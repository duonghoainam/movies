
import 'package:flutter/material.dart';
import 'package:movies/core/constant/color.dart';
class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _textController = TextEditingController();
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Form(
      child: Row(
        children: [
          TextFormField(
            controller: _textController,
            cursorColor: AppColors.white,
            style: textTheme.bodyLarge,
            onChanged: (value) {},
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.white,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.white,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: AppColors.white,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  _textController.text = '';
                },
                child: const Icon(
                  Icons.clear_rounded,
                  color: AppColors.white,
                ),
              ),
              hintText: 'Find your movie...',
              hintStyle: textTheme.bodyLarge,
            ),
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.grid_view_rounded))
        ],
      ),
    );
  }
}
