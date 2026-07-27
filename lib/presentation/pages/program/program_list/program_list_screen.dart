import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xlerate/core/error_helper.dart';
import 'package:xlerate/domain/entities/program.dart';
import 'package:xlerate/presentation/pages/program/program_list/methods/build_empty_state.dart';
import 'package:xlerate/presentation/pages/program/program_list/methods/build_program_card.dart';
import 'package:xlerate/presentation/providers/programs/programs_list_provider.dart';
import '../create_program/create_program_screen.dart';

/// [ProgramListScreen]
/// Primary discovery screen to browse, search, and filter programs from Provider.
class ProgramListScreen extends ConsumerStatefulWidget {
  final bool isAdmin;

  const ProgramListScreen({
    super.key,
    this.isAdmin = true,
  });

  @override
  ConsumerState<ProgramListScreen> createState() => _ProgramListScreenState();
}

class _ProgramListScreenState extends ConsumerState<ProgramListScreen>
    with SingleTickerProviderStateMixin {
  // 1. STATE VARIABLES
  List<Program> _filteredPrograms = [];
  String _searchKeyword = '';
  String _selectedCategory = 'All';

  // Track raw fetched programs to prevent unnecessary refiltering loops
  List<Program> _lastFetchedPrograms = [];

  // 2. BRAND DESIGN TOKENS
  final LinearGradient _brandGradient = const LinearGradient(
    colors: [
      Colors.redAccent,
      Colors.orangeAccent,
    ],
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

  // 3. CONTROLLERS
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // 4. LOGIC

  /// Filters source programs based on search keyword and selected category tag.
  void _applyFilters(List<Program> sourcePrograms) {
    final filtered = sourcePrograms.where((program) {
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

    setState(() {
      _filteredPrograms = filtered;
    });

    // Reset and replay staggered entrance animation
    _animationController.reset();
    _animationController.forward();
  }

  // 5. MAIN BUILDER

  @override
  Widget build(BuildContext context) {
    final programAsyncValue = ref.watch(programsListProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
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
              fontSize: 26,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          if (widget.isAdmin)
            IconButton(
              icon: const Icon(
                Icons.add_circle_outline,
                color: Colors.deepOrangeAccent,
              ),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateProgramScreen(),
                  ),
                );

                // Refresh provider after creating a new program
                if (result == true) {
                  ref.read(programsListProvider.notifier).refresh();
                }
              },
            ),
        ],
      ),
      body: RefreshIndicator(
        color: Colors.deepOrangeAccent,
        onRefresh: () async {
          // Trigger pull-to-refresh on Riverpod provider
          await ref.read(programsListProvider.notifier).refresh();
        },
        child: Padding(
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
                    _applyFilters(_lastFetchedPrograms);
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
                      .map((category) => buildAnimatedFilterChip(category))
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

              // --- MAIN PROGRAM LISTVIEW WITH PROVIDER DATA ---
              Expanded(
                child: programAsyncValue.when(
                  // 1. DATA STATE (FETCH SUCCESSFUL)
                  data: (fetchedPrograms) {
                    // Filter again if new network data arrives
                    if (_lastFetchedPrograms != fetchedPrograms) {
                      _lastFetchedPrograms = fetchedPrograms;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _applyFilters(fetchedPrograms);
                      });
                    }

                    if (fetchedPrograms.isEmpty) {
                      return ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          const SizedBox(height: 80),
                          buildEmptyState(
                            icon: Icons.event_busy,
                            message: widget.isAdmin
                                ? 'No programs found.\nClick the "+" icon to add one.'
                                : 'No programs available right now.',
                          ),
                        ],
                      );
                    }

                    if (_filteredPrograms.isEmpty) {
                      return ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          const SizedBox(height: 80),
                          buildEmptyState(
                            icon: Icons.search_off,
                            message: 'No programs match your search.',
                          ),
                        ],
                      );
                    }

                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      itemCount: _filteredPrograms.length,
                      itemBuilder: (context, index) {
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
                          child: buildProgramCard(
                            context,
                            _filteredPrograms[index],
                          ),
                        );
                      },
                    );
                  },

                  // 2. LOADING STATE
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepOrangeAccent,
                    ),
                  ),

                  // 3. ERROR STATE
                  error: (error, stack) => ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: 80),
                      buildEmptyState(
                        icon: Icons.error_outline,
                        message: getReadableErrorMessage(error),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 6. UI HELPER COMPONENTS
  Widget buildAnimatedFilterChip(String label) {
    final isSelected = _selectedCategory == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = label;
          _applyFilters(_lastFetchedPrograms);
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
}
