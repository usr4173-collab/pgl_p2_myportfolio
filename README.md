# PGL-P2-MyPortfolio · Sabores de Canarias

App de Flutter sobre la **gastronomía canaria**. En esta tarea se añade el **registro e inicio de sesión de usuarios** contra una API REST que trabaja con **tokens JWT**.

## Rama de esta tarea

`P2-Tarea5-SesionUsuario`

## API utilizada

- URL: `https://my-users-api.onrender.com`
- Repositorio: [adhernea/my-users-api](https://github.com/adhernea/my-users-api)

| Método | Endpoint | Uso en la app |
|---|---|---|
| `POST` | `/users/register` | Pantalla de registro (`fullName`, `email`, `pwd`) |
| `POST` | `/users/login` | Pantalla de login (`email`, `pwd`) → devuelve el token |
| `GET` | `/users/check-token` | Al abrir la app, comprueba si el token guardado sigue siendo válido |
| `GET` | `/users/welcome` | Botón **Ver mensaje de bienvenida** de la pantalla Bienvenida |

Las rutas protegidas reciben el token en la cabecera `Authorization: Bearer <token>`.

> La API está en el plan gratuito de Render: tras 15 minutos sin tráfico se suspende y la primera petición tarda unos 50-60 segundos. Por eso la app usa un tiempo de espera de 60 segundos. Además, la base de datos SQLite se borra cuando el servicio se reinicia, así que los usuarios registrados pueden desaparecer.

## Capturas

| Registro exitoso | Login fallido |
|:---:|:---:|
| ![Registro exitoso](screenshots/05_registro_exitoso.png) | ![Login fallido](screenshots/06_login_fallido.png) |

| Login exitoso | Mensaje de bienvenida |
|:---:|:---:|
| ![Login exitoso](screenshots/07_login_exitoso.png) | ![Mensaje de bienvenida](screenshots/08_mensaje_bienvenida.png) |

## Funcionamiento

### Registro (`/register`)
- Inputs de **nombre completo**, **email** y **contraseña**.
- El botón **Registrarse** llama a `POST /users/register`. Mientras espera, el botón se desactiva y muestra un indicador de carga.
- **Cualquier respuesta** (éxito, campos vacíos, email repetido, error del servidor o sin conexión) se muestra en una **alerta** (`AlertDialog`).
- Tras un registro correcto, al cerrar la alerta se redirige al **login**.

### Login (`/login`)
- Inputs de **email** y **contraseña**.
- El botón **Entrar** llama a `POST /users/login` y muestra la respuesta en una alerta.
- Si el login es correcto, el **token JWT se guarda de forma segura** y se entra a la pantalla de Bienvenida.
- El botón **¿No tienes cuenta? Regístrate** lleva al registro.

### Almacenamiento seguro del token
Se usa **`flutter_secure_storage`** en lugar de `shared_preferences`, porque `shared_preferences` guarda texto plano. `flutter_secure_storage` cifra el token con el **Android Keystore** (Android) y el **Keychain** (iOS). Toda la lógica está en `TokenStorageService` (Singleton), con los métodos `saveToken`, `getToken` y `deleteToken`.

### Al iniciar la app
- La app arranca siempre en el **login**, sin Drawer ni acceso a otras pantallas.
- Si hay un token guardado, se valida con `GET /users/check-token`:
  - **Válido:** redirige automáticamente a la pantalla de Bienvenida.
  - **No válido** (caducado, ya que dura 1 hora): se borra y se muestra el login.

### Mensaje de bienvenida
El botón **Ver mensaje de bienvenida** de la pantalla Bienvenida llama a `GET /users/welcome` con el token y muestra la respuesta de la API en una alerta. Si la sesión ha caducado (`401`), borra el token y vuelve al login.

### Cierre de sesión
Opción **Cerrar sesión** al final del **Drawer**: elimina el token del dispositivo y redirige al login con `context.go`, de forma que el botón "atrás" no puede volver a las pantallas privadas.

## Estructura del proyecto

```
lib/
├── main.dart
├── core/
│   ├── constants/
│   │   ├── api_constants.dart      → URL de la API, endpoints y timeout
│   │   └── app_colors / app_sizes / app_strings
│   ├── router/app_router.dart      → Rutas de go_router (empieza en /login)
│   ├── services/
│   │   ├── auth_service.dart       → Llamadas HTTP a la API (register, login, checkToken, welcome)
│   │   ├── token_storage_service.dart → Token JWT en almacenamiento seguro
│   │   └── local_storage_service.dart → Ajustes (shared_preferences)
│   ├── theme/app_theme.dart
│   └── widgets/
│       ├── drawer_menu.dart        → Menú lateral + cerrar sesión
│       └── response_dialog.dart    → Alerta con la respuesta de la API
└── features/
    ├── auth/
    │   ├── login_screen.dart
    │   ├── register_screen.dart
    │   ├── models/user.dart
    │   └── widgets/auth_input_decoration.dart
    ├── welcome/welcome_screen.dart → Bienvenida + botón de mensaje de bienvenida
    ├── portfolio/
    ├── dishes/
    └── settings/
```

## Paquetes

| Paquete | Uso |
|---|---|
| `go_router` | Navegación |
| `http` | Peticiones a la API |
| `flutter_secure_storage` | Guardar el token de forma segura |
| `shared_preferences` | Ajustes de la app |
| `qr_flutter` | QR del portfolio |

## Cómo ejecutarlo

```bash
flutter pub get
flutter run
```
