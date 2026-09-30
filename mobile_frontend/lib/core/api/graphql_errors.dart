/// Whether a GraphQL response body says the session is no longer valid: the
/// backend marks a missing, invalid or expired token with the code
/// UNAUTHENTICATED. Other 401s, like a wrong password, don't carry it.
bool isSessionExpired(dynamic body) {
  if (body is! Map || body['errors'] is! List) return false;
  return (body['errors'] as List).any(
    (error) =>
        error is Map &&
        error['extensions'] is Map &&
        error['extensions']['code'] == 'UNAUTHENTICATED',
  );
}
