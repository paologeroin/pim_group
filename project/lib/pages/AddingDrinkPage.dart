import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:pim_group/models/drinks/drinkDB.dart';
import 'package:pim_group/drink_screens/drinkpage.dart';
import 'package:pim_group/utils/formats.dart';
import 'package:provider/provider.dart';

class AddingDrinkPage extends StatelessWidget {
  AddingDrinkPage({Key? key}) : super(key: key);

  static const routeDisplayName = 'Add drink';

  @override
  Widget build(BuildContext context) {
    //Print the route display name for debugging
    print('${AddingDrinkPage.routeDisplayName} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(AddingDrinkPage.routeDisplayName),
        backgroundColor: Color.fromARGB(255, 109, 230, 69),
        elevation: 1,
        centerTitle: true,
      ),
      body: Center(
        //Here we are using a Consumer because we want the UI showing
        //the list of drink to rebuild every time the meal DB updates.
        child: Consumer<DrinkDB>(
          builder: (context, drinkDB, child) {
            //If the list of drinks is empty, show a simple Text, otherwise show the list of drinks using a ListView.
            return drinkDB.drinks.isEmpty
                ? Text('The drink list is currently empty')
                : ListView.builder(
                    itemCount: drinkDB.drinks.length,
                    itemBuilder: (context, drinkIndex) {
                      //Here, I'm showing to you some new things:
                      //1. We are using the Card widget to wrap each ListTile to make the UI prettier;
                      //2. I'm using DateTime to manage dates;
                      //3. I'm using a custom DateFormats to format the DateTime (take a look at the utils/formats.dart file);
                      //4. Improving UI/UX adding a leading and a trailing to the ListTile

                      return Card(
                        elevation: 5,
                        child: ListTile(
                          leading: Icon(Icons.wine_bar),
                          trailing: Icon(Icons.note_alt),
                          title: Text(
                              'CHO : ${drinkDB.drinks[drinkIndex].drinkType}'),
                          subtitle: Text(
                              '${Formats.fullDateFormatNoSeconds.format(drinkDB.drinks[drinkIndex].dateTime)}'),
                          //When a ListTile is tapped, the user is redirected to the DrinkPage, where it will be able to edit it.
                          onTap: () =>
                              _toDrinkPage(context, drinkDB, drinkIndex),
                        ),
                      );
                    });
          },
        ),
      ),
      //Here, I'm using a FAB to let the user add new meals.
      //Rationale: I'm using -1 as mealIndex to let MealPage know that we want to add a new meal.
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _toDrinkPage(
            context, Provider.of<DrinkDB>(context, listen: false), -1),
      ),
    );
  } //build

  //Utility method to navigate to DrinkPage
  void _toDrinkPage(BuildContext context, DrinkDB drinkDB, int drinkIndex) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DrinkPage(
                  drinkDB: drinkDB,
                  drinkIndex: drinkIndex,
                )));
  } //_toDrinkPage
} //AddingDrinkPage

/* lion
import 'package:flutter/foundation.dart';


class AddingDrinkPage extends StatefulWidget {
  const AddingDrinkPage({Key? key}) : super(key: key);
  @override
  State<AddingDrinkPage> createState() => _AddingDrinkPageState();
}
class _AddingDrinkPageState extends State<AddingDrinkPage> {
  String dropdownValue = 'Dog';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagina dove aggiungere il drink')),
      
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            // Step 2.
            DropdownButton<String>(
              // Step 3.
              value: dropdownValue,
              // Step 4.
              items: <String>['Dog', 'Cat', 'Tiger', 'Lion']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 30),
                  ),
                );
              }).toList(),
              // Step 5.
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Selected Value: $dropdownValue',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
*/

/*

class AddingDrinkPage extends StatelessWidget {
   AddingDrinkPage({super.key});

  
final List<String> items = [
  'Beer',
  'Wine',
  'Cocktail',
  'Item4',
  'Item5',
  'Item6',
  'Item7',
  'Item8',
];
String? selectedValue;

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.teal[50],
      appBar: AppBar(title: const Text('Pagina dove aggiungere il drink')),
      
    body: Column(
      children: [
        
      CustomDropdownButton2(
        hint: 'Select drink ',
        dropdownItems: items,
        value: selectedValue,
        
        onChanged: (value) {
          setState() {
            selectedValue = value as String;
          };
        },
      ),
    ]),
  );
}
}
class CustomDropdownButton2 extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;

  const CustomDropdownButton2({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = const Offset(0, 0),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        //To avoid long text overflowing.
        isExpanded: true,
        hint: Container(
          alignment: hintAlignment,
          child: Text(
            hint,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).hintColor,
            ),
          ),
        ),
        value: value,
        items: dropdownItems
                .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Container(
            alignment: valueAlignment,
            child: Text(
              item,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ))
                .toList(),
        onChanged: onChanged,
        selectedItemBuilder: selectedItemBuilder,
        buttonStyleData: ButtonStyleData(
          height: buttonHeight ?? 50,
          width: buttonWidth ?? 200,
          padding: buttonPadding ?? const EdgeInsets.only(left: 14, right: 14),
          decoration: buttonDecoration ??
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.black45,
                    ),
                  ),
          elevation: buttonElevation,
        ),
        iconStyleData: IconStyleData(
          icon: icon ?? const Icon(Icons.arrow_forward_ios_outlined),
          iconSize: iconSize ?? 12,
          iconEnabledColor: iconEnabledColor,
          iconDisabledColor: iconDisabledColor,
        ),
        dropdownStyleData: DropdownStyleData(
          //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
          maxHeight: dropdownHeight ?? 200,
          width: dropdownWidth ?? 200,
          padding: dropdownPadding,
          decoration: dropdownDecoration ??
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                  ),
          elevation: dropdownElevation ?? 8,
          //Null or Offset(0, 0) will open just under the button. You can edit as you want.
          offset: offset,
          //Default is false to show menu below button
          isOverButton: false,
          scrollbarTheme: ScrollbarThemeData(
            radius: scrollbarRadius ?? const Radius.circular(40),
            thickness: scrollbarThickness != null
                    ? MaterialStateProperty.all<double>(scrollbarThickness!)
                    : null,
            thumbVisibility: scrollbarAlwaysShow != null
                    ? MaterialStateProperty.all<bool>(scrollbarAlwaysShow!)
                    : null,
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: itemHeight ?? 40,
          padding: itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}



*/

/*
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(title: const Text('Pagina dove aggiungere il drink')),
      body: Center(
        child: Text('drink aggiunti')
        
      )
    );
  }
}
*/
/*
//RUBRICA
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:pim_group/models/contacts.dart';


class AddingDrinkPage extends StatefulWidget {
  const AddingDrinkPage({Key? key}) : super(key: key);

  @override
  State<AddingDrinkPage> createState() => _AddingDrinkPageState();
}

class _AddingDrinkPageState extends State<AddingDrinkPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  List<Contact> contacts = List.empty(growable: true);

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contacts List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),

          


            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: 'Contact Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),




            const SizedBox(height: 10),
            TextField(
              controller: contactController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: const InputDecoration(
                  hintText: 'Contact Number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      //
                      String name = nameController.text.trim();
                      String contact = contactController.text.trim();
                      if (name.isNotEmpty && contact.isNotEmpty) {
                        setState(() {
                          nameController.text = '';
                          contactController.text = '';
                          contacts.add(Contact(name: name, contact: contact));
                        });
                      }
                      //
                    },
                    child: const Text('Save')),
                ElevatedButton(
                    onPressed: () {
                      //
                      String name = nameController.text.trim();
                      String contact = contactController.text.trim();
                      if (name.isNotEmpty && contact.isNotEmpty) {
                        setState(() {
                          nameController.text = '';
                          contactController.text = '';
                          contacts[selectedIndex].name = name;
                          contacts[selectedIndex].contact = contact;
                          selectedIndex = -1;
                        });
                      }
                      //
                    },
                    child: const Text('Update')),
              ],
            ),
            const SizedBox(height: 20),
            contacts.isEmpty
                ? const Text(
                    'You had 0 drinks today',
                    style: TextStyle(fontSize: 22),
                    
                    
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) => getRow(index),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
          child: Text(
            contacts[index].name[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(contacts[index].contact),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    //
                    nameController.text = contacts[index].name;
                    contactController.text = contacts[index].contact;
                    setState(() {
                      selectedIndex = index;
                    });
                    //
                  },
                  child: const Icon(Icons.edit)),
              InkWell(
                  onTap: (() {
                    //
                    setState(() {
                      contacts.removeAt(index);
                    });
                    //
                  }),
                  child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}
*/
