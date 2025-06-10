import 'dart:io';

import 'package:art_gallery/core/repos/images_repo/images_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/features/auth/data/models/user_model.dart';
import 'package:art_gallery/features/auth/domain/entites/user_entity.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/widgets/image_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  bool isEditing = false;
  late UserEntity user;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  File? fileImage = null;

  @override
  void initState() {
    super.initState();
    user = getIt.get<AuthRepo>().getSavedUserData();

    nameController.text = user.name;
    emailController.text = user.email;
    phoneController.text = user.phone;
    birthdateController.text = user.birthDate;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    birthdateController.dispose();
    super.dispose();
  }

  void toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void saveProfile() async {
    if (fileImage == null) {
      setState(() {
        user.profileImageUrl = "";
        user.name = nameController.text;
        user.phone = phoneController.text;
        user.birthDate = birthdateController.text;
        user.email = emailController.text;
        getIt.get<AuthRepo>().saveUserData(user: user);
        getIt.get<AuthRepo>().addUser(UserModel.fromEntity(user));
        isEditing = false;
      });
      return;
    }
    var result = await getIt<ImagesRepo>().UploadImage(fileImage!);
    result.fold(
      (f) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(f.message)),
        );
        return;
      },
      (url) async {
        setState(() {
          user.profileImageUrl = url;
          user.name = nameController.text;
          user.phone = phoneController.text;
          user.birthDate = birthdateController.text;
          user.email = emailController.text;
          getIt.get<AuthRepo>().saveUserData(user: user);
          getIt.get<AuthRepo>().addUser(UserModel.fromEntity(user));
          isEditing = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            onPressed: isEditing ? saveProfile : toggleEdit,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: isEditing ? pickImage : null,
                child: CircleAvatar(
                  radius: 90,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: ClipOval(
                      child: user.profileImageUrl != null &&
                              user.profileImageUrl != ""
                          ? Image.network(
                              user.profileImageUrl!,
                              fit: BoxFit.cover,
                            )
                          : fileImage == null
                              ? Image.asset(
                                  Assets.imagesUserPicture,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  fileImage!,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                    ),
                  ), // Add a profile picture in assets
                ),
              ),
              SizedBox(height: 30),
              buildTextField('Name', nameController, isEditing),
              SizedBox(height: 25),
              buildTextField('Email', emailController, false),
              SizedBox(height: 25),
              buildTextField('Phone', phoneController, isEditing),
              SizedBox(height: 25),
              buildTextField('Birthdate', birthdateController, false),
              SizedBox(height: 50),
              if (isEditing)
                ElevatedButton(
                  onPressed: saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightPrimaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  child: Text('Save Changes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, TextEditingController controller, bool isEditable) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: isEditable ? Colors.black : const Color.fromARGB(255, 0, 0, 0),
        fontSize: 20,
      ),
      decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          enabled: isEditable,
          fillColor:
              isEditable ? Colors.white : const Color.fromARGB(255, 0, 0, 0),
          labelStyle: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 22,
          )),
    );
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();

    // Show bottom sheet to choose source
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take a photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Remove current image'),
              onTap: () {
                fileImage = null; // Clear the current image
                user.profileImageUrl =
                    null; // Clear the URL to use the new image
                setState(() {}); // Update the UI
                Navigator.pop(context); // Close the bottom sheet
              },
            ),
          ],
        ),
      ),
    );

    if (source == null) return; // User dismissed the bottom sheet

    final XFile? media = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );

    if (media != null) {
      fileImage = File(media.path);
      user.profileImageUrl = null; // Clear the URL to use the new image
      // Update the UI
      // If you're in a stateful widget, call setState(() {})
      setState(() {});
    }
  }
}
