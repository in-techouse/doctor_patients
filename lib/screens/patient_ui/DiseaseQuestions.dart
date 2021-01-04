import 'package:doctor_app/director/Constants.dart';
import 'package:doctor_app/director/Questions.dart';
import 'package:doctor_app/screens/patient_ui/DoctorsList.dart';
import 'package:doctor_app/screens/patient_ui/PrescriptionScreen.dart';
import 'package:doctor_app/utilis/HelloDocColors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DiseaseQuestions extends StatefulWidget {
  DiseaseQuestions({this.index});

  int index = 0;

  @override
  _DiseaseQuestionsState createState() => _DiseaseQuestionsState();
}

class _DiseaseQuestionsState extends State<DiseaseQuestions> {
  List<String> diseases = Constants.DISEASES;
  String disease = "";
  var questions;
  var questionIndex = 0;
  var totalScore = 0;

  @override
  void initState() {
    super.initState();
    disease = diseases[widget.index];
    print("DiseaseQuestions, Index is: ${widget.index}");
    print("DiseaseQuestions, Disease is: $disease");

    if (disease == Constants.COLD_FLU) {
      setState(() {
        questions = Questions.COLD_FLU_QUESTIONS;
      });
    } else if (disease == Constants.ALLERGIES) {
      setState(() {
        questions = Questions.ALLERGIES_QUESTIONS;
      });
    } else if (disease == Constants.CARDIO_VASCULAR) {
      setState(() {
        questions = Questions.CARDIO_VASCULAR_QUESTIONS;
      });
    } else if (disease == Constants.HAIR_FALL) {
      setState(() {
        questions = Questions.HAIR_FALL;
      });
    } else if (disease == Constants.DIABETES) {
      setState(() {
        questions = Questions.DIABETICS;
      });
    } else if (disease == Constants.HEADACHE) {
      setState(() {
        questions = Questions.HEADACHE;
      });
    } else if (disease == Constants.STOMACHACHE) {
      setState(() {
        questions = Questions.STOMACHACHE;
      });
    }
  }

  void resetQuiz() {
    setState(() {
      questionIndex = 0;
      totalScore = 0;
    });
  }

  void answerQuestion(int score) {
    totalScore += score;

    setState(() {
      questionIndex = questionIndex + 1;
    });
    print(questionIndex);
    if (questionIndex < questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  Widget getQuestion() {
    return Column(
      children: [Text("${questions[questionIndex].questionText}")],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("DISEASE QUESTIONS"),
        centerTitle: true,
        elevation: 20,
        backgroundColor: HelloDocColors.colorPrimary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Card(
                color: HelloDocColors.colorPrimary,
                child: Padding(
                  padding: const EdgeInsets.all(21.0),
                  child: Center(
                      child: Text(
                    '${disease.toUpperCase()}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: HelloDocColors.colorWhite,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
                )),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Container(
                  width: width,
                  child: Card(
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(11),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(13, 21, 13, 21),
                          child: questionIndex < questions.length
                              ? Quiz(
                                  answerQuestion: answerQuestion,
                                  questionIndex: questionIndex,
                                  questions: questions,
                                )
                              : Result(totalScore, resetQuiz,
                                  questions.length * 10, disease),
                          // child: getQuestion(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
        ),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(11, 27, 11, 27),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: Text(
          questionText,
          style: TextStyle(fontSize: 28),
          textAlign: TextAlign.center,
        ),
      ),
    );
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
        color: HelloDocColors.colorPrimary,
        textColor: Colors.white,
        child: Text(answerText),
        onPressed: selectHandler,
      ),
    );
  }
}

// ignore: must_be_immutable
class Result extends StatelessWidget {
  final int resultScore, totalQuestions;
  final String disease;
  final Function resetHandler;
  bool score = false;

  Result(
      this.resultScore, this.resetHandler, this.totalQuestions, this.disease);

  // Remark Logic
  String get resultPhrase {
    String resultText;
    print("Result is $resultScore");
    print("Total Questions are is $totalQuestions");
    var percentage = ((resultScore / totalQuestions) * 100);
    print("Percentage is $percentage");
    if (percentage >= 75) {
      resultText = 'You have minor symptoms. Take care of yourself.';
    } else if (percentage >= 40 && percentage < 75) {
      resultText = 'Have a look at the prescription';
    } else if (percentage < 40) {
      resultText = 'Please Consult with the doctor.';
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
          ),
          resultPhrase == "Please Consult with the doctor."
              ? GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DoctorList()));
                  },
                  child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 40,
                      width: 230,
                      decoration: BoxDecoration(
                          color: HelloDocColors.colorPrimary,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Chose Your Doctor",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Icon(
                            Icons.arrow_forward_outlined,
                            color: Colors.white,
                          )
                        ],
                      )),
                )
              : SizedBox(),
          resultPhrase == "Have a look at the prescription"
              ? GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PrescriptionScreen(disease: disease)));
                  },
                  child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 40,
                      width: 230,
                      decoration: BoxDecoration(
                          color: HelloDocColors.colorPrimary,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "SHOW PRESCRIPTION",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Icon(
                            Icons.arrow_forward_outlined,
                            color: Colors.white,
                          )
                        ],
                      )),
                )
              : SizedBox(),
          FlatButton(
            child: Text(
              'Back to diseases',
            ), //Text
            textColor: Colors.blue,
            onPressed: () {
              Navigator.pop(context);
            },
          ), //FlatButton
        ], //<Widget>[]
      ), //Column
    ); //Center
  }
}
