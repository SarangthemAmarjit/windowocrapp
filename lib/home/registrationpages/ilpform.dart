import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:crop_image/crop_image.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import 'package:dropdown_search/dropdown_search.dart';
import '../../cons/constant.dart';

class TemporaryILPForm extends StatefulWidget {
  const TemporaryILPForm({super.key});

  @override
  State<TemporaryILPForm> createState() => _TemporaryILPFormState();
}

class _TemporaryILPFormState extends State<TemporaryILPForm> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  final _nameController = TextEditingController();
  final _parentNameController = TextEditingController();
  final _idNoController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _placeStayController = TextEditingController();
  final _visitPurposeController = TextEditingController();
  final _nearestpliceController = TextEditingController();
  final _villageController = TextEditingController();
  final _tehsilController = TextEditingController();
  final List<String> cardTypes = ['Aadhar', 'PAN', 'Voter', 'Driving Licence'];
  String? selectedCardType;
  XFile? profileimage;

  DateTime? _fromDate;
  DateTime? _dob;
  String? _selectedIdProof;

  final List<String> idProofs = [
    'Aadhaar',
    'Voter ID',
    'Driving License',
    'Passport'
  ];
  // final List<String> purposes = ['Business', 'Tourism', 'Medical', 'Other'];
  // final List<String> gates = ['Imphal Gate', 'Mao Gate', 'Moreh Gate'];
  // final List<String> states = states;
  // final List<String> genders = ['Male', 'Female', 'Others'];

  @override
  Widget build(BuildContext context) {
    Imagecontroller imgcon = Get.put(Imagecontroller());
    return GetBuilder<Managementcontroller>(builder: (mngctrl) {
      return GetBuilder<Imagecontroller>(builder: (_) {
        return GetBuilder<PagenavControllers>(builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // imgcon.profileimage != null
                  //     ? CropImage(
                  //         controller: imgcon.crcontroller,
                  //         image: Image.file(
                  //           File(imgcon.profileimage!.path),
                  //         ),
                  //         paddingSize: 25.0,
                  //         alwaysMove: false,
                  //         minimumImageSize: 500,
                  //         maximumImageSize: 500,
                  //       )
                  //     : SizedBox(),
                  Row(
                    children: [
                      // Expanded(
                      //   flex: 1,
                      //   child: InkWell(
                      //     onTap: () {
                      //       imgcon.initializeCamera(
                      //           isfront: false,
                      //           isback: false,
                      //           isprofilecam: true,
                      //           context: context);
                      //     },
                      //     child: Container(
                      //       height: 130,
                      //       decoration: BoxDecoration(
                      //         border: Border.all(
                      //           color: Colors.grey[700]!,
                      //         ),
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //       child: ClipRRect(
                      //         borderRadius: BorderRadius.circular(10),
                      //         child: imgcon.profileimage != null
                      //             ? Transform.flip(
                      //                 flipX: true,
                      //                 child: Image.file(
                      //                   fit: BoxFit.cover,
                      //                   File(imgcon.profileimage!.path),
                      //                 ),
                      //               )
                      //             : Column(
                      //                 mainAxisAlignment: MainAxisAlignment.center,
                      //                 children: [
                      //                   Icon(Icons.add_a_photo_rounded),
                      //                   SizedBox(
                      //                     height: 16,
                      //                   ),
                      //                   Text("Capture a Profile Photo")
                      //                 ],
                      //               ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      Expanded(
                          child: _buildTextField(
                              'Applicant Name', _nameController)),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: _buildTextField(
                            'Parent/Guardian Name', _parentNameController),
                      )
                      // Expanded(
                      //   flex: 4,
                      //   child: Column(
                      //     children: [
                      //       _buildTextField('Applicant Name', _nameController),
                      //       _buildTextField(
                      //           'Parent/Guardian Name', _parentNameController),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdownField(
                            'ID Proof', idProofs, _selectedIdProof, (value) {
                          setState(() {
                            _selectedIdProof = value;
                          });
                        }),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: _buildTextField('ID No.', _idNoController)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField('Email', _emailController,
                            validator: _emailValidator),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: _buildTextField('Mobile No.', _mobileController,
                            validator: _phoneValidator),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDateField(
                            'Period of Stay (From)', _fromDate, (value) {
                          setState(() {
                            _fromDate = value;
                          });
                        }),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: _buildTextField('Place of Stay in Manipur',
                              _placeStayController)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdownField(
                            'Purpose of Visit', purposes, mngctrl.purpose,
                            (value) {
                          mngctrl.changePurpose(value!);
                        }),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: _buildTextField(
                              'Purpose (if other)', _visitPurposeController)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDateField('Date of Birth', _dob, (value) {
                          setState(() {
                            _dob = value;
                          });
                        }),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: _buildRadioGroup(
                            'Gender', genders, mngctrl.gender, (value) {
                          mngctrl.changeGender(value!);
                        }),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdownState(
                            'State', states, mngctrl.state, (value) {
                          mngctrl.changeState(value!);
                        }),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child:
                              _buildTextField('District', _villageController)),
                    ],
                  ),
                  _buildTextField('Village/Street', _villageController),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                            'Nearest Police Station', _nearestpliceController),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: _buildTextField('Tehsil', _tehsilController)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      // if(_formkey.currentState!.validate()){
                      controller.changePage(2);

                      // }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8)),
                      clipBehavior: Clip.antiAlias,
                      child: Center(
                          child: Text(
                        "Next",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: const Duration(milliseconds: 500)),
            ),
          );
        });
      });
    });
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        ),
        validator: validator ??
            (v) {
              if (v!.isEmpty) {
                return "$label is empty";
              }
            },
      ),
    );
  }

  Widget _buildDropdownState(String label, List items, String? selectedValue,
      ValueChanged<String?> onChanged) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: DropdownSearch<String>(
          // we can pass string to it as well but then we've to make
          // sure that the list of items are string like this List<String>

          onChanged: onChanged,

          selectedItem: selectedValue,
        ));
  }

  Widget _buildDropdownField(String label, List<String> items,
      String? selectedValue, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isDense: true,
            value: selectedValue,
            isExpanded: false,
            onChanged: onChanged,
            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? selectedDate,
      ValueChanged<DateTime?> onDateSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () async {
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now().add(const Duration(days: 365)),
          );
          if (date != null) {
            onDateSelected(date);
          }
        },
        child: InputDecorator(
          decoration: InputDecoration(
              labelText: label,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.green))),
          child: Text(selectedDate != null
              ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
              : 'Select Date'),
        ),
      ),
    );
  }

  Widget _buildRadioGroup(String label, List<String> options,
      String? selectedValue, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Row(
            children: options
                .map((option) => Expanded(
                      child: RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(option),
                        value: option,
                        groupValue: selectedValue,
                        onChanged: onChanged,
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number cannot be empty';
    }
    final phoneRegex = RegExp(r'^\d{10}\$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid 10-digit mobile number';
    }
    return null;
  }
}
