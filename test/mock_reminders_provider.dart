import 'package:mobxtestingdemo/provider/reminders_provider.dart';
import 'package:mobxtestingdemo/state/reminder.dart';
import 'utils.dart';

final mockReminder1DateTime = DateTime(2000, 1, 2, 3, 4, 5, 6, 7);
final mockReminder1Id = '1';
final mockReminder1Text = 'text1';
final mockReminder1IsDone = true;
final mockReminder1 = Reminder(
    id: mockReminder1Id,
    creationDate: mockReminder1DateTime,
    text: mockReminder1Text,
    isDone: mockReminder1IsDone,
);

final mockReminder2DateTime = DateTime(2001, 1, 2, 3, 4, 5, 6, 7);
final mockReminder2Id = '2';
final mockReminder2Text = 'text2';
final mockReminder2IsDone = false;
final mockReminder2 = Reminder(
  id: mockReminder2Id,
  creationDate: mockReminder2DateTime,
  text: mockReminder2Text,
  isDone: mockReminder2IsDone,
);

final Iterable<Reminder> mockReminders = [
  mockReminder1,
  mockReminder2,
];

const mockReminderId = 'mockreminderid';

class MockReminderProvider implements ReminderProvider{

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

}