import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../controller/pagecontroller.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PageControllers>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
          Row(
            children: [
              Icon(Icons.monetization_on_rounded,size: 30,color: Colors.green  ),
              SizedBox(width: 10,),
              Text("Payments",style: TextStyle(fontSize: 30,color: Colors.green),),
            ],
          ),
                      Divider(),
          SizedBox(height: 30,),
                        Center(
                          child: Container(
                           width: 350,
                           height: 500,
                           clipBehavior:Clip.antiAlias,
                           decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(16),
                           color: Colors.grey[200],
                           
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 6,
                              spreadRadius: 3,
                              color: Colors.black.withValues(alpha: 0.2)
                            )
                          ]
                           ),
                            child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                // image: DecorationImage(image: AssetImage('assets/images/bg.png')),
                                color: Colors.green,
                                gradient: LinearGradient(colors: [Colors.green,Colors.green[900]!],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight
                                )

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                   
                                    children: [
                                                    
                                      Text("Rs 2000",style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                              ),

                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                         
                                          Text("Payment Details",style: TextStyle(fontWeight: FontWeight.bold),),
                                          Divider(),
                                          SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Permit Type"),
                                              Text("Labour Permit"),
                                      
                                            ],
                                          ),
                                               SizedBox(height: 10,),
                                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("permit Validity"),
                                              Text("6 Months"),
                                      
                                            ],
                                          ),
                                               SizedBox(height: 10,),
                                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("From"),
                                              Text("22/1/2025"),
                                      
                                            ],
                                          ),
                                               SizedBox(height: 10,),
                                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                         Text("To"),
                                              Text("22/7/2025"),
                                            ],
                                          ),
                                               SizedBox(height: 10,),
                                        ],
                                      ),
                                    )),
                                InkWell(
                                  onTap: (){
                                    controller.changePage(1);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                                    width: double.infinity,
                                                         
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(8)),clipBehavior: Clip.antiAlias,child: Center(child: Text("Pay",style: TextStyle(color: Colors.white),)),),
                                ),
                            ],
                            ),
                          ),
                        ) ,


                      SizedBox(height: 10,),
                    
                        
          ],
        ).animate().fadeIn(duration: Duration(milliseconds: 500));
      }
    );
  }
}