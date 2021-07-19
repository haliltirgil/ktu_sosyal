import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ktu_sosyal/models/group_list_model.dart';
import 'package:ktu_sosyal/models/group_model.dart';
import 'package:ktu_sosyal/models/user_model.dart';
import 'package:ktu_sosyal/repositories/group_repository.dart';
import 'package:ktu_sosyal/services/id_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupProvider with ChangeNotifier {
  var dio = Dio();

  List<Group> _myGroups = <Group>[];
  List<Group> _allGroups = <Group>[];
  List<Group> _allGroupsSearch = <Group>[];
  List<Group> _myGroupsSearch = <Group>[];
  List<User> _groupMembers = <User>[];
  Group? group;
  bool? _isLoading;
  bool? _isJoined;
  bool? _isDeleted;

  List<Group> get myGroups => _myGroups;
  List<Group> get allGroups => _allGroups;
  List<Group> get allGroupsSearch => _allGroupsSearch;
  List<Group> get myGroupsSearch => _myGroupsSearch;
  List<User> get groupMembers => _groupMembers;
  bool? get isLoading => _isLoading;
  bool? get isJoined => _isJoined;
  bool? get isDeleted => _isDeleted;

  Future<String> createGroup(String name, String faculty) async {
    Response response;
    response = await dio.post(
      'http://51.138.78.233/api/groups',
      data: {'name': name, 'faculty': faculty},
      options: Options(
        headers: {'auth-token': await getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    if (response.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(name, true);
      setMyGroups();
      return "Grup Oluşturuldu!";
    } else {
      return "Grup Oluşturulamadı";
    }
  }

  Future<void> setMyGroups() async {
    Response response;
    IdService id = IdService();
    //REMINDER: get user id is the line 47
    //Map<String, dynamic> payload = Jwt.parseJwt(await getToken() ?? "");
    response = await dio.get(
      'http://51.138.78.233/api/users/${await id.getId()}/mygroups/', //todo url yanlış
      options: Options(
        headers: {'auth-token': await getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    if (response.statusCode == 200) {
      _myGroups.removeRange(0, _myGroups.length);
      for (Map<String, dynamic> group in response.data) {
        Group newGroup = Group.fromJson(group);
        _myGroups.add(newGroup);
      }
      _myGroupsSearch = _myGroups;
    }
    notifyListeners();
  }

  Future<String> deleteGroupFromDatabase(String? groupId) async {
    Response response;
    response = await dio.delete(
      'http://51.138.78.233/api/groups/$groupId',
      options: Options(
        headers: {'auth-token': await getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    if (response.statusCode == 200) {
      setMyGroups();
      return "Grup Başarıyla Silindi";
    } else if (response.statusCode == 401) {
      return "Grubu Silmeye Yetkiniz Yok";
    } else {
      return "Grup Silinemedi";
    }
  }

  Future<dynamic> getOneGroup(String groupId) async {
    _isLoading = true;
    IdService idService = IdService();
    Response response;
    String id = await idService.getId();
    _isJoined = false;
    _isDeleted = false;
    notifyListeners();
    response = await dio.get(
      'http://51.138.78.233/api/groups/$groupId',
      options: Options(
        headers: {'auth-token': await getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    if (response.data == "") {
      _isDeleted = true;
    } else {
      group = Group.fromJson(response.data);
      group!.users!.forEach((user) {
        if (user.id == id) {
          _isJoined = true;
        }
      });
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> joinGroup(String groupId) async {
    Response response = await dio.post(
      'http://51.138.78.233/api/groups/$groupId/join',
      data: {'groupId': groupId},
      options: Options(
        headers: {'auth-token': await getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      setMyGroups();
      getOneGroup(groupId);
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  Future<bool> leaveGroup(String groupId) async {
    Response response = await dio.put(
      'http://51.138.78.233/api/groups/$groupId/leave',
      data: {'groupId': groupId},
      options: Options(
        headers: {'auth-token': await getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 204) {
      setMyGroups();
      getOneGroup(groupId);
      _isJoined = false;
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  void getAllGroups() async {
    Response response;
    response = await dio.get(
      'http://51.138.78.233/api/groups',
      options: Options(
        headers: {'auth-token': await getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    if (response.statusCode == 200) {
      GroupList? list = GroupList.fromJson(response.data);
      _allGroups = list.groups ?? [];
      _allGroupsSearch = _allGroups;
    }
    notifyListeners();
  }

  void filterGroups(String searchString) {
    _allGroupsSearch = _allGroups
        .where((group) => group.name!.toLowerCase().contains(searchString))
        .toList();
    notifyListeners();
  }

  void filterMyGroups(String searchString) {
    _myGroupsSearch = _myGroups
        .where((group) => group.name!.toLowerCase().contains(searchString))
        .toList();
    notifyListeners();
  }

  Future<void> getGroupMembers(String groupId) async {
    GroupRepository groupRepository = GroupRepository();
    _isLoading = true;
    _groupMembers = await groupRepository.getGroupMembers(groupId);
    _isLoading = false;
    notifyListeners();
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString('auth-token'));
  }
}
