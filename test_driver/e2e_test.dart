// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Counter App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final counterTextFinder = find.byValueKey('counterText');
    final buttonFinder = find.byTooltip('Increment');
    final subtractButton = find.byValueKey('subtract');
    final alertButton = find.byValueKey('alert');
    final alertBoxText = find.byValueKey('alert_text');
    final alertBoxCloseButton = find.byValueKey('alertClose_Button');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('starts at 0', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(counterTextFinder), "0");
    });

    test('negative value is shown as well', () async {
      //Set the counter to negative value by tapping "Subtract" button.
      await driver.tap(subtractButton);

      //Then, confirm that negative value is shown in the counter bar.
      expect(await driver.getText(counterTextFinder), contains('-'));
    });

    test('increments the counter', () async {
      // First, tap the button.
      await driver.tap(buttonFinder);

      // Then, verify the counter text is incremented by 1.
      expect(await driver.getText(counterTextFinder), "0");
    });

    test('alert box functioning', () async {
      //First, initiate the Alert Box
      await driver.tap(alertButton);

      //Second, verify that text in the alert box is valid.
      expect(await driver.getText(alertBoxText), "Welcome to Flutter Automation 0");

      //Close the alert box.
      await driver.tap(alertBoxCloseButton);
    });
  });
}
