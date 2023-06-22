import 'package:flutter/material.dart';
import 'package:clust/styles/mobile_styles.dart' as mobile;
import 'package:clust/styles/palate.dart';
import '../models/interaction_model.dart';
import '../models/answer_model.dart';
import '../controllers/interaction_controller.dart';
import '../controllers/answer_controller.dart';

class QuestionScreen extends StatelessWidget {
  final int interactionId;

  QuestionScreen({required this.interactionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interactions'),
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
      ;
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
