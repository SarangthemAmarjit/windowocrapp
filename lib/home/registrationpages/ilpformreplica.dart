import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:camera_windows_example/models/permit.dart';
import 'package:camera_windows_example/widgets/bannercard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../cons/constant.dart';

class TemporaryILPFormReplica extends StatefulWidget {
  const TemporaryILPFormReplica({super.key});

  @override
  State<TemporaryILPFormReplica> createState() =>
      _TemporaryILPFormReplicaState();
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
  final _districtController = TextEditingController();
  final _tehsilController = TextEditingController();

  final _localpincodeController = TextEditingController();
  final _localpolicestationController = TextEditingController();
  final _localresidencename = TextEditingController();

  final List<String> cardTypes = ['Aadhar', 'PAN', 'Voter', 'Driving Licence'];
  String? selectedCardType;
  XFile? profileimage;
  DateTime? _dob;
  String? datenullText;
  String? statenullText;
  String district = "Imphal West";
  String? purposevisitnulltext;
  String? districtnulltext;
  @override
  void initState() {
    super.initState();
    VisitorEntry? d = Get.find<Managementcontroller>().getPermit;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (d != null) {
          _nameController.text = d.applcntName ?? "";
          _parentNameController.text = d.applcntParent ?? "";
          // _idNoController.text = d.idNo ?? "";
          _districtController.text = d.district ?? "";
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Managementcontroller>(builder: (mngctrl) {
      return GetBuilder<Imagecontroller>(builder: (imgcon) {
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
                      Center(
                              child: SizedBox(
                                  width: double.maxFinite,
                                  child: BannerContainer(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    margin: EdgeInsets.zero,
                                    text: "All fields with * are mandatory",
                                    color: Colors.orange,
                                    isCenter: true,
                                  )))
                          .animate()
                          .fadeIn(delay: Duration(milliseconds: 0)),
                      SizedBox(
                        height: 20,
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: mngctrl.getPermit?.idProof != null
                                ? _buildDropdownField(
                                    "ID Proof",
                                    [mngctrl.getPermit?.idProof ?? "Id Card"],
                                    mngctrl.getPermit?.idProof ?? "",
                                    (value) {},
                                    null)
                                : SizedBox(),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child:
                                  _buildTextField('ID No.', _idNoController)),
                        ],
                      ).animate().fadeIn(delay: Duration(milliseconds: 0)),
                      Row(
                        children: [
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
                      ).animate().fadeIn(delay: Duration(milliseconds: 300)),

                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField('Email', _emailController,
                                mandatory: false, validator: _emailValidator),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: _buildTextField(
                                'Mobile No.', _mobileController,
                                counter: 10, validator: _phoneValidator),
                          ),
                        ],
                      ).animate().fadeIn(delay: Duration(milliseconds: 400)),

                      Row(
                        children: [
                          Expanded(
                            child:
                                _buildDateField('Date of Birth', _dob, (value) {
                              setState(() {
                                _dob = value;
                              });
                            }, datenullText),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: _buildTextField(
                                'Village/Street', _villageController),
                          ),
                        ],
                      ).animate().fadeIn(delay: Duration(milliseconds: 600)),

                      Row(
                        children: [
                          Expanded(
                            child: _buildDropdownField(
                                'State', states, mngctrl.state, (value) {
                              mngctrl.changeState(value!);
                            }, statenullText),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: _buildTextField(
                                  'District', _districtController)),
                        ],
                      ).animate().fadeIn(delay: Duration(milliseconds: 800)),

                      //

                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                                'Police Station', _nearestpliceController),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child:
                                  _buildTextField('Tehsil', _tehsilController)),
                        ],
                      ).animate().fadeIn(delay: Duration(milliseconds: 1000)),
                      _buildRadioGroup('Gender', genders, mngctrl.gender,
                          (value) {
                        mngctrl.changeGender(value!);
                      }).animate().fadeIn(delay: Duration(milliseconds: 1200)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildDropdownField(
                                '* District', districts, district, (value) {
                              setState(() {
                                if (value != null) {
                                  district = value;
                                }
                              });
                            }, null),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: _buildTextField(
                              'PinCode',
                              _localpincodeController,
                              mandatory: false,
                              validator: (p0) {
                                if (p0 != null && p0.isNotEmpty) {
                                  if (p0.isNumericOnly && p0.length == 6) {
                                    return null;
                                  }
                                  return "Pincode must be 6 digits";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ).animate().fadeIn(delay: Duration(milliseconds: 1400)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: _buildTextField('Place of Stay in Manipur',
                                  _placeStayController)),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: _buildTextField(
                              'Nearest Police Station',
                              validator: (p) {
                                return null;
                              },
                              _localpolicestationController,
                              mandatory: false,
                            ),
                          ),
                        ],
                      ).animate().fadeIn(delay: Duration(milliseconds: 1600)),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AnimatedContainer(
                              height: mngctrl.purpose == "Others" ? 220 : 100,
                              padding: mngctrl.purpose == "Others"
                                  ? EdgeInsets.all(8)
                                  : null,
                              duration: Duration(milliseconds: 800),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: mngctrl.purpose == "Others"
                                    ? Colors.blue.withValues(alpha: 0.2)
                                    : Colors.white,
                              ),
                              child: Column(
                                children: [
                                  _buildDropdownField('* Purpose of Visit',
                                      purposes, mngctrl.purpose, (value) {
                                    mngctrl.changePurpose(value!);
                                  }, purposevisitnulltext),
                                  mngctrl.purpose == "Others"
                                      ? AnimatedOpacity(
                                          duration: Duration(milliseconds: 600),
                                          opacity: mngctrl.purpose == "Others"
                                              ? 1
                                              : 0,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _buildTextField(
                                                  padding: EdgeInsets.only(
                                                      bottom: 4),
                                                  'Purpose',
                                                  _visitPurposeController),
                                              Text("Please provide a purpose.")
                                            ],
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: _buildTextField(
                              'Local Residence',
                              validator: (p) {
                                return null;
                              },
                              _localresidencename,
                              mandatory: false,
                            ),
                          ),
                        ],
                      ).animate().fadeIn(delay: Duration(milliseconds: 1600)),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          if (_formkey.currentState!.validate() &&
                              _dob != null &&
                              mngctrl.state != null &&
                              mngctrl.purpose != null) {
                            VisitorEntry permits = VisitorEntry(
                              applcntName: _nameController.text,
                              applcntAddress: _villageController.text,
                              idProof: mngctrl.getPermit?.idProof ?? "",
                              applcntDOB: _dob?.toIso8601String(),
                              applcntDistrict: _districtController.text,
                              applcntEmail: _emailController.text,
                              applcntGender: mngctrl.gender,
                              applcntMobile: _mobileController.text,
                              applcntParent: _parentNameController.text,
                              applcntPoliceStation:
                                  _nearestpliceController.text,
                              applcntState: mngctrl.state,
                              idNo: _idNoController.text,
                              applcntTehsil: _tehsilController.text,
                              applcntVillage: _villageController.text,
                              gateID: mngctrl.selectedGate?.id ?? "",
                              placeOfStay: _placeStayController.text,
                              pinCode: _localpincodeController.text,
                              residingPeriod: "30",
                              entryType: "ONLINE",
                              applcntHNo: "NA",
                              applyDistrictID: "NA",
                              category: "NA",
                              district: district,
                              landmark: "NA",
                              nearestPS: _nearestpliceController.text,
                              lrName: _localresidencename.text,
                              visitDate: DateTime(DateTime.now().year,
                                      DateTime.now().month, DateTime.now().day)
                                  .toIso8601String(),
                              purposeVisit: mngctrl.purpose == "Others"
                                  ? _visitPurposeController.text
                                  : mngctrl.purpose,
                            );

                            mngctrl.addPermit(permits);
                            controller.changePage(2);
                            setState(() {
                              datenullText = null;
                              statenullText = null;
                            });
                          } else {
                            if (_dob == null) {
                              setState(() {
                                datenullText = "DOB cannot be empty";
                              });
                            } else {
                              setState(() {
                                datenullText = null;
                              });
                            }

                            if (mngctrl.state == null) {
                              setState(() {
                                statenullText = "State Cannot be empty";
                              });
                            } else {
                              setState(() {
                                statenullText = null;
                              });
                            }

                            if (mngctrl.purpose == null) {
                              setState(() {
                                purposevisitnulltext =
                                    "Purpose cannot be empty";
                              });
                            } else {
                              setState(() {
                                purposevisitnulltext = null;
                              });
                            }
                          }
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
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                        )
                            .animate()
                            .scaleXY(
                                begin: 0.6,
                                end: 1,
                                delay: Duration(milliseconds: 1800),
                                duration: Duration(milliseconds: 600),
                                curve: Curves.easeIn)
                            .fadeIn(delay: Duration(milliseconds: 1800)),
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn(duration: const Duration(milliseconds: 500)),
                ),
              );
            }),
          ),
        );
      });
    });
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {String? Function(String?)? validator,
      EdgeInsets? padding,
      int? counter,
      bool mandatory = true}) {
    return TextFieldWidget(
      controller: controller,
      label: label,
      validator: validator,
      counter: counter,
      mandatory: mandatory,
    );
  }

  Widget _buildDropdownField(
      String label,
      List<String> items,
      String? selectedValue,
      ValueChanged<String?> onChanged,
      String? errorText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          errorText: errorText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),

            // dropdownColor: Colors.green,
            // iconEnabledColor: Colors.green,
            // focusColor: Colors.green,
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
      ValueChanged<DateTime?> onDateSelected, String? errorText) {
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
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.date_range,
                  size: 14,
                ),
              ),
              errorText: errorText,
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
                        onTap: () {
                          mngctrl.changeGender(option);
                        },
                        child: AnimatedContainer(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          duration: Duration(milliseconds: 800),
                          height: 60,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: selectedValue == option
                                ? Colors.blue
                                : Colors.grey[200],
                          ),
                          child: Center(
                              child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 1,
                                      color: selectedValue == option
                                          ? Colors.white
                                          : Colors.grey),
                                ),
                                child: selectedValue == option
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                      )
                                    : SizedBox(),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                option,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: selectedValue == option
                                        ? Colors.white
                                        : null),
                              ),
                            ],
                          )),

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
      return null;
    }

    return RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)
        ? null
        : "Email doesnt match";
  }

  String? _phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number cannot be empty';
    }

    if (!value.isNum || value.length != 10) {
      return 'Enter a valid 10-digit mobile number';
    }
    return null;
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.padding,
    required this.controller,
    required this.label,
    this.validator,
    this.counter,
    this.focusnode,
    this.fontSize,
    this.contentpadding,
    this.mandatory = true, this.keytype,
  });
  final double? fontSize;
  final FocusNode? focusnode;
  final EdgeInsets? padding;
  final EdgeInsets? contentpadding;
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final int? counter;
  final bool mandatory;
  final TextInputType? keytype;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        keyboardType:  keytype,
        style: TextStyle(fontSize: fontSize),
        focusNode: focusnode,
        maxLength: counter ?? 40,
        controller: controller,
        buildCounter: (context,
                {required currentLength,
                required isFocused,
                required maxLength}) =>
            SizedBox(),
        decoration: InputDecoration(
          
          errorStyle: TextStyle(
            color: Colors.red, // Change error text color
            fontSize: 24, // Change font size
            fontWeight: FontWeight.bold, // Make it bold
          ),
          contentPadding: contentpadding,
          labelStyle: TextStyle(fontSize: 20),
          labelText: mandatory ? "* $label" : label,
          floatingLabelStyle: TextStyle(fontSize: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        ),
        validator: validator ??
            (v) {
              if (v!.isEmpty) {
                return "$label is empty";
              }
              return null;
            },
      ),
    );
  }
}
