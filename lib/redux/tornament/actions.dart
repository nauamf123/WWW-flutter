import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:what_when_where/db_chgk_info/models/tournament.dart';

@immutable
class SetTournament {
  final Tournament tournament;

  const SetTournament(this.tournament);

  @override
  String toString() =>
      '$SetTournament tournament.textId = "${tournament.textId}", tournament.title = "${tournament.title}"';
}

@immutable
class VoidTournament {
  const VoidTournament();

  @override
  String toString() => '$VoidTournament';
}

@immutable
class LoadTournament {
  final String tournamentId;

  const LoadTournament(this.tournamentId);

  @override
  String toString() => '$LoadTournament tournamentId = "$tournamentId"';
}

@immutable
class ReloadTournament {
  const ReloadTournament();

  @override
  String toString() => '$ReloadTournament';
}

@immutable
class TournamentIsLoading {
  final String tournamentId;

  const TournamentIsLoading(this.tournamentId);

  @override
  String toString() => '$TournamentIsLoading tournamentId = "$tournamentId"';
}

@immutable
class TournamentLoaded {
  final Tournament tournament;

  const TournamentLoaded(this.tournament);

  @override
  String toString() =>
      '$TournamentLoaded tournament.id = "${tournament.id}", tournament.title = "${tournament.title}"';
}

@immutable
class TournamentFailedLoading {
  final String tournamentId;
  final Exception exception;

  const TournamentFailedLoading(this.tournamentId, this.exception);

  @override
  String toString() =>
      '$TournamentFailedLoading tournamentId = "$tournamentId", exception.runtimeType = "${exception.runtimeType}"';
}
