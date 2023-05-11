import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pim_group/models/goals/goalDB.dart';
import 'package:pim_group/models/goals/goalProvider.dart';
import 'package:pim_group/pages/inizializegoals.dart';
import 'package:pim_group/utils/formats.dart';
import 'package:provider/provider.dart';

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
            onPressed: () => _toGoalPage(
                context, Provider.of<GoalProvider>(context, listen: false), -1),
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
        child: Consumer<GoalProvider>(
          builder: (context, goalDB, child) {
            //If the list of goals is empty, show a simple Text, otherwise show the list of goals using a ListView.
            return goalDB.goals.isEmpty
                ? const Text(
                    'You have no Goals now, insert one of yours Goals here')
                : ListView.builder(
                    itemCount: goalDB.goals.length,
                    itemBuilder: (context, mealIndex) {
                      //Here, I'm showing to you some new things:
                      //1. We are using the Card widget to wrap each ListTile to make the UI prettier;
                      //2. I'm using DateTime to manage dates;
                      //3. I'm using a custom DateFormats to format the DateTime (take a look at the utils/formats.dart file);
                      //4. Improving UI/UX adding a leading and a trailing to the ListTile
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          leading: Icon(MdiIcons.flag),
                          trailing: Icon(MdiIcons.noteEdit),
                          title: Text('${goalDB.goals[mealIndex].name}'),
                          subtitle: Text(
                              'objective to reach: ${goalDB.goals[mealIndex].money} €'),
                          //When a ListTile is tapped, the user is redirected to the GoalPage of the specific goal, where it will be able to edit it.
                          onTap: () => _toGoalPage(context, goalDB, mealIndex),
                        ),
                      );
                    });
          },
        ),
      ),

      //Here, we are using a FAB to let the user add new goals.
      //Rationale: I'm using -1 as goalIndex to let GoalPage know that we want to add a new goal.
      /*    floatingActionButton: FloatingActionButton(
        child: Icon(MdiIcons.plus),
        backgroundColor: Colors.green,
        onPressed: () => _toGoalPage(
            context, Provider.of<GoalProvider>(context, listen: false), -1),
      ), */
    );
  } //build

  //Utility method to navigate to GoalPage
  void _toGoalPage(BuildContext context, GoalProvider goalDB, int goalIndex) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateGoalsPage(
                  goalDB: goalDB,
                  goalIndex: goalIndex,
                )));
  } //_toGoalPage
} //Goalspage

  