/// API data (backend of the teacher: https://github.com/adhernea/my-users-api).
class ApiConstants {
  static const String baseUrl = 'https://my-users-api.onrender.com';

  // Endpoints (all the auth routes are under /users)
  static const String register = '/users/register';
  static const String login = '/users/login';

  // The server is on Render's free plan: when it is "asleep",
  // the first request can take up to ~1 minute to answer.
  static const Duration timeout = Duration(seconds: 60);
}
