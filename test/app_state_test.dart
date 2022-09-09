

import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobxtestingdemo/state/app_state.dart';

import 'mock_auth_service.dart';
import 'mock_image_service.dart';
import 'mock_reminders_service.dart';

void main() {
  late AppState appState;
  setUp(() {
    appState = AppState(
        authService: MockAuthService(),
        reminderService: MockReminderService(),
        imageUploadService: MockImageService(),
    );
  });

  test('Initial Text', () {
    expect(
      appState.currentScreen,
      AppScreen.login,
    );
    appState.authError.expectNull();
    appState.isLoading.expectFalse();
    appState.reminders.isEmpty.expectTrue();
  });

  test(
      'Going to screen', () {
    appState.goTo(AppScreen.register);
    expect(
        appState.currentScreen,
        AppScreen.register,
    );

    appState.goTo(AppScreen.reminders);
    expect(
      appState.currentScreen,
      AppScreen.reminders,
    );

    appState.goTo(AppScreen.login);
    expect(
      appState.currentScreen,
      AppScreen.login,
    );
  });

  test(
      'Initializing the app State', ()  async {
        await appState.initialize();

        expect(
          appState.currentScreen,
          AppScreen.reminders,
        );

    //reminders should have be loaded
    expect(
        appState.reminders.length,
        mockReminders.length,
    );
     appState.reminders.contains(mockReminder1).expectTrue();
     appState.reminders.contains(mockReminder2).expectTrue();
  });

  test(
      'modify reminders', () async {
        await appState.initialize();
        await appState.modifyReminder(
            reminderId: mockReminder1Id,
            isDone: false,
        );
        await appState.modifyReminder(
            reminderId: mockReminder2Id,
            isDone: true,
        );

        final reminder1 = appState.reminders.firstWhere(
                (reminder) => reminder.id == mockReminder1Id);
        final reminder2 = appState.reminders.firstWhere(
                (reminder) => reminder.id == mockReminder2Id);

          reminder1.isDone.expectFalse();
          reminder2.isDone.expectTrue();
  });

  test(
      'Create reminder', () async {
       await appState.initialize();
       const text = 'text';
       final didCreate = await appState.createReminder(
           text,
       );
        didCreate.expectTrue();

        expect(
         appState.reminders.length,
         mockReminders.length + 1,
       );
       final testReminder = appState.reminders.firstWhere(
             (element) => element.id == mockReminderId,
       );
       expect(
         testReminder.text,
         text,
       );
        testReminder.isDone.expectFalse();
  });

  test(
      'Delete reminder', () async {
     await appState.initialize();
     final count = appState.reminders.length;
     final reminder = appState.reminders.first;
     final deleted = await appState.delete(reminder);

     deleted.expectTrue();
     expect(
       appState.reminders.length,
       count - 1,
     );
  });

  test(
      'Delete Account', () async {
        await appState.initialize();
        final couldDeletedAccount = await appState.deleteAccount();

        couldDeletedAccount.expectTrue();
        appState.reminders.isEmpty.expectTrue();
        expect(
          appState.currentScreen,
          AppScreen.login,
        );
  });

  test(
      'Logging out', () async {
    await appState.initialize();
    await appState.logOut();

    appState.reminders.isEmpty.expectTrue();
    expect(
      appState.currentScreen,
      AppScreen.login,
    );
  });

  test(
      'Uploading Image for reminder', () async{
    await appState.initialize();
    final reminder = appState.reminders.firstWhere(
            (element) => element.id == mockReminder1.id,
    );
    reminder.hasImage.expectFalse();
    reminder.imageData.expectNull();

    //fake uplod imeg
    final couldUploadImage = await appState.upload(
        filePath: 'dummy_path',
        forReminderId: reminder.id,
    );
    couldUploadImage.expectTrue();
    reminder.hasImage.expectTrue();
    reminder.imageData.expectNull();

    final imageData = await appState.getReminderImage(
      reminderId: reminder.id,
    );
    imageData.expectNotNull();
    imageData!.isEqualTo(mockReminder1ImageData).expectTrue();
  });
  }

  extension Expectations on Object? {
  void expectNull() => expect(this, isNull);
  void expectNotNull() => expect(this, isNotNull);
  }

  extension BoolExpectations on bool {
  void expectTrue() => expect(this, true);
  void expectFalse() => expect(this, false);
  }

  extension Comparison<E> on List<E> {
  bool isEqualTo(List<E> other) {
    if (identical(this, other)) {
      return true;
    }
    if (length != other.length) {
      return false;
    }
    for(var i = 0; i< length;i++) {
      if (this[i] != other[i]) {
        return false;
      }
    }
    return true;
   }
  }

