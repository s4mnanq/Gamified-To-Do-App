part of '../screens/add_task_screen.dart';

class _PriorityWidgetButton extends StatelessWidget {
  //
  final String txtMessage;
  final int currentIndex;
  final int selectedCategoryIndex;
  final VoidCallback onTap;

  const _PriorityWidgetButton({
    // super.key,
    required this.txtMessage,
    required this.currentIndex,
    required this.selectedCategoryIndex,
    required this.onTap,
    // enum
  });

  @override
  Widget build(BuildContext context) {
    Color activeColor = const Color.fromARGB(255, 97, 203, 101);
    Color inactiveColor = Colors.white;
    var unSelectedBorder = 0.0;
    var selectedBorder = 1.5;

    final color = currentIndex == selectedCategoryIndex
        ? activeColor
        : inactiveColor;
    final border = currentIndex == selectedCategoryIndex
        ? selectedBorder
        : unSelectedBorder;

    return GestureDetector(
      onTap: () {
        onTap();
        debugPrint('Index : $currentIndex');
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .29,
        decoration: BoxDecoration(
          border: Border.all(width: border, color: color),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(
              txtMessage,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
