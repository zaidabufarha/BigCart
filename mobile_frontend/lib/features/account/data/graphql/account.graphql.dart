import '../../../../core/graphql/fragments.graphql.dart';
import '../../../../core/graphql/schema.graphql.dart';
import 'package:gql/ast.dart';

class Query$GetUserData {
  Query$GetUserData({required this.me});

  factory Query$GetUserData.fromJson(Map<String, dynamic> json) {
    final l$me = json['me'];
    return Query$GetUserData(
      me: Fragment$UserFields.fromJson((l$me as Map<String, dynamic>)),
    );
  }

  final Fragment$UserFields me;

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
    if (other is! Query$GetUserData || runtimeType != other.runtimeType) {
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

const documentNodeQueryGetUserData = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetUserData'),
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
                FragmentSpreadNode(
                  name: NameNode(value: 'UserFields'),
                  directives: [],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    fragmentDefinitionUserFields,
  ],
);

class Query$GetAddresses {
  Query$GetAddresses({required this.me});

  factory Query$GetAddresses.fromJson(Map<String, dynamic> json) {
    final l$me = json['me'];
    return Query$GetAddresses(
      me: Query$GetAddresses$me.fromJson((l$me as Map<String, dynamic>)),
    );
  }

  final Query$GetAddresses$me me;

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
    if (other is! Query$GetAddresses || runtimeType != other.runtimeType) {
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

const documentNodeQueryGetAddresses = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetAddresses'),
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
                  name: NameNode(value: 'default_address_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
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
              ],
            ),
          ),
        ],
      ),
    ),
    fragmentDefinitionAddressFields,
  ],
);

class Query$GetAddresses$me {
  Query$GetAddresses$me({this.default_address_id, required this.address});

  factory Query$GetAddresses$me.fromJson(Map<String, dynamic> json) {
    final l$default_address_id = json['default_address_id'];
    final l$address = json['address'];
    return Query$GetAddresses$me(
      default_address_id: (l$default_address_id as String?),
      address: (l$address as List<dynamic>)
          .map(
            (e) => Fragment$AddressFields.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
    );
  }

  final String? default_address_id;

  final List<Fragment$AddressFields> address;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$default_address_id = default_address_id;
    _resultData['default_address_id'] = l$default_address_id;
    final l$address = address;
    _resultData['address'] = l$address.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$default_address_id = default_address_id;
    final l$address = address;
    return Object.hashAll([
      l$default_address_id,
      Object.hashAll(l$address.map((v) => v)),
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetAddresses$me || runtimeType != other.runtimeType) {
      return false;
    }
    final l$default_address_id = default_address_id;
    final lOther$default_address_id = other.default_address_id;
    if (l$default_address_id != lOther$default_address_id) {
      return false;
    }
    final l$address = address;
    final lOther$address = other.address;
    if (l$address.length != lOther$address.length) {
      return false;
    }
    for (int i = 0; i < l$address.length; i++) {
      final l$address$entry = l$address[i];
      final lOther$address$entry = lOther$address[i];
      if (l$address$entry != lOther$address$entry) {
        return false;
      }
    }
    return true;
  }
}

class Query$GetCreditCards {
  Query$GetCreditCards({required this.me});

  factory Query$GetCreditCards.fromJson(Map<String, dynamic> json) {
    final l$me = json['me'];
    return Query$GetCreditCards(
      me: Query$GetCreditCards$me.fromJson((l$me as Map<String, dynamic>)),
    );
  }

  final Query$GetCreditCards$me me;

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
    if (other is! Query$GetCreditCards || runtimeType != other.runtimeType) {
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

const documentNodeQueryGetCreditCards = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetCreditCards'),
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
                  name: NameNode(value: 'default_credit_card_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
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
          ),
        ],
      ),
    ),
    fragmentDefinitionCardFields,
  ],
);

class Query$GetCreditCards$me {
  Query$GetCreditCards$me({
    this.default_credit_card_id,
    required this.credit_card,
  });

  factory Query$GetCreditCards$me.fromJson(Map<String, dynamic> json) {
    final l$default_credit_card_id = json['default_credit_card_id'];
    final l$credit_card = json['credit_card'];
    return Query$GetCreditCards$me(
      default_credit_card_id: (l$default_credit_card_id as String?),
      credit_card: (l$credit_card as List<dynamic>)
          .map((e) => Fragment$CardFields.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  final String? default_credit_card_id;

  final List<Fragment$CardFields> credit_card;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$default_credit_card_id = default_credit_card_id;
    _resultData['default_credit_card_id'] = l$default_credit_card_id;
    final l$credit_card = credit_card;
    _resultData['credit_card'] = l$credit_card.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$default_credit_card_id = default_credit_card_id;
    final l$credit_card = credit_card;
    return Object.hashAll([
      l$default_credit_card_id,
      Object.hashAll(l$credit_card.map((v) => v)),
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetCreditCards$me || runtimeType != other.runtimeType) {
      return false;
    }
    final l$default_credit_card_id = default_credit_card_id;
    final lOther$default_credit_card_id = other.default_credit_card_id;
    if (l$default_credit_card_id != lOther$default_credit_card_id) {
      return false;
    }
    final l$credit_card = credit_card;
    final lOther$credit_card = other.credit_card;
    if (l$credit_card.length != lOther$credit_card.length) {
      return false;
    }
    for (int i = 0; i < l$credit_card.length; i++) {
      final l$credit_card$entry = l$credit_card[i];
      final lOther$credit_card$entry = lOther$credit_card[i];
      if (l$credit_card$entry != lOther$credit_card$entry) {
        return false;
      }
    }
    return true;
  }
}

class Query$GetNotificationPreferences {
  Query$GetNotificationPreferences({required this.me});

  factory Query$GetNotificationPreferences.fromJson(Map<String, dynamic> json) {
    final l$me = json['me'];
    return Query$GetNotificationPreferences(
      me: Query$GetNotificationPreferences$me.fromJson(
        (l$me as Map<String, dynamic>),
      ),
    );
  }

  final Query$GetNotificationPreferences$me me;

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
    if (other is! Query$GetNotificationPreferences ||
        runtimeType != other.runtimeType) {
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

const documentNodeQueryGetNotificationPreferences = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetNotificationPreferences'),
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
                  name: NameNode(value: 'notification_preference'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'allow_general'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'allow_order'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'allow_email'),
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
      ),
    ),
  ],
);

class Query$GetNotificationPreferences$me {
  Query$GetNotificationPreferences$me({required this.notification_preference});

  factory Query$GetNotificationPreferences$me.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$notification_preference = json['notification_preference'];
    return Query$GetNotificationPreferences$me(
      notification_preference:
          Query$GetNotificationPreferences$me$notification_preference.fromJson(
            (l$notification_preference as Map<String, dynamic>),
          ),
    );
  }

  final Query$GetNotificationPreferences$me$notification_preference
  notification_preference;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$notification_preference = notification_preference;
    _resultData['notification_preference'] = l$notification_preference.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$notification_preference = notification_preference;
    return Object.hashAll([l$notification_preference]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetNotificationPreferences$me ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$notification_preference = notification_preference;
    final lOther$notification_preference = other.notification_preference;
    if (l$notification_preference != lOther$notification_preference) {
      return false;
    }
    return true;
  }
}

class Query$GetNotificationPreferences$me$notification_preference {
  Query$GetNotificationPreferences$me$notification_preference({
    required this.allow_general,
    required this.allow_order,
    required this.allow_email,
  });

  factory Query$GetNotificationPreferences$me$notification_preference.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$allow_general = json['allow_general'];
    final l$allow_order = json['allow_order'];
    final l$allow_email = json['allow_email'];
    return Query$GetNotificationPreferences$me$notification_preference(
      allow_general: (l$allow_general as bool),
      allow_order: (l$allow_order as bool),
      allow_email: (l$allow_email as bool),
    );
  }

  final bool allow_general;

  final bool allow_order;

  final bool allow_email;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$allow_general = allow_general;
    _resultData['allow_general'] = l$allow_general;
    final l$allow_order = allow_order;
    _resultData['allow_order'] = l$allow_order;
    final l$allow_email = allow_email;
    _resultData['allow_email'] = l$allow_email;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$allow_general = allow_general;
    final l$allow_order = allow_order;
    final l$allow_email = allow_email;
    return Object.hashAll([l$allow_general, l$allow_order, l$allow_email]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetNotificationPreferences$me$notification_preference ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$allow_general = allow_general;
    final lOther$allow_general = other.allow_general;
    if (l$allow_general != lOther$allow_general) {
      return false;
    }
    final l$allow_order = allow_order;
    final lOther$allow_order = other.allow_order;
    if (l$allow_order != lOther$allow_order) {
      return false;
    }
    final l$allow_email = allow_email;
    final lOther$allow_email = other.allow_email;
    if (l$allow_email != lOther$allow_email) {
      return false;
    }
    return true;
  }
}

class Query$GetOrders {
  Query$GetOrders({required this.me});

  factory Query$GetOrders.fromJson(Map<String, dynamic> json) {
    final l$me = json['me'];
    return Query$GetOrders(
      me: Query$GetOrders$me.fromJson((l$me as Map<String, dynamic>)),
    );
  }

  final Query$GetOrders$me me;

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
    if (other is! Query$GetOrders || runtimeType != other.runtimeType) {
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

const documentNodeQueryGetOrders = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetOrders'),
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
                  name: NameNode(value: 'order'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'OrderFields'),
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
    fragmentDefinitionOrderFields,
    fragmentDefinitionProductFields,
    fragmentDefinitionCategoryFields,
    fragmentDefinitionAddressFields,
    fragmentDefinitionCardFields,
  ],
);

class Query$GetOrders$me {
  Query$GetOrders$me({required this.order});

  factory Query$GetOrders$me.fromJson(Map<String, dynamic> json) {
    final l$order = json['order'];
    return Query$GetOrders$me(
      order: (l$order as List<dynamic>)
          .map(
            (e) => Fragment$OrderFields.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
    );
  }

  final List<Fragment$OrderFields> order;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$order = order;
    _resultData['order'] = l$order.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$order = order;
    return Object.hashAll([Object.hashAll(l$order.map((v) => v))]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetOrders$me || runtimeType != other.runtimeType) {
      return false;
    }
    final l$order = order;
    final lOther$order = other.order;
    if (l$order.length != lOther$order.length) {
      return false;
    }
    for (int i = 0; i < l$order.length; i++) {
      final l$order$entry = l$order[i];
      final lOther$order$entry = lOther$order[i];
      if (l$order$entry != lOther$order$entry) {
        return false;
      }
    }
    return true;
  }
}

class Query$GetTransactions {
  Query$GetTransactions({required this.me});

  factory Query$GetTransactions.fromJson(Map<String, dynamic> json) {
    final l$me = json['me'];
    return Query$GetTransactions(
      me: Query$GetTransactions$me.fromJson((l$me as Map<String, dynamic>)),
    );
  }

  final Query$GetTransactions$me me;

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
    if (other is! Query$GetTransactions || runtimeType != other.runtimeType) {
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

const documentNodeQueryGetTransactions = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetTransactions'),
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
                  name: NameNode(value: 'transaction'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'TransactionFields'),
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
    fragmentDefinitionTransactionFields,
  ],
);

class Query$GetTransactions$me {
  Query$GetTransactions$me({required this.transaction});

  factory Query$GetTransactions$me.fromJson(Map<String, dynamic> json) {
    final l$transaction = json['transaction'];
    return Query$GetTransactions$me(
      transaction: (l$transaction as List<dynamic>)
          .map(
            (e) => Fragment$TransactionFields.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
    );
  }

  final List<Fragment$TransactionFields> transaction;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$transaction = transaction;
    _resultData['transaction'] = l$transaction.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$transaction = transaction;
    return Object.hashAll([Object.hashAll(l$transaction.map((v) => v))]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetTransactions$me ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$transaction = transaction;
    final lOther$transaction = other.transaction;
    if (l$transaction.length != lOther$transaction.length) {
      return false;
    }
    for (int i = 0; i < l$transaction.length; i++) {
      final l$transaction$entry = l$transaction[i];
      final lOther$transaction$entry = lOther$transaction[i];
      if (l$transaction$entry != lOther$transaction$entry) {
        return false;
      }
    }
    return true;
  }
}

class Variables$Mutation$AddAddress {
  factory Variables$Mutation$AddAddress({required Input$AddressInput input}) =>
      Variables$Mutation$AddAddress._({r'input': input});

  Variables$Mutation$AddAddress._(this._$data);

  factory Variables$Mutation$AddAddress.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] = Input$AddressInput.fromJson(
      (l$input as Map<String, dynamic>),
    );
    return Variables$Mutation$AddAddress._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$AddressInput get input => (_$data['input'] as Input$AddressInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$AddAddress ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

class Mutation$AddAddress {
  Mutation$AddAddress({required this.addAddress});

  factory Mutation$AddAddress.fromJson(Map<String, dynamic> json) {
    final l$addAddress = json['addAddress'];
    return Mutation$AddAddress(
      addAddress: Mutation$AddAddress$addAddress.fromJson(
        (l$addAddress as Map<String, dynamic>),
      ),
    );
  }

  final Mutation$AddAddress$addAddress addAddress;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$addAddress = addAddress;
    _resultData['addAddress'] = l$addAddress.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$addAddress = addAddress;
    return Object.hashAll([l$addAddress]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$AddAddress || runtimeType != other.runtimeType) {
      return false;
    }
    final l$addAddress = addAddress;
    final lOther$addAddress = other.addAddress;
    if (l$addAddress != lOther$addAddress) {
      return false;
    }
    return true;
  }
}

const documentNodeMutationAddAddress = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'AddAddress'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'input')),
          type: NamedTypeNode(
            name: NameNode(value: 'AddressInput'),
            isNonNull: true,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'addAddress'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'input'),
                value: VariableNode(name: NameNode(value: 'input')),
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

class Mutation$AddAddress$addAddress {
  Mutation$AddAddress$addAddress({required this.id});

  factory Mutation$AddAddress$addAddress.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    return Mutation$AddAddress$addAddress(id: (l$id as String));
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
    if (other is! Mutation$AddAddress$addAddress ||
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

class Variables$Mutation$AddCard {
  factory Variables$Mutation$AddCard({required Input$CardInput input}) =>
      Variables$Mutation$AddCard._({r'input': input});

  Variables$Mutation$AddCard._(this._$data);

  factory Variables$Mutation$AddCard.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] = Input$CardInput.fromJson(
      (l$input as Map<String, dynamic>),
    );
    return Variables$Mutation$AddCard._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$CardInput get input => (_$data['input'] as Input$CardInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$AddCard ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

class Mutation$AddCard {
  Mutation$AddCard({required this.addCard});

  factory Mutation$AddCard.fromJson(Map<String, dynamic> json) {
    final l$addCard = json['addCard'];
    return Mutation$AddCard(
      addCard: Mutation$AddCard$addCard.fromJson(
        (l$addCard as Map<String, dynamic>),
      ),
    );
  }

  final Mutation$AddCard$addCard addCard;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$addCard = addCard;
    _resultData['addCard'] = l$addCard.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$addCard = addCard;
    return Object.hashAll([l$addCard]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$AddCard || runtimeType != other.runtimeType) {
      return false;
    }
    final l$addCard = addCard;
    final lOther$addCard = other.addCard;
    if (l$addCard != lOther$addCard) {
      return false;
    }
    return true;
  }
}

const documentNodeMutationAddCard = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'AddCard'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'input')),
          type: NamedTypeNode(
            name: NameNode(value: 'CardInput'),
            isNonNull: true,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'addCard'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'input'),
                value: VariableNode(name: NameNode(value: 'input')),
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

class Mutation$AddCard$addCard {
  Mutation$AddCard$addCard({required this.id});

  factory Mutation$AddCard$addCard.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    return Mutation$AddCard$addCard(id: (l$id as String));
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
    if (other is! Mutation$AddCard$addCard ||
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

class Variables$Mutation$UpdateAddress {
  factory Variables$Mutation$UpdateAddress({
    required String id,
    required Input$AddressInput input,
  }) => Variables$Mutation$UpdateAddress._({r'id': id, r'input': input});

  Variables$Mutation$UpdateAddress._(this._$data);

  factory Variables$Mutation$UpdateAddress.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$input = data['input'];
    result$data['input'] = Input$AddressInput.fromJson(
      (l$input as Map<String, dynamic>),
    );
    return Variables$Mutation$UpdateAddress._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Input$AddressInput get input => (_$data['input'] as Input$AddressInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$UpdateAddress ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$input = input;
    return Object.hashAll([l$id, l$input]);
  }
}

class Mutation$UpdateAddress {
  Mutation$UpdateAddress({required this.updateAddress});

  factory Mutation$UpdateAddress.fromJson(Map<String, dynamic> json) {
    final l$updateAddress = json['updateAddress'];
    return Mutation$UpdateAddress(
      updateAddress: Mutation$UpdateAddress$updateAddress.fromJson(
        (l$updateAddress as Map<String, dynamic>),
      ),
    );
  }

  final Mutation$UpdateAddress$updateAddress updateAddress;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateAddress = updateAddress;
    _resultData['updateAddress'] = l$updateAddress.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateAddress = updateAddress;
    return Object.hashAll([l$updateAddress]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$UpdateAddress || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateAddress = updateAddress;
    final lOther$updateAddress = other.updateAddress;
    if (l$updateAddress != lOther$updateAddress) {
      return false;
    }
    return true;
  }
}

const documentNodeMutationUpdateAddress = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateAddress'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'input')),
          type: NamedTypeNode(
            name: NameNode(value: 'AddressInput'),
            isNonNull: true,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateAddress'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'id')),
              ),
              ArgumentNode(
                name: NameNode(value: 'input'),
                value: VariableNode(name: NameNode(value: 'input')),
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

class Mutation$UpdateAddress$updateAddress {
  Mutation$UpdateAddress$updateAddress({required this.id});

  factory Mutation$UpdateAddress$updateAddress.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$id = json['id'];
    return Mutation$UpdateAddress$updateAddress(id: (l$id as String));
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
    if (other is! Mutation$UpdateAddress$updateAddress ||
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

class Variables$Mutation$UpdateCreditCard {
  factory Variables$Mutation$UpdateCreditCard({
    required String id,
    required Input$CardInput input,
  }) => Variables$Mutation$UpdateCreditCard._({r'id': id, r'input': input});

  Variables$Mutation$UpdateCreditCard._(this._$data);

  factory Variables$Mutation$UpdateCreditCard.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$input = data['input'];
    result$data['input'] = Input$CardInput.fromJson(
      (l$input as Map<String, dynamic>),
    );
    return Variables$Mutation$UpdateCreditCard._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Input$CardInput get input => (_$data['input'] as Input$CardInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$UpdateCreditCard ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$input = input;
    return Object.hashAll([l$id, l$input]);
  }
}

class Mutation$UpdateCreditCard {
  Mutation$UpdateCreditCard({required this.updateCreditCard});

  factory Mutation$UpdateCreditCard.fromJson(Map<String, dynamic> json) {
    final l$updateCreditCard = json['updateCreditCard'];
    return Mutation$UpdateCreditCard(
      updateCreditCard: Mutation$UpdateCreditCard$updateCreditCard.fromJson(
        (l$updateCreditCard as Map<String, dynamic>),
      ),
    );
  }

  final Mutation$UpdateCreditCard$updateCreditCard updateCreditCard;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateCreditCard = updateCreditCard;
    _resultData['updateCreditCard'] = l$updateCreditCard.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateCreditCard = updateCreditCard;
    return Object.hashAll([l$updateCreditCard]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$UpdateCreditCard ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateCreditCard = updateCreditCard;
    final lOther$updateCreditCard = other.updateCreditCard;
    if (l$updateCreditCard != lOther$updateCreditCard) {
      return false;
    }
    return true;
  }
}

const documentNodeMutationUpdateCreditCard = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateCreditCard'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'input')),
          type: NamedTypeNode(
            name: NameNode(value: 'CardInput'),
            isNonNull: true,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateCreditCard'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'id')),
              ),
              ArgumentNode(
                name: NameNode(value: 'input'),
                value: VariableNode(name: NameNode(value: 'input')),
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

class Mutation$UpdateCreditCard$updateCreditCard {
  Mutation$UpdateCreditCard$updateCreditCard({required this.id});

  factory Mutation$UpdateCreditCard$updateCreditCard.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$id = json['id'];
    return Mutation$UpdateCreditCard$updateCreditCard(id: (l$id as String));
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
    if (other is! Mutation$UpdateCreditCard$updateCreditCard ||
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

class Variables$Mutation$SetDefaultCreditCard {
  factory Variables$Mutation$SetDefaultCreditCard({required String id}) =>
      Variables$Mutation$SetDefaultCreditCard._({r'id': id});

  Variables$Mutation$SetDefaultCreditCard._(this._$data);

  factory Variables$Mutation$SetDefaultCreditCard.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return Variables$Mutation$SetDefaultCreditCard._(result$data);
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
    if (other is! Variables$Mutation$SetDefaultCreditCard ||
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

class Mutation$SetDefaultCreditCard {
  Mutation$SetDefaultCreditCard({required this.setDefaultCreditCard});

  factory Mutation$SetDefaultCreditCard.fromJson(Map<String, dynamic> json) {
    final l$setDefaultCreditCard = json['setDefaultCreditCard'];
    return Mutation$SetDefaultCreditCard(
      setDefaultCreditCard:
          Mutation$SetDefaultCreditCard$setDefaultCreditCard.fromJson(
            (l$setDefaultCreditCard as Map<String, dynamic>),
          ),
    );
  }

  final Mutation$SetDefaultCreditCard$setDefaultCreditCard setDefaultCreditCard;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$setDefaultCreditCard = setDefaultCreditCard;
    _resultData['setDefaultCreditCard'] = l$setDefaultCreditCard.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$setDefaultCreditCard = setDefaultCreditCard;
    return Object.hashAll([l$setDefaultCreditCard]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$SetDefaultCreditCard ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$setDefaultCreditCard = setDefaultCreditCard;
    final lOther$setDefaultCreditCard = other.setDefaultCreditCard;
    if (l$setDefaultCreditCard != lOther$setDefaultCreditCard) {
      return false;
    }
    return true;
  }
}

const documentNodeMutationSetDefaultCreditCard = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SetDefaultCreditCard'),
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
            name: NameNode(value: 'setDefaultCreditCard'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'id')),
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

class Mutation$SetDefaultCreditCard$setDefaultCreditCard {
  Mutation$SetDefaultCreditCard$setDefaultCreditCard({required this.id});

  factory Mutation$SetDefaultCreditCard$setDefaultCreditCard.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$id = json['id'];
    return Mutation$SetDefaultCreditCard$setDefaultCreditCard(
      id: (l$id as String),
    );
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
    if (other is! Mutation$SetDefaultCreditCard$setDefaultCreditCard ||
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

class Variables$Mutation$UpdateProfile {
  factory Variables$Mutation$UpdateProfile({
    required Input$UpdateProfileInput input,
  }) => Variables$Mutation$UpdateProfile._({r'input': input});

  Variables$Mutation$UpdateProfile._(this._$data);

  factory Variables$Mutation$UpdateProfile.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] = Input$UpdateProfileInput.fromJson(
      (l$input as Map<String, dynamic>),
    );
    return Variables$Mutation$UpdateProfile._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$UpdateProfileInput get input =>
      (_$data['input'] as Input$UpdateProfileInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$UpdateProfile ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

class Mutation$UpdateProfile {
  Mutation$UpdateProfile({required this.updateProfile});

  factory Mutation$UpdateProfile.fromJson(Map<String, dynamic> json) {
    final l$updateProfile = json['updateProfile'];
    return Mutation$UpdateProfile(
      updateProfile: Mutation$UpdateProfile$updateProfile.fromJson(
        (l$updateProfile as Map<String, dynamic>),
      ),
    );
  }

  final Mutation$UpdateProfile$updateProfile updateProfile;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateProfile = updateProfile;
    _resultData['updateProfile'] = l$updateProfile.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateProfile = updateProfile;
    return Object.hashAll([l$updateProfile]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$UpdateProfile || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateProfile = updateProfile;
    final lOther$updateProfile = other.updateProfile;
    if (l$updateProfile != lOther$updateProfile) {
      return false;
    }
    return true;
  }
}

const documentNodeMutationUpdateProfile = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateProfile'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'input')),
          type: NamedTypeNode(
            name: NameNode(value: 'UpdateProfileInput'),
            isNonNull: true,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateProfile'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'input'),
                value: VariableNode(name: NameNode(value: 'input')),
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

class Mutation$UpdateProfile$updateProfile {
  Mutation$UpdateProfile$updateProfile({required this.id});

  factory Mutation$UpdateProfile$updateProfile.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$id = json['id'];
    return Mutation$UpdateProfile$updateProfile(id: (l$id as String));
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
    if (other is! Mutation$UpdateProfile$updateProfile ||
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

class Variables$Mutation$ChangePassword {
  factory Variables$Mutation$ChangePassword({
    required String oldPassword,
    required String newPassword,
  }) => Variables$Mutation$ChangePassword._({
    r'oldPassword': oldPassword,
    r'newPassword': newPassword,
  });

  Variables$Mutation$ChangePassword._(this._$data);

  factory Variables$Mutation$ChangePassword.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$oldPassword = data['oldPassword'];
    result$data['oldPassword'] = (l$oldPassword as String);
    final l$newPassword = data['newPassword'];
    result$data['newPassword'] = (l$newPassword as String);
    return Variables$Mutation$ChangePassword._(result$data);
  }

  Map<String, dynamic> _$data;

  String get oldPassword => (_$data['oldPassword'] as String);

  String get newPassword => (_$data['newPassword'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$oldPassword = oldPassword;
    result$data['oldPassword'] = l$oldPassword;
    final l$newPassword = newPassword;
    result$data['newPassword'] = l$newPassword;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$ChangePassword ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$oldPassword = oldPassword;
    final lOther$oldPassword = other.oldPassword;
    if (l$oldPassword != lOther$oldPassword) {
      return false;
    }
    final l$newPassword = newPassword;
    final lOther$newPassword = other.newPassword;
    if (l$newPassword != lOther$newPassword) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$oldPassword = oldPassword;
    final l$newPassword = newPassword;
    return Object.hashAll([l$oldPassword, l$newPassword]);
  }
}

class Mutation$ChangePassword {
  Mutation$ChangePassword({required this.changePassword});

  factory Mutation$ChangePassword.fromJson(Map<String, dynamic> json) {
    final l$changePassword = json['changePassword'];
    return Mutation$ChangePassword(changePassword: (l$changePassword as bool));
  }

  final bool changePassword;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$changePassword = changePassword;
    _resultData['changePassword'] = l$changePassword;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$changePassword = changePassword;
    return Object.hashAll([l$changePassword]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ChangePassword || runtimeType != other.runtimeType) {
      return false;
    }
    final l$changePassword = changePassword;
    final lOther$changePassword = other.changePassword;
    if (l$changePassword != lOther$changePassword) {
      return false;
    }
    return true;
  }
}

const documentNodeMutationChangePassword = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ChangePassword'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'oldPassword')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'newPassword')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'changePassword'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'oldPassword'),
                value: VariableNode(name: NameNode(value: 'oldPassword')),
              ),
              ArgumentNode(
                name: NameNode(value: 'newPassword'),
                value: VariableNode(name: NameNode(value: 'newPassword')),
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

class Variables$Mutation$UpdateNotificationPreference {
  factory Variables$Mutation$UpdateNotificationPreference({
    bool? email,
    bool? order,
    bool? general,
  }) => Variables$Mutation$UpdateNotificationPreference._({
    if (email != null) r'email': email,
    if (order != null) r'order': order,
    if (general != null) r'general': general,
  });

  Variables$Mutation$UpdateNotificationPreference._(this._$data);

  factory Variables$Mutation$UpdateNotificationPreference.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('email')) {
      final l$email = data['email'];
      result$data['email'] = (l$email as bool?);
    }
    if (data.containsKey('order')) {
      final l$order = data['order'];
      result$data['order'] = (l$order as bool?);
    }
    if (data.containsKey('general')) {
      final l$general = data['general'];
      result$data['general'] = (l$general as bool?);
    }
    return Variables$Mutation$UpdateNotificationPreference._(result$data);
  }

  Map<String, dynamic> _$data;

  bool? get email => (_$data['email'] as bool?);

  bool? get order => (_$data['order'] as bool?);

  bool? get general => (_$data['general'] as bool?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('email')) {
      final l$email = email;
      result$data['email'] = l$email;
    }
    if (_$data.containsKey('order')) {
      final l$order = order;
      result$data['order'] = l$order;
    }
    if (_$data.containsKey('general')) {
      final l$general = general;
      result$data['general'] = l$general;
    }
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$UpdateNotificationPreference ||
        runtimeType != other.runtimeType) {
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
    final l$order = order;
    final lOther$order = other.order;
    if (_$data.containsKey('order') != other._$data.containsKey('order')) {
      return false;
    }
    if (l$order != lOther$order) {
      return false;
    }
    final l$general = general;
    final lOther$general = other.general;
    if (_$data.containsKey('general') != other._$data.containsKey('general')) {
      return false;
    }
    if (l$general != lOther$general) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$email = email;
    final l$order = order;
    final l$general = general;
    return Object.hashAll([
      _$data.containsKey('email') ? l$email : const {},
      _$data.containsKey('order') ? l$order : const {},
      _$data.containsKey('general') ? l$general : const {},
    ]);
  }
}

class Mutation$UpdateNotificationPreference {
  Mutation$UpdateNotificationPreference({
    required this.updateNotificationPreference,
  });

  factory Mutation$UpdateNotificationPreference.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$updateNotificationPreference = json['updateNotificationPreference'];
    return Mutation$UpdateNotificationPreference(
      updateNotificationPreference:
          Mutation$UpdateNotificationPreference$updateNotificationPreference.fromJson(
            (l$updateNotificationPreference as Map<String, dynamic>),
          ),
    );
  }

  final Mutation$UpdateNotificationPreference$updateNotificationPreference
  updateNotificationPreference;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateNotificationPreference = updateNotificationPreference;
    _resultData['updateNotificationPreference'] = l$updateNotificationPreference
        .toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateNotificationPreference = updateNotificationPreference;
    return Object.hashAll([l$updateNotificationPreference]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$UpdateNotificationPreference ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateNotificationPreference = updateNotificationPreference;
    final lOther$updateNotificationPreference =
        other.updateNotificationPreference;
    if (l$updateNotificationPreference != lOther$updateNotificationPreference) {
      return false;
    }
    return true;
  }
}

const documentNodeMutationUpdateNotificationPreference = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateNotificationPreference'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'email')),
          type: NamedTypeNode(
            name: NameNode(value: 'Boolean'),
            isNonNull: false,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'order')),
          type: NamedTypeNode(
            name: NameNode(value: 'Boolean'),
            isNonNull: false,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'general')),
          type: NamedTypeNode(
            name: NameNode(value: 'Boolean'),
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
            name: NameNode(value: 'updateNotificationPreference'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'allow_email'),
                value: VariableNode(name: NameNode(value: 'email')),
              ),
              ArgumentNode(
                name: NameNode(value: 'allow_order'),
                value: VariableNode(name: NameNode(value: 'order')),
              ),
              ArgumentNode(
                name: NameNode(value: 'allow_general'),
                value: VariableNode(name: NameNode(value: 'general')),
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

class Mutation$UpdateNotificationPreference$updateNotificationPreference {
  Mutation$UpdateNotificationPreference$updateNotificationPreference({
    required this.id,
  });

  factory Mutation$UpdateNotificationPreference$updateNotificationPreference.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$id = json['id'];
    return Mutation$UpdateNotificationPreference$updateNotificationPreference(
      id: (l$id as String),
    );
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
    if (other
            is! Mutation$UpdateNotificationPreference$updateNotificationPreference ||
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
