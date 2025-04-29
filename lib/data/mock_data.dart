import '/models/category.dart';
import '/models/restaurant.dart';
import '/models/menu_item.dart';
import '/models/user.dart';
import '/models/address.dart';
import '/models/payment_method.dart';
import '/models/order.dart';
import '/models/cart_item.dart';

class MockData {
  static final List<Category> categories = [
    Category(
      id: "1",
      name: "Pizza",
      icon: "pizza",
      image:
          "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
    ),
    Category(
      id: "2",
      name: "Burger",
      icon: "hamburger",
      image:
          "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
    ),
    Category(
      id: "3",
      name: "Sushi",
      icon: "fish",
      image:
          "https://images.unsplash.com/photo-1579871494447-9811cf80d66c?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
    ),
    Category(
      id: "4",
      name: "Salad",
      icon: "salad",
      image:
          "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
    ),
    Category(
      id: "5",
      name: "Dessert",
      icon: "cake",
      image:
          "https://images.unsplash.com/photo-1563729784474-d77dbb933a9e?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
    ),
    Category(
      id: "6",
      name: "Drinks",
      icon: "coffee",
      image:
          "https://images.unsplash.com/photo-1544145945-f90425340c7e?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
    ),
  ];

  static final List<Restaurant> restaurants = [
    Restaurant(
      id: "1",
      name: "Burger Palace",
      image:
          "https://images.unsplash.com/photo-1550547660-d9450f859349?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      rating: 4.8,
      deliveryTime: "15-25 min",
      deliveryFee: "\$2.99",
      categories: ["2"],
      featured: true,
    ),
    Restaurant(
      id: "2",
      name: "Pizza Heaven",
      image:
          "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      rating: 4.5,
      deliveryTime: "20-30 min",
      deliveryFee: "\$1.99",
      categories: ["1"],
      featured: true,
    ),
    Restaurant(
      id: "3",
      name: "Sushi Master",
      image:
          "https://images.unsplash.com/photo-1553621042-f6e147245754?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      rating: 4.9,
      deliveryTime: "25-35 min",
      deliveryFee: "\$3.99",
      categories: ["3"],
      featured: true,
    ),
    Restaurant(
      id: "4",
      name: "Green Bowl",
      image:
          "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      rating: 4.3,
      deliveryTime: "15-25 min",
      deliveryFee: "\$2.49",
      categories: ["4"],
    ),
    Restaurant(
      id: "5",
      name: "Sweet Treats",
      image:
          "https://images.unsplash.com/photo-1551024601-bec78aea704b?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      rating: 4.7,
      deliveryTime: "20-30 min",
      deliveryFee: "\$2.99",
      categories: ["5"],
    ),
    Restaurant(
      id: "6",
      name: "Coffee Corner",
      image:
          "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      rating: 4.6,
      deliveryTime: "10-20 min",
      deliveryFee: "\$1.49",
      categories: ["6"],
    ),
    Restaurant(
      id: "7",
      name: "Taco Fiesta",
      image:
          "https://images.unsplash.com/photo-1565299585323-38d6b0865b47?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      rating: 4.4,
      deliveryTime: "20-30 min",
      deliveryFee: "\$2.49",
      categories: ["2", "4"],
    ),
    Restaurant(
      id: "8",
      name: "Pasta Paradise",
      image:
          "https://images.unsplash.com/photo-1563379926898-05f4575a45d8?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      rating: 4.5,
      deliveryTime: "25-35 min",
      deliveryFee: "\$2.99",
      categories: ["1", "4"],
    ),
  ];

  static final List<MenuItem> menuItems = [
    // Burger Palace
    MenuItem(
      id: "1-1",
      name: "Classic Cheeseburger",
      description:
          "Juicy beef patty with melted cheddar, lettuce, tomato, and special sauce",
      price: 8.99,
      image:
          "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      restaurantId: "1",
      categoryId: "2",
      popular: true,
    ),
    MenuItem(
      id: "1-2",
      name: "Bacon Deluxe Burger",
      description:
          "Beef patty topped with crispy bacon, cheese, caramelized onions, and BBQ sauce",
      price: 10.99,
      image:
          "https://images.unsplash.com/photo-1594212699903-ec8a3eca50f5?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      restaurantId: "1",
      categoryId: "2",
      popular: true,
    ),
    MenuItem(
      id: "1-3",
      name: "Veggie Burger",
      description:
          "Plant-based patty with avocado, sprouts, tomato, and vegan mayo",
      price: 9.99,
      image:
          "https://images.unsplash.com/photo-1585238342024-78d387f4a707?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      restaurantId: "1",
      categoryId: "2",
    ),
    MenuItem(
      id: "1-4",
      name: "Crispy Chicken Sandwich",
      description:
          "Crispy fried chicken breast with pickles, lettuce, and spicy mayo",
      price: 9.49,
      image:
          "https://images.unsplash.com/photo-1606755962773-d324e0a13086?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      restaurantId: "1",
      categoryId: "2",
    ),
    MenuItem(
      id: "1-5",
      name: "French Fries",
      description: "Crispy golden fries with sea salt",
      price: 3.99,
      image:
          "https://images.unsplash.com/photo-1573080496219-bb080dd4f877?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      restaurantId: "1",
      categoryId: "2",
    ),
    MenuItem(
      id: "1-6",
      name: "Chocolate Milkshake",
      description: "Creamy chocolate shake topped with whipped cream",
      price: 4.99,
      image:
          "https://images.unsplash.com/photo-1572490122747-3968b75cc699?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      restaurantId: "1",
      categoryId: "6",
    ),

    // Pizza Heaven
    MenuItem(
      id: "2-1",
      name: "Margherita Pizza",
      description:
          "Classic pizza with tomato sauce, fresh mozzarella, and basil",
      price: 12.99,
      image:
          "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      restaurantId: "2",
      categoryId: "1",
      popular: true,
    ),
    MenuItem(
      id: "2-2",
      name: "Pepperoni Pizza",
      description: "Tomato sauce, mozzarella, and spicy pepperoni slices",
      price: 14.99,
      image:
          "https://images.unsplash.com/photo-1628840042765-356cda07504e?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      restaurantId: "2",
      categoryId: "1",
      popular: true,
    ),
    MenuItem(
      id: "2-3",
      name: "Vegetarian Pizza",
      description:
          "Tomato sauce, mozzarella, bell peppers, mushrooms, olives, and onions",
      price: 13.99,
      image:
          "https://images.unsplash.com/photo-1604917877934-07d8d248d396?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      restaurantId: "2",
      categoryId: "1",
    ),
    MenuItem(
      id: "2-4",
      name: "BBQ Chicken Pizza",
      description:
          "BBQ sauce, mozzarella, grilled chicken, red onions, and cilantro",
      price: 15.99,
      image:
          "https://images.unsplash.com/photo-1594007654729-407eedc4fe0f?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      restaurantId: "2",
      categoryId: "1",
    ),
    MenuItem(
      id: "2-5",
      name: "Garlic Bread",
      description: "Toasted bread with garlic butter and herbs",
      price: 4.99,
      image:
          "https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      restaurantId: "2",
      categoryId: "1",
    ),
    MenuItem(
      id: "2-6",
      name: "Caesar Salad",
      description:
          "Romaine lettuce, croutons, parmesan cheese, and Caesar dressing",
      price: 6.99,
      image:
          "https://images.unsplash.com/photo-1550304943-4f24f54ddde9?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      restaurantId: "2",
      categoryId: "4",
    ),

    // Sushi Master
    MenuItem(
      id: "3-1",
      name: "California Roll",
      description: "Crab, avocado, and cucumber wrapped in seaweed and rice",
      price: 7.99,
      image:
          "https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      restaurantId: "3",
      categoryId: "3",
      popular: true,
    ),
    MenuItem(
      id: "3-2",
      name: "Salmon Nigiri",
      description: "Fresh salmon slices on pressed rice",
      price: 8.99,
      image:
          "https://images.unsplash.com/photo-1617196034183-421b4917c92d?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      restaurantId: "3",
      categoryId: "3",
      popular: true,
    ),
    MenuItem(
      id: "3-3",
      name: "Spicy Tuna Roll",
      description: "Spicy tuna and cucumber wrapped in seaweed and rice",
      price: 9.99,
      image:
          "https://images.unsplash.com/photo-1611143669185-af224c5e3252?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      restaurantId: "3",
      categoryId: "3",
    ),
    MenuItem(
      id: "3-4",
      name: "Dragon Roll",
      description: "Eel and cucumber roll topped with avocado and eel sauce",
      price: 12.99,
      image:
          "https://images.unsplash.com/photo-1617196035154-1e7e6e28b0db?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      restaurantId: "3",
      categoryId: "3",
    ),
    MenuItem(
      id: "3-5",
      name: "Miso Soup",
      description:
          "Traditional Japanese soup with tofu, seaweed, and green onions",
      price: 3.99,
      image:
          "https://images.unsplash.com/photo-1607301406259-dfb186e15de8?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      restaurantId: "3",
      categoryId: "3",
    ),
    MenuItem(
      id: "3-6",
      name: "Edamame",
      description: "Steamed soybean pods with sea salt",
      price: 4.99,
      image:
          "https://images.unsplash.com/photo-1622944925717-0c329a0b7c37?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
      restaurantId: "3",
      categoryId: "3",
    ),
  ];

  static final User user = User(
    id: "1",
    name: "John Doe",
    email: "john.doe@example.com",
    phone: "+1 (555) 123-4567",
    addresses: [
      Address(
        id: "1",
        title: "Home",
        address: "123 Main St, Apt 4B, New York, NY 10001",
        isDefault: true,
      ),
      Address(
        id: "2",
        title: "Work",
        address: "456 Business Ave, Suite 200, New York, NY 10002",
        isDefault: false,
      ),
    ],
    paymentMethods: [
      PaymentMethod(
        id: "1",
        type: PaymentType.card,
        title: "Visa ending in 4242",
        lastFour: "4242",
        isDefault: true,
      ),
      PaymentMethod(
        id: "2",
        type: PaymentType.card,
        title: "Mastercard ending in 5555",
        lastFour: "5555",
        isDefault: false,
      ),
      PaymentMethod(
        id: "3",
        type: PaymentType.cash,
        title: "Cash on Delivery",
        isDefault: false,
      ),
    ],
    orders: [
      Order(
        id: "1",
        restaurantId: "1",
        restaurantName: "Burger Palace",
        items: [
          CartItem(
            id: "1",
            menuItem: menuItems.firstWhere((item) => item.id == "1-1"),
            quantity: 2,
          ),
          CartItem(
            id: "2",
            menuItem: menuItems.firstWhere((item) => item.id == "1-5"),
            quantity: 1,
          ),
        ],
        status: OrderStatus.delivered,
        total: 21.97,
        deliveryFee: 2.99,
        date: "2023-06-15T18:30:00Z",
        address: Address(
          id: "1",
          title: "Home",
          address: "123 Main St, Apt 4B, New York, NY 10001",
          isDefault: true,
        ),
        paymentMethod: PaymentMethod(
          id: "1",
          type: PaymentType.card,
          title: "Visa ending in 4242",
          lastFour: "4242",
          isDefault: true,
        ),
      ),
      Order(
        id: "2",
        restaurantId: "2",
        restaurantName: "Pizza Heaven",
        items: [
          CartItem(
            id: "1",
            menuItem: menuItems.firstWhere((item) => item.id == "2-2"),
            quantity: 1,
          ),
        ],
        status: OrderStatus.delivered,
        total: 16.98,
        deliveryFee: 1.99,
        date: "2023-06-10T19:45:00Z",
        address: Address(
          id: "1",
          title: "Home",
          address: "123 Main St, Apt 4B, New York, NY 10001",
          isDefault: true,
        ),
        paymentMethod: PaymentMethod(
          id: "1",
          type: PaymentType.card,
          title: "Visa ending in 4242",
          lastFour: "4242",
          isDefault: true,
        ),
      ),
    ],
  );
}
