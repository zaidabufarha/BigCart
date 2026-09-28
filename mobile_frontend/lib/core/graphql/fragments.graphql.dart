import 'package:gql/ast.dart';

class Fragment$CategoryFields {
  Fragment$CategoryFields({
    required this.id,
    required this.name,
    required this.image_path,
    required this.color,
  });

  factory Fragment$CategoryFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$image_path = json['image_path'];
    final l$color = json['color'];
    return Fragment$CategoryFields(
      id: (l$id as String),
      name: (l$name as String),
      image_path: (l$image_path as String),
      color: (l$color as String),
    );
  }

  final String id;

  final String name;

  final String image_path;

  final String color;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$image_path = image_path;
    _resultData['image_path'] = l$image_path;
    final l$color = color;
    _resultData['color'] = l$color;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$image_path = image_path;
    final l$color = color;
    return Object.hashAll([l$id, l$name, l$image_path, l$color]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$CategoryFields || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$image_path = image_path;
    final lOther$image_path = other.image_path;
    if (l$image_path != lOther$image_path) {
      return false;
    }
    final l$color = color;
    final lOther$color = other.color;
    if (l$color != lOther$color) {
      return false;
    }
    return true;
  }
}

const fragmentDefinitionCategoryFields = FragmentDefinitionNode(
  name: NameNode(value: 'CategoryFields'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Category'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'id'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'name'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'image_path'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'color'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ],
  ),
);
const documentNodeFragmentCategoryFields = DocumentNode(
  definitions: [fragmentDefinitionCategoryFields],
);

class Fragment$ProductFields {
  Fragment$ProductFields({
    required this.id,
    required this.name,
    required this.image_path,
    required this.amount,
    required this.description,
    required this.discount,
    required this.price,
    required this.is_new,
    required this.is_favorite,
    required this.color,
    required this.rating,
    required this.free_shipping,
    required this.same_day_delivery,
    this.category,
  });

  factory Fragment$ProductFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$image_path = json['image_path'];
    final l$amount = json['amount'];
    final l$description = json['description'];
    final l$discount = json['discount'];
    final l$price = json['price'];
    final l$is_new = json['is_new'];
    final l$is_favorite = json['is_favorite'];
    final l$color = json['color'];
    final l$rating = json['rating'];
    final l$free_shipping = json['free_shipping'];
    final l$same_day_delivery = json['same_day_delivery'];
    final l$category = json['category'];
    return Fragment$ProductFields(
      id: (l$id as String),
      name: (l$name as String),
      image_path: (l$image_path as String),
      amount: (l$amount as String),
      description: (l$description as String),
      discount: (l$discount as num).toDouble(),
      price: (l$price as num).toDouble(),
      is_new: (l$is_new as bool),
      is_favorite: (l$is_favorite as bool),
      color: (l$color as String),
      rating: (l$rating as num).toDouble(),
      free_shipping: (l$free_shipping as bool),
      same_day_delivery: (l$same_day_delivery as bool),
      category: l$category == null
          ? null
          : Fragment$CategoryFields.fromJson(
              (l$category as Map<String, dynamic>),
            ),
    );
  }

  final String id;

  final String name;

  final String image_path;

  final String amount;

  final String description;

  final double discount;

  final double price;

  final bool is_new;

  final bool is_favorite;

  final String color;

  final double rating;

  final bool free_shipping;

  final bool same_day_delivery;

  final Fragment$CategoryFields? category;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$image_path = image_path;
    _resultData['image_path'] = l$image_path;
    final l$amount = amount;
    _resultData['amount'] = l$amount;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$discount = discount;
    _resultData['discount'] = l$discount;
    final l$price = price;
    _resultData['price'] = l$price;
    final l$is_new = is_new;
    _resultData['is_new'] = l$is_new;
    final l$is_favorite = is_favorite;
    _resultData['is_favorite'] = l$is_favorite;
    final l$color = color;
    _resultData['color'] = l$color;
    final l$rating = rating;
    _resultData['rating'] = l$rating;
    final l$free_shipping = free_shipping;
    _resultData['free_shipping'] = l$free_shipping;
    final l$same_day_delivery = same_day_delivery;
    _resultData['same_day_delivery'] = l$same_day_delivery;
    final l$category = category;
    _resultData['category'] = l$category?.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$image_path = image_path;
    final l$amount = amount;
    final l$description = description;
    final l$discount = discount;
    final l$price = price;
    final l$is_new = is_new;
    final l$is_favorite = is_favorite;
    final l$color = color;
    final l$rating = rating;
    final l$free_shipping = free_shipping;
    final l$same_day_delivery = same_day_delivery;
    final l$category = category;
    return Object.hashAll([
      l$id,
      l$name,
      l$image_path,
      l$amount,
      l$description,
      l$discount,
      l$price,
      l$is_new,
      l$is_favorite,
      l$color,
      l$rating,
      l$free_shipping,
      l$same_day_delivery,
      l$category,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$ProductFields || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$image_path = image_path;
    final lOther$image_path = other.image_path;
    if (l$image_path != lOther$image_path) {
      return false;
    }
    final l$amount = amount;
    final lOther$amount = other.amount;
    if (l$amount != lOther$amount) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$discount = discount;
    final lOther$discount = other.discount;
    if (l$discount != lOther$discount) {
      return false;
    }
    final l$price = price;
    final lOther$price = other.price;
    if (l$price != lOther$price) {
      return false;
    }
    final l$is_new = is_new;
    final lOther$is_new = other.is_new;
    if (l$is_new != lOther$is_new) {
      return false;
    }
    final l$is_favorite = is_favorite;
    final lOther$is_favorite = other.is_favorite;
    if (l$is_favorite != lOther$is_favorite) {
      return false;
    }
    final l$color = color;
    final lOther$color = other.color;
    if (l$color != lOther$color) {
      return false;
    }
    final l$rating = rating;
    final lOther$rating = other.rating;
    if (l$rating != lOther$rating) {
      return false;
    }
    final l$free_shipping = free_shipping;
    final lOther$free_shipping = other.free_shipping;
    if (l$free_shipping != lOther$free_shipping) {
      return false;
    }
    final l$same_day_delivery = same_day_delivery;
    final lOther$same_day_delivery = other.same_day_delivery;
    if (l$same_day_delivery != lOther$same_day_delivery) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (l$category != lOther$category) {
      return false;
    }
    return true;
  }
}

const fragmentDefinitionProductFields = FragmentDefinitionNode(
  name: NameNode(value: 'ProductFields'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Product'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'id'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'name'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'image_path'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'amount'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'description'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'discount'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'price'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'is_new'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'is_favorite'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'color'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'rating'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'free_shipping'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'same_day_delivery'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'category'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FragmentSpreadNode(
              name: NameNode(value: 'CategoryFields'),
              directives: [],
            ),
          ],
        ),
      ),
    ],
  ),
);
const documentNodeFragmentProductFields = DocumentNode(
  definitions: [
    fragmentDefinitionProductFields,
    fragmentDefinitionCategoryFields,
  ],
);

class Fragment$ReviewFields {
  Fragment$ReviewFields({
    required this.id,
    required this.rating,
    required this.comment,
    required this.created_at,
    this.user,
  });

  factory Fragment$ReviewFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$rating = json['rating'];
    final l$comment = json['comment'];
    final l$created_at = json['created_at'];
    final l$user = json['user'];
    return Fragment$ReviewFields(
      id: (l$id as String),
      rating: (l$rating as num).toDouble(),
      comment: (l$comment as String),
      created_at: (l$created_at as String),
      user: l$user == null
          ? null
          : Fragment$ReviewFields$user.fromJson(
              (l$user as Map<String, dynamic>),
            ),
    );
  }

  final String id;

  final double rating;

  final String comment;

  final String created_at;

  final Fragment$ReviewFields$user? user;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$rating = rating;
    _resultData['rating'] = l$rating;
    final l$comment = comment;
    _resultData['comment'] = l$comment;
    final l$created_at = created_at;
    _resultData['created_at'] = l$created_at;
    final l$user = user;
    _resultData['user'] = l$user?.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$rating = rating;
    final l$comment = comment;
    final l$created_at = created_at;
    final l$user = user;
    return Object.hashAll([l$id, l$rating, l$comment, l$created_at, l$user]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$ReviewFields || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$rating = rating;
    final lOther$rating = other.rating;
    if (l$rating != lOther$rating) {
      return false;
    }
    final l$comment = comment;
    final lOther$comment = other.comment;
    if (l$comment != lOther$comment) {
      return false;
    }
    final l$created_at = created_at;
    final lOther$created_at = other.created_at;
    if (l$created_at != lOther$created_at) {
      return false;
    }
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) {
      return false;
    }
    return true;
  }
}

const fragmentDefinitionReviewFields = FragmentDefinitionNode(
  name: NameNode(value: 'ReviewFields'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Review'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'id'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'rating'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'comment'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'created_at'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'user'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FieldNode(
              name: NameNode(value: 'name'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'image_path'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
          ],
        ),
      ),
    ],
  ),
);
const documentNodeFragmentReviewFields = DocumentNode(
  definitions: [fragmentDefinitionReviewFields],
);

class Fragment$ReviewFields$user {
  Fragment$ReviewFields$user({required this.name, required this.image_path});

  factory Fragment$ReviewFields$user.fromJson(Map<String, dynamic> json) {
    final l$name = json['name'];
    final l$image_path = json['image_path'];
    return Fragment$ReviewFields$user(
      name: (l$name as String),
      image_path: (l$image_path as String),
    );
  }

  final String name;

  final String image_path;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$name = name;
    _resultData['name'] = l$name;
    final l$image_path = image_path;
    _resultData['image_path'] = l$image_path;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$name = name;
    final l$image_path = image_path;
    return Object.hashAll([l$name, l$image_path]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$ReviewFields$user ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$image_path = image_path;
    final lOther$image_path = other.image_path;
    if (l$image_path != lOther$image_path) {
      return false;
    }
    return true;
  }
}

class Fragment$UserFields {
  Fragment$UserFields({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image_path,
  });

  factory Fragment$UserFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$email = json['email'];
    final l$phone = json['phone'];
    final l$image_path = json['image_path'];
    return Fragment$UserFields(
      id: (l$id as String),
      name: (l$name as String),
      email: (l$email as String),
      phone: (l$phone as String),
      image_path: (l$image_path as String),
    );
  }

  final String id;

  final String name;

  final String email;

  final String phone;

  final String image_path;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$email = email;
    _resultData['email'] = l$email;
    final l$phone = phone;
    _resultData['phone'] = l$phone;
    final l$image_path = image_path;
    _resultData['image_path'] = l$image_path;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$email = email;
    final l$phone = phone;
    final l$image_path = image_path;
    return Object.hashAll([l$id, l$name, l$email, l$phone, l$image_path]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$UserFields || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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
    final l$phone = phone;
    final lOther$phone = other.phone;
    if (l$phone != lOther$phone) {
      return false;
    }
    final l$image_path = image_path;
    final lOther$image_path = other.image_path;
    if (l$image_path != lOther$image_path) {
      return false;
    }
    return true;
  }
}

const fragmentDefinitionUserFields = FragmentDefinitionNode(
  name: NameNode(value: 'UserFields'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'User'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'id'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'name'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'email'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'phone'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'image_path'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ],
  ),
);
const documentNodeFragmentUserFields = DocumentNode(
  definitions: [fragmentDefinitionUserFields],
);

class Fragment$AddressFields {
  Fragment$AddressFields({
    required this.id,
    required this.name,
    required this.street,
    required this.city,
    required this.zip_code,
    required this.country,
    required this.phone,
  });

  factory Fragment$AddressFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$street = json['street'];
    final l$city = json['city'];
    final l$zip_code = json['zip_code'];
    final l$country = json['country'];
    final l$phone = json['phone'];
    return Fragment$AddressFields(
      id: (l$id as String),
      name: (l$name as String),
      street: (l$street as String),
      city: (l$city as String),
      zip_code: (l$zip_code as String),
      country: (l$country as String),
      phone: (l$phone as String),
    );
  }

  final String id;

  final String name;

  final String street;

  final String city;

  final String zip_code;

  final String country;

  final String phone;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$street = street;
    _resultData['street'] = l$street;
    final l$city = city;
    _resultData['city'] = l$city;
    final l$zip_code = zip_code;
    _resultData['zip_code'] = l$zip_code;
    final l$country = country;
    _resultData['country'] = l$country;
    final l$phone = phone;
    _resultData['phone'] = l$phone;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$street = street;
    final l$city = city;
    final l$zip_code = zip_code;
    final l$country = country;
    final l$phone = phone;
    return Object.hashAll([
      l$id,
      l$name,
      l$street,
      l$city,
      l$zip_code,
      l$country,
      l$phone,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$AddressFields || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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
    return true;
  }
}

const fragmentDefinitionAddressFields = FragmentDefinitionNode(
  name: NameNode(value: 'AddressFields'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Address'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'id'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'name'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'street'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'city'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'zip_code'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'country'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'phone'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ],
  ),
);
const documentNodeFragmentAddressFields = DocumentNode(
  definitions: [fragmentDefinitionAddressFields],
);

class Fragment$CardFields {
  Fragment$CardFields({
    required this.id,
    required this.card_holder_name,
    required this.last4,
    required this.expiry_date,
    required this.processor,
  });

  factory Fragment$CardFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$card_holder_name = json['card_holder_name'];
    final l$last4 = json['last4'];
    final l$expiry_date = json['expiry_date'];
    final l$processor = json['processor'];
    return Fragment$CardFields(
      id: (l$id as String),
      card_holder_name: (l$card_holder_name as String),
      last4: (l$last4 as String),
      expiry_date: (l$expiry_date as String),
      processor: (l$processor as String),
    );
  }

  final String id;

  final String card_holder_name;

  final String last4;

  final String expiry_date;

  final String processor;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$card_holder_name = card_holder_name;
    _resultData['card_holder_name'] = l$card_holder_name;
    final l$last4 = last4;
    _resultData['last4'] = l$last4;
    final l$expiry_date = expiry_date;
    _resultData['expiry_date'] = l$expiry_date;
    final l$processor = processor;
    _resultData['processor'] = l$processor;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$card_holder_name = card_holder_name;
    final l$last4 = last4;
    final l$expiry_date = expiry_date;
    final l$processor = processor;
    return Object.hashAll([
      l$id,
      l$card_holder_name,
      l$last4,
      l$expiry_date,
      l$processor,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$CardFields || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$card_holder_name = card_holder_name;
    final lOther$card_holder_name = other.card_holder_name;
    if (l$card_holder_name != lOther$card_holder_name) {
      return false;
    }
    final l$last4 = last4;
    final lOther$last4 = other.last4;
    if (l$last4 != lOther$last4) {
      return false;
    }
    final l$expiry_date = expiry_date;
    final lOther$expiry_date = other.expiry_date;
    if (l$expiry_date != lOther$expiry_date) {
      return false;
    }
    final l$processor = processor;
    final lOther$processor = other.processor;
    if (l$processor != lOther$processor) {
      return false;
    }
    return true;
  }
}

const fragmentDefinitionCardFields = FragmentDefinitionNode(
  name: NameNode(value: 'CardFields'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'CreditCard'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'id'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'card_holder_name'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'last4'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'expiry_date'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'processor'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ],
  ),
);
const documentNodeFragmentCardFields = DocumentNode(
  definitions: [fragmentDefinitionCardFields],
);

class Fragment$OrderFields {
  Fragment$OrderFields({
    required this.id,
    required this.shipping_method,
    required this.total_amount,
    required this.status,
    required this.date_placed,
    this.date_confirmed,
    this.date_shipped,
    this.date_out_for_delivery,
    this.date_delivered,
    required this.order_item,
    this.address,
    this.credit_card,
  });

  factory Fragment$OrderFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$shipping_method = json['shipping_method'];
    final l$total_amount = json['total_amount'];
    final l$status = json['status'];
    final l$date_placed = json['date_placed'];
    final l$date_confirmed = json['date_confirmed'];
    final l$date_shipped = json['date_shipped'];
    final l$date_out_for_delivery = json['date_out_for_delivery'];
    final l$date_delivered = json['date_delivered'];
    final l$order_item = json['order_item'];
    final l$address = json['address'];
    final l$credit_card = json['credit_card'];
    return Fragment$OrderFields(
      id: (l$id as String),
      shipping_method: (l$shipping_method as String),
      total_amount: (l$total_amount as num).toDouble(),
      status: (l$status as String),
      date_placed: (l$date_placed as String),
      date_confirmed: (l$date_confirmed as String?),
      date_shipped: (l$date_shipped as String?),
      date_out_for_delivery: (l$date_out_for_delivery as String?),
      date_delivered: (l$date_delivered as String?),
      order_item: (l$order_item as List<dynamic>)
          .map(
            (e) => Fragment$OrderFields$order_item.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      address: l$address == null
          ? null
          : Fragment$AddressFields.fromJson(
              (l$address as Map<String, dynamic>),
            ),
      credit_card: l$credit_card == null
          ? null
          : Fragment$CardFields.fromJson(
              (l$credit_card as Map<String, dynamic>),
            ),
    );
  }

  final String id;

  final String shipping_method;

  final double total_amount;

  final String status;

  final String date_placed;

  final String? date_confirmed;

  final String? date_shipped;

  final String? date_out_for_delivery;

  final String? date_delivered;

  final List<Fragment$OrderFields$order_item> order_item;

  final Fragment$AddressFields? address;

  final Fragment$CardFields? credit_card;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$shipping_method = shipping_method;
    _resultData['shipping_method'] = l$shipping_method;
    final l$total_amount = total_amount;
    _resultData['total_amount'] = l$total_amount;
    final l$status = status;
    _resultData['status'] = l$status;
    final l$date_placed = date_placed;
    _resultData['date_placed'] = l$date_placed;
    final l$date_confirmed = date_confirmed;
    _resultData['date_confirmed'] = l$date_confirmed;
    final l$date_shipped = date_shipped;
    _resultData['date_shipped'] = l$date_shipped;
    final l$date_out_for_delivery = date_out_for_delivery;
    _resultData['date_out_for_delivery'] = l$date_out_for_delivery;
    final l$date_delivered = date_delivered;
    _resultData['date_delivered'] = l$date_delivered;
    final l$order_item = order_item;
    _resultData['order_item'] = l$order_item.map((e) => e.toJson()).toList();
    final l$address = address;
    _resultData['address'] = l$address?.toJson();
    final l$credit_card = credit_card;
    _resultData['credit_card'] = l$credit_card?.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$shipping_method = shipping_method;
    final l$total_amount = total_amount;
    final l$status = status;
    final l$date_placed = date_placed;
    final l$date_confirmed = date_confirmed;
    final l$date_shipped = date_shipped;
    final l$date_out_for_delivery = date_out_for_delivery;
    final l$date_delivered = date_delivered;
    final l$order_item = order_item;
    final l$address = address;
    final l$credit_card = credit_card;
    return Object.hashAll([
      l$id,
      l$shipping_method,
      l$total_amount,
      l$status,
      l$date_placed,
      l$date_confirmed,
      l$date_shipped,
      l$date_out_for_delivery,
      l$date_delivered,
      Object.hashAll(l$order_item.map((v) => v)),
      l$address,
      l$credit_card,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$OrderFields || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$shipping_method = shipping_method;
    final lOther$shipping_method = other.shipping_method;
    if (l$shipping_method != lOther$shipping_method) {
      return false;
    }
    final l$total_amount = total_amount;
    final lOther$total_amount = other.total_amount;
    if (l$total_amount != lOther$total_amount) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$date_placed = date_placed;
    final lOther$date_placed = other.date_placed;
    if (l$date_placed != lOther$date_placed) {
      return false;
    }
    final l$date_confirmed = date_confirmed;
    final lOther$date_confirmed = other.date_confirmed;
    if (l$date_confirmed != lOther$date_confirmed) {
      return false;
    }
    final l$date_shipped = date_shipped;
    final lOther$date_shipped = other.date_shipped;
    if (l$date_shipped != lOther$date_shipped) {
      return false;
    }
    final l$date_out_for_delivery = date_out_for_delivery;
    final lOther$date_out_for_delivery = other.date_out_for_delivery;
    if (l$date_out_for_delivery != lOther$date_out_for_delivery) {
      return false;
    }
    final l$date_delivered = date_delivered;
    final lOther$date_delivered = other.date_delivered;
    if (l$date_delivered != lOther$date_delivered) {
      return false;
    }
    final l$order_item = order_item;
    final lOther$order_item = other.order_item;
    if (l$order_item.length != lOther$order_item.length) {
      return false;
    }
    for (int i = 0; i < l$order_item.length; i++) {
      final l$order_item$entry = l$order_item[i];
      final lOther$order_item$entry = lOther$order_item[i];
      if (l$order_item$entry != lOther$order_item$entry) {
        return false;
      }
    }
    final l$address = address;
    final lOther$address = other.address;
    if (l$address != lOther$address) {
      return false;
    }
    final l$credit_card = credit_card;
    final lOther$credit_card = other.credit_card;
    if (l$credit_card != lOther$credit_card) {
      return false;
    }
    return true;
  }
}

const fragmentDefinitionOrderFields = FragmentDefinitionNode(
  name: NameNode(value: 'OrderFields'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Order'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'id'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'shipping_method'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'total_amount'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'status'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'date_placed'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'date_confirmed'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'date_shipped'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'date_out_for_delivery'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'date_delivered'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'order_item'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FieldNode(
              name: NameNode(value: 'id'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'quantity'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'price_at_purchase'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'product'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(
                selections: [
                  FragmentSpreadNode(
                    name: NameNode(value: 'ProductFields'),
                    directives: [],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      FieldNode(
        name: NameNode(value: 'address'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FragmentSpreadNode(
              name: NameNode(value: 'AddressFields'),
              directives: [],
            ),
          ],
        ),
      ),
      FieldNode(
        name: NameNode(value: 'credit_card'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FragmentSpreadNode(
              name: NameNode(value: 'CardFields'),
              directives: [],
            ),
          ],
        ),
      ),
    ],
  ),
);
const documentNodeFragmentOrderFields = DocumentNode(
  definitions: [
    fragmentDefinitionOrderFields,
    fragmentDefinitionProductFields,
    fragmentDefinitionCategoryFields,
    fragmentDefinitionAddressFields,
    fragmentDefinitionCardFields,
  ],
);

class Fragment$OrderFields$order_item {
  Fragment$OrderFields$order_item({
    required this.id,
    required this.quantity,
    required this.price_at_purchase,
    required this.product,
  });

  factory Fragment$OrderFields$order_item.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$quantity = json['quantity'];
    final l$price_at_purchase = json['price_at_purchase'];
    final l$product = json['product'];
    return Fragment$OrderFields$order_item(
      id: (l$id as String),
      quantity: (l$quantity as int),
      price_at_purchase: (l$price_at_purchase as num).toDouble(),
      product: Fragment$ProductFields.fromJson(
        (l$product as Map<String, dynamic>),
      ),
    );
  }

  final String id;

  final int quantity;

  final double price_at_purchase;

  final Fragment$ProductFields product;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$quantity = quantity;
    _resultData['quantity'] = l$quantity;
    final l$price_at_purchase = price_at_purchase;
    _resultData['price_at_purchase'] = l$price_at_purchase;
    final l$product = product;
    _resultData['product'] = l$product.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$quantity = quantity;
    final l$price_at_purchase = price_at_purchase;
    final l$product = product;
    return Object.hashAll([l$id, l$quantity, l$price_at_purchase, l$product]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$OrderFields$order_item ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$quantity = quantity;
    final lOther$quantity = other.quantity;
    if (l$quantity != lOther$quantity) {
      return false;
    }
    final l$price_at_purchase = price_at_purchase;
    final lOther$price_at_purchase = other.price_at_purchase;
    if (l$price_at_purchase != lOther$price_at_purchase) {
      return false;
    }
    final l$product = product;
    final lOther$product = other.product;
    if (l$product != lOther$product) {
      return false;
    }
    return true;
  }
}

class Fragment$TransactionFields {
  Fragment$TransactionFields({
    required this.id,
    required this.amount,
    required this.status,
    required this.payment_method,
    required this.created_at,
  });

  factory Fragment$TransactionFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$amount = json['amount'];
    final l$status = json['status'];
    final l$payment_method = json['payment_method'];
    final l$created_at = json['created_at'];
    return Fragment$TransactionFields(
      id: (l$id as String),
      amount: (l$amount as num).toDouble(),
      status: (l$status as String),
      payment_method: (l$payment_method as String),
      created_at: (l$created_at as String),
    );
  }

  final String id;

  final double amount;

  final String status;

  final String payment_method;

  final String created_at;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$amount = amount;
    _resultData['amount'] = l$amount;
    final l$status = status;
    _resultData['status'] = l$status;
    final l$payment_method = payment_method;
    _resultData['payment_method'] = l$payment_method;
    final l$created_at = created_at;
    _resultData['created_at'] = l$created_at;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$amount = amount;
    final l$status = status;
    final l$payment_method = payment_method;
    final l$created_at = created_at;
    return Object.hashAll([
      l$id,
      l$amount,
      l$status,
      l$payment_method,
      l$created_at,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$TransactionFields ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$amount = amount;
    final lOther$amount = other.amount;
    if (l$amount != lOther$amount) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$payment_method = payment_method;
    final lOther$payment_method = other.payment_method;
    if (l$payment_method != lOther$payment_method) {
      return false;
    }
    final l$created_at = created_at;
    final lOther$created_at = other.created_at;
    if (l$created_at != lOther$created_at) {
      return false;
    }
    return true;
  }
}

const fragmentDefinitionTransactionFields = FragmentDefinitionNode(
  name: NameNode(value: 'TransactionFields'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Transaction'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'id'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'amount'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'status'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'payment_method'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'created_at'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ],
  ),
);
const documentNodeFragmentTransactionFields = DocumentNode(
  definitions: [fragmentDefinitionTransactionFields],
);

class Fragment$SessionFields {
  Fragment$SessionFields({required this.token, required this.user});

  factory Fragment$SessionFields.fromJson(Map<String, dynamic> json) {
    final l$token = json['token'];
    final l$user = json['user'];
    return Fragment$SessionFields(
      token: (l$token as String),
      user: Fragment$UserFields.fromJson((l$user as Map<String, dynamic>)),
    );
  }

  final String token;

  final Fragment$UserFields user;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$token = token;
    _resultData['token'] = l$token;
    final l$user = user;
    _resultData['user'] = l$user.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$token = token;
    final l$user = user;
    return Object.hashAll([l$token, l$user]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$SessionFields || runtimeType != other.runtimeType) {
      return false;
    }
    final l$token = token;
    final lOther$token = other.token;
    if (l$token != lOther$token) {
      return false;
    }
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) {
      return false;
    }
    return true;
  }
}

const fragmentDefinitionSessionFields = FragmentDefinitionNode(
  name: NameNode(value: 'SessionFields'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'AuthPayload'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'token'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'user'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FragmentSpreadNode(
              name: NameNode(value: 'UserFields'),
              directives: [],
            ),
          ],
        ),
      ),
    ],
  ),
);
const documentNodeFragmentSessionFields = DocumentNode(
  definitions: [fragmentDefinitionSessionFields, fragmentDefinitionUserFields],
);
