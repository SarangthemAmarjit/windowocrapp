import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';

import '../../cons/printimages.dart';
class PaintCanvas extends StatefulWidget {
  final VoidCallback callback;

  const PaintCanvas({super.key, required this.callback});
  @override
  _PaintCanvasState createState() => _PaintCanvasState();
}

class _PaintCanvasState extends State<PaintCanvas> {
  List<Offset?> points = [];
  GlobalKey _globalKey = GlobalKey();
  final double canvasWidth = 600;
  final double canvasHeight = 400;
  void _saveAsImage() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
 
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${DateTime.now().toIso8601String().replaceAll(".","").replaceAll(":","")}signature.png');
    await file.writeAsBytes(pngBytes);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Drawing saved at: ${file.path}')),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
        WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus(); // Hide keyboard when the screen starts
    });
  }

    void _clearDrawing() {
    setState(() {

      points.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return
     GetBuilder<Imagecontroller>(
       builder: (imgcon) {
         return GetBuilder<PagenavControllers>(
           builder: (controller) {
             return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 800),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                           clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 5)
                        ]),
                    child: Column(
                      children: [
                             IconButton(onPressed: widget.callback, icon: Icon(Icons.arrow_back_ios,size: 30,color: Colors.black,)),
                              Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'Add Signatures',
                          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                             
                            Text(
                              'Write your signature inside the bounded area.',
                              style: TextStyle(fontSize: 20,),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 30,),
                        Container(
                          width: 650,
                          height: 500,
                          padding: EdgeInsets.all(32),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1,color: Colors.grey),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child:imgcon.signature!=null?Image.memory(imgcon.signature!,fit: BoxFit.contain,) : Center(
                            child: RepaintBoundary(
                              key: _globalKey,
                              child: Column(
                                children: [
                                
                                  GestureDetector(
                                                              onPanUpdate: (details) {
                                  setState(() {
                                    // Restrict drawing inside the defined canvas size
                                    if (details.localPosition.dx >= 0 &&
                                        details.localPosition.dx <= canvasWidth &&
                                        details.localPosition.dy >= 0 &&
                                        details.localPosition.dy <= canvasHeight) {
                                      points.add(details.localPosition);
                                    }
                                  });
                                                              },
                                                              onPanEnd: (details) {
                                  points.add(null);
                                                              },
                                                              child: CustomPaint(
                                  painter: _DrawingPainter(points,Size(canvasWidth, canvasHeight)),
                                  size: Size(canvasWidth, canvasHeight),
                                                              ),
                                              ),
                                ],
                              ),
                                        
                            ),
                          ),
                        ),
                             SizedBox(height: 30,),
                             Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap:
                                       points.isEmpty && imgcon.signature==null?null:(){
                                        _clearDrawing();
                                        if(imgcon.signature!=null){
                                          imgcon.retakeSignature();
                                        }
                                          controller.listenPageChange();
                                       } ,

                                      child: Container(
                                        // margin: EdgeInsets.symmetric(horizontal: 16),
                                        width: double.infinity,
                                        padding: EdgeInsets.all(32),
                                        decoration: BoxDecoration(
                                          color: points.isEmpty && imgcon.signature==null?Colors.blue[200]:Colors.blue,
                                          // borderRadius: BorderRadius.circular(8)
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.replay,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "Clear",
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 24),
                                            ),
                                          ],
                                        )),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: points.isEmpty &&  imgcon.signature==null ?null: () async {
                                            if(imgcon.signature!=null){
  controller.changePage(4);
                                        controller.listenPageChange();    
                                            }else{
                                               RenderRepaintBoundary boundary =
                                        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
                                        ui.Image image = await boundary.toImage();
                                         ByteData? byteData =
                                        await image.toByteData(format: ui.ImageByteFormat.png);
                                        Uint8List pngBytes = byteData!.buffer.asUint8List();
          
                                          //  final tempDir = await getTemporaryDirectory();
                                          //  final file = File('${tempDir.path}/${DateTime.now().toIso8601String().replaceAll(".","").replaceAll(":","")}signature.png');
                                          //  await file.writeAsBytes(pngBytes);
                                            imgcon.saveImage(pngBytes);
         
         
                                      

                                            }
                                           
                                      },
                                      child: Container(
                                        //  margin: EdgeInsets.symmetric(horizontal: 16),
                                        width: double.infinity,
                                        padding: EdgeInsets.all(32),
                                        decoration: BoxDecoration(
                                          color:points.isEmpty &&  imgcon.signature==null ?Colors.green[200]: Colors.green,
                                          //  borderRadius: BorderRadius.circular(8)
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Save & Proceed",
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 24),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            ),
                                          ],
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ).animate().fadeIn(
                                  duration: Duration(milliseconds: 1200),
                                  delay: Duration(milliseconds: 400)),
                                
                             
                            
                      ],
                    ),
                  ).animate()
                      .scaleXY(
                          begin: 0.7,
                          end: 1,
                          curve: Curves.easeInCubic,
                          duration: Duration(milliseconds: 600))
                      .fadeIn(duration: Duration(milliseconds: 500)),
                ),
              );
           }
         );
       }
     );
    
  }
}

class _DrawingPainter extends CustomPainter {
  final List<Offset?> points;

  _DrawingPainter(this.points, this.canvassize);
  final Size canvassize;
  @override
  void paint(Canvas canvas, Size size) {
        // Fill background with white
    Paint backgroundPaint = Paint()..color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(0, 0, canvassize.width, canvassize.height), backgroundPaint);
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DrawingPainter oldDelegate) => true;
}
