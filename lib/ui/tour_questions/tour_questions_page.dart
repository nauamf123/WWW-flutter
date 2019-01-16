import 'package:flutter/material.dart';
import 'package:what_when_where/db_chgk_info/models/tour.dart';
import 'package:what_when_where/resources/dimensions.dart';
import 'package:what_when_where/resources/strings.dart';
import 'package:what_when_where/ui/tour_questions/question_card.dart';
import 'package:what_when_where/ui/tour_questions/timer_bloc.dart';

class TourQuestionsPage extends StatefulWidget {
  static const String routeName = 'questions';

  final Tour tour;
  final int startIndex;

  TourQuestionsPage({Key key, @required this.tour, this.startIndex})
      : assert(tour != null),
        assert(tour.questions != null),
        super(key: key);

  @override
  createState() => _TourQuestionsPageState(tour: tour, startIndex: startIndex);
}

class _TourQuestionsPageState extends State<TourQuestionsPage> {
  final Tour tour;
  final int _startIndex;
  final _timerBloc = TimerBloc();

  _TourQuestionsPageState({@required this.tour, int startIndex})
      : this._startIndex = startIndex;

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildTimerButton(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          iconTheme: Theme.of(context).iconTheme,
          elevation: 0.0,
        ),
        bottomNavigationBar: BottomAppBar(
            color: Theme.of(context).primaryColor,
            child: IconTheme(
              data: Theme.of(context).primaryIconTheme,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildTimerWidget(context),
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
            )),
        body: PageView.builder(
          controller:
              PageController(initialPage: _startIndex, viewportFraction: 0.85),
          itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(bottom: kToolbarHeight),
              child: QuestionCard(
                question: tour.questions[index],
              )),
          itemCount: tour.questions.length,
          onPageChanged: (index) => _timerBloc.actions.add(TimerActions.reset),
        ),
      );

  Widget _buildTimerButton() => StreamBuilder<bool>(
      stream: _timerBloc.isRunning,
      initialData: false,
      builder: (context, snapshot) => FloatingActionButton(
            child: Icon(
              snapshot.data ? Icons.timer_off : Icons.timer,
            ),
            tooltip: snapshot.data ? Strings.pauseTimer : Strings.startTimer,
            onPressed: () => _timerBloc.actions
                .add((snapshot.data) ? TimerActions.pause : TimerActions.run),
          ));

  Widget _buildTimerWidget(BuildContext context) => StreamBuilder<String>(
      stream: _timerBloc.time,
      initialData: '',
      builder: (context, snapshot) => Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.defaultSidePadding * 2),
            child: Text(
              snapshot.data,
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ));

  @override
  void dispose() {
    _timerBloc.dispose();

    super.dispose();
  }
}