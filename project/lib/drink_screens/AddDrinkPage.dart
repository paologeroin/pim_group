import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pim_group/models/drinks/drinkDB.dart';
import 'package:pim_group/drink_screens/drinkpage.dart';
import 'package:pim_group/utils/formats.dart';
import 'package:provider/provider.dart';

//Homepage screen. It will show the list of drinks.
class AddDrinkPage extends StatelessWidget {
  AddDrinkPage({Key? key}) : super(key: key);

  static const routeDisplayName = 'Drinks had today';

  @override
  Widget build(BuildContext context) {
    //Print the route display name for debugging
    print('${AddDrinkPage.routeDisplayName} built');

    return Scaffold(
      appBar: AppBar(
        title: Text(AddDrinkPage.routeDisplayName),
      ),
      body: Center(
        //Here we are using a Consumer because we want the UI showing
        //the list of drinks to rebuild every time the drink DB updates.
        child: Consumer<DrinkDB>(
          builder: (context, drinkDB, child) {
            //If the list of drinks is empty, show a simple Text, otherwise show the list of drinks using a ListView.
            return drinkDB.drinks.isEmpty
                ? Text('The drink list is currently empty')
                : ListView.builder(
                    itemCount: drinkDB.drinks.length,
                    itemBuilder: (context, mealIndex) {
                      //Here, I'm showing to you some new things:
                      //1. We are using the Card widget to wrap each ListTile to make the UI prettier;
                      //2. I'm using DateTime to manage dates;
                      //3. I'm using a custom DateFormats to format the DateTime (take a look at the utils/formats.dart file);
                      //4. Improving UI/UX adding a leading and a trailing to the ListTile
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          leading: Icon(MdiIcons.pasta),
                          trailing: Icon(MdiIcons.noteEdit),
                          title: Text(
                              'CHO : ${drinkDB.drinks[mealIndex].drinkType}'),
                          subtitle: Text(
                              '${Formats.fullDateFormatNoSeconds.format(drinkDB.drinks[mealIndex].dateTime)}'),
                          //When a ListTile is tapped, the user is redirected to the MealPage, where it will be able to edit it.
                          onTap: () =>
                              _toDrinkPage(context, drinkDB, mealIndex),
                        ),
                      );
                    });
          },
        ),
      ),

      // BOTTONE PER AGGIUNGERE UN ALTRO DRINK

      //Here, I'm using a FAB to let the user add new drinks.
      //Rationale: I'm using -1 as drinkIndex to let DrinkPage know that we want to add a new drink.
      floatingActionButton: FloatingActionButton(
        child: Icon(MdiIcons.plus),
        onPressed: () => _toDrinkPage(
            context, Provider.of<DrinkDB>(context, listen: false), -1),
      ),
    );
  } //build

  //Utility method to navigate to DrinkPage
  void _toDrinkPage(BuildContext context, DrinkDB mealDB, int drinkIndex) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DrinkPage(
                  drinkDB: mealDB,
                  drinkIndex: drinkIndex,
                )));
  } //_toDrinkPage
} //AddDrinkPage
