import '../../../../core/graphql/fragments.graphql.dart';
import 'package:gql/ast.dart';

class Variables$Mutation$LogIn {
  factory Variables$Mutation$LogIn({
    required String email,
    required String password,
  }) => Variables$Mutation$LogIn._({r'email': email, r'password': password});

  Variables$Mutation$LogIn._(this._$data);

  factory Variables$Mutation$LogIn.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    final l$password = data['password'];
    result$data['password'] = (l$password as String);
    return Variables$Mutation$LogIn._(result$data);
  }

  Map<String, dynamic> _$data;

  String get email => (_$data['email'] as String);

  String get password => (_$data['password'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$email = email;
    result$data['email'] = l$email;
    final l$password = password;
    result$data['password'] = l$password;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$LogIn ||
        runtimeType != other.runtimeType) {
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
    return true;
  }

  @override
  int get hashCode {
    final l$email = email;
    final l$password = password;
    return Object.hashAll([l$email, l$password]);
  }
}

class Mutation$LogIn {
  Mutation$LogIn({required this.logIn});

  factory Mutation$LogIn.fromJson(Map<String, dynamic> json) {
    final l$logIn = json['logIn'];
    return Mutation$LogIn(
      logIn: Fragment$SessionFields.fromJson((l$logIn as Map<String, dynamic>)),
    );
  }

  final Fragment$SessionFields logIn;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$logIn = logIn;
    _resultData['logIn'] = l$logIn.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$logIn = logIn;
    return Object.hashAll([l$logIn]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$LogIn || runtimeType != other.runtimeType) {
      return false;
    }
    final l$logIn = logIn;
    final lOther$logIn = other.logIn;
    if (l$logIn != lOther$logIn) {
      return false;
    }
    return true;
  }
}

const documentNodeMutationLogIn = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'LogIn'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'email')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'password')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'logIn'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'email'),
                value: VariableNode(name: NameNode(value: 'email')),
              ),
              ArgumentNode(
                name: NameNode(value: 'password'),
                value: VariableNode(name: NameNode(value: 'password')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'SessionFields'),
                  directives: [],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    fragmentDefinitionSessionFields,
    fragmentDefinitionUserFields,
  ],
);

class Variables$Mutation$GoogleSignIn {
  factory Variables$Mutation$GoogleSignIn({required String idToken}) =>
      Variables$Mutation$GoogleSignIn._({r'idToken': idToken});

  Variables$Mutation$GoogleSignIn._(this._$data);

  factory Variables$Mutation$GoogleSignIn.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$idToken = data['idToken'];
    result$data['idToken'] = (l$idToken as String);
    return Variables$Mutation$GoogleSignIn._(result$data);
  }

  Map<String, dynamic> _$data;

  String get idToken => (_$data['idToken'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$idToken = idToken;
    result$data['idToken'] = l$idToken;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$GoogleSignIn ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$idToken = idToken;
    final lOther$idToken = other.idToken;
    if (l$idToken != lOther$idToken) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$idToken = idToken;
    return Object.hashAll([l$idToken]);
  }
}

class Mutation$GoogleSignIn {
  Mutation$GoogleSignIn({required this.googleSignIn});

  factory Mutation$GoogleSignIn.fromJson(Map<String, dynamic> json) {
    final l$googleSignIn = json['googleSignIn'];
    return Mutation$GoogleSignIn(
      googleSignIn: Fragment$SessionFields.fromJson(
        (l$googleSignIn as Map<String, dynamic>),
      ),
    );
  }

  final Fragment$SessionFields googleSignIn;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$googleSignIn = googleSignIn;
    _resultData['googleSignIn'] = l$googleSignIn.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$googleSignIn = googleSignIn;
    return Object.hashAll([l$googleSignIn]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$GoogleSignIn || runtimeType != other.runtimeType) {
      return false;
    }
    final l$googleSignIn = googleSignIn;
    final lOther$googleSignIn = other.googleSignIn;
    if (l$googleSignIn != lOther$googleSignIn) {
      return false;
    }
    return true;
  }
}

const documentNodeMutationGoogleSignIn = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'GoogleSignIn'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'idToken')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'googleSignIn'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'idToken'),
                value: VariableNode(name: NameNode(value: 'idToken')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'SessionFields'),
                  directives: [],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    fragmentDefinitionSessionFields,
    fragmentDefinitionUserFields,
  ],
);

class Variables$Mutation$SignUp {
  factory Variables$Mutation$SignUp({
    required String email,
    required String number,
    required String password,
  }) => Variables$Mutation$SignUp._({
    r'email': email,
    r'number': number,
    r'password': password,
  });

  Variables$Mutation$SignUp._(this._$data);

  factory Variables$Mutation$SignUp.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    final l$number = data['number'];
    result$data['number'] = (l$number as String);
    final l$password = data['password'];
    result$data['password'] = (l$password as String);
    return Variables$Mutation$SignUp._(result$data);
  }

  Map<String, dynamic> _$data;

  String get email => (_$data['email'] as String);

  String get number => (_$data['number'] as String);

  String get password => (_$data['password'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$email = email;
    result$data['email'] = l$email;
    final l$number = number;
    result$data['number'] = l$number;
    final l$password = password;
    result$data['password'] = l$password;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$SignUp ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$number = number;
    final lOther$number = other.number;
    if (l$number != lOther$number) {
      return false;
    }
    final l$password = password;
    final lOther$password = other.password;
    if (l$password != lOther$password) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$email = email;
    final l$number = number;
    final l$password = password;
    return Object.hashAll([l$email, l$number, l$password]);
  }
}

class Mutation$SignUp {
  Mutation$SignUp({required this.signUp});

  factory Mutation$SignUp.fromJson(Map<String, dynamic> json) {
    final l$signUp = json['signUp'];
    return Mutation$SignUp(
      signUp: Fragment$UserFields.fromJson((l$signUp as Map<String, dynamic>)),
    );
  }

  final Fragment$UserFields signUp;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$signUp = signUp;
    _resultData['signUp'] = l$signUp.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$signUp = signUp;
    return Object.hashAll([l$signUp]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$SignUp || runtimeType != other.runtimeType) {
      return false;
    }
    final l$signUp = signUp;
    final lOther$signUp = other.signUp;
    if (l$signUp != lOther$signUp) {
      return false;
    }
    return true;
  }
}

const documentNodeMutationSignUp = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SignUp'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'email')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'number')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'password')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'signUp'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'email'),
                value: VariableNode(name: NameNode(value: 'email')),
              ),
              ArgumentNode(
                name: NameNode(value: 'number'),
                value: VariableNode(name: NameNode(value: 'number')),
              ),
              ArgumentNode(
                name: NameNode(value: 'password'),
                value: VariableNode(name: NameNode(value: 'password')),
              ),
            ],
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

class Variables$Mutation$ForgotPassword {
  factory Variables$Mutation$ForgotPassword({required String email}) =>
      Variables$Mutation$ForgotPassword._({r'email': email});

  Variables$Mutation$ForgotPassword._(this._$data);

  factory Variables$Mutation$ForgotPassword.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    return Variables$Mutation$ForgotPassword._(result$data);
  }

  Map<String, dynamic> _$data;

  String get email => (_$data['email'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$email = email;
    result$data['email'] = l$email;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$ForgotPassword ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$email = email;
    return Object.hashAll([l$email]);
  }
}

class Mutation$ForgotPassword {
  Mutation$ForgotPassword({required this.forgotPassword});

  factory Mutation$ForgotPassword.fromJson(Map<String, dynamic> json) {
    final l$forgotPassword = json['forgotPassword'];
    return Mutation$ForgotPassword(forgotPassword: (l$forgotPassword as bool));
  }

  final bool forgotPassword;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$forgotPassword = forgotPassword;
    _resultData['forgotPassword'] = l$forgotPassword;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$forgotPassword = forgotPassword;
    return Object.hashAll([l$forgotPassword]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$ForgotPassword || runtimeType != other.runtimeType) {
      return false;
    }
    final l$forgotPassword = forgotPassword;
    final lOther$forgotPassword = other.forgotPassword;
    if (l$forgotPassword != lOther$forgotPassword) {
      return false;
    }
    return true;
  }
}

const documentNodeMutationForgotPassword = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ForgotPassword'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'email')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'forgotPassword'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'email'),
                value: VariableNode(name: NameNode(value: 'email')),
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
