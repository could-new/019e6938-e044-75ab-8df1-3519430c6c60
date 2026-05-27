import 'package:flutter/material.dart';

void main() {
  runApp(const ResumeApp());
}

class ResumeApp extends StatelessWidget {
  const ResumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume Builder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ResumeBuilderScreen(),
      },
    );
  }
}

class ResumeData {
  String name = '';
  String title = '';
  String email = '';
  String phone = '';
  String location = '';
  String photoUrl = '';
  String summary = '';
  List<Experience> experiences = [];
  List<Education> educations = [];
  List<String> skills = [];
}

class Experience {
  String company = '';
  String role = '';
  String dateRange = '';
  String description = '';
}

class Education {
  String institution = '';
  String degree = '';
  String dateRange = '';
}

class ResumeBuilderScreen extends StatefulWidget {
  const ResumeBuilderScreen({super.key});

  @override
  State<ResumeBuilderScreen> createState() => _ResumeBuilderScreenState();
}

class _ResumeBuilderScreenState extends State<ResumeBuilderScreen> {
  final _formKey = GlobalKey<FormState>();
  final ResumeData _resumeData = ResumeData();
  
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Resume'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.remove_red_eye),
            tooltip: 'Preview Resume',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResumePreviewScreen(resumeData: _resumeData),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 3) {
              setState(() {
                _currentStep += 1;
              });
            } else {
               if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResumePreviewScreen(resumeData: _resumeData),
                  ),
                );
              }
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep -= 1;
              });
            }
          },
          steps: [
            Step(
              title: const Text('Personal Details'),
              content: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    onSaved: (val) => _resumeData.name = val ?? '',
                    initialValue: _resumeData.name,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Professional Title'),
                    onSaved: (val) => _resumeData.title = val ?? '',
                    initialValue: _resumeData.title,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Photo URL'),
                    onSaved: (val) => _resumeData.photoUrl = val ?? '',
                    initialValue: _resumeData.photoUrl,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    onSaved: (val) => _resumeData.email = val ?? '',
                    initialValue: _resumeData.email,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Phone'),
                    onSaved: (val) => _resumeData.phone = val ?? '',
                    initialValue: _resumeData.phone,
                  ),
                   TextFormField(
                    decoration: const InputDecoration(labelText: 'Location'),
                    onSaved: (val) => _resumeData.location = val ?? '',
                    initialValue: _resumeData.location,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Professional Summary'),
                    maxLines: 3,
                    onSaved: (val) => _resumeData.summary = val ?? '',
                    initialValue: _resumeData.summary,
                  ),
                ],
              ),
              isActive: _currentStep >= 0,
            ),
            Step(
              title: const Text('Experience'),
              content: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _resumeData.experiences.add(Experience());
                      });
                    },
                    child: const Text('Add Experience'),
                  ),
                  ...List.generate(_resumeData.experiences.length, (index) {
                    final exp = _resumeData.experiences[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Experience ${index + 1}'),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      _resumeData.experiences.removeAt(index);
                                    });
                                  },
                                )
                              ],
                            ),
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'Company'),
                              onSaved: (val) => exp.company = val ?? '',
                              initialValue: exp.company,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'Role'),
                              onSaved: (val) => exp.role = val ?? '',
                              initialValue: exp.role,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'Date Range (e.g. 2020 - Present)'),
                              onSaved: (val) => exp.dateRange = val ?? '',
                              initialValue: exp.dateRange,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'Description'),
                              maxLines: 2,
                              onSaved: (val) => exp.description = val ?? '',
                              initialValue: exp.description,
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                ],
              ),
              isActive: _currentStep >= 1,
            ),
            Step(
              title: const Text('Education'),
              content: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _resumeData.educations.add(Education());
                      });
                    },
                    child: const Text('Add Education'),
                  ),
                  ...List.generate(_resumeData.educations.length, (index) {
                    final edu = _resumeData.educations[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Education ${index + 1}'),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      _resumeData.educations.removeAt(index);
                                    });
                                  },
                                )
                              ],
                            ),
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'Institution'),
                              onSaved: (val) => edu.institution = val ?? '',
                              initialValue: edu.institution,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'Degree'),
                              onSaved: (val) => edu.degree = val ?? '',
                              initialValue: edu.degree,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'Date Range'),
                              onSaved: (val) => edu.dateRange = val ?? '',
                              initialValue: edu.dateRange,
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                ],
              ),
              isActive: _currentStep >= 2,
            ),
             Step(
              title: const Text('Skills'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   TextFormField(
                    decoration: const InputDecoration(labelText: 'Skills (comma separated)'),
                    onSaved: (val) {
                       if (val != null && val.isNotEmpty) {
                         _resumeData.skills = val.split(',').map((e) => e.trim()).toList();
                       }
                    },
                    initialValue: _resumeData.skills.join(', '),
                  ),
                ],
              ),
              isActive: _currentStep >= 3,
            ),
          ],
        ),
      ),
    );
  }
}

class ResumePreviewScreen extends StatelessWidget {
  final ResumeData resumeData;

  const ResumePreviewScreen({super.key, required this.resumeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Preview'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (resumeData.photoUrl.isNotEmpty) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              resumeData.photoUrl,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 120,
                                height: 120,
                                color: Colors.grey[300],
                                child: const Icon(Icons.person, size: 64, color: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                resumeData.name.isEmpty ? 'Your Name' : resumeData.name,
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              if (resumeData.title.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    resumeData.title,
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 16,
                                runSpacing: 8,
                                children: [
                                  if (resumeData.email.isNotEmpty) _ContactItem(icon: Icons.email, text: resumeData.email),
                                  if (resumeData.phone.isNotEmpty) _ContactItem(icon: Icons.phone, text: resumeData.phone),
                                  if (resumeData.location.isNotEmpty) _ContactItem(icon: Icons.location_on, text: resumeData.location),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (resumeData.summary.isNotEmpty) ...[
                      const SizedBox(height: 32),
                      _SectionHeader(title: 'Professional Summary'),
                      Text(resumeData.summary, style: const TextStyle(height: 1.5)),
                    ],
                    if (resumeData.experiences.isNotEmpty) ...[
                      const SizedBox(height: 32),
                      _SectionHeader(title: 'Experience'),
                      ...resumeData.experiences.map((exp) => Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    exp.role,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ),
                                Text(exp.dateRange, style: TextStyle(color: Colors.grey[600])),
                              ],
                            ),
                            Text(exp.company, style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text(exp.description, style: const TextStyle(height: 1.4)),
                          ],
                        ),
                      )),
                    ],
                    if (resumeData.educations.isNotEmpty) ...[
                      const SizedBox(height: 32),
                      _SectionHeader(title: 'Education'),
                      ...resumeData.educations.map((edu) => Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    edu.degree,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ),
                                Text(edu.dateRange, style: TextStyle(color: Colors.grey[600])),
                              ],
                            ),
                            Text(edu.institution, style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.w500)),
                          ],
                        ),
                      )),
                    ],
                    if (resumeData.skills.isNotEmpty) ...[
                      const SizedBox(height: 32),
                      _SectionHeader(title: 'Skills'),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: resumeData.skills.map((skill) => Chip(
                          label: Text(skill),
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                          side: BorderSide.none,
                        )).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(color: Colors.grey[800])),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
