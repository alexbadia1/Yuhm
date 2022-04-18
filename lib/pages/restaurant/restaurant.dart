/// Flutters way of cleaning up long lists of imports...
library restaurant;

/// Presentation
///
/// Base view of the restaurant page containing all components and what not.
export 'restaurant_page.dart';

/// Components
///
/// Card containing the restaurants name, logo, and brief description about
/// them. Has a button which lets the user read the menu from the start.
export 'restaurant_info_card.dart';

/// Card containing a specific section of the menu (i.e. "Appetizers"). It has
/// a name and a brief description for the menu section.
export 'menu_section_card.dart';

/// Card containing the restaurants daily special, promo, or deals of some sort.
/// It has a name, a brief description, and an image for the special, promo, or
/// deal of some sort.
export 'menu_special_card.dart';
