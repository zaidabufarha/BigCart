import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/di/injection.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/search_history_cubit.dart';
import 'package:big_cart/features/buy/presentation/pages/category_page.dart';
import 'package:big_cart/features/buy/presentation/pages/filter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // search matches product names, so each of these finds something
  static const discoverOptions = [
    'Organic',
    'Fresh',
    'Juice',
    'Oil',
    'Avocado',
    'Baby',
    'Detergent',
  ];

  // saved on the device and cleared on sign-out
  final history = getIt<SearchHistoryCubit>()..load();

  @override
  void dispose() {
    history.close();
    super.dispose();
  }

  void _navigateToSearch(String query) {
    if (query.trim().isEmpty) return;
    history.add(query);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryPage.search(query.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20.h,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: AppColors.backgroundPrimary,
      body: Column(
        spacing: 10.h,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      _navigateToSearch(value);
                    },
                    decoration: InputDecoration(
                      fillColor: AppColors.backgroundSecondary,
                      filled: true,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.textSecondary,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.tune,
                          color: AppColors.textSecondary,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FilterPage(),
                            ),
                          );
                        },
                      ),
                      hint: Text(
                        'Search keywords..',
                        style: Fonts.paragraphRegular(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.backgroundSecondary,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Search history',
                        style: Fonts.titleBold(size: 18),
                      ),
                      TextButton(
                        onPressed: history.clear,
                        child: Text(
                          'Clear',
                          style: Fonts.label().copyWith(
                            color: Color(0xFF407EC7),
                          ),
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<SearchHistoryCubit, List<String>>(
                    bloc: history,
                    builder: (context, searches) => Wrap(
                      spacing: 10.w,
                      runSpacing: 10.h,
                      children: [
                        for (String item in searches)
                          InkWell(
                            onTap: () => _navigateToSearch(item),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              color: AppColors.backgroundPrimary,
                              child: Text(
                                item,
                                style: Fonts.label(size: 10),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // fixed suggestions, so nothing to clear
                  Text(
                    'Discover more',
                    style: Fonts.titleBold(size: 18),
                  ),
                  SizedBox(height: 10.h),
                  Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: [
                      for (String item in discoverOptions)
                        InkWell(
                          onTap: () => _navigateToSearch(item),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            color: AppColors.backgroundPrimary,
                            child: Text(
                              item,
                              style: Fonts.label(size: 10),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
