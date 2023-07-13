import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pim_group/models/repo/app_repository.dart';
import 'package:pim_group/pages/CreateGoalsPage.dart';
import 'package:provider/provider.dart';
import '../models/entities/entities.dart';

//Homepage screen where it show the list of goals
class GoalsPage extends StatelessWidget {
  GoalsPage({Key? key}) : super(key: key);

  static const routeDisplayName = 'Goals';

  @override
  Widget build(BuildContext context) {
    print('${GoalsPage.routeDisplayName} built');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 109, 230, 69),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_box,
              size: 30.0,
              color: Colors.white,
            ),
            onPressed: () => _toGoalPage(context, null),
          )
        ],
        centerTitle: true,
        title: const Text(
          GoalsPage.routeDisplayName,
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Center(
        child: Consumer<AppDatabaseRepository>(
          builder: (context, goal, child) {
            return FutureBuilder(
              initialData: null,
              future: goal.findAllGoals(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as List<Goal>;
                  return data.length == 0
                      ? const Text('The goal list is currently empty')
                      : ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, goalIndex) {
                            return Card(
                              elevation: 5,
                              child: ListTile(
                                leading: const Icon(MdiIcons.flag),
                                trailing: const Icon(MdiIcons.noteEdit),
                                title: Text(data[goalIndex].name),
                                subtitle: Text(
                                    'objective to reach: ${data[goalIndex].money} €'),
                                onTap: () =>
                                    _toGoalPage(context, data[goalIndex]),
                              ),
                            );
                          });
                } else {
                  return CircularProgressIndicator();
                }
              },
            );
          },
        ),
      ),
    );
  } //build

  // Method to navigate to CreateGoalsPage
  void _toGoalPage(BuildContext context, Goal? goal) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CreateGoalsPage(goal: goal)));
  } //_toGoalPage
} //Goalspage
