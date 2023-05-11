import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pim_group/models/goals/goalDB.dart';
import 'package:pim_group/models/goals/goalProvider.dart';
import 'package:pim_group/widgetsgoals/formTiles.dart';
import 'package:pim_group/widgetsgoals/formSeparator.dart';
import 'package:pim_group/utils/formats.dart';

//This is the class that implement the page to be used to edit existing goals and add new goals.
//This is a StatefulWidget since it needs to rebuild when the form fields change.

class CreateGoalsPage extends StatefulWidget {
  //GoalPage needs to know the index of the goal we are editing (it is equal to -1 if the goal is new)
  final int goalIndex;
  //For simplicity, even if it is not necessary, we are also passing the instance of GoalDB.
  //This choice is not mandatory and maybe redundant, but it will allow us to initialize easily the form values.
  final GoalProvider goalDB;

  //GoalPage constructor
  CreateGoalsPage({Key? key, required this.goalDB, required this.goalIndex})
      : super(key: key);

  static const routeDisplayName = 'Goal\'s specification';

  @override
  State<CreateGoalsPage> createState() => _GoalPageState();
} //GoalPage

//Class that manages the state of GoalPage
class _GoalPageState extends State<CreateGoalsPage> {
  //Form globalkey: this is required to validate the form fields.
  final formKey = GlobalKey<FormState>();

  //Variables that maintain the current form fields values in memory.

  TextEditingController _NameController =
      TextEditingController(); // this is for the name of the goal

  TextEditingController _Controller =
      TextEditingController(); // and this is for the money needed by the goal

  DateTime _selectedDate = DateTime.now();

  //Here, we are using initState() to initialize the form fields values.
  //Rationale: Goal name, money and time are not known if the goal is new (goalIndex == -1).
  //  In this case, initialize them to empty and now(), respectively, otherwise set them to the respective values.
  @override
  void initState() {
    _NameController.text = widget.goalIndex == -1
        ? ''
        : widget.goalDB.goals[widget.goalIndex].name;
    // se l'indice è uguale a -1 (vuol dire che sto inizializzando un nuovo goal)
    // inizializzo _NameController come vuoto '', altrimenti lo imposto al rispettivo valore

    _Controller.text = widget.goalIndex == -1
        ? ''
        : widget.goalDB.goals[widget.goalIndex].money.toString();
    // se l'indice è uguale a -1 (vuol dire che sto inizializzando un nuovo goal)
    // inizializzo _Controller come vuoto '', altrimenti lo imposto al rispettivo valore

    _selectedDate = widget.goalIndex == -1
        ? DateTime.now()
        : widget.goalDB.goals[widget.goalIndex].dateTime;
    // se l'indice è uguale a -1 (vuol dire che sto inizializzando un nuovo goal)
    // inizializzo _selectDate alla data di oggi, altrimenti lo imposto al rispettivo valore

    super.initState();
  } // initState

  //Form controllers need to be manually disposed. So, here we need also to override (sovrascrivere) the dispose() method.
  @override
  void dispose() {
    _NameController.dispose();
    _Controller.dispose();
    super.dispose();
  } // dispose
  // qui smaltisco i Form controllers

  // We build here the display of the initializegoals pages
  @override
  Widget build(BuildContext context) {
    //Print the route display name for debugging
    print('${CreateGoalsPage.routeDisplayName} built');

    //The page is composed of a form. An action in the AppBar is used to validate and save the information provided by the user.
    //A FAB is showed to provide the "delete" functinality. It is showed only if the goal already exists.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 109, 230, 69),
        centerTitle: true,
        title: Text(CreateGoalsPage.routeDisplayName),
        actions: [
          IconButton(
              onPressed: () => _validateAndSave(context),
              icon: Icon(Icons.done))
        ],
      ),
      body: Center(
        child: _buildForm(context),
      ),
      floatingActionButton: widget.goalIndex == -1
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
            // BISOGNA CAMBIARE COLORE ALLE ICONE DEI SEPARATORI E ALLE SCRITTE
            FormSeparator(label: 'Goal:'),
            FormTextTile(
              labelText: "Write here your Goal",
              icon: Icons.photo_camera_front, // E' L'ICONA
              controller: _NameController,
            ),
            FormSeparator(label: 'Goal\'s money:'),
            FormNumberTile(
              labelText: 'Write the sum of money to reach',
              controller: _Controller,
              icon: Icons.money,
            ),
            FormSeparator(label: 'Date your Goal was created:'),
            FormDateTile(
              labelText: 'Creation Goal time',
              date: _selectedDate,
              icon: MdiIcons.clockTimeFourOutline,
              onPressed: () {
                _selectDate(context);
              },
              dateFormat: Formats.fullDateFormatNoSeconds,
            ),
          ],
        ),
      ),
    );
  } // _buildForm

  // Utility method that implements a Date+Time picker.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: _selectedDate,
            firstDate: DateTime(2010),
            lastDate: DateTime(2101))
        .then((value) async {
      if (value != null) {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime:
              TimeOfDay(hour: _selectedDate.hour, minute: _selectedDate.minute),
        );
        return pickedTime != null
            ? value.add(
                Duration(hours: pickedTime.hour, minutes: pickedTime.minute))
            : null;
      }
      return null;
    });
    if (picked != null && picked != _selectedDate)
      //Here, we are using setState to update the _selectedDate field and rebuild the UI.
      setState(() {
        _selectedDate = picked;
      });
  } //_selectDate

  //Utility method that validate the form and, if it is valid, save the new goal information.
  void _validateAndSave(BuildContext context) {
    if (formKey.currentState!.validate()) {
      // MANCA IL FATTO CHE L'UTENTE DEVE SCRIVERE QUALCOSA NEL NOME PER ACCETTARE credo sia nelle condizioni qua
      Goal newGoal = Goal(
          name: _NameController.text,
          money: double.parse(_Controller
              .text), // We transform the date of the money from type String to type double
          dateTime: _selectedDate);
      widget.goalIndex == -1
          ? widget.goalDB.addGoal(
              newGoal) // se goalIndex è uguale a -1 credo un nuovo Goal
          : widget.goalDB.editGoal(widget.goalIndex,
              newGoal); // altrimenti vuol dire che ho editato il goal
      Navigator.pop(context);
    }
  } // _validateAndSave

  //Utility method that deletes a goal entry.
  void _deleteAndPop(BuildContext context) {
    widget.goalDB.deleteGoal(widget.goalIndex);
    Navigator.pop(context); // pop per tornare a schermata precedente
  } //_deleteAndPop
} //GoalPage
