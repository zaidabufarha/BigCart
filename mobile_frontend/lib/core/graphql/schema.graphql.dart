class Input$SignUpInput {
  factory Input$SignUpInput({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) => Input$SignUpInput._({
    r'name': name,
    r'email': email,
    r'password': password,
    r'phone': phone,
  });

  Input$SignUpInput._(this._$data);

  factory Input$SignUpInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    final l$password = data['password'];
    result$data['password'] = (l$password as String);
    final l$phone = data['phone'];
    result$data['phone'] = (l$phone as String);
    return Input$SignUpInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get name => (_$data['name'] as String);

  String get email => (_$data['email'] as String);

  String get password => (_$data['password'] as String);

  String get phone => (_$data['phone'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$name = name;
    result$data['name'] = l$name;
    final l$email = email;
    result$data['email'] = l$email;
    final l$password = password;
    result$data['password'] = l$password;
    final l$phone = phone;
    result$data['phone'] = l$phone;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$SignUpInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$password = password;
    final lOther$password = other.password;
    if (l$password != lOther$password) {
      return false;
    }
    final l$phone = phone;
    final lOther$phone = other.phone;
    if (l$phone != lOther$phone) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$name = name;
    final l$email = email;
    final l$password = password;
    final l$phone = phone;
    return Object.hashAll([l$name, l$email, l$password, l$phone]);
  }
}

class Input$UpdateProfileInput {
  factory Input$UpdateProfileInput({
    String? name,
    String? email,
    String? phone,
    String? image_path,
  }) => Input$UpdateProfileInput._({
    if (name != null) r'name': name,
    if (email != null) r'email': email,
    if (phone != null) r'phone': phone,
    if (image_path != null) r'image_path': image_path,
  });

  Input$UpdateProfileInput._(this._$data);

  factory Input$UpdateProfileInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('name')) {
      final l$name = data['name'];
      result$data['name'] = (l$name as String?);
    }
    if (data.containsKey('email')) {
      final l$email = data['email'];
      result$data['email'] = (l$email as String?);
    }
    if (data.containsKey('phone')) {
      final l$phone = data['phone'];
      result$data['phone'] = (l$phone as String?);
    }
    if (data.containsKey('image_path')) {
      final l$image_path = data['image_path'];
      result$data['image_path'] = (l$image_path as String?);
    }
    return Input$UpdateProfileInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get name => (_$data['name'] as String?);

  String? get email => (_$data['email'] as String?);

  String? get phone => (_$data['phone'] as String?);

  String? get image_path => (_$data['image_path'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('name')) {
      final l$name = name;
      result$data['name'] = l$name;
    }
    if (_$data.containsKey('email')) {
      final l$email = email;
      result$data['email'] = l$email;
    }
    if (_$data.containsKey('phone')) {
      final l$phone = phone;
      result$data['phone'] = l$phone;
    }
    if (_$data.containsKey('image_path')) {
      final l$image_path = image_path;
      result$data['image_path'] = l$image_path;
    }
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$UpdateProfileInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (_$data.containsKey('name') != other._$data.containsKey('name')) {
      return false;
    }
    if (l$name != lOther$name) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (_$data.containsKey('email') != other._$data.containsKey('email')) {
      return false;
    }
    if (l$email != lOther$email) {
      return false;
    }
    final l$phone = phone;
    final lOther$phone = other.phone;
    if (_$data.containsKey('phone') != other._$data.containsKey('phone')) {
      return false;
    }
    if (l$phone != lOther$phone) {
      return false;
    }
    final l$image_path = image_path;
    final lOther$image_path = other.image_path;
    if (_$data.containsKey('image_path') !=
        other._$data.containsKey('image_path')) {
      return false;
    }
    if (l$image_path != lOther$image_path) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$name = name;
    final l$email = email;
    final l$phone = phone;
    final l$image_path = image_path;
    return Object.hashAll([
      _$data.containsKey('name') ? l$name : const {},
      _$data.containsKey('email') ? l$email : const {},
      _$data.containsKey('phone') ? l$phone : const {},
      _$data.containsKey('image_path') ? l$image_path : const {},
    ]);
  }
}

class Input$AddressInput {
  factory Input$AddressInput({
    required String name,
    required String street,
    required String city,
    required String zip_code,
    required String country,
    required String phone,
    bool? is_default,
  }) => Input$AddressInput._({
    r'name': name,
    r'street': street,
    r'city': city,
    r'zip_code': zip_code,
    r'country': country,
    r'phone': phone,
    if (is_default != null) r'is_default': is_default,
  });

  Input$AddressInput._(this._$data);

  factory Input$AddressInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    final l$street = data['street'];
    result$data['street'] = (l$street as String);
    final l$city = data['city'];
    result$data['city'] = (l$city as String);
    final l$zip_code = data['zip_code'];
    result$data['zip_code'] = (l$zip_code as String);
    final l$country = data['country'];
    result$data['country'] = (l$country as String);
    final l$phone = data['phone'];
    result$data['phone'] = (l$phone as String);
    if (data.containsKey('is_default')) {
      final l$is_default = data['is_default'];
      result$data['is_default'] = (l$is_default as bool?);
    }
    return Input$AddressInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get name => (_$data['name'] as String);

  String get street => (_$data['street'] as String);

  String get city => (_$data['city'] as String);

  String get zip_code => (_$data['zip_code'] as String);

  String get country => (_$data['country'] as String);

  String get phone => (_$data['phone'] as String);

  bool? get is_default => (_$data['is_default'] as bool?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$name = name;
    result$data['name'] = l$name;
    final l$street = street;
    result$data['street'] = l$street;
    final l$city = city;
    result$data['city'] = l$city;
    final l$zip_code = zip_code;
    result$data['zip_code'] = l$zip_code;
    final l$country = country;
    result$data['country'] = l$country;
    final l$phone = phone;
    result$data['phone'] = l$phone;
    if (_$data.containsKey('is_default')) {
      final l$is_default = is_default;
      result$data['is_default'] = l$is_default;
    }
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$AddressInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$street = street;
    final lOther$street = other.street;
    if (l$street != lOther$street) {
      return false;
    }
    final l$city = city;
    final lOther$city = other.city;
    if (l$city != lOther$city) {
      return false;
    }
    final l$zip_code = zip_code;
    final lOther$zip_code = other.zip_code;
    if (l$zip_code != lOther$zip_code) {
      return false;
    }
    final l$country = country;
    final lOther$country = other.country;
    if (l$country != lOther$country) {
      return false;
    }
    final l$phone = phone;
    final lOther$phone = other.phone;
    if (l$phone != lOther$phone) {
      return false;
    }
    final l$is_default = is_default;
    final lOther$is_default = other.is_default;
    if (_$data.containsKey('is_default') !=
        other._$data.containsKey('is_default')) {
      return false;
    }
    if (l$is_default != lOther$is_default) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$name = name;
    final l$street = street;
    final l$city = city;
    final l$zip_code = zip_code;
    final l$country = country;
    final l$phone = phone;
    final l$is_default = is_default;
    return Object.hashAll([
      l$name,
      l$street,
      l$city,
      l$zip_code,
      l$country,
      l$phone,
      _$data.containsKey('is_default') ? l$is_default : const {},
    ]);
  }
}

class Input$CardInput {
  factory Input$CardInput({
    String? card_holder_name,
    String? last4,
    String? card_number,
    String? expiry_date,
    String? stripe_payment_id,
    String? processor,
    bool? is_default,
  }) => Input$CardInput._({
    if (card_holder_name != null) r'card_holder_name': card_holder_name,
    if (last4 != null) r'last4': last4,
    if (card_number != null) r'card_number': card_number,
    if (expiry_date != null) r'expiry_date': expiry_date,
    if (stripe_payment_id != null) r'stripe_payment_id': stripe_payment_id,
    if (processor != null) r'processor': processor,
    if (is_default != null) r'is_default': is_default,
  });

  Input$CardInput._(this._$data);

  factory Input$CardInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('card_holder_name')) {
      final l$card_holder_name = data['card_holder_name'];
      result$data['card_holder_name'] = (l$card_holder_name as String?);
    }
    if (data.containsKey('last4')) {
      final l$last4 = data['last4'];
      result$data['last4'] = (l$last4 as String?);
    }
    if (data.containsKey('card_number')) {
      final l$card_number = data['card_number'];
      result$data['card_number'] = (l$card_number as String?);
    }
    if (data.containsKey('expiry_date')) {
      final l$expiry_date = data['expiry_date'];
      result$data['expiry_date'] = (l$expiry_date as String?);
    }
    if (data.containsKey('stripe_payment_id')) {
      final l$stripe_payment_id = data['stripe_payment_id'];
      result$data['stripe_payment_id'] = (l$stripe_payment_id as String?);
    }
    if (data.containsKey('processor')) {
      final l$processor = data['processor'];
      result$data['processor'] = (l$processor as String?);
    }
    if (data.containsKey('is_default')) {
      final l$is_default = data['is_default'];
      result$data['is_default'] = (l$is_default as bool?);
    }
    return Input$CardInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get card_holder_name => (_$data['card_holder_name'] as String?);

  String? get last4 => (_$data['last4'] as String?);

  String? get card_number => (_$data['card_number'] as String?);

  String? get expiry_date => (_$data['expiry_date'] as String?);

  String? get stripe_payment_id => (_$data['stripe_payment_id'] as String?);

  String? get processor => (_$data['processor'] as String?);

  bool? get is_default => (_$data['is_default'] as bool?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('card_holder_name')) {
      final l$card_holder_name = card_holder_name;
      result$data['card_holder_name'] = l$card_holder_name;
    }
    if (_$data.containsKey('last4')) {
      final l$last4 = last4;
      result$data['last4'] = l$last4;
    }
    if (_$data.containsKey('card_number')) {
      final l$card_number = card_number;
      result$data['card_number'] = l$card_number;
    }
    if (_$data.containsKey('expiry_date')) {
      final l$expiry_date = expiry_date;
      result$data['expiry_date'] = l$expiry_date;
    }
    if (_$data.containsKey('stripe_payment_id')) {
      final l$stripe_payment_id = stripe_payment_id;
      result$data['stripe_payment_id'] = l$stripe_payment_id;
    }
    if (_$data.containsKey('processor')) {
      final l$processor = processor;
      result$data['processor'] = l$processor;
    }
    if (_$data.containsKey('is_default')) {
      final l$is_default = is_default;
      result$data['is_default'] = l$is_default;
    }
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$CardInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$card_holder_name = card_holder_name;
    final lOther$card_holder_name = other.card_holder_name;
    if (_$data.containsKey('card_holder_name') !=
        other._$data.containsKey('card_holder_name')) {
      return false;
    }
    if (l$card_holder_name != lOther$card_holder_name) {
      return false;
    }
    final l$last4 = last4;
    final lOther$last4 = other.last4;
    if (_$data.containsKey('last4') != other._$data.containsKey('last4')) {
      return false;
    }
    if (l$last4 != lOther$last4) {
      return false;
    }
    final l$card_number = card_number;
    final lOther$card_number = other.card_number;
    if (_$data.containsKey('card_number') !=
        other._$data.containsKey('card_number')) {
      return false;
    }
    if (l$card_number != lOther$card_number) {
      return false;
    }
    final l$expiry_date = expiry_date;
    final lOther$expiry_date = other.expiry_date;
    if (_$data.containsKey('expiry_date') !=
        other._$data.containsKey('expiry_date')) {
      return false;
    }
    if (l$expiry_date != lOther$expiry_date) {
      return false;
    }
    final l$stripe_payment_id = stripe_payment_id;
    final lOther$stripe_payment_id = other.stripe_payment_id;
    if (_$data.containsKey('stripe_payment_id') !=
        other._$data.containsKey('stripe_payment_id')) {
      return false;
    }
    if (l$stripe_payment_id != lOther$stripe_payment_id) {
      return false;
    }
    final l$processor = processor;
    final lOther$processor = other.processor;
    if (_$data.containsKey('processor') !=
        other._$data.containsKey('processor')) {
      return false;
    }
    if (l$processor != lOther$processor) {
      return false;
    }
    final l$is_default = is_default;
    final lOther$is_default = other.is_default;
    if (_$data.containsKey('is_default') !=
        other._$data.containsKey('is_default')) {
      return false;
    }
    if (l$is_default != lOther$is_default) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$card_holder_name = card_holder_name;
    final l$last4 = last4;
    final l$card_number = card_number;
    final l$expiry_date = expiry_date;
    final l$stripe_payment_id = stripe_payment_id;
    final l$processor = processor;
    final l$is_default = is_default;
    return Object.hashAll([
      _$data.containsKey('card_holder_name') ? l$card_holder_name : const {},
      _$data.containsKey('last4') ? l$last4 : const {},
      _$data.containsKey('card_number') ? l$card_number : const {},
      _$data.containsKey('expiry_date') ? l$expiry_date : const {},
      _$data.containsKey('stripe_payment_id') ? l$stripe_payment_id : const {},
      _$data.containsKey('processor') ? l$processor : const {},
      _$data.containsKey('is_default') ? l$is_default : const {},
    ]);
  }
}

class Input$ProductFilterInput {
  factory Input$ProductFilterInput({
    String? category_id,
    String? search,
    double? min_rating,
    double? min_price,
    double? max_price,
    bool? discount_only,
    bool? free_shipping_only,
    bool? same_day_delivery_only,
    int? limit,
    int? offset,
  }) => Input$ProductFilterInput._({
    if (category_id != null) r'category_id': category_id,
    if (search != null) r'search': search,
    if (min_rating != null) r'min_rating': min_rating,
    if (min_price != null) r'min_price': min_price,
    if (max_price != null) r'max_price': max_price,
    if (discount_only != null) r'discount_only': discount_only,
    if (free_shipping_only != null) r'free_shipping_only': free_shipping_only,
    if (same_day_delivery_only != null)
      r'same_day_delivery_only': same_day_delivery_only,
    if (limit != null) r'limit': limit,
    if (offset != null) r'offset': offset,
  });

  Input$ProductFilterInput._(this._$data);

  factory Input$ProductFilterInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('category_id')) {
      final l$category_id = data['category_id'];
      result$data['category_id'] = (l$category_id as String?);
    }
    if (data.containsKey('search')) {
      final l$search = data['search'];
      result$data['search'] = (l$search as String?);
    }
    if (data.containsKey('min_rating')) {
      final l$min_rating = data['min_rating'];
      result$data['min_rating'] = (l$min_rating as num?)?.toDouble();
    }
    if (data.containsKey('min_price')) {
      final l$min_price = data['min_price'];
      result$data['min_price'] = (l$min_price as num?)?.toDouble();
    }
    if (data.containsKey('max_price')) {
      final l$max_price = data['max_price'];
      result$data['max_price'] = (l$max_price as num?)?.toDouble();
    }
    if (data.containsKey('discount_only')) {
      final l$discount_only = data['discount_only'];
      result$data['discount_only'] = (l$discount_only as bool?);
    }
    if (data.containsKey('free_shipping_only')) {
      final l$free_shipping_only = data['free_shipping_only'];
      result$data['free_shipping_only'] = (l$free_shipping_only as bool?);
    }
    if (data.containsKey('same_day_delivery_only')) {
      final l$same_day_delivery_only = data['same_day_delivery_only'];
      result$data['same_day_delivery_only'] =
          (l$same_day_delivery_only as bool?);
    }
    if (data.containsKey('limit')) {
      final l$limit = data['limit'];
      result$data['limit'] = (l$limit as int?);
    }
    if (data.containsKey('offset')) {
      final l$offset = data['offset'];
      result$data['offset'] = (l$offset as int?);
    }
    return Input$ProductFilterInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get category_id => (_$data['category_id'] as String?);

  String? get search => (_$data['search'] as String?);

  double? get min_rating => (_$data['min_rating'] as double?);

  double? get min_price => (_$data['min_price'] as double?);

  double? get max_price => (_$data['max_price'] as double?);

  bool? get discount_only => (_$data['discount_only'] as bool?);

  bool? get free_shipping_only => (_$data['free_shipping_only'] as bool?);

  bool? get same_day_delivery_only =>
      (_$data['same_day_delivery_only'] as bool?);

  int? get limit => (_$data['limit'] as int?);

  int? get offset => (_$data['offset'] as int?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('category_id')) {
      final l$category_id = category_id;
      result$data['category_id'] = l$category_id;
    }
    if (_$data.containsKey('search')) {
      final l$search = search;
      result$data['search'] = l$search;
    }
    if (_$data.containsKey('min_rating')) {
      final l$min_rating = min_rating;
      result$data['min_rating'] = l$min_rating;
    }
    if (_$data.containsKey('min_price')) {
      final l$min_price = min_price;
      result$data['min_price'] = l$min_price;
    }
    if (_$data.containsKey('max_price')) {
      final l$max_price = max_price;
      result$data['max_price'] = l$max_price;
    }
    if (_$data.containsKey('discount_only')) {
      final l$discount_only = discount_only;
      result$data['discount_only'] = l$discount_only;
    }
    if (_$data.containsKey('free_shipping_only')) {
      final l$free_shipping_only = free_shipping_only;
      result$data['free_shipping_only'] = l$free_shipping_only;
    }
    if (_$data.containsKey('same_day_delivery_only')) {
      final l$same_day_delivery_only = same_day_delivery_only;
      result$data['same_day_delivery_only'] = l$same_day_delivery_only;
    }
    if (_$data.containsKey('limit')) {
      final l$limit = limit;
      result$data['limit'] = l$limit;
    }
    if (_$data.containsKey('offset')) {
      final l$offset = offset;
      result$data['offset'] = l$offset;
    }
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$ProductFilterInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$category_id = category_id;
    final lOther$category_id = other.category_id;
    if (_$data.containsKey('category_id') !=
        other._$data.containsKey('category_id')) {
      return false;
    }
    if (l$category_id != lOther$category_id) {
      return false;
    }
    final l$search = search;
    final lOther$search = other.search;
    if (_$data.containsKey('search') != other._$data.containsKey('search')) {
      return false;
    }
    if (l$search != lOther$search) {
      return false;
    }
    final l$min_rating = min_rating;
    final lOther$min_rating = other.min_rating;
    if (_$data.containsKey('min_rating') !=
        other._$data.containsKey('min_rating')) {
      return false;
    }
    if (l$min_rating != lOther$min_rating) {
      return false;
    }
    final l$min_price = min_price;
    final lOther$min_price = other.min_price;
    if (_$data.containsKey('min_price') !=
        other._$data.containsKey('min_price')) {
      return false;
    }
    if (l$min_price != lOther$min_price) {
      return false;
    }
    final l$max_price = max_price;
    final lOther$max_price = other.max_price;
    if (_$data.containsKey('max_price') !=
        other._$data.containsKey('max_price')) {
      return false;
    }
    if (l$max_price != lOther$max_price) {
      return false;
    }
    final l$discount_only = discount_only;
    final lOther$discount_only = other.discount_only;
    if (_$data.containsKey('discount_only') !=
        other._$data.containsKey('discount_only')) {
      return false;
    }
    if (l$discount_only != lOther$discount_only) {
      return false;
    }
    final l$free_shipping_only = free_shipping_only;
    final lOther$free_shipping_only = other.free_shipping_only;
    if (_$data.containsKey('free_shipping_only') !=
        other._$data.containsKey('free_shipping_only')) {
      return false;
    }
    if (l$free_shipping_only != lOther$free_shipping_only) {
      return false;
    }
    final l$same_day_delivery_only = same_day_delivery_only;
    final lOther$same_day_delivery_only = other.same_day_delivery_only;
    if (_$data.containsKey('same_day_delivery_only') !=
        other._$data.containsKey('same_day_delivery_only')) {
      return false;
    }
    if (l$same_day_delivery_only != lOther$same_day_delivery_only) {
      return false;
    }
    final l$limit = limit;
    final lOther$limit = other.limit;
    if (_$data.containsKey('limit') != other._$data.containsKey('limit')) {
      return false;
    }
    if (l$limit != lOther$limit) {
      return false;
    }
    final l$offset = offset;
    final lOther$offset = other.offset;
    if (_$data.containsKey('offset') != other._$data.containsKey('offset')) {
      return false;
    }
    if (l$offset != lOther$offset) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$category_id = category_id;
    final l$search = search;
    final l$min_rating = min_rating;
    final l$min_price = min_price;
    final l$max_price = max_price;
    final l$discount_only = discount_only;
    final l$free_shipping_only = free_shipping_only;
    final l$same_day_delivery_only = same_day_delivery_only;
    final l$limit = limit;
    final l$offset = offset;
    return Object.hashAll([
      _$data.containsKey('category_id') ? l$category_id : const {},
      _$data.containsKey('search') ? l$search : const {},
      _$data.containsKey('min_rating') ? l$min_rating : const {},
      _$data.containsKey('min_price') ? l$min_price : const {},
      _$data.containsKey('max_price') ? l$max_price : const {},
      _$data.containsKey('discount_only') ? l$discount_only : const {},
      _$data.containsKey('free_shipping_only')
          ? l$free_shipping_only
          : const {},
      _$data.containsKey('same_day_delivery_only')
          ? l$same_day_delivery_only
          : const {},
      _$data.containsKey('limit') ? l$limit : const {},
      _$data.containsKey('offset') ? l$offset : const {},
    ]);
  }
}

enum Enum$__TypeKind {
  SCALAR,
  OBJECT,
  INTERFACE,
  UNION,
  ENUM,
  INPUT_OBJECT,
  LIST,
  NON_NULL,
  $unknown;

  factory Enum$__TypeKind.fromJson(String value) =>
      fromJson$Enum$__TypeKind(value);

  String toJson() => toJson$Enum$__TypeKind(this);
}

String toJson$Enum$__TypeKind(Enum$__TypeKind e) {
  switch (e) {
    case Enum$__TypeKind.SCALAR:
      return r'SCALAR';
    case Enum$__TypeKind.OBJECT:
      return r'OBJECT';
    case Enum$__TypeKind.INTERFACE:
      return r'INTERFACE';
    case Enum$__TypeKind.UNION:
      return r'UNION';
    case Enum$__TypeKind.ENUM:
      return r'ENUM';
    case Enum$__TypeKind.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__TypeKind.LIST:
      return r'LIST';
    case Enum$__TypeKind.NON_NULL:
      return r'NON_NULL';
    case Enum$__TypeKind.$unknown:
      return r'$unknown';
  }
}

Enum$__TypeKind fromJson$Enum$__TypeKind(String value) {
  switch (value) {
    case r'SCALAR':
      return Enum$__TypeKind.SCALAR;
    case r'OBJECT':
      return Enum$__TypeKind.OBJECT;
    case r'INTERFACE':
      return Enum$__TypeKind.INTERFACE;
    case r'UNION':
      return Enum$__TypeKind.UNION;
    case r'ENUM':
      return Enum$__TypeKind.ENUM;
    case r'INPUT_OBJECT':
      return Enum$__TypeKind.INPUT_OBJECT;
    case r'LIST':
      return Enum$__TypeKind.LIST;
    case r'NON_NULL':
      return Enum$__TypeKind.NON_NULL;
    default:
      return Enum$__TypeKind.$unknown;
  }
}

enum Enum$__DirectiveLocation {
  QUERY,
  MUTATION,
  SUBSCRIPTION,
  FIELD,
  FRAGMENT_DEFINITION,
  FRAGMENT_SPREAD,
  INLINE_FRAGMENT,
  VARIABLE_DEFINITION,
  SCHEMA,
  SCALAR,
  OBJECT,
  FIELD_DEFINITION,
  ARGUMENT_DEFINITION,
  INTERFACE,
  UNION,
  ENUM,
  ENUM_VALUE,
  INPUT_OBJECT,
  INPUT_FIELD_DEFINITION,
  $unknown;

  factory Enum$__DirectiveLocation.fromJson(String value) =>
      fromJson$Enum$__DirectiveLocation(value);

  String toJson() => toJson$Enum$__DirectiveLocation(this);
}

String toJson$Enum$__DirectiveLocation(Enum$__DirectiveLocation e) {
  switch (e) {
    case Enum$__DirectiveLocation.QUERY:
      return r'QUERY';
    case Enum$__DirectiveLocation.MUTATION:
      return r'MUTATION';
    case Enum$__DirectiveLocation.SUBSCRIPTION:
      return r'SUBSCRIPTION';
    case Enum$__DirectiveLocation.FIELD:
      return r'FIELD';
    case Enum$__DirectiveLocation.FRAGMENT_DEFINITION:
      return r'FRAGMENT_DEFINITION';
    case Enum$__DirectiveLocation.FRAGMENT_SPREAD:
      return r'FRAGMENT_SPREAD';
    case Enum$__DirectiveLocation.INLINE_FRAGMENT:
      return r'INLINE_FRAGMENT';
    case Enum$__DirectiveLocation.VARIABLE_DEFINITION:
      return r'VARIABLE_DEFINITION';
    case Enum$__DirectiveLocation.SCHEMA:
      return r'SCHEMA';
    case Enum$__DirectiveLocation.SCALAR:
      return r'SCALAR';
    case Enum$__DirectiveLocation.OBJECT:
      return r'OBJECT';
    case Enum$__DirectiveLocation.FIELD_DEFINITION:
      return r'FIELD_DEFINITION';
    case Enum$__DirectiveLocation.ARGUMENT_DEFINITION:
      return r'ARGUMENT_DEFINITION';
    case Enum$__DirectiveLocation.INTERFACE:
      return r'INTERFACE';
    case Enum$__DirectiveLocation.UNION:
      return r'UNION';
    case Enum$__DirectiveLocation.ENUM:
      return r'ENUM';
    case Enum$__DirectiveLocation.ENUM_VALUE:
      return r'ENUM_VALUE';
    case Enum$__DirectiveLocation.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION:
      return r'INPUT_FIELD_DEFINITION';
    case Enum$__DirectiveLocation.$unknown:
      return r'$unknown';
  }
}

Enum$__DirectiveLocation fromJson$Enum$__DirectiveLocation(String value) {
  switch (value) {
    case r'QUERY':
      return Enum$__DirectiveLocation.QUERY;
    case r'MUTATION':
      return Enum$__DirectiveLocation.MUTATION;
    case r'SUBSCRIPTION':
      return Enum$__DirectiveLocation.SUBSCRIPTION;
    case r'FIELD':
      return Enum$__DirectiveLocation.FIELD;
    case r'FRAGMENT_DEFINITION':
      return Enum$__DirectiveLocation.FRAGMENT_DEFINITION;
    case r'FRAGMENT_SPREAD':
      return Enum$__DirectiveLocation.FRAGMENT_SPREAD;
    case r'INLINE_FRAGMENT':
      return Enum$__DirectiveLocation.INLINE_FRAGMENT;
    case r'VARIABLE_DEFINITION':
      return Enum$__DirectiveLocation.VARIABLE_DEFINITION;
    case r'SCHEMA':
      return Enum$__DirectiveLocation.SCHEMA;
    case r'SCALAR':
      return Enum$__DirectiveLocation.SCALAR;
    case r'OBJECT':
      return Enum$__DirectiveLocation.OBJECT;
    case r'FIELD_DEFINITION':
      return Enum$__DirectiveLocation.FIELD_DEFINITION;
    case r'ARGUMENT_DEFINITION':
      return Enum$__DirectiveLocation.ARGUMENT_DEFINITION;
    case r'INTERFACE':
      return Enum$__DirectiveLocation.INTERFACE;
    case r'UNION':
      return Enum$__DirectiveLocation.UNION;
    case r'ENUM':
      return Enum$__DirectiveLocation.ENUM;
    case r'ENUM_VALUE':
      return Enum$__DirectiveLocation.ENUM_VALUE;
    case r'INPUT_OBJECT':
      return Enum$__DirectiveLocation.INPUT_OBJECT;
    case r'INPUT_FIELD_DEFINITION':
      return Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION;
    default:
      return Enum$__DirectiveLocation.$unknown;
  }
}

const possibleTypesMap = <String, Set<String>>{};
