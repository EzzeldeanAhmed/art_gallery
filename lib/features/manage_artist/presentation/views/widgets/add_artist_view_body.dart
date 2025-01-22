import 'dart:io';

import 'package:art_gallery/core/models/artist_entity.dart';
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
String? selectedValue;

class _AddArtistViewBodyState extends State<AddArtistViewBody> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String name = widget.update! ? widget.defaultEntity!.name : "",
      BirthDate = widget.update! ? widget.defaultEntity!.BirthDate : "",
      DeathDate = widget.update! ? widget.defaultEntity!.DeathDate : "",
      country = widget.update! ? widget.defaultEntity!.country : "",
      century = widget.update! ? widget.defaultEntity!.century : "",
      epoch = widget.update! ? widget.defaultEntity!.epoch : "",
      biography = widget.update! ? widget.defaultEntity!.biography : "";
  late File? image = widget.update! ? File("") : null;
  final birthDateController = TextEditingController();
  final countryController = TextEditingController();
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
                  'Welcome Admin, Fill the data to ${widget.update! ? "update" : "add"} artist',
                  style: const TextStyle(fontSize: 18, color: Colors.black)),
              const SizedBox(height: 20),

              CustomTextFormField(
                  enabled: !widget.delete!,
                  initialValue: name,
                  onSaved: (value) {
                    name = value!;
                  },
                  hintText: 'Artist Name',
                  textInputType: TextInputType.text),

              const SizedBox(height: 8),

              CustomTextFormField(
                  enabled: !widget.delete!,
                  initialValue: epoch,
                  onSaved: (value) {
                    epoch = value!;
                  },
                  hintText: 'Epoch',
                  textInputType: TextInputType.text),
              const SizedBox(height: 8),
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
                hintText: 'Birth Date',
                textInputType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter valid Birth Date';
                  }
                  return null;
                },
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
              CustomTextFormField(
                  enabled: !widget.delete!,
                  initialValue: DeathDate,
                  onSaved: (value) {
                    DeathDate = value!;
                  },
                  hintText: 'DeathDate',
                  textInputType: TextInputType.text),
              const SizedBox(height: 8),
              CustomTextFormField(
                  enabled: !widget.delete!,
                  initialValue: century,
                  onSaved: (value) {
                    century = value!;
                  },
                  hintText: 'Century',
                  textInputType: TextInputType.text),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: countryController,
                hintText: "Nationality",
                textInputType: TextInputType.text,
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
              CustomTextFormField(
                enabled: !widget.delete!,
                initialValue: biography,
                onSaved: (value) {
                  biography = value!;
                },
                hintText: 'Artist Biography',
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