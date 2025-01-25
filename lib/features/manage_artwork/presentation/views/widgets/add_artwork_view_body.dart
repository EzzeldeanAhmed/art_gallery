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

class _AddArtworkViewBodyState extends State<AddArtworkViewBody> {
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
  late num year = widget.update! ? widget.defaultEntity!.year : -1;
  late File? image = widget.update! ? File("") : null;

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
              Text(
                  'Welcome Admin, Fill the data to ${widget.update! ? "update" : "add"} artwork',
                  style: const TextStyle(fontSize: 18, color: Colors.black)),
              const SizedBox(height: 20),

              CustomTextFormField(
                  enabled: !widget.delete!,
                  initialValue: code,
                  onSaved: (value) {
                    code = value!.toLowerCase();
                  },
                  hintText: 'Artwork Code',
                  textInputType: TextInputType.text),
              const SizedBox(height: 8),
              CustomTextFormField(
                  enabled: !widget.delete!,
                  initialValue: name,
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
              CustomTextFormField(
                  enabled: !widget.delete!,
                  initialValue: year != -1 ? year.toString() : "",
                  onSaved: (value) {
                    year = num.parse(value!);
                  },
                  hintText: 'Year Made',
                  textInputType: TextInputType.number),
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
              CustomTextFormField(
                  enabled: !widget.delete!,
                  initialValue: dimensions,
                  onSaved: (value) {
                    dimensions = value!;
                  },
                  hintText: 'Dimensions',
                  textInputType: TextInputType.text),
              const SizedBox(height: 8),
              CustomTextFormField(
                  enabled: !widget.delete!,
                  initialValue: medium,
                  onSaved: (value) {
                    medium = value!;
                  },
                  hintText: 'Medium',
                  textInputType: TextInputType.text),
              const SizedBox(height: 8),
              CustomTextFormField(
                  enabled: !widget.delete!,
                  initialValue: artist,
                  onSaved: (value) {
                    artist = value!;
                  },
                  hintText: 'Artist',
                  textInputType: TextInputType.text),
              const SizedBox(height: 8),
              CustomTextFormField(
                  enabled: !widget.delete!,
                  initialValue: country,
                  onSaved: (value) {
                    country = value!;
                  },
                  hintText: 'Country ',
                  textInputType: TextInputType.text),
              const SizedBox(height: 8),
              CustomTextFormField(
                enabled: !widget.delete!,
                initialValue: description,
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