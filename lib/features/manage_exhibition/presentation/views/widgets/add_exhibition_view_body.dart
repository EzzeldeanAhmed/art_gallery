import 'dart:io';

import 'package:art_gallery/core/artwork_cubit/artworks_cubit.dart';
import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/models/exhibition_entity.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/core/widgets/custom_button.dart';
import 'package:art_gallery/core/widgets/custom_text_field.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/manger/add_artist/cubit/add_artist_cubit.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/widgets/image_field.dart';
import 'package:art_gallery/features/manage_exhibition/presentation/views/manger/add_artist/cubit/add_exhibition_cubit.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExhibitionViewBody extends StatefulWidget {
  AddExhibitionViewBody(
      {super.key, this.update, this.defaultEntity, this.delete});
  final bool? update;
  final bool? delete;
  final ExhibitionEntity? defaultEntity;
  List<ArtworkEntity> artworks = [];
  @override
  State<AddExhibitionViewBody> createState() => _AddExhibitionViewBodyState();
}

String? selectedValue;

class _AddExhibitionViewBodyState extends State<AddExhibitionViewBody> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String name = widget.update! ? widget.defaultEntity!.name : "",
      overview = widget.update! ? widget.defaultEntity!.overview : "",
      location = widget.update! ? widget.defaultEntity!.location : "",
      museumName = widget.update! ? widget.defaultEntity!.museumName : "";
  late File? image = widget.update! ? File("") : null;
  late DateTime startDate =
          widget.update! ? widget.defaultEntity!.startDate : DateTime.now(),
      endDate = widget.update! ? widget.defaultEntity!.endDate : DateTime.now();
  late List<dynamic> currentArtworks =
      widget.update! ? widget.defaultEntity!.artworks : [];

  late double ticketPrice =
      widget.update! ? widget.defaultEntity!.ticketPrice : 0;
  late int capacity = widget.update! ? widget.defaultEntity!.capacity : 0;

  late final strartDateController = TextEditingController(
      text: widget.update!
          ? widget.defaultEntity!.startDate.toString().split(' ')[0]
          : "");

  late final startTimeController = TextEditingController(
      text: widget.update!
          ? widget.defaultEntity!.startDate.toString().split(' ')[1]
          : "");

  late final endDateController = TextEditingController(
      text: widget.update!
          ? widget.defaultEntity!.endDate.toString().split(' ')[0]
          : "");

  late final endTimeController = TextEditingController(
      text: widget.update!
          ? widget.defaultEntity!.endDate.toString().split(' ')[1]
          : "");

  Map<String, bool> artworkSelected = {};
  @override
  void initState() {
    context.read<ArtworksCubit>().getArtworks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtworksCubit, ArtworksState>(builder: (context, state) {
      if (state is ArtworksSuccess) {
        var sortedArtworks = state.artworks;
        sortedArtworks.sort((a, b) => a.name.compareTo(b.name));
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              autovalidateMode: autovalidateMode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                        'Welcome Admin, Fill the data to ${widget.update! ? "update" : "add"} Exhibition',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1F5E3B))),
                  ),
                  const SizedBox(height: 20),
                  Text('Name:', style: TextStyles.semiBold16),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                      enabled: !widget.delete!,
                      initialValue: name,
                      onSaved: (value) {
                        name = value!;
                      },
                      hintText: 'Enter Exhibition Name',
                      textInputType: TextInputType.text),

                  // CustomTextFormField(
                  //     enabled: !widget.delete!,
                  //     initialValue: epoch,
                  //     onSaved: (value) {
                  //       epoch = value!;
                  //     },
                  //     hintText: 'Epoch',
                  //     textInputType: TextInputType.text),
                  const SizedBox(height: 8),
                  Text('Start Date:', style: TextStyles.semiBold16),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    controller: strartDateController,
                    readOnly: true,
                    onTap: () async {
                      final dt = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 20),
                        initialDate: DateTime.now(),
                      );
                      if (dt != null) {
                        strartDateController.text =
                            dt.toIso8601String().split('T')[0];
                        startDate = DateTime(
                          dt.year,
                          dt.month,
                          dt.day,
                          startDate.hour,
                          startDate.minute,
                        );
                      }
                    },
                    hintText: 'Enter Exhibition Start Date',
                    textInputType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter valid Start Date';
                      }
                      return null;
                    },
                    enabled: !widget.delete!,
                  ),
                  const SizedBox(height: 8),
                  Text('Start Time:', style: TextStyles.semiBold16),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: startTimeController,
                    readOnly: true,
                    onTap: () async {
                      final dt = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (dt != null) {
                        startTimeController.text = dt.format(context);
                        startDate = DateTime(
                          startDate.year,
                          startDate.month,
                          startDate.day,
                          dt.hour,
                          dt.minute,
                        );
                      }
                    },
                    hintText: 'Enter Exhibition Start Time',
                    textInputType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter valid Start Time';
                      }
                      return null;
                    },
                    enabled: !widget.delete!,
                  ),
                  // CustomTextFormField(
                  //     enabled: !widget.delete!,
                  //     initialValue: BirthDate,
                  //     onSaved: (value) {
                  //       BirthDate = value!;
                  //     },
                  //     hintText: 'Birthdate',
                  //     textInputType: TextInputType.text),
                  const SizedBox(height: 8),
                  Text('End Date:', style: TextStyles.semiBold16),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    controller: endDateController,
                    readOnly: true,
                    onTap: () async {
                      final dt = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 20),
                        initialDate: DateTime.now(),
                      );
                      if (dt != null) {
                        endDateController.text =
                            dt.toIso8601String().split('T')[0];
                        endDate = dt;
                      }
                    },
                    hintText: 'Enter Exhibition End Date',
                    textInputType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter valid End Date';
                      }
                      return null;
                    },
                    enabled: !widget.delete!,
                  ),
                  const SizedBox(height: 8),
                  Text('End Time:', style: TextStyles.semiBold16),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: endTimeController,
                    readOnly: true,
                    onTap: () async {
                      final dt = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (dt != null) {
                        endTimeController.text = dt.format(context);
                        endDate = DateTime(
                          endDate.year,
                          endDate.month,
                          endDate.day,
                          dt.hour,
                          dt.minute,
                        );
                      }
                    },
                    hintText: 'Enter Exhibition End Time',
                    textInputType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter valid End Time';
                      }
                      return null;
                    },
                    enabled: !widget.delete!,
                  ),
                  const SizedBox(height: 8),
                  Text('Location:', style: TextStyles.semiBold16),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                      enabled: !widget.delete!,
                      initialValue: location,
                      onSaved: (value) {
                        location = value!;
                      },
                      hintText: 'Location',
                      textInputType: TextInputType.text),
                  const SizedBox(height: 8),
                  Text('Musuem Name:', style: TextStyles.semiBold16),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                      enabled: !widget.delete!,
                      initialValue: museumName,
                      onSaved: (value) {
                        museumName = value!;
                      },
                      hintText: 'Musuem Name',
                      textInputType: TextInputType.text),
                  const SizedBox(height: 8),
                  Text('Ticket Price:', style: TextStyles.semiBold16),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                      enabled: !widget.delete!,
                      initialValue: ticketPrice.toString(),
                      onSaved: (value) {
                        ticketPrice = double.parse(value!);
                      },
                      hintText: 'Ticket Price',
                      textInputType: TextInputType.number),
                  const SizedBox(height: 8),
                  Text('Capacity:', style: TextStyles.semiBold16),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                      enabled: !widget.delete!,
                      initialValue: capacity.toString(),
                      onSaved: (value) {
                        capacity = int.parse(value!);
                      },
                      hintText: 'Capacity',
                      textInputType: TextInputType.number),
                  const SizedBox(height: 8),
                  Text('Overview:', style: TextStyles.semiBold16),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    enabled: !widget.delete!,
                    initialValue: overview,
                    onSaved: (value) {
                      overview = value!;
                    },
                    hintText: 'Enter Exhibition Overview',
                    textInputType: TextInputType.text,
                    maxLines: 5,
                  ),
//
                  const SizedBox(height: 20),
//
                  Text('Upload Exhibition image:',
                      style: TextStyles.semiBold16),
                  const SizedBox(height: 5),
                  ImageField(
                    onFileChanged: (image) {
                      this.image = image;
                    },
                    delete: widget.delete!,
                    imageUrl:
                        widget.update! ? widget.defaultEntity!.imageUrl : "",
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                      onPressed: () {
                        _showBottomSheet(
                            sortedArtworks, currentArtworks, artworkSelected);
                      },
                      text: 'Select Artworks'),
                  const SizedBox(height: 24),
                  CustomButton(
                    onPressed: () {
                      if (image != null) {
                        if (_formkey.currentState!.validate() &&
                            startDate.isBefore(endDate)) {
                          _formkey.currentState!.save();
                          ExhibitionEntity input = ExhibitionEntity(
                            name: name,
                            overview: overview,
                            location: location,
                            museumName: museumName,
                            startDate: startDate,
                            endDate: endDate,
                            imageUrl: "",
                            artworks: currentArtworks,
                            image: image!,
                            ticketPrice: ticketPrice,
                            capacity: capacity,
                          );
                          if (widget.delete!) {
                            context
                                .read<AddExhibitionCubit>()
                                .deleteExhibition(widget.defaultEntity!.id!);
                          } else if (widget.update!) {
                            input.id = widget.defaultEntity!.id;
                            if (image?.path == "") {
                              input.imageUrl = widget.defaultEntity!.imageUrl;
                            }
                            context
                                .read<AddExhibitionCubit>()
                                .updateExhibition(input);
                          } else {
                            context
                                .read<AddExhibitionCubit>()
                                .addExhibition(input);
                          }
                        } else if (startDate.isAfter(endDate)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Start Date should be before End Date')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please fill all fields')));
                          autovalidateMode = AutovalidateMode.always;
                          setState(() {});
                        }
                      } else {
                        showError(context);
                      }
                    },
                    text:
                        '${widget.delete! ? "Delete" : widget.update! ? "Update" : "Add"} Exhibition',
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }

  void showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please select an image'),
      ),
    );
  }

  void _showBottomSheet(List<ArtworkEntity> artworks,
      List<dynamic> currentArtworks, Map<String, bool> artworkSelected) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return FractionallySizedBox(
            heightFactor: 0.8, // Makes it not full screen
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    title:
                        Text("Artworks", style: TextStyle(color: Colors.black)),
                    actions: [
                      TextButton(
                        onPressed: _clearAll,
                        child: Text("Clear All",
                            style: TextStyle(color: Colors.blue)),
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: artworks.map((artwork) {
                        artworkSelected[artwork.id!] =
                            currentArtworks.contains(artwork.id);
                        return CheckboxListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: 150,
                                  child: Text(
                                      artwork.name.length > 18
                                          ? artwork.name.substring(0, 18) +
                                              "..."
                                          : artwork.name,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16))),
                              Row(
                                children: [
                                  Text("(${artwork.type})",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                  SizedBox(width: 10),
                                  Image.network(artwork.imageUrl!,
                                      width: 50,
                                      height: 80,
                                      fit: BoxFit.fitWidth),
                                ],
                              )
                            ],
                          ),
                          value: artworkSelected[artwork.id] ?? false,
                          onChanged: (bool? value) {
                            setState(() {
                              if (value!) {
                                currentArtworks.add(artwork.id);
                                artworkSelected[artwork.id!] = true;
                              } else {
                                currentArtworks.remove(artwork.id);
                                artworkSelected[artwork.id!] = false;
                              }
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text("Done",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void _clearAll() {
    setState(() {
      // artworkSelected.updateAll((key, value) => false);
      // currentArtworks.clear();
    });
  }
}
/*CustomTextFormField(
                  onSaved: (value) {
                    type = value!;
                  },
                  hintText: 'Exhibition Type',
                  textInputType: TextInputType.text,
                  ),*/