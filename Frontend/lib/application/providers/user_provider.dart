import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Sebawi/data/services/api_path.dart';

class UserNotifier extends AsyncNotifier<String?>{
  @override
  Future<String?> build() async {
    return await _fetchUser();
  }
  Future <String?> _fetchUser() async {
    final service = RemoteService();
    return await service.getUser() ?? "";
  }
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchUser());
  }
}

final userProvider = AsyncNotifierProvider<UserNotifier, String?>(() {
  return UserNotifier();
});