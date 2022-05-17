part of 'widgets.dart';

class DescriptionText extends StatelessWidget {
  final String desc;

  const DescriptionText({Key? key, required this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleText(
      color: Colors.grey,
      fontSize: 16,
      lineHeight: 1.8,
      text: desc,
    );
  }
}
