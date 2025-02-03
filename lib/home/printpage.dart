import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReceiptPreviewPage extends StatelessWidget {
  final pdf = pw.Document();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt Preview'),
      ),
      body: PdfPreview(
        build: (format) => generatePdf(format),
      ),
    );
  }

  Future<Uint8List> generatePdf(PdfPageFormat format) async {
    // Create a PDF document
    final pdf = pw.Document();

    // Add a page with the receipt layout
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat(58 * PdfPageFormat.mm, double.infinity, marginAll: 4), // 58mm width
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('MY STORE', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 4),
              pw.Text('123 Main Street', style: pw.TextStyle(fontSize: 10)),
              pw.Text('City, State, ZIP', style: pw.TextStyle(fontSize: 10)),
              pw.SizedBox(height: 8),
              pw.Divider(),
              pw.SizedBox(height: 8),
              pw.Text('Order #12345', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 4),
              pw.Text('Date: ${DateTime.now().toString()}', style: pw.TextStyle(fontSize: 10)),
              pw.SizedBox(height: 8),
              pw.Divider(),
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Item', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                  pw.Text('Qty', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                  pw.Text('Price', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.SizedBox(height: 4),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Product 1', style: pw.TextStyle(fontSize: 10)),
                  pw.Text('2', style: pw.TextStyle(fontSize: 10)),
                  pw.Text('\$10.00', style: pw.TextStyle(fontSize: 10)),
                ],
              ),
              pw.SizedBox(height: 4),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Product 2', style: pw.TextStyle(fontSize: 10)),
                  pw.Text('1', style: pw.TextStyle(fontSize: 10)),
                  pw.Text('\$5.00', style: pw.TextStyle(fontSize: 10)),
                ],
              ),
              pw.SizedBox(height: 8),
              pw.Divider(),
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                  pw.Text('\$15.00', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.SizedBox(height: 16),
              pw.Center(
                child: pw.Text('Thank you for your purchase!', style: pw.TextStyle(fontSize: 10)),
              ),
            ],
          );
        },
      ),
    );

    // Return the PDF as a byte array
    return pdf.save();
  }
}