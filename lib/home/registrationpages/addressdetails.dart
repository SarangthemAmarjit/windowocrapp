import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:form_validation/form_validation.dart';
import 'package:get/get.dart';

import '../../controller/pagecontroller.dart';
import '../../widgets/textfields.dart';


class AddressDetails extends StatefulWidget {
  const AddressDetails({super.key});

  @override
  State<AddressDetails> createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
    final _namecontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  DateTime _dob = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return   GetBuilder<PageControllers>(
      builder: (controller) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Address Details",style: TextStyle(fontSize: 30,color: Colors.green),),
                  Divider(),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(child: TextFieldWidget(hint: 'Name', controller:_namecontroller,validator: RequiredValidator(),)),
                      SizedBox(width: 20,),
                      Expanded(child: TextFieldWidget(hint:"Phone",controller: _phonecontroller,validator: PhoneNumberValidator(),)),
                    ],
                  ),
        
                                Row(
                    children: [
                      Expanded(child: TextFieldWidget(hint: 'Parent Name', controller:_namecontroller,validator: RequiredValidator(),)),
                      SizedBox(width: 20,),
                      Expanded(child: TextFieldWidget(hint:"Id Mark",controller: _phonecontroller,validator: PhoneNumberValidator(),)),
                    ],
                  ),
        
                                Row(
                              
                    children: [
                      
                  
                      Expanded(child: TextFieldWidget(hint:"Address",controller: _phonecontroller,validator: PhoneNumberValidator(),)),
                        SizedBox(width:20,),
                      Expanded(child: TextFieldWidget(hint:"Occupation",controller: _phonecontroller,validator: PhoneNumberValidator(),)),
                    ],
                  ),
        
        
                      // SizedBox(width: 20,),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                 Text(
                                                  "D.O.B",
                                                    style: TextStyle(
                                                      
                                                        fontSize: 12),
                                                  ),
                                                  SizedBox(height: 8,),
                                    Container(
                                    height: 40,
                                  clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                         border: Border.all(color: Colors.grey[900]!),
                                         borderRadius: BorderRadius.circular(8)
                                      ),
                                      child: InkWell(
                                        onTap: (){
                                          showDatePicker(context: context, firstDate: DateTime(1950), lastDate: DateTime(DateTime.now().year)).then((value) {
                                            setState(() {
                                              _dob = value!;
                                            });
                                          },);
                                    
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text("${_dob.day}/${_dob.month}/${_dob.year}"),
                                              SizedBox(width: 10,),
                                              Icon(Icons.date_range_outlined,size: 16,)
                                            ],
                                          ),
                                        ),
                                      )
                                    ),
                                  ],
                                ),
          SizedBox(width:20,),
                                Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                             Text(
                                              "Gender",
                                                style: TextStyle(
                                                  
                                                    fontSize: 12),
                                              ),
                                              SizedBox(height: 8,),
                                Container(
                                height: 40,
                                padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                     border: Border.all(color: Colors.grey[900]!),
                                     borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: DropdownButton(
                                    style: TextStyle(fontSize: 16,color: Colors.black),
                                    underline: SizedBox(),
                                    value: "Male",
                                    items: [
                                  DropdownMenuItem(value:"Male",child: Text("Male"),),
                                  DropdownMenuItem(value:"Female",child: Text("Female"),),
                                  
                                  ], onChanged:(v){}),
                                ),
                              ],
                            ),
                              ],
                            ),
                          SizedBox(height: 20,),
                            InkWell(
                              onTap: (){
                                controller.changePage(3);
                              },
                              child: Container(
                                width: double.infinity,
                                                     
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8)),clipBehavior: Clip.antiAlias,child: Center(child: Text("Next",style: TextStyle(color: Colors.white),)),),
                            ),
                ],
              ).animate().fadeIn(duration: Duration(milliseconds: 500));
      }
    );
  }
}