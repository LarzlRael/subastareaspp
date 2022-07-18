part of 'services.dart';

class OffersServices {
  final _storage = const FlutterSecureStorage();
  Future makeOrEditOffer(
    bool edit,
    int idHomework,
    int priceOffer,
    int idOffer,
  ) async {
    final homeworkRequest = await Request.sendRequestWithToken(
        !edit ? 'POST' : 'PUT',
        !edit ? 'offer/makeOffer/$idHomework' : 'offer/editOffer/$idOffer',
        {
          'priceOffer': priceOffer,
        },
        await _storage.read(key: 'token'));

    return homeworkRequest!.body;
  }

  Future enterPendingTrade(int idOffer) async {
    final homeworkRequest = await Request.sendRequestWithToken(
        'GET',
        'trade/enterPendingTrade/$idOffer',
        {},
        await _storage.read(key: 'token'));

    print(homeworkRequest!.body);
  }

  Future uploadHomeworkResolvedFile(File file, int idOfferAcceptd) async {
    final homeworkRequest = await Request.sendRequestWithFile(
        'PUT',
        'trade/uploadResolvedHomework/$idOfferAcceptd',
        {},
        file,
        await _storage.read(key: 'token') ?? '');

    print(homeworkRequest!.body);
    return validateStatus(homeworkRequest.statusCode);
  }

  Future<List<HomeworksModel>> getUsersHomeworksPending() async {
    final uploadWithFile = await Request.sendRequestWithToken(
      'GET',
      'offer/getUsersHomeworksPending',
      {},
      await _storage.read(key: 'token') ?? '',
    );
    return homeworksModelFromJson(uploadWithFile!.body);
  }
}
