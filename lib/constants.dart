List categories_list = [
  {
    'image': 'assets/fashion.svg',
    'name': 'Fashion',
    'isSelected': false,
    'code': 'clothes',
  },
  {
    'image': 'assets/food.svg',
    'name': 'Food',
    'isSelected': false,
  },
  {
    'image': 'assets/groceries.svg',
    'name': 'Grocery',
    'isSelected': false,
  },
  {
    'image': 'assets/mobile.svg',
    'name': 'Mobile',
    'isSelected': false,
  },
  {
    'image': 'assets/sports.svg',
    'name': 'Sports',
    'isSelected': false,
  },
  {
    'image': 'assets/cosmetics.svg',
    'name': 'Cosmetics',
    'isSelected': false,
  },
];

List location_list = [
  {
    'image': 'assets/india.svg',
    'name': 'All India',
  },
  {
    'image': 'assets/chhattisgarh.svg',
    'name': 'Chhattisgarh',
  },
  {
    'image': 'assets/gujrat.svg',
    'name': 'Gujarat',
  },
  {
    'image': 'assets/haryana.svg',
    'name': 'Haryana',
  },
  {
    'image': 'assets/himachal.svg',
    'name': 'Himachal Pradesh',
  },
  {
    'image': 'assets/jammu.svg',
    'name': 'Jammu and Kashmir',
  },
  {
    'image': 'assets/madhya.svg',
    'name': 'Madhya Pradesh',
  },
  {
    'image': 'assets/maharastra.svg',
    'name': 'Maharashtra',
  },
  {
    'image': 'assets/ptna.svg',
    'name': 'Bihar',
  },
  {
    'image': 'assets/punjab.svg',
    'name': 'Punjab',
  },
  {
    'image': 'assets/rajasthan.svg',
    'name': 'Rajasthan',
  },
  {
    'image': 'assets/uttarPradesh.svg',
    'name': 'Uttar Pradesh',
  },
  {
    'image': 'assets/uttrakhand.svg',
    'name': 'Uttarakhand',
  },
];

class ApiConstants {
  static String baseUrl = "http://157.245.104.57:8080";
  static String razorpayKey = 'rzp_test_XETURsaY2qkuB3';
}

class UserRoles {
  static String admin = "Admin";
}

class StoreKeys {
  static String accessToken = "access-token";
  static String refreshToken = "refresh-token";
}

Map<String, List<dynamic>> filters = {
  "gender": ["male", "female"],
  "filters": ["jeans", "shirt", "t-shirt", "pants", "dress", "jacket", "hoodie", "shorts"],
  "sizes": ["XS", "S", "L", "XL", "XXL", "XXXL"],
  "color": ["blue", "black", "white", "pink", "purple", "red", "green", "yellow", "grey"]
};
