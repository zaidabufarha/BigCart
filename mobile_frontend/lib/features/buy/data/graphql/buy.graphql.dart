import '../../../../core/graphql/fragments.graphql.dart';
import 'package:gql/ast.dart';

class Query$GetCategories {
  Query$GetCategories({required this.categories});

  factory Query$GetCategories.fromJson(Map<String, dynamic> json) {
    final l$categories = json['categories'];
    return Query$GetCategories(
      categories: (l$categories as List<dynamic>)
          .map(
            (e) =>
                Fragment$CategoryFields.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
    );
  }

  final List<Fragment$CategoryFields> categories;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$categories = categories;
    _resultData['categories'] = l$categories.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$categories = categories;
    return Object.hashAll([Object.hashAll(l$categories.map((v) => v))]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetCategories || runtimeType != other.runtimeType) {
      return false;
    }
    final l$categories = categories;
    final lOther$categories = other.categories;
    if (l$categories.length != lOther$categories.length) {
      return false;
    }
    for (int i = 0; i < l$categories.length; i++) {
      final l$categories$entry = l$categories[i];
      final lOther$categories$entry = lOther$categories[i];
      if (l$categories$entry != lOther$categories$entry) {
        return false;
      }
    }
    return true;
  }
}

const documentNodeQueryGetCategories = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetCategories'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'categories'),
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
    ),
    fragmentDefinitionCategoryFields,
  ],
);

class Query$GetProducts {
  Query$GetProducts({required this.products});

  factory Query$GetProducts.fromJson(Map<String, dynamic> json) {
    final l$products = json['products'];
    return Query$GetProducts(
      products: (l$products as List<dynamic>)
          .map(
            (e) => Fragment$ProductFields.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
    );
  }

  final List<Fragment$ProductFields> products;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$products = products;
    _resultData['products'] = l$products.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$products = products;
    return Object.hashAll([Object.hashAll(l$products.map((v) => v))]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetProducts || runtimeType != other.runtimeType) {
      return false;
    }
    final l$products = products;
    final lOther$products = other.products;
    if (l$products.length != lOther$products.length) {
      return false;
    }
    for (int i = 0; i < l$products.length; i++) {
      final l$products$entry = l$products[i];
      final lOther$products$entry = lOther$products[i];
      if (l$products$entry != lOther$products$entry) {
        return false;
      }
    }
    return true;
  }
}

const documentNodeQueryGetProducts = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetProducts'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'products'),
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
    fragmentDefinitionProductFields,
    fragmentDefinitionCategoryFields,
  ],
);

class Variables$Query$GetProductReviews {
  factory Variables$Query$GetProductReviews({required String productId}) =>
      Variables$Query$GetProductReviews._({r'productId': productId});

  Variables$Query$GetProductReviews._(this._$data);

  factory Variables$Query$GetProductReviews.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$productId = data['productId'];
    result$data['productId'] = (l$productId as String);
    return Variables$Query$GetProductReviews._(result$data);
  }

  Map<String, dynamic> _$data;

  String get productId => (_$data['productId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$productId = productId;
    result$data['productId'] = l$productId;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$GetProductReviews ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$productId = productId;
    final lOther$productId = other.productId;
    if (l$productId != lOther$productId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$productId = productId;
    return Object.hashAll([l$productId]);
  }
}

class Query$GetProductReviews {
  Query$GetProductReviews({required this.productReviews});

  factory Query$GetProductReviews.fromJson(Map<String, dynamic> json) {
    final l$productReviews = json['productReviews'];
    return Query$GetProductReviews(
      productReviews: (l$productReviews as List<dynamic>)
          .map(
            (e) => Fragment$ReviewFields.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
    );
  }

  final List<Fragment$ReviewFields> productReviews;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$productReviews = productReviews;
    _resultData['productReviews'] = l$productReviews
        .map((e) => e.toJson())
        .toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$productReviews = productReviews;
    return Object.hashAll([Object.hashAll(l$productReviews.map((v) => v))]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetProductReviews || runtimeType != other.runtimeType) {
      return false;
    }
    final l$productReviews = productReviews;
    final lOther$productReviews = other.productReviews;
    if (l$productReviews.length != lOther$productReviews.length) {
      return false;
    }
    for (int i = 0; i < l$productReviews.length; i++) {
      final l$productReviews$entry = l$productReviews[i];
      final lOther$productReviews$entry = lOther$productReviews[i];
      if (l$productReviews$entry != lOther$productReviews$entry) {
        return false;
      }
    }
    return true;
  }
}

const documentNodeQueryGetProductReviews = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetProductReviews'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'productId')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'productReviews'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'product_id'),
                value: VariableNode(name: NameNode(value: 'productId')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'ReviewFields'),
                  directives: [],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    fragmentDefinitionReviewFields,
  ],
);

class Query$GetCart {
  Query$GetCart({required this.cart});

  factory Query$GetCart.fromJson(Map<String, dynamic> json) {
    final l$cart = json['cart'];
    return Query$GetCart(
      cart: (l$cart as List<dynamic>)
          .map((e) => Query$GetCart$cart.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  final List<Query$GetCart$cart> cart;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$cart = cart;
    _resultData['cart'] = l$cart.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$cart = cart;
    return Object.hashAll([Object.hashAll(l$cart.map((v) => v))]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetCart || runtimeType != other.runtimeType) {
      return false;
    }
    final l$cart = cart;
    final lOther$cart = other.cart;
    if (l$cart.length != lOther$cart.length) {
      return false;
    }
    for (int i = 0; i < l$cart.length; i++) {
      final l$cart$entry = l$cart[i];
      final lOther$cart$entry = lOther$cart[i];
      if (l$cart$entry != lOther$cart$entry) {
        return false;
      }
    }
    return true;
  }
}

const documentNodeQueryGetCart = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetCart'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'cart'),
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
        ],
      ),
    ),
    fragmentDefinitionProductFields,
    fragmentDefinitionCategoryFields,
  ],
);

class Query$GetCart$cart {
  Query$GetCart$cart({
    required this.id,
    required this.quantity,
    required this.product,
  });

  factory Query$GetCart$cart.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$quantity = json['quantity'];
    final l$product = json['product'];
    return Query$GetCart$cart(
      id: (l$id as String),
      quantity: (l$quantity as int),
      product: Fragment$ProductFields.fromJson(
        (l$product as Map<String, dynamic>),
      ),
    );
  }

  final String id;

  final int quantity;

  final Fragment$ProductFields product;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$quantity = quantity;
    _resultData['quantity'] = l$quantity;
    final l$product = product;
    _resultData['product'] = l$product.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$quantity = quantity;
    final l$product = product;
    return Object.hashAll([l$id, l$quantity, l$product]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetCart$cart || runtimeType != other.runtimeType) {
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
    final l$product = product;
    final lOther$product = other.product;
    if (l$product != lOther$product) {
      return false;
    }
    return true;
  }
}

class Query$GetFavorites {
  Query$GetFavorites({required this.me});

  factory Query$GetFavorites.fromJson(Map<String, dynamic> json) {
    final l$me = json['me'];
    return Query$GetFavorites(
      me: Query$GetFavorites$me.fromJson((l$me as Map<String, dynamic>)),
    );
  }

  final Query$GetFavorites$me me;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$me = me;
    _resultData['me'] = l$me.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$me = me;
    return Object.hashAll([l$me]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetFavorites || runtimeType != other.runtimeType) {
      return false;
    }
    final l$me = me;
    final lOther$me = other.me;
    if (l$me != lOther$me) {
      return false;
    }
    return true;
  }
}

const documentNodeQueryGetFavorites = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetFavorites'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'me'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'favorite'),
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
        ],
      ),
    ),
    fragmentDefinitionProductFields,
    fragmentDefinitionCategoryFields,
  ],
);

class Query$GetFavorites$me {
  Query$GetFavorites$me({required this.favorite});

  factory Query$GetFavorites$me.fromJson(Map<String, dynamic> json) {
    final l$favorite = json['favorite'];
    return Query$GetFavorites$me(
      favorite: (l$favorite as List<dynamic>)
          .map(
            (e) => Fragment$ProductFields.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
    );
  }

  final List<Fragment$ProductFields> favorite;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$favorite = favorite;
    _resultData['favorite'] = l$favorite.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$favorite = favorite;
    return Object.hashAll([Object.hashAll(l$favorite.map((v) => v))]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetFavorites$me || runtimeType != other.runtimeType) {
      return false;
    }
    final l$favorite = favorite;
    final lOther$favorite = other.favorite;
    if (l$favorite.length != lOther$favorite.length) {
      return false;
    }
    for (int i = 0; i < l$favorite.length; i++) {
      final l$favorite$entry = l$favorite[i];
      final lOther$favorite$entry = lOther$favorite[i];
      if (l$favorite$entry != lOther$favorite$entry) {
        return false;
      }
    }
    return true;
  }
}

class Variables$Mutation$AddReview {
  factory Variables$Mutation$AddReview({
    required String productId,
    required double rating,
    required String comment,
  }) => Variables$Mutation$AddReview._({
    r'productId': productId,
    r'rating': rating,
    r'comment': comment,
  });

  Variables$Mutation$AddReview._(this._$data);

  factory Variables$Mutation$AddReview.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$productId = data['productId'];
    result$data['productId'] = (l$productId as String);
    final l$rating = data['rating'];
    result$data['rating'] = (l$rating as num).toDouble();
    final l$comment = data['comment'];
    result$data['comment'] = (l$comment as String);
    return Variables$Mutation$AddReview._(result$data);
  }

  Map<String, dynamic> _$data;

  String get productId => (_$data['productId'] as String);

  double get rating => (_$data['rating'] as double);

  String get comment => (_$data['comment'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$productId = productId;
    result$data['productId'] = l$productId;
    final l$rating = rating;
    result$data['rating'] = l$rating;
    final l$comment = comment;
    result$data['comment'] = l$comment;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$AddReview ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$productId = productId;
    final lOther$productId = other.productId;
    if (l$productId != lOther$productId) {
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
    return true;
  }

  @override
  int get hashCode {
    final l$productId = productId;
    final l$rating = rating;
    final l$comment = comment;
    return Object.hashAll([l$productId, l$rating, l$comment]);
  }
}

class Mutation$AddReview {
  Mutation$AddReview({required this.addReview});

  factory Mutation$AddReview.fromJson(Map<String, dynamic> json) {
    final l$addReview = json['addReview'];
    return Mutation$AddReview(
      addReview: Mutation$AddReview$addReview.fromJson(
        (l$addReview as Map<String, dynamic>),
      ),
    );
  }

  final Mutation$AddReview$addReview addReview;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$addReview = addReview;
    _resultData['addReview'] = l$addReview.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$addReview = addReview;
    return Object.hashAll([l$addReview]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$AddReview || runtimeType != other.runtimeType) {
      return false;
    }
    final l$addReview = addReview;
    final lOther$addReview = other.addReview;
    if (l$addReview != lOther$addReview) {
      return false;
    }
    return true;
  }
}

const documentNodeMutationAddReview = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'AddReview'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'productId')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'rating')),
          type: NamedTypeNode(name: NameNode(value: 'Float'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'comment')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'addReview'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'product_id'),
                value: VariableNode(name: NameNode(value: 'productId')),
              ),
              ArgumentNode(
                name: NameNode(value: 'rating'),
                value: VariableNode(name: NameNode(value: 'rating')),
              ),
              ArgumentNode(
                name: NameNode(value: 'comment'),
                value: VariableNode(name: NameNode(value: 'comment')),
              ),
            ],
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
              ],
            ),
          ),
        ],
      ),
    ),
  ],
);

class Mutation$AddReview$addReview {
  Mutation$AddReview$addReview({required this.id});

  factory Mutation$AddReview$addReview.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    return Mutation$AddReview$addReview(id: (l$id as String));
  }

  final String id;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    return Object.hashAll([l$id]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$AddReview$addReview ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    return true;
  }
}

class Variables$Mutation$AddToCart {
  factory Variables$Mutation$AddToCart({
    required String productId,
    required int quantity,
  }) => Variables$Mutation$AddToCart._({
    r'productId': productId,
    r'quantity': quantity,
  });

  Variables$Mutation$AddToCart._(this._$data);

  factory Variables$Mutation$AddToCart.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$productId = data['productId'];
    result$data['productId'] = (l$productId as String);
    final l$quantity = data['quantity'];
    result$data['quantity'] = (l$quantity as int);
    return Variables$Mutation$AddToCart._(result$data);
  }

  Map<String, dynamic> _$data;

  String get productId => (_$data['productId'] as String);

  int get quantity => (_$data['quantity'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$productId = productId;
    result$data['productId'] = l$productId;
    final l$quantity = quantity;
    result$data['quantity'] = l$quantity;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$AddToCart ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$productId = productId;
    final lOther$productId = other.productId;
    if (l$productId != lOther$productId) {
      return false;
    }
    final l$quantity = quantity;
    final lOther$quantity = other.quantity;
    if (l$quantity != lOther$quantity) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$productId = productId;
    final l$quantity = quantity;
    return Object.hashAll([l$productId, l$quantity]);
  }
}

class Mutation$AddToCart {
  Mutation$AddToCart({required this.addToCart});

  factory Mutation$AddToCart.fromJson(Map<String, dynamic> json) {
    final l$addToCart = json['addToCart'];
    return Mutation$AddToCart(
      addToCart: Mutation$AddToCart$addToCart.fromJson(
        (l$addToCart as Map<String, dynamic>),
      ),
    );
  }

  final Mutation$AddToCart$addToCart addToCart;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$addToCart = addToCart;
    _resultData['addToCart'] = l$addToCart.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$addToCart = addToCart;
    return Object.hashAll([l$addToCart]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$AddToCart || runtimeType != other.runtimeType) {
      return false;
    }
    final l$addToCart = addToCart;
    final lOther$addToCart = other.addToCart;
    if (l$addToCart != lOther$addToCart) {
      return false;
    }
    return true;
  }
}

const documentNodeMutationAddToCart = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'AddToCart'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'productId')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'quantity')),
          type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'addToCart'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'product_id'),
                value: VariableNode(name: NameNode(value: 'productId')),
              ),
              ArgumentNode(
                name: NameNode(value: 'quantity'),
                value: VariableNode(name: NameNode(value: 'quantity')),
              ),
            ],
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
              ],
            ),
          ),
        ],
      ),
    ),
  ],
);

class Mutation$AddToCart$addToCart {
  Mutation$AddToCart$addToCart({required this.id});

  factory Mutation$AddToCart$addToCart.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    return Mutation$AddToCart$addToCart(id: (l$id as String));
  }

  final String id;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    return Object.hashAll([l$id]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$AddToCart$addToCart ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    return true;
  }
}

class Variables$Mutation$UpdateCartItem {
  factory Variables$Mutation$UpdateCartItem({
    required String id,
    required int quantity,
  }) => Variables$Mutation$UpdateCartItem._({r'id': id, r'quantity': quantity});

  Variables$Mutation$UpdateCartItem._(this._$data);

  factory Variables$Mutation$UpdateCartItem.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$quantity = data['quantity'];
    result$data['quantity'] = (l$quantity as int);
    return Variables$Mutation$UpdateCartItem._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  int get quantity => (_$data['quantity'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$quantity = quantity;
    result$data['quantity'] = l$quantity;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$UpdateCartItem ||
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
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$quantity = quantity;
    return Object.hashAll([l$id, l$quantity]);
  }
}

class Mutation$UpdateCartItem {
  Mutation$UpdateCartItem({required this.updateCartItem});

  factory Mutation$UpdateCartItem.fromJson(Map<String, dynamic> json) {
    final l$updateCartItem = json['updateCartItem'];
    return Mutation$UpdateCartItem(
      updateCartItem: Mutation$UpdateCartItem$updateCartItem.fromJson(
        (l$updateCartItem as Map<String, dynamic>),
      ),
    );
  }

  final Mutation$UpdateCartItem$updateCartItem updateCartItem;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateCartItem = updateCartItem;
    _resultData['updateCartItem'] = l$updateCartItem.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateCartItem = updateCartItem;
    return Object.hashAll([l$updateCartItem]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$UpdateCartItem || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateCartItem = updateCartItem;
    final lOther$updateCartItem = other.updateCartItem;
    if (l$updateCartItem != lOther$updateCartItem) {
      return false;
    }
    return true;
  }
}

const documentNodeMutationUpdateCartItem = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateCartItem'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'quantity')),
          type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateCartItem'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'cart_item_id'),
                value: VariableNode(name: NameNode(value: 'id')),
              ),
              ArgumentNode(
                name: NameNode(value: 'quantity'),
                value: VariableNode(name: NameNode(value: 'quantity')),
              ),
            ],
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
              ],
            ),
          ),
        ],
      ),
    ),
  ],
);

class Mutation$UpdateCartItem$updateCartItem {
  Mutation$UpdateCartItem$updateCartItem({required this.id});

  factory Mutation$UpdateCartItem$updateCartItem.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$id = json['id'];
    return Mutation$UpdateCartItem$updateCartItem(id: (l$id as String));
  }

  final String id;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    return Object.hashAll([l$id]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$UpdateCartItem$updateCartItem ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    return true;
  }
}

class Variables$Mutation$RemoveFromCart {
  factory Variables$Mutation$RemoveFromCart({required String id}) =>
      Variables$Mutation$RemoveFromCart._({r'id': id});

  Variables$Mutation$RemoveFromCart._(this._$data);

  factory Variables$Mutation$RemoveFromCart.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return Variables$Mutation$RemoveFromCart._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$RemoveFromCart ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    return Object.hashAll([l$id]);
  }
}

class Mutation$RemoveFromCart {
  Mutation$RemoveFromCart({required this.removeFromCart});

  factory Mutation$RemoveFromCart.fromJson(Map<String, dynamic> json) {
    final l$removeFromCart = json['removeFromCart'];
    return Mutation$RemoveFromCart(removeFromCart: (l$removeFromCart as bool));
  }

  final bool removeFromCart;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$removeFromCart = removeFromCart;
    _resultData['removeFromCart'] = l$removeFromCart;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$removeFromCart = removeFromCart;
    return Object.hashAll([l$removeFromCart]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$RemoveFromCart || runtimeType != other.runtimeType) {
      return false;
    }
    final l$removeFromCart = removeFromCart;
    final lOther$removeFromCart = other.removeFromCart;
    if (l$removeFromCart != lOther$removeFromCart) {
      return false;
    }
    return true;
  }
}

const documentNodeMutationRemoveFromCart = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RemoveFromCart'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'removeFromCart'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'cart_item_id'),
                value: VariableNode(name: NameNode(value: 'id')),
              ),
            ],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
  ],
);

class Variables$Mutation$ToggleFavorite {
  factory Variables$Mutation$ToggleFavorite({required String productId}) =>
      Variables$Mutation$ToggleFavorite._({r'productId': productId});

  Variables$Mutation$ToggleFavorite._(this._$data);

  factory Variables$Mutation$ToggleFavorite.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$productId = data['productId'];
    result$data['productId'] = (l$productId as String);
    return Variables$Mutation$ToggleFavorite._(result$data);
  }

  Map<String, dynamic> _$data;

  String get productId => (_$data['productId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$productId = productId;
    result$data['productId'] = l$productId;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$ToggleFavorite ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$productId = productId;
    final lOther$productId = other.productId;
    if (l$productId != lOther$productId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$productId = productId;
    return Object.hashAll([l$productId]);
  }
}

class Mutation$ToggleFavorite {
  Mutation$ToggleFavorite({required this.toggleFavorite});

  factory Mutation$ToggleFavorite.fromJson(Map<String, dynamic> json) {
    final l$toggleFavorite = json['toggleFavorite'];
    return Mutation$ToggleFavorite(toggleFavorite: (l$toggleFavorite as bool));
  }

  final bool toggleFavorite;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$toggleFavorite = toggleFavorite;
    _resultData['toggleFavorite'] = l$toggleFavorite;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$toggleFavorite = toggleFavorite;
    return Object.hashAll([l$toggleFavorite]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ToggleFavorite || runtimeType != other.runtimeType) {
      return false;
    }
    final l$toggleFavorite = toggleFavorite;
    final lOther$toggleFavorite = other.toggleFavorite;
    if (l$toggleFavorite != lOther$toggleFavorite) {
      return false;
    }
    return true;
  }
}

const documentNodeMutationToggleFavorite = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ToggleFavorite'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'productId')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'toggleFavorite'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'product_id'),
                value: VariableNode(name: NameNode(value: 'productId')),
              ),
            ],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
  ],
);

class Variables$Mutation$CreateOrder {
  factory Variables$Mutation$CreateOrder({
    required String addressId,
    required String cardId,
    String? shippingMethod,
  }) => Variables$Mutation$CreateOrder._({
    r'addressId': addressId,
    r'cardId': cardId,
    if (shippingMethod != null) r'shippingMethod': shippingMethod,
  });

  Variables$Mutation$CreateOrder._(this._$data);

  factory Variables$Mutation$CreateOrder.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$addressId = data['addressId'];
    result$data['addressId'] = (l$addressId as String);
    final l$cardId = data['cardId'];
    result$data['cardId'] = (l$cardId as String);
    if (data.containsKey('shippingMethod')) {
      final l$shippingMethod = data['shippingMethod'];
      result$data['shippingMethod'] = (l$shippingMethod as String?);
    }
    return Variables$Mutation$CreateOrder._(result$data);
  }

  Map<String, dynamic> _$data;

  String get addressId => (_$data['addressId'] as String);

  String get cardId => (_$data['cardId'] as String);

  String? get shippingMethod => (_$data['shippingMethod'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$addressId = addressId;
    result$data['addressId'] = l$addressId;
    final l$cardId = cardId;
    result$data['cardId'] = l$cardId;
    if (_$data.containsKey('shippingMethod')) {
      final l$shippingMethod = shippingMethod;
      result$data['shippingMethod'] = l$shippingMethod;
    }
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$CreateOrder ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$addressId = addressId;
    final lOther$addressId = other.addressId;
    if (l$addressId != lOther$addressId) {
      return false;
    }
    final l$cardId = cardId;
    final lOther$cardId = other.cardId;
    if (l$cardId != lOther$cardId) {
      return false;
    }
    final l$shippingMethod = shippingMethod;
    final lOther$shippingMethod = other.shippingMethod;
    if (_$data.containsKey('shippingMethod') !=
        other._$data.containsKey('shippingMethod')) {
      return false;
    }
    if (l$shippingMethod != lOther$shippingMethod) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$addressId = addressId;
    final l$cardId = cardId;
    final l$shippingMethod = shippingMethod;
    return Object.hashAll([
      l$addressId,
      l$cardId,
      _$data.containsKey('shippingMethod') ? l$shippingMethod : const {},
    ]);
  }
}

class Mutation$CreateOrder {
  Mutation$CreateOrder({required this.createOrder});

  factory Mutation$CreateOrder.fromJson(Map<String, dynamic> json) {
    final l$createOrder = json['createOrder'];
    return Mutation$CreateOrder(
      createOrder: Mutation$CreateOrder$createOrder.fromJson(
        (l$createOrder as Map<String, dynamic>),
      ),
    );
  }

  final Mutation$CreateOrder$createOrder createOrder;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$createOrder = createOrder;
    _resultData['createOrder'] = l$createOrder.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$createOrder = createOrder;
    return Object.hashAll([l$createOrder]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$CreateOrder || runtimeType != other.runtimeType) {
      return false;
    }
    final l$createOrder = createOrder;
    final lOther$createOrder = other.createOrder;
    if (l$createOrder != lOther$createOrder) {
      return false;
    }
    return true;
  }
}

const documentNodeMutationCreateOrder = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'CreateOrder'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'addressId')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'cardId')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'shippingMethod')),
          type: NamedTypeNode(
            name: NameNode(value: 'String'),
            isNonNull: false,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'createOrder'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'address_id'),
                value: VariableNode(name: NameNode(value: 'addressId')),
              ),
              ArgumentNode(
                name: NameNode(value: 'card_id'),
                value: VariableNode(name: NameNode(value: 'cardId')),
              ),
              ArgumentNode(
                name: NameNode(value: 'shipping_method'),
                value: VariableNode(name: NameNode(value: 'shippingMethod')),
              ),
            ],
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
              ],
            ),
          ),
        ],
      ),
    ),
  ],
);

class Mutation$CreateOrder$createOrder {
  Mutation$CreateOrder$createOrder({required this.id});

  factory Mutation$CreateOrder$createOrder.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    return Mutation$CreateOrder$createOrder(id: (l$id as String));
  }

  final String id;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    return Object.hashAll([l$id]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$CreateOrder$createOrder ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    return true;
  }
}
