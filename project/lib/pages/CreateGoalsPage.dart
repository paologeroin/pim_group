import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pim_group/models/repo/app_repository.dart';
import 'package:pim_group/widgetGoals/formTilesGoals.dart';
import 'package:pim_group/widgetGoals/formSeparator.dart';
import 'package:provider/provider.dart';
import '../models/entities/goals.dart';

// This is the class that implement the page to be used to edit existing goals and add new goals.
class CreateGoalsPage extends StatefulWidget {
  final Goal? goal;

  CreateGoalsPage({Key? key, required this.goal}) : super(key: key);

  static const routeDisplayName = 'Goal\'s specification';

  @override
  State<CreateGoalsPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<CreateGoalsPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController _NameController = TextEditingController();

  TextEditingController _Controller = TextEditingController();

  @override
  void initState() {
    _NameController.text = widget.goal == null ? '' : widget.goal!.name;

    _Controller.text = widget.goal == null ? '' : widget.goal!.money.toString();

    super.initState();
  } // initState

  // here we override the dispose() method
  @override
  void dispose() {
    _NameController.dispose();
    _Controller.dispose();
    super.dispose();
  } // dispose

  @override
  Widget build(BuildContext context) {
    print('${CreateGoalsPage.routeDisplayName} built');

    return Scaffold(
      appBar:  PreferredSize(
          preferredSize: Size.fromHeight(47.0),
          child: AppBar(
              // motivational phrases for the User that change during time
              title: Center(child:
                Text("Goal Specification", style: GoogleFonts.lato()),
              ),
              backgroundColor: Color.fromARGB(255, 194, 138, 243),
              elevation: 0,
        actions: [
          IconButton(
              onPressed: () => _validateAndSave(context),
              icon: Icon(Icons.done))
        ],
      ),),
      body: Center(
        child: _buildForm(context),
      ),
      floatingActionButton: widget.goal == null
          ? null
          : FloatingActionButton(
              onPressed: () => _deleteAndPop(context),
              child: Icon(Icons.delete),
            ),
    );
  } //build

  Widget _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 8, left: 20, right: 20),
        child: ListView(
          children: <Widget>[
            FormSeparator(label: 'Goal:'),
            FormTextTile(
              labelText: "Write here your Goal",
              icon: Icons.photo_camera_front,
              controller: _NameController,
            ),
            FormSeparator(label: 'Goal\'s money:'),
            FormNumberTile(
              labelText: 'Write the sum of money to reach',
              controller: _Controller,
              icon: Icons.money,
            ),
          ],
        ),
      ),
    );
  } // _buildForm

  // method to validate and save the goal's data
  void _validateAndSave(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (widget.goal == null) {
        Goal newGoal = Goal(
            id: null,
            name: _NameController.text,
            money: double.parse(_Controller.text));
        await Provider.of<AppDatabaseRepository>(context, listen: false)
            .insertGoal(newGoal);
      } else {
        Goal updatedGoal = Goal(
            id: widget.goal!.id,
            name: _NameController.text,
            money: double.parse(_Controller.text));
        await Provider.of<AppDatabaseRepository>(context, listen: false)
            .updateGoal(updatedGoal);
      }
      Navigator.pop(context);
    }
  } // _validateAndSave

  // method used to delete the goal
  void _deleteAndPop(BuildContext context) async {
    await Provider.of<AppDatabaseRepository>(context, listen: false)
        .removeGoal(widget.goal!);
    Navigator.pop(context);
  } //_deleteAndPop
} //GoalPage
