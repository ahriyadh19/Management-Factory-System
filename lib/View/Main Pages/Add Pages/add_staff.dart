import 'package:flutter/material.dart';
import 'package:management_factory_system/View/Containers/app_bar_customize.dart';
import 'package:management_factory_system/View/Containers/background.dart';
import 'package:management_factory_system/Controller/colors.dart';

class AddStaffPage extends StatefulWidget {
  const AddStaffPage({Key? key, this.option, this.appBarTitle})
      : super(key: key);
  final int? option;
  final String? appBarTitle;
  @override
  State<AddStaffPage> createState() => _AddStaffPageState();
}

class _AddStaffPageState extends State<AddStaffPage> {
  @override
  void initState() {
    super.initState();
    emptyAllData();
  }

  static String? errorTextHint;
  static bool hasError = false;

  static List<String?> errorsTexts = List.generate(2, (i) => null);
  static List<TextEditingController> myControllerNewCustomer =
      List.generate(2, (i) => TextEditingController());
  Widget bodyPage(BuildContext ctx) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Add New Staff',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: MyColors.myColorFont)),
          fieldInput('Staff name', 'Input Staff Name', Icons.person, 0, ctx),
          fieldInput('Staff Phone', 'Input Staff Phone',
              Icons.phone_android_rounded, 1, ctx),
          hasError
              ? Text(errorTextHint!, style: const TextStyle(color: Colors.red))
              : Container(),
          const SizedBox(height: 10),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonAction('Clear', 0),
                const SizedBox(width: 20),
                buttonAction('Save', 1)
              ],
            ),
          )
        ],
      ),
    );
  }

  ElevatedButton buttonAction(String txt, int op) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(MyColors.myColorContainer)),
        onPressed: () {
          setState(() {
            if (op == 0) {
              emptyAllData();
            } else {
              emptyDataVisible();
              validity();
            }
          });
        },
        child: Text(txt, style: TextStyle(color: MyColors.myColorFont)));
  }

  void emptyDataVisible() {
    for (int i = 0; i < errorsTexts.length; i++) {
      errorsTexts[i] = null;
    }
    errorTextHint = null;
    hasError = false;
  }

  void validity() {
    if (myControllerNewCustomer[0].text.isEmpty ||
        myControllerNewCustomer[0].text.trim().isEmpty) {
      hasError = true;
      errorsTexts[0] = 'Please at least input Me !';
      errorTextHint = 'Check the input';
    } else {
      showDone(context);
    }
  }

  void emptyAllData() {
    for (int i = 0; i < errorsTexts.length; i++) {
      errorsTexts[i] = null;
      myControllerNewCustomer[i].clear();
    }
    errorTextHint = null;
    hasError = false;
  }

  Container fieldInput(String label, String hint, IconData icon, int index,
      BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: MyColors.myColorContainer.withOpacity(0.4)),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          icon: Icon(
            icon,
            color: Colors.black,
          ),
          labelText: label,
          hintText: hint,
          errorText: errorsTexts[index],
          labelStyle: const TextStyle(color: Colors.black),
          iconColor: Colors.black,
        ),
        keyboardType: TextInputType.name,
        controller: myControllerNewCustomer[index],
      ),
    );
  }

  showDone(BuildContext ctx) async {
    return await showDialog(
        context: ctx,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: MyColors.myColorContainer.withOpacity(0.7),
            title: const Text('Success'),
            content: const Text('Your record has saved successfully'),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        MyColors.myColorContainer.withOpacity(1))),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  emptyAllData();
                },
                child:
                    Text('Okay', style: TextStyle(color: MyColors.myColorFont)),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return widget.option != 0
        ? Background(widget: bodyPage(context)).build()
        : Scaffold(
            appBar:
                CustomizeAppBar().createCustomizeAppBar(widget.appBarTitle!),
            body: Background(widget: bodyPage(context)).build(),
          );
  }
}
