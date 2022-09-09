import 'dart:typed_data';

import 'package:mobxtestingdemo/services/reminders_service.dart';
import 'package:mobxtestingdemo/state/reminder.dart';
import 'utils.dart';

final mockReminder1DateTime = DateTime(2000, 1, 2, 3, 4, 5, 6, 7);
const mockReminder1Id = '1';
const mockReminder1Text = 'text1';
const mockReminder1IsDone = true;
final mockReminder1ImageData = 'image1'.toUint8List();
final mockReminder1 = Reminder(
    id: mockReminder1Id,
    creationDate: mockReminder1DateTime,
    text: mockReminder1Text,
    isDone: mockReminder1IsDone,
    hasImage: false,
);

final mockReminder2DateTime = DateTime(2001, 1, 2, 3, 4, 5, 6, 7);
const mockReminder2Id = '2';
const mockReminder2Text = 'text2';
const mockReminder2IsDone = false;
final mockReminder2ImageData = 'image2'.toUint8List();
final mockReminder2 = Reminder(
  id: mockReminder2Id,
  creationDate: mockReminder2DateTime,
  text: mockReminder2Text,
  isDone: mockReminder2IsDone,
  hasImage: false,

);

final Iterable<Reminder> mockReminders = [
  mockReminder1,
  mockReminder2,
];

const mockReminderId = 'mockreminderid';

class MockReminderService implements ReminderService{

  @override
  Future<ReminderId> createReminder({
    required String userId,
    required String text,
    required DateTime createDate,
  }) => mockReminderId.toFuture(oneSecond);

  @override
  Future<void> deleteAllDocuments({
    required String userId,
  }) => Future.delayed(oneSecond);

  @override
  Future<void> deleteReminderWithId(
        ReminderId id, {
        required String userId,
      }) => Future.delayed(oneSecond);

  @override
  Future<Iterable<Reminder>> loadReminder({
    required String userId,
  }) => mockReminders.toFuture(oneSecond);

  @override
  Future<void> modify({
    required ReminderId reminderId,
    required bool isDone,
    required String userId,
  }) => Future.delayed(oneSecond);

  @override
  Future<Uint8List?> getReminderImage({
    required String userId,
    required ReminderId reminderId,
  }) async {
    switch (reminderId){
      case mockReminder1Id:
        return mockReminder1ImageData;
      case mockReminder2Id:
        return mockReminder2ImageData;
      default:
        return null;
    }
  }

  @override
  Future<void> setReminderHasImage({
    required ReminderId reminderId,
    required String userId,
  }) async {
    mockReminders
        .firstWhere((element) => element.id== reminderId,
    )
        .hasImage = true;
  }

}