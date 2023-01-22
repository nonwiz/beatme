import 'package:beatme/shared/menu_bottom.dart';
import 'package:beatme/shared/menu_drawer.dart';
import 'package:flutter/material.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final TextEditingController txtHeight = TextEditingController();
  final TextEditingController txtWeight = TextEditingController();
  final double fontSize = 18;
  String result = '';
  bool isMetric = true;
  bool isImperial = false;
  double? height;
  double? weight;
  late List<bool> isSelected;
  String heightMessage = "";
  String weightMessage = "";

  @override
  void initState() {
    isSelected = [isMetric, isImperial];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heightMessage =
        "Please insert your height in " + ((isMetric) ? 'meters' : 'inches');
    weightMessage =
        "Please insert your weight in " + ((isMetric) ? 'kilos' : 'pounds');
    return Scaffold(
        appBar: AppBar(title: Text('BMI Calculator')),
        bottomNavigationBar: MenuBottom(),
        drawer: MenuDrawer(),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ToggleButtons(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: fontSize),
                      child: Text("Metric")),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: fontSize),
                      child: Text("Imperial"))
                ],
                isSelected: isSelected,
                onPressed: toggleMeasure,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                controller: txtHeight,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: heightMessage),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                controller: txtWeight,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: weightMessage),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ElevatedButton(onPressed: findBMI, child: Text('Calculate BMI')),
            ),
            Text(result, style: TextStyle(fontSize: fontSize))
          ]),
        ));
  }

  void toggleMeasure(value) {
    if (value == 0) {
      isMetric = true;
      isImperial = false;
    } else {
      isMetric = false;
      isImperial = true;
    }
    setState(() {
      isSelected = [isMetric, isImperial];
    });
  }

  void findBMI() {
    double bmi = 0;
    double height = double.tryParse(txtHeight.text) ?? 0;
    double weight = double.tryParse(txtWeight.text) ?? 0;
    if (isMetric) {
      bmi = weight / (height * weight);
    } else {
      bmi = weight * 703 / (height * weight);
    }
    setState(() {
      result = "Your BMI is " + bmi.toStringAsFixed(2);
    });
  }
}
