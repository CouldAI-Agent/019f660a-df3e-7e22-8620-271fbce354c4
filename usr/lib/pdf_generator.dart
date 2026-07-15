import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generatePdfBasedOnCriteria(Map<String, dynamic> criteria) async {
  final pdf = pw.Document();

  final title = criteria['title'] as String;
  final description = criteria['description'] as String;
  final includeDate = criteria['includeDate'] as bool;
  final includeSignatureLine = criteria['includeSignatureLine'] as bool;

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            if (includeDate)
              pw.Text(
                'Date: ${DateTime.now().toLocal().toString().split(' ')[0]}',
                style: const pw.TextStyle(fontSize: 12),
              ),
            if (includeDate) pw.SizedBox(height: 20),
            
            // Title
            pw.Text(
              title,
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 20),
            
            // Description exactly as entered
            pw.Text(
              description,
              style: const pw.TextStyle(fontSize: 14),
            ),
            
            if (includeSignatureLine) ...[
              pw.Spacer(),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Text('Authorized Signature: _______________________'),
            ]
          ],
        );
      },
    ),
  );

  return pdf.save();
}
