import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pim_group/widgetsgoals/formTiles.dart';
import 'package:pim_group/widgetsgoals/formSeparator.dart';
import 'package:pim_group/utils/formats.dart';
import 'package:quickalert/quickalert.dart';
import 'package:provider/provider.dart';
import 'package:pim_group/models/repo/app_repository.dart';
import 'package:pim_group/models/entities/drink.dart';

class DrinkPage extends StatefulWidget {
  final int drinkIndex;

  DrinkPage({Key? key, required this.drinkIndex}) : super(key: key);

  static const routeDisplayName = 'Add your drink';

  @override
  State<DrinkPage> createState() => _DrinkPageState();
} //DrinkPage

class _DrinkPageState extends State<DrinkPage> {
  bool checkstate = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController _choController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  DateTime today = DateTime.now();

  String? currentSelectedValue;
  final ValueNotifier<List<String>> _listNotifier =
      ValueNotifier<List<String>>(["Beer", "Wine", "Cocktail"]);

  @override
  void initState() {
    super.initState();
  } // initState

  @override
  void dispose() {
    _choController.dispose();
    super.dispose();
  } // dispose

  @override
  Widget build(BuildContext context) {
    print('${DrinkPage.routeDisplayName} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(DrinkPage.routeDisplayName),
        actions: [
          IconButton(
              onPressed: () async => {
                    checkstate = false,
                    _validateAndSave(context),
                    if (currentSelectedValue == null)
                      {
                        setState(() {
                          checkstate = false;
                        })
                      }
                    else
                      {
                        setState(() {
                          checkstate = true;
                        })
                      },
                    if (checkstate)
                      {
                        showDialog(
                            context: context,
                            builder: (context) {
                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.of(context).pop(true);
                              });
                              return AlertDialog(
                                title: Text('Added'),
                              );
                            })
                      }
                    else
                      {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Sorry, something went wrong',
                          text: 'You need to select a drink',
                        )
                      },
                  },
              icon: Icon(Icons.done)),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: SizedBox(
              height: 300,
              child: _buildForm(context),
            ),
          ),
          Text("Drinks today:"),
          SizedBox(
            height: 300,
            child: Center(
              child: Consumer<AppDatabaseRepository>(
                  builder: (context, dbr, child) {
                return FutureBuilder(
                  initialData: null,
                  future: dbr.findDrinksOnDate(
                      DateTime(today.year, today.month, today.day, 0, 0),
                      DateTime(today.year, today.month, today.day, 23, 59)),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data as List<Drink>;
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, drinkIndex) {
                            final drink = data[drinkIndex];
                            return Card(
                              elevation: 5,
                              child: Dismissible(
                                key: UniqueKey(),
                                background: Container(color: Colors.red),
                                child: ListTile(
                                  leading: Icon(MdiIcons.note),
                                  title: Text(drink.drinkType),
                                  subtitle: Text('ID: ${drink.id}'),
                                ),
                                onDismissed: (direction) async {
                                  await Provider.of<AppDatabaseRepository>(
                                          context,
                                          listen: false)
                                      .removeDrink(drink);
                                },
                              ),
                            );
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                );
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: widget.drinkIndex == -1
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
            FormSeparator(label: 'SELEZIONA DRINK'),
            SizedBox(
              height: 100,
              child: (() {
                return ValueListenableBuilder(
                    valueListenable: _listNotifier,
                    builder: (BuildContext context, List<String> list,
                        Widget? child) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: Text("Select Drink"),
                                  value: currentSelectedValue,
                                  isDense: true,
                                  onChanged: (newValue) {
                                    currentSelectedValue = newValue;
                                    _listNotifier.notifyListeners();
                                  },
                                  items: list.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    });
              }()),
            ),
            FormSeparator(label: 'IMPOSTA ORARIO'),
            FormDateTile(
              labelText: 'Drink Time',
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
      setState(() {
        _selectedDate = picked;
      });
  } //_selectDate

  //Utility method that validate the form and, if it is valid, save the new drink information.
  void _validateAndSave(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (currentSelectedValue == null) {
        setState(() {
          checkstate = false;
        });
      } else {
        Drink newDrink =
            Drink(drinkType: (currentSelectedValue!), dateTime: _selectedDate);
        await Provider.of<AppDatabaseRepository>(context, listen: false)
            .insertDrink(newDrink);
        setState(() {
          checkstate = true;
        });
      }
    }
  } // _validateAndSave

  // Method used to delete a drink entry
  void _deleteAndPop(BuildContext context) async {
    Drink newDrink =
        Drink(drinkType: (currentSelectedValue!), dateTime: _selectedDate);
    await Provider.of<AppDatabaseRepository>(context, listen: false)
        .insertDrink(newDrink);
    Navigator.pop(context);
  } //_deleteAndPop
} //DrinkPage
