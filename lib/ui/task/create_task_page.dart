import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/category/category_list_page.dart';
import 'package:todo_list_app/ui/task_priority/task_priority_list_page.dart';

import '../../models/category_model.dart';
import '../utils.enums/color_extension.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _nameTaskTextController = TextEditingController();
  final _descTaskTextController = TextEditingController();
  DateTime? _dateTimeSelected;
  CategoryModel? _categorySelected;
  int? _prioritySelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 24).copyWith(top: 25, bottom: 20),
      color: const Color(0xff121212),
      child: SafeArea(
          child: Container(
        child: _buildBodyPage(),
      )),
    );
  }

  Widget _buildBodyPage() {
    return Form(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTaskNameField(),
            _buildTaskDescriptionField(),
            if (_categorySelected != null) _buildCategorySelected(),
            if (_dateTimeSelected != null) _buildDateTimeSelected(),
            if (_prioritySelected != null) _buildPrioritySelected(),
            _buildTaskActionField(),
          ]),
    );
  }

  Widget _buildTaskNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "create_task_form_name_label",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Lato",
            color: Colors.white.withOpacity(0.87),
            fontWeight: FontWeight.bold,
          ),
        ).tr(),
        Container(
          height: 50,
          margin: EdgeInsets.only(top: 16),
          child: TextFormField(
            controller: _nameTaskTextController,
            style: const TextStyle(
              fontFamily: 'Lato',
              color: Colors.white,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              hintText: "create_task_form_name_placeholder".tr(),
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

  Widget _buildTaskDescriptionField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "create_task_form_desc_label",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Lato",
              color: Colors.white.withOpacity(0.87),
              fontWeight: FontWeight.bold,
            ),
          ).tr(),
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 16),
            child: TextFormField(
              controller: _descTaskTextController,
              style: const TextStyle(
                fontFamily: 'Lato',
                color: Colors.white,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: "create_task_form_desc_placeholder".tr(),
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
      ),
    );
  }

  Widget _buildCategorySelected() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'task_category'.tr(),
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Lato",
              color: Colors.white.withOpacity(0.87),
              fontWeight: FontWeight.bold,
            ),
          ).tr(),
          Container(
            height: 91,
            margin: EdgeInsets.only(top: 16),
            child: _buildGridCategoryItem(_categorySelected!),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeSelected() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'task_time'.tr(),
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Lato",
              color: Colors.white.withOpacity(0.87),
              fontWeight: FontWeight.bold,
            ),
          ).tr(),
          SizedBox(
            width: 8,
          ),
          Container(
            padding: EdgeInsets.only(top: 3),
            child: Text(
              DateFormat('HH:mm dd/MM/yyyy').format(_dateTimeSelected!),
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Lato",
                color: Colors.white.withOpacity(0.87),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrioritySelected() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'task_priority'.tr(),
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Lato",
                color: Colors.white.withOpacity(0.87),
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff8787E7),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(children: [
                Image.asset('assets/png/flag.png'),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '$_prioritySelected',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Lato",
                    color: Colors.white.withOpacity(0.87),
                  ),
                ),
              ])),
        ],
      ),
    );
  }

  Widget _buildGridCategoryItem(CategoryModel category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: category.backgroundColorHex != null
                  ? HexColor(category.backgroundColorHex!)
                  : Colors.white,
              borderRadius: BorderRadius.circular(8),
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
    );
  }

  Widget _buildTaskActionField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        spacing: 32,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: _selectTaskTimeDialog,
            child: Image.asset("assets/png/timer.png"),
          ),
          InkWell(
            onTap: _showDialogChooseCategory,
            child: Image.asset("assets/png/tag.png"),
          ),
          InkWell(
            onTap: _showDialogChoosePriority,
            child: Image.asset("assets/png/flag.png"),
          ),
          Spacer(),
          InkWell(
            child: Image.asset("assets/png/send.png"),
          ),
        ],
      ),
    );
  }

  void _showDialogChooseCategory() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CategoryListPage();
      },
    );

    if (result != null && result is Map<String, dynamic>) {
      final categoryId = result["categoryId"];
      if (categoryId == null) return;
      final name = result["name"];
      final iconCodePoint = result["iconCodePoint"];
      final backgroundColorHex = result["backgroundColorHex"];
      final iconColorHex = result["iconColorHex"];

      final categoryModel = CategoryModel(
        id: categoryId,
        name: name,
        iconCodePoint: iconCodePoint,
        backgroundColorHex: backgroundColorHex,
        iconColorHex: iconColorHex,
      );
      setState(() {
        _categorySelected = categoryModel;
      });
    } else {}
  }

  void _showDialogChoosePriority() async {
    final result = await showDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return const TaskPriorityListPage();
      },
    );

    if (result != null && result is Map<String, dynamic>) {
      final priority = result["priority"];
      setState(() {
        _prioritySelected = priority;
      });
    }
  }

  void _selectTaskTimeDialog() async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.dark(
                primary: const Color(0xff8687E7),
                onPrimary: Colors.black,
                surface: const Color(0xff8687E7),
                onSurface: Colors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xff8687E7),
                ),
              ),
            ),
            child: child!,
          );
        });

    if (date == null) return;

    if (!context.mounted) return;

    final time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (time == null) return;

    final dateTimeSelected =
        date.copyWith(hour: time.hour, minute: time.minute, second: 0);

    setState(() {
      _dateTimeSelected = dateTimeSelected;
    });
  }
}
