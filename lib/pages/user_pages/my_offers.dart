part of '../pages.dart';

class MyOffers extends StatelessWidget {
  const MyOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeworkServices = HomeworkServices();
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            automaticallyImplyLeading: false,
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Ionicons.paper_plane_outline),
                  text: "Ofertas realizadas",
                ),
                Tab(
                  icon: Icon(Icons.directions_transit),
                  text: "Ofertas recibidas",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              FutureBuilder(
                future: homeworkServices.getHomeworksByUser(),
                /* initialData: InitialData, */
                builder: (BuildContext context,
                    AsyncSnapshot<List<HomeworksModel>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return NoInformation(
                        icon: Icons.assignment,
                        message: 'No tienes ofertas realizadas',
                        showButton: true,
                        iconButton: Icons.abc,
                        onPressed: () {
                          Navigator.pushNamed(context, 'bottomNavigation');
                        },
                        buttonTitle: 'Subir Tarea',
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HomeworkCard(
                          isLogged: true,
                          homework: snapshot.data![index],
                          goTo: 'auctionPage',
                          /* homework: snapshot.data[index], */
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              const Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }

/* class OffersPage extends StatelessWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeworkServices = HomeworkServices();

    return Container(
      child: FutureBuilder(
        future: homeworkServices.getHomeworksByUser(),
        /* initialData: InitialData, */
        builder: (BuildContext context,
            AsyncSnapshot<List<HomeworksModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return HomeworkCard(
                  isLogged: true,
                  homework: snapshot.data![index],

                  /* homework: snapshot.data[index], */
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
 */
}
