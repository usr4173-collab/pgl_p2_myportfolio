/// All the app texts and image paths in one place.
class AppStrings {
  // General
  static const String appTitle = 'Sabores de Canarias';

  // Welcome screen
  static const String welcomeBackground = 'assets/images/welcome/fondo.jpg';
  static const String welcomeTitle = '¡Bienvenido a\nSabores de Canarias!';
  static const String welcomeSubtitle =
      'Descubre los platos y productos típicos de las 8 islas.';
  static const String startButton = 'Empezar';

  // Drawer
  static const String menuHome = 'Inicio';
  static const String menuPortfolio = 'Portfolio';
  static const String menuDishes = 'Gestionar platos';
  static const String menuSettings = 'Ajustes';
  static const String menuLogout = 'Cerrar sesión';

  // Auth (register / login)
  static const String registerTitle = 'Crear cuenta';
  static const String loginTitle = 'Iniciar sesión';
  static const String loginButton = 'Entrar';
  static const String checkingSession = 'Comprobando sesión...';
  static const String tokenSaveError =
      'No se ha podido guardar la sesión en el dispositivo.';
  static const String goToLogin = '¿Ya tienes cuenta? Inicia sesión';
  static const String goToRegister = '¿No tienes cuenta? Regístrate';
  static const String fullName = 'Nombre completo';
  static const String email = 'Email';
  static const String password = 'Contraseña';
  static const String registerButton = 'Registrarse';
  static const String successTitle = '¡Todo correcto!';
  static const String errorTitle = 'Algo ha fallado';
  static const String accept = 'Aceptar';
  static const String connectionError =
      'No se ha podido conectar con el servidor. Inténtalo de nuevo.';

  // Dishes (CRUD)
  static const String dishesTitle = 'Gestionar platos';
  static const String noDishes = 'No hay platos. Pulsa + para añadir uno.';
  static const String addDish = 'Añadir plato';
  static const String dishName = 'Nombre';
  static const String dishIsland = 'Isla';
  static const String dishCategory = 'Categoría';
  static const String dishDescription = 'Descripción';
  static const String shortDescriptionHint = 'Una frase breve';
  static const String requiredField = 'Este campo es obligatorio';
  static const String cancel = 'Cancelar';
  static const String save = 'Guardar';
  static const String dishAdded = 'Plato añadido';
  static const String delete = 'Borrar';
  static const String deleteDishTitle = '¿Borrar plato?';
  static const String deleteDishQuestion = 'Se eliminará';
  static const String dishDeleted = 'Plato eliminado';
  static const String totalDishes = 'Total de platos';

  // Settings
  static const String settingsTitle = 'Ajustes';
  static const String favoriteIslandTitle = 'Tu isla favorita';
  static const String favoriteDishTitle = 'Tu plato favorito';
  static const String favoriteDishLabel = 'Plato favorito';
  static const String favoriteDishHint = 'Ej.: Papas arrugadas con mojo';
  static const String savedValueTitle = 'Guardado en memoria';
  static const String nothingSaved = 'Nada guardado todavía';
  static const String islandSaved = 'Isla favorita guardada';
  static const String dishSaved = 'Plato favorito guardado';
  static const String saveError = 'No se ha podido guardar';
  static const String resetSettings = 'Borrar ajustes guardados';
  static const String settingsReset = 'Ajustes borrados';

  // Portfolio
  static const String portfolioTitle = 'Portfolio';
  static const String hobbiesTab = 'Mis hobbies';
  static const String repositoryTab = 'Más sobre mí';

  static const String introduction =
      '¡Hola! Soy Ellie, tengo 14 años y vivo en un mundo postapocalíptico. '
      'Me encanta la música y tocar la guitarra, y también disfruto mucho de los videojuegos.';
  static const String profilePhoto = 'assets/images/portfolio/EllieTLOU1.png';

  static const String repositoryImage = 'assets/images/portfolio/Naughty_Dog_Logo.png';
  static const String repositoryName = 'Ellie Williams';
  static const String repositoryQuote =
      '"Si quieres sobrevivir en este mundo, necesitas ser fuerte y valiente. '
      'También necesitas tener un poco de suerte."';
  static const String repositoryUrl = 'https://thelastofus.fandom.com/wiki/Ellie_Williams';
}
