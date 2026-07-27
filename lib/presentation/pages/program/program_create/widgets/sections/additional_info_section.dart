import 'package:flutter/material.dart';
import '../section_card_widget.dart';
import '../inputs/validated_input_field.dart';
import '../inputs/list_manager_widget.dart';

class AdditionalInfoSection extends StatelessWidget {
  final TextEditingController descriptionController;
  final TextEditingController urlController;
  final TextEditingController tagController;
  final TextEditingController skillController;
  final List<String> selectedTags;
  final List<String> suggestedTags;
  final List<String> selectedSkills;
  final List<String> suggestedSkills;

  final Function(String) onAddTag;
  final Function(String) onRemoveTag;
  final Function(String) onAddSkill;
  final Function(String) onRemoveSkill;

  const AdditionalInfoSection({
    super.key,
    required this.descriptionController,
    required this.urlController,
    required this.tagController,
    required this.skillController,
    required this.selectedTags,
    required this.suggestedTags,
    required this.selectedSkills,
    required this.suggestedSkills,
    required this.onAddTag,
    required this.onRemoveTag,
    required this.onAddSkill,
    required this.onRemoveSkill,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCardWidget(
      title: 'ADDITIONAL INFO',
      children: [
        ValidatedInputField(
          label: 'Event Descriptions *',
          hint: 'Write a brief description...',
          maxLines: 4,
          controller: descriptionController,
          isRequired: true,
        ),
        const SizedBox(height: 16),
        ValidatedInputField(
          label: 'Event URL',
          hint: 'Enter a link for more info...',
          controller: urlController,
        ),
        const SizedBox(height: 16),
        ListManagerWidget(
          label: 'Event Tags',
          hint: 'Type or Select tags...',
          controller: tagController,
          selectedList: selectedTags,
          suggestedList: suggestedTags,
          onAdd: onAddTag,
          onRemove: onRemoveTag,
        ),
        const SizedBox(height: 16),
        ListManagerWidget(
          label: 'Skillset',
          hint: 'Add skills...',
          controller: skillController,
          selectedList: selectedSkills,
          suggestedList: suggestedSkills,
          chipColor: Colors.teal,
          onAdd: onAddSkill,
          onRemove: onRemoveSkill,
        ),
      ],
    );
  }
}
