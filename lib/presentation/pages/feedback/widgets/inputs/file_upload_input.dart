import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FileUploadInput extends StatelessWidget {
  final String? uploadedFileName;
  final Color brandOrange;
  final ValueChanged<String> onChanged;

  const FileUploadInput({
    super.key,
    required this.uploadedFileName,
    required this.brandOrange,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool isUploading = uploadedFileName == "Uploading...";

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.any,
        );

        if (result != null) {
          PlatformFile file = result.files.first;
          onChanged("Uploading...");

          await Future.delayed(const Duration(milliseconds: 500));
          onChanged(file.name);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: uploadedFileName != null && !isUploading
                ? brandOrange
                : Colors.grey.shade300,
            width: uploadedFileName != null && !isUploading ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: uploadedFileName != null && !isUploading
              ? brandOrange.withAlpha(15)
              : Colors.white,
        ),
        child: Center(
          child: Column(
            children: [
              if (isUploading)
                SizedBox(
                  height: 35,
                  width: 35,
                  child: CircularProgressIndicator(
                    color: brandOrange,
                    strokeWidth: 3,
                  ),
                )
              else
                Icon(
                  uploadedFileName != null
                      ? Icons.check_circle
                      : Icons.cloud_upload_outlined,
                  size: 35,
                  color: uploadedFileName != null ? Colors.green : brandOrange,
                ),
              const SizedBox(height: 10),
              Text(
                isUploading
                    ? "Reading file..."
                    : (uploadedFileName != null
                          ? "Attached: $uploadedFileName"
                          : "Tap to browse files"),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: uploadedFileName != null && !isUploading
                      ? Colors.black87
                      : Colors.grey.shade500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
