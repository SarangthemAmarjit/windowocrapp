
import 'dart:ui';

import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../cons/constant.dart';

class TemporaryILPFormReplica extends StatefulWidget {
  const TemporaryILPFormReplica({super.key});

  @override
  State<TemporaryILPFormReplica> createState() => _TemporaryILPFormReplicaState();
}

class _TemporaryILPFormReplicaState extends State<TemporaryILPFormReplica> {
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
  // final List<String> purposes = ['Business', 'Tourism', 'Medical', 'Other'];
  // final List<String> gates = ['Imphal Gate', 'Mao Gate', 'Moreh Gate'];
  // final List<String> states = states;
  // final List<String> genders = ['Male', 'Female', 'Others'];

  @override
  Widget build(BuildContext context) {
    Imagecontroller imgcon = Get.put(Imagecontroller());
    return GetBuilder<Managementcontroller>(
      builder: (mngctrl) {
        return GetBuilder<Imagecontroller>(builder: (_) {
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800),
              child: GetBuilder<PagenavControllers>(builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                            Expanded(
                              child: _buildDropdownField(
                                 "ID Proof", [mngctrl.idCard??"Id Card"],  mngctrl.idCard??"", (value) {
                               
                              }),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(child: _buildTextField('ID No.', _idNoController)),
                          ],
                        ).animate().fadeIn(delay: Duration(milliseconds: 0)),
                        Row(
                          children: [
                      
                               Expanded(child: _buildTextField('Applicant Name', _nameController)),
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
                        ).animate().fadeIn(delay: Duration(milliseconds: 300)),
                   
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
                        ).animate().fadeIn(delay: Duration(milliseconds: 400)),
                                
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
                              child:SizedBox()
                            ),
                          ],
                        ).animate().fadeIn(delay: Duration(milliseconds: 600)),
                                
                         _buildRadioGroup(
                                  'Gender', genders,mngctrl.gender, (value) {
                         mngctrl.changeGender(value!);
                              }).animate().fadeIn(delay: Duration(milliseconds: 800)),
                        Row(
                          children: [
                            Expanded(
                              child: _buildDateField('Period of Stay (From)', _fromDate,
                                  (value) {
                                setState(() {
                                  _fromDate = value;
                                });
                              }),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: _buildTextField(
                                    'Place of Stay in Manipur', _placeStayController)),
                          ],
                        ).animate().fadeIn(delay: Duration(milliseconds: 1000)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: AnimatedContainer(
                                height: mngctrl.purpose=="Others"?180:80,
                               padding:mngctrl.purpose=="Others"?EdgeInsets.all(8):null,
                                                           duration:Duration(milliseconds:800),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                   color: mngctrl.purpose=="Others"?Colors.yellow.withValues(alpha: 0.2): Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    _buildDropdownField(
                                        'Purpose of Visit', purposes,mngctrl.purpose,
                                        (value) {
                                            mngctrl.changePurpose(value!);
                                    }),
                                    mngctrl.purpose=="Others"? AnimatedOpacity(
                                      duration: Duration(milliseconds: 600),
                                      opacity: mngctrl.purpose=="Others"?1:0,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          _buildTextField(
                                            padding: EdgeInsets.only(bottom:4),
                                            'Purpose', _visitPurposeController),
                                            Text("Please provide a purpose.")
                                        ],
                                      ),
                                    ):SizedBox(),
                                     
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child:_buildTextField('Village/Street', _villageController),),
                          ],
                        ).animate().fadeIn(delay: Duration(milliseconds: 1200)),
                       
                        Row(
                          children: [
                            Expanded(
                              child: _buildDropdownField(
                                  'State', states, mngctrl.state, (value) {
                                      mngctrl.changeState(value!);
                              }),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: _buildTextField('District', _villageController)),
                          ],
                        ).animate().fadeIn(delay: Duration(milliseconds: 1400)),
                        
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
                        ).animate().fadeIn(delay: Duration(milliseconds: 1600)),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            // if(_formkey.currentState!.validate()){
                            controller.changePage(2);
                        
                            // }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(32),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8)),
                            clipBehavior: Clip.antiAlias,
                            child: Center(
                                child: Text(
                              "Next",
                              style: TextStyle(color: Colors.white,fontSize: 20),
                            )),
                          ).animate().scaleXY(begin: 0.6,end: 1,delay: Duration(milliseconds: 1800),duration: Duration(milliseconds: 600),curve: Curves.easeIn). fadeIn(delay: Duration(milliseconds: 1800)),
                        ),
                      ],
                    ).animate().fadeIn(duration: const Duration(milliseconds: 500)),
                  ),
                );
              }),
            ),
          );
        });
      }
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {String? Function(String?)? validator,EdgeInsets? padding}) {
        
    return Padding(
      padding: padding??const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        
        controller: controller,
        decoration: InputDecoration(
          labelStyle: TextStyle(fontSize: 20),
          labelText: label,
          floatingLabelStyle:TextStyle(fontSize: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        
        ),
        validator: validator??(v){
          if(v!.isEmpty){
            return "$label is empty";
          }
        },
      ),
    );
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
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),

            // dropdownColor: Colors.green,
            // iconEnabledColor: Colors.green,
            // focusColor: Colors.green,
            isDense: true,
            
            value: selectedValue,
            isExpanded: false,
            onChanged: onChanged,
            items: items
                .map((item) => DropdownMenuItem(
                  
                  value: item, child: Text(item)))
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
            
            label: Text(label),
            prefix: Padding(
              padding: const EdgeInsets.only (right:  8.0),
              child: Icon(Icons.date_range,size: 14,),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.green)
            )
          ),
          child: Text(selectedDate != null
              ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
              : 'Select Date'),
        ),
      ),
    );
  }

  Widget _buildRadioGroup(String label, List<String> options,
      String? selectedValue, ValueChanged<String?> onChanged) {
        Managementcontroller mngctrl = Get.find<Managementcontroller>();
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
                      child: InkWell(
                        onTap:(){
                            mngctrl.changeGender(option);
                        },
                        child: AnimatedContainer(
                          
                          margin: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                          duration: Duration(milliseconds: 800),
                          height: 60,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          color: selectedValue == option?Colors.green:Colors.grey[200],
                          ),
                          child: Center(child: Text(option,style: TextStyle(fontSize: 18,color:selectedValue == option?Colors.white:null ),)),
                         
                          // child: RadioListTile(
                          //   contentPadding: EdgeInsets.zero,
                          //   title: Text(option),
                          //   value: option,
                          //   groupValue: selectedValue,
                          //   onChanged: onChanged,
                          // ),
                        ),
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
