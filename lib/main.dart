  import 'package:flutter/material.dart';
  import 'package:google_nav_bar/google_nav_bar.dart';
  import 'package:circular_countdown_timer/circular_countdown_timer.dart';
  import 'package:google_fonts/google_fonts.dart';

  void main() {
    runApp(const Pomodoro());
  }

  class Pomodoro extends StatelessWidget {
    const Pomodoro({super.key});



    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'PomodoroApp',
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(title: 'Pomordoro Home Page'),
      );
    }
  }

  class MyHomePage extends StatefulWidget {
    const MyHomePage({super.key, required this.title});

    final String title;

    @override
    State<MyHomePage> createState() => _MyHomePageState();
  }

  class _MyHomePageState extends State<MyHomePage> {
    final List<bool> _selectedStates = <bool>[true, false, false];
    Color appBarColor = Color.fromARGB(255, 255, 93, 93);
    Color backgroundColor = Color.fromARGB(255, 253, 162, 162);
    Color buttonColor = Color.fromARGB(255, 255, 111, 111);
    int timerIndex = 0;
    bool isOn = false;
    bool started = false;

    List<CountDownController> countdownControllers = [
      CountDownController(),
      CountDownController(),
      CountDownController(),
    ];

    List<int> currentDuration = [
      1500,
      900,
      300,
    ];

    List<Widget> timerStates = [
      Text('Pomodoro',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        )
      ),
      Text('Long Break',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        )
      ),
      Text('Short Break',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        )
      ),
    ];

    void changeTimerIndex(int index){
      setState(() {
        timerIndex = index;
      });

    }

    void changeColor(int selected) {
      setState(() {
        if(selected == 0) {
          appBarColor = Color.fromRGBO(255, 105, 105, 1);
          backgroundColor = Color.fromRGBO(253, 162, 162,1);
          buttonColor = Color.fromRGBO(255, 105, 105, 0.5);
        } else if(selected == 1) {
          appBarColor = Color.fromRGBO(114, 134, 211,1);
          backgroundColor = Color.fromRGBO(142, 167, 233,1);
          buttonColor = Color.fromRGBO(114, 134, 211,0.5);
        } else if(selected == 2) {
          appBarColor = Color.fromRGBO(87, 200, 77, 1);
          backgroundColor = Color.fromRGBO(171, 224, 152,1);
          buttonColor = Color.fromRGBO(87, 209, 77,0.5);;
        }
      });
    }

    showAlert(BuildContext context, Text title, Text content) {
      // Create button
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      // Create AlertDialog
      AlertDialog alert = AlertDialog(
        title: title,
        content: content,
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          //title: _widgetOptions.elementAt(_selectedIndex),
          title: Text(
            "Pomodoro",
            style: GoogleFonts.montserrat(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: appBarColor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ToggleButtons(
                        onPressed: (int index) {
                          if (!countdownControllers[timerIndex].isPaused && countdownControllers[timerIndex].isStarted){
                            showAlert(context, Text("Important Notice!"), Text("Pause the timer before continuing. Changing modes will reset your timer."));
                          }else {
                            setState(() {
                              // The button that is tapped is set to true, and the others to false.
                              for (int i = 0; i < _selectedStates.length; i++) {
                                _selectedStates[i] = i == index;
                              }

                              changeColor(index);
                              changeTimerIndex(index);
                              //currentDuration[timerIndex] = int.parse(countdownControllers[index].getTime() ?? '0');
                            });
                          };
                        },
                        renderBorder: false,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        selectedColor: Colors.white,
                        fillColor: buttonColor,
                        color: Colors.white,
                        constraints: const BoxConstraints(
                          minHeight: 50.0,
                          minWidth: 120.0,
                        ),
                        isSelected: _selectedStates,
                        children: timerStates,
                      ),
                    ],
                  ),
                  Stack(
                    children:[
                      Visibility(
                        visible: timerIndex == 0,
                        child: CircularCountDownTimer(
                          duration: currentDuration[timerIndex],
                          initialDuration: 0,
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 2,
                          controller: countdownControllers[0],
                          ringColor: Colors.white,
                          fillColor: appBarColor,
                          backgroundColor: buttonColor,
                          strokeWidth: 18.0,
                          strokeCap: StrokeCap.round,
                          textStyle: const TextStyle(
                            fontSize: 45,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textFormat: CountdownTextFormat.MM_SS,
                          isReverse: true,
                          isReverseAnimation: true,
                          isTimerTextShown: true,
                          autoStart: false,
                        ),
                      ),
                      Visibility(
                        visible: timerIndex == 1,
                        child: CircularCountDownTimer(
                          duration: currentDuration[timerIndex],
                          initialDuration: 0,
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 2,
                          controller: countdownControllers[1],
                          ringColor: Colors.white,
                          fillColor: appBarColor,
                          backgroundColor: buttonColor,
                          strokeWidth: 18.0,
                          strokeCap: StrokeCap.round,
                          textStyle: const TextStyle(
                            fontSize: 45,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textFormat: CountdownTextFormat.MM_SS,
                          isReverse: true,
                          isReverseAnimation: true,
                          isTimerTextShown: true,
                          autoStart: false,
                          onStart: () {
                            // Here, do whatever you want
                            debugPrint('Countdown Started');
                          },
                          onComplete: () {
                            // Here, do whatever you want
                            debugPrint('Countdown Ended');
                          },
                        ),
                      ),
                      Visibility(
                        visible: timerIndex == 2,
                        child: CircularCountDownTimer(
                          duration: currentDuration[timerIndex],
                          initialDuration: 0,
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 2,
                          controller: countdownControllers[2],
                          ringColor: Colors.white,
                          fillColor: appBarColor,
                          backgroundColor: buttonColor,
                          strokeWidth: 18.0,
                          strokeCap: StrokeCap.round,
                          textStyle: const TextStyle(
                            fontSize: 45,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textFormat: CountdownTextFormat.MM_SS,
                          isReverse: true,
                          isReverseAnimation: true,
                          isTimerTextShown: true,
                          autoStart: false,
                          onStart: () {
                            // Here, do whatever you want
                            debugPrint('Countdown Started');
                          },
                          onComplete: () {
                            // Here, do whatever you want
                            debugPrint('Countdown Ended');
                          },
                        ),
                      ),
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (!countdownControllers[timerIndex].isStarted){
                            setState(() {
                              countdownControllers[timerIndex].start();
                            });
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10, horizontal: 20))
                        ),
                        child: Text(
                          'Start',
                          style: TextStyle(fontSize: 26, color: backgroundColor),
                        )
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            countdownControllers[timerIndex].pause();
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10, horizontal: 20))
                        ),
                        child: Text(
                          'Pause',
                          style: TextStyle(fontSize: 26, color: backgroundColor),
                        )
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            countdownControllers[timerIndex].resume();
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10, horizontal: 20))
                        ),
                        child: Text(
                          'Resume',
                          style: TextStyle(fontSize: 26, color: backgroundColor),
                        )
                      )
                    ]
                  )
                ],
              ),
            ),
          ],

        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    }
  }


