//TODO's

//import

//list of employee
//Stream controllers

//Stream Sink getter

//Constructor - add data; listen to changes

// Core functions

// dispose

import 'employee.dart';
import 'dart:async';

class EmployeeBloc {
  //sink to add in pipe
  //stream to get data from pipe
  //by pipe means data flow

  List<Employee> _employeeList = [
    Employee(1, "Employee one", 10000.0),
    Employee(2, "Employee two", 20000.0),
    Employee(3, "Employee three", 30000.0),
    Employee(4, "Employee four", 40000.0),
    Employee(5, "Employee five", 50000.0)
  ];

  final _employeeListStreamController = StreamController<List<Employee>>();

  // for inc and dec
  final _employeeSalaryIncreamentStreamController =
      StreamController<Employee>();
  final _employeeSalaryDecreamentStreamController =
      StreamController<Employee>();

  //getters
  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncreament =>
      _employeeSalaryIncreamentStreamController.sink;

  StreamSink<Employee> get employeeSalaryDecreament =>
      _employeeSalaryDecreamentStreamController.sink;

  EmployeeBloc() {
    _employeeListStreamController.add(_employeeList);


    // listen to changes
    _employeeSalaryIncreamentStreamController.stream.listen(_increamentSalary);

    _employeeSalaryDecreamentStreamController.stream.listen(_decreamentSalary);
  }

  _increamentSalary(Employee employee) {
    double salary = employee.salary;

    double _increamentSalary = salary * 20 / 100;

    _employeeList[employee.id - 1].salary =
        double.parse((salary + _increamentSalary).toStringAsFixed(2));

    employeeListSink.add(_employeeList);
  }

  _decreamentSalary(Employee employee) {
    double salary = employee.salary;

    double _decreamentSalary = salary * 20 / 100;

    _employeeList[employee.id - 1].salary =
        double.parse((salary - _decreamentSalary).toStringAsFixed(2));

    employeeListSink.add(_employeeList);
  }

  void dispose() {
    _employeeListStreamController.close();
    _employeeSalaryIncreamentStreamController.close();
    _employeeSalaryDecreamentStreamController.close();
  }
}
