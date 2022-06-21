import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  final String title = 'Calculator';

  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userInput = "";
  String result = "";
  @override
  void initState() {
    setState((){});
    super.initState();
  }


  List<String> buttons = [
    "7",
    "8",
    "9",
    "+",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "X",
    ".",
    "0",
    "Del",
    "÷",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.zero,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userInput,
                        style: const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.centerRight,
                      child: Text(
                        result,
                        style: const TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
            ),
          ),
          Container(
            color: Colors.black,
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                    crossAxisCount: 4,
                    childAspectRatio: 0.8),
                itemBuilder: (BuildContext context, int index) {
                  if (buttons[index] == "Del") {
                    return InkWell(
                      onTap: () =>
                          setState(() {
                            if (userInput.isNotEmpty) {
                              userInput =
                                  userInput.substring(0, userInput.length - 1);
                            }
                          }),
                      child: Container(
                        color: Colors.deepPurpleAccent,
                        child: Center(
                          child: Text(
                            buttons[index],
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }
                  else {
                    return InkWell(
                      onTap: () => setState(() => userInput += buttons[index]),
                      child: Container(
                        color: Colors.deepPurpleAccent,
                        child: Center(
                          child: Text(
                            buttons[index],
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }
                }),
          ),
          InkWell(
              child: Container(
                  color: Colors.black,
                  width: double.infinity,
                  child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Calculate",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ))),
              onTap: () {
                if(userInput.isNotEmpty){
                  var finalUserInput = userInput.replaceAll('X', '*').replaceAll('÷', '/');
                  Parser p = Parser();
                  Expression exp = p.parse(finalUserInput);
                  ContextModel cm = ContextModel();
                  double eval = exp.evaluate(EvaluationType.REAL, cm);
                  result = eval.toString();
                  setState((){});
                }
                }),
        ],
      ),
    );
  }
}


