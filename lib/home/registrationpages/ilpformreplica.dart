import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:camera_windows_example/models/permit.dart';
import 'package:camera_windows_example/widgets/bannercard.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../cons/constant.dart';
import '../../widgets/customkeys.dart';

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

  Map<String, TextEditingController>? controllers;

  final _focusNodes = {
    'name': FocusNode(),
    'parentName': FocusNode(),
    'idNo': FocusNode(),
    'email': FocusNode(),
    'mobile': FocusNode(),
    'placeStay': FocusNode(),
    'visitPurpose': FocusNode(),
    'nearestPolice': FocusNode(),
    'village': FocusNode(),
    'district': FocusNode(),
    'tehsil': FocusNode(),
    'localPincode': FocusNode(),
    'localPoliceStation': FocusNode(),
    'localResidenceName': FocusNode(),
  };

  final List<String> cardTypes = ['Aadhar', 'PAN', 'Voter', 'Driving Licence'];
  String? selectedCardType;
  XFile? profileimage;
  DateTime? _dob;
  String? datenullText;
  String? statenullText;
  String district = "Imphal West";
  String? purposevisitnulltext;
  String? districtnulltext;

  String? _activeField;

  bool firspage = true;
  bool isKeyboardnum = false;
  void changepages(bool ispage) {
    setState(() {
      firspage = ispage;
    });
  }

  @override
  void initState() {
    super.initState();
    VisitorEntry? d = Get.find<Managementcontroller>().getPermit;

    controllers = {
      'name': _nameController,
      'parentName': _parentNameController,
      'idNo': _idNoController,
      'email': _emailController,
      'mobile': _mobileController,
      'placeStay': _placeStayController,
      'visitPurpose': _visitPurposeController,
      'nearestPolice': _nearestpliceController,
      'village': _villageController,
      'district': _districtController,
      'tehsil': _tehsilController,
      'localPincode': _localpincodeController,
      'localPoliceStation': _localpolicestationController,
      'localResidenceName': _localresidencename,
    };

    // Attach focus listeners
    _focusNodes.forEach((key, node) {
      node.addListener(() {
        if (node.hasFocus) {
          setState(() {
            _activeField = key;
          });

          if (_activeField == 'mobile' || _activeField == 'localPincode') {
            if (!isKeyboardnum) {
              setState(() {
                isKeyboardnum = true;
              });
            }
          } else {
            if (isKeyboardnum) {
              setState(() {
                isKeyboardnum = false;
              });
            }
          }
        }
      });
    });

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (d != null) {
          _nameController.text = d.applcntName ?? "";
          _parentNameController.text = d.applcntParent ?? "";
          _idNoController.text = d.idNo ?? "";
          _districtController.text = d.applcntDistrict ?? "";
          _emailController.text = d.applcntEmail ?? "";
          _mobileController.text = d.applcntMobile ?? "";
          _placeStayController.text = d.placeOfStay ?? "";
          _visitPurposeController.text = d.purposeVisit ?? "";
          _nearestpliceController.text = d.applcntPoliceStation ?? "";
          _villageController.text = d.applcntVillage ?? "";
          _tehsilController.text = d.applcntTehsil ?? "";
          _localpincodeController.text = d.pinCode ?? "";
          _localpolicestationController.text = d.nearestPS ?? "";
          _localresidencename.text = d.lrName ?? "";
          _dob = DateTime.tryParse(d.applcntDOB ?? "");
          if (d.district != null && d.district!.isNotEmpty) {
            district = d.district ?? "";
          }
        }
      },
    );
  }

  void _onKeyTap(String key) {
    if (_activeField != null && controllers != null) {
      if (_activeField == 'email') {
        controllers![_activeField]!.text += key;
      } else {
        String d = controllers?[_activeField]?.text ?? "";
        d += key;
        controllers![_activeField]!.text = d.capitalize!;
      }
    }
  }

  void _onBackspace() {
    if (_activeField != null && controllers != null) {
      final controller = controllers![_activeField]!;
      if (controller.text.isNotEmpty) {
        controller.text =
            controller.text.substring(0, controller.text.length - 1);
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusManager.instance.primaryFocus?.unfocus();
    });
    super.dispose();
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
                      firspage
                          ? SizedBox()
                          : IconButton.outlined(
                                  onPressed: () {
                                    changepages(true);
                                    _formkey.currentState!.reset();
                                  },
                                  icon: Icon(Icons.arrow_back_ios_new_outlined))
                              .animate()
                              .fadeIn()
                              .scaleXY(
                                  begin: 0.5, end: 1, curve: Curves.easeIn),
                      SizedBox(
                        height: firspage ? 0 : 20,
                      ),
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
                      Container(
                        height:firspage? 600:null,
                        child: SingleChildScrollView(
                          child: firspage
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child:
                                              mngctrl.getPermit?.idProof !=
                                                      null
                                                  ? _buildDropdownField(
                                                      "ID Proof",
                                                      [
                                                        mngctrl.getPermit
                                                                ?.idProof ??
                                                            "Id Card"
                                                      ],
                                                      mngctrl.getPermit
                                                              ?.idProof ??
                                                          "",
                                                      (value) {},
                                                      null)
                                                  : SizedBox(),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                            child: _buildTextField(
                                                'ID No.', _idNoController,
                                                node: _focusNodes['idNo']!,
                                                enabled: false)),
                                      ],
                                    ).animate().fadeIn(
                                        delay: Duration(milliseconds: 0)),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: _buildTextField(
                                                'Applicant Name',
                                                _nameController,
                                                node:
                                                    _focusNodes['name']!)),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: _buildTextField(
                                              'Parent/Guardian Name',
                                              _parentNameController,
                                              node: _focusNodes[
                                                  'parentName']!),
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
                                    ).animate().fadeIn(
                                        delay: Duration(milliseconds: 300)),
                                                
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildTextField(
                                              iscapitalize: false,
                                              'Email',
                                              _emailController,
                                              node: _focusNodes['email']!,
                                              mandatory: false,
                                              validator: _emailValidator),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: _buildTextField(
                                              'Mobile No.',
                                              _mobileController,
                                              node: _focusNodes['mobile']!,
                                              counter: 10,
                                              validator: _phoneValidator),
                                        ),
                                       
                                      ],
                                    ).animate().fadeIn(
                                        delay: Duration(milliseconds: 400)),
                                                
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildDateField(
                                              '* Date of Birth', _dob,
                                              (value) {
                                            setState(() {
                                              _dob = value;
                                            });
                                                
                                            if (_dob == null) {
                                              setState(() {
                                                datenullText =
                                                    "DOB cannot be empty";
                                              });
                                            } else {
                                              setState(() {
                                                datenullText = null;
                                              });
                                            }
                                          }, datenullText),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: _buildTextField(
                                              node: _focusNodes['village']!,
                                              'Village/Street',
                                              _villageController),
                                        ),
                                      ],
                                    ).animate().fadeIn(
                                        delay: Duration(milliseconds: 600)),
                                                
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                             
                                              _buildDropdownField(
                                                
                                                  'State',
                                                  states,
                                                  mngctrl.state, (value) {
                                                mngctrl.changeState(value!);
                                              }, statenullText),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                            child: _buildTextField(
                                                node: _focusNodes[
                                                    'district']!,
                                                'District',
                                                _districtController)),
                                      ],
                                    ).animate().fadeIn(
                                        delay: Duration(milliseconds: 800)),
                                                
                                    //
                                                
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildTextField(
                                              node: _focusNodes[
                                                  'nearestPolice']!,
                                              'Police Station',
                                              _nearestpliceController),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                            child: _buildTextField(
                                                node:
                                                    _focusNodes['tehsil']!,
                                                'Tehsil',
                                                _tehsilController)),
                                      ],
                                    ).animate().fadeIn(
                                        delay:
                                            Duration(milliseconds: 1000)),
                                    _buildRadioGroup(
                                        '* Gender', genders, mngctrl.gender,
                                        (value) {
                                      mngctrl.changeGender(value!);
                                    }).animate().fadeIn(
                                        delay:
                                            Duration(milliseconds: 1200)),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: _buildDropdownField(
                                              '* District',
                                              districts,
                                              district, (value) {
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
                                             counter: 6,
                                            node: _focusNodes[
                                                'localPincode']!,
                                            'PinCode',
                                            _localpincodeController,
                                            mandatory: false,
                                            validator: (p0) {
                                              if (p0 != null &&
                                                  p0.isNotEmpty) {
                                                if (p0.isNumericOnly &&
                                                    p0.length == 6) {
                                                  return null;
                                                }
                                                return "Pincode must be 6 digits";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ).animate().fadeIn(
                                        delay: Duration(milliseconds: 0)),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: _buildTextField(
                                                node: _focusNodes[
                                                    'placeStay']!,
                                                'Place of Stay in Manipur',
                                                _placeStayController)),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: _buildTextField(
                                            node: _focusNodes[
                                                'localPoliceStation']!,
                                            'Nearest Police Station',
                                            validator: (p) {
                                              return null;
                                            },
                                            _localpolicestationController,
                                            mandatory: false,
                                          ),
                                        ),
                                      ],
                                    ).animate().fadeIn(
                                        delay: Duration(milliseconds: 200)),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: AnimatedContainer(
                                            height:
                                                mngctrl.purpose == "Others"
                                                    ? 220
                                                    : 100,
                                            padding:
                                                mngctrl.purpose == "Others"
                                                    ? EdgeInsets.all(8)
                                                    : null,
                                            duration:
                                                Duration(milliseconds: 800),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: mngctrl.purpose ==
                                                      "Others"
                                                  ? Colors.blue.withValues(
                                                      alpha: 0.2)
                                                  : Colors.white,
                                            ),
                                            child: Column(
                                              children: [
                                                _buildDropdownField(
                                                    '* Purpose of Visit',
                                                    purposes,
                                                    mngctrl.purpose,
                                                    (value) {
                                                  mngctrl.changePurpose(
                                                      value!);
                                                }, purposevisitnulltext),
                                                mngctrl.purpose == "Others"
                                                    ? AnimatedOpacity(
                                                        duration: Duration(
                                                            milliseconds:
                                                                600),
                                                        opacity:
                                                            mngctrl.purpose ==
                                                                    "Others"
                                                                ? 1
                                                                : 0,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            _buildTextField(
                                                                node: _focusNodes[
                                                                    'visitPurpose']!,
                                                                padding: EdgeInsets.only(
                                                                    bottom:
                                                                        4),
                                                                'Purpose',
                                                                _visitPurposeController),
                                                            Text(
                                                                "Please provide a purpose.")
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
                                            node: _focusNodes[
                                                'localResidenceName']!,
                                            'Local Residence',
                                            validator: (p) {
                                              return null;
                                            },
                                            _localresidencename,
                                            mandatory: false,
                                          ),
                                        ),
                                      ],
                                    ).animate().fadeIn(
                                        delay: Duration(milliseconds: 400)),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (firspage) {
                            if (_formkey.currentState!.validate() &&
                                _dob != null &&
                                mngctrl.state != null) {
                              changepages(false);
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
                              controller.listenPageChange();
                            }
                          } else {
                            if (_formkey.currentState!.validate() &&
                                _dob != null &&
                                mngctrl.state != null &&
                                mngctrl.purpose != null) {
                              VisitorEntry permits = VisitorEntry(
                                applcntName: _nameController.text.trim(),
                                applcntAddress: _villageController.text.trim(),
                                idProof: mngctrl.getPermit?.idProof ?? "",
                                applcntDOB: _dob?.toIso8601String(),
                                applcntDistrict:
                                    _districtController.text.trim(),
                                applcntEmail: _emailController.text.trim(),
                                applcntGender: mngctrl.gender,
                                applcntMobile: _mobileController.text.trim(),
                                applcntParent:
                                    _parentNameController.text.trim(),
                                applcntPoliceStation:
                                    _nearestpliceController.text.trim(),
                                applcntState: mngctrl.state,
                                idNo: _idNoController.text,
                                applcntTehsil: _tehsilController.text.trim(),
                                applcntVillage: _villageController.text.trim(),
                                gateID: mngctrl.selectedGate?.id ?? "",
                                placeOfStay: _placeStayController.text.trim(),
                                pinCode: _localpincodeController.text.trim(),
                                residingPeriod:"${mngctrl.getPermitPrice?.validityDays??"30"}",
                                entryType: "ONLINE",
                                applcntHNo: mngctrl.applicid?.houseNo??"NA",
                                applyDistrictID: "NA",
                                category: "NA",
                                district: district.trim(),
                                landmark: "NA",
                                nearestPS: _nearestpliceController.text.trim(),
                                lrName: _localresidencename.text.trim(),
                                visitDate: DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day)
                                    .toIso8601String(),
                                purposeVisit: mngctrl.purpose == "Others"
                                    ? _visitPurposeController.text
                                    : mngctrl.purpose,
                              );

                              mngctrl.addPermit(permits);
                              controller.changePage(2);
                              controller.pageIncremeter(2);
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
                              controller.listenPageChange();
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
                      SizedBox(height: 20),
                      CustomKeyboard(
                        onKeyTap: _onKeyTap,
                        onBackspace: _onBackspace,
                        onToggle: _toggleKeyboard,
                        isAlpha: !isKeyboardnum,
                      ),
                      SizedBox(
                        height: 30,
                      )
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

  void _toggleKeyboard() {
    setState(() {}); // Just rebuild to update UI
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {String? Function(String?)? validator,
      EdgeInsets? padding,
      required FocusNode node,
      bool enabled = true,
      int? counter,
      bool iscapitalize = true,
      bool mandatory = true}) {
    return TextFieldWidget(
      controller: controller,
      label: label,
      focusnode: node,
      isCapitalise: iscapitalize,
      validator: validator,
      counter: counter,
      enable: enabled,
      mandatory: mandatory,
    );
  }

  Widget _buildDropdownFieldState(
      String label,
      List<String> items,
      String? selectedValue,
      ValueChanged<String?> onChanged,
      String? errorText) {
    return DropdownSearch<String>(
      onChanged: onChanged,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      selectedItem: selectedValue,
      
      decoratorProps: DropDownDecoratorProps(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          floatingLabelAlignment: FloatingLabelAlignment.center,
          // labelStyle:
          //     TextStyle(fontWeight: FontWeight.bold),
          // labelText: "YEAR :",
          hintText: "Select $label",
        ),
      ),
      popupProps: PopupProps.menu(
        searchDelay: Duration.zero,
        searchFieldProps: const TextFieldProps(
            autofocus: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                constraints: BoxConstraints(
                  maxHeight: 40,
                ))),
        // constraints: BoxConstraints.tight(Size(
        //     MediaQuery.of(context).size.width,
        //     MediaQuery.of(context).size.height / 2)),
        showSearchBox: true,
        showSelectedItems: true,
      ),
      items: (filter, loadProps) => items,
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
constraints: BoxConstraints(
  maxHeight: 60
),
          labelText: label,
          errorText: errorText,
          
          border: OutlineInputBorder(
          
            borderRadius: BorderRadius.circular(4),
          
          ),
        ),
        child: DropdownButtonHideUnderline(
      
          child: DropdownButton<String>(
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            hint: Text("Select $label"),
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

class TextFieldWidget extends StatefulWidget {
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
    this.mandatory = true,
    this.keytype,
    this.errorSize,
    this.isCapitalise = true,
    this.enable = true,
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
  final double? errorSize;
  final bool? isCapitalise;
  final bool? enable;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        style: TextStyle(
          fontSize: widget.fontSize,
          color: widget.enable == false ? Colors.black : null,
        ),
        focusNode: widget.focusnode,
        maxLength: widget.counter ?? 10,
    
        controller: widget.controller,
        cursorColor: Colors.black,
        readOnly: true,
        buildCounter: (context,
                {required currentLength,
                required isFocused,
                required maxLength}) =>
            SizedBox(),
        decoration: InputDecoration(
          
          enabled: widget.enable!,
          errorStyle: TextStyle(
            color: Colors.red, // Change error text color
            fontSize: widget.errorSize ?? null, // Change font size
            // fontWeight: FontWeight.bold, // Make it bold
          ),
          contentPadding: widget.contentpadding,
          labelStyle: TextStyle(fontSize: 20),
          labelText: widget.mandatory ? "* ${widget.label}" : widget.label,
          floatingLabelStyle: TextStyle(fontSize: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        ),
        inputFormatters: [UpperCaseTextFormatter()],
        validator: widget.validator ??
            (v) {
              if (v!.isEmpty) {
                return "${widget.label} is empty";
              }
              return null;
            },
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(text: newValue.text.capitalize);
  }
}
