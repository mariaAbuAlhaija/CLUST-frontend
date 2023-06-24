import 'package:clust/providers/event_spot_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:clust/styles/mobile_styles.dart' as mobile;
import 'package:clust/styles/palate.dart';
import '../models/interaction_model.dart';
import '../models/answer_model.dart';
import '../controllers/interaction_controller.dart';
import '../controllers/answer_controller.dart';

class QuestionScreen extends StatelessWidget {
  final int interactionId;
  final bool ispast;
  QuestionScreen({required this.interactionId,required this.ispast});

  @override
  Widget build(BuildContext context) {
    ThemeData theme(BuildContext context) {
      return ThemeData(
        textTheme: Theme.of(context).textTheme.copyWith(
              displayLarge: mobile.displayLarge(color: Colors.amber),
              headlineLarge: mobile.headlineLarge(color: Palate.black),
              headlineMedium: mobile.headlineMedium(color: Palate.black),
              headlineSmall: mobile.headlineSmall(color: Palate.black),
              bodySmall: mobile.bodySmall(color: Palate.black),
              labelSmall: mobile.labelSmall(color: Palate.black),
            ),
      );
    }

    return Theme(
      data: !kIsWeb ? theme(context) : ThemeData(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Interactions'),
          backgroundColor: Palate.sand,
        ),
        body: FutureBuilder<Interaction>(
          future: InteractionController().getByID(interactionId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              Interaction interaction = snapshot.data!;
              eventSpotProvider provider = eventSpotProvider();
             
              return Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.campaign_rounded,
                          size: 40,
                          color: Palate.sand,
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            interaction.type,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: AnswerList(interactionId: interactionId),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text('No question found.'));
            }
          },
        ),
        floatingActionButton:ispast? null:FloatingActionButton(
          onPressed: () {
            _showAnswerDialog(context);
          },
          backgroundColor: Palate.sand,
          child: Icon(
            Icons.chat,
            color: Palate.black,
          ),
        ),
      ),
    );
  }

  void _showAnswerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController answerController = TextEditingController();

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Enter your answer',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: answerController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    TextButton(
                      onPressed: () async {
                        String answerText = answerController.text;
                        if (answerText.isNotEmpty) {
                          Answer answer = Answer(
                            0, // Provide the actual answer ID
                            answerText,
                            interactionId,
                          );
                          await AnswerController().create(answer);

                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AnswerList extends StatefulWidget {
  final int interactionId;

  AnswerList({required this.interactionId});

  @override
  _AnswerListState createState() => _AnswerListState();
}

class _AnswerListState extends State<AnswerList> {
  List<Answer> answers = [];

  @override
  void initState() {
    super.initState();
    fetchAnswers();
  }

  Future<void> fetchAnswers() async {
    try {
      List<Answer> fetchedAnswers =
          await AnswerController().getByInteractionId(widget.interactionId);
      setState(() {
        answers = fetchedAnswers;
      });
    } catch (error) {
      print('Error fetching answers: $error');
    }
  }

  Future<void> refreshAnswers() async {
    setState(() {
      answers.clear();
    });
    await fetchAnswers();
  }

  @override
  Widget build(BuildContext context) {
    if (answers.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return RefreshIndicator(
      onRefresh: refreshAnswers,
      child: ListView.builder(
        itemCount: answers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.assignment_ind_outlined,
                  size: 20,
                  color: Palate.lightwine,
                ),
                SizedBox(width: 8),
                Text(
                  answers[index].textDescription,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
