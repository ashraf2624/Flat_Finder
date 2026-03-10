class SimpleAuthService {
  static final Map<String, String> _users = {};
  static String? _currentUser;

  // Simple registration - stores in memory
  Future<bool> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    if (_users.containsKey(email)) {
      throw 'User already exists with this email';
    }
    
    _users[email] = password;
    _currentUser = email;
    return true;
  }

  // Simple login - checks memory
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    if (!_users.containsKey(email)) {
      throw 'No user found with this email';
    }
    
    if (_users[email] != password) {
      throw 'Incorrect password';
    }
    
    _currentUser = email;
    return true;
  }

  // Check if user is logged in
  bool get isLoggedIn => _currentUser != null;
  
  // Get current user email
  String? get currentUserEmail => _currentUser;
  
  // Logout
  void logout() {
    _currentUser = null;
  }
}