part of '../screens/tasks_screen.dart';

class _TaskButtonWidget extends StatelessWidget {
  final TasksController controller = Get.find<TasksController>();

  final String txtMessage;
  final int currentIndex;
  final int selectedCategoryIndex;

  _TaskButtonWidget({
    required this.txtMessage,
    required this.currentIndex,
    required this.selectedCategoryIndex,
  });

  @override
  Widget build(BuildContext context) {
    Color inactiveColour = Colors.grey;
    Color activeColour = const Color.fromARGB(255, 97, 203, 101);
    var unSelectedBorder = 0.0;
    var selectedBorder = 1.5;

    final color = currentIndex == selectedCategoryIndex
        ? activeColour
        : inactiveColour;

    final border = currentIndex == selectedCategoryIndex
        ? selectedBorder
        : unSelectedBorder;

    return GestureDetector(
      onTap: () => {
        controller.updateColour(currentIndex),
        debugPrint('$currentIndex'),
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.267,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: .5),
              blurRadius: 44,
              spreadRadius: 3.3,
              offset: Offset(0, 0), // Centered glow
              blurStyle: BlurStyle.inner,
            ),
          ],
          border: Border.all(color: color, width: border),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(
              txtMessage,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
