import 'dart:io';

import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/core/widgets/custom_button.dart';
import 'package:art_gallery/core/widgets/custom_text_field.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/manger/add_artist/cubit/add_artist_cubit.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/widgets/image_field.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddArtistViewBody extends StatefulWidget {
  const AddArtistViewBody(
      {super.key, this.update, this.defaultEntity, this.delete});
  final bool? update;
  final bool? delete;
  final ArtistEntity? defaultEntity;
  @override
  State<AddArtistViewBody> createState() => _AddArtistViewBodyState();
}

List<String> typeItems = [
  'Sculpture',
  'Drawings',
  'Paintings',
  'Black and White',
  'Mosaic'
];
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
String? selectedValue;

class _AddArtistViewBodyState extends State<AddArtistViewBody> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String name = widget.update! ? widget.defaultEntity!.name : "",
      BirthDate = widget.update! ? widget.defaultEntity!.BirthDate : "",
      DeathDate = widget.update! ? widget.defaultEntity!.DeathDate : "",
      country = widget.update! ? widget.defaultEntity!.country : "",
      century = widget.update! ? widget.defaultEntity!.century : "",
      epoch = widget.update!
          ? (epochItems.contains(widget.defaultEntity!.epoch)
              ? widget.defaultEntity!.epoch
              : "")
          : "",
      //epoch = widget.update! ? widget.defaultEntity!.epoch : "",
      biography = widget.update! ? widget.defaultEntity!.biography : "";
  late File? image = widget.update! ? File("") : null;
  late final birthDateController = TextEditingController(
      text: widget.update! ? widget.defaultEntity!.BirthDate : "");

  late final deathDateController = TextEditingController(
      text: widget.update! ? widget.defaultEntity!.DeathDate : "");
  late final countryController = TextEditingController(
      text: widget.update! ? widget.defaultEntity!.country : "");
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
                    'Welcome Admin, Fill the data to ${widget.update! ? "update" : "add"} artist',
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
                  hintText: 'Enter Artist Name',
                  textInputType: TextInputType.text),

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
                  'Select epoch of Artist',
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
              Text('Birth Date:', style: TextStyles.semiBold16),
              const SizedBox(height: 5),
              CustomTextFormField(
                controller: birthDateController,
                readOnly: true,
                onTap: () async {
                  final dt = await showDatePicker(
                    context: context,
                    firstDate: DateTime(0),
                    lastDate: DateTime(DateTime.now().year - 20),
                  );
                  if (dt != null) {
                    birthDateController.text =
                        BirthDate = dt.toIso8601String().split('T')[0];
                  }
                },
                hintText: 'Enter Artist Birth Date',
                textInputType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter valid Birth Date';
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
              Text('Death Date: (if died)', style: TextStyles.semiBold16),
              const SizedBox(height: 5),
              CustomTextFormField(
                controller: deathDateController,
                readOnly: true,
                onTap: () async {
                  final dt = await showDatePicker(
                    context: context,
                    firstDate: DateTime(0),
                    lastDate: DateTime(DateTime.now().year - 5),
                  );
                  if (dt != null) {
                    deathDateController.text =
                        DeathDate = dt.toIso8601String().split('T')[0];
                  }
                },
                hintText: 'Enter Death Date',
                textInputType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter valid Death Date';
                  }
                  return null;
                },
                enabled: !widget.delete!,
              ),
              const SizedBox(height: 8),
              Text('Century:', style: TextStyles.semiBold16),
              const SizedBox(height: 5),
              CustomTextFormField(
                  enabled: !widget.delete!,
                  initialValue: century,
                  onSaved: (value) {
                    century = value!;
                  },
                  hintText: 'Century',
                  textInputType: TextInputType.text),
              const SizedBox(height: 8),
              Text('Nationality:', style: TextStyles.semiBold16),
              const SizedBox(height: 5),
              CustomTextFormField(
                controller: countryController,
                hintText: " Choose Nationality of Artist",
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
              //     hintText: 'Nationality ',
              //     textInputType: TextInputType.text),
              const SizedBox(height: 8),
              Text('Biography:', style: TextStyles.semiBold16),
              const SizedBox(height: 5),
              CustomTextFormField(
                enabled: !widget.delete!,
                initialValue: biography,
                onSaved: (value) {
                  biography = value!;
                },
                hintText: 'Enter Artist Biography',
                textInputType: TextInputType.text,
                maxLines: 5,
              ),
//
              const SizedBox(height: 20),
//
              Text('Upload Artist image:', style: TextStyles.semiBold16),
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
                      ArtistEntity input = ArtistEntity(
                        reviews: [],
                        name: name,
                        BirthDate: BirthDate,
                        DeathDate: DeathDate,
                        country: country,
                        century: century,
                        epoch: epoch,
                        biography: biography,
                        image: image!,
                      );
                      if (widget.delete!) {
                        context
                            .read<AddArtistCubit>()
                            .deleteArtist(widget.defaultEntity!.id!);
                      } else if (widget.update!) {
                        input.id = widget.defaultEntity!.id;
                        if (image?.path == "") {
                          input.imageUrl = widget.defaultEntity!.imageUrl;
                        }
                        context.read<AddArtistCubit>().updateArtist(input);
                      } else {
                        context.read<AddArtistCubit>().addArtist(input);
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
                    '${widget.delete! ? "Delete" : widget.update! ? "Update" : "Add"} Artist',
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
                  hintText: 'Artist Type',
                  textInputType: TextInputType.text,
                  ),*/