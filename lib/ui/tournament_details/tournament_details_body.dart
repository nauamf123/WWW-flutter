import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tuple/tuple.dart';
import 'package:what_when_where/db_chgk_info/models/tournament.dart';
import 'package:what_when_where/redux/app/state.dart';
import 'package:what_when_where/redux/tours/actions.dart';
import 'package:what_when_where/resources/dimensions.dart';
import 'package:what_when_where/ui/tour_details/tour_details_container.dart';
import 'package:what_when_where/utils/function_holder.dart';

class TournamentDetailsBody extends StatefulWidget {
  final Tournament _tournament;

  TournamentDetailsBody({Key key, @required Tournament tournament})
      : assert(tournament != null),
        assert(tournament.tours != null),
        this._tournament = tournament;

  @override
  createState() => _TournamentDetailsBodyState();
}

class _TournamentDetailsBodyState extends State<TournamentDetailsBody>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  TabController _tabController;

  _TournamentDetailsBodyState() {
    _pageController = PageController();
    _tabController =
        TabController(length: widget._tournament.tours.length, vsync: this);
  }

  @override
  void initState() {
    super.initState();

    _pageController.addListener(_pageControllerListener);
    _tabController.addListener(_tabControllerListener);
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PhysicalModel(
            color: Theme.of(context).primaryColor,
            elevation: 4.0,
            child: _buildHeader(context),
          ),
          Expanded(
            child: _buildPageView(),
          ),
        ],
      );

  Widget _buildHeader(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(
                  left: kToolbarHeight,
                  right: kToolbarHeight,
                  bottom: Dimensions.defaultSidePadding * 2),
              child: Text(
                widget._tournament.title,
                style: Theme.of(context).primaryTextTheme.title,
              )),
          _buildTabBar(context),
        ],
      );

  Widget _buildTabBar(BuildContext context) => TabBar(
        indicatorColor: Theme.of(context).primaryTextTheme.body2.color,
        isScrollable: true,
        controller: _tabController,
        tabs: widget._tournament.tours
            .map((tour) => Tab(text: tour.title))
            .toList(),
      );

  Widget _buildPageView() =>
      StoreConnector<AppState, Tuple2<int, FunctionHolder>>(
          distinct: true,
          converter: (store) => Tuple2(store.state.toursState.tours.length,
              FunctionHolder((index) => store.dispatch(SelectTour(index)))),
          builder: (context, data) {
            var count = data.item1;
            var onPageChanged = data.item2;

            return PageView.builder(
              controller: _pageController,
              itemCount: count,
              itemBuilder: (context, index) =>
                  TourDetailsContainer(index: index),
              onPageChanged: (index) => onPageChanged.function(index),
            );
          },
          onDispose: (store) {
            store.dispatch(VoidTours());
          });

  @override
  void dispose() {
    _pageController.removeListener(_pageControllerListener);
    _pageController.dispose();
    _tabController.removeListener(_tabControllerListener);
    _tabController.dispose();

    super.dispose();
  }

  void _pageControllerListener() {
    var index = _pageController.page.round();

    if (index != _tabController.index) {
      _tabController.animateTo(index);
    }
  }

  void _tabControllerListener() {
    if (_tabController.indexIsChanging) {
      var index = _tabController.index;
      if (index != _pageController.page.round()) {
        _pageController.animateToPage(index,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    }
  }
}
