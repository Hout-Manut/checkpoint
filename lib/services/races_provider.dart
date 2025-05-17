import 'package:flutter/material.dart';
import 'package:checkpoint/entities/helpers/async_value.dart';
import 'package:checkpoint/entities/models/race_model.dart';
import 'package:checkpoint/repositories/r1_race/base.dart';
import 'package:checkpoint/services/user_service.dart';

class RacesProvider extends ChangeNotifier {
  RacesProvider(this.repo) {
    getAllRaces();
  }

  final RaceRepo repo;
  AsyncValue<List<Race>> allRaces = AsyncValue.initial();

  void getAllRaces() async {
    allRaces = AsyncValue.loading();
    notifyListeners();
    try {
      List<Race> races = await repo.getAllRaces(userId: UserService.userId);

      if (races.isEmpty) {
        allRaces = AsyncValue.empty();
      } else {
        allRaces = AsyncValue.success(races);
      }
    } catch (e) {
      allRaces = AsyncValue.error(e);
      notifyListeners();
    }
    notifyListeners();
  }
}
