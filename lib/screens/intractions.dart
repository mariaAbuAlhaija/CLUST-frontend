import 'dart:async';

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
  QuestionScreen({required this.interactionId, required this.ispast});

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
          title: const Text('Interactions'),
          backgroundColor: Palate.sand,
        ),
        body: FutureBuilder<Interaction>(
          future: InteractionController().getByID(interactionId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              Interaction interaction = snapshot.data!;
              eventSpotProvider provider = eventSpotProvider();

              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.campaign_rounded,
                          size: 40,
                          color: Palate.sand,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            interaction.type,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: AnswerList(interactionId: interactionId),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No question found.'));
            }
          },
        ),
        floatingActionButton: ispast
            ? null
            : FloatingActionButton(
                onPressed: () {
                  _showAnswerDialog(context);
                },
                backgroundColor: Palate.sand,
                child: const Icon(
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
                const Text(
                  'Enter your answer',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: answerController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
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
                      child: const Text(
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
  bool showNoAnswers = false;

  @override
  void initState() {
    super.initState();
    fetchAnswers();
    Timer(const Duration(seconds: 4), () {
      if (answers.isEmpty) {
        setState(() {
          showNoAnswers = true;
        });
      }
    });
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
      showNoAnswers = false;
    });
    await fetchAnswers();
  }

  @override
  Widget build(BuildContext context) {
    if (answers.isEmpty && !showNoAnswers) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (answers.isEmpty && showNoAnswers) {
      return RefreshIndicator(
        onRefresh: refreshAnswers,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const Center(
              child: Text('No answers'),
            ),
          ],
        ),
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
                const Icon(
                  Icons.assignment_ind_outlined,
                  size: 20,
                  color: Palate.lightwine,
                ),
                const SizedBox(width: 8),
                Text(
                  answers[index].textDescription,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
