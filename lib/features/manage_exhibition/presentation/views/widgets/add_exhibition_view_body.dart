import 'dart:io';

import 'package:art_gallery/core/models/artist_entity.dart';
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
  const AddExhibitionViewBody(
      {super.key, this.update, this.defaultEntity, this.delete});
  final bool? update;
  final bool? delete;
  final ExhibitionEntity? defaultEntity;
  @override
  State<AddExhibitionViewBody> createState() => _AddExhibitionViewBodyState();
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

  late final strartDateController = TextEditingController(
      text: widget.update! ? widget.defaultEntity!.startDate.toString() : "");

  late final endDateController = TextEditingController(
      text: widget.update! ? widget.defaultEntity!.endDate.toString() : "");

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
                    firstDate: DateTime(0),
                    lastDate: DateTime(DateTime.now().year - 20),
                  );
                  if (dt != null) {
                    strartDateController.text =
                        dt.toIso8601String().split('T')[0];
                    startDate = dt;
                  }
                },
                hintText: 'Enter Exhibition Birth Date',
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
                controller: endDateController,
                readOnly: true,
                onTap: () async {
                  final dt = await showDatePicker(
                    context: context,
                    firstDate: DateTime(0),
                    lastDate: DateTime(DateTime.now().year - 20),
                  );
                  if (dt != null) {
                    endDateController.text = dt.toIso8601String().split('T')[0];
                    endDate = dt;
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
              // CustomTextFormField(
              //     enabled: !widget.delete!,
              //     initialValue: country,
              //     onSaved: (value) {
              //       country = value!;
              //     },
              //     hintText: 'Nationality ',
              //     textInputType: TextInputType.text),
              const SizedBox(height: 8),
              Text('Overview:', style: TextStyles.semiBold16),
              const SizedBox(height: 5),
              CustomTextFormField(
                enabled: !widget.delete!,
                initialValue: overview,
                onSaved: (value) {
                  overview = value!;
                },
                hintText: 'Enter Exhibition Biography',
                textInputType: TextInputType.text,
                maxLines: 5,
              ),
//
              const SizedBox(height: 20),
//
              Text('Upload Exhibition image:', style: TextStyles.semiBold16),
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
                      ExhibitionEntity input = ExhibitionEntity(
                        name: name,
                        overview: overview,
                        location: location,
                        museumName: museumName,
                        startDate: startDate,
                        endDate: endDate,
                        imageUrl: "",
                        artworks: [],
                        image: image!,
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
                        context.read<AddExhibitionCubit>().addExhibition(input);
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
                    '${widget.delete! ? "Delete" : widget.update! ? "Update" : "Add"} Exhibition',
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
                  hintText: 'Exhibition Type',
                  textInputType: TextInputType.text,
                  ),*/