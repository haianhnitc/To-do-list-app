import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:todo_list_app/common/common.dart';
import 'package:todo_list_app/entities/category_realm_entity.dart';
import 'package:todo_list_app/ui/category/create_or_edit_category.dart';
import 'package:todo_list_app/ui/utils.enums/color_extension.dart';

import '../../models/category_model.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<CategoryModel> categoryListDataSource = [];
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getCategoryList();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent, body: _buildBodyPage());
  }

  Widget _buildBodyPage() {
    return Center(
      child: Container(
        height: 400,
        width: 400,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Color(0xff363636)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 6),
            _buildChooseCategoryTitle(),
            _buildGridCategoryList(),
            SizedBox(height: 15),
            _buildButons(),
          ],
        ),
      ),
    );
  }

  Widget _buildChooseCategoryTitle() {
    return Column(
      children: [
        Text("category_list_page_title",
            style: TextStyle(
              fontSize: 16,
              fontFamily: "Lato",
              color: Colors.white.withOpacity(0.87),
              fontWeight: FontWeight.bold,
            )).tr(),
        Divider(
          color: Color(0xff979797),
        ),
      ],
    );
  }

  Widget _buildGridCategoryList() {
    return Container(
      height: 270,
      width: 340,
      child: Expanded(
        child: GridView.builder(
          controller: ScrollController(),
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(top: 15),
          shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          itemCount: categoryListDataSource.length + 1,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 20),
          itemBuilder: (context, index) {
            final isFirstItem = index == 0;
            if (isFirstItem) {
              return _buildCategoryItemCreateNew();
            }
            final category = categoryListDataSource.elementAt(index - 1);
            return _buildGridCategoryItem(category);
          },
        ),
      ),
    );
  }

  Widget _buildGridCategoryItem(CategoryModel category) {
    return GestureDetector(
      onTap: () {
        _onHandleClickCategoryItem(category);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: category.backgroundColorHex != null
                    ? HexColor(category.backgroundColorHex!)
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _isEditMode ? Colors.orange : Colors.transparent,
                  width: _isEditMode ? 2 : 0,
                ),
              ),
              child: category.iconCodePoint != null
                  ? Icon(
                      IconData(category.iconCodePoint!,
                          fontFamily: 'MaterialIcons'),
                      color: category.iconColorHex != null
                          ? HexColor(category.iconColorHex!)
                          : Colors.white,
                      size: 30,
                    )
                  : null),
          SizedBox(
            height: 8,
          ),
          Text(
            category.name,
            style: TextStyle(
              fontFamily: 'Lato',
              color: Colors.white.withOpacity(0.87),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItemCreateNew() {
    return GestureDetector(
      onTap: () {
        _goToCreateCategoryPage();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Color(0xff80FFD1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.add,
                color: Color(0xff00A369),
                size: 30,
              )),
          SizedBox(
            height: 8,
          ),
          Text(
            "Create New",
            style: TextStyle(
              fontFamily: 'Lato',
              color: Colors.white.withOpacity(0.87),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 48,
            child: Center(
              child: Text(
                'cancel'.tr(),
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Colors.white.withOpacity(0.44),
                  fontSize: 16,
                ),
              ).tr(),
            ),
          ),
        ),
        Spacer(),
        CustomButton(
          onPressed: () {
            setState(() {
              _isEditMode = !_isEditMode;
            });
          },
          textButton: _isEditMode
              ? "cancel_edit_category_button".tr()
              : 'category_list_edit_category_button'.tr(),
        ),
      ]),
    );
  }

  Future<void> _getCategoryList() async {
    // lấy dữ liệu lưu trong category
    final config = Configuration.local([CategoryRealmEntity.schema]);
    final realm = Realm(config);
    // RealmResult = CategoryRealmEntity => List<CategoryRealmEntity>
    // nhưng muốn sử dụng 1 model khác
    final categories = realm.all<CategoryRealmEntity>();
    List<CategoryModel> categoryModels = categories.map((e) {
      return CategoryModel(
        id: e.id.hexString,
        name: e.name,
        iconCodePoint: e.iconCodePoint,
        backgroundColorHex: e.backgroundColorHex,
        iconColorHex: e.iconColorHex,
      );
    }).toList();

    setState(() {
      categoryListDataSource = categoryModels;
    });
  }

  void _goToCreateCategoryPage() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CreateOrEditCategory();
    }));
  }

  void _onHandleClickCategoryItem(CategoryModel category) {
    if (_isEditMode) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return CreateOrEditCategory(
          categoryId: category.id,
        );
      }));
    } else {
      Navigator.pop(context, {
        'categoryId': category.id,
        'name': category.name,
        'iconCodePoint': category.iconCodePoint,
        'backgroundColorHex': category.backgroundColorHex,
        'iconColorHex': category.iconColorHex,
      });
    }
    ;
  }
}
