import 'package:art_gallery/core/models/collection_entity.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/core/widgets/custom_button.dart';
import 'package:art_gallery/core/widgets/custom_text_field.dart';
import 'package:art_gallery/features/manage_collection/presentation/views/manger/add_collection/cubit/add_collection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCollectionViewBody extends StatefulWidget {
  const AddCollectionViewBody(
      {super.key, this.update, this.defaultEntity, this.delete});
  final bool? update;
  final bool? delete;
  final CollectionEntity? defaultEntity;
  @override
  State<AddCollectionViewBody> createState() => _AddCollectionViewBodyState();
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

class _AddCollectionViewBodyState extends State<AddCollectionViewBody> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String name = widget.update! ? widget.defaultEntity!.name : "",
      overview = widget.update! ? widget.defaultEntity!.overview : "";

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
                    'Welcome Admin, Fill the data to ${widget.update! ? "update" : "add"} collection',
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
                  hintText: 'Enter Collection Name',
                  textInputType: TextInputType.text),

              const SizedBox(height: 8),
              Text('Overview:', style: TextStyles.semiBold16),
              const SizedBox(height: 5),
              CustomTextFormField(
                enabled: !widget.delete!,
                initialValue: overview,
                onSaved: (value) {
                  overview = value!;
                },
                hintText: 'Enter Collection Overview',
                textInputType: TextInputType.text,
                maxLines: 5,
              ),
//
              const SizedBox(height: 20),

              CustomButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    CollectionEntity input = CollectionEntity(
                      name: name,
                      overview: overview,
                    );
                    if (widget.delete!) {
                      context
                          .read<AddCollectionCubit>()
                          .deleteCollection(widget.defaultEntity!.id!);
                    } else if (widget.update!) {
                      context
                          .read<AddCollectionCubit>()
                          .updateCollection(input);
                    } else {
                      context.read<AddCollectionCubit>().addCollection(input);
                    }
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                text:
                    '${widget.delete! ? "Delete" : widget.update! ? "Update" : "Add"} Collection',
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
