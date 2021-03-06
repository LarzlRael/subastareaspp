part of '../widgets.dart';

class HomeworkPendingToResolve extends StatelessWidget {
  final TradeUserModel tradeUserModel;

  const HomeworkPendingToResolve({
    Key? key,
    required this.tradeUserModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          'verify_homework_resolved',
          arguments: tradeUserModel,
        );
      },
      child: Container(
        color: Colors.red,
        width: double.infinity,
        height: 140,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SimpleText(
                  text: tradeUserModel.title,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  bottom: 10,
                ),
                Row(
                  children: [
                    SimpleText(
                      text:
                          '${getDateDiff(tradeUserModel.resolutionTime).inHours < 0 ? 0 : getDateDiff(tradeUserModel.resolutionTime).inHours} horas restantes',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      bottom: 10,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
