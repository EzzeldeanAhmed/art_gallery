import 'dart:io';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/features/auth/presentation/views/widgets/custom_checkbox.dart';
import 'package:art_gallery/features/manage_collection/presentation/views/manger/get_collections/cubit/get_collection_cubit.dart';
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
      {super.key,
      this.update,
      this.defaultEntity,
      this.delete,
      this.collection = 'Main'});
  final bool? update;
  final bool? delete;
  final ArtworkEntity? defaultEntity;
  final String collection;
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
List<String> collections = [];
Map<String, String> collectionMap = {};

class _AddArtworkViewBodyState extends State<AddArtworkViewBody> {
  Future<List<String>> getArtistNames() async {
    try {
      // Replace 'your-collection-name' with the name of your collection
      if (artists.isNotEmpty) {
        return artists;
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

  Future<List<String>> getCollection() async {
    try {
      if (!collections.isEmpty) {
        return collections;
      }
      final querySnapshot =
          await FirebaseFirestore.instance.collection('collections').get();

      // Extract document IDs
      final collectionNames = querySnapshot.docs.map((doc) {
        collectionMap[doc.get("name").toString()] = doc.id;
        return doc.get("name").toString();
      }).toList();
      collectionMap["Main"] = "main";
      // push Main in front of list
      collections = ["Main"] + collectionNames;
      return ["Main"] + collectionNames;
    } catch (e) {
      print('Error fetching collection names: $e');
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
      // collection = widget.update!
      //     ? widget.defaultEntity!.collectionID!
      //     : widget.collection,
      dimensions = widget.update! ? widget.defaultEntity!.dimensions : "",
      videoUrl = widget.update! ? widget.defaultEntity!.videoUrl ?? "" : "";
  late bool forSale = widget.update! ? widget.defaultEntity!.forSale! : false;
  late final countryController = TextEditingController(
      text: widget.update! ? widget.defaultEntity!.country : "");
  late final yearController = TextEditingController(
      text: widget.update! ? widget.defaultEntity!.year.toString() : "");
  late num year = widget.update! ? widget.defaultEntity!.year : -1,
      price = widget.update! ? widget.defaultEntity!.price ?? 0 : 0;
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
              widget.update! || widget.delete!
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID:', style: TextStyles.semiBold16),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                            enabled: false,
                            initialValue: widget.defaultEntity!.id,
                            hintText: 'Artwork ID',
                            textInputType: TextInputType.text),
                        const SizedBox(height: 8),
                      ],
                    )
                  : Container(),
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
                  enabled: !widget.delete!,
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
                                      DateTime(DateTime.now().year - 825, 1),
                                  lastDate:
                                      DateTime(DateTime.now().year - 1, 1),
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
                },
              ),
              // const SizedBox(height: 8),
              // Text('Collection:', style: TextStyles.semiBold16),
              // const SizedBox(height: 5),
              // FutureBuilder<List<String>>(
              //   future: getCollection(),
              //   builder: (context, snapshot) {
              //     // ignore: unrelated_type_equality_checks
              //     if (snapshot.connectionState == ConnectionState.waiting &&
              //         collections != []) {
              //       return CustomTextFormField(
              //           hintText: "Loading",
              //           textInputType: TextInputType.text,
              //           enabled: false);
              //     } else if (snapshot.hasError && collections != []) {
              //       return Center(child: Text('Error: ${snapshot.error}'));
              //     } else if ((!snapshot.hasData || snapshot.data!.isEmpty) &&
              //         collections != []) {
              //       return Center(child: Text('No documents found.'));
              //     } else {
              //       return DropdownButtonFormField2<String>(
              //         //isExpanded: true,
              //         decoration: InputDecoration(
              //           filled: true,
              //           fillColor: const Color(0xFFF9FAFA),
              //           contentPadding: EdgeInsets.zero,
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(0),
              //           ),
              //         ),
              //         value:
              //             collection != "" && collections.contains(collection)
              //                 ? collection
              //                 : null,
              //         hint: const Text(
              //           'Select collection of Artwork',
              //           style: TextStyle(
              //             fontSize: 14,
              //             color: Color(0XFF949D9E),
              //           ),
              //         ),
              //         items: snapshot.data!
              //             .map((item) => DropdownMenuItem<String>(
              //                   value: item,
              //                   child: Text(
              //                     item,
              //                     style: const TextStyle(
              //                       fontSize: 14,
              //                     ),
              //                   ),
              //                 ))
              //             .toList(),
              //         validator: (value) {
              //           if (value == null) {
              //             return 'Please select a collection.';
              //           }
              //           return null;
              //         },
              //         onChanged: widget.delete!
              //             ? null
              //             : (value) {
              //                 setState(() {
              //                   collection = value!;
              //                 });
              //               },
              //         onSaved: (value) {},
              //         buttonStyleData: const ButtonStyleData(
              //           padding: EdgeInsets.only(right: 8),
              //         ),
              //         iconStyleData: const IconStyleData(
              //           icon: Icon(
              //             Icons.arrow_drop_down,
              //             color: Colors.blue,
              //           ),
              //           iconSize: 30,
              //         ),
              //         dropdownStyleData: DropdownStyleData(
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(15),
              //             color: Colors.white,
              //           ),
              //         ),
              //         menuItemStyleData: const MenuItemStyleData(
              //           padding: EdgeInsets.symmetric(horizontal: 16),
              //         ),
              //       );

              //       // CustomTextFormField(
              //       //     enabled: !widget.delete!,
              //       //     initialValue: artist,
              //       //     onSaved: (value) {
              //       //       artist = value!;
              //       //     },
              //       //     hintText: 'Artist',
              //       //     textInputType: TextInputType.text);
              //     }
              //   },
              // ),
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
              Text('Video URL:', style: TextStyles.semiBold16),
              const SizedBox(height: 5),
              CustomTextFormField(
                  enabled: !widget.delete!,
                  initialValue: videoUrl,
                  onSaved: (value) {
                    videoUrl = value!;
                  },
                  validator: (value) {
                    return null; // No validation, so it's not required
                  },
                  hintText: 'Enter artwork Video URL',
                  textInputType: TextInputType.text),
              widget.collection == "Main"
                  ? Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CustomCheckBox(
                              onChecked: (value) {
                                setState(() {
                                  forSale = value;
                                });
                              },
                              isChecked:
                                  widget.collection != "Main" ? false : forSale,
                              enabled: widget.collection == "Main",
                            ),
                          ),
                          Text('For Sale', style: TextStyles.semiBold16),
                        ]),
                      ],
                    )
                  : Container(),
              const SizedBox(height: 20),
              forSale
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price:', style: TextStyles.semiBold16),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          enabled: !widget.delete!,
                          initialValue: price.toString(),
                          onSaved: (value) {
                            price = num.parse(value!);
                          },
                          hintText: 'Enter Artwork Price',
                          textInputType: TextInputType.number,
                        ),
                      ],
                    )
                  : Container(),
              const SizedBox(height: 30),
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
                      // ArtworkEntity input = ArtworkEntity(
                      //   reviews: [],
                      //   code: code,
                      //   name: name,
                      //   type: type,
                      //   medium: medium,
                      //   country: country,
                      //   description: description,
                      //   epoch: epoch,
                      //   artist: artist,
                      //   year: year,
                      //   dimensions: dimensions,
                      //   image: image!,
                      //   collectionID: widget.collection,
                      //   status:
                      //       widget.collection == "Main" ? "permanent" : "other",
                      //   forSale: widget.collection != "Main" ? false : forSale,
                      //   price: price.toInt(),
                      //   videoUrl: videoUrl,
                      // );
                      ArtworkEntity input;
                      if (widget.defaultEntity != null) {
                        input = widget.defaultEntity!;
                        input.name = name;
                        input.code = code;
                        input.type = type;
                        input.medium = medium;
                        input.country = country;
                        input.description = description;
                        input.epoch = epoch;
                        input.artist = artist;
                        input.year = year;
                        input.dimensions = dimensions;
                        input.image = image!;
                        input.collectionID = widget.collection;
                        input.status =
                            widget.collection == "Main" ? "permanent" : "other";
                        input.forSale =
                            widget.collection != "Main" ? false : forSale;
                        input.price = price.toInt();
                        input.videoUrl = videoUrl;
                      } else {
                        input = ArtworkEntity(
                          name: name,
                          reviews: [],
                          code: "dummy",
                          type: type,
                          medium: medium,
                          country: country,
                          description: description,
                          epoch: epoch,
                          artist: artist,
                          year: year,
                          dimensions: dimensions,
                          image: image!,
                          collectionID: widget.collection,
                          status: widget.collection == "Main"
                              ? "permanent"
                              : "other",
                          forSale:
                              widget.collection != "Main" ? false : forSale,
                          price: price.toInt(),
                          videoUrl: videoUrl,
                        );
                      }

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
                        if (widget.collection != "Main") {
                          Navigator.of(context).pop();
                        }
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