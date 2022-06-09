part of '../pages.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tus Notificaciones")),
      body: Column(
        children: [
          StoreCard(amount: 1, price: 4.87),
          StoreCard(amount: 5, price: 22.37),
          StoreCard(amount: 10, price: 44.76),
        ],
      ),
    );
  }
}