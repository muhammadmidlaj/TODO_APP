

class ServerException implements Exception {
  
  final String message;

  ServerException({ required this.message});
}

class NoConnectionException  implements Exception {
  final String message = "Oops! It seems you're offline. Please check your internet connection";
 
 
}
