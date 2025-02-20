import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/common/common.dart';

class TaskPriorityListPage extends StatefulWidget {
  const TaskPriorityListPage({super.key});

  @override
  State<TaskPriorityListPage> createState() => _TaskPriorityListPageState();
}

class _TaskPriorityListPageState extends State<TaskPriorityListPage> {
  final List<int> priorityListDataSource =
      List.generate(20, (index) => index + 1);
  int? _selectedPriority;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent, body: _buildBodyPage());
  }

  Widget _buildBodyPage() {
    return Center(
      child: Container(
        height: 400,
        width: 420,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Color(0xff363636)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 6),
            _buildChoosePriorityTitle(),
            _buildGridPriorityList(),
            SizedBox(
              height: 15,
            ),
            _buildButons(),
          ],
        ),
      ),
    );
  }

  Widget _buildChoosePriorityTitle() {
    return Column(
      children: [
        Text('priority_list_page_title'.tr(),
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

  Widget _buildGridPriorityList() {
    return Container(
      height: 270,
      width: 340,
      child: Expanded(
        child: GridView.builder(
          controller: ScrollController(),
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(top: 15),
          shrinkWrap: true,
          itemCount: priorityListDataSource.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 13, crossAxisSpacing: 13),
          itemBuilder: (context, index) {
            final priority = priorityListDataSource.elementAt(index);
            return _buildGridPriorityItem(priority);
          },
        ),
      ),
    );
  }

  Widget _buildGridPriorityItem(int priority) {
    final isSelected = priority == _selectedPriority;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPriority = priority;
        });
      },
      child: Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Color(0xff8687E7) : Color(0xff272727),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/png/flag.png'),
            SizedBox(
              height: 5,
            ),
            Text(
              '${priority}',
              style: TextStyle(
                fontFamily: 'Lato',
                color: Colors.white.withOpacity(0.87),
                fontSize: 16,
              ),
            ),
          ],
        ),
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
            Navigator.pop(context, {
              'priority': _selectedPriority,
            });
          },
          textButton: 'save'.tr(),
        ),
      ]),
    );
  }
}
