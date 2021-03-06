part of '../pages.dart';

class PendingsHomeworksOffersAcepts extends StatelessWidget {
  const PendingsHomeworksOffersAcepts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final offerServices = OffersServices();

    return Scaffold(
      body: FutureBuilder(
        future: offerServices.getUsersHomeworksPending(),
        builder: (BuildContext context,
            AsyncSnapshot<List<HomeworksModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return HomeworkCard(
                  isLogged: true,
                  homework: snapshot.data![index],
                  goTo: 'upload_homework_offered_page',
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
