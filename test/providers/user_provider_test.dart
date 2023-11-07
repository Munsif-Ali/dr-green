import 'package:doctor_green/providers/user_provider.dart';
import 'package:doctor_green/services/authentication/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserProvider', () {
    test('changeUserInfo() should update user information', () {
      final provider = UserProivder();

      // Set initial user information
      provider.user = AuthUser(
        name: 'John Doe',
        email: 'johndoe@example.com',
        id: '1234',
        isAdmin: false,
      );

      // Update user information
      provider.changeUserInfo(
        name: 'Jane Doe',
        email: 'janedoe@example.com',
        id: '5678',
        isAdmin: true,
      );

      // Verify that user information was updated
      expect(provider.user.name, 'Jane Doe');
      expect(provider.user.email, 'janedoe@example.com');
      expect(provider.user.id, '5678');
      expect(provider.user.isAdmin, true);
    });
  });
}
