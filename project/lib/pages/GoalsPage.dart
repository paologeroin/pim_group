import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pim_group/models/repo/app_repository.dart';
import 'package:pim_group/pages/inizializegoals.dart';
import 'package:provider/provider.dart';
import '../models/entities/goals.dart';

//Homepage screen. It will show the list of goals.
class GoalsPage extends StatelessWidget {
  GoalsPage({Key? key}) : super(key: key);

  static const routeDisplayName = 'Goals';

  @override
  Widget build(BuildContext context) {
    //Print the route display name for debugging
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
            onPressed: () => _toGoalPage(context,
                null), // se arrivo con null vuol dire che voglio creare un nuovo goal
          )
        ],
        centerTitle: true,
        title: const Text(
          GoalsPage.routeDisplayName,
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Center(
        //We are using a Consumer because we want that the UI showing
        //the list of goals to rebuild every time the Goal DB updates.
        child: Consumer<AppDatabaseRepository>(
          builder: (context, goal, child) {
            return FutureBuilder(
              initialData: null,
              future: goal.findAllGoals(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as List<Goal>;
                  //If the Goal table is empty, show a simple Text, otherwise show the list of goals using a ListView.
                  return data.length == 0
                      ? const Text('The goal list is currently empty')
                      : ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, goalIndex) {
                            //Here, we are using a Card to show a Meal
                            return Card(
                              elevation: 5,
                              child: ListTile(
                                leading: const Icon(MdiIcons.flag),
                                trailing: const Icon(MdiIcons.noteEdit),
                                title: Text(data[goalIndex].name),
                                subtitle: Text(
                                    'objective to reach: ${data[goalIndex].money} €'),
                                //When a ListTile is tapped, the user is redirected to the MealPage, where it will be able to edit it.
                                onTap: () =>
                                    _toGoalPage(context, data[goalIndex]),
                              ),
                            );
                          });
                } //if
                else {
                  return CircularProgressIndicator();
                } //else
              }, //FutureBuilder builder
            );
          },
        ),
      ),
    );
  } //build

  //Utility method to navigate to GoalPage
  void _toGoalPage(BuildContext context, Goal? goal) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CreateGoalsPage(goal: goal)));
  } //_toMealPage
} //Goalspage
