//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:t_t_t/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = "X";
  bool gameover = false;
  Game game = Game();
  List<int> scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
  int turn = 0;
  String result = "";

  @override
  void initState() {
    super.initState();
    // ignore: avoid_print
    game.board = Game.initGameboard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double bwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "It is $lastValue turn",
            style: const TextStyle(
                color: Colors.white, fontSize: 30, fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
              width: bwidth,
              height: bwidth,
              child: GridView.count(
                crossAxisCount: Game.blength ~/ 3,
                padding: const EdgeInsets.all(15),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: List.generate(
                  Game.blength,
                  (index) {
                    return InkWell(
                      onTap: gameover
                          ? null
                          : () {
                              if (game.board![index] == "") {
                                setState(() {
                                  game.board![index] = lastValue;
                                  turn++;
                                  gameover = game.wCheck(
                                      lastValue, index, scoreboard, 3);
                                  if (gameover) {
                                    result = "$lastValue is the Winner";
                                  } else if (!gameover && turn == 9) {
                                    result = "It is a Draw";
                                    gameover = true;
                                  }
                                  if (lastValue == "X") {
                                    lastValue = "O";
                                  } else {
                                    lastValue = "X";
                                  }
                                });
                              }
                            },
                      child: Container(
                        width: Game.bsize,
                        height: Game.bsize,
                        decoration: BoxDecoration(
                          color: Colors.limeAccent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            game.board![index],
                            style: TextStyle(
                                color: game.board![index] == "X"
                                    ? Colors.blueAccent
                                    : Colors.cyan,
                                fontSize: 64.0),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )),
          // const SizedBox(
          //   height: 50.0,
          //   width: 30,
          // ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text(
              result,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontStyle: FontStyle.italic),
            ),
          ),
          // ElevatedButton.icon(
          //   onPressed: () {
          //     setState(() {
          //       game.board = Game.initGameboard();
          //       lastValue = "X";
          //       gameover = false;
          //       turn = 0;
          //       result = "";
          //       scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
          //     });
          //   },
          //   icon: const Icon(Icons.replay),
          //   label: const Text(""),
          // ),
          Container(
            height: 10,
            width: 100,
            
            child: TextButton(
                child: const Icon(Icons.replay_circle_filled_sharp,color: Colors.amber,size: 35,),
                
                onPressed: () {
                  setState(() {
                    game.board = Game.initGameboard();
                    lastValue = "X";
                    gameover = false;
                    turn = 0;
                    result = "";
                    scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
                  });
                  
                }),
          )
        ],
      ),
    );
  }
}
