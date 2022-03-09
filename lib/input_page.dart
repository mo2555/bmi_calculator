import 'package:bmi_calculator/calculator_brain.dart';
import 'package:bmi_calculator/result.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const activeCardColor = Color(0xFF1D1E33);
const inactiveCardColor = Color(0xFF111328);

enum Gender {
  Male,
  Female,
}

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? selectedGender;

  int height = 120;
  int weight = 50;
  int age = 20;

  addWeight(){
    setState(() {
      weight++;
    });
  }
  minWeight(){
    setState(() {
      weight--;
    });
  }

  addAge(){
    setState(() {
      age++;
    });
  }
  minAge(){
    setState(() {
      age--;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("BMI CALCULATOR"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.Male;
                      });
                    },
                    child: CustomContainer(
                      selectedGender == Gender.Male
                          ? activeCardColor
                          : inactiveCardColor,
                      CustomColumn(FontAwesomeIcons.mars, "MALE"),
                    ),
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedGender = Gender.Female;
                    });
                  },
                  child: CustomContainer(
                      selectedGender == Gender.Female
                          ? activeCardColor
                          : inactiveCardColor,
                      CustomColumn(FontAwesomeIcons.venus, 'FEMALE')),
                )),
              ],
            ),
          ),
          Expanded(
            child: CustomContainer(
              activeCardColor,
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text("HEIGHT",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF8D8E98),
                    ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("$height",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w900
                        ),
                      ),
                      Text(" cm")
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 15.0,
                      ),
                    ),
                    child: Slider(
                      thumbColor: Color((0xFFEB1555)),
                      divisions: 100,
                      activeColor: Colors.white,
                      inactiveColor: Color(0xFF8D8E98),
                      min: 120,
                        max: 220,
                        value: height.toDouble(),
                        onChanged: (newValue){
                        setState(() {
                          height=newValue.toInt();
                        });
                        }
                        ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: CustomContainer(activeCardColor, CustomWidget(minWeight,addWeight,weight,'WEIGHT'))),
                Expanded(child: CustomContainer(activeCardColor, CustomWidget(minAge,addAge,age,'AGE'))),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              CalculatorBrain calc = CalculatorBrain(height, weight);
              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                return ResultPage(
                  bmiResult: calc.calculatBMI(),
                  text: calc.grtResult(),
                  hint: calc.getHint(),
                );
              }));
            },
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              color: Color(0xFFEB1555),
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              height: 80,
              child: Text("CALCULATE",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget CustomContainer(Color color, Widget child) => Container(
      child: child,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(15),
    );

Widget CustomColumn(IconData icon, text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        icon,
        size: 80,
      ),
      SizedBox(
        height: 15,
      ),
      Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: Color(0xFF8D8E98),
        ),
      ),
    ],
  );
}

Widget CustomWidget(minimize,add,value,text){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("$text",
      style: TextStyle(
      fontSize: 18,
      color: Color(0xFF8D8E98),
  ),
      ),
      Text("$value",
        style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w900
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: RaisedButton(
              padding: EdgeInsets.all(10),
              shape: CircleBorder(
              ),
              onPressed: minimize,
              child: Icon(Icons.minimize),
              color: Colors.grey,
            ),
          ),
          Expanded(child: RaisedButton(onPressed: add,
            padding: EdgeInsets.all(10),
          child: Icon(Icons.add),
            shape: CircleBorder(),
            color: Colors.grey,
          ),),
        ],
      ),
    ],
  );
}
