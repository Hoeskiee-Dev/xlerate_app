import 'package:flutter/material.dart';

Widget taskSearchBar({
  required TextEditingController controller,
  ValueChanged<String>? onChanged,
  VoidCallback? onClear,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: StatefulBuilder(
      builder: (context, setState) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: TextField(
            controller: controller,
            textAlignVertical: TextAlignVertical.center,
            onChanged: (value) {
              setState(
                () {},
              ); // Update UI internal untuk menampilkan/menyembunyikan suffixIcon
              if (onChanged != null) onChanged(value);
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search),
              // 💡 Suffix Icon (Clear) otomatis muncul jika controller tidak kosong
              suffixIcon: controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      onPressed: () {
                        controller.clear();
                        setState(() {});
                        if (onClear != null) {
                          onClear();
                        } else if (onChanged != null) {
                          onChanged('');
                        }
                      },
                    )
                  : null,
              hintText: "Search your task here",
              hintStyle: TextStyle(color: Colors.grey.shade500),
            ),
          ),
        );
      },
    ),
  );
}
