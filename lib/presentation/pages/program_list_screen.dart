import 'package:flutter/material.dart';
import 'package:xlerate/presentation/pages/program/program_detail_page.dart';
import '../../data/program_data.dart';
import 'create_program_screen.dart';
import '../pages/program/program_detail_page.dart';

class ProgramListScreen extends StatefulWidget {
  final bool isAdmin;

  const ProgramListScreen({
    super.key,
    this.isAdmin = true,
  }); // Default to true for testing

  @override
  State<ProgramListScreen> createState() => _ProgramListScreenState();
}

class _ProgramListScreenState extends State<ProgramListScreen>
    with SingleTickerProviderStateMixin {
  List<Program> _filteredPrograms = [];
  String _searchKeyword = '';
  String _selectedCategory = 'All';

  // Excelerate Brand Gradient (Orange to Magenta)
  final LinearGradient _brandGradient = const LinearGradient(
    colors: [Color(0xFFFF6B35), Color(0xFFE91E63)], // Orange to Pink/Magenta
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

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

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _applyFilters();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    setState(() {
      _filteredPrograms = globalPrograms.where((program) {
        final matchesKeyword = program.title.toLowerCase().contains(
          _searchKeyword.toLowerCase(),
        );
        final programTags = program.tag
            .toLowerCase()
            .split(',')
            .map((e) => e.trim())
            .toList();
        final matchesCategory =
            _selectedCategory == 'All' ||
            programTags.contains(_selectedCategory.toLowerCase());

        return matchesKeyword && matchesCategory;
      }).toList();
    });

    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB), // Very clean, light background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBFBFB),
        elevation: 0,

        title: ShaderMask(
          shaderCallback: (bounds) => _brandGradient.createShader(bounds),
          child: const Text(
            'Program List',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          if (widget.isAdmin)
            IconButton(
              icon: const Icon(Icons.add_circle_outline, color: Colors.black87),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateProgramScreen(),
                  ),
                );
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

            // Animated Search Bar
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
                  _applyFilters();
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
                  ), // Brand Orange
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
                    ), // Brand Pink
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

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

            Expanded(
              child: globalPrograms.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.event_busy,
                            size: 60,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.isAdmin
                                ? 'No programs found.\nClick the "+" icon to add one.'
                                : 'No programs available right now.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : _filteredPrograms.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: _filteredPrograms.length,
                      itemBuilder: (context, index) {
                        // Staggered Animation Logic
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
                    )
                  : Center(
                      child: Text(
                        'No programs match your search.',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 16,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

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
          // Applies gradient if selected, white if not
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

  IconData _getLocationIcon(String type) {
    if (type == 'Virtual') return Icons.videocam_outlined;
    if (type == 'Hybrid') return Icons.devices_outlined;
    return Icons.location_on_outlined;
  }

  Widget _buildProgramCard(Program program) {
    final dateText = program.endDate != null
        ? '${program.startDate} - ${program.endDate}'
        : '${program.startDate} at ${program.time}';

    //Live Spots Left Calculation
    int? total = program.totalSeats;
    int joined = program.joinedCount;

    Color spotsColor;
    String spotsText;

    if (total == null) {
      // Unlimited spots
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

        if (percentage >= 0.5) {
          spotsColor = Colors.green.shade600;
        } else if (percentage >= 0.25) {
          spotsColor = Colors.amber.shade700;
        } else {
          spotsColor = Colors.red.shade600;
        }
      }
    }

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
          gradient: _brandGradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(2.5),
        child: Container(
          height: 111, // Locked height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.5),
          ),
          clipBehavior: Clip.hardEdge,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 5.0,
              top: 5.0,
              right: 5.0,
              bottom: 5.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: program.imageFile != null
                              ? Image.file(
                                  program.imageFile!,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  program.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.image,
                                        color: Colors.grey,
                                        size: 25,
                                      ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: 70,
                        height: 16,
                        child: Container(
                          padding: const EdgeInsets.all(
                            1.6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.redAccent,
                                Colors.green,
                                Colors.blueAccent,
                              ], // RGB Colors!
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                4,
                              ),
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: ShaderMask(
                                shaderCallback: (bounds) =>
                                    _brandGradient.createShader(bounds),
                                child: Text(
                                  program.host,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 6),

                Opacity(
                  opacity: 0.016,
                  child: Container(
                    width: 1.6,
                    decoration: BoxDecoration(gradient: _brandGradient),
                  ),
                ),

                const SizedBox(width: 0),

                // --- MIDDLE SIDE: Title, Logistics, Spots ---
                Expanded(
                  flex: 65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) =>
                            _brandGradient.createShader(bounds),
                        child: Text(
                          program.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 19,
                            color: Colors.white,
                            height: 1.16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      const SizedBox(height: 4),

                      SizedBox(
                        height: 24,
                        child:
                            program.speaker != null &&
                                program.speaker!.isNotEmpty
                            ? Row(
                                children: [
                                  const Text(
                                    '🧑‍💼',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      program.speaker!,
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          Icon(
                            _getLocationIcon(program.locationType),
                            size: 13,
                            color: const Color(0xFFFF6B35),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            program.locationType,
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '•',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Icon(
                            Icons.calendar_month_rounded,
                            size: 13,
                            color: Colors.grey.shade700,
                          ),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              dateText,
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 4,
                      ),

                      // --- Live Spots & Deadline Row ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (program.registrationDeadLine != null &&
                              program.registrationDeadLine!.isNotEmpty)
                            Text(
                              'Application Deadline: ${program.registrationDeadLine}',
                              style: TextStyle(
                                color: Colors.red.shade500,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              ),
                            ),

                          Row(
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
                    ],
                  ),
                ),

                const SizedBox(width: 0),

                Opacity(
                  opacity: 0.016,
                  child: Container(
                    width: 1.6,
                    decoration: BoxDecoration(gradient: _brandGradient),
                  ),
                ),

                const SizedBox(width: 6),

                // --- RIGHT SIDE: Fee & Rewards ---
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 18,
                          child: Center(
                            child: program.isFree || program.fee > 0
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
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
                                        fontSize: 8.5,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),

                        const SizedBox(height: 4),

                        SizedBox(
                          height: 46,
                          child: Center(
                            child: SizedBox(
                              width: 36,
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 2,
                                runSpacing: 2,
                                children: [
                                  if (program.offersCertificate)
                                    _buildPremiumIcon(
                                      Icons.workspace_premium,
                                      const Color(0xFFD4AF37),
                                    ),
                                  if (program.offersBadge)
                                    _buildPremiumIcon(
                                      Icons.shield,
                                      const Color(0xFF4169E1),
                                    ),
                                  if (program.offersMicroScholarships)
                                    _buildPremiumIcon(
                                      Icons.school,
                                      Colors.teal,
                                    ),
                                  if (program.offersLetterOfRecommendation)
                                    _buildPremiumIcon(
                                      Icons.edit_document,
                                      Colors.indigo,
                                    ),
                                  if (program.offersPhysicalSwags)
                                    _buildPremiumIcon(
                                      Icons.redeem,
                                      Colors.redAccent,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 4),

                        // XP Amount Slot
                        SizedBox(
                          height: 16,
                          child: Center(
                            child:
                                program.offersXleratePoints &&
                                    program.xpAmount != null
                                ? Container(
                                    padding: const EdgeInsets.all(
                                      1.6,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Colors.redAccent,
                                          Colors.green,
                                          Colors.blueAccent,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 1.6,
                                        vertical: 1.6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          4,
                                        ),
                                      ),
                                      child: ShaderMask(
                                        shaderCallback: (bounds) =>
                                            _brandGradient.createShader(bounds),
                                        child: Text(
                                          '${program.xpAmount} XP',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 7.5,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for the tinted icons
  Widget _buildPremiumIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 10, color: color),
    );
  }
}
