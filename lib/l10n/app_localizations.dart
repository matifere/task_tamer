import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'TaskTamer'**
  String get appTitle;

  /// No description provided for @welcomeBack.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido de nuevo'**
  String get welcomeBack;

  /// No description provided for @createAccount.
  ///
  /// In es, this message translates to:
  /// **'Crea tu cuenta'**
  String get createAccount;

  /// No description provided for @loginToContinue.
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión para continuar'**
  String get loginToContinue;

  /// No description provided for @registerToOrganize.
  ///
  /// In es, this message translates to:
  /// **'Regístrate para organizar tus tareas'**
  String get registerToOrganize;

  /// No description provided for @emailLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get passwordLabel;

  /// No description provided for @loginBtn.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get loginBtn;

  /// No description provided for @registerBtn.
  ///
  /// In es, this message translates to:
  /// **'Registrarse'**
  String get registerBtn;

  /// No description provided for @dontHaveAccount.
  ///
  /// In es, this message translates to:
  /// **'¿No tienes una cuenta? Regístrate'**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In es, this message translates to:
  /// **'¿Ya tienes una cuenta? Inicia sesión'**
  String get alreadyHaveAccount;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In es, this message translates to:
  /// **'Las contraseñas no coinciden'**
  String get passwordsDoNotMatch;

  /// No description provided for @unexpectedError.
  ///
  /// In es, this message translates to:
  /// **'Ocurrió un error inesperado'**
  String get unexpectedError;

  /// No description provided for @loginSuccess.
  ///
  /// In es, this message translates to:
  /// **'Inicio de sesión exitoso'**
  String get loginSuccess;

  /// No description provided for @registerSuccess.
  ///
  /// In es, this message translates to:
  /// **'Registro exitoso.'**
  String get registerSuccess;

  /// No description provided for @tasks.
  ///
  /// In es, this message translates to:
  /// **'Tareas'**
  String get tasks;

  /// No description provided for @ranking.
  ///
  /// In es, this message translates to:
  /// **'Ranking'**
  String get ranking;

  /// No description provided for @rewards.
  ///
  /// In es, this message translates to:
  /// **'Premios'**
  String get rewards;

  /// No description provided for @settings.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get settings;

  /// No description provided for @yourGroups.
  ///
  /// In es, this message translates to:
  /// **'Tus Grupos'**
  String get yourGroups;

  /// No description provided for @noActiveGroup.
  ///
  /// In es, this message translates to:
  /// **'Aún no tienes un grupo activo'**
  String get noActiveGroup;

  /// No description provided for @createOrJoinGroupDesc.
  ///
  /// In es, this message translates to:
  /// **'Crea uno nuevo para invitar a tus amigos o únete a uno existente usando un código de invitación.'**
  String get createOrJoinGroupDesc;

  /// No description provided for @createNewGroupBtn.
  ///
  /// In es, this message translates to:
  /// **'Crear un nuevo grupo'**
  String get createNewGroupBtn;

  /// No description provided for @iHaveInviteCodeBtn.
  ///
  /// In es, this message translates to:
  /// **'Tengo un código de invitación'**
  String get iHaveInviteCodeBtn;

  /// No description provided for @join.
  ///
  /// In es, this message translates to:
  /// **'Unirse'**
  String get join;

  /// No description provided for @newGroup.
  ///
  /// In es, this message translates to:
  /// **'Nuevo Grupo'**
  String get newGroup;

  /// No description provided for @createGroupTitle.
  ///
  /// In es, this message translates to:
  /// **'Crear un nuevo grupo'**
  String get createGroupTitle;

  /// No description provided for @groupNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre del grupo'**
  String get groupNameLabel;

  /// No description provided for @groupDescLabel.
  ///
  /// In es, this message translates to:
  /// **'Descripción (Opcional)'**
  String get groupDescLabel;

  /// No description provided for @createGroupAction.
  ///
  /// In es, this message translates to:
  /// **'Crear Grupo'**
  String get createGroupAction;

  /// No description provided for @joinGroupTitle.
  ///
  /// In es, this message translates to:
  /// **'Unirse a un grupo'**
  String get joinGroupTitle;

  /// No description provided for @joinGroupDesc.
  ///
  /// In es, this message translates to:
  /// **'Ingresa el código de 8 caracteres que te compartieron.'**
  String get joinGroupDesc;

  /// No description provided for @inviteCodeLabel.
  ///
  /// In es, this message translates to:
  /// **'Código de Invitación'**
  String get inviteCodeLabel;

  /// No description provided for @myGroups.
  ///
  /// In es, this message translates to:
  /// **'Mis Grupos'**
  String get myGroups;

  /// No description provided for @changeCreateJoinGroup.
  ///
  /// In es, this message translates to:
  /// **'Cambiar de grupo activo, crear o unirse'**
  String get changeCreateJoinGroup;

  /// No description provided for @accountAndGroups.
  ///
  /// In es, this message translates to:
  /// **'Cuenta y Grupos'**
  String get accountAndGroups;

  /// No description provided for @security.
  ///
  /// In es, this message translates to:
  /// **'Seguridad'**
  String get security;

  /// No description provided for @logout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get logout;

  /// No description provided for @groupCreatedSuccessfully.
  ///
  /// In es, this message translates to:
  /// **'¡Grupo {name} creado exitosamente!'**
  String groupCreatedSuccessfully(String name);

  /// No description provided for @errorCreatingGroup.
  ///
  /// In es, this message translates to:
  /// **'Error al crear el grupo. Inténtalo de nuevo.'**
  String get errorCreatingGroup;

  /// No description provided for @joinedGroupSuccessfully.
  ///
  /// In es, this message translates to:
  /// **'¡Te has unido a {name}!'**
  String joinedGroupSuccessfully(String name);

  /// No description provided for @invalidInviteCode.
  ///
  /// In es, this message translates to:
  /// **'Código de invitación no válido o no existe.'**
  String get invalidInviteCode;

  /// No description provided for @alreadyInGroupOrError.
  ///
  /// In es, this message translates to:
  /// **'Ya perteneces a este grupo o hubo un error.'**
  String get alreadyInGroupOrError;

  /// No description provided for @createTaskTitle.
  ///
  /// In es, this message translates to:
  /// **'Crear Tarea'**
  String get createTaskTitle;

  /// No description provided for @taskTitleLabel.
  ///
  /// In es, this message translates to:
  /// **'Título de la tarea'**
  String get taskTitleLabel;

  /// No description provided for @taskDescLabel.
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get taskDescLabel;

  /// No description provided for @isReusableLabel.
  ///
  /// In es, this message translates to:
  /// **'¿Es reutilizable?'**
  String get isReusableLabel;

  /// No description provided for @resetFrequencyLabel.
  ///
  /// In es, this message translates to:
  /// **'Frecuencia de reinicio'**
  String get resetFrequencyLabel;

  /// No description provided for @difficultyMultiplierLabel.
  ///
  /// In es, this message translates to:
  /// **'Multiplicador de recompensa (Dificultad)'**
  String get difficultyMultiplierLabel;

  /// No description provided for @createTaskAction.
  ///
  /// In es, this message translates to:
  /// **'Guardar Tarea'**
  String get createTaskAction;

  /// No description provided for @taskCreatedSuccessfully.
  ///
  /// In es, this message translates to:
  /// **'¡Tarea creada exitosamente!'**
  String get taskCreatedSuccessfully;

  /// No description provided for @freqInstant.
  ///
  /// In es, this message translates to:
  /// **'Instantáneo (Siempre)'**
  String get freqInstant;

  /// No description provided for @freqDaily.
  ///
  /// In es, this message translates to:
  /// **'Diario'**
  String get freqDaily;

  /// No description provided for @freqWeekly.
  ///
  /// In es, this message translates to:
  /// **'Semanal'**
  String get freqWeekly;

  /// No description provided for @emptyTasksTitle.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay tareas'**
  String get emptyTasksTitle;

  /// No description provided for @emptyTasksDesc.
  ///
  /// In es, this message translates to:
  /// **'Crea la primera tarea para que tu grupo empiece a ganar puntos.'**
  String get emptyTasksDesc;

  /// No description provided for @difficulty.
  ///
  /// In es, this message translates to:
  /// **'Dificultad'**
  String get difficulty;

  /// No description provided for @reusable.
  ///
  /// In es, this message translates to:
  /// **'Reutilizable'**
  String get reusable;

  /// No description provided for @oneTime.
  ///
  /// In es, this message translates to:
  /// **'Única vez'**
  String get oneTime;

  /// No description provided for @activeTaskTitle.
  ///
  /// In es, this message translates to:
  /// **'Tarea en Progreso'**
  String get activeTaskTitle;

  /// No description provided for @completeTaskAction.
  ///
  /// In es, this message translates to:
  /// **'Completar Tarea'**
  String get completeTaskAction;

  /// No description provided for @cancelTaskAction.
  ///
  /// In es, this message translates to:
  /// **'Abandonar'**
  String get cancelTaskAction;

  /// No description provided for @timeElapsed.
  ///
  /// In es, this message translates to:
  /// **'Tiempo Transcurrido'**
  String get timeElapsed;

  /// No description provided for @pause.
  ///
  /// In es, this message translates to:
  /// **'Pausar'**
  String get pause;

  /// No description provided for @resume.
  ///
  /// In es, this message translates to:
  /// **'Reanudar'**
  String get resume;

  /// No description provided for @start.
  ///
  /// In es, this message translates to:
  /// **'Iniciar temporizador'**
  String get start;

  /// No description provided for @earnedCoinsTitle.
  ///
  /// In es, this message translates to:
  /// **'¡Tarea Completada!'**
  String get earnedCoinsTitle;

  /// No description provided for @earnedCoinsDesc.
  ///
  /// In es, this message translates to:
  /// **'Has ganado {coins} monedas por tu esfuerzo.'**
  String earnedCoinsDesc(int coins);

  /// No description provided for @awesome.
  ///
  /// In es, this message translates to:
  /// **'¡Genial!'**
  String get awesome;

  /// No description provided for @myGlobalCoins.
  ///
  /// In es, this message translates to:
  /// **'Mis Monedas Globales'**
  String get myGlobalCoins;

  /// No description provided for @equipped.
  ///
  /// In es, this message translates to:
  /// **'Equipado'**
  String get equipped;

  /// No description provided for @equip.
  ///
  /// In es, this message translates to:
  /// **'Equipar'**
  String get equip;

  /// No description provided for @cosmeticDefaultName.
  ///
  /// In es, this message translates to:
  /// **'Básico'**
  String get cosmeticDefaultName;

  /// No description provided for @cosmeticDefaultDesc.
  ///
  /// In es, this message translates to:
  /// **'El estilo por defecto'**
  String get cosmeticDefaultDesc;

  /// No description provided for @cosmeticGoldName.
  ///
  /// In es, this message translates to:
  /// **'Rey Dorado'**
  String get cosmeticGoldName;

  /// No description provided for @cosmeticGoldDesc.
  ///
  /// In es, this message translates to:
  /// **'Tu nombre brillará en oro'**
  String get cosmeticGoldDesc;

  /// No description provided for @cosmeticHackerName.
  ///
  /// In es, this message translates to:
  /// **'Hacker'**
  String get cosmeticHackerName;

  /// No description provided for @cosmeticHackerDesc.
  ///
  /// In es, this message translates to:
  /// **'Terminal verde'**
  String get cosmeticHackerDesc;

  /// No description provided for @cosmeticNeonName.
  ///
  /// In es, this message translates to:
  /// **'Neón Cyberpunk'**
  String get cosmeticNeonName;

  /// No description provided for @cosmeticNeonDesc.
  ///
  /// In es, this message translates to:
  /// **'Brillo que encandila'**
  String get cosmeticNeonDesc;

  /// No description provided for @cosmeticFireName.
  ///
  /// In es, this message translates to:
  /// **'Llamas'**
  String get cosmeticFireName;

  /// No description provided for @cosmeticFireDesc.
  ///
  /// In es, this message translates to:
  /// **'Demuestra que estás en racha'**
  String get cosmeticFireDesc;

  /// No description provided for @insufficientCoins.
  ///
  /// In es, this message translates to:
  /// **'No tienes suficientes monedas globales.'**
  String get insufficientCoins;

  /// No description provided for @cosmeticOceanName.
  ///
  /// In es, this message translates to:
  /// **'Océano'**
  String get cosmeticOceanName;

  /// No description provided for @cosmeticOceanDesc.
  ///
  /// In es, this message translates to:
  /// **'Profundo y sereno'**
  String get cosmeticOceanDesc;

  /// No description provided for @cosmeticRainbowName.
  ///
  /// In es, this message translates to:
  /// **'Arcoíris'**
  String get cosmeticRainbowName;

  /// No description provided for @cosmeticRainbowDesc.
  ///
  /// In es, this message translates to:
  /// **'Todos los colores'**
  String get cosmeticRainbowDesc;

  /// No description provided for @cosmeticGlitchName.
  ///
  /// In es, this message translates to:
  /// **'Glitch'**
  String get cosmeticGlitchName;

  /// No description provided for @cosmeticGlitchDesc.
  ///
  /// In es, this message translates to:
  /// **'Efecto distorsión'**
  String get cosmeticGlitchDesc;

  /// No description provided for @cosmeticBubblegumName.
  ///
  /// In es, this message translates to:
  /// **'Chicle'**
  String get cosmeticBubblegumName;

  /// No description provided for @cosmeticBubblegumDesc.
  ///
  /// In es, this message translates to:
  /// **'Dulce y vibrante'**
  String get cosmeticBubblegumDesc;

  /// No description provided for @cosmeticIceName.
  ///
  /// In es, this message translates to:
  /// **'Hielo Polar'**
  String get cosmeticIceName;

  /// No description provided for @cosmeticIceDesc.
  ///
  /// In es, this message translates to:
  /// **'Frío como el viento'**
  String get cosmeticIceDesc;

  /// No description provided for @tabNames.
  ///
  /// In es, this message translates to:
  /// **'Estilos de Nombre'**
  String get tabNames;

  /// No description provided for @tabAvatars.
  ///
  /// In es, this message translates to:
  /// **'Avatares Animados'**
  String get tabAvatars;

  /// No description provided for @avatarSmileName.
  ///
  /// In es, this message translates to:
  /// **'Sonrisa'**
  String get avatarSmileName;

  /// No description provided for @avatarSmileDesc.
  ///
  /// In es, this message translates to:
  /// **'Un clásico feliz'**
  String get avatarSmileDesc;

  /// No description provided for @avatarMoneyName.
  ///
  /// In es, this message translates to:
  /// **'Billetes'**
  String get avatarMoneyName;

  /// No description provided for @avatarMoneyDesc.
  ///
  /// In es, this message translates to:
  /// **'Oliendo la riqueza'**
  String get avatarMoneyDesc;

  /// No description provided for @avatarMeltingName.
  ///
  /// In es, this message translates to:
  /// **'Derritiéndose'**
  String get avatarMeltingName;

  /// No description provided for @avatarMeltingDesc.
  ///
  /// In es, this message translates to:
  /// **'Demasiado calor'**
  String get avatarMeltingDesc;

  /// No description provided for @avatarGrimacingName.
  ///
  /// In es, this message translates to:
  /// **'Mueca'**
  String get avatarGrimacingName;

  /// No description provided for @avatarGrimacingDesc.
  ///
  /// In es, this message translates to:
  /// **'¡Ups, lo siento!'**
  String get avatarGrimacingDesc;

  /// No description provided for @avatarCryingName.
  ///
  /// In es, this message translates to:
  /// **'Llorando'**
  String get avatarCryingName;

  /// No description provided for @avatarCryingDesc.
  ///
  /// In es, this message translates to:
  /// **'Lágrimas a mares'**
  String get avatarCryingDesc;

  /// No description provided for @avatarTongueName.
  ///
  /// In es, this message translates to:
  /// **'Burlón'**
  String get avatarTongueName;

  /// No description provided for @avatarTongueDesc.
  ///
  /// In es, this message translates to:
  /// **'Sacando la lengua'**
  String get avatarTongueDesc;

  /// No description provided for @avatarHearNoEvilName.
  ///
  /// In es, this message translates to:
  /// **'Mono Sordo'**
  String get avatarHearNoEvilName;

  /// No description provided for @avatarHearNoEvilDesc.
  ///
  /// In es, this message translates to:
  /// **'No escucho nada'**
  String get avatarHearNoEvilDesc;

  /// No description provided for @avatarSeeNoEvilName.
  ///
  /// In es, this message translates to:
  /// **'Mono Ciego'**
  String get avatarSeeNoEvilName;

  /// No description provided for @avatarSeeNoEvilDesc.
  ///
  /// In es, this message translates to:
  /// **'No veo nada'**
  String get avatarSeeNoEvilDesc;

  /// No description provided for @avatarSayNoEvilName.
  ///
  /// In es, this message translates to:
  /// **'Mono Mudo'**
  String get avatarSayNoEvilName;

  /// No description provided for @avatarSayNoEvilDesc.
  ///
  /// In es, this message translates to:
  /// **'No digo nada'**
  String get avatarSayNoEvilDesc;

  /// No description provided for @avatarOctopusName.
  ///
  /// In es, this message translates to:
  /// **'Pulpo'**
  String get avatarOctopusName;

  /// No description provided for @avatarOctopusDesc.
  ///
  /// In es, this message translates to:
  /// **'Tentáculos juguetones'**
  String get avatarOctopusDesc;

  /// No description provided for @avatarTurtleName.
  ///
  /// In es, this message translates to:
  /// **'Tortuga'**
  String get avatarTurtleName;

  /// No description provided for @avatarTurtleDesc.
  ///
  /// In es, this message translates to:
  /// **'Lento pero seguro'**
  String get avatarTurtleDesc;

  /// No description provided for @avatarFireEmojiName.
  ///
  /// In es, this message translates to:
  /// **'Fueguito'**
  String get avatarFireEmojiName;

  /// No description provided for @avatarFireEmojiDesc.
  ///
  /// In es, this message translates to:
  /// **'¡Qué calor!'**
  String get avatarFireEmojiDesc;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
