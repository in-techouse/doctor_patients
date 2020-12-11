import 'package:doctor_app/model/Questions.dart';
import 'package:doctor_app/view/utilis/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'diseases.dart';

class DiseaseQuestions extends StatefulWidget {
  DiseaseQuestions({this.disease});

  String disease = "";

  @override
  _DiseaseQuestionsState createState() => _DiseaseQuestionsState();
}

class _DiseaseQuestionsState extends State<DiseaseQuestions> {
  var _questions;

  // final _questions = const [
  //   {
  //     'questionText': 'Q1. Have you had fever during cold?',
  //     'answers': [
  //       {
  //         'text': 'Yes',
  //         'score': -2,
  //       },
  //       {'text': 'No', 'score': 10},
  //     ],
  //   },
  //   {
  //     'questionText': 'Q2. Did you feel difficulty in breathing?',
  //     'answers': [
  //       {
  //         'text': 'Yes',
  //         'score': -2,
  //       },
  //       {'text': 'No', 'score': 10},
  //     ],
  //   },
  //   {
  //     'questionText': ' Q3.Did you feel chest pain / pressure?',
  //     'answers': [
  //       {
  //         'text': 'Yes',
  //         'score': -2,
  //       },
  //       {'text': 'No', 'score': 10},
  //     ],
  //   },
  //   {
  //     'questionText': 'Q4. Did you feel muscle pain?',
  //     'answers': [
  //       {
  //         'text': 'Yes',
  //         'score': -2,
  //       },
  //       {'text': 'No', 'score': 10},
  //     ],
  //   },
  //   {
  //     'questionText':
  //     'Q5. Have you had watery eyes?',
  //     'answers': [
  //       {
  //         'text': 'Yes',
  //         'score': -2,
  //       },
  //       {'text': 'No', 'score': 10},
  //     ],
  //   },
  //   {
  //     'questionText':
  //     'Q6. Have you had runny nose?',
  //     'answers': [
  //       {
  //         'text': 'Yes',
  //         'score': -2,
  //       },
  //       {'text': 'No', 'score': 10},
  //     ],
  //   },
  //   {
  //     'questionText':
  //     'Q7. Have you had headache or body ache?',
  //     'answers': [
  //       {
  //         'text': 'Yes',
  //         'score': -2,
  //       },
  //       {'text': 'No', 'score': 10},
  //     ],
  //   },
  //   {
  //     'questionText':
  //     'Q8. Did you feel loss of appetite?',
  //     'answers': [
  //       {
  //         'text': 'Yes',
  //         'score': -2,
  //       },
  //       {'text': 'No', 'score': 10},
  //     ],
  //   },
  //   {
  //     'questionText':
  //     'Q8. Have you had sore throat?',
  //     'answers': [
  //       {
  //         'text': 'Yes',
  //         'score': -2,
  //       },
  //       {'text': 'No', 'score': 10},
  //     ],
  //   },
  //
  // ];

  var _questionIndex = 0;
  var _totalScore = 0;

  @override
  void initState() {
    if (widget.disease == "Cold Flu") {
      setState(() {
        _questions = Questions.COLD_FLU_QUESTIONS;
      });
    } else if (widget.disease == "Allergies") {
      setState(() {
        _questions = Questions.ALLERGIES_QUESTIONS;
      });
    }
    else if (widget.disease == "Cardio Vascular") {
      setState(() {
        _questions = Questions.CARDIO_VASCULAR_QUESTIONS;
      });
    }
    else if (widget.disease == "HairFall") {
      setState(() {
        _questions = Questions.HAIR_FALL;
      });
    }
    else if (widget.disease == "Diabetics") {
      setState(() {
        _questions = Questions.DIABETICS;
      });
    }
    else if (widget.disease == "Headache") {
      setState(() {
        _questions = Questions.HEADACHE;
      });
    }
    else if (widget.disease == "Stomachache") {
      setState(() {
        _questions = Questions.STOMACHACHE;
      });
    }
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: main_color,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60,),
              Text("Monitoring you health",style: GoogleFonts.aclonica(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24)),
              SizedBox(height: 70,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  child: Card(
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                      child: _questionIndex < _questions.length
                          ? Quiz(
                              answerQuestion: _answerQuestion,
                              questionIndex: _questionIndex,
                              questions: _questions,
                            ) //Quiz
                          : Result(_totalScore, _resetQuiz),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    @required this.questions,
    @required this.answerQuestion,
    @required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          questions[questionIndex]['questionText'],
        ), //Question
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(() => answerQuestion(answer['score']), answer['text']);
        }).toList()
      ],
    ); //Column
  }
}

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        questionText,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ), //Text
    ); //Contaier
  }
}

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: main_color,
        textColor: Colors.white,
        child: Text(answerText),
        onPressed: selectHandler,
      ), //RaisedButton
    ); //Container
  }
}

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;

  Result(this.resultScore, this.resetHandler);

  //Remark Logic
  String get resultPhrase {
    String resultText;
    if (resultScore >= 41) {
      resultText = 'Please Consult with your doctor.';
      print(resultScore);
    } else if (resultScore >= 31) {
      resultText = 'Please Consult with your doctor.';
      print(resultScore);
    } else if (resultScore >= 21) {
      resultText = 'Prescription here.';
    } else if (resultScore >= 1) {
      resultText = 'You have minnor symptoms.Take care of yourself.';
    } else {
      resultText = 'You have no flu or cold.';
      print(resultScore);
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ), //Tex//Text
          FlatButton(
            child: Text(
              'Back to diseases',
            ), //Text
            textColor: Colors.blue,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Diseases()));
            },
          ), //FlatButton
        ], //<Widget>[]
      ), //Column
    ); //Center
  }
}
