/// Flutters way of cleaning up long lists of imports...
library presentation.pages;

/// Opening screen where the user is prompted to scan for a QR code at the
/// restaurant. This will bring them to the restaurant page, where they can
/// access the menu and send orders to the chef or bartender.
export 'home/home_page.dart';

/// Screen allowing the user to type in the restaurants pin as an alternative
/// to QR code.
export 'restaurant_pin/restaurant_pin_page.dart';

/// Home screen for the Restaurant. From here, the user can see a quick bio
/// about the restaurant, choose sections of the menu to order from (or read the
/// menu entirely from the beginning), and see any specials, promo's or deals.
export 'restaurant/restaurant.dart';

/// An interactive restaurant menu, where the user can just circle what they
/// want from the menu. Perhaps add underlines, strikeouts, and other markings
/// to convey extra or no toppings, etc.
export 'menu/menu_page_view.dart';

/// Opens user's camera to scan for QR codes
export 'qr_scanner/qr_scanner.dart';
