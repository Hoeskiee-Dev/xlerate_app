import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:xlerate/domain/entities/announcement.dart';

final dioProvider = Provider((ref) => Dio());

final announcementListProvider = FutureProvider<List<Announcement>>((
  ref,
) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get(
    'https://6a69e9dcb2789286ad712ba3.mockapi.io/api/v1/announcements',
  );

  final List<dynamic> data = response.data;
  return data.map((json) => Announcement.fromJson(json)).toList();
});

final announcementActionProvider = Provider((ref) {
  return AnnouncementActions(ref);
});

class AnnouncementActions {
  final Ref ref;
  AnnouncementActions(this.ref);

  Future<void> createAnnouncement(Announcement newAnnouncement) async {
    final dio = ref.read(dioProvider);

    await dio.post(
      'https://6a69e9dcb2789286ad712ba3.mockapi.io/api/v1/announcements',
      data: newAnnouncement.toJson(),
    );

    ref.invalidate(announcementListProvider);
  }
}
