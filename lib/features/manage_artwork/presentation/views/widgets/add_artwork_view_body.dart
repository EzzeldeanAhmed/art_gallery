import 'dart:io';

import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/widgets/custom_button.dart';
import 'package:art_gallery/core/widgets/custom_text_field.dart';
import 'package:art_gallery/features/manage_artwork/presentation/views/manger/add_artwork/cubit/add_artwork_cubit.dart';
import 'package:art_gallery/features/manage_artwork/presentation/views/widgets/image_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddArtworkViewBody extends StatefulWidget {
  const AddArtworkViewBody({super.key});

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

class _AddArtworkViewBodyState extends State<AddArtworkViewBody> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String code,
      name,
      type,
      medium,
      country,
      description,
      epoch,
      artist,
      dimensions;
  late num year;
  File? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text('Welcome Admin, Fill the data to add artwork',
                  style: TextStyle(fontSize: 18, color: Colors.black)),
              const SizedBox(height: 20),

              CustomTextFormField(
                  onSaved: (value) {
                    code = value!.toLowerCase();
                  },
                  hintText: 'Artwork Code',
                  textInputType: TextInputType.text),
              const SizedBox(height: 8),
              CustomTextFormField(
                  onSaved: (value) {
                    name = value!;
                  },
                  hintText: 'Artwork Name',
                  textInputType: TextInputType.text),
              const SizedBox(height: 8),

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
                onChanged: (value) {
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
              CustomTextFormField(
                  onSaved: (value) {
                    year = num.parse(value!);
                  },
                  hintText: 'Year Made',
                  textInputType: TextInputType.number),
              const SizedBox(height: 8),
              CustomTextFormField(
                  onSaved: (value) {
                    epoch = value!;
                  },
                  hintText: 'Epoch',
                  textInputType: TextInputType.text),
              const SizedBox(height: 8),
              CustomTextFormField(
                  onSaved: (value) {
                    dimensions = value!;
                  },
                  hintText: 'Dimensions',
                  textInputType: TextInputType.text),
              const SizedBox(height: 8),
              CustomTextFormField(
                  onSaved: (value) {
                    medium = value!;
                  },
                  hintText: 'Medium',
                  textInputType: TextInputType.text),
              const SizedBox(height: 8),
              CustomTextFormField(
                  onSaved: (value) {
                    artist = value!;
                  },
                  hintText: 'Artist',
                  textInputType: TextInputType.text),
              const SizedBox(height: 8),
              CustomTextFormField(
                  onSaved: (value) {
                    country = value!;
                  },
                  hintText: 'Country ',
                  textInputType: TextInputType.text),
              const SizedBox(height: 8),
              CustomTextFormField(
                onSaved: (value) {
                  description = value!;
                },
                hintText: 'Artwork Description',
                textInputType: TextInputType.text,
                maxLines: 5,
              ),
              const SizedBox(height: 12),
//

              ImageField(
                onFileChanged: (image) {
                  this.image = image;
                },
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
                      context.read<AddArtworkCubit>().addArtwork(input);
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  } else {
                    showError(context);
                  }
                },
                text: 'Add Artwork',
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