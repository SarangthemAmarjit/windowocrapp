import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:form_validation/form_validation.dart';
import 'package:get/get.dart';

import '../../cons/constant.dart';
import '../../controller/managementcontroller.dart';
import '../../controller/pagecontroller.dart';
import '../../widgets/textfields.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final _namecontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _parentnamecontroller = TextEditingController();
  final _idmarkcontroller = TextEditingController();
  final _occupationcontroller = TextEditingController();
  DateTime _dob = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Managementcontroller>(builder: (managectrl) {
      return GetBuilder<PageControllers>(builder: (controller) {
        return Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text("Personal Details",style: TextStyle(fontSize: 30,color: Colors.green),),
              // Divider(),
              // SizedBox(height: 10,),
              controller.cardtype != null
                  ? Row(
                      children: [
                        Expanded(
                            child: TextFieldWidget(
                          hint: "${controller.cardtype}",
                          controller: _phonecontroller,
                          validator: PhoneNumberValidator(),
                        )),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(child: SizedBox())
                      ],
                    )
                  : SizedBox(),
              Row(
                children: [
                  Expanded(
                      child: TextFieldWidget(
                    hint: 'Name',
                    controller: _namecontroller,
                    validator: RequiredValidator(),
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: TextFieldWidget(
                    hint: "Parent Name",
                    controller: _phonecontroller,
                    validator: RequiredValidator(),
                  )),
                ],
              ),

              Row(
                children: [
                  Expanded(
                      child: TextFieldWidget(
                    hint: 'Phone',
                    controller: _phonecontroller,
                    validator: PhoneNumberValidator(),
                  )),
              
     
                ],
              ),
         
              // SizedBox(width: 20,),
              Row(
                children: [
                      Expanded(
                        child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                         Text(
                                           "Gender",
                                           style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                         ),
                                        //  SizedBox(
                                        //    height: 8,
                                        //  ),
                                         Row(
                                           children: genders
                         .map(
                           (e) => RoundCard(
                             padding: EdgeInsets.symmetric(vertical: 16,horizontal: 32),
                             color:managectrl.gender==e?Colors.green[700] : Colors.grey[300],
                             callback: (){
                               managectrl.changeGender(e);
                             },
                             child: Text(e,style: TextStyle(color:managectrl.gender==e? Colors.white:null),)),
                         )
                         .toList(),
                                         ),
                                       ],
                                     ),
                      ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "D.O.B",
                          style: TextStyle(fontSize: 16,
                          fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                            height: 60,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[900]!),
                                borderRadius: BorderRadius.circular(8)),
                            child: InkWell(
                              onTap: () {
                                showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1940),
                                        initialDate: DateTime(2000),
                                        lastDate: DateTime(DateTime.now().year+1))
                                    .then(
                                  (value) {
                                    setState(() {
                                      _dob = value!;
                                    });
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 16),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        "${_dob.day} / ${_dob.month} / ${_dob.year}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.date_range_outlined,
                                      size: 18,
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  controller.changePage(2);
                },
                child: RoundCard(
                  child: Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: Duration(milliseconds: 500));
      });
    });
  }
}

class RoundCard extends StatelessWidget {
  RoundCard({
    super.key,
    required this.child,
    this.color, this.margin, this.padding, this.callback,
  });
  final Widget child;
  final Color? color;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final VoidCallback? callback;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: AnimatedContainer(
        margin: margin??EdgeInsets.all(8),
        padding:padding?? EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: color ?? Colors.green, borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.antiAlias,
        duration: Duration(milliseconds: 700),
        child: Center(child: child),
      ),
    );
  }
}
