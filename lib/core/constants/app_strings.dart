/// All the app texts and image paths in one place.
class AppStrings {
  // General
  static const String appTitle = 'Sabores de Canarias';

  // Welcome screen
  static const String welcomeBackground = 'assets/images/fondo.jpg';
  static const String welcomeTitle = '¡Bienvenido a\nSabores de Canarias!';
  static const String welcomeSubtitle =
      'Descubre los platos y productos típicos de las 8 islas.';
  static const String startButton = 'Empezar';

  // Drawer
  static const String menuHome = 'Inicio';
  static const String menuPortfolio = 'Portfolio';
  static const String menuDishes = 'Gestionar platos';
  static const String menuSettings = 'Ajustes';

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
  static const String profilePhoto = 'assets/images/EllieTLOU1.png';

  static const String repositoryImage = 'assets/images/Naughty_Dog_Logo.png';
  static const String repositoryName = 'Ellie Williams';
  static const String repositoryQuote =
      '"Si quieres sobrevivir en este mundo, necesitas ser fuerte y valiente. '
      'También necesitas tener un poco de suerte."';
  static const String repositoryUrl = 'https://thelastofus.fandom.com/wiki/Ellie_Williams';
}
