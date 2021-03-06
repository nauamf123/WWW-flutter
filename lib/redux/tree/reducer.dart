import 'package:redux/redux.dart';
import 'package:dartx/dartx.dart';

import 'package:what_when_where/data/models/tournament.dart';
import 'package:what_when_where/data/models/tournaments_tree.dart';
import 'package:what_when_where/redux/redux_action.dart';
import 'package:what_when_where/redux/tournament/actions.dart';
import 'package:what_when_where/redux/tree/actions.dart';
import 'package:what_when_where/redux/tree/state.dart';

class TournamentsTreeReducer {
  static final Reducer<TournamentsTreeState> _reducer =
      combineReducers<TournamentsTreeState>([
    TypedReducer<TournamentsTreeState, InitTournamentsTreeSystemAction>(_init),
    TypedReducer<TournamentsTreeState, DeInitTournamentsTreeSystemAction>(
        _deInit),
    TypedReducer<TournamentsTreeState, InitSubTreeTournamentsTreeSystemAction>(
        _initSubTree),
    TypedReducer<TournamentsTreeState,
        DeInitSubTreeTournamentsTreeSystemAction>(_deInitSubTree),
    TypedReducer<TournamentsTreeState, CompletedTournamentsTreeSystemAction>(
        _completed),
    TypedReducer<TournamentsTreeState, LoadingTournamentsTreeSystemAction>(
        _loading),
    TypedReducer<TournamentsTreeState, FailedTournamentsTreeSystemAction>(
        _failed),
    TypedReducer<TournamentsTreeState, StatusChangedTournamentSystemAction>(
        _statusChanged),
  ]);

  static TournamentsTreeState reduce(
          TournamentsTreeState state, ReduxAction action) =>
      _reducer(state, action);

  static TournamentsTreeState _init(
          TournamentsTreeState state, InitTournamentsTreeSystemAction action) =>
      const TournamentsTreeState();

  static TournamentsTreeState _deInit(TournamentsTreeState state,
          DeInitTournamentsTreeSystemAction action) =>
      null;

  static TournamentsTreeState _completed(TournamentsTreeState state,
          CompletedTournamentsTreeSystemAction action) =>
      _copyWithSubTree(
          state,
          TournamentsSubTreeState.data(
            info: action.tree.info,
            tree: action.tree,
          ));

  static TournamentsTreeState _loading(TournamentsTreeState state,
          LoadingTournamentsTreeSystemAction action) =>
      _copyWithSubTree(
          state, TournamentsSubTreeState.loading(info: action.info));

  static TournamentsTreeState _failed(TournamentsTreeState state,
          FailedTournamentsTreeSystemAction action) =>
      _copyWithSubTree(
          state,
          TournamentsSubTreeState.error(
            info: action.info,
            exception: action.exception,
          ));

  static TournamentsTreeState _initSubTree(TournamentsTreeState state,
      InitSubTreeTournamentsTreeSystemAction action) {
    if (state == null) {
      return state;
    }

    final newStates = Map<String, TournamentsSubTreeState>.from(state.states);
    newStates[action.info.id] =
        TournamentsSubTreeState.initial(info: action.info);
    return TournamentsTreeState(states: newStates);
  }

  static TournamentsTreeState _deInitSubTree(TournamentsTreeState state,
      DeInitSubTreeTournamentsTreeSystemAction action) {
    if (state == null) {
      return state;
    }

    final newStates = Map<String, TournamentsSubTreeState>.from(state.states);
    newStates.remove(action.info.id);
    return TournamentsTreeState(states: newStates);
  }

  static TournamentsTreeState _copyWithSubTree(
      TournamentsTreeState state, TournamentsSubTreeState subState) {
    if (state == null) {
      return state;
    }

    final newStates = Map<String, TournamentsSubTreeState>.from(state.states);
    newStates[subState.info.id] = subState;

    if (subState is DataTournamentsSubTreeState) {
      subState.tree.children.whereType<TournamentsTree>().forEach(
            (x) => newStates[x.id] = newStates[x.id] ??
                TournamentsSubTreeState.initial(info: x.info),
          );
    }

    return TournamentsTreeState(states: newStates);
  }

  static TournamentsTreeState _statusChanged(
      TournamentsTreeState state, StatusChangedTournamentSystemAction action) {
    if (state == null) {
      return state;
    }

    final isTheOne = (Tournament tournament) =>
        (action.info.id.isNotNullOrEmpty && tournament.id == action.info.id) ||
        (action.info.id2.isNotNullOrEmpty && tournament.id2 == action.info.id2);

    var tournamentIndexInParent = -1;
    final tournamentParent = state.states.entries.firstWhere(
      (x) {
        final value = x.value;
        if (value is DataTournamentsSubTreeState) {
          tournamentIndexInParent = value.tree.children
              .indexWhere((dynamic x) => x is Tournament && isTheOne(x));

          return tournamentIndexInParent >= 0;
        } else {
          return false;
        }
      },
      orElse: () => null,
    );

    if (tournamentParent == null) {
      return state;
    }

    final parentValue = tournamentParent.value as DataTournamentsSubTreeState;
    final newChildren = List<dynamic>.from(parentValue.tree.children);
    newChildren[tournamentIndexInParent] =
        (newChildren[tournamentIndexInParent] as Tournament)
            .copyWith(status: action.status);
    final newParentValue = parentValue.copyWith.tree(children: newChildren);
    final newStates = Map<String, TournamentsSubTreeState>.from(state.states);
    newStates[tournamentParent.key] = newParentValue;

    return TournamentsTreeState(states: newStates);
  }
}
