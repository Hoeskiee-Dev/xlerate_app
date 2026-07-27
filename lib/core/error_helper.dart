String getReadableErrorMessage(Object error) {
  final errorString = error.toString().toLowerCase();

  if (errorString.contains('socketexception') ||
      errorString.contains('failed host lookup') ||
      errorString.contains('connection errored')) {
    return 'No internet connection. Please check your network.';
  } else if (errorString.contains('404')) {
    return 'Data not found.';
  } else if (errorString.contains('500') || errorString.contains('server')) {
    return 'Server is under maintenance. Please try again later.';
  } else if (errorString.contains('timeout')) {
    return 'Connection timed out. Please try again.';
  }

  return 'Something went wrong. Please try again.';
}
