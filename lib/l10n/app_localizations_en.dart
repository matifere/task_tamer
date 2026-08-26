// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'TaskTamer';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get createAccount => 'Create your account';

  @override
  String get loginToContinue => 'Log in to continue';

  @override
  String get registerToOrganize => 'Sign up to organize your tasks';

  @override
  String get emailLabel => 'Email address';

  @override
  String get passwordLabel => 'Password';

  @override
  String get loginBtn => 'Log in';

  @override
  String get registerBtn => 'Sign up';

  @override
  String get dontHaveAccount => 'Don\'t have an account? Sign up';

  @override
  String get alreadyHaveAccount => 'Already have an account? Log in';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get unexpectedError => 'An unexpected error occurred';

  @override
  String get loginSuccess => 'Login successful';

  @override
  String get registerSuccess => 'Registration successful.';

  @override
  String get tasks => 'Tasks';

  @override
  String get ranking => 'Leaderboard';

  @override
  String get rewards => 'Rewards';

  @override
  String get settings => 'Settings';

  @override
  String get yourGroups => 'Your Groups';

  @override
  String get noActiveGroup => 'You don\'t have an active group yet';

  @override
  String get createOrJoinGroupDesc =>
      'Create a new one to invite your friends or join an existing one using an invitation code.';

  @override
  String get createNewGroupBtn => 'Create a new group';

  @override
  String get iHaveInviteCodeBtn => 'I have an invitation code';

  @override
  String get join => 'Join';

  @override
  String get newGroup => 'New Group';

  @override
  String get createGroupTitle => 'Create a new group';

  @override
  String get groupNameLabel => 'Group name';

  @override
  String get groupDescLabel => 'Description (Optional)';

  @override
  String get createGroupAction => 'Create Group';

  @override
  String get joinGroupTitle => 'Join a group';

  @override
  String get joinGroupDesc =>
      'Enter the 8-character code that was shared with you.';

  @override
  String get inviteCodeLabel => 'Invitation Code';

  @override
  String get myGroups => 'My Groups';

  @override
  String get changeCreateJoinGroup => 'Switch active group, create or join';

  @override
  String get accountAndGroups => 'Account & Groups';

  @override
  String get security => 'Security';

  @override
  String get logout => 'Log out';

  @override
  String groupCreatedSuccessfully(String name) {
    return 'Group $name created successfully!';
  }

  @override
  String get errorCreatingGroup =>
      'Error creating the group. Please try again.';

  @override
  String joinedGroupSuccessfully(String name) {
    return 'You have joined $name!';
  }

  @override
  String get invalidInviteCode =>
      'Invalid invitation code or group does not exist.';

  @override
  String get alreadyInGroupOrError =>
      'You already belong to this group or an error occurred.';

  @override
  String get createTaskTitle => 'Create Task';

  @override
  String get taskTitleLabel => 'Task title';

  @override
  String get taskDescLabel => 'Description';

  @override
  String get isReusableLabel => 'Is reusable?';

  @override
  String get resetFrequencyLabel => 'Reset frequency';

  @override
  String get difficultyMultiplierLabel => 'Reward multiplier (Difficulty)';

  @override
  String get createTaskAction => 'Save Task';

  @override
  String get taskCreatedSuccessfully => 'Task created successfully!';

  @override
  String get freqInstant => 'Instant (Always)';

  @override
  String get freqDaily => 'Daily';

  @override
  String get freqWeekly => 'Weekly';

  @override
  String get emptyTasksTitle => 'No tasks yet';

  @override
  String get emptyTasksDesc =>
      'Create the first task so your group can start earning points.';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get reusable => 'Reusable';

  @override
  String get oneTime => 'One-time';
}
