import 'package:dartx/dartx.dart';
import 'package:redux/redux.dart';
import 'package:what_when_where/data/models/tournament.dart';
import 'package:what_when_where/redux/redux_action.dart';
import 'package:what_when_where/redux/search/actions.dart';
import 'package:what_when_where/redux/search/state.dart';
import 'package:what_when_where/redux/tournament/actions.dart';

class SearchReducer {
  static final Reducer<SearchState> _reducer = combineReducers<SearchState>([
    TypedReducer<SearchState, UpdateTextSearchUserAction>(_updateText),
    TypedReducer<SearchState, UpdateSortingSearchUserAction>(_updateSorting),
    TypedReducer<SearchState, InitSearchSystemAction>(_initSearch),
    TypedReducer<SearchState, DeInitSearchSystemAction>(_deInitSearch),
    TypedReducer<SearchState, ClearResultsSearchSystemAction>(_clearResults),
    TypedReducer<SearchState, LoadingSearchSystemAction>(_loading),
    TypedReducer<SearchState, FailedSearchSystemAction>(_failed),
    TypedReducer<SearchState, CompletedSearchSystemAction>(_completed),
    TypedReducer<SearchState, StatusChangedTournamentSystemAction>(
        _statusChanged),
  ]);

  static SearchState reduce(SearchState state, ReduxAction action) =>
      _reducer(state, action);

  static SearchState _updateText(
          SearchState state, UpdateTextSearchUserAction action) =>
      state?.copyWith?.parameters(query: action.query);

  static SearchState _updateSorting(
          SearchState state, UpdateSortingSearchUserAction action) =>
      state?.copyWith?.parameters(sorting: action.sorting);

  static SearchState _initSearch(
          SearchState state, InitSearchSystemAction action) =>
      const SearchState.initial(parameters: SearchParameters());

  static SearchState _deInitSearch(
          SearchState state, DeInitSearchSystemAction action) =>
      null;

  static SearchState _clearResults(
          SearchState state, ClearResultsSearchSystemAction action) =>
      state != null
          ? SearchState.initial(
              parameters: state.parameters.copyWith(nextPage: 0))
          : state;

  static SearchState _loading(
          SearchState state, LoadingSearchSystemAction action) =>
      state != null && action.parameters == state.parameters
          ? state.parameters.nextPage > 0
              ? SearchState.loadingWithData(
                  parameters: state.parameters,
                  data: state.dataOrEmpty,
                )
              : SearchState.loadingFirstPage(
                  parameters: state.parameters,
                )
          : state;

  static SearchState _failed(
          SearchState state, FailedSearchSystemAction action) =>
      state != null && action.parameters == state.parameters
          ? state.parameters.nextPage > 0
              ? SearchState.errorWithData(
                  parameters: state.parameters,
                  exception: action.exception,
                  data: state.dataOrEmpty,
                )
              : SearchState.errorFirstPage(
                  parameters: state.parameters,
                  exception: action.exception,
                )
          : state;

  static SearchState _completed(
          SearchState state, CompletedSearchSystemAction action) =>
      state != null && action.parameters == state.parameters
          ? SearchState.data(
              parameters: state.parameters.copyWith(nextPage: action.nextPage),
              data: [...state.dataOrEmpty, ...action.data],
              canLoadMore: action.canLoadMore,
            )
          : state;

  static SearchState _statusChanged(
      SearchState state, StatusChangedTournamentSystemAction action) {
    if (state == null) {
      return state;
    }

    final isTheOne = (Tournament tournament) =>
        (action.info.id.isNotNullOrEmpty && tournament.id == action.info.id) ||
        (action.info.id2.isNotNullOrEmpty && tournament.id2 == action.info.id2);

    final index = state.dataOrEmpty.indexWhere((x) => isTheOne(x));

    if (index < 0) {
      return state;
    }

    final newData = List<Tournament>.from(state.dataOrEmpty, growable: false);
    newData[index] = newData[index].copyWith(status: action.status);

    return state.maybeMap(
      data: (value) => value.copyWith(data: newData),
      loadingWithData: (value) => value.copyWith(data: newData),
      errorWithData: (value) => value.copyWith(data: newData),
      orElse: () => state,
    );
  }
}
