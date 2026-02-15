part of '../screens/home_screen.dart';

class _CartWidget extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  final IconData icon;
  final RxInt number;
  final String nameCart;
  final Color? colour;

  _CartWidget({
    // super.key,
    required this.icon,
    required this.number,
    required this.nameCart,
    this.colour,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Cart Got Tapped');
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.28,
        padding: const EdgeInsets.symmetric(vertical: 12),

        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.green),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, size: 48, color: colour),
            Obx(
              () => Text(
                '$number',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              nameCart,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
