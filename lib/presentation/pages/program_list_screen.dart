import 'package:flutter/material.dart';
import '../../data/program_data.dart';
import '../pages/program/program_detail_page.dart';
import 'create_program_screen.dart';

/// [ProgramListScreen]
/// The primary discovery screen for users to browse, search, and filter available programs.
/// Built with responsive layouts to prevent layout overflows across different screen sizes.
class ProgramListScreen extends StatefulWidget {
  final bool isAdmin;

  const ProgramListScreen({
    super.key,
    this.isAdmin = true, // Defaults to true for testing and Admin views
  });

  @override
  State<ProgramListScreen> createState() => _ProgramListScreenState();
}

class _ProgramListScreenState extends State<ProgramListScreen>
    with SingleTickerProviderStateMixin {
  // 1. STATE VARIABLES

  /// Holds programs matching current filters/search to drive the ListView
  List<Program> _filteredPrograms = [];

  /// Current string entered in the search bar
  String _searchKeyword = '';

  /// Currently active category filter chip (Defaults to 'All')
  String _selectedCategory = 'All';

  // 2. BRAND DESIGN TOKENS

  /// Primary Brand Gradient: Red on the left sweeping to Orange on the right.
  /// Used for outlines, active states, and primary title text.
  final LinearGradient _brandGradient = const LinearGradient(
    colors: [
      Colors.redAccent, // Start color (Left)
      Colors.orangeAccent, // End color (Right)
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  /// Available categories for filtering programs horizontally
  final List<String> _categories = [
    'All',
    'Tech',
    'Database',
    'SQL',
    'Design',
    'Data',
    'Business',
    'Marketing',
    'Nature',
    'Economy',
    'Misc',
  ];

  // 3. CONTROLLERS

  /// Drives the staggered upward-slide entrance animation for the program list
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller with a smooth 800ms duration
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Populate the initial program list and trigger first animation
    _applyFilters();
  }

  @override
  void dispose() {
    _animationController
        .dispose(); // Prevent memory leaks when screen is closed
    super.dispose();
  }

  // 4. LOGIC

  /// Filters [globalPrograms] based on the search keyword and selected category tag.
  /// Refreshes the UI and triggers the list view animation upon completion.
  void _applyFilters() {
    setState(() {
      _filteredPrograms = globalPrograms.where((program) {
        // 1. Match title against keyword search (Case Insensitive)
        final matchesKeyword = program.title.toLowerCase().contains(
          _searchKeyword.toLowerCase(),
        );

        // 2. Parse comma-separated program tags safely
        final programTags = program.tag
            .toLowerCase()
            .split(',')
            .map((e) => e.trim())
            .toList();

        // 3. Check if program belongs to selected category
        final matchesCategory =
            _selectedCategory == 'All' ||
            programTags.contains(_selectedCategory.toLowerCase());

        return matchesKeyword && matchesCategory;
      }).toList();
    });

    // Reset and replay staggered entrance animation to reflect new list state
    _animationController.reset();
    _animationController.forward();
  }

  // 5. MAIN BUILDER

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFFBFBFB,
      ), // Clean, light background surface
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBFBFB),
        elevation: 0,
        // Gradient-masked title text matching brand colors
        title: ShaderMask(
          shaderCallback: (bounds) => _brandGradient.createShader(bounds),
          child: const Text(
            'Program List',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          // Admin-only action button to create new programs
          if (widget.isAdmin)
            IconButton(
              icon: const Icon(
                Icons.add_circle_outline,
                color: Colors.deepOrangeAccent,
              ),
              onPressed: () async {
                // Wait for the creation screen to pop back
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateProgramScreen(),
                  ),
                );
                // Refresh list if a new program was successfully created
                if (result == true) {
                  _applyFilters();
                }
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

            // --- SEARCH BAR SECTION ---
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) {
                  _searchKeyword = value;
                  _applyFilters(); // Real-time filtering on input change
                },
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Search programs...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 16,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFFFF6B35),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Color(0xFFE91E63),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- HORIZONTAL CATEGORY FILTER CHIPS ---
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: _categories
                    .map((category) => _buildAnimatedFilterChip(category))
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),

            // --- SECTION HEADER ---
            const Text(
              'Find any programs you like',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black87,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),

            // --- MAIN PROGRAM LISTVIEW ---
            Expanded(
              child: globalPrograms.isEmpty
                  // State 1: Entire Database is Empty
                  ? _buildEmptyState(
                      icon: Icons.event_busy,
                      message: widget.isAdmin
                          ? 'No programs found.\nClick the "+" icon to add one.'
                          : 'No programs available right now.',
                    )
                  : _filteredPrograms.isEmpty
                  // State 2: Active Search/Filter yields zero results
                  ? _buildEmptyState(
                      icon: Icons.search_off,
                      message: 'No programs match your search.',
                    )
                  // State 3: Render Data with Animations
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: _filteredPrograms.length,
                      itemBuilder: (context, index) {
                        // Calculates a staggered entrance animation curve per list item
                        final Animation<double> animation =
                            Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                parent: _animationController,
                                curve: Interval(
                                  (index / _filteredPrograms.length) * 0.5,
                                  1.0,
                                  curve: Curves.easeOutQuart,
                                ),
                              ),
                            );

                        return AnimatedBuilder(
                          animation: animation,
                          builder: (context, child) {
                            return Transform.translate(
                              // Slides up from 50px below
                              offset: Offset(0, 50 * (1 - animation.value)),
                              child: Opacity(
                                opacity: animation.value,
                                child: child,
                              ),
                            );
                          },
                          child: _buildProgramCard(_filteredPrograms[index]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // 6. UI HELPER COMPONENTS

  /// Reusable empty state UI for missing data or zero search results
  Widget _buildEmptyState({required IconData icon, required String message}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 60, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  /// Interactive category filter pill that animates when selected.
  Widget _buildAnimatedFilterChip(String label) {
    final isSelected = _selectedCategory == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = label;
          _applyFilters();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected ? _brandGradient : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
            width: 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: const Color(0xFFFF6B35).withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            else
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  /// Maps program location types ('Virtual', 'Hybrid', 'Physical') to UI icons.
  IconData _getLocationIcon(String type) {
    if (type == 'Virtual') return Icons.videocam_outlined;
    if (type == 'Hybrid') return Icons.devices_outlined;
    return Icons.location_on_outlined;
  }

  /// Constructs the primary Program Card layout.
  Widget _buildProgramCard(Program program) {
    // --- PRE-CALCULATE LIVE SPOTS ---
    int? total = program.totalSeats;
    int joined = program.joinedCount;
    Color spotsColor;
    String spotsText;

    if (total == null) {
      spotsColor = Colors.green.shade600;
      spotsText = 'No Limit';
    } else {
      int spotsLeft = total - joined;
      if (spotsLeft <= 0) {
        spotsColor = Colors.grey.shade500;
        spotsText = 'No Spots Left';
      } else {
        spotsText = '$spotsLeft Spots Left';
        double percentage = spotsLeft / total;

        // Dynamically style based on urgency (filling up)
        if (percentage >= 0.5) {
          spotsColor = Colors.green.shade600; // Plenty of room
        } else if (percentage >= 0.25) {
          spotsColor = Colors.amber.shade700; // Filling up
        } else {
          spotsColor = Colors.red.shade600; // Almost full
        }
      }
    }

    // --- PRE-CALCULATE DEADLINE SAFETY ---
    // Guarantees we never pass a null value to the Text widget
    final String deadlineText =
        (program.registrationDeadLine == null ||
            program.registrationDeadLine.toString().trim().isEmpty)
        ? 'TBA'
        : program.registrationDeadLine.toString();

    // Multi-color used for XP icon
    const LinearGradient rgbGradient = LinearGradient(
      colors: [Colors.redAccent, Colors.orangeAccent, Colors.redAccent],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    // Light two-tone gradient for premium reward outlines
    const LinearGradient lightBrandGradient = LinearGradient(
      colors: [Colors.blueAccent, Colors.lightGreenAccent],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProgramDetailPage(program: program),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: _brandGradient, //
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(2.5), // Inner gap to create the border
        child: Container(
          decoration: BoxDecoration(
            // Premium Pastel Gradient Background
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFFF3E8), // Distinct Soft Peach
                Colors.white, // Clean White center for text readability
                Color(0xFFFBE4EE), // Distinct Soft Pink
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.4, 1.0],
            ),
            borderRadius: BorderRadius.circular(14.5),
          ),
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // CARD LEFT: THUMBNAIL IMAGE
              Container(
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  // Render local file if it exists, otherwise pull from Network URL
                  child: program.imageFile != null
                      ? Image.file(
                          program.imageFile!,
                          fit: BoxFit.cover,
                          cacheWidth: 250, // Optimize memory
                        )
                      : Image.network(
                          program.imageUrl,
                          fit: BoxFit.cover,
                          cacheWidth: 250, // Optimize memory
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.image,
                                color: Colors.grey,
                                size: 25,
                              ),
                        ),
                ),
              ),
              const SizedBox(width: 12),

              // CARD RIGHT: RESPONSIVE CONTENT BLOCK
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Header Row: Title & Fee Container ---
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title masked with Brand Gradient
                        Expanded(
                          child: ShaderMask(
                            shaderCallback: (bounds) =>
                                _brandGradient.createShader(bounds),
                            child: Text(
                              program.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                                color: Colors.white,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),

                        // Fee Tag (Only render if free or fee > 0)
                        if (program.isFree || program.fee > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: program.isFree
                                  ? Colors.green.shade50
                                  : Colors.amber.shade50,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: program.isFree
                                    ? Colors.green.shade300
                                    : Colors.amber.shade300,
                              ),
                            ),
                            child: Text(
                              program.isFree
                                  ? 'FREE'
                                  : '\$${program.fee.toStringAsFixed(0)}',
                              style: TextStyle(
                                color: program.isFree
                                    ? Colors.green.shade800
                                    : Colors.amber.shade900,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                      ],
                    ),

                    // --- Speaker Data Row ---
                    if (program.speaker != null && program.speaker!.isNotEmpty)
                      Text(
                        '🧑‍💼 ${program.speaker}',
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                    const SizedBox(height: 2),

                    // --- Middle Row: Application Deadline & Live Spots ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left: Bulletproof Deadline
                        Expanded(
                          child: Text(
                            'Application Deadline: $deadlineText',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Right: Dynamic Spot Count Indicator
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.local_activity_outlined,
                              size: 12,
                              color: spotsColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              spotsText,
                              style: TextStyle(
                                color: spotsColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 3),

                    // --- Bottom Row: Rewards & Host ---
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left: Wrapping container for dynamic Rewards
                        Expanded(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 5,
                            runSpacing: 4,
                            children: [
                              if (program.offersCertificate)
                                _buildPremiumIcon(
                                  Icons.workspace_premium,
                                  const Color(0xFFD4AF37),
                                  lightBrandGradient,
                                ),
                              if (program.offersBadge)
                                _buildPremiumIcon(
                                  Icons.shield,
                                  const Color(0xFF4169E1),
                                  lightBrandGradient,
                                ),
                              if (program.offersMicroScholarships)
                                _buildPremiumIcon(
                                  Icons.school,
                                  Colors.teal,
                                  lightBrandGradient,
                                ),
                              if (program.offersLetterOfRecommendation)
                                _buildPremiumIcon(
                                  Icons.edit_document,
                                  Colors.indigo,
                                  lightBrandGradient,
                                ),
                              if (program.offersPhysicalSwags)
                                _buildPremiumIcon(
                                  Icons.redeem,
                                  Colors.redAccent,
                                  lightBrandGradient,
                                ),

                              // Custom XP Graphic Badge
                              if (program.offersXleratePoints)
                                Container(
                                  width: 20,
                                  height: 20,
                                  padding: const EdgeInsets.all(1.5),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: lightBrandGradient,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: ShaderMask(
                                        shaderCallback: (bounds) =>
                                            rgbGradient.createShader(bounds),
                                        child: const Text(
                                          'XP',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 8.5,
                                            fontWeight: FontWeight.w900,
                                            height: 1.0,

                                            shadows: [
                                              Shadow(
                                                color: Colors.white,
                                                offset: Offset(0.2, 0.2),
                                              ),
                                              Shadow(
                                                color: Colors.white,
                                                offset: Offset(-0.2, -0.2),
                                              ),
                                              Shadow(
                                                color: Colors.white,
                                                offset: Offset(0.2, -0.2),
                                              ),
                                              Shadow(
                                                color: Colors.white,
                                                offset: Offset(-0.2, 0.2),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Right: Host Text (Custom Orange-to-Red Masked Gradient)
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              Colors.orangeAccent, // Left color
                              Colors.redAccent, // Right color
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds),
                          child: Text(
                            program.host.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: Colors
                                  .white, // Must remain white to absorb gradient mask
                              height: 1.0,
                              letterSpacing: 0.5,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
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
      ),
    );
  }

  /// Helper widget that creates a uniform circular badge with an outline gradient.

  Widget _buildPremiumIcon(
    IconData icon,
    Color color,
    LinearGradient outlineGradient,
  ) {
    return Container(
      width: 20,
      height: 20,
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: outlineGradient, // Premium dual-tone edge
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white, // White core to maintain icon visibility
        ),
        child: Icon(
          icon,
          size: 11, // Properly scaled internal Icon
          color: color,
        ),
      ),
    );
  }
}
