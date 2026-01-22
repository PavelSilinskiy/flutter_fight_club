import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(textTheme: GoogleFonts.pressStart2pTextTheme(textTheme)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Color(0xFFD5DEF0),
      body: Column(
        children: [
          SizedBox(height: 40),
          FightersInfo(),
          Expanded(child: SizedBox()),
          ControlsWidget(
            defendingBodyPart: defendingBodyPart,
            attackingBodyPart: attackingBodyPart,
            selectDefendingBodyPart: _selectDefendingBodyPart,
            selectAttackingBodyPart: _selectAttackingBodyPart,
          ),
          SizedBox(height: 14),
          Row(
            children: [
              SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: _go,
                  child: SizedBox(
                    height: 40,
                    child: ColoredBox(
                      color: _isReadyToGo() ? Colors.black87 : Colors.black38,
                      child: Center(
                        child: Text(
                          'Go'.toUpperCase(),
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.87),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  bool _isReadyToGo() {
    return defendingBodyPart != null && attackingBodyPart != null;
  }

  void _selectDefendingBodyPart(BodyPart value) {
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectAttackingBodyPart(BodyPart value) {
    setState(() {
      attackingBodyPart = value;
    });
  }

  void _go() {
    if (defendingBodyPart == null || attackingBodyPart == null) {
      return;
    }
    setState(() {
      defendingBodyPart = null;
      attackingBodyPart = null;
    });
  }
}

class ControlsWidget extends StatelessWidget {
  final BodyPart? defendingBodyPart;
  final ValueSetter<BodyPart> selectDefendingBodyPart;
  final BodyPart? attackingBodyPart;
  final ValueSetter<BodyPart> selectAttackingBodyPart;

  const ControlsWidget({
    super.key,
    required this.defendingBodyPart,
    required this.selectDefendingBodyPart,
    required this.attackingBodyPart,
    required this.selectAttackingBodyPart,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    'Defend'.toUpperCase(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(height: 13),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: defendingBodyPart == BodyPart.head,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: defendingBodyPart == BodyPart.torso,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: defendingBodyPart == BodyPart.legs,
                bodyPartSetter: selectDefendingBodyPart,
              ),
            ],
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    'Attack'.toUpperCase(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(height: 13),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: attackingBodyPart == BodyPart.head,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: attackingBodyPart == BodyPart.torso,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: attackingBodyPart == BodyPart.legs,
                bodyPartSetter: selectAttackingBodyPart,
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}

class FightersInfo extends StatelessWidget {
  const FightersInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              Center(child: Text('You')),
              LivesWidget(overAllLivesCount: 5, currentLivesCount: 3),
            ],
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              Center(child: Text('Enemy')),
              LivesWidget(overAllLivesCount: 5, currentLivesCount: 4),
            ],
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}

class LivesWidget extends StatelessWidget {
  final int overAllLivesCount;
  final int currentLivesCount;

  const LivesWidget({
    super.key,
    required this.overAllLivesCount,
    required this.currentLivesCount,
  }) : assert(currentLivesCount >= 0),
       assert(overAllLivesCount >= currentLivesCount),
       assert(overAllLivesCount >= 1);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(overAllLivesCount, (index) {
        if (index < currentLivesCount) {
          return Text('1');
        } else {
          return Text('0');
        }
      }),
    );
  }
}

class BodyPart {
  //RichEnum
  final String name;

  const BodyPart._(this.name);
  static const head = BodyPart._('Head');
  static const torso = BodyPart._('Torso');
  static const legs = BodyPart._('Legs');

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton({
    super.key,
    required this.bodyPart,
    required this.selected,
    required this.bodyPartSetter,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: ColoredBox(
          color: selected ? Color(0xFF1C79CE) : Colors.black38,
          child: Center(
            child: Text(
              style: TextStyle(
                color: selected ? Color(0xFFFFFFFF) : Color(0xFF060D14),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              bodyPart.name.toUpperCase(),
            ),
          ),
        ),
      ),
    );
  }
}
