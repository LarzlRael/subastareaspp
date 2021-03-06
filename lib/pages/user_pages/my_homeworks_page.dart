part of '../pages.dart';

class MyHomeworksPage extends StatelessWidget {
  const MyHomeworksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeworkServices = HomeworkServices();
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            automaticallyImplyLeading: false,
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Ionicons.paper_plane_outline),
                  text: "Tareas subidas",
                ),
                Tab(
                  icon: Icon(Icons.directions_transit),
                  text: "Tareas Pendientes",
                ),
                Tab(
                  icon: Icon(Icons.directions_transit),
                  text: "Tareas resueltas",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              UploadedHomeworkUser(homeworkServices: homeworkServices),
              PendingOferedPendingHomework(homeworkServices: homeworkServices),
              ResolvedHomeworkUser(homeworkServices: homeworkServices),
            ],
          ),
        ),
      ),
    );
  }
}
