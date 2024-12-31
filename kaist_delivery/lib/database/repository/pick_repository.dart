import '../../common/util/logger.dart';
import '../dao/pick_dao.dart';
import '../model/pick_model.dart';

class PickRepository {
  final PickDao _dao = PickDao();

  // CREATE
  Future<int> insertPick(PickModel pick) async {
    Log.info('Pick Repo - insertPick: $pick');
    return await _dao.insertPick(pick);
  }

  // READ (전체)
  Future<List<PickModel>> getAllPicks() async {
    Log.info('Pick Repo - getAllPicks');
    return await _dao.getAllPicks();
  }

  // READ (단일)
  Future<PickModel?> getPickById(int id) async {
    Log.info('Pick Repo - getPickById: $id');
    return await _dao.getPickById(id);
  }

  // UPDATE
  Future<int> updatePick(PickModel pick) async {
    Log.info('Pick Repo - updatePick: $pick');
    return await _dao.updatePick(pick);
  }

  // DELETE (단일)
  Future<int> deletePick(int id) async {
    Log.info('Pick Repo - deletePick by id: $id');
    return await _dao.deletePick(id);
  }

  // DELETE (전체)
  Future<int> deleteAllPicks() async {
    Log.info('Pick Repo - deleteAllPicks');
    return await _dao.deleteAllPicks();
  }

  // 특정 이름으로 삭제
  Future<int> deletePickByName(String name) async {
    Log.info('Pick Repo - deletePick by name: $name');
    return await _dao.deleteByName(name);
  }

  // 특정 이름을 새 이름으로 업데이트
  Future<int> updatePickName(String oldName, String newName) async {
    Log.info('Pick Repo - updatePickName: $oldName -> $newName');
    return await _dao.updateName(oldName, newName);
  }
}
