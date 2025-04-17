import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class CountryModel
{
  String name;
  String code;
  CountryModel({required this.name,required this.code});

  @override
  String toString() {
    return "${this.name} ${this.code}";
  }
}
class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailRegex = RegExp(
    r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
  );
  String name='';
  bool check = false;
  List<CountryModel> countries = [
    CountryModel(name: 'Egypt', code: 'eg'),
    CountryModel(name: 'Syria', code: 'sy'),
    CountryModel(name: 'Jordan', code: 'jo'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Icon(Icons.add),
        title: Text(
          'My Home Page',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 20),
            child: Icon(Icons.access_alarms_sharp),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 20),
            child: Icon(Icons.access_alarms_sharp),
          ),
        ],
      ),

      body: Form(
        key: formKey,
        child: Column(
          children:
          [

            Switch(
              activeColor: Colors.amberAccent,
                inactiveThumbColor: Colors.blue,
                inactiveTrackColor: Colors.black,
                value: check,
                onChanged: (bool? value){
              setState(() {
                if(value != null) check = value;
              });
            }),
            Checkbox(
              checkColor: Colors.blue,
                fillColor: WidgetStateProperty.all(Colors.red),
                value: check,
                onChanged: (bool? value){
              setState(() {
                if(value != null) check = value;
              });
            }),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                autocorrect: true,
                controller: nameController,
                enabled: true,
                onTap: ()
                {
                  // showTimePicker(context: context,
                  //     initialTime: TimeOfDay.now());
                  // showDatePicker(context: context,
                  //   firstDate: DateTime.now(),
                  //     lastDate: DateTime(2025, )
                  // );
                  // print('Form tapped');
                },
                onChanged: (String value)
                {
                  // if(!formKey.currentState!.validate()) return;
                  //
                  // setState(() {
                  //   name = nameController.text;
                  // });
                },
                validator: (String? value)
                {
                  if(value == null || value.isEmpty)
                  {
                    return "Filed is required";
                  }
                  if (!emailRegex.hasMatch(value))
                  {
                    return 'email not valid';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter Your Name",
                  labelText: "Name",
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: Icon(Icons.person),
                  suffixIconColor: Colors.amberAccent,
                  enabledBorder: AppBorderDecoration.formFieldDecoration(Colors.grey),
                  disabledBorder: AppBorderDecoration.formFieldDecoration(Colors.grey.withAlpha(50)),
                  focusedBorder: AppBorderDecoration.formFieldDecoration(Colors.blue),
                  errorBorder: AppBorderDecoration.formFieldDecoration(Colors.red),
                  focusedErrorBorder: AppBorderDecoration.formFieldDecoration(Colors.blue),
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(20),
                  //   borderSide: BorderSide(
                  //     color: Colors.red
                  //   )
                  // )
                ),
              ),
            ),
          DropdownButtonFormField(
              decoration: InputDecoration(
                hintText: "Enter Your Name",
                labelText: "Name",
                prefixIcon: Icon(Icons.person),
                suffixIcon: Icon(Icons.person),
                suffixIconColor: Colors.amberAccent,
                enabledBorder:
                    AppBorderDecoration.formFieldDecoration(Colors.grey),
                disabledBorder: AppBorderDecoration.formFieldDecoration(
                    Colors.grey.withAlpha(50)),
                focusedBorder:
                    AppBorderDecoration.formFieldDecoration(Colors.blue),
                errorBorder:
                    AppBorderDecoration.formFieldDecoration(Colors.red),
                focusedErrorBorder:
                    AppBorderDecoration.formFieldDecoration(Colors.blue),
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(20),
                //   borderSide: BorderSide(
                //     color: Colors.red
                //   )
                // )
              ),
              items: countries.map(
                  (item) => DropdownMenuItem(value: item, child:
                  Text(item.toString()))
              ).toList(),
              onChanged: (value) {
                print(value?.name);
                print(value?.code);
              }),
          SizedBox(height: 50,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: Colors.black, width: 5)
                )
              ),
              onPressed: ()
              {
                if(!formKey.currentState!.validate()) return;

                setState(() {
                  name = nameController.text;
                });
              },
              child: Text('Validate')
            ),
            SizedBox(height: 50,),
            Text(name),
          ]),
      ),
    );
  }
}
abstract class AppBorderDecoration
{
  static InputBorder formFieldDecoration (Color color)
  {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
            color: color
        )
    );
  }

}

class RowBuilder extends StatelessWidget {
  const RowBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          for (int i = 0; i < 3; i++)
            Builder(builder: (context) {
              if (i == 0) {
                return ContainerItemBuilder();
              } else {
                return SizedBox();
              }
            })
        ],
      ),
    );
  }
}

class ContainerItemBuilder extends StatelessWidget {
  const ContainerItemBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      color: Colors.grey,
      margin: EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
