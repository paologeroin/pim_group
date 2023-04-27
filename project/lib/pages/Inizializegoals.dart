import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pim_group/models/goal.dart';
import 'package:pim_group/models/goalDB.dart';
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
  final GoalDB goalDB;

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
  TextEditingController _NameController = TextEditingController();

  TextEditingController _Controller = TextEditingController();
  // TextEditingController _NameController = TextEditingController(); // SERVE UN METODO PER CONTROLLARE IL NOME DELL'OBIETTIVO
  DateTime _selectedDate = DateTime.now();

  //Here, we are using initState() to initialize the form fields values.
  //Rationale: Goal name, money and time are not known is the goal is new (goalIndex == -1).
  //  In this case, initilize them to empty and now(), respectively, otherwise set them to the respective values.
  @override
  void initState() {
    _NameController.text = widget.goalIndex == -1
        ? ''
        : widget.goalDB.goals[widget.goalIndex]
            .name; // CORRETTO ORA CREDO VADA, SERVE PER CORREGGERE CASELLA DI TESTO POI

    _Controller.text = widget.goalIndex == -1
        ? ''
        : widget.goalDB.goals[widget.goalIndex].money.toString();

    _selectedDate = widget.goalIndex == -1
        ? DateTime.now()
        : widget.goalDB.goals[widget.goalIndex].dateTime;

    super.initState();
  } // initState

  //Form controllers need to be manually disposed. So, here we need also to override the dispose() method.
  @override
  void dispose() {
    _NameController.dispose();
    _Controller.dispose();
    super.dispose();
  } // dispose

// FINO QUA OKAY QUA COSTRUIAMO LA PAGINA ORA
  @override
  Widget build(BuildContext context) {
    //Print the route display name for debugging
    print('${CreateGoalsPage.routeDisplayName} built');

    //The page is composed of a form. An action in the AppBar is used to validate and save the information provided by the user.
    //A FAB is showed to provide the "delete" functinality. It is showed only if the goal already exists.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
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

  //Utility method used to build the form.
  //Here, I'm showing to you how to do some new things:
  //1. How to actually implement a Form;
  //2. Define custom-made FormTiles (take a look at the widgets/formSeparator.dart and widgets/formTiles.dart files);
  //3. How to implement a Date+Time picker (take a look at the _selectDate utility method).
  Widget _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 8, left: 20, right: 20),
        child: ListView(
          children: <Widget>[
            // NON RIESCO A CAMBIARE IL COLORE DEI SEPARATORI QUA
            FormSeparator(
                label:
                    'Goal:'), // MANCA IL FATTO CHE L'UTENTE DEVE PER FORZA SCRIVERE QUALCOSA ALTRIMENTI NON VA
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Write here your Goal",
                fillColor: Colors.green,
                prefixIcon: Icon(Icons.photo_camera_front), // E' L'ICONA
              ),
              cursorColor: Colors.green,
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

  // APPOSTO
  //Utility method that implements a Date+Time picker.
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
      //Here, I'm using setState to update the _selectedDate field and rebuild the UI.
      setState(() {
        _selectedDate = picked;
      });
  } //_selectDate

  //
  //Utility method that validate the form and, if it is valid, save the new goal information.
  void _validateAndSave(BuildContext context) {
    if (formKey.currentState!.validate()) {
      Goal newGoal = Goal(
          name: _NameController
              .text, // MANCA IL FATTO CHE L'UTENTE DEVE SCRIVERE QUALCOSA NEL NOME PER ACCETTARE
          money: double.parse(_Controller.text),
          dateTime: _selectedDate);
      widget.goalIndex == -1
          ? widget.goalDB.addGoal(newGoal)
          : widget.goalDB.editGoal(widget.goalIndex, newGoal);
      Navigator.pop(context);
    }
  } // _validateAndSave

  //Utility method that deletes a goal entry.
  void _deleteAndPop(BuildContext context) {
    widget.goalDB.deleteGoal(widget.goalIndex);
    Navigator.pop(context);
  } //_deleteAndPop
} //MealPage
