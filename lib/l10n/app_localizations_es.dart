// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'TaskTamer';

  @override
  String get welcomeBack => 'Bienvenido de nuevo';

  @override
  String get createAccount => 'Crea tu cuenta';

  @override
  String get loginToContinue => 'Inicia sesión para continuar';

  @override
  String get registerToOrganize => 'Regístrate para organizar tus tareas';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get loginBtn => 'Iniciar sesión';

  @override
  String get registerBtn => 'Registrarse';

  @override
  String get dontHaveAccount => '¿No tienes una cuenta? Regístrate';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta? Inicia sesión';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get unexpectedError => 'Ocurrió un error inesperado';

  @override
  String get loginSuccess => 'Inicio de sesión exitoso';

  @override
  String get registerSuccess => 'Registro exitoso.';

  @override
  String get tasks => 'Tareas';

  @override
  String get ranking => 'Ranking';

  @override
  String get rewards => 'Premios';

  @override
  String get settings => 'Ajustes';

  @override
  String get yourGroups => 'Tus Grupos';

  @override
  String get noActiveGroup => 'Aún no tienes un grupo activo';

  @override
  String get createOrJoinGroupDesc =>
      'Crea uno nuevo para invitar a tus amigos o únete a uno existente usando un código de invitación.';

  @override
  String get createNewGroupBtn => 'Crear un nuevo grupo';

  @override
  String get iHaveInviteCodeBtn => 'Tengo un código de invitación';

  @override
  String get join => 'Unirse';

  @override
  String get newGroup => 'Nuevo Grupo';

  @override
  String get createGroupTitle => 'Crear un nuevo grupo';

  @override
  String get groupNameLabel => 'Nombre del grupo';

  @override
  String get groupDescLabel => 'Descripción (Opcional)';

  @override
  String get createGroupAction => 'Crear Grupo';

  @override
  String get joinGroupTitle => 'Unirse a un grupo';

  @override
  String get joinGroupDesc =>
      'Ingresa el código de 8 caracteres que te compartieron.';

  @override
  String get inviteCodeLabel => 'Código de Invitación';

  @override
  String get myGroups => 'Mis Grupos';

  @override
  String get changeCreateJoinGroup => 'Cambiar de grupo activo, crear o unirse';

  @override
  String get accountAndGroups => 'Cuenta y Grupos';

  @override
  String get security => 'Seguridad';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String groupCreatedSuccessfully(String name) {
    return '¡Grupo $name creado exitosamente!';
  }

  @override
  String get errorCreatingGroup =>
      'Error al crear el grupo. Inténtalo de nuevo.';

  @override
  String joinedGroupSuccessfully(String name) {
    return '¡Te has unido a $name!';
  }

  @override
  String get invalidInviteCode => 'Código de invitación no válido o no existe.';

  @override
  String get alreadyInGroupOrError =>
      'Ya perteneces a este grupo o hubo un error.';

  @override
  String get createTaskTitle => 'Crear Tarea';

  @override
  String get taskTitleLabel => 'Título de la tarea';

  @override
  String get taskDescLabel => 'Descripción';

  @override
  String get isReusableLabel => '¿Es reutilizable?';

  @override
  String get resetFrequencyLabel => 'Frecuencia de reinicio';

  @override
  String get difficultyMultiplierLabel =>
      'Multiplicador de recompensa (Dificultad)';

  @override
  String get createTaskAction => 'Guardar Tarea';

  @override
  String get taskCreatedSuccessfully => '¡Tarea creada exitosamente!';

  @override
  String get freqInstant => 'Instantáneo (Siempre)';

  @override
  String get freqDaily => 'Diario';

  @override
  String get freqWeekly => 'Semanal';

  @override
  String get emptyTasksTitle => 'Aún no hay tareas';

  @override
  String get emptyTasksDesc =>
      'Crea la primera tarea para que tu grupo empiece a ganar puntos.';

  @override
  String get difficulty => 'Dificultad';

  @override
  String get reusable => 'Reutilizable';

  @override
  String get oneTime => 'Única vez';

  @override
  String get activeTaskTitle => 'Tarea en Progreso';

  @override
  String get completeTaskAction => 'Completar Tarea';

  @override
  String get cancelTaskAction => 'Abandonar';

  @override
  String get timeElapsed => 'Tiempo Transcurrido';

  @override
  String get pause => 'Pausar';

  @override
  String get resume => 'Reanudar';

  @override
  String get start => 'Iniciar temporizador';

  @override
  String get earnedCoinsTitle => '¡Tarea Completada!';

  @override
  String earnedCoinsDesc(int coins) {
    return 'Has ganado $coins monedas por tu esfuerzo.';
  }

  @override
  String get awesome => '¡Genial!';

  @override
  String get myGlobalCoins => 'Mis Monedas Globales';

  @override
  String get equipped => 'Equipado';

  @override
  String get equip => 'Equipar';

  @override
  String get cosmeticDefaultName => 'Básico';

  @override
  String get cosmeticDefaultDesc => 'El estilo por defecto';

  @override
  String get cosmeticGoldName => 'Rey Dorado';

  @override
  String get cosmeticGoldDesc => 'Tu nombre brillará en oro';

  @override
  String get cosmeticHackerName => 'Hacker';

  @override
  String get cosmeticHackerDesc => 'Terminal verde';

  @override
  String get cosmeticNeonName => 'Neón Cyberpunk';

  @override
  String get cosmeticNeonDesc => 'Brillo que encandila';

  @override
  String get cosmeticFireName => 'Llamas';

  @override
  String get cosmeticFireDesc => 'Demuestra que estás en racha';

  @override
  String get insufficientCoins => 'No tienes suficientes monedas globales.';
}
