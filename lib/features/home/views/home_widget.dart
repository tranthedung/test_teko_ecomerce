part of 'home_page.dart';

Widget _buildBody(HomeCtrl controller) {
  return Column(
    children: [
      _buildProducts(controller),
    ],
  );
}

Widget _buildProducts(HomeCtrl controller) {
  return ListView.builder(
    itemBuilder: (context, index) {
      final product = controller.listProducts[index];
      return Text("data");
    },
    itemCount: 10,
  );
}
