import 'package:clust/controllers/user_controller.dart';
import 'package:clust/globals.dart';
import 'package:clust/models/user_model.dart';
import 'package:clust/providers/user_provider.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/widgets/loading.dart';
import 'package:clust/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:provider/provider.dart';

class BecomeOrganizer extends StatefulWidget {
  BecomeOrganizer({super.key});
  @override
  State<BecomeOrganizer> createState() => _BecomeOrganizerState();
}

class _BecomeOrganizerState extends State<BecomeOrganizer> {
  final PageController _controller = PageController(initialPage: 0);
  final sidController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  int _pageIndex = 0;
  var validated = false;
  var scroll = true;
  bool visible = false;

  Future<void> sendApprovalEmail() async {
    String username = 'clustevents@gmail.com';
    String password = 'ovqsvecbocresybx';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Clust Events')
      ..recipients.add('aymancheese@hotmail.com')
      ..subject = 'Approval Needed'
      ..text = 'A user needs authentication to become an organizer. Please check the dashboard.';

    try {
      final sendReport = await send(message, smtpServer);
      print('Email sent:');
    } catch (e) {
      print('Error sending email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, UserProvider provider, Widget? child) {
        if (provider.user == null)
          return loading();
        else {
          if (provider.user!.accessRole == AccessRole.pending)
            return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: const [Color(0xffF4E7CA), Palate.sand]),
                ),
                child: thirdPage());
          else if (provider.user!.accessRole == AccessRole.attendee) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [Color(0xffF4E7CA), Palate.sand]),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      physics: scroll ? null : NeverScrollableScrollPhysics(),
                      controller: _controller,
                      onPageChanged: (value) {
                        setState(() {
                          _pageIndex = value;
                        });
                        if (value == 1 && !validated) {
                          setState(() {
                            scroll = false;
                          });
                        }
                        if (value == 2) {
                          setState(() {
                            visible = true;
                          });
                        } else {
                          setState(() {
                            visible = false;
                          });
                        }
                      },
                      children: <Widget>[
                        firstPage(),
                        secondPage(),
                        thirdPage(),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(right: 20.w, left: 20.w, bottom: 20),
                    height: 60.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: List.generate(3,
                                (index) => dotsIndicator(_pageIndex == index)),
                          ),
                        ),
                        arrow(provider)
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return loading();
          }
        }
      },
    );
  }

  Center secondPage() {
    return Center(
        child: Container(
      width: 300.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Organizer request",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 15.h,
          ),
          FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: sidController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  validator: FormBuilderValidators.required(),
                  onChanged: (value) {
                    setState(() {
                      validated = _formKey.currentState!.validate();
                      scroll = validated;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: "Social Security number",
                      labelText: "Enter Your Social Security number"),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Center firstPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Create many epic Events',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            'Become an events organizer Now!',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  Stack arrow(UserProvider provider) {
    return Stack(
      children: [
        Visibility(
          visible: !visible,
          child: IconButton(
              onPressed: (_pageIndex == 1 && !validated)
                  ? null
                  : () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
              icon: Icon(
                Icons.play_arrow_rounded,
                size: 40,
                color: (_pageIndex == 1 && !validated)
                    ? Palate.lighterBlack
                    : Palate.black,
              )),
        ),
        Visibility(
            visible: visible,
            child: MaterialButton(
              color: Palate.wine,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              onPressed: () {
                User _user = User.fromObj(provider.user!,
                    sid: int.parse(sidController.text),
                    accessRole: AccessRole.pending);
                print(_user.firstName);
                print("${_user.accessRole}" + " button");
                try {
                  provider.updateUser(_user);
                  EasyLoading.showSuccess(
                    "Requested!",
                    duration: Duration(seconds: 3),
                  );

                  // Send approval email after success
                  sendApprovalEmail();

                  Navigator.pushReplacementNamed(context, "/navigator");
                } catch (error, stackTrace) {
                  print(error);
                  print(stackTrace);
                  EasyLoading.showError(
                    "${error.toString()}",
                    duration: Duration(seconds: 3),
                  );
                }
              },
              child: Text(
                "Send Request",
                style: TextStyle(color: Palate.white),
              ),
            ))
      ],
    );
  }

  AnimatedContainer dotsIndicator(isActive) {
    return AnimatedContainer(
      decoration: BoxDecoration(
          color: isActive ? Palate.black : Palate.lighterBlack,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.all(2),
      height: isActive ? 20 : 10.h,
      width: 3.w,
      duration: Duration(milliseconds: 200),
    );
  }
}

class thirdPage extends StatelessWidget {
  const thirdPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Pending',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            'Your request to be an organizer will be reviewed',
            style: TextStyle(fontSize: 15),
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
