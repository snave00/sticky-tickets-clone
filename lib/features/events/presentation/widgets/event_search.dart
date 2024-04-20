import 'package:flutter/material.dart';

import '../../../../../core/presentation/widgets/textfield/custom_search_text_form_field.dart';
import '../../../../../utils/constants/widget_const.dart';
import '../../../../utils/constants/string_const.dart';

class EventSearch extends StatelessWidget {
  const EventSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: PagePadding.pagePadding,
        ),
        child: CustomSearchTextFormField(
          hintText: StringConst.searchEvents,
          onChanged: (value) {},
        ),
      ),
    );
  }
}
