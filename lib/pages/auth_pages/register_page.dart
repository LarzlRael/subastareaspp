part of '../pages.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  RegisterPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(
              bottom: 30,
              top: 20,
              left: 30.0,
              right: 30.0,
            ),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const HeaderLoginRegister(
                        headerTitle: 'Registro',
                      ),
                      /* FormBuilderTextField(
                        name: 'username',
                        validator: FormBuilderValidators.required(),
                        decoration: const InputDecoration(
                          labelText: 'Nombre de usuario',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ), */
                      const CustomFormbuildeRTextField(
                        name: 'username',
                        icon: Icons.person,
                        placeholder: 'Nombre de usuario',
                      ),
                      const CustomFormbuildeRTextField(
                        name: 'email',
                        keyboardType: TextInputType.emailAddress,
                        icon: FontAwesomeIcons.at,
                        placeholder: 'Correo electrónico',
                      ),
                      /*  FormBuilderTextField(
                        name: 'password',
                        obscureText: true,
                        validator: FormBuilderValidators.required(),
                        decoration: const InputDecoration(
                          labelText: 'Contraseña',
                          prefixIcon: Icon(
                            Icons.password_outlined,
                          ),
                        ),
                      ), */
                      const CustomFormbuildeRTextField(
                        name: 'password',
                        icon: FontAwesomeIcons.lock,
                        placeholder: 'Contraseña',
                        passwordField: true,
                      ),
                      const CustomFormbuildeRTextField(
                        name: 'password',
                        icon: FontAwesomeIcons.lock,
                        placeholder: 'Repetir contraseña',
                        passwordField: true,
                      ),
                      FormBuilderCheckbox(
                        name: 'accept_terms',
                        initialValue: false,
                        title: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Tengo mas de 18 años',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.equal(
                          true,
                          errorText:
                              'Debes marcar la casilla de confirmación para continuar',
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      LoginButton(
                        text: "Registrarse",
                        textColor: Colors.white,
                        showIcon: false,
                        onPressed: () async {
                          final validationSuccess =
                              _formKey.currentState!.validate();
                          print(_formKey.currentState!.value['username']);
                          print(_formKey.currentState!.value['password']);
                          if (validationSuccess) {
                            _formKey.currentState!.save();
                            final login = await authService.register(
                              _formKey.currentState!.value['username'],
                              _formKey.currentState!.value['email'],
                              _formKey.currentState!.value['password'],
                            );

                            if (login) {
                              Navigator.pushReplacementNamed(context, 'login');
                            } else {
                              showSimpleAlert(
                                  context, 'hubo un error en el registro');
                            }
                          }
                        },
                      ),
                      const LabelLoginRegister(
                        title: '¿Ya tienes cuenta?',
                        subtitle: 'Iniciar sesión',
                        route: 'login',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
