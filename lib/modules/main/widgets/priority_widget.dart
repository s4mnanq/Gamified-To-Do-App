part of '../screens/add_task_screen.dart';

class _PriorityWidgetButton extends StatelessWidget {
  //
  final AddTaskController controller = Get.find<AddTaskController>();
  //
  final String txtMessage;
  final int currentIndex;
  final int selectedCategoryIndex;

  _PriorityWidgetButton({
    // super.key,
    required this.txtMessage,
    required this.currentIndex,
    required this.selectedCategoryIndex,
    // enum
  });

  @override
  Widget build(BuildContext context) {
    Color activeColour = const Color.fromARGB(255, 97, 203, 101);
    Color inactiveColour = Colors.white;
    var unSelectedBorder = 0.0;
    var selectedBorder = 1.5;

    final colour = currentIndex == selectedCategoryIndex
        ? activeColour
        : inactiveColour;
    final border = currentIndex == selectedCategoryIndex
        ? selectedBorder
        : unSelectedBorder;

    //  var lowColour = activeColour;
    // var mediumColour = inactiveColour;
    // var highColour = inactiveColour;
    // var borderLow = selectedBorder;
    // var borderMedium = unSelectedBorder;
    // var borderHigh = unSelectedBorder;

    return GestureDetector(
      onTap: () {
        controller.updatedColour(currentIndex);
        debugPrint('Index : $currentIndex');
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .29,
        decoration: BoxDecoration(
          border: Border.all(width: border, color: colour),
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
                color: colour,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
