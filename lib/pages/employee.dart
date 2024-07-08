import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import '../service/database.dart';

final formatter = DateFormat.yMd();

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  bool _firstFieldEmpty = false;
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String? formattedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 80, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });

      formattedDate = DateFormat('MM/dd/yyyy').format(_selectedDate!);
      debugPrint('Selected date: $formattedDate');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Employee',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Form',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.only(
                left: 20,
                top: 30,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    // validator: (value) {
                    //   if(value!.isEmpty) {
                    //     return 'Please enter your name';
                    //   }
                    //   return null;
                    // },

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _firstFieldEmpty = true;
                        return 'Please enter your name!';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(
                          () {
                            _firstFieldEmpty = false;
                          },
                        );
                      }
                    },

                    controller: nameController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text(
                          'Name',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Age',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    // validator: (value) =>
                    //     value!.isEmpty ? 'Please enter your age' : null,

                    validator: (value) {
                      if (_firstFieldEmpty) {
                        _formKey.currentState!.validate();
                        return null;
                      }
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age!';
                      }
                      return null;
                    },
                    onTap: () {
                      setState(
                        () {
                          _formKey.currentState!.validate();
                        },
                      );
                    },
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text(
                          'Age',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Location',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (_firstFieldEmpty) {
                        _formKey.currentState!.validate();
                        return null;
                      }
                      if (value == null || value.isEmpty) {
                        return 'Please enter your location!';
                      }
                      return null;
                    },
                    onTap: () {
                      setState(
                        () {
                          _formKey.currentState!.validate();
                        },
                      );
                    },
                    controller: locationController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text(
                          'Location',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'DOB',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          _selectedDate == null
                              ? 'DOB'
                              : formatter.format(_selectedDate!),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                          Navigator.pop(context);
                        }
                        String id = randomAlphaNumeric(10);
                        Map<String, dynamic> employeeInfoMap = {
                          'Name': nameController.text,
                          'Age': ageController.text,
                          'Id': id,
                          'DOB': formattedDate,
                          'Location': locationController.text,
                        };
                        await DatabaseMethods()
                            .addEmployeeDetails(
                          employeeInfoMap,
                          id,
                        )
                            .then(
                          (value) {
                            return Container();
                          },
                        );
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
