import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xlerate/domain/entities/program.dart';
import 'package:xlerate/domain/entities/saved_feedback_form.dart';
import 'package:xlerate/domain/usecases/create_program/create_program_params.dart';
import 'package:xlerate/presentation/providers/programs/add_program_provider.dart';
import 'package:xlerate/presentation/pages/feedback/create_feedback_form_screen.dart';

// ---  NEW CUSTOM SECTION IMPORTS ---
import 'widgets/sections/event_details_section.dart';
import 'widgets/sections/logistics_section.dart';
import 'widgets/sections/audience_pricing_section.dart';
import 'widgets/sections/additional_info_section.dart';
import 'widgets/sections/rewards_section.dart';
import 'widgets/sections/administration_section.dart';

class CreateProgramScreen extends ConsumerStatefulWidget {
  const CreateProgramScreen({super.key});
  @override
  ConsumerState<CreateProgramScreen> createState() =>
      _CreateProgramScreenState();
}

class _CreateProgramScreenState extends ConsumerState<CreateProgramScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _speakerController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _eligibilityController = TextEditingController();
  final TextEditingController _feeController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _skillController = TextEditingController();
  final TextEditingController _totalSeatsController = TextEditingController();
  final TextEditingController _xpAmountController = TextEditingController();
  final TextEditingController _extraRewardController = TextEditingController();

  // Event Details State
  File? _selectedImage;
  bool _createFeedback = true;
  bool _isMultiDay = false;
  bool _isFree = true;
  bool _offersCertificate = false;
  bool _offersBadge = false;
  bool _offersMicroScholarships = false;
  bool _offersLetterOfRecommendation = false;
  bool _offersPhysicalSwags = false;
  bool _offersXleratePoints = false;
  String _locationType = 'In-Person';

  // Date & Time State
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _selectedTime;
  DateTime? _registrationDeadLine;

  // Lists
  final List<String> _selectedTags = [];
  final List<String> _suggestedTags = [
    'Tech',
    'Database',
    'SQL',
    'Design',
    'AI',
    'Business',
    'Marketing',
    'Nature',
    'Economy',
  ];

  final List<String> _selectedSkills = [];
  final List<String> _suggestedSkills = [
    'Critical Thinking',
    'Creative Thinking',
    'Productivity',
    'Team Work',
    'Time Management',
  ];

  // --- Helpers ---
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
        if (_registrationDeadLine != null &&
            _registrationDeadLine!.isAfter(_startDate!))
          _registrationDeadLine = null;
        if (_endDate != null && _endDate!.isBefore(_startDate!))
          _endDate = null;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    if (_startDate == null) {
      _showErrorSnackBar('Please select a Start Date first.');
      return;
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate!,
      firstDate: _startDate!,
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _endDate = picked);
  }

  Future<void> _selectDeadline(BuildContext context) async {
    if (_startDate == null) {
      _showErrorSnackBar('Please select an Event Start Date first.');
      return;
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().isBefore(_startDate!)
          ? DateTime.now()
          : _startDate!,
      firstDate: DateTime.now(),
      lastDate: _startDate!,
    );
    if (picked != null) setState(() => _registrationDeadLine = picked);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Select Date';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString().substring(2)}';
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null)
      setState(() => _selectedImage = File(pickedFile.path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'New Program',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Picker (Kept in main file as it is unique to the header)
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    image: _selectedImage != null
                        ? DecorationImage(
                            image: FileImage(_selectedImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _selectedImage == null
                      ? Center(
                          child: Icon(
                            Icons.add_photo_alternate_outlined,
                            color: Colors.grey.shade400,
                            size: 50,
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 24),

              // --- MODULAR SECTIONS ---
              EventDetailsSection(
                titleController: _titleController,
                hostController: _hostController,
                speakerController: _speakerController,
              ),
              const SizedBox(height: 16),

              LogisticsSection(
                isMultiDay: _isMultiDay,
                startDateText: _formatDate(_startDate),
                endDateText: _formatDate(_endDate),
                locationType: _locationType,
                startTimeText: _selectedTime == null
                    ? 'Set Time'
                    : _selectedTime!.format(context),
                locationController: _locationController,
                totalSeatsController: _totalSeatsController,
                onMultiDayChanged: (val) => setState(() {
                  _isMultiDay = val;
                  if (!val) _endDate = null;
                }),
                onSelectStartDate: () => _selectStartDate(context),
                onSelectEndDate: () => _selectEndDate(context),
                onLocationTypeChanged: (val) =>
                    setState(() => _locationType = val),
                onSelectTime: () => _selectTime(context),
              ),
              const SizedBox(height: 16),

              AudiencePricingSection(
                eligibilityController: _eligibilityController,
                feeController: _feeController,
                isFree: _isFree,
                onIsFreeChanged: (val) => setState(() {
                  _isFree = val;
                  if (val) _feeController.clear();
                }),
              ),
              const SizedBox(height: 16),

              AdditionalInfoSection(
                descriptionController: _descriptionController,
                urlController: _urlController,
                tagController: _tagController,
                skillController: _skillController,
                selectedTags: _selectedTags,
                suggestedTags: _suggestedTags,
                selectedSkills: _selectedSkills,
                suggestedSkills: _suggestedSkills,
                onAddTag: (item) => setState(() => _selectedTags.add(item)),
                onRemoveTag: (item) =>
                    setState(() => _selectedTags.remove(item)),
                onAddSkill: (item) => setState(() => _selectedSkills.add(item)),
                onRemoveSkill: (item) =>
                    setState(() => _selectedSkills.remove(item)),
              ),
              const SizedBox(height: 16),

              RewardsSection(
                offersCertificate: _offersCertificate,
                offersBadge: _offersBadge,
                offersMicroScholarships: _offersMicroScholarships,
                offersLetterOfRecommendation: _offersLetterOfRecommendation,
                offersPhysicalSwags: _offersPhysicalSwags,
                offersXleratePoints: _offersXleratePoints,
                xpAmountController: _xpAmountController,
                extraRewardController: _extraRewardController,
                onCertificateChanged: (val) =>
                    setState(() => _offersCertificate = val),
                onBadgeChanged: (val) => setState(() => _offersBadge = val),
                onMicroScholarshipsChanged: (val) =>
                    setState(() => _offersMicroScholarships = val),
                onLetterChanged: (val) =>
                    setState(() => _offersLetterOfRecommendation = val),
                onSwagsChanged: (val) =>
                    setState(() => _offersPhysicalSwags = val),
                onXpChanged: (val) =>
                    setState(() => _offersXleratePoints = val),
              ),
              const SizedBox(height: 16),

              AdministrationSection(
                deadlineText: _formatDate(_registrationDeadLine),
                createFeedback: _createFeedback,
                onSelectDeadline: () => _selectDeadline(context),
                onCreateFeedbackChanged: (val) =>
                    setState(() => _createFeedback = val),
              ),
              const SizedBox(height: 40),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5E5CE6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _submitForm,
                  child: const Text(
                    'Publish Program',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Submit Logic
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      _showErrorSnackBar('Please fill out all required fields.');
      return;
    }

    if (_startDate == null ||
        _registrationDeadLine == null ||
        _selectedTime == null ||
        (_isMultiDay && _endDate == null)) {
      _showErrorSnackBar('Please ensure all Dates and Times are selected.');
      return;
    }

    SavedFeedbackForm? createdFeedbackForm;

    if (_createFeedback) {
      final result = await Navigator.push<SavedFeedbackForm>(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateFeedbackFormScreen(),
        ),
      );

      if (result == null) {
        _showErrorSnackBar('Please complete and publish the feedback form.');
        return;
      }

      createdFeedbackForm = result;
    }

    final newProgram = Program(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      host: _hostController.text.trim(),
      speaker: _speakerController.text.trim(),
      startDate: _formatDate(_startDate),
      endDate: _isMultiDay ? _formatDate(_endDate) : null,
      time: _selectedTime!.format(context),
      registrationDeadLine: _formatDate(_registrationDeadLine),
      locationType: _locationType,
      location: _locationController.text.trim(),
      tag: _selectedTags.isNotEmpty ? _selectedTags.join(', ') : 'Misc',
      skills: List.from(_selectedSkills),
      eligibility: _eligibilityController.text.trim().isEmpty
          ? 'Open to all'
          : _eligibilityController.text.trim(),
      isFree: _isFree,
      fee: _isFree ? 0.0 : double.tryParse(_feeController.text) ?? 0.0,
      offersCertificate: _offersCertificate,
      offersBadge: _offersBadge,
      offersMicroScholarships: _offersMicroScholarships,
      offersLetterOfRecommendation: _offersLetterOfRecommendation,
      offersPhysicalSwags: _offersPhysicalSwags,
      offersXleratePoints: _offersXleratePoints,
      xpAmount: _offersXleratePoints
          ? int.tryParse(_xpAmountController.text.trim())
          : null,
      extraReward: _extraRewardController.text.trim().isNotEmpty
          ? _extraRewardController.text.trim()
          : null,
      imageUrl:
          'https://picsum.photos/seed/${DateTime.now().millisecondsSinceEpoch}/600/400',
      imageFile: _selectedImage,
      totalSeats: _totalSeatsController.text.trim().isEmpty
          ? null
          : int.tryParse(_totalSeatsController.text.trim()),
      joinedCount: 0,
      url: _urlController.text.trim().isEmpty
          ? null
          : _urlController.text.trim(),
      feedbackForm: createdFeedbackForm,
    );

    final params = CreateProgramParams(program: newProgram);
    final errorMessage = await ref
        .read(addProgramProvider.notifier)
        .submitProgram(params: params);

    if (!mounted) return;

    if (errorMessage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text('Program Published Successfully!'),
            ],
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context, true);
    } else {
      _showErrorSnackBar('Failed to publish program: $errorMessage');
    }
  }
}
