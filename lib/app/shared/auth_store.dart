import 'package:cuidapet_fornecedor/app/models/user_model.dart';
import 'package:cuidapet_fornecedor/app/repositories/shared_prefs_repository.dart';
import 'package:mobx/mobx.dart';
part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  @observable
  UserModel loggedUser;

  @action
  Future<void> loadUser() async {
    final prefs = await SharedPrefsRepository.instance;
    loggedUser = prefs.userData;
  }

  @action
  Future<bool> isLogged() async {
    final prefs = await SharedPrefsRepository.instance;
    final accessToken = prefs.accessToken;

    return accessToken != null;
  }
}
