import 'package:flutter/material.dart';

// This screen should display a list of programs available for the user to select from, when the user clicks on Browse Programs from the Dashboard Screen.

class Program {
  final String title;
  final String description;
  final String host;
  final String date;
  final String time;
  final String tag;
  final String imageUrl;

  Program({
    required this.title,
    required this.description,
    required this.host,
    required this.date,
    required this.time,
    required this.tag,
    required this.imageUrl,
  });
}

// I am using a StatefulWidget here so that the screen updates when the user search.

class ProgramListScreen extends StatefulWidget {
  final bool isAdmin;

  // I have set the default value of isAdmin to true for testing purposes. You can change it to false when you integrate with the actual user data.

  const ProgramListScreen({Key? key, this.isAdmin = true}) : super(key: key);
  //  const ProgramListScreen({Key? key, this.isAdmin = false}) : super(key: key);

  @override
  State<ProgramListScreen> createState() => _ProgramListScreenState();
}

class _ProgramListScreenState extends State<ProgramListScreen> {
  // 2. Let this be the mock data representing the Excelerate programs or the workshops that the user can select from.

  final List<Program> _allPrograms = [
    Program(
      title: 'UI/UX Masterclass',
      description: 'Learn Figma basics.',
      host: 'Alex Uzbek, B.Cs.',
      date: 'Monday, Oct 12, 2026',
      time: '10:00 AM',
      tag: 'Design',
      imageUrl: 'image url to be added',
    ),
    Program(
      title: 'Leadership Workshop',
      description: 'Lead with empathy and vision.',
      host: 'Ferry Gunawan, CEO',
      date: 'Sunday, Oct 18, 2026',
      time: '09:00 AM',
      tag: 'Business',
      imageUrl: 'image url to be added',
    ),
    Program(
      title: 'Flutter for Beginners',
      description: 'Build your first Flutter app.',
      host: 'Bishvajit Kumar, Junior Developer',
      date: 'Thursday, Oct 15, 2026',
      time: '02:00 PM',
      tag: 'Tech',
      imageUrl: 'image url to be added  ',
    ),
    Program(
      title: 'Data Analytics 101',
      description: 'Intro to Python',
      host: 'Augustine Chidera, Data Scientist',
      date: 'Tuesday, Oct 20, 2026',
      time: '03:00 PM',
      tag: 'Data',
      imageUrl: 'image url to be added',
    ),
    Program(
      title: 'Digital Marketing Strategies',
      description: 'Learn SEO and social media marketing.',
      host: 'Harini Duggirala, Marketing Expert',
      date: 'Thursday, Oct 22, 2026',
      time: '01:00 PM',
      tag: 'Marketing',
      imageUrl: 'image url to be added',
    ),
    Program(
      title: 'AI & Machine Learning',
      description: 'Basics of AI and ML.',
      host: 'Emmanueal Nyarkotey, AI Specialist',
      date: 'Sunday, Oct 25, 2026',
      time: '11:00 AM',
      tag: 'Tech',
      imageUrl: 'image url to be added',
    ),
    Program(
      title: 'Eco-Friendly Tech Solutions',
      description: 'Building sustainable hardware.',
      host: 'Bhavitha Sree K, Environmental Engineer',
      date: 'Monday, Nov 02, 2026',
      time: '10:00 AM',
      tag: 'Nature',
      imageUrl: 'image url to be added',
    ),
    Program(
      title: 'Global Economy Trends',
      description: 'Analyzing the 2026 financial markets.',
      host: 'Joan Gils, Economist',
      date: 'Thursday, Nov 05, 2026',
      time: '02:00 PM',
      tag: 'Economy',
      imageUrl: 'image url to be added',
    ),
    Program(
      title: 'Advanced State Management',
      description: 'Deep dive into Riverpod & Bloc.',
      host: 'Michael Ankomah, Senior Flutter Developer',
      date: 'Tuesday, Nov 10, 2026',
      time: '04:00 PM',
      tag: 'Tech',
      imageUrl: 'image url to be added',
    ),
    Program(
      title: 'Public Speaking for Introverts',
      description: 'Master the stage with confidence.',
      host: 'Murli Kumar Pandit, Communication Coach',
      date: 'Sunday, Nov 15, 2026',
      time: '09:00 AM',
      tag: 'Business',
      imageUrl: 'image url to be added',
    ),
  ];

  // This list will change when the user starts typing in the search bar.

  List<Program> _filteredPrograms = [];
  String _searchKeyword = '';
  String _selectedCategory = 'All';

  // Initially all programs are displayed.

  final List<String> _categories = [
    'All',
    'Tech',
    'Design',
    'Data',
    'Business',
    'Marketing',
    'Nature',
    'Economy',
  ];

  @override
  void initState() {
    super.initState();
    _filteredPrograms = _allPrograms;
  }

  // This code will handle the search logic.

  void _applyFilters() {
    setState(() {
      _filteredPrograms = _allPrograms.where((program) {
        final matchesKeyword = program.title.toLowerCase().contains(
          _searchKeyword.toLowerCase(),
        );
        final matchesCategory =
            _selectedCategory == 'All' || program.tag == _selectedCategory;

        return matchesKeyword && matchesCategory;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic material design visual layout structure for the screen.

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            size: 20,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          'Program List',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          if (widget.isAdmin)
            IconButton(
              icon: const Icon(Icons.add_circle_outline, color: Colors.black54),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Navigate to Create Program Screen'),
                  ),
                );
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // Search Bar for filtering programs.
            TextField(
              onChanged: (value) {
                _searchKeyword = value;
                _applyFilters();
              },
              decoration: InputDecoration(
                hintText: 'search any events/programs...',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
              ),
            ),
            const SizedBox(height: 16),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((category) {
                  return _buildFilterChip(category);
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Find any programs you like',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            // Scrollable list of programs.
            Expanded(
              child: _filteredPrograms.isNotEmpty
                  ? ListView.builder(
                      itemCount: _filteredPrograms.length,
                      itemBuilder: (context, index) {
                        return _buildProgramCard(_filteredPrograms[index]);
                      },
                    )
                  : const Center(
                      child: Text('No programs found in this category.'),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Interactive Chip Builder

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedCategory == label;

    return GestureDetector(
      onTap: () {
        _selectedCategory = label;
        _applyFilters();
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blueAccent.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.blueAccent : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.blueAccent : Colors.grey.shade600,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Program Card

  Widget _buildProgramCard(Program program) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opening ${program.title} details...')),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with slighly rounded corners
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                program.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),

            // Text Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    program.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    program.host,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${program.date} at ${program.time}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        program.tag,
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
