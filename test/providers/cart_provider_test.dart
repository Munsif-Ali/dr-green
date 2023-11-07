import 'package:flutter_test/flutter_test.dart';
import 'package:doctor_green/providers/cart_provider.dart';

void main() {
  group('CartProvider', () {
    late CartProvider cartProvider;

    setUp(() {
      cartProvider = CartProvider();
    });

    test('addItem should add item to cartItems list', () {
      final cartItem = CartItem(
        imageUrl: 'https://example.com/image.jpg',
        productId: 'product-1',
        name: 'Product 1',
        quantity: 1,
        price: 10,
      );

      cartProvider.addItem(cartItem);

      expect(cartProvider.cartItems.length, 1);
      expect(cartProvider.cartItems.first, cartItem);
    });

    test('removeItem should remove item from cartItems list', () {
      final cartItem1 = CartItem(
        imageUrl: 'https://example.com/image1.jpg',
        productId: 'product-1',
        name: 'Product 1',
        quantity: 1,
        price: 10,
      );
      final cartItem2 = CartItem(
        imageUrl: 'https://example.com/image2.jpg',
        productId: 'product-2',
        name: 'Product 2',
        quantity: 1,
        price: 20,
      );

      cartProvider.addItem(cartItem1);
      cartProvider.addItem(cartItem2);

      cartProvider.removeItem(0);

      expect(cartProvider.cartItems.length, 1);
      expect(cartProvider.cartItems.first, cartItem2);
    });

    test('isProductInCart should return true if product is in cart', () {
      final cartItem1 = CartItem(
        imageUrl: 'https://example.com/image1.jpg',
        productId: 'product-1',
        name: 'Product 1',
        quantity: 1,
        price: 10,
      );
      final cartItem2 = CartItem(
        imageUrl: 'https://example.com/image2.jpg',
        productId: 'product-2',
        name: 'Product 2',
        quantity: 1,
        price: 20,
      );

      cartProvider.addItem(cartItem1);
      cartProvider.addItem(cartItem2);

      expect(cartProvider.isProductInCart('product-1'), true);
      expect(cartProvider.isProductInCart('product-3'), false);
    });

    test('totalPrice should return the total price of all items in cart', () {
      final cartItem1 = CartItem(
        imageUrl: 'https://example.com/image1.jpg',
        productId: 'product-1',
        name: 'Product 1',
        quantity: 2,
        price: 10,
      );
      final cartItem2 = CartItem(
        imageUrl: 'https://example.com/image2.jpg',
        productId: 'product-2',
        name: 'Product 2',
        quantity: 1,
        price: 20,
      );

      cartProvider.addItem(cartItem1);
      cartProvider.addItem(cartItem2);

      expect(cartProvider.totalPrice, 40);
    });

    test('clearCart should remove all items from cartItems list', () {
      final cartItem1 = CartItem(
        imageUrl: 'https://example.com/image1.jpg',
        productId: 'product-1',
        name: 'Product 1',
        quantity: 1,
        price: 10,
      );
      final cartItem2 = CartItem(
        imageUrl: 'https://example.com/image2.jpg',
        productId: 'product-2',
        name: 'Product 2',
        quantity: 1,
        price: 20,
      );

      cartProvider.addItem(cartItem1);
      cartProvider.addItem(cartItem2);

      cartProvider.clearCart();

      expect(cartProvider.cartItems.length, 0);
    });
  });
}
