import 'dart:io';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';

import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/widgets/custom_button.dart';
import 'package:art_gallery/core/widgets/custom_text_field.dart';
import 'package:art_gallery/features/manage_artwork/presentation/views/manger/add_artwork/cubit/add_artwork_cubit.dart';
import 'package:art_gallery/features/manage_artwork/presentation/views/widgets/image_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddArtworkViewBody extends StatefulWidget {
  const AddArtworkViewBody(
      {super.key, this.update, this.defaultEntity, this.delete});
  final bool? update;
  final bool? delete;
  final ArtworkEntity? defaultEntity;
  @override
  State<AddArtworkViewBody> createState() => _AddArtworkViewBodyState();
}

List<String> typeItems = [
  'Sculpture',
  'Drawings',
  'Paintings',
  'Black and White',
  'Mosaic'
];
String? selectedValue;

List<String> epochItems = [
  'Prehistoric Art',
  'Ancient Art',
  'Classical Art',
  'Byzantine Art',
  'Romanesque Art',
  'Renaissance Art',
  'Neoclassical Art',
  'Romanticism',
  'Impressionism',
  'Modernism',
  'Contemporary Art',
  'Realism',
  'Expressionism',
  'Ancient Roman Art',
  'Rococo Art',
  'Baroque Art'
];
List<String> artists = [];

class _AddArtworkViewBodyState extends State<AddArtworkViewBody> {
  Future<List<String>> getArtistNames() async {
    try {
      // Replace 'your-collection-name' with the name of your collection
      if (artists.isNotEmpty) {
        // return artists;
      }
      final querySnapshot =
          await FirebaseFirestore.instance.collection('artists').get();

      // Extract document IDs
      final artistNames =
          querySnapshot.docs.map((doc) => doc.get("name").toString()).toList();
      artists = artistNames;
      return artistNames;
    } catch (e) {
      print('Error fetching artist names: $e');
      return [];
    }
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String code = widget.update! ? widget.defaultEntity!.code : "",
      name = widget.update! ? widget.defaultEntity!.name : "",
      type = widget.update! ? widget.defaultEntity!.type : "",
      medium = widget.update! ? widget.defaultEntity!.medium : "",
      country = widget.update! ? widget.defaultEntity!.country : "",
      description = widget.update! ? widget.defaultEntity!.description : "",
      epoch = widget.update!
          ? (epochItems.contains(widget.defaultEntity!.epoch)
              ? widget.defaultEntity!.epoch
              : "")
          : "",
      artist = widget.update! ? widget.defaultEntity!.artist : "",
      dimensions = widget.update! ? widget.defaultEntity!.dimensions : "";
  late final countryController = TextEditingController(
      text: widget.update! ? widget.defaultEntity!.country : "");
  late final yearController = TextEditingController(
      text: widget.update! ? widget.defaultEntity!.year.toString() : "");
  late num year = widget.update! ? widget.defaultEntity!.year : -1;
  late File? image = widget.update! ? File("") : null;
  late DateTime _selectedDate = DateTime(year.toInt());

  @override
  Widget build(BuildContext context) {
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
                      'Welcome Admin, Fill the data to ${widget.update! ? "update" : "add"} artwork',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1F5E3B)))),
              const SizedBox(height: 20),

              Text('Code:', style: TextStyles.semiBold16),
              const SizedBox(height: 5),

              CustomTextFormField(
                  enabled: !widget.delete!,
                  initialValue: code,
                  onSaved: (value) {
                    code = value!.toLowerCase();
                  },
                  hintText: 'Artwork Code',
                  textInputType: TextInputType.text),
              const SizedBox(height: 8),
              Text('Name:', style: TextStyles.semiBold16),
              const SizedBox(height: 5),
              CustomTextFormField(
                  enabled: !widget.delete!,
                  initialValue: name,
                  onSaved: (value) {
                    name = value!;
                  },
                  hintText: 'Artwork Name',
                  textInputType: TextInputType.text),
              const SizedBox(height: 8),
              Text('Type:', style: TextStyles.semiBold16),
              const SizedBox(height: 5),

              DropdownButtonFormField2<String>(
                //isExpanded: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF9FAFA),
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                value: type != "" ? type : null,
                hint: const Text(
                  'Select Type of Artwork',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0XFF949D9E),
                  ),
                ),
                items: typeItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a type.';
                  }
                  return null;
                },
                onChanged: widget.delete!
                    ? null
                    : (value) {
                        setState(() {
                          type = value!;
                        });
                      },
                onSaved: (value) {},
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 8),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.blue,
                  ),
                  iconSize: 30,
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 8),
              Text('Year:', style: TextStyles.semiBold16),
              const SizedBox(height: 5),
              CustomTextFormField(
                  controller: yearController,
                  hintText: "Determine Year of the artwork",
                  textInputType: TextInputType.datetime,
                  readOnly: true,
                  // onChanged: (value) {
                  //   _selectedDate = DateTime(int.parse(value!));
                  // },
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text("Select Year"),
                            content: Container(
                                width: 400,
                                height: 600,
                                child: YearPicker(
                                  firstDate:
                                      DateTime(DateTime.now().year - 600, 1),
                                  lastDate:
                                      DateTime(DateTime.now().year - 10, 1),
                                  selectedDate: _selectedDate,
                                  onChanged: (DateTime dateTime) {
                                    Navigator.pop(context);
                                    _selectedDate = dateTime;
                                    year = _selectedDate.year;
                                    yearController.text = year.toString();
                                  },
                                )));
                      })),
              // CustomTextFormField(
              //     enabled: !widget.delete!,
              //     initialValue: year != -1 ? year.toString() : "",
              //     onSaved: (value) {
              //       year = num.parse(value!);
              //     },
              //     hintText: 'Year Made',
              //     textInputType: TextInputType.number),
              const SizedBox(height: 8),
              Text('Epoch:', style: TextStyles.semiBold16),
              const SizedBox(height: 5),
              DropdownButtonFormField2<String>(
                //isExpanded: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF9FAFA),
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                value: epoch != "" ? epoch : null,
                hint: const Text(
                  'Select epoch of Artwork',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0XFF949D9E),
                  ),
                ),
                items: epochItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a epoch.';
                  }
                  return null;
                },
                onChanged: widget.delete!
                    ? null
                    : (value) {
                        setState(() {
                          epoch = value!;
                        });
                      },
                onSaved: (value) {},
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 8),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.blue,
                  ),
                  iconSize: 30,
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),

              // CustomTextFormField(
              //     enabled: !widget.delete!,
              //     initialValue: epoch,
              //     onSaved: (value) {
              //       epoch = value!;
              //     },
              //     hintText: 'Epoch',
              //     textInputType: TextInputType.text),
              const SizedBox(height: 8),
              Text('Dimensions:', style: TextStyles.semiBold16),
              const SizedBox(height: 5),
              CustomTextFormField(
                  enabled: !widget.delete!,
                  initialValue: dimensions,
                  onSaved: (value) {
                    dimensions = value!;
                  },
                  hintText: 'Enter artwork Dimensions',
                  textInputType: TextInputType.text),
              const SizedBox(height: 8),
              Text('Medium:', style: TextStyles.semiBold16),
              const SizedBox(height: 5),
              CustomTextFormField(
                  enabled: !widget.delete!,
                  initialValue: medium,
                  onSaved: (value) {
                    medium = value!;
                  },
                  hintText: 'Enter artwork Medium',
                  textInputType: TextInputType.text),
              const SizedBox(height: 8),
              Text('Artist:', style: TextStyles.semiBold16),
              const SizedBox(height: 5),
              FutureBuilder<List<String>>(
                  future: getArtistNames(),
                  builder: (context, snapshot) {
                    // ignore: unrelated_type_equality_checks
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        artist != []) {
                      return CustomTextFormField(
                          hintText: "Loading",
                          textInputType: TextInputType.text,
                          enabled: false);
                    } else if (snapshot.hasError && artist != []) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if ((!snapshot.hasData || snapshot.data!.isEmpty) &&
                        artist != []) {
                      return Center(child: Text('No documents found.'));
                    } else {
                      return DropdownButtonFormField2<String>(
                        //isExpanded: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF9FAFA),
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        value: artist != "" && artists.contains(artist)
                            ? artist
                            : null,
                        hint: const Text(
                          'Select artist of Artwork',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0XFF949D9E),
                          ),
                        ),
                        items: snapshot.data!
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a artist.';
                          }
                          return null;
                        },
                        onChanged: widget.delete!
                            ? null
                            : (value) {
                                setState(() {
                                  artist = value!;
                                });
                              },
                        onSaved: (value) {},
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.blue,
                          ),
                          iconSize: 30,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      );

                      // CustomTextFormField(
                      //     enabled: !widget.delete!,
                      //     initialValue: artist,
                      //     onSaved: (value) {
                      //       artist = value!;
                      //     },
                      //     hintText: 'Artist',
                      //     textInputType: TextInputType.text);
                    }
                  }),
              const SizedBox(height: 8),
              Text('Country:', style: TextStyles.semiBold16),
              const SizedBox(height: 5),
              CustomTextFormField(
                controller: countryController,
                hintText: "Pick up a Country",
                textInputType: TextInputType.text,
                enabled: !widget.delete!,
                onTap: () {
                  showCountryPicker(
                      context: context,
                      onSelect: (Country c) {
                        countryController.text = country = c.name;
                      },
                      exclude: ['IL']);
                },
                readOnly: true,
              ),
              // CustomTextFormField(
              //     enabled: !widget.delete!,
              //     initialValue: country,
              //     onSaved: (value) {
              //       country = value!;
              //     },
              //     hintText: 'Country ',
              //     textInputType: TextInputType.text),
              const SizedBox(height: 8),
              Text('Description:', style: TextStyles.semiBold16),
              const SizedBox(height: 5),
              CustomTextFormField(
                enabled: !widget.delete!,
                initialValue: description,
                onSaved: (value) {
                  description = value!;
                },
                hintText: 'Enter Artwork Description',
                textInputType: TextInputType.text,
                maxLines: 5,
              ),
              const SizedBox(height: 20),
//
              Text('Upload Artwork image:', style: TextStyles.semiBold16),
              const SizedBox(height: 5),

              ImageField(
                onFileChanged: (image) {
                  this.image = image;
                },
                delete: widget.delete!,
                imageUrl: widget.update! ? widget.defaultEntity!.imageUrl : "",
              ),
              const SizedBox(height: 24),
              CustomButton(
                onPressed: () {
                  if (image != null) {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      ArtworkEntity input = ArtworkEntity(
                        reviews: [],
                        code: code,
                        name: name,
                        type: type,
                        medium: medium,
                        country: country,
                        description: description,
                        epoch: epoch,
                        artist: artist,
                        year: year,
                        dimensions: dimensions,
                        image: image!,
                      );
                      if (widget.delete!) {
                        context
                            .read<AddArtworkCubit>()
                            .deleteArtwork(widget.defaultEntity!.id!);
                      } else if (widget.update!) {
                        input.id = widget.defaultEntity!.id;
                        if (image?.path == "") {
                          input.imageUrl = widget.defaultEntity!.imageUrl;
                        }
                        context.read<AddArtworkCubit>().updateArtwork(input);
                      } else {
                        context.read<AddArtworkCubit>().addArtwork(input);
                      }
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  } else {
                    showError(context);
                  }
                },
                text:
                    '${widget.delete! ? "Delete" : widget.update! ? "Update" : "Add"} Artwork',
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please select an image'),
      ),
    );
  }
}
/*CustomTextFormField(
                  onSaved: (value) {
                    type = value!;
                  },
                  hintText: 'Artwork Type',
                  textInputType: TextInputType.text,
                  ),*/