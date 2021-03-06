part of '../pages.dart';

class MakeOfferPage extends StatefulWidget {
  const MakeOfferPage({Key? key}) : super(key: key);

  @override
  State<MakeOfferPage> createState() => _MakeOfferPageState();
}

class _MakeOfferPageState extends State<MakeOfferPage> {
  TextEditingController textController = TextEditingController();
  bool editing = false;

  late SocketService socketService;
  late Offer? getUserOffer;
  late bool getFindUserOffer = false;
  @override
  void initState() {
    socketService = Provider.of<SocketService>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final argumets =
        ModalRoute.of(context)!.settings.arguments as OneHomeworkModel;
    final auth = Provider.of<AuthServices>(context, listen: false);
    final verifyUserOfferted =
        argumets.offers.map((item) => item.user.id).contains(auth.user.id);

    if (verifyUserOfferted) {
      getUserOffer =
          argumets.offers.firstWhere((item) => item.user.id == auth.user.id);
      getFindUserOffer = true;
    }
    final blocHomework = OneHomeworkBloc();
    return Scaffold(
      appBar: AppBar(
        /* title: Text('Hacer oferta'), */
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              showProfileImage(
                argumets.homework.user.profileImageUrl,
                argumets.homework.user.username,
                radius: 75,
              ),
              SimpleText(
                top: 25,
                bottom: 25,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                text: argumets.homework.user.username,
                /* color: Colors.grey, */
              ),
              argumets.homework.description != null
                  ? DescriptionText(
                      desc: argumets.homework.description!,
                      textAlign: TextAlign.center,
                      despegable: false,
                    )
                  : Container(),
              /* TimerCounter(
                endTime: DateTime.now().millisecondsSinceEpoch + 2000 * 30,
              ), */

              verifyUserOfferted
                  ? SimpleText(
                      text:
                          'Tu oferta es de ${getUserOffer!.priceOffer} puntos',
                      top: 15,
                      bottom: 15,
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                    )
                  : const SizedBox(
                      height: 10,
                    ),
              const SimpleText(
                text: 'Precio',
                top: 15,
                bottom: 15,
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
              Container(
                color: Colors.grey[200],
                width: MediaQuery.of(context).size.width * 0.7,
                child: SimpleText(
                  text: '${argumets.homework.offeredAmount}',
                  textAlign: TextAlign.center,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: verifyUserOfferted
                    ? verifyUserOfferted && getUserOffer!.edited
                        ? Container()
                        : ButtonWithIcon(
                            verticalPadding: 15,
                            onPressed: () {
                              showOfferDialog(
                                blocHomework,
                                argumets.homework.id,
                                verifyUserOfferted,
                                amount: getUserOffer!.priceOffer,
                                idOffer: getUserOffer!.id,
                              );
                              /* Navigator.pop(context); */
                            },
                            label: verifyUserOfferted
                                ? 'Editar oferta'
                                : 'Hacer oferta',
                            icon: Icons.send,
                            /* marginVertical: 10, */
                          )
                    : ButtonWithIcon(
                        verticalPadding: 15,
                        onPressed: () {
                          showOfferDialog(
                            blocHomework,
                            argumets.homework.id,
                            verifyUserOfferted,
                            amount: argumets.homework.offeredAmount,
                            idOffer: 0,
                          );
                          /* Navigator.pop(context); */
                        },
                        label: verifyUserOfferted
                            ? 'Editar oferta'
                            : 'Hacer oferta',
                        icon: Icons.send,
                        /* marginVertical: 10, */
                      ),
              ),
              verifyUserOfferted && getUserOffer!.edited
                  ? const SimpleText(
                      text: 'Ya has editado tu oferta',
                      top: 15,
                      bottom: 15,
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                    )
                  : const SizedBox(
                      height: 10,
                    ),
              verifyUserOfferted
                  ? ButtonWithIcon(
                      verticalPadding: 15,
                      onPressed: () async {
                        final deletedOffer = await blocHomework.deleteOffer(
                            argumets.homework.id, getUserOffer!.id);
                        socketService.emit('deleteOffer', {
                          'room': argumets.homework.id,
                          'offer': deletedOffer,
                        });
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      label: 'Retirar oferta',
                      backgroundColorButton: Colors.red,
                      icon: Icons.delete,

                      /* marginVertical: 10, */
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  showOfferDialog(
    OneHomeworkBloc blocHomework,
    int idHomework,
    bool verify, {
    int amount = 0,
    int idOffer = 0,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        bool isLoading = false;
        final formKey = GlobalKey<FormState>();
        int emailField = 0;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20.0,
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.only(
                top: 10.0,
              ),
              title: const SimpleText(
                text: "Hacer oferta",
                fontSize: 24.0,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
              ),
              content: SizedBox(
                height: 300,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Ingrese cantidad ",
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: formKey,
                          child: TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            initialValue: verify ? amount.toString() : '',
                            decoration: const InputDecoration(
                                labelText: 'Ingrese su oferta'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'La oferta es requerida';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) => emailField = int.parse(value!),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: !isLoading
                              ? () async {
                                  if (!formKey.currentState!.validate()) return;
                                  formKey.currentState!.save();
                                  setState(() {
                                    isLoading = true;
                                  });

                                  final newOffer =
                                      await blocHomework.makeOrEditOffer(
                                    verify,
                                    idHomework,
                                    emailField,
                                    idOffer,
                                  );
                                  //TODO emitir evento para actualizar la lista de ofertas
                                  socketService.emit(
                                      idOffer == 0
                                          ? 'makeOfferToServer'
                                          : 'editOffer',
                                      {
                                        'room': idHomework,
                                        'offer': newOffer,
                                      });
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            // fixedSize: Size(250, 50),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  !verify ? "Ofertar" : "Editar oferta",
                                ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const SimpleText(text: 'Nota: '),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SimpleText(
                          text:
                              'Solo puedes editar tu oferta una vez, si quieres cambiarla, debes eliminar esta oferta y hacer una nueva oferta',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
