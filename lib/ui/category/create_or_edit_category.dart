import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:realm/realm.dart';
import 'package:todo_list_app/common/common.dart';
import 'package:todo_list_app/ui/utils.enums/color_extension.dart';
import '../../entities/category_realm_entity.dart';

class CreateOrEditCategory extends StatefulWidget {
  String? categoryId;
  CreateOrEditCategory({super.key, this.categoryId});

  @override
  State<CreateOrEditCategory> createState() => _CreateOrEditCategoryState();
}

class _CreateOrEditCategoryState extends State<CreateOrEditCategory> {
  final nameCategoryTextController = TextEditingController();
  final List<Color> colorDataSource = [];
  Color? _backgroundColorSelected;
  Icon? _iconSelected;
  Color _categoryIconColor = Colors.white;

  bool get isEdit {
    return widget.categoryId != null;
  }

  @override
  void initState() {
    super.initState();

    final storagePath = Configuration.defaultRealmPath;
    print(storagePath);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (isEdit) {
        _findCategory(widget.categoryId!);
      }
    });

    colorDataSource.addAll(
      [
        Color(0xffC9CC41),
        Color(0xff66CC41),
        Color(0xff41CCA7),
        Color(0xff4181CC),
        Color(0xff41A2CC),
        Color(0xffCC8441),
        Color(0xff9741CC),
        Color(0xffCC4173),
        Color.fromARGB(255, 1, 57, 81),
        Color.fromARGB(255, 217, 90, 179),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      appBar: AppBar(
        backgroundColor: Color(0xff121212),
        elevation: 0,
        title: Text(
            isEdit
                ? "category_list_edit_category_button".tr()
                : "create_category_page_title".tr(),
            style: TextStyle(
              fontFamily: 'Lato',
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 52),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryNameField(),
            _buildCategoryChooseIconField(),
            _buildCategoryChooseBackgroundColorField(),
            _buildIconColor(),
            _buildCategoryPreview(),
            Spacer(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldTitile("category_name".tr()),
        Container(
          height: 50,
          margin: EdgeInsets.only(top: 16),
          child: TextFormField(
            controller: nameCategoryTextController,
            style: const TextStyle(
              fontFamily: 'Lato',
              color: Colors.white,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              hintText: "category_name_hint".tr(),
              hintStyle: const TextStyle(
                fontFamily: 'Lato',
                color: Color(0xffAFAFAF),
                fontSize: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Color(0Xff979797), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Color(0xff8687E7), width: 1),
              ),
            ),
            onChanged: (String? value) {
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChooseIconField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitile("category_icon".tr()),
          SizedBox(
            height: 16,
          ),
          InkWell(
              onTap: () {
                _chooseIcon();
              },
              child: Container(
                width: 154,
                height: 37,
                decoration: BoxDecoration(
                  color: Color(0xffffffff).withOpacity(0.21),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: _iconSelected != null
                      ? Center(child: _iconSelected)
                      : Text(
                          "category_choose_icon".tr(),
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: Colors.white.withOpacity(0.87),
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildCategoryChooseBackgroundColorField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitile("category_color".tr()),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 36,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final color = colorDataSource.elementAt(index);
                  final isSelected = _backgroundColorSelected == color;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _backgroundColorSelected = color;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 12),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(36 / 2),
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            )
                          : null,
                    ),
                  );
                },
                itemCount: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildIconColor() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitile("icon_color".tr()),
          SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {
              _onChooseCategoryBackgroundColor();
            },
            child: Container(
              margin: EdgeInsets.only(right: 12),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _categoryIconColor,
                borderRadius: BorderRadius.circular(36 / 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        CustomButton(
          onPressed: () {
            Navigator.pop(context);
          },
          textButton: "cancel".tr(),
          backgroundColor: Color(0xff121212),
        ),
        Spacer(),
        CustomButton(
            onPressed: () {
              _onHandleCreateOrEditCategory();
              Navigator.pop(context);
            },
            textButton: isEdit
                ? "category_list_edit_category_button".tr()
                : "create_category".tr()),
      ],
    );
  }

  Widget _buildCategoryPreview() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFieldTitile("category_preview".tr()),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: _backgroundColorSelected ?? Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _iconSelected?.icon,
                color: _categoryIconColor,
                size: 30,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              nameCategoryTextController.text,
              style: TextStyle(
                fontFamily: 'Lato',
                color: Colors.white.withOpacity(0.87),
                fontSize: 16,
              ),
            ),
          ],
        ));
  }

  Widget _buildFieldTitile(String titleLabel) {
    return Text(
      titleLabel,
      style: TextStyle(
        fontFamily: 'Lato',
        color: Colors.white.withOpacity(0.87),
        fontSize: 16,
      ),
    );
  }

  void _onHandleCreateOrEditCategory() async {
    try {
      final categoryName = nameCategoryTextController.text;
      if (categoryName.isEmpty) {
        // không làm gì cả
        _showAlerDialog('validation'.tr(), 'category_name_not_empty'.tr());
        return;
      }
      if (_iconSelected == null) {
        _showAlerDialog('validation'.tr(), 'category_icon_not_empty'.tr());
        return;
      }

      // mở real (bắt buộc) để chuẩn bị ghi dữ liệu
      var config = Configuration.local([CategoryRealmEntity.schema]);
      var realm = Realm(config);

      // nếu categoryId truyền vào không tồn tại thì tức là đang create

      // nếu có categoryId truyền vào chứng tỏ đang edit
      if (widget.categoryId != null) {
        final category = realm.find<CategoryRealmEntity>(
            ObjectId.fromHexString(widget.categoryId!));
        if (category == null)
          return;
        else {
          await realm.writeAsync(() {
            category.name = categoryName;
            category.iconCodePoint = _iconSelected?.icon?.codePoint;
            category.backgroundColorHex = _backgroundColorSelected?.toHex();
            category.iconColorHex = _categoryIconColor.toHex();
          });
        }
      } else {
        // ghi dữ liệu vào realm , hàm toHex() được định nghĩa trong file color_extension.dart
        // để chuyển color sang hex string vì realm không hỗ trợ lưu trực tiếp color
        // nếu không có hàm toHex() thì sẽ báo lỗi, và hàm này là tham khảo trên mạng
        final backgroundColorHex =
            _backgroundColorSelected?.toHex() ?? Colors.transparent.toHex();
        var category = CategoryRealmEntity(ObjectId(), categoryName,
            iconCodePoint: _iconSelected?.icon?.codePoint,
            backgroundColorHex: backgroundColorHex,
            iconColorHex: _categoryIconColor.toHex());
        // realm.write(() {
        //   realm.add(category);
        // });
        // không nên dùng vì có thể thông báo hiển thị trước khi ghi dữ liệu xong
        await realm.writeAsync(() {
          realm.add(category);
        });
      }
      if (widget.categoryId == null) {
        _showAlerDialog("success".tr(), "create_category_success_content".tr());
      } else {
        _showAlerDialog("success".tr(), "edit_category_success_content".tr());
      }
      nameCategoryTextController.clear();
      _iconSelected = null;
      _backgroundColorSelected = null;
      _categoryIconColor = Colors.white;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  void _chooseIcon() async {
    IconPickerIcon? icon = await showIconPicker(
      context,
      configuration: SinglePickerConfiguration(
        showSearchBar: true, // thanh search trong icon picker
        adaptiveDialog:
            false, // có hiện dưới dạng dialog hay không , hay là hiện full màn hình chọn icon
        showTooltips: true,
        iconPickerShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        searchComparator: (String search, IconPickerIcon icon) =>
            search
                .toLowerCase()
                .contains(icon.name.replaceAll('_', ' ').toLowerCase()) ||
            icon.name.toLowerCase().contains(search.toLowerCase()),
        // vì tên tên các icon mặc định trong flutter là dạng snake_case nên cần replace _ thành dấu cách
      ),
    );

    setState(
      () {
        _iconSelected = Icon(icon?.data, color: Colors.white, size: 30);
      },
    );
  }

  void _onChooseCategoryBackgroundColor() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ColorPicker(
                  pickerColor: _categoryIconColor,
                  onColorChanged: (Color newColor) {
                    setState(() {
                      _categoryIconColor = newColor;
                    });
                  }),
            ),
          );
        });
  }

  void _showAlerDialog(String title, String content) {
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36),
            ),
            child: AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK",
                        style:
                            TextStyle(color: Color(0xff8875FF), fontSize: 20))),
              ],
            ),
          );
        });
  }

  void _findCategory(String id) {
    final config = Configuration.local([CategoryRealmEntity.schema]);
    final realm = Realm(config);

    final category =
        realm.find<CategoryRealmEntity>(ObjectId.fromHexString(id));
    if (category != null) {
      nameCategoryTextController.text = category.name;
      if (category.iconCodePoint != null)
        _iconSelected = Icon(
            IconData(category.iconCodePoint!, fontFamily: 'MaterialIcons'),
            color: Colors.white,
            size: 30);
      if (category.backgroundColorHex != null)
        _backgroundColorSelected = HexColor(category.backgroundColorHex!);
      if (category.iconColorHex != null)
        _categoryIconColor = HexColor(category.iconColorHex!);
      setState(() {});
    } else
      return;
  }
}
