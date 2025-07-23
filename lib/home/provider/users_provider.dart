import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:register_app/home/models/users_model.dart';
import 'package:register_app/home/repositories/users_repositories.dart';

class UserProvider with ChangeNotifier {
  final UserRepositories _repo = UserRepositories();

  final PagingController<int, Users> pagingController = PagingController(
    firstPageKey: 1,
  );

  static const int _pageSize = 5;

  UserProvider() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final result = await _repo.fetchUsers(page: pageKey, limit: _pageSize);
      final isLastPage = result.users!.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(result.users!);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(result.users!, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void reset() {
    pagingController.refresh();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}
