part of 'widgets.dart';

class CustomFormbuildeRTextField extends StatelessWidget {
  final String name;
  final IconData icon;
  final String placeholder;
  final bool passwordField;
  const CustomFormbuildeRTextField({
    Key? key,
    required this.name,
    required this.icon,
    required this.placeholder,
    this.passwordField = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: FormBuilderTextField(
        obscureText: passwordField,
        name: name,
        validator: FormBuilderValidators.required(),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: placeholder,
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}