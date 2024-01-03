import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_app/main.dart' as app;
import 'package:form_app/src/keys/form_keys.dart';
import 'package:form_app/src/keys/sign_in_http_keys.dart';
import 'package:form_app/src/validation.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  group('Form Samples', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Sign with HTTP', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      var signinHttpOption = find.text('Sign in with HTTP');
      var emailInput = find.byKey(SignInHttpKeys.emailInputKey);
      var passwordInput = find.byKey(SignInHttpKeys.passwordInputKey);
      var signInButton = find.byType(TextButton);

      await tester.tap(signinHttpOption);
      await tester.pumpAndSettle();

      await tester.enterText(emailInput, 'root');

      await tester.enterText(passwordInput, 'password');

      await tester.tap(signInButton);
      await tester.pumpAndSettle();

      expect(find.text('Successfully signed in.'), findsOneWidget);
    });

    testWidgets('Story Generator', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: FormValidationDemo(),
      ));
      await tester.pumpAndSettle();

      var adjective = 'good';
      var noun = 'person';
      var adjectiveInput = find.byKey(FormKeys.adjectiveInputKey);
      var nounInput = find.byKey(FormKeys.nounInputKey);
      var agreementCheckbox = find.byType(Checkbox);
      var submitButton = find.text('Submit');

      await tester.enterText(adjectiveInput, adjective);

      await tester.enterText(nounInput, noun);

      await tester.tap(agreementCheckbox);

      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(find.text('The $adjective developer saw a $noun'), findsOneWidget);
    });
  });
}
