import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'pdf_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Criteria PDF Generator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const CriteriaFormScreen(),
      },
    );
  }
}

class CriteriaFormScreen extends StatefulWidget {
  const CriteriaFormScreen({super.key});

  @override
  State<CriteriaFormScreen> createState() => _CriteriaFormScreenState();
}

class _CriteriaFormScreenState extends State<CriteriaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  bool _includeDate = true;
  bool _includeSignatureLine = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _generatePdf() async {
    if (_formKey.currentState!.validate()) {
      final criteria = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'includeDate': _includeDate,
        'includeSignatureLine': _includeSignatureLine,
      };

      final pdfBytes = await generatePdfBasedOnCriteria(criteria);
      
      await Printing.layoutPdf(
        onLayout: (format) async => pdfBytes,
        name: 'generated_criteria.pdf',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Criteria'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Document Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title based on your criteria';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Criteria Content',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the content';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text('Additional Criteria:', style: TextStyle(fontWeight: FontWeight.bold)),
              SwitchListTile(
                title: const Text('Include Current Date'),
                value: _includeDate,
                onChanged: (bool value) {
                  setState(() {
                    _includeDate = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Include Signature Line'),
                value: _includeSignatureLine,
                onChanged: (bool value) {
                  setState(() {
                    _includeSignatureLine = value;
                  });
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: _generatePdf,
                  child: const Text('Generate PDF from Criteria'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
