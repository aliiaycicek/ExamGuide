import 'package:flutter/material.dart';

class ScoresScreen extends StatefulWidget {
  const ScoresScreen({super.key});

  @override
  State<ScoresScreen> createState() => _ScoresScreenState();
}

class _ScoresScreenState extends State<ScoresScreen> {
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Net Skorları'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildSubjectField('Türkçe'),
              const SizedBox(height: 16),
              _buildSubjectField('Matematik'),
              const SizedBox(height: 16),
              _buildSubjectField('Fen Bilimleri'),
              const SizedBox(height: 16),
              _buildSubjectField('Sosyal Bilimler'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    // Netleri kaydet
                  }
                },
                child: const Text('Netleri Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectField(String subject) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '$subject Net',
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Lütfen net sayısını giriniz';
        }
        return null;
      },
    );
  }
} 