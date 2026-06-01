// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ClientsTable extends Clients with TableInfo<$ClientsTable, Client> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
    'sync_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _middleNameMeta = const VerificationMeta(
    'middleName',
  );
  @override
  late final GeneratedColumn<String> middleName = GeneratedColumn<String>(
    'middle_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _visitsMeta = const VerificationMeta('visits');
  @override
  late final GeneratedColumn<int> visits = GeneratedColumn<int>(
    'visits',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('bound'),
  );
  static const VerificationMeta _lastModifiedUtcMeta = const VerificationMeta(
    'lastModifiedUtc',
  );
  @override
  late final GeneratedColumn<DateTime> lastModifiedUtc =
      GeneratedColumn<DateTime>(
        'last_modified_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _lastModifiedByMeta = const VerificationMeta(
    'lastModifiedBy',
  );
  @override
  late final GeneratedColumn<String> lastModifiedBy = GeneratedColumn<String>(
    'last_modified_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    syncId,
    firstName,
    middleName,
    lastName,
    phone,
    email,
    notes,
    visits,
    photoPath,
    status,
    lastModifiedUtc,
    lastModifiedBy,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Client> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sync_id')) {
      context.handle(
        _syncIdMeta,
        syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta),
      );
    } else if (isInserting) {
      context.missing(_syncIdMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('middle_name')) {
      context.handle(
        _middleNameMeta,
        middleName.isAcceptableOrUnknown(data['middle_name']!, _middleNameMeta),
      );
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('visits')) {
      context.handle(
        _visitsMeta,
        visits.isAcceptableOrUnknown(data['visits']!, _visitsMeta),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('last_modified_utc')) {
      context.handle(
        _lastModifiedUtcMeta,
        lastModifiedUtc.isAcceptableOrUnknown(
          data['last_modified_utc']!,
          _lastModifiedUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastModifiedUtcMeta);
    }
    if (data.containsKey('last_modified_by')) {
      context.handle(
        _lastModifiedByMeta,
        lastModifiedBy.isAcceptableOrUnknown(
          data['last_modified_by']!,
          _lastModifiedByMeta,
        ),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Client(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      syncId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_id'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      middleName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}middle_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      visits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}visits'],
      )!,
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      lastModifiedUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_modified_utc'],
      )!,
      lastModifiedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_modified_by'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(attachedDatabase, alias);
  }
}

class Client extends DataClass implements Insertable<Client> {
  /// Primary key
  final int id;

  /// Sync identifier for multi-device sync
  final String syncId;

  /// First name
  final String firstName;

  /// Middle name (optional)
  final String middleName;

  /// Last name
  final String lastName;

  /// Phone number
  final String phone;

  /// Email address
  final String email;

  /// Free-form notes
  final String notes;

  /// Number of visits
  final int visits;

  /// Path to profile photo
  final String photoPath;

  /// Client status (bound/freshSoul/highValue/void_)
  final String status;

  /// Last modification timestamp (UTC)
  final DateTime lastModifiedUtc;

  /// User who last modified this record
  final String lastModifiedBy;

  /// Soft delete flag
  final bool isDeleted;
  const Client({
    required this.id,
    required this.syncId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.notes,
    required this.visits,
    required this.photoPath,
    required this.status,
    required this.lastModifiedUtc,
    required this.lastModifiedBy,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_id'] = Variable<String>(syncId);
    map['first_name'] = Variable<String>(firstName);
    map['middle_name'] = Variable<String>(middleName);
    map['last_name'] = Variable<String>(lastName);
    map['phone'] = Variable<String>(phone);
    map['email'] = Variable<String>(email);
    map['notes'] = Variable<String>(notes);
    map['visits'] = Variable<int>(visits);
    map['photo_path'] = Variable<String>(photoPath);
    map['status'] = Variable<String>(status);
    map['last_modified_utc'] = Variable<DateTime>(lastModifiedUtc);
    map['last_modified_by'] = Variable<String>(lastModifiedBy);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      id: Value(id),
      syncId: Value(syncId),
      firstName: Value(firstName),
      middleName: Value(middleName),
      lastName: Value(lastName),
      phone: Value(phone),
      email: Value(email),
      notes: Value(notes),
      visits: Value(visits),
      photoPath: Value(photoPath),
      status: Value(status),
      lastModifiedUtc: Value(lastModifiedUtc),
      lastModifiedBy: Value(lastModifiedBy),
      isDeleted: Value(isDeleted),
    );
  }

  factory Client.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Client(
      id: serializer.fromJson<int>(json['id']),
      syncId: serializer.fromJson<String>(json['syncId']),
      firstName: serializer.fromJson<String>(json['firstName']),
      middleName: serializer.fromJson<String>(json['middleName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      phone: serializer.fromJson<String>(json['phone']),
      email: serializer.fromJson<String>(json['email']),
      notes: serializer.fromJson<String>(json['notes']),
      visits: serializer.fromJson<int>(json['visits']),
      photoPath: serializer.fromJson<String>(json['photoPath']),
      status: serializer.fromJson<String>(json['status']),
      lastModifiedUtc: serializer.fromJson<DateTime>(json['lastModifiedUtc']),
      lastModifiedBy: serializer.fromJson<String>(json['lastModifiedBy']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syncId': serializer.toJson<String>(syncId),
      'firstName': serializer.toJson<String>(firstName),
      'middleName': serializer.toJson<String>(middleName),
      'lastName': serializer.toJson<String>(lastName),
      'phone': serializer.toJson<String>(phone),
      'email': serializer.toJson<String>(email),
      'notes': serializer.toJson<String>(notes),
      'visits': serializer.toJson<int>(visits),
      'photoPath': serializer.toJson<String>(photoPath),
      'status': serializer.toJson<String>(status),
      'lastModifiedUtc': serializer.toJson<DateTime>(lastModifiedUtc),
      'lastModifiedBy': serializer.toJson<String>(lastModifiedBy),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  Client copyWith({
    int? id,
    String? syncId,
    String? firstName,
    String? middleName,
    String? lastName,
    String? phone,
    String? email,
    String? notes,
    int? visits,
    String? photoPath,
    String? status,
    DateTime? lastModifiedUtc,
    String? lastModifiedBy,
    bool? isDeleted,
  }) => Client(
    id: id ?? this.id,
    syncId: syncId ?? this.syncId,
    firstName: firstName ?? this.firstName,
    middleName: middleName ?? this.middleName,
    lastName: lastName ?? this.lastName,
    phone: phone ?? this.phone,
    email: email ?? this.email,
    notes: notes ?? this.notes,
    visits: visits ?? this.visits,
    photoPath: photoPath ?? this.photoPath,
    status: status ?? this.status,
    lastModifiedUtc: lastModifiedUtc ?? this.lastModifiedUtc,
    lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Client copyWithCompanion(ClientsCompanion data) {
    return Client(
      id: data.id.present ? data.id.value : this.id,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      middleName: data.middleName.present
          ? data.middleName.value
          : this.middleName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      notes: data.notes.present ? data.notes.value : this.notes,
      visits: data.visits.present ? data.visits.value : this.visits,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      status: data.status.present ? data.status.value : this.status,
      lastModifiedUtc: data.lastModifiedUtc.present
          ? data.lastModifiedUtc.value
          : this.lastModifiedUtc,
      lastModifiedBy: data.lastModifiedBy.present
          ? data.lastModifiedBy.value
          : this.lastModifiedBy,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('id: $id, ')
          ..write('syncId: $syncId, ')
          ..write('firstName: $firstName, ')
          ..write('middleName: $middleName, ')
          ..write('lastName: $lastName, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('notes: $notes, ')
          ..write('visits: $visits, ')
          ..write('photoPath: $photoPath, ')
          ..write('status: $status, ')
          ..write('lastModifiedUtc: $lastModifiedUtc, ')
          ..write('lastModifiedBy: $lastModifiedBy, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    syncId,
    firstName,
    middleName,
    lastName,
    phone,
    email,
    notes,
    visits,
    photoPath,
    status,
    lastModifiedUtc,
    lastModifiedBy,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Client &&
          other.id == this.id &&
          other.syncId == this.syncId &&
          other.firstName == this.firstName &&
          other.middleName == this.middleName &&
          other.lastName == this.lastName &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.notes == this.notes &&
          other.visits == this.visits &&
          other.photoPath == this.photoPath &&
          other.status == this.status &&
          other.lastModifiedUtc == this.lastModifiedUtc &&
          other.lastModifiedBy == this.lastModifiedBy &&
          other.isDeleted == this.isDeleted);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<int> id;
  final Value<String> syncId;
  final Value<String> firstName;
  final Value<String> middleName;
  final Value<String> lastName;
  final Value<String> phone;
  final Value<String> email;
  final Value<String> notes;
  final Value<int> visits;
  final Value<String> photoPath;
  final Value<String> status;
  final Value<DateTime> lastModifiedUtc;
  final Value<String> lastModifiedBy;
  final Value<bool> isDeleted;
  const ClientsCompanion({
    this.id = const Value.absent(),
    this.syncId = const Value.absent(),
    this.firstName = const Value.absent(),
    this.middleName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.notes = const Value.absent(),
    this.visits = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.status = const Value.absent(),
    this.lastModifiedUtc = const Value.absent(),
    this.lastModifiedBy = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  ClientsCompanion.insert({
    this.id = const Value.absent(),
    required String syncId,
    required String firstName,
    this.middleName = const Value.absent(),
    required String lastName,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.notes = const Value.absent(),
    this.visits = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime lastModifiedUtc,
    this.lastModifiedBy = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : syncId = Value(syncId),
       firstName = Value(firstName),
       lastName = Value(lastName),
       lastModifiedUtc = Value(lastModifiedUtc);
  static Insertable<Client> custom({
    Expression<int>? id,
    Expression<String>? syncId,
    Expression<String>? firstName,
    Expression<String>? middleName,
    Expression<String>? lastName,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? notes,
    Expression<int>? visits,
    Expression<String>? photoPath,
    Expression<String>? status,
    Expression<DateTime>? lastModifiedUtc,
    Expression<String>? lastModifiedBy,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncId != null) 'sync_id': syncId,
      if (firstName != null) 'first_name': firstName,
      if (middleName != null) 'middle_name': middleName,
      if (lastName != null) 'last_name': lastName,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (notes != null) 'notes': notes,
      if (visits != null) 'visits': visits,
      if (photoPath != null) 'photo_path': photoPath,
      if (status != null) 'status': status,
      if (lastModifiedUtc != null) 'last_modified_utc': lastModifiedUtc,
      if (lastModifiedBy != null) 'last_modified_by': lastModifiedBy,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  ClientsCompanion copyWith({
    Value<int>? id,
    Value<String>? syncId,
    Value<String>? firstName,
    Value<String>? middleName,
    Value<String>? lastName,
    Value<String>? phone,
    Value<String>? email,
    Value<String>? notes,
    Value<int>? visits,
    Value<String>? photoPath,
    Value<String>? status,
    Value<DateTime>? lastModifiedUtc,
    Value<String>? lastModifiedBy,
    Value<bool>? isDeleted,
  }) {
    return ClientsCompanion(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      notes: notes ?? this.notes,
      visits: visits ?? this.visits,
      photoPath: photoPath ?? this.photoPath,
      status: status ?? this.status,
      lastModifiedUtc: lastModifiedUtc ?? this.lastModifiedUtc,
      lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (middleName.present) {
      map['middle_name'] = Variable<String>(middleName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (visits.present) {
      map['visits'] = Variable<int>(visits.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (lastModifiedUtc.present) {
      map['last_modified_utc'] = Variable<DateTime>(lastModifiedUtc.value);
    }
    if (lastModifiedBy.present) {
      map['last_modified_by'] = Variable<String>(lastModifiedBy.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('id: $id, ')
          ..write('syncId: $syncId, ')
          ..write('firstName: $firstName, ')
          ..write('middleName: $middleName, ')
          ..write('lastName: $lastName, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('notes: $notes, ')
          ..write('visits: $visits, ')
          ..write('photoPath: $photoPath, ')
          ..write('status: $status, ')
          ..write('lastModifiedUtc: $lastModifiedUtc, ')
          ..write('lastModifiedBy: $lastModifiedBy, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('artist'),
  );
  static const VerificationMeta _themeKeyMeta = const VerificationMeta(
    'themeKey',
  );
  @override
  late final GeneratedColumn<String> themeKey = GeneratedColumn<String>(
    'theme_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('InfernalNeon'),
  );
  static const VerificationMeta _avatarPathMeta = const VerificationMeta(
    'avatarPath',
  );
  @override
  late final GeneratedColumn<String> avatarPath = GeneratedColumn<String>(
    'avatar_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _hourlyRateMeta = const VerificationMeta(
    'hourlyRate',
  );
  @override
  late final GeneratedColumn<double> hourlyRate = GeneratedColumn<double>(
    'hourly_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(150.0),
  );
  static const VerificationMeta _speedFactorMeta = const VerificationMeta(
    'speedFactor',
  );
  @override
  late final GeneratedColumn<double> speedFactor = GeneratedColumn<double>(
    'speed_factor',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastLoginAtMeta = const VerificationMeta(
    'lastLoginAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastLoginAt = GeneratedColumn<DateTime>(
    'last_login_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _departmentMeta = const VerificationMeta(
    'department',
  );
  @override
  late final GeneratedColumn<String> department = GeneratedColumn<String>(
    'department',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _commissionRateMeta = const VerificationMeta(
    'commissionRate',
  );
  @override
  late final GeneratedColumn<double> commissionRate = GeneratedColumn<double>(
    'commission_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _fontSizeMeta = const VerificationMeta(
    'fontSize',
  );
  @override
  late final GeneratedColumn<int> fontSize = GeneratedColumn<int>(
    'font_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(14),
  );
  static const VerificationMeta _keyboardShortcutsJsonMeta =
      const VerificationMeta('keyboardShortcutsJson');
  @override
  late final GeneratedColumn<String> keyboardShortcutsJson =
      GeneratedColumn<String>(
        'keyboard_shortcuts_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _permissionsJsonMeta = const VerificationMeta(
    'permissionsJson',
  );
  @override
  late final GeneratedColumn<String> permissionsJson = GeneratedColumn<String>(
    'permissions_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    username,
    displayName,
    passwordHash,
    role,
    themeKey,
    avatarPath,
    hourlyRate,
    speedFactor,
    createdAt,
    updatedAt,
    lastLoginAt,
    isActive,
    isDeleted,
    deletedAt,
    department,
    commissionRate,
    fontSize,
    keyboardShortcutsJson,
    permissionsJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('theme_key')) {
      context.handle(
        _themeKeyMeta,
        themeKey.isAcceptableOrUnknown(data['theme_key']!, _themeKeyMeta),
      );
    }
    if (data.containsKey('avatar_path')) {
      context.handle(
        _avatarPathMeta,
        avatarPath.isAcceptableOrUnknown(data['avatar_path']!, _avatarPathMeta),
      );
    }
    if (data.containsKey('hourly_rate')) {
      context.handle(
        _hourlyRateMeta,
        hourlyRate.isAcceptableOrUnknown(data['hourly_rate']!, _hourlyRateMeta),
      );
    }
    if (data.containsKey('speed_factor')) {
      context.handle(
        _speedFactorMeta,
        speedFactor.isAcceptableOrUnknown(
          data['speed_factor']!,
          _speedFactorMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('last_login_at')) {
      context.handle(
        _lastLoginAtMeta,
        lastLoginAt.isAcceptableOrUnknown(
          data['last_login_at']!,
          _lastLoginAtMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('department')) {
      context.handle(
        _departmentMeta,
        department.isAcceptableOrUnknown(data['department']!, _departmentMeta),
      );
    }
    if (data.containsKey('commission_rate')) {
      context.handle(
        _commissionRateMeta,
        commissionRate.isAcceptableOrUnknown(
          data['commission_rate']!,
          _commissionRateMeta,
        ),
      );
    }
    if (data.containsKey('font_size')) {
      context.handle(
        _fontSizeMeta,
        fontSize.isAcceptableOrUnknown(data['font_size']!, _fontSizeMeta),
      );
    }
    if (data.containsKey('keyboard_shortcuts_json')) {
      context.handle(
        _keyboardShortcutsJsonMeta,
        keyboardShortcutsJson.isAcceptableOrUnknown(
          data['keyboard_shortcuts_json']!,
          _keyboardShortcutsJsonMeta,
        ),
      );
    }
    if (data.containsKey('permissions_json')) {
      context.handle(
        _permissionsJsonMeta,
        permissionsJson.isAcceptableOrUnknown(
          data['permissions_json']!,
          _permissionsJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      themeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_key'],
      )!,
      avatarPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_path'],
      )!,
      hourlyRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hourly_rate'],
      )!,
      speedFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}speed_factor'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      lastLoginAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_login_at'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      department: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}department'],
      )!,
      commissionRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}commission_rate'],
      )!,
      fontSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}font_size'],
      )!,
      keyboardShortcutsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}keyboard_shortcuts_json'],
      )!,
      permissionsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}permissions_json'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  /// Primary key
  final int id;

  /// Unique login username
  final String username;

  /// Display name for UI
  final String displayName;

  /// Hashed password (BCrypt)
  final String passwordHash;

  /// User role (admin/artist)
  final String role;

  /// UI theme preference key
  final String themeKey;

  /// Path to avatar image
  final String avatarPath;

  /// Default hourly rate
  final double hourlyRate;

  /// Work speed multiplier
  final double speedFactor;

  /// Account creation timestamp
  final DateTime createdAt;

  /// Last update timestamp
  final DateTime updatedAt;

  /// Last login timestamp
  final DateTime? lastLoginAt;

  /// Whether account is active
  final bool isActive;

  /// Soft delete flag
  final bool isDeleted;

  /// Deletion timestamp
  final DateTime? deletedAt;

  /// Department assignment
  final String department;

  /// Commission rate (0-1)
  final double commissionRate;

  /// UI font size preference
  final int fontSize;

  /// JSON string for keyboard shortcuts
  final String keyboardShortcutsJson;

  /// JSON string for permissions
  final String permissionsJson;
  const User({
    required this.id,
    required this.username,
    required this.displayName,
    required this.passwordHash,
    required this.role,
    required this.themeKey,
    required this.avatarPath,
    required this.hourlyRate,
    required this.speedFactor,
    required this.createdAt,
    required this.updatedAt,
    this.lastLoginAt,
    required this.isActive,
    required this.isDeleted,
    this.deletedAt,
    required this.department,
    required this.commissionRate,
    required this.fontSize,
    required this.keyboardShortcutsJson,
    required this.permissionsJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['display_name'] = Variable<String>(displayName);
    map['password_hash'] = Variable<String>(passwordHash);
    map['role'] = Variable<String>(role);
    map['theme_key'] = Variable<String>(themeKey);
    map['avatar_path'] = Variable<String>(avatarPath);
    map['hourly_rate'] = Variable<double>(hourlyRate);
    map['speed_factor'] = Variable<double>(speedFactor);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || lastLoginAt != null) {
      map['last_login_at'] = Variable<DateTime>(lastLoginAt);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['is_deleted'] = Variable<bool>(isDeleted);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['department'] = Variable<String>(department);
    map['commission_rate'] = Variable<double>(commissionRate);
    map['font_size'] = Variable<int>(fontSize);
    map['keyboard_shortcuts_json'] = Variable<String>(keyboardShortcutsJson);
    map['permissions_json'] = Variable<String>(permissionsJson);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      displayName: Value(displayName),
      passwordHash: Value(passwordHash),
      role: Value(role),
      themeKey: Value(themeKey),
      avatarPath: Value(avatarPath),
      hourlyRate: Value(hourlyRate),
      speedFactor: Value(speedFactor),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      lastLoginAt: lastLoginAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLoginAt),
      isActive: Value(isActive),
      isDeleted: Value(isDeleted),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      department: Value(department),
      commissionRate: Value(commissionRate),
      fontSize: Value(fontSize),
      keyboardShortcutsJson: Value(keyboardShortcutsJson),
      permissionsJson: Value(permissionsJson),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      displayName: serializer.fromJson<String>(json['displayName']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      role: serializer.fromJson<String>(json['role']),
      themeKey: serializer.fromJson<String>(json['themeKey']),
      avatarPath: serializer.fromJson<String>(json['avatarPath']),
      hourlyRate: serializer.fromJson<double>(json['hourlyRate']),
      speedFactor: serializer.fromJson<double>(json['speedFactor']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      lastLoginAt: serializer.fromJson<DateTime?>(json['lastLoginAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      department: serializer.fromJson<String>(json['department']),
      commissionRate: serializer.fromJson<double>(json['commissionRate']),
      fontSize: serializer.fromJson<int>(json['fontSize']),
      keyboardShortcutsJson: serializer.fromJson<String>(
        json['keyboardShortcutsJson'],
      ),
      permissionsJson: serializer.fromJson<String>(json['permissionsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'displayName': serializer.toJson<String>(displayName),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'role': serializer.toJson<String>(role),
      'themeKey': serializer.toJson<String>(themeKey),
      'avatarPath': serializer.toJson<String>(avatarPath),
      'hourlyRate': serializer.toJson<double>(hourlyRate),
      'speedFactor': serializer.toJson<double>(speedFactor),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'lastLoginAt': serializer.toJson<DateTime?>(lastLoginAt),
      'isActive': serializer.toJson<bool>(isActive),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'department': serializer.toJson<String>(department),
      'commissionRate': serializer.toJson<double>(commissionRate),
      'fontSize': serializer.toJson<int>(fontSize),
      'keyboardShortcutsJson': serializer.toJson<String>(keyboardShortcutsJson),
      'permissionsJson': serializer.toJson<String>(permissionsJson),
    };
  }

  User copyWith({
    int? id,
    String? username,
    String? displayName,
    String? passwordHash,
    String? role,
    String? themeKey,
    String? avatarPath,
    double? hourlyRate,
    double? speedFactor,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> lastLoginAt = const Value.absent(),
    bool? isActive,
    bool? isDeleted,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? department,
    double? commissionRate,
    int? fontSize,
    String? keyboardShortcutsJson,
    String? permissionsJson,
  }) => User(
    id: id ?? this.id,
    username: username ?? this.username,
    displayName: displayName ?? this.displayName,
    passwordHash: passwordHash ?? this.passwordHash,
    role: role ?? this.role,
    themeKey: themeKey ?? this.themeKey,
    avatarPath: avatarPath ?? this.avatarPath,
    hourlyRate: hourlyRate ?? this.hourlyRate,
    speedFactor: speedFactor ?? this.speedFactor,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    lastLoginAt: lastLoginAt.present ? lastLoginAt.value : this.lastLoginAt,
    isActive: isActive ?? this.isActive,
    isDeleted: isDeleted ?? this.isDeleted,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    department: department ?? this.department,
    commissionRate: commissionRate ?? this.commissionRate,
    fontSize: fontSize ?? this.fontSize,
    keyboardShortcutsJson: keyboardShortcutsJson ?? this.keyboardShortcutsJson,
    permissionsJson: permissionsJson ?? this.permissionsJson,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      role: data.role.present ? data.role.value : this.role,
      themeKey: data.themeKey.present ? data.themeKey.value : this.themeKey,
      avatarPath: data.avatarPath.present
          ? data.avatarPath.value
          : this.avatarPath,
      hourlyRate: data.hourlyRate.present
          ? data.hourlyRate.value
          : this.hourlyRate,
      speedFactor: data.speedFactor.present
          ? data.speedFactor.value
          : this.speedFactor,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastLoginAt: data.lastLoginAt.present
          ? data.lastLoginAt.value
          : this.lastLoginAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      department: data.department.present
          ? data.department.value
          : this.department,
      commissionRate: data.commissionRate.present
          ? data.commissionRate.value
          : this.commissionRate,
      fontSize: data.fontSize.present ? data.fontSize.value : this.fontSize,
      keyboardShortcutsJson: data.keyboardShortcutsJson.present
          ? data.keyboardShortcutsJson.value
          : this.keyboardShortcutsJson,
      permissionsJson: data.permissionsJson.present
          ? data.permissionsJson.value
          : this.permissionsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('displayName: $displayName, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('role: $role, ')
          ..write('themeKey: $themeKey, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('hourlyRate: $hourlyRate, ')
          ..write('speedFactor: $speedFactor, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastLoginAt: $lastLoginAt, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('department: $department, ')
          ..write('commissionRate: $commissionRate, ')
          ..write('fontSize: $fontSize, ')
          ..write('keyboardShortcutsJson: $keyboardShortcutsJson, ')
          ..write('permissionsJson: $permissionsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    username,
    displayName,
    passwordHash,
    role,
    themeKey,
    avatarPath,
    hourlyRate,
    speedFactor,
    createdAt,
    updatedAt,
    lastLoginAt,
    isActive,
    isDeleted,
    deletedAt,
    department,
    commissionRate,
    fontSize,
    keyboardShortcutsJson,
    permissionsJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.displayName == this.displayName &&
          other.passwordHash == this.passwordHash &&
          other.role == this.role &&
          other.themeKey == this.themeKey &&
          other.avatarPath == this.avatarPath &&
          other.hourlyRate == this.hourlyRate &&
          other.speedFactor == this.speedFactor &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.lastLoginAt == this.lastLoginAt &&
          other.isActive == this.isActive &&
          other.isDeleted == this.isDeleted &&
          other.deletedAt == this.deletedAt &&
          other.department == this.department &&
          other.commissionRate == this.commissionRate &&
          other.fontSize == this.fontSize &&
          other.keyboardShortcutsJson == this.keyboardShortcutsJson &&
          other.permissionsJson == this.permissionsJson);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> displayName;
  final Value<String> passwordHash;
  final Value<String> role;
  final Value<String> themeKey;
  final Value<String> avatarPath;
  final Value<double> hourlyRate;
  final Value<double> speedFactor;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> lastLoginAt;
  final Value<bool> isActive;
  final Value<bool> isDeleted;
  final Value<DateTime?> deletedAt;
  final Value<String> department;
  final Value<double> commissionRate;
  final Value<int> fontSize;
  final Value<String> keyboardShortcutsJson;
  final Value<String> permissionsJson;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.displayName = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.role = const Value.absent(),
    this.themeKey = const Value.absent(),
    this.avatarPath = const Value.absent(),
    this.hourlyRate = const Value.absent(),
    this.speedFactor = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastLoginAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.department = const Value.absent(),
    this.commissionRate = const Value.absent(),
    this.fontSize = const Value.absent(),
    this.keyboardShortcutsJson = const Value.absent(),
    this.permissionsJson = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    this.displayName = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.role = const Value.absent(),
    this.themeKey = const Value.absent(),
    this.avatarPath = const Value.absent(),
    this.hourlyRate = const Value.absent(),
    this.speedFactor = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.lastLoginAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.department = const Value.absent(),
    this.commissionRate = const Value.absent(),
    this.fontSize = const Value.absent(),
    this.keyboardShortcutsJson = const Value.absent(),
    this.permissionsJson = const Value.absent(),
  }) : username = Value(username),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? displayName,
    Expression<String>? passwordHash,
    Expression<String>? role,
    Expression<String>? themeKey,
    Expression<String>? avatarPath,
    Expression<double>? hourlyRate,
    Expression<double>? speedFactor,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? lastLoginAt,
    Expression<bool>? isActive,
    Expression<bool>? isDeleted,
    Expression<DateTime>? deletedAt,
    Expression<String>? department,
    Expression<double>? commissionRate,
    Expression<int>? fontSize,
    Expression<String>? keyboardShortcutsJson,
    Expression<String>? permissionsJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (displayName != null) 'display_name': displayName,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (role != null) 'role': role,
      if (themeKey != null) 'theme_key': themeKey,
      if (avatarPath != null) 'avatar_path': avatarPath,
      if (hourlyRate != null) 'hourly_rate': hourlyRate,
      if (speedFactor != null) 'speed_factor': speedFactor,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastLoginAt != null) 'last_login_at': lastLoginAt,
      if (isActive != null) 'is_active': isActive,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (department != null) 'department': department,
      if (commissionRate != null) 'commission_rate': commissionRate,
      if (fontSize != null) 'font_size': fontSize,
      if (keyboardShortcutsJson != null)
        'keyboard_shortcuts_json': keyboardShortcutsJson,
      if (permissionsJson != null) 'permissions_json': permissionsJson,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? username,
    Value<String>? displayName,
    Value<String>? passwordHash,
    Value<String>? role,
    Value<String>? themeKey,
    Value<String>? avatarPath,
    Value<double>? hourlyRate,
    Value<double>? speedFactor,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? lastLoginAt,
    Value<bool>? isActive,
    Value<bool>? isDeleted,
    Value<DateTime?>? deletedAt,
    Value<String>? department,
    Value<double>? commissionRate,
    Value<int>? fontSize,
    Value<String>? keyboardShortcutsJson,
    Value<String>? permissionsJson,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      passwordHash: passwordHash ?? this.passwordHash,
      role: role ?? this.role,
      themeKey: themeKey ?? this.themeKey,
      avatarPath: avatarPath ?? this.avatarPath,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      speedFactor: speedFactor ?? this.speedFactor,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      deletedAt: deletedAt ?? this.deletedAt,
      department: department ?? this.department,
      commissionRate: commissionRate ?? this.commissionRate,
      fontSize: fontSize ?? this.fontSize,
      keyboardShortcutsJson:
          keyboardShortcutsJson ?? this.keyboardShortcutsJson,
      permissionsJson: permissionsJson ?? this.permissionsJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (themeKey.present) {
      map['theme_key'] = Variable<String>(themeKey.value);
    }
    if (avatarPath.present) {
      map['avatar_path'] = Variable<String>(avatarPath.value);
    }
    if (hourlyRate.present) {
      map['hourly_rate'] = Variable<double>(hourlyRate.value);
    }
    if (speedFactor.present) {
      map['speed_factor'] = Variable<double>(speedFactor.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (lastLoginAt.present) {
      map['last_login_at'] = Variable<DateTime>(lastLoginAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (department.present) {
      map['department'] = Variable<String>(department.value);
    }
    if (commissionRate.present) {
      map['commission_rate'] = Variable<double>(commissionRate.value);
    }
    if (fontSize.present) {
      map['font_size'] = Variable<int>(fontSize.value);
    }
    if (keyboardShortcutsJson.present) {
      map['keyboard_shortcuts_json'] = Variable<String>(
        keyboardShortcutsJson.value,
      );
    }
    if (permissionsJson.present) {
      map['permissions_json'] = Variable<String>(permissionsJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('displayName: $displayName, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('role: $role, ')
          ..write('themeKey: $themeKey, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('hourlyRate: $hourlyRate, ')
          ..write('speedFactor: $speedFactor, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastLoginAt: $lastLoginAt, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('department: $department, ')
          ..write('commissionRate: $commissionRate, ')
          ..write('fontSize: $fontSize, ')
          ..write('keyboardShortcutsJson: $keyboardShortcutsJson, ')
          ..write('permissionsJson: $permissionsJson')
          ..write(')'))
        .toString();
  }
}

class $AppointmentsTable extends Appointments
    with TableInfo<$AppointmentsTable, Appointment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppointmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
    'sync_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientNameMeta = const VerificationMeta(
    'clientName',
  );
  @override
  late final GeneratedColumn<String> clientName = GeneratedColumn<String>(
    'client_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceTypeMeta = const VerificationMeta(
    'serviceType',
  );
  @override
  late final GeneratedColumn<String> serviceType = GeneratedColumn<String>(
    'service_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Tattoo'),
  );
  static const VerificationMeta _serviceCategoryMeta = const VerificationMeta(
    'serviceCategory',
  );
  @override
  late final GeneratedColumn<String> serviceCategory = GeneratedColumn<String>(
    'service_category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('General'),
  );
  static const VerificationMeta _priceTypeMeta = const VerificationMeta(
    'priceType',
  );
  @override
  late final GeneratedColumn<String> priceType = GeneratedColumn<String>(
    'price_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Hourly'),
  );
  static const VerificationMeta _priceChargedMeta = const VerificationMeta(
    'priceCharged',
  );
  @override
  late final GeneratedColumn<double> priceCharged = GeneratedColumn<double>(
    'price_charged',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _quotedPriceMeta = const VerificationMeta(
    'quotedPrice',
  );
  @override
  late final GeneratedColumn<double> quotedPrice = GeneratedColumn<double>(
    'quoted_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _finalPriceMeta = const VerificationMeta(
    'finalPrice',
  );
  @override
  late final GeneratedColumn<double> finalPrice = GeneratedColumn<double>(
    'final_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Scheduled'),
  );
  static const VerificationMeta _isBlockOffMeta = const VerificationMeta(
    'isBlockOff',
  );
  @override
  late final GeneratedColumn<bool> isBlockOff = GeneratedColumn<bool>(
    'is_block_off',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_block_off" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _modifiedAtMeta = const VerificationMeta(
    'modifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
    'modified_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastModifiedByMeta = const VerificationMeta(
    'lastModifiedBy',
  );
  @override
  late final GeneratedColumn<String> lastModifiedBy = GeneratedColumn<String>(
    'last_modified_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    syncId,
    clientId,
    userId,
    clientName,
    startTime,
    durationMinutes,
    serviceType,
    serviceCategory,
    priceType,
    priceCharged,
    quotedPrice,
    finalPrice,
    notes,
    photoPath,
    color,
    status,
    isBlockOff,
    modifiedAt,
    lastModifiedBy,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'appointments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Appointment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sync_id')) {
      context.handle(
        _syncIdMeta,
        syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta),
      );
    } else if (isInserting) {
      context.missing(_syncIdMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('client_name')) {
      context.handle(
        _clientNameMeta,
        clientName.isAcceptableOrUnknown(data['client_name']!, _clientNameMeta),
      );
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('service_type')) {
      context.handle(
        _serviceTypeMeta,
        serviceType.isAcceptableOrUnknown(
          data['service_type']!,
          _serviceTypeMeta,
        ),
      );
    }
    if (data.containsKey('service_category')) {
      context.handle(
        _serviceCategoryMeta,
        serviceCategory.isAcceptableOrUnknown(
          data['service_category']!,
          _serviceCategoryMeta,
        ),
      );
    }
    if (data.containsKey('price_type')) {
      context.handle(
        _priceTypeMeta,
        priceType.isAcceptableOrUnknown(data['price_type']!, _priceTypeMeta),
      );
    }
    if (data.containsKey('price_charged')) {
      context.handle(
        _priceChargedMeta,
        priceCharged.isAcceptableOrUnknown(
          data['price_charged']!,
          _priceChargedMeta,
        ),
      );
    }
    if (data.containsKey('quoted_price')) {
      context.handle(
        _quotedPriceMeta,
        quotedPrice.isAcceptableOrUnknown(
          data['quoted_price']!,
          _quotedPriceMeta,
        ),
      );
    }
    if (data.containsKey('final_price')) {
      context.handle(
        _finalPriceMeta,
        finalPrice.isAcceptableOrUnknown(data['final_price']!, _finalPriceMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('is_block_off')) {
      context.handle(
        _isBlockOffMeta,
        isBlockOff.isAcceptableOrUnknown(
          data['is_block_off']!,
          _isBlockOffMeta,
        ),
      );
    }
    if (data.containsKey('modified_at')) {
      context.handle(
        _modifiedAtMeta,
        modifiedAt.isAcceptableOrUnknown(data['modified_at']!, _modifiedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_modifiedAtMeta);
    }
    if (data.containsKey('last_modified_by')) {
      context.handle(
        _lastModifiedByMeta,
        lastModifiedBy.isAcceptableOrUnknown(
          data['last_modified_by']!,
          _lastModifiedByMeta,
        ),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Appointment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Appointment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      syncId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      clientName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_name'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      )!,
      serviceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_type'],
      )!,
      serviceCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_category'],
      )!,
      priceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}price_type'],
      )!,
      priceCharged: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_charged'],
      )!,
      quotedPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quoted_price'],
      ),
      finalPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}final_price'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      isBlockOff: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_block_off'],
      )!,
      modifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}modified_at'],
      )!,
      lastModifiedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_modified_by'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $AppointmentsTable createAlias(String alias) {
    return $AppointmentsTable(attachedDatabase, alias);
  }
}

class Appointment extends DataClass implements Insertable<Appointment> {
  /// Primary key
  final int id;

  /// Sync identifier for multi-device sync
  final String syncId;

  /// Foreign key to Client
  final int clientId;

  /// Foreign key to User (Artist)
  final int userId;

  /// Denormalized client name for quick display
  final String clientName;

  /// Appointment start date/time (renamed from dateTime to avoid Table conflict)
  final DateTime startTime;

  /// Duration in minutes
  final int durationMinutes;

  /// Type of service (Tattoo, Piercing, etc.)
  final String serviceType;

  /// Service category grouping
  final String serviceCategory;

  /// Pricing method (Hourly, Flat, etc.)
  final String priceType;

  /// Amount charged
  final double priceCharged;

  /// Original quoted price
  final double? quotedPrice;

  /// Finalized price
  final double? finalPrice;

  /// Free-form notes
  final String? notes;

  /// Path to reference photo
  final String? photoPath;

  /// Calendar display color (hex or named)
  final String color;

  /// Current status (Scheduled, Completed, etc.)
  final String status;

  /// Whether this is a time block (not a real appointment)
  final bool isBlockOff;

  /// Last modification timestamp (UTC)
  final DateTime modifiedAt;

  /// User who last modified this record
  final String lastModifiedBy;

  /// Soft delete flag
  final bool isDeleted;
  const Appointment({
    required this.id,
    required this.syncId,
    required this.clientId,
    required this.userId,
    required this.clientName,
    required this.startTime,
    required this.durationMinutes,
    required this.serviceType,
    required this.serviceCategory,
    required this.priceType,
    required this.priceCharged,
    this.quotedPrice,
    this.finalPrice,
    this.notes,
    this.photoPath,
    required this.color,
    required this.status,
    required this.isBlockOff,
    required this.modifiedAt,
    required this.lastModifiedBy,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_id'] = Variable<String>(syncId);
    map['client_id'] = Variable<int>(clientId);
    map['user_id'] = Variable<int>(userId);
    map['client_name'] = Variable<String>(clientName);
    map['start_time'] = Variable<DateTime>(startTime);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    map['service_type'] = Variable<String>(serviceType);
    map['service_category'] = Variable<String>(serviceCategory);
    map['price_type'] = Variable<String>(priceType);
    map['price_charged'] = Variable<double>(priceCharged);
    if (!nullToAbsent || quotedPrice != null) {
      map['quoted_price'] = Variable<double>(quotedPrice);
    }
    if (!nullToAbsent || finalPrice != null) {
      map['final_price'] = Variable<double>(finalPrice);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['color'] = Variable<String>(color);
    map['status'] = Variable<String>(status);
    map['is_block_off'] = Variable<bool>(isBlockOff);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    map['last_modified_by'] = Variable<String>(lastModifiedBy);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  AppointmentsCompanion toCompanion(bool nullToAbsent) {
    return AppointmentsCompanion(
      id: Value(id),
      syncId: Value(syncId),
      clientId: Value(clientId),
      userId: Value(userId),
      clientName: Value(clientName),
      startTime: Value(startTime),
      durationMinutes: Value(durationMinutes),
      serviceType: Value(serviceType),
      serviceCategory: Value(serviceCategory),
      priceType: Value(priceType),
      priceCharged: Value(priceCharged),
      quotedPrice: quotedPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(quotedPrice),
      finalPrice: finalPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(finalPrice),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      color: Value(color),
      status: Value(status),
      isBlockOff: Value(isBlockOff),
      modifiedAt: Value(modifiedAt),
      lastModifiedBy: Value(lastModifiedBy),
      isDeleted: Value(isDeleted),
    );
  }

  factory Appointment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Appointment(
      id: serializer.fromJson<int>(json['id']),
      syncId: serializer.fromJson<String>(json['syncId']),
      clientId: serializer.fromJson<int>(json['clientId']),
      userId: serializer.fromJson<int>(json['userId']),
      clientName: serializer.fromJson<String>(json['clientName']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      serviceType: serializer.fromJson<String>(json['serviceType']),
      serviceCategory: serializer.fromJson<String>(json['serviceCategory']),
      priceType: serializer.fromJson<String>(json['priceType']),
      priceCharged: serializer.fromJson<double>(json['priceCharged']),
      quotedPrice: serializer.fromJson<double?>(json['quotedPrice']),
      finalPrice: serializer.fromJson<double?>(json['finalPrice']),
      notes: serializer.fromJson<String?>(json['notes']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      color: serializer.fromJson<String>(json['color']),
      status: serializer.fromJson<String>(json['status']),
      isBlockOff: serializer.fromJson<bool>(json['isBlockOff']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
      lastModifiedBy: serializer.fromJson<String>(json['lastModifiedBy']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syncId': serializer.toJson<String>(syncId),
      'clientId': serializer.toJson<int>(clientId),
      'userId': serializer.toJson<int>(userId),
      'clientName': serializer.toJson<String>(clientName),
      'startTime': serializer.toJson<DateTime>(startTime),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'serviceType': serializer.toJson<String>(serviceType),
      'serviceCategory': serializer.toJson<String>(serviceCategory),
      'priceType': serializer.toJson<String>(priceType),
      'priceCharged': serializer.toJson<double>(priceCharged),
      'quotedPrice': serializer.toJson<double?>(quotedPrice),
      'finalPrice': serializer.toJson<double?>(finalPrice),
      'notes': serializer.toJson<String?>(notes),
      'photoPath': serializer.toJson<String?>(photoPath),
      'color': serializer.toJson<String>(color),
      'status': serializer.toJson<String>(status),
      'isBlockOff': serializer.toJson<bool>(isBlockOff),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
      'lastModifiedBy': serializer.toJson<String>(lastModifiedBy),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  Appointment copyWith({
    int? id,
    String? syncId,
    int? clientId,
    int? userId,
    String? clientName,
    DateTime? startTime,
    int? durationMinutes,
    String? serviceType,
    String? serviceCategory,
    String? priceType,
    double? priceCharged,
    Value<double?> quotedPrice = const Value.absent(),
    Value<double?> finalPrice = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
    String? color,
    String? status,
    bool? isBlockOff,
    DateTime? modifiedAt,
    String? lastModifiedBy,
    bool? isDeleted,
  }) => Appointment(
    id: id ?? this.id,
    syncId: syncId ?? this.syncId,
    clientId: clientId ?? this.clientId,
    userId: userId ?? this.userId,
    clientName: clientName ?? this.clientName,
    startTime: startTime ?? this.startTime,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    serviceType: serviceType ?? this.serviceType,
    serviceCategory: serviceCategory ?? this.serviceCategory,
    priceType: priceType ?? this.priceType,
    priceCharged: priceCharged ?? this.priceCharged,
    quotedPrice: quotedPrice.present ? quotedPrice.value : this.quotedPrice,
    finalPrice: finalPrice.present ? finalPrice.value : this.finalPrice,
    notes: notes.present ? notes.value : this.notes,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    color: color ?? this.color,
    status: status ?? this.status,
    isBlockOff: isBlockOff ?? this.isBlockOff,
    modifiedAt: modifiedAt ?? this.modifiedAt,
    lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Appointment copyWithCompanion(AppointmentsCompanion data) {
    return Appointment(
      id: data.id.present ? data.id.value : this.id,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      userId: data.userId.present ? data.userId.value : this.userId,
      clientName: data.clientName.present
          ? data.clientName.value
          : this.clientName,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      serviceType: data.serviceType.present
          ? data.serviceType.value
          : this.serviceType,
      serviceCategory: data.serviceCategory.present
          ? data.serviceCategory.value
          : this.serviceCategory,
      priceType: data.priceType.present ? data.priceType.value : this.priceType,
      priceCharged: data.priceCharged.present
          ? data.priceCharged.value
          : this.priceCharged,
      quotedPrice: data.quotedPrice.present
          ? data.quotedPrice.value
          : this.quotedPrice,
      finalPrice: data.finalPrice.present
          ? data.finalPrice.value
          : this.finalPrice,
      notes: data.notes.present ? data.notes.value : this.notes,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      color: data.color.present ? data.color.value : this.color,
      status: data.status.present ? data.status.value : this.status,
      isBlockOff: data.isBlockOff.present
          ? data.isBlockOff.value
          : this.isBlockOff,
      modifiedAt: data.modifiedAt.present
          ? data.modifiedAt.value
          : this.modifiedAt,
      lastModifiedBy: data.lastModifiedBy.present
          ? data.lastModifiedBy.value
          : this.lastModifiedBy,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Appointment(')
          ..write('id: $id, ')
          ..write('syncId: $syncId, ')
          ..write('clientId: $clientId, ')
          ..write('userId: $userId, ')
          ..write('clientName: $clientName, ')
          ..write('startTime: $startTime, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('serviceType: $serviceType, ')
          ..write('serviceCategory: $serviceCategory, ')
          ..write('priceType: $priceType, ')
          ..write('priceCharged: $priceCharged, ')
          ..write('quotedPrice: $quotedPrice, ')
          ..write('finalPrice: $finalPrice, ')
          ..write('notes: $notes, ')
          ..write('photoPath: $photoPath, ')
          ..write('color: $color, ')
          ..write('status: $status, ')
          ..write('isBlockOff: $isBlockOff, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('lastModifiedBy: $lastModifiedBy, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    syncId,
    clientId,
    userId,
    clientName,
    startTime,
    durationMinutes,
    serviceType,
    serviceCategory,
    priceType,
    priceCharged,
    quotedPrice,
    finalPrice,
    notes,
    photoPath,
    color,
    status,
    isBlockOff,
    modifiedAt,
    lastModifiedBy,
    isDeleted,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Appointment &&
          other.id == this.id &&
          other.syncId == this.syncId &&
          other.clientId == this.clientId &&
          other.userId == this.userId &&
          other.clientName == this.clientName &&
          other.startTime == this.startTime &&
          other.durationMinutes == this.durationMinutes &&
          other.serviceType == this.serviceType &&
          other.serviceCategory == this.serviceCategory &&
          other.priceType == this.priceType &&
          other.priceCharged == this.priceCharged &&
          other.quotedPrice == this.quotedPrice &&
          other.finalPrice == this.finalPrice &&
          other.notes == this.notes &&
          other.photoPath == this.photoPath &&
          other.color == this.color &&
          other.status == this.status &&
          other.isBlockOff == this.isBlockOff &&
          other.modifiedAt == this.modifiedAt &&
          other.lastModifiedBy == this.lastModifiedBy &&
          other.isDeleted == this.isDeleted);
}

class AppointmentsCompanion extends UpdateCompanion<Appointment> {
  final Value<int> id;
  final Value<String> syncId;
  final Value<int> clientId;
  final Value<int> userId;
  final Value<String> clientName;
  final Value<DateTime> startTime;
  final Value<int> durationMinutes;
  final Value<String> serviceType;
  final Value<String> serviceCategory;
  final Value<String> priceType;
  final Value<double> priceCharged;
  final Value<double?> quotedPrice;
  final Value<double?> finalPrice;
  final Value<String?> notes;
  final Value<String?> photoPath;
  final Value<String> color;
  final Value<String> status;
  final Value<bool> isBlockOff;
  final Value<DateTime> modifiedAt;
  final Value<String> lastModifiedBy;
  final Value<bool> isDeleted;
  const AppointmentsCompanion({
    this.id = const Value.absent(),
    this.syncId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.userId = const Value.absent(),
    this.clientName = const Value.absent(),
    this.startTime = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.serviceType = const Value.absent(),
    this.serviceCategory = const Value.absent(),
    this.priceType = const Value.absent(),
    this.priceCharged = const Value.absent(),
    this.quotedPrice = const Value.absent(),
    this.finalPrice = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.color = const Value.absent(),
    this.status = const Value.absent(),
    this.isBlockOff = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.lastModifiedBy = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  AppointmentsCompanion.insert({
    this.id = const Value.absent(),
    required String syncId,
    required int clientId,
    required int userId,
    this.clientName = const Value.absent(),
    required DateTime startTime,
    required int durationMinutes,
    this.serviceType = const Value.absent(),
    this.serviceCategory = const Value.absent(),
    this.priceType = const Value.absent(),
    this.priceCharged = const Value.absent(),
    this.quotedPrice = const Value.absent(),
    this.finalPrice = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.color = const Value.absent(),
    this.status = const Value.absent(),
    this.isBlockOff = const Value.absent(),
    required DateTime modifiedAt,
    this.lastModifiedBy = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : syncId = Value(syncId),
       clientId = Value(clientId),
       userId = Value(userId),
       startTime = Value(startTime),
       durationMinutes = Value(durationMinutes),
       modifiedAt = Value(modifiedAt);
  static Insertable<Appointment> custom({
    Expression<int>? id,
    Expression<String>? syncId,
    Expression<int>? clientId,
    Expression<int>? userId,
    Expression<String>? clientName,
    Expression<DateTime>? startTime,
    Expression<int>? durationMinutes,
    Expression<String>? serviceType,
    Expression<String>? serviceCategory,
    Expression<String>? priceType,
    Expression<double>? priceCharged,
    Expression<double>? quotedPrice,
    Expression<double>? finalPrice,
    Expression<String>? notes,
    Expression<String>? photoPath,
    Expression<String>? color,
    Expression<String>? status,
    Expression<bool>? isBlockOff,
    Expression<DateTime>? modifiedAt,
    Expression<String>? lastModifiedBy,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncId != null) 'sync_id': syncId,
      if (clientId != null) 'client_id': clientId,
      if (userId != null) 'user_id': userId,
      if (clientName != null) 'client_name': clientName,
      if (startTime != null) 'start_time': startTime,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (serviceType != null) 'service_type': serviceType,
      if (serviceCategory != null) 'service_category': serviceCategory,
      if (priceType != null) 'price_type': priceType,
      if (priceCharged != null) 'price_charged': priceCharged,
      if (quotedPrice != null) 'quoted_price': quotedPrice,
      if (finalPrice != null) 'final_price': finalPrice,
      if (notes != null) 'notes': notes,
      if (photoPath != null) 'photo_path': photoPath,
      if (color != null) 'color': color,
      if (status != null) 'status': status,
      if (isBlockOff != null) 'is_block_off': isBlockOff,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (lastModifiedBy != null) 'last_modified_by': lastModifiedBy,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  AppointmentsCompanion copyWith({
    Value<int>? id,
    Value<String>? syncId,
    Value<int>? clientId,
    Value<int>? userId,
    Value<String>? clientName,
    Value<DateTime>? startTime,
    Value<int>? durationMinutes,
    Value<String>? serviceType,
    Value<String>? serviceCategory,
    Value<String>? priceType,
    Value<double>? priceCharged,
    Value<double?>? quotedPrice,
    Value<double?>? finalPrice,
    Value<String?>? notes,
    Value<String?>? photoPath,
    Value<String>? color,
    Value<String>? status,
    Value<bool>? isBlockOff,
    Value<DateTime>? modifiedAt,
    Value<String>? lastModifiedBy,
    Value<bool>? isDeleted,
  }) {
    return AppointmentsCompanion(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      clientId: clientId ?? this.clientId,
      userId: userId ?? this.userId,
      clientName: clientName ?? this.clientName,
      startTime: startTime ?? this.startTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      serviceType: serviceType ?? this.serviceType,
      serviceCategory: serviceCategory ?? this.serviceCategory,
      priceType: priceType ?? this.priceType,
      priceCharged: priceCharged ?? this.priceCharged,
      quotedPrice: quotedPrice ?? this.quotedPrice,
      finalPrice: finalPrice ?? this.finalPrice,
      notes: notes ?? this.notes,
      photoPath: photoPath ?? this.photoPath,
      color: color ?? this.color,
      status: status ?? this.status,
      isBlockOff: isBlockOff ?? this.isBlockOff,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (clientName.present) {
      map['client_name'] = Variable<String>(clientName.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (serviceType.present) {
      map['service_type'] = Variable<String>(serviceType.value);
    }
    if (serviceCategory.present) {
      map['service_category'] = Variable<String>(serviceCategory.value);
    }
    if (priceType.present) {
      map['price_type'] = Variable<String>(priceType.value);
    }
    if (priceCharged.present) {
      map['price_charged'] = Variable<double>(priceCharged.value);
    }
    if (quotedPrice.present) {
      map['quoted_price'] = Variable<double>(quotedPrice.value);
    }
    if (finalPrice.present) {
      map['final_price'] = Variable<double>(finalPrice.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (isBlockOff.present) {
      map['is_block_off'] = Variable<bool>(isBlockOff.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    if (lastModifiedBy.present) {
      map['last_modified_by'] = Variable<String>(lastModifiedBy.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppointmentsCompanion(')
          ..write('id: $id, ')
          ..write('syncId: $syncId, ')
          ..write('clientId: $clientId, ')
          ..write('userId: $userId, ')
          ..write('clientName: $clientName, ')
          ..write('startTime: $startTime, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('serviceType: $serviceType, ')
          ..write('serviceCategory: $serviceCategory, ')
          ..write('priceType: $priceType, ')
          ..write('priceCharged: $priceCharged, ')
          ..write('quotedPrice: $quotedPrice, ')
          ..write('finalPrice: $finalPrice, ')
          ..write('notes: $notes, ')
          ..write('photoPath: $photoPath, ')
          ..write('color: $color, ')
          ..write('status: $status, ')
          ..write('isBlockOff: $isBlockOff, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('lastModifiedBy: $lastModifiedBy, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $QuotesTable extends Quotes with TableInfo<$QuotesTable, Quote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
    'client_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artistIdMeta = const VerificationMeta(
    'artistId',
  );
  @override
  late final GeneratedColumn<int> artistId = GeneratedColumn<int>(
    'artist_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _placementMeta = const VerificationMeta(
    'placement',
  );
  @override
  late final GeneratedColumn<String> placement = GeneratedColumn<String>(
    'placement',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _styleMeta = const VerificationMeta('style');
  @override
  late final GeneratedColumn<String> style = GeneratedColumn<String>(
    'style',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isCoverUpMeta = const VerificationMeta(
    'isCoverUp',
  );
  @override
  late final GeneratedColumn<bool> isCoverUp = GeneratedColumn<bool>(
    'is_cover_up',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_cover_up" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<double> width = GeneratedColumn<double>(
    'width',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
    'height',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _coverageLevelMeta = const VerificationMeta(
    'coverageLevel',
  );
  @override
  late final GeneratedColumn<int> coverageLevel = GeneratedColumn<int>(
    'coverage_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _lineComplexityMeta = const VerificationMeta(
    'lineComplexity',
  );
  @override
  late final GeneratedColumn<int> lineComplexity = GeneratedColumn<int>(
    'line_complexity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _shadingComplexityMeta = const VerificationMeta(
    'shadingComplexity',
  );
  @override
  late final GeneratedColumn<int> shadingComplexity = GeneratedColumn<int>(
    'shading_complexity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _colorComplexityMeta = const VerificationMeta(
    'colorComplexity',
  );
  @override
  late final GeneratedColumn<int> colorComplexity = GeneratedColumn<int>(
    'color_complexity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<int> difficulty = GeneratedColumn<int>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _estimatedHoursLowMeta = const VerificationMeta(
    'estimatedHoursLow',
  );
  @override
  late final GeneratedColumn<double> estimatedHoursLow =
      GeneratedColumn<double>(
        'estimated_hours_low',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _estimatedHoursHighMeta =
      const VerificationMeta('estimatedHoursHigh');
  @override
  late final GeneratedColumn<double> estimatedHoursHigh =
      GeneratedColumn<double>(
        'estimated_hours_high',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _priceLowMeta = const VerificationMeta(
    'priceLow',
  );
  @override
  late final GeneratedColumn<double> priceLow = GeneratedColumn<double>(
    'price_low',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _priceHighMeta = const VerificationMeta(
    'priceHigh',
  );
  @override
  late final GeneratedColumn<double> priceHigh = GeneratedColumn<double>(
    'price_high',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _shopMinimumMeta = const VerificationMeta(
    'shopMinimum',
  );
  @override
  late final GeneratedColumn<double> shopMinimum = GeneratedColumn<double>(
    'shop_minimum',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _recommendedDepositMeta =
      const VerificationMeta('recommendedDeposit');
  @override
  late final GeneratedColumn<double> recommendedDeposit =
      GeneratedColumn<double>(
        'recommended_deposit',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _confidenceScoreMeta = const VerificationMeta(
    'confidenceScore',
  );
  @override
  late final GeneratedColumn<double> confidenceScore = GeneratedColumn<double>(
    'confidence_score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _similarJobsCountMeta = const VerificationMeta(
    'similarJobsCount',
  );
  @override
  late final GeneratedColumn<int> similarJobsCount = GeneratedColumn<int>(
    'similar_jobs_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    artistId,
    placement,
    style,
    isCoverUp,
    width,
    height,
    coverageLevel,
    lineComplexity,
    shadingComplexity,
    colorComplexity,
    difficulty,
    estimatedHoursLow,
    estimatedHoursHigh,
    priceLow,
    priceHigh,
    shopMinimum,
    recommendedDeposit,
    confidenceScore,
    similarJobsCount,
    notes,
    photoPath,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quotes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Quote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    }
    if (data.containsKey('artist_id')) {
      context.handle(
        _artistIdMeta,
        artistId.isAcceptableOrUnknown(data['artist_id']!, _artistIdMeta),
      );
    } else if (isInserting) {
      context.missing(_artistIdMeta);
    }
    if (data.containsKey('placement')) {
      context.handle(
        _placementMeta,
        placement.isAcceptableOrUnknown(data['placement']!, _placementMeta),
      );
    }
    if (data.containsKey('style')) {
      context.handle(
        _styleMeta,
        style.isAcceptableOrUnknown(data['style']!, _styleMeta),
      );
    }
    if (data.containsKey('is_cover_up')) {
      context.handle(
        _isCoverUpMeta,
        isCoverUp.isAcceptableOrUnknown(data['is_cover_up']!, _isCoverUpMeta),
      );
    }
    if (data.containsKey('width')) {
      context.handle(
        _widthMeta,
        width.isAcceptableOrUnknown(data['width']!, _widthMeta),
      );
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('coverage_level')) {
      context.handle(
        _coverageLevelMeta,
        coverageLevel.isAcceptableOrUnknown(
          data['coverage_level']!,
          _coverageLevelMeta,
        ),
      );
    }
    if (data.containsKey('line_complexity')) {
      context.handle(
        _lineComplexityMeta,
        lineComplexity.isAcceptableOrUnknown(
          data['line_complexity']!,
          _lineComplexityMeta,
        ),
      );
    }
    if (data.containsKey('shading_complexity')) {
      context.handle(
        _shadingComplexityMeta,
        shadingComplexity.isAcceptableOrUnknown(
          data['shading_complexity']!,
          _shadingComplexityMeta,
        ),
      );
    }
    if (data.containsKey('color_complexity')) {
      context.handle(
        _colorComplexityMeta,
        colorComplexity.isAcceptableOrUnknown(
          data['color_complexity']!,
          _colorComplexityMeta,
        ),
      );
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    }
    if (data.containsKey('estimated_hours_low')) {
      context.handle(
        _estimatedHoursLowMeta,
        estimatedHoursLow.isAcceptableOrUnknown(
          data['estimated_hours_low']!,
          _estimatedHoursLowMeta,
        ),
      );
    }
    if (data.containsKey('estimated_hours_high')) {
      context.handle(
        _estimatedHoursHighMeta,
        estimatedHoursHigh.isAcceptableOrUnknown(
          data['estimated_hours_high']!,
          _estimatedHoursHighMeta,
        ),
      );
    }
    if (data.containsKey('price_low')) {
      context.handle(
        _priceLowMeta,
        priceLow.isAcceptableOrUnknown(data['price_low']!, _priceLowMeta),
      );
    }
    if (data.containsKey('price_high')) {
      context.handle(
        _priceHighMeta,
        priceHigh.isAcceptableOrUnknown(data['price_high']!, _priceHighMeta),
      );
    }
    if (data.containsKey('shop_minimum')) {
      context.handle(
        _shopMinimumMeta,
        shopMinimum.isAcceptableOrUnknown(
          data['shop_minimum']!,
          _shopMinimumMeta,
        ),
      );
    }
    if (data.containsKey('recommended_deposit')) {
      context.handle(
        _recommendedDepositMeta,
        recommendedDeposit.isAcceptableOrUnknown(
          data['recommended_deposit']!,
          _recommendedDepositMeta,
        ),
      );
    }
    if (data.containsKey('confidence_score')) {
      context.handle(
        _confidenceScoreMeta,
        confidenceScore.isAcceptableOrUnknown(
          data['confidence_score']!,
          _confidenceScoreMeta,
        ),
      );
    }
    if (data.containsKey('similar_jobs_count')) {
      context.handle(
        _similarJobsCountMeta,
        similarJobsCount.isAcceptableOrUnknown(
          data['similar_jobs_count']!,
          _similarJobsCountMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Quote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Quote(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      ),
      artistId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}artist_id'],
      )!,
      placement: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}placement'],
      )!,
      style: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}style'],
      )!,
      isCoverUp: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_cover_up'],
      )!,
      width: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}width'],
      )!,
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height'],
      )!,
      coverageLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}coverage_level'],
      )!,
      lineComplexity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_complexity'],
      )!,
      shadingComplexity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}shading_complexity'],
      )!,
      colorComplexity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_complexity'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}difficulty'],
      )!,
      estimatedHoursLow: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}estimated_hours_low'],
      )!,
      estimatedHoursHigh: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}estimated_hours_high'],
      )!,
      priceLow: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_low'],
      )!,
      priceHigh: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_high'],
      )!,
      shopMinimum: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}shop_minimum'],
      )!,
      recommendedDeposit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}recommended_deposit'],
      )!,
      confidenceScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence_score'],
      )!,
      similarJobsCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}similar_jobs_count'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $QuotesTable createAlias(String alias) {
    return $QuotesTable(attachedDatabase, alias);
  }
}

class Quote extends DataClass implements Insertable<Quote> {
  /// Primary key
  final int id;

  /// Optional foreign key to Client
  final int? clientId;

  /// Foreign key to User (Artist who created the quote)
  final int artistId;

  /// Body placement location
  final String placement;

  /// Art style (Traditional, Realism, etc.)
  final String style;

  /// Whether this is a cover-up
  final bool isCoverUp;

  /// Width dimension
  final double width;

  /// Height dimension
  final double height;

  /// Coverage level (1-5 scale)
  final int coverageLevel;

  /// Line work complexity (1-5 scale)
  final int lineComplexity;

  /// Shading complexity (1-5 scale)
  final int shadingComplexity;

  /// Color work complexity (1-5 scale)
  final int colorComplexity;

  /// Overall difficulty (1-5 scale)
  final int difficulty;

  /// Estimated hours - low end
  final double estimatedHoursLow;

  /// Estimated hours - high end
  final double estimatedHoursHigh;

  /// Price estimate - low end
  final double priceLow;

  /// Price estimate - high end
  final double priceHigh;

  /// Shop minimum rate applied
  final double shopMinimum;

  /// Recommended deposit amount
  final double recommendedDeposit;

  /// Confidence score (0-1)
  final double confidenceScore;

  /// Number of similar past jobs
  final int similarJobsCount;

  /// Free-form notes
  final String? notes;

  /// Path to reference photo
  final String? photoPath;

  /// Quote creation timestamp
  final DateTime createdAt;
  const Quote({
    required this.id,
    this.clientId,
    required this.artistId,
    required this.placement,
    required this.style,
    required this.isCoverUp,
    required this.width,
    required this.height,
    required this.coverageLevel,
    required this.lineComplexity,
    required this.shadingComplexity,
    required this.colorComplexity,
    required this.difficulty,
    required this.estimatedHoursLow,
    required this.estimatedHoursHigh,
    required this.priceLow,
    required this.priceHigh,
    required this.shopMinimum,
    required this.recommendedDeposit,
    required this.confidenceScore,
    required this.similarJobsCount,
    this.notes,
    this.photoPath,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || clientId != null) {
      map['client_id'] = Variable<int>(clientId);
    }
    map['artist_id'] = Variable<int>(artistId);
    map['placement'] = Variable<String>(placement);
    map['style'] = Variable<String>(style);
    map['is_cover_up'] = Variable<bool>(isCoverUp);
    map['width'] = Variable<double>(width);
    map['height'] = Variable<double>(height);
    map['coverage_level'] = Variable<int>(coverageLevel);
    map['line_complexity'] = Variable<int>(lineComplexity);
    map['shading_complexity'] = Variable<int>(shadingComplexity);
    map['color_complexity'] = Variable<int>(colorComplexity);
    map['difficulty'] = Variable<int>(difficulty);
    map['estimated_hours_low'] = Variable<double>(estimatedHoursLow);
    map['estimated_hours_high'] = Variable<double>(estimatedHoursHigh);
    map['price_low'] = Variable<double>(priceLow);
    map['price_high'] = Variable<double>(priceHigh);
    map['shop_minimum'] = Variable<double>(shopMinimum);
    map['recommended_deposit'] = Variable<double>(recommendedDeposit);
    map['confidence_score'] = Variable<double>(confidenceScore);
    map['similar_jobs_count'] = Variable<int>(similarJobsCount);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  QuotesCompanion toCompanion(bool nullToAbsent) {
    return QuotesCompanion(
      id: Value(id),
      clientId: clientId == null && nullToAbsent
          ? const Value.absent()
          : Value(clientId),
      artistId: Value(artistId),
      placement: Value(placement),
      style: Value(style),
      isCoverUp: Value(isCoverUp),
      width: Value(width),
      height: Value(height),
      coverageLevel: Value(coverageLevel),
      lineComplexity: Value(lineComplexity),
      shadingComplexity: Value(shadingComplexity),
      colorComplexity: Value(colorComplexity),
      difficulty: Value(difficulty),
      estimatedHoursLow: Value(estimatedHoursLow),
      estimatedHoursHigh: Value(estimatedHoursHigh),
      priceLow: Value(priceLow),
      priceHigh: Value(priceHigh),
      shopMinimum: Value(shopMinimum),
      recommendedDeposit: Value(recommendedDeposit),
      confidenceScore: Value(confidenceScore),
      similarJobsCount: Value(similarJobsCount),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      createdAt: Value(createdAt),
    );
  }

  factory Quote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Quote(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<int?>(json['clientId']),
      artistId: serializer.fromJson<int>(json['artistId']),
      placement: serializer.fromJson<String>(json['placement']),
      style: serializer.fromJson<String>(json['style']),
      isCoverUp: serializer.fromJson<bool>(json['isCoverUp']),
      width: serializer.fromJson<double>(json['width']),
      height: serializer.fromJson<double>(json['height']),
      coverageLevel: serializer.fromJson<int>(json['coverageLevel']),
      lineComplexity: serializer.fromJson<int>(json['lineComplexity']),
      shadingComplexity: serializer.fromJson<int>(json['shadingComplexity']),
      colorComplexity: serializer.fromJson<int>(json['colorComplexity']),
      difficulty: serializer.fromJson<int>(json['difficulty']),
      estimatedHoursLow: serializer.fromJson<double>(json['estimatedHoursLow']),
      estimatedHoursHigh: serializer.fromJson<double>(
        json['estimatedHoursHigh'],
      ),
      priceLow: serializer.fromJson<double>(json['priceLow']),
      priceHigh: serializer.fromJson<double>(json['priceHigh']),
      shopMinimum: serializer.fromJson<double>(json['shopMinimum']),
      recommendedDeposit: serializer.fromJson<double>(
        json['recommendedDeposit'],
      ),
      confidenceScore: serializer.fromJson<double>(json['confidenceScore']),
      similarJobsCount: serializer.fromJson<int>(json['similarJobsCount']),
      notes: serializer.fromJson<String?>(json['notes']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<int?>(clientId),
      'artistId': serializer.toJson<int>(artistId),
      'placement': serializer.toJson<String>(placement),
      'style': serializer.toJson<String>(style),
      'isCoverUp': serializer.toJson<bool>(isCoverUp),
      'width': serializer.toJson<double>(width),
      'height': serializer.toJson<double>(height),
      'coverageLevel': serializer.toJson<int>(coverageLevel),
      'lineComplexity': serializer.toJson<int>(lineComplexity),
      'shadingComplexity': serializer.toJson<int>(shadingComplexity),
      'colorComplexity': serializer.toJson<int>(colorComplexity),
      'difficulty': serializer.toJson<int>(difficulty),
      'estimatedHoursLow': serializer.toJson<double>(estimatedHoursLow),
      'estimatedHoursHigh': serializer.toJson<double>(estimatedHoursHigh),
      'priceLow': serializer.toJson<double>(priceLow),
      'priceHigh': serializer.toJson<double>(priceHigh),
      'shopMinimum': serializer.toJson<double>(shopMinimum),
      'recommendedDeposit': serializer.toJson<double>(recommendedDeposit),
      'confidenceScore': serializer.toJson<double>(confidenceScore),
      'similarJobsCount': serializer.toJson<int>(similarJobsCount),
      'notes': serializer.toJson<String?>(notes),
      'photoPath': serializer.toJson<String?>(photoPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Quote copyWith({
    int? id,
    Value<int?> clientId = const Value.absent(),
    int? artistId,
    String? placement,
    String? style,
    bool? isCoverUp,
    double? width,
    double? height,
    int? coverageLevel,
    int? lineComplexity,
    int? shadingComplexity,
    int? colorComplexity,
    int? difficulty,
    double? estimatedHoursLow,
    double? estimatedHoursHigh,
    double? priceLow,
    double? priceHigh,
    double? shopMinimum,
    double? recommendedDeposit,
    double? confidenceScore,
    int? similarJobsCount,
    Value<String?> notes = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
    DateTime? createdAt,
  }) => Quote(
    id: id ?? this.id,
    clientId: clientId.present ? clientId.value : this.clientId,
    artistId: artistId ?? this.artistId,
    placement: placement ?? this.placement,
    style: style ?? this.style,
    isCoverUp: isCoverUp ?? this.isCoverUp,
    width: width ?? this.width,
    height: height ?? this.height,
    coverageLevel: coverageLevel ?? this.coverageLevel,
    lineComplexity: lineComplexity ?? this.lineComplexity,
    shadingComplexity: shadingComplexity ?? this.shadingComplexity,
    colorComplexity: colorComplexity ?? this.colorComplexity,
    difficulty: difficulty ?? this.difficulty,
    estimatedHoursLow: estimatedHoursLow ?? this.estimatedHoursLow,
    estimatedHoursHigh: estimatedHoursHigh ?? this.estimatedHoursHigh,
    priceLow: priceLow ?? this.priceLow,
    priceHigh: priceHigh ?? this.priceHigh,
    shopMinimum: shopMinimum ?? this.shopMinimum,
    recommendedDeposit: recommendedDeposit ?? this.recommendedDeposit,
    confidenceScore: confidenceScore ?? this.confidenceScore,
    similarJobsCount: similarJobsCount ?? this.similarJobsCount,
    notes: notes.present ? notes.value : this.notes,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    createdAt: createdAt ?? this.createdAt,
  );
  Quote copyWithCompanion(QuotesCompanion data) {
    return Quote(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      artistId: data.artistId.present ? data.artistId.value : this.artistId,
      placement: data.placement.present ? data.placement.value : this.placement,
      style: data.style.present ? data.style.value : this.style,
      isCoverUp: data.isCoverUp.present ? data.isCoverUp.value : this.isCoverUp,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      coverageLevel: data.coverageLevel.present
          ? data.coverageLevel.value
          : this.coverageLevel,
      lineComplexity: data.lineComplexity.present
          ? data.lineComplexity.value
          : this.lineComplexity,
      shadingComplexity: data.shadingComplexity.present
          ? data.shadingComplexity.value
          : this.shadingComplexity,
      colorComplexity: data.colorComplexity.present
          ? data.colorComplexity.value
          : this.colorComplexity,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      estimatedHoursLow: data.estimatedHoursLow.present
          ? data.estimatedHoursLow.value
          : this.estimatedHoursLow,
      estimatedHoursHigh: data.estimatedHoursHigh.present
          ? data.estimatedHoursHigh.value
          : this.estimatedHoursHigh,
      priceLow: data.priceLow.present ? data.priceLow.value : this.priceLow,
      priceHigh: data.priceHigh.present ? data.priceHigh.value : this.priceHigh,
      shopMinimum: data.shopMinimum.present
          ? data.shopMinimum.value
          : this.shopMinimum,
      recommendedDeposit: data.recommendedDeposit.present
          ? data.recommendedDeposit.value
          : this.recommendedDeposit,
      confidenceScore: data.confidenceScore.present
          ? data.confidenceScore.value
          : this.confidenceScore,
      similarJobsCount: data.similarJobsCount.present
          ? data.similarJobsCount.value
          : this.similarJobsCount,
      notes: data.notes.present ? data.notes.value : this.notes,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Quote(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('artistId: $artistId, ')
          ..write('placement: $placement, ')
          ..write('style: $style, ')
          ..write('isCoverUp: $isCoverUp, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('coverageLevel: $coverageLevel, ')
          ..write('lineComplexity: $lineComplexity, ')
          ..write('shadingComplexity: $shadingComplexity, ')
          ..write('colorComplexity: $colorComplexity, ')
          ..write('difficulty: $difficulty, ')
          ..write('estimatedHoursLow: $estimatedHoursLow, ')
          ..write('estimatedHoursHigh: $estimatedHoursHigh, ')
          ..write('priceLow: $priceLow, ')
          ..write('priceHigh: $priceHigh, ')
          ..write('shopMinimum: $shopMinimum, ')
          ..write('recommendedDeposit: $recommendedDeposit, ')
          ..write('confidenceScore: $confidenceScore, ')
          ..write('similarJobsCount: $similarJobsCount, ')
          ..write('notes: $notes, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    clientId,
    artistId,
    placement,
    style,
    isCoverUp,
    width,
    height,
    coverageLevel,
    lineComplexity,
    shadingComplexity,
    colorComplexity,
    difficulty,
    estimatedHoursLow,
    estimatedHoursHigh,
    priceLow,
    priceHigh,
    shopMinimum,
    recommendedDeposit,
    confidenceScore,
    similarJobsCount,
    notes,
    photoPath,
    createdAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Quote &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.artistId == this.artistId &&
          other.placement == this.placement &&
          other.style == this.style &&
          other.isCoverUp == this.isCoverUp &&
          other.width == this.width &&
          other.height == this.height &&
          other.coverageLevel == this.coverageLevel &&
          other.lineComplexity == this.lineComplexity &&
          other.shadingComplexity == this.shadingComplexity &&
          other.colorComplexity == this.colorComplexity &&
          other.difficulty == this.difficulty &&
          other.estimatedHoursLow == this.estimatedHoursLow &&
          other.estimatedHoursHigh == this.estimatedHoursHigh &&
          other.priceLow == this.priceLow &&
          other.priceHigh == this.priceHigh &&
          other.shopMinimum == this.shopMinimum &&
          other.recommendedDeposit == this.recommendedDeposit &&
          other.confidenceScore == this.confidenceScore &&
          other.similarJobsCount == this.similarJobsCount &&
          other.notes == this.notes &&
          other.photoPath == this.photoPath &&
          other.createdAt == this.createdAt);
}

class QuotesCompanion extends UpdateCompanion<Quote> {
  final Value<int> id;
  final Value<int?> clientId;
  final Value<int> artistId;
  final Value<String> placement;
  final Value<String> style;
  final Value<bool> isCoverUp;
  final Value<double> width;
  final Value<double> height;
  final Value<int> coverageLevel;
  final Value<int> lineComplexity;
  final Value<int> shadingComplexity;
  final Value<int> colorComplexity;
  final Value<int> difficulty;
  final Value<double> estimatedHoursLow;
  final Value<double> estimatedHoursHigh;
  final Value<double> priceLow;
  final Value<double> priceHigh;
  final Value<double> shopMinimum;
  final Value<double> recommendedDeposit;
  final Value<double> confidenceScore;
  final Value<int> similarJobsCount;
  final Value<String?> notes;
  final Value<String?> photoPath;
  final Value<DateTime> createdAt;
  const QuotesCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.artistId = const Value.absent(),
    this.placement = const Value.absent(),
    this.style = const Value.absent(),
    this.isCoverUp = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.coverageLevel = const Value.absent(),
    this.lineComplexity = const Value.absent(),
    this.shadingComplexity = const Value.absent(),
    this.colorComplexity = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.estimatedHoursLow = const Value.absent(),
    this.estimatedHoursHigh = const Value.absent(),
    this.priceLow = const Value.absent(),
    this.priceHigh = const Value.absent(),
    this.shopMinimum = const Value.absent(),
    this.recommendedDeposit = const Value.absent(),
    this.confidenceScore = const Value.absent(),
    this.similarJobsCount = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  QuotesCompanion.insert({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    required int artistId,
    this.placement = const Value.absent(),
    this.style = const Value.absent(),
    this.isCoverUp = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.coverageLevel = const Value.absent(),
    this.lineComplexity = const Value.absent(),
    this.shadingComplexity = const Value.absent(),
    this.colorComplexity = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.estimatedHoursLow = const Value.absent(),
    this.estimatedHoursHigh = const Value.absent(),
    this.priceLow = const Value.absent(),
    this.priceHigh = const Value.absent(),
    this.shopMinimum = const Value.absent(),
    this.recommendedDeposit = const Value.absent(),
    this.confidenceScore = const Value.absent(),
    this.similarJobsCount = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoPath = const Value.absent(),
    required DateTime createdAt,
  }) : artistId = Value(artistId),
       createdAt = Value(createdAt);
  static Insertable<Quote> custom({
    Expression<int>? id,
    Expression<int>? clientId,
    Expression<int>? artistId,
    Expression<String>? placement,
    Expression<String>? style,
    Expression<bool>? isCoverUp,
    Expression<double>? width,
    Expression<double>? height,
    Expression<int>? coverageLevel,
    Expression<int>? lineComplexity,
    Expression<int>? shadingComplexity,
    Expression<int>? colorComplexity,
    Expression<int>? difficulty,
    Expression<double>? estimatedHoursLow,
    Expression<double>? estimatedHoursHigh,
    Expression<double>? priceLow,
    Expression<double>? priceHigh,
    Expression<double>? shopMinimum,
    Expression<double>? recommendedDeposit,
    Expression<double>? confidenceScore,
    Expression<int>? similarJobsCount,
    Expression<String>? notes,
    Expression<String>? photoPath,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (artistId != null) 'artist_id': artistId,
      if (placement != null) 'placement': placement,
      if (style != null) 'style': style,
      if (isCoverUp != null) 'is_cover_up': isCoverUp,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (coverageLevel != null) 'coverage_level': coverageLevel,
      if (lineComplexity != null) 'line_complexity': lineComplexity,
      if (shadingComplexity != null) 'shading_complexity': shadingComplexity,
      if (colorComplexity != null) 'color_complexity': colorComplexity,
      if (difficulty != null) 'difficulty': difficulty,
      if (estimatedHoursLow != null) 'estimated_hours_low': estimatedHoursLow,
      if (estimatedHoursHigh != null)
        'estimated_hours_high': estimatedHoursHigh,
      if (priceLow != null) 'price_low': priceLow,
      if (priceHigh != null) 'price_high': priceHigh,
      if (shopMinimum != null) 'shop_minimum': shopMinimum,
      if (recommendedDeposit != null) 'recommended_deposit': recommendedDeposit,
      if (confidenceScore != null) 'confidence_score': confidenceScore,
      if (similarJobsCount != null) 'similar_jobs_count': similarJobsCount,
      if (notes != null) 'notes': notes,
      if (photoPath != null) 'photo_path': photoPath,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  QuotesCompanion copyWith({
    Value<int>? id,
    Value<int?>? clientId,
    Value<int>? artistId,
    Value<String>? placement,
    Value<String>? style,
    Value<bool>? isCoverUp,
    Value<double>? width,
    Value<double>? height,
    Value<int>? coverageLevel,
    Value<int>? lineComplexity,
    Value<int>? shadingComplexity,
    Value<int>? colorComplexity,
    Value<int>? difficulty,
    Value<double>? estimatedHoursLow,
    Value<double>? estimatedHoursHigh,
    Value<double>? priceLow,
    Value<double>? priceHigh,
    Value<double>? shopMinimum,
    Value<double>? recommendedDeposit,
    Value<double>? confidenceScore,
    Value<int>? similarJobsCount,
    Value<String?>? notes,
    Value<String?>? photoPath,
    Value<DateTime>? createdAt,
  }) {
    return QuotesCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      artistId: artistId ?? this.artistId,
      placement: placement ?? this.placement,
      style: style ?? this.style,
      isCoverUp: isCoverUp ?? this.isCoverUp,
      width: width ?? this.width,
      height: height ?? this.height,
      coverageLevel: coverageLevel ?? this.coverageLevel,
      lineComplexity: lineComplexity ?? this.lineComplexity,
      shadingComplexity: shadingComplexity ?? this.shadingComplexity,
      colorComplexity: colorComplexity ?? this.colorComplexity,
      difficulty: difficulty ?? this.difficulty,
      estimatedHoursLow: estimatedHoursLow ?? this.estimatedHoursLow,
      estimatedHoursHigh: estimatedHoursHigh ?? this.estimatedHoursHigh,
      priceLow: priceLow ?? this.priceLow,
      priceHigh: priceHigh ?? this.priceHigh,
      shopMinimum: shopMinimum ?? this.shopMinimum,
      recommendedDeposit: recommendedDeposit ?? this.recommendedDeposit,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      similarJobsCount: similarJobsCount ?? this.similarJobsCount,
      notes: notes ?? this.notes,
      photoPath: photoPath ?? this.photoPath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (artistId.present) {
      map['artist_id'] = Variable<int>(artistId.value);
    }
    if (placement.present) {
      map['placement'] = Variable<String>(placement.value);
    }
    if (style.present) {
      map['style'] = Variable<String>(style.value);
    }
    if (isCoverUp.present) {
      map['is_cover_up'] = Variable<bool>(isCoverUp.value);
    }
    if (width.present) {
      map['width'] = Variable<double>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (coverageLevel.present) {
      map['coverage_level'] = Variable<int>(coverageLevel.value);
    }
    if (lineComplexity.present) {
      map['line_complexity'] = Variable<int>(lineComplexity.value);
    }
    if (shadingComplexity.present) {
      map['shading_complexity'] = Variable<int>(shadingComplexity.value);
    }
    if (colorComplexity.present) {
      map['color_complexity'] = Variable<int>(colorComplexity.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<int>(difficulty.value);
    }
    if (estimatedHoursLow.present) {
      map['estimated_hours_low'] = Variable<double>(estimatedHoursLow.value);
    }
    if (estimatedHoursHigh.present) {
      map['estimated_hours_high'] = Variable<double>(estimatedHoursHigh.value);
    }
    if (priceLow.present) {
      map['price_low'] = Variable<double>(priceLow.value);
    }
    if (priceHigh.present) {
      map['price_high'] = Variable<double>(priceHigh.value);
    }
    if (shopMinimum.present) {
      map['shop_minimum'] = Variable<double>(shopMinimum.value);
    }
    if (recommendedDeposit.present) {
      map['recommended_deposit'] = Variable<double>(recommendedDeposit.value);
    }
    if (confidenceScore.present) {
      map['confidence_score'] = Variable<double>(confidenceScore.value);
    }
    if (similarJobsCount.present) {
      map['similar_jobs_count'] = Variable<int>(similarJobsCount.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuotesCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('artistId: $artistId, ')
          ..write('placement: $placement, ')
          ..write('style: $style, ')
          ..write('isCoverUp: $isCoverUp, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('coverageLevel: $coverageLevel, ')
          ..write('lineComplexity: $lineComplexity, ')
          ..write('shadingComplexity: $shadingComplexity, ')
          ..write('colorComplexity: $colorComplexity, ')
          ..write('difficulty: $difficulty, ')
          ..write('estimatedHoursLow: $estimatedHoursLow, ')
          ..write('estimatedHoursHigh: $estimatedHoursHigh, ')
          ..write('priceLow: $priceLow, ')
          ..write('priceHigh: $priceHigh, ')
          ..write('shopMinimum: $shopMinimum, ')
          ..write('recommendedDeposit: $recommendedDeposit, ')
          ..write('confidenceScore: $confidenceScore, ')
          ..write('similarJobsCount: $similarJobsCount, ')
          ..write('notes: $notes, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, Document> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
    'sync_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uploadedByUserIdMeta = const VerificationMeta(
    'uploadedByUserId',
  );
  @override
  late final GeneratedColumn<int> uploadedByUserId = GeneratedColumn<int>(
    'uploaded_by_user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastModifiedUtcMeta = const VerificationMeta(
    'lastModifiedUtc',
  );
  @override
  late final GeneratedColumn<DateTime> lastModifiedUtc =
      GeneratedColumn<DateTime>(
        'last_modified_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _lastModifiedByMeta = const VerificationMeta(
    'lastModifiedBy',
  );
  @override
  late final GeneratedColumn<String> lastModifiedBy = GeneratedColumn<String>(
    'last_modified_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    syncId,
    uploadedByUserId,
    clientId,
    title,
    filePath,
    createdAt,
    lastModifiedUtc,
    lastModifiedBy,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<Document> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sync_id')) {
      context.handle(
        _syncIdMeta,
        syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta),
      );
    } else if (isInserting) {
      context.missing(_syncIdMeta);
    }
    if (data.containsKey('uploaded_by_user_id')) {
      context.handle(
        _uploadedByUserIdMeta,
        uploadedByUserId.isAcceptableOrUnknown(
          data['uploaded_by_user_id']!,
          _uploadedByUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_uploadedByUserIdMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_modified_utc')) {
      context.handle(
        _lastModifiedUtcMeta,
        lastModifiedUtc.isAcceptableOrUnknown(
          data['last_modified_utc']!,
          _lastModifiedUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastModifiedUtcMeta);
    }
    if (data.containsKey('last_modified_by')) {
      context.handle(
        _lastModifiedByMeta,
        lastModifiedBy.isAcceptableOrUnknown(
          data['last_modified_by']!,
          _lastModifiedByMeta,
        ),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Document map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Document(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      syncId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_id'],
      )!,
      uploadedByUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}uploaded_by_user_id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastModifiedUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_modified_utc'],
      )!,
      lastModifiedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_modified_by'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }
}

class Document extends DataClass implements Insertable<Document> {
  /// Primary key
  final int id;

  /// Sync identifier for multi-device sync
  final String syncId;

  /// Foreign key to User who uploaded
  final int uploadedByUserId;

  /// Foreign key to Client
  final int clientId;

  /// Document title/name
  final String title;

  /// File storage path
  final String filePath;

  /// Upload timestamp
  final DateTime createdAt;

  /// Last modification timestamp (UTC)
  final DateTime lastModifiedUtc;

  /// User who last modified this record
  final String lastModifiedBy;

  /// Soft delete flag
  final bool isDeleted;
  const Document({
    required this.id,
    required this.syncId,
    required this.uploadedByUserId,
    required this.clientId,
    required this.title,
    required this.filePath,
    required this.createdAt,
    required this.lastModifiedUtc,
    required this.lastModifiedBy,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_id'] = Variable<String>(syncId);
    map['uploaded_by_user_id'] = Variable<int>(uploadedByUserId);
    map['client_id'] = Variable<int>(clientId);
    map['title'] = Variable<String>(title);
    map['file_path'] = Variable<String>(filePath);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['last_modified_utc'] = Variable<DateTime>(lastModifiedUtc);
    map['last_modified_by'] = Variable<String>(lastModifiedBy);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      syncId: Value(syncId),
      uploadedByUserId: Value(uploadedByUserId),
      clientId: Value(clientId),
      title: Value(title),
      filePath: Value(filePath),
      createdAt: Value(createdAt),
      lastModifiedUtc: Value(lastModifiedUtc),
      lastModifiedBy: Value(lastModifiedBy),
      isDeleted: Value(isDeleted),
    );
  }

  factory Document.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Document(
      id: serializer.fromJson<int>(json['id']),
      syncId: serializer.fromJson<String>(json['syncId']),
      uploadedByUserId: serializer.fromJson<int>(json['uploadedByUserId']),
      clientId: serializer.fromJson<int>(json['clientId']),
      title: serializer.fromJson<String>(json['title']),
      filePath: serializer.fromJson<String>(json['filePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastModifiedUtc: serializer.fromJson<DateTime>(json['lastModifiedUtc']),
      lastModifiedBy: serializer.fromJson<String>(json['lastModifiedBy']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syncId': serializer.toJson<String>(syncId),
      'uploadedByUserId': serializer.toJson<int>(uploadedByUserId),
      'clientId': serializer.toJson<int>(clientId),
      'title': serializer.toJson<String>(title),
      'filePath': serializer.toJson<String>(filePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastModifiedUtc': serializer.toJson<DateTime>(lastModifiedUtc),
      'lastModifiedBy': serializer.toJson<String>(lastModifiedBy),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  Document copyWith({
    int? id,
    String? syncId,
    int? uploadedByUserId,
    int? clientId,
    String? title,
    String? filePath,
    DateTime? createdAt,
    DateTime? lastModifiedUtc,
    String? lastModifiedBy,
    bool? isDeleted,
  }) => Document(
    id: id ?? this.id,
    syncId: syncId ?? this.syncId,
    uploadedByUserId: uploadedByUserId ?? this.uploadedByUserId,
    clientId: clientId ?? this.clientId,
    title: title ?? this.title,
    filePath: filePath ?? this.filePath,
    createdAt: createdAt ?? this.createdAt,
    lastModifiedUtc: lastModifiedUtc ?? this.lastModifiedUtc,
    lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Document copyWithCompanion(DocumentsCompanion data) {
    return Document(
      id: data.id.present ? data.id.value : this.id,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      uploadedByUserId: data.uploadedByUserId.present
          ? data.uploadedByUserId.value
          : this.uploadedByUserId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      title: data.title.present ? data.title.value : this.title,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastModifiedUtc: data.lastModifiedUtc.present
          ? data.lastModifiedUtc.value
          : this.lastModifiedUtc,
      lastModifiedBy: data.lastModifiedBy.present
          ? data.lastModifiedBy.value
          : this.lastModifiedBy,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Document(')
          ..write('id: $id, ')
          ..write('syncId: $syncId, ')
          ..write('uploadedByUserId: $uploadedByUserId, ')
          ..write('clientId: $clientId, ')
          ..write('title: $title, ')
          ..write('filePath: $filePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastModifiedUtc: $lastModifiedUtc, ')
          ..write('lastModifiedBy: $lastModifiedBy, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    syncId,
    uploadedByUserId,
    clientId,
    title,
    filePath,
    createdAt,
    lastModifiedUtc,
    lastModifiedBy,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Document &&
          other.id == this.id &&
          other.syncId == this.syncId &&
          other.uploadedByUserId == this.uploadedByUserId &&
          other.clientId == this.clientId &&
          other.title == this.title &&
          other.filePath == this.filePath &&
          other.createdAt == this.createdAt &&
          other.lastModifiedUtc == this.lastModifiedUtc &&
          other.lastModifiedBy == this.lastModifiedBy &&
          other.isDeleted == this.isDeleted);
}

class DocumentsCompanion extends UpdateCompanion<Document> {
  final Value<int> id;
  final Value<String> syncId;
  final Value<int> uploadedByUserId;
  final Value<int> clientId;
  final Value<String> title;
  final Value<String> filePath;
  final Value<DateTime> createdAt;
  final Value<DateTime> lastModifiedUtc;
  final Value<String> lastModifiedBy;
  final Value<bool> isDeleted;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.syncId = const Value.absent(),
    this.uploadedByUserId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.title = const Value.absent(),
    this.filePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastModifiedUtc = const Value.absent(),
    this.lastModifiedBy = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  DocumentsCompanion.insert({
    this.id = const Value.absent(),
    required String syncId,
    required int uploadedByUserId,
    required int clientId,
    required String title,
    required String filePath,
    required DateTime createdAt,
    required DateTime lastModifiedUtc,
    this.lastModifiedBy = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : syncId = Value(syncId),
       uploadedByUserId = Value(uploadedByUserId),
       clientId = Value(clientId),
       title = Value(title),
       filePath = Value(filePath),
       createdAt = Value(createdAt),
       lastModifiedUtc = Value(lastModifiedUtc);
  static Insertable<Document> custom({
    Expression<int>? id,
    Expression<String>? syncId,
    Expression<int>? uploadedByUserId,
    Expression<int>? clientId,
    Expression<String>? title,
    Expression<String>? filePath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastModifiedUtc,
    Expression<String>? lastModifiedBy,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncId != null) 'sync_id': syncId,
      if (uploadedByUserId != null) 'uploaded_by_user_id': uploadedByUserId,
      if (clientId != null) 'client_id': clientId,
      if (title != null) 'title': title,
      if (filePath != null) 'file_path': filePath,
      if (createdAt != null) 'created_at': createdAt,
      if (lastModifiedUtc != null) 'last_modified_utc': lastModifiedUtc,
      if (lastModifiedBy != null) 'last_modified_by': lastModifiedBy,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  DocumentsCompanion copyWith({
    Value<int>? id,
    Value<String>? syncId,
    Value<int>? uploadedByUserId,
    Value<int>? clientId,
    Value<String>? title,
    Value<String>? filePath,
    Value<DateTime>? createdAt,
    Value<DateTime>? lastModifiedUtc,
    Value<String>? lastModifiedBy,
    Value<bool>? isDeleted,
  }) {
    return DocumentsCompanion(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      uploadedByUserId: uploadedByUserId ?? this.uploadedByUserId,
      clientId: clientId ?? this.clientId,
      title: title ?? this.title,
      filePath: filePath ?? this.filePath,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedUtc: lastModifiedUtc ?? this.lastModifiedUtc,
      lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (uploadedByUserId.present) {
      map['uploaded_by_user_id'] = Variable<int>(uploadedByUserId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastModifiedUtc.present) {
      map['last_modified_utc'] = Variable<DateTime>(lastModifiedUtc.value);
    }
    if (lastModifiedBy.present) {
      map['last_modified_by'] = Variable<String>(lastModifiedBy.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('syncId: $syncId, ')
          ..write('uploadedByUserId: $uploadedByUserId, ')
          ..write('clientId: $clientId, ')
          ..write('title: $title, ')
          ..write('filePath: $filePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastModifiedUtc: $lastModifiedUtc, ')
          ..write('lastModifiedBy: $lastModifiedBy, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $ShopSettingsTableTable extends ShopSettingsTable
    with TableInfo<$ShopSettingsTableTable, ShopSettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShopSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _shopNameMeta = const VerificationMeta(
    'shopName',
  );
  @override
  late final GeneratedColumn<String> shopName = GeneratedColumn<String>(
    'shop_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _logoPathMeta = const VerificationMeta(
    'logoPath',
  );
  @override
  late final GeneratedColumn<String> logoPath = GeneratedColumn<String>(
    'logo_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _accentColorMeta = const VerificationMeta(
    'accentColor',
  );
  @override
  late final GeneratedColumn<String> accentColor = GeneratedColumn<String>(
    'accent_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sidebarArtworkPathMeta =
      const VerificationMeta('sidebarArtworkPath');
  @override
  late final GeneratedColumn<String> sidebarArtworkPath =
      GeneratedColumn<String>(
        'sidebar_artwork_path',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _specialMessageTextMeta =
      const VerificationMeta('specialMessageText');
  @override
  late final GeneratedColumn<String> specialMessageText =
      GeneratedColumn<String>(
        'special_message_text',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _loginBackgroundPathMeta =
      const VerificationMeta('loginBackgroundPath');
  @override
  late final GeneratedColumn<String> loginBackgroundPath =
      GeneratedColumn<String>(
        'login_background_path',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _loginHeadlineFontFamilyMeta =
      const VerificationMeta('loginHeadlineFontFamily');
  @override
  late final GeneratedColumn<String> loginHeadlineFontFamily =
      GeneratedColumn<String>(
        'login_headline_font_family',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _loginTaglineFontFamilyMeta =
      const VerificationMeta('loginTaglineFontFamily');
  @override
  late final GeneratedColumn<String> loginTaglineFontFamily =
      GeneratedColumn<String>(
        'login_tagline_font_family',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _loginTextColorMeta = const VerificationMeta(
    'loginTextColor',
  );
  @override
  late final GeneratedColumn<String> loginTextColor = GeneratedColumn<String>(
    'login_text_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _tattooPerHourMeta = const VerificationMeta(
    'tattooPerHour',
  );
  @override
  late final GeneratedColumn<double> tattooPerHour = GeneratedColumn<double>(
    'tattoo_per_hour',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(150.0),
  );
  static const VerificationMeta _piercingSingleMeta = const VerificationMeta(
    'piercingSingle',
  );
  @override
  late final GeneratedColumn<double> piercingSingle = GeneratedColumn<double>(
    'piercing_single',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(50.0),
  );
  static const VerificationMeta _piercingMultiMeta = const VerificationMeta(
    'piercingMulti',
  );
  @override
  late final GeneratedColumn<double> piercingMulti = GeneratedColumn<double>(
    'piercing_multi',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(40.0),
  );
  static const VerificationMeta _shopMinimumRateMeta = const VerificationMeta(
    'shopMinimumRate',
  );
  @override
  late final GeneratedColumn<double> shopMinimumRate = GeneratedColumn<double>(
    'shop_minimum_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(100.0),
  );
  static const VerificationMeta _enableAutomaticHolidayThemesMeta =
      const VerificationMeta('enableAutomaticHolidayThemes');
  @override
  late final GeneratedColumn<bool> enableAutomaticHolidayThemes =
      GeneratedColumn<bool>(
        'enable_automatic_holiday_themes',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("enable_automatic_holiday_themes" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _isSpecialMessageEnabledMeta =
      const VerificationMeta('isSpecialMessageEnabled');
  @override
  late final GeneratedColumn<bool> isSpecialMessageEnabled =
      GeneratedColumn<bool>(
        'is_special_message_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_special_message_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(true),
      );
  static const VerificationMeta _shopHoursJsonMeta = const VerificationMeta(
    'shopHoursJson',
  );
  @override
  late final GeneratedColumn<String> shopHoursJson = GeneratedColumn<String>(
    'shop_hours_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _taxRateMeta = const VerificationMeta(
    'taxRate',
  );
  @override
  late final GeneratedColumn<double> taxRate = GeneratedColumn<double>(
    'tax_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _depositTypeMeta = const VerificationMeta(
    'depositType',
  );
  @override
  late final GeneratedColumn<String> depositType = GeneratedColumn<String>(
    'deposit_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('percentage'),
  );
  static const VerificationMeta _depositAmountMeta = const VerificationMeta(
    'depositAmount',
  );
  @override
  late final GeneratedColumn<double> depositAmount = GeneratedColumn<double>(
    'deposit_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(20.0),
  );
  static const VerificationMeta _bookingBufferMinutesMeta =
      const VerificationMeta('bookingBufferMinutes');
  @override
  late final GeneratedColumn<int> bookingBufferMinutes = GeneratedColumn<int>(
    'booking_buffer_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(15),
  );
  static const VerificationMeta _cancellationPolicyMeta =
      const VerificationMeta('cancellationPolicy');
  @override
  late final GeneratedColumn<String> cancellationPolicy =
      GeneratedColumn<String>(
        'cancellation_policy',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _appointmentDurationPresetsJsonMeta =
      const VerificationMeta('appointmentDurationPresetsJson');
  @override
  late final GeneratedColumn<String> appointmentDurationPresetsJson =
      GeneratedColumn<String>(
        'appointment_duration_presets_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _specialHoursJsonMeta = const VerificationMeta(
    'specialHoursJson',
  );
  @override
  late final GeneratedColumn<String> specialHoursJson = GeneratedColumn<String>(
    'special_hours_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _notificationSettingsJsonMeta =
      const VerificationMeta('notificationSettingsJson');
  @override
  late final GeneratedColumn<String> notificationSettingsJson =
      GeneratedColumn<String>(
        'notification_settings_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _backupSettingsJsonMeta =
      const VerificationMeta('backupSettingsJson');
  @override
  late final GeneratedColumn<String> backupSettingsJson =
      GeneratedColumn<String>(
        'backup_settings_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _linkedAccountsJsonMeta =
      const VerificationMeta('linkedAccountsJson');
  @override
  late final GeneratedColumn<String> linkedAccountsJson =
      GeneratedColumn<String>(
        'linked_accounts_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _appFontSizeMeta = const VerificationMeta(
    'appFontSize',
  );
  @override
  late final GeneratedColumn<double> appFontSize = GeneratedColumn<double>(
    'app_font_size',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(14.0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopName,
    logoPath,
    accentColor,
    sidebarArtworkPath,
    specialMessageText,
    loginBackgroundPath,
    loginHeadlineFontFamily,
    loginTaglineFontFamily,
    loginTextColor,
    tattooPerHour,
    piercingSingle,
    piercingMulti,
    shopMinimumRate,
    enableAutomaticHolidayThemes,
    isSpecialMessageEnabled,
    shopHoursJson,
    taxRate,
    depositType,
    depositAmount,
    bookingBufferMinutes,
    cancellationPolicy,
    appointmentDurationPresetsJson,
    specialHoursJson,
    notificationSettingsJson,
    backupSettingsJson,
    linkedAccountsJson,
    appFontSize,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shop_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShopSettingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('shop_name')) {
      context.handle(
        _shopNameMeta,
        shopName.isAcceptableOrUnknown(data['shop_name']!, _shopNameMeta),
      );
    }
    if (data.containsKey('logo_path')) {
      context.handle(
        _logoPathMeta,
        logoPath.isAcceptableOrUnknown(data['logo_path']!, _logoPathMeta),
      );
    }
    if (data.containsKey('accent_color')) {
      context.handle(
        _accentColorMeta,
        accentColor.isAcceptableOrUnknown(
          data['accent_color']!,
          _accentColorMeta,
        ),
      );
    }
    if (data.containsKey('sidebar_artwork_path')) {
      context.handle(
        _sidebarArtworkPathMeta,
        sidebarArtworkPath.isAcceptableOrUnknown(
          data['sidebar_artwork_path']!,
          _sidebarArtworkPathMeta,
        ),
      );
    }
    if (data.containsKey('special_message_text')) {
      context.handle(
        _specialMessageTextMeta,
        specialMessageText.isAcceptableOrUnknown(
          data['special_message_text']!,
          _specialMessageTextMeta,
        ),
      );
    }
    if (data.containsKey('login_background_path')) {
      context.handle(
        _loginBackgroundPathMeta,
        loginBackgroundPath.isAcceptableOrUnknown(
          data['login_background_path']!,
          _loginBackgroundPathMeta,
        ),
      );
    }
    if (data.containsKey('login_headline_font_family')) {
      context.handle(
        _loginHeadlineFontFamilyMeta,
        loginHeadlineFontFamily.isAcceptableOrUnknown(
          data['login_headline_font_family']!,
          _loginHeadlineFontFamilyMeta,
        ),
      );
    }
    if (data.containsKey('login_tagline_font_family')) {
      context.handle(
        _loginTaglineFontFamilyMeta,
        loginTaglineFontFamily.isAcceptableOrUnknown(
          data['login_tagline_font_family']!,
          _loginTaglineFontFamilyMeta,
        ),
      );
    }
    if (data.containsKey('login_text_color')) {
      context.handle(
        _loginTextColorMeta,
        loginTextColor.isAcceptableOrUnknown(
          data['login_text_color']!,
          _loginTextColorMeta,
        ),
      );
    }
    if (data.containsKey('tattoo_per_hour')) {
      context.handle(
        _tattooPerHourMeta,
        tattooPerHour.isAcceptableOrUnknown(
          data['tattoo_per_hour']!,
          _tattooPerHourMeta,
        ),
      );
    }
    if (data.containsKey('piercing_single')) {
      context.handle(
        _piercingSingleMeta,
        piercingSingle.isAcceptableOrUnknown(
          data['piercing_single']!,
          _piercingSingleMeta,
        ),
      );
    }
    if (data.containsKey('piercing_multi')) {
      context.handle(
        _piercingMultiMeta,
        piercingMulti.isAcceptableOrUnknown(
          data['piercing_multi']!,
          _piercingMultiMeta,
        ),
      );
    }
    if (data.containsKey('shop_minimum_rate')) {
      context.handle(
        _shopMinimumRateMeta,
        shopMinimumRate.isAcceptableOrUnknown(
          data['shop_minimum_rate']!,
          _shopMinimumRateMeta,
        ),
      );
    }
    if (data.containsKey('enable_automatic_holiday_themes')) {
      context.handle(
        _enableAutomaticHolidayThemesMeta,
        enableAutomaticHolidayThemes.isAcceptableOrUnknown(
          data['enable_automatic_holiday_themes']!,
          _enableAutomaticHolidayThemesMeta,
        ),
      );
    }
    if (data.containsKey('is_special_message_enabled')) {
      context.handle(
        _isSpecialMessageEnabledMeta,
        isSpecialMessageEnabled.isAcceptableOrUnknown(
          data['is_special_message_enabled']!,
          _isSpecialMessageEnabledMeta,
        ),
      );
    }
    if (data.containsKey('shop_hours_json')) {
      context.handle(
        _shopHoursJsonMeta,
        shopHoursJson.isAcceptableOrUnknown(
          data['shop_hours_json']!,
          _shopHoursJsonMeta,
        ),
      );
    }
    if (data.containsKey('tax_rate')) {
      context.handle(
        _taxRateMeta,
        taxRate.isAcceptableOrUnknown(data['tax_rate']!, _taxRateMeta),
      );
    }
    if (data.containsKey('deposit_type')) {
      context.handle(
        _depositTypeMeta,
        depositType.isAcceptableOrUnknown(
          data['deposit_type']!,
          _depositTypeMeta,
        ),
      );
    }
    if (data.containsKey('deposit_amount')) {
      context.handle(
        _depositAmountMeta,
        depositAmount.isAcceptableOrUnknown(
          data['deposit_amount']!,
          _depositAmountMeta,
        ),
      );
    }
    if (data.containsKey('booking_buffer_minutes')) {
      context.handle(
        _bookingBufferMinutesMeta,
        bookingBufferMinutes.isAcceptableOrUnknown(
          data['booking_buffer_minutes']!,
          _bookingBufferMinutesMeta,
        ),
      );
    }
    if (data.containsKey('cancellation_policy')) {
      context.handle(
        _cancellationPolicyMeta,
        cancellationPolicy.isAcceptableOrUnknown(
          data['cancellation_policy']!,
          _cancellationPolicyMeta,
        ),
      );
    }
    if (data.containsKey('appointment_duration_presets_json')) {
      context.handle(
        _appointmentDurationPresetsJsonMeta,
        appointmentDurationPresetsJson.isAcceptableOrUnknown(
          data['appointment_duration_presets_json']!,
          _appointmentDurationPresetsJsonMeta,
        ),
      );
    }
    if (data.containsKey('special_hours_json')) {
      context.handle(
        _specialHoursJsonMeta,
        specialHoursJson.isAcceptableOrUnknown(
          data['special_hours_json']!,
          _specialHoursJsonMeta,
        ),
      );
    }
    if (data.containsKey('notification_settings_json')) {
      context.handle(
        _notificationSettingsJsonMeta,
        notificationSettingsJson.isAcceptableOrUnknown(
          data['notification_settings_json']!,
          _notificationSettingsJsonMeta,
        ),
      );
    }
    if (data.containsKey('backup_settings_json')) {
      context.handle(
        _backupSettingsJsonMeta,
        backupSettingsJson.isAcceptableOrUnknown(
          data['backup_settings_json']!,
          _backupSettingsJsonMeta,
        ),
      );
    }
    if (data.containsKey('linked_accounts_json')) {
      context.handle(
        _linkedAccountsJsonMeta,
        linkedAccountsJson.isAcceptableOrUnknown(
          data['linked_accounts_json']!,
          _linkedAccountsJsonMeta,
        ),
      );
    }
    if (data.containsKey('app_font_size')) {
      context.handle(
        _appFontSizeMeta,
        appFontSize.isAcceptableOrUnknown(
          data['app_font_size']!,
          _appFontSizeMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShopSettingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShopSettingsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      shopName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_name'],
      )!,
      logoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_path'],
      )!,
      accentColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accent_color'],
      )!,
      sidebarArtworkPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sidebar_artwork_path'],
      )!,
      specialMessageText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}special_message_text'],
      )!,
      loginBackgroundPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}login_background_path'],
      )!,
      loginHeadlineFontFamily: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}login_headline_font_family'],
      )!,
      loginTaglineFontFamily: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}login_tagline_font_family'],
      )!,
      loginTextColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}login_text_color'],
      )!,
      tattooPerHour: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tattoo_per_hour'],
      )!,
      piercingSingle: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}piercing_single'],
      )!,
      piercingMulti: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}piercing_multi'],
      )!,
      shopMinimumRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}shop_minimum_rate'],
      )!,
      enableAutomaticHolidayThemes: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable_automatic_holiday_themes'],
      )!,
      isSpecialMessageEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_special_message_enabled'],
      )!,
      shopHoursJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_hours_json'],
      )!,
      taxRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_rate'],
      )!,
      depositType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deposit_type'],
      )!,
      depositAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}deposit_amount'],
      )!,
      bookingBufferMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}booking_buffer_minutes'],
      )!,
      cancellationPolicy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cancellation_policy'],
      )!,
      appointmentDurationPresetsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}appointment_duration_presets_json'],
      )!,
      specialHoursJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}special_hours_json'],
      )!,
      notificationSettingsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notification_settings_json'],
      )!,
      backupSettingsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}backup_settings_json'],
      )!,
      linkedAccountsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}linked_accounts_json'],
      )!,
      appFontSize: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}app_font_size'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ShopSettingsTableTable createAlias(String alias) {
    return $ShopSettingsTableTable(attachedDatabase, alias);
  }
}

class ShopSettingsTableData extends DataClass
    implements Insertable<ShopSettingsTableData> {
  /// Primary key (typically -1 or 1 for singleton)
  final int id;

  /// Shop name for display
  final String shopName;

  /// Path to logo image
  final String logoPath;

  /// Primary accent color (hex or named)
  final String accentColor;

  /// Path to sidebar artwork
  final String sidebarArtworkPath;

  /// Special message text for announcements
  final String specialMessageText;

  /// Path to login background image
  final String loginBackgroundPath;

  /// Login headline font family
  final String loginHeadlineFontFamily;

  /// Login tagline font family
  final String loginTaglineFontFamily;

  /// Login text color
  final String loginTextColor;

  /// Tattoo hourly rate
  final double tattooPerHour;

  /// Single piercing price
  final double piercingSingle;

  /// Multiple piercing discount price
  final double piercingMulti;

  /// Shop minimum charge
  final double shopMinimumRate;

  /// Whether to enable automatic holiday themes
  final bool enableAutomaticHolidayThemes;

  /// Whether special message is enabled
  final bool isSpecialMessageEnabled;

  /// JSON string for shop hours by day
  final String shopHoursJson;

  /// Sales tax rate (0-1)
  final double taxRate;

  /// Deposit type (percentage/fixed)
  final String depositType;

  /// Deposit amount (percentage or fixed value)
  final double depositAmount;

  /// Buffer minutes between bookings
  final int bookingBufferMinutes;

  /// Cancellation policy text
  final String cancellationPolicy;

  /// JSON string for appointment duration presets
  final String appointmentDurationPresetsJson;

  /// JSON string for special hours/closures
  final String specialHoursJson;

  /// JSON string for notification settings
  final String notificationSettingsJson;

  /// JSON string for backup settings
  final String backupSettingsJson;

  /// JSON string for linked accounts
  final String linkedAccountsJson;

  /// Default app font size
  final double appFontSize;

  /// Record creation timestamp
  final DateTime createdAt;

  /// Last update timestamp
  final DateTime updatedAt;
  const ShopSettingsTableData({
    required this.id,
    required this.shopName,
    required this.logoPath,
    required this.accentColor,
    required this.sidebarArtworkPath,
    required this.specialMessageText,
    required this.loginBackgroundPath,
    required this.loginHeadlineFontFamily,
    required this.loginTaglineFontFamily,
    required this.loginTextColor,
    required this.tattooPerHour,
    required this.piercingSingle,
    required this.piercingMulti,
    required this.shopMinimumRate,
    required this.enableAutomaticHolidayThemes,
    required this.isSpecialMessageEnabled,
    required this.shopHoursJson,
    required this.taxRate,
    required this.depositType,
    required this.depositAmount,
    required this.bookingBufferMinutes,
    required this.cancellationPolicy,
    required this.appointmentDurationPresetsJson,
    required this.specialHoursJson,
    required this.notificationSettingsJson,
    required this.backupSettingsJson,
    required this.linkedAccountsJson,
    required this.appFontSize,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['shop_name'] = Variable<String>(shopName);
    map['logo_path'] = Variable<String>(logoPath);
    map['accent_color'] = Variable<String>(accentColor);
    map['sidebar_artwork_path'] = Variable<String>(sidebarArtworkPath);
    map['special_message_text'] = Variable<String>(specialMessageText);
    map['login_background_path'] = Variable<String>(loginBackgroundPath);
    map['login_headline_font_family'] = Variable<String>(
      loginHeadlineFontFamily,
    );
    map['login_tagline_font_family'] = Variable<String>(loginTaglineFontFamily);
    map['login_text_color'] = Variable<String>(loginTextColor);
    map['tattoo_per_hour'] = Variable<double>(tattooPerHour);
    map['piercing_single'] = Variable<double>(piercingSingle);
    map['piercing_multi'] = Variable<double>(piercingMulti);
    map['shop_minimum_rate'] = Variable<double>(shopMinimumRate);
    map['enable_automatic_holiday_themes'] = Variable<bool>(
      enableAutomaticHolidayThemes,
    );
    map['is_special_message_enabled'] = Variable<bool>(isSpecialMessageEnabled);
    map['shop_hours_json'] = Variable<String>(shopHoursJson);
    map['tax_rate'] = Variable<double>(taxRate);
    map['deposit_type'] = Variable<String>(depositType);
    map['deposit_amount'] = Variable<double>(depositAmount);
    map['booking_buffer_minutes'] = Variable<int>(bookingBufferMinutes);
    map['cancellation_policy'] = Variable<String>(cancellationPolicy);
    map['appointment_duration_presets_json'] = Variable<String>(
      appointmentDurationPresetsJson,
    );
    map['special_hours_json'] = Variable<String>(specialHoursJson);
    map['notification_settings_json'] = Variable<String>(
      notificationSettingsJson,
    );
    map['backup_settings_json'] = Variable<String>(backupSettingsJson);
    map['linked_accounts_json'] = Variable<String>(linkedAccountsJson);
    map['app_font_size'] = Variable<double>(appFontSize);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ShopSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return ShopSettingsTableCompanion(
      id: Value(id),
      shopName: Value(shopName),
      logoPath: Value(logoPath),
      accentColor: Value(accentColor),
      sidebarArtworkPath: Value(sidebarArtworkPath),
      specialMessageText: Value(specialMessageText),
      loginBackgroundPath: Value(loginBackgroundPath),
      loginHeadlineFontFamily: Value(loginHeadlineFontFamily),
      loginTaglineFontFamily: Value(loginTaglineFontFamily),
      loginTextColor: Value(loginTextColor),
      tattooPerHour: Value(tattooPerHour),
      piercingSingle: Value(piercingSingle),
      piercingMulti: Value(piercingMulti),
      shopMinimumRate: Value(shopMinimumRate),
      enableAutomaticHolidayThemes: Value(enableAutomaticHolidayThemes),
      isSpecialMessageEnabled: Value(isSpecialMessageEnabled),
      shopHoursJson: Value(shopHoursJson),
      taxRate: Value(taxRate),
      depositType: Value(depositType),
      depositAmount: Value(depositAmount),
      bookingBufferMinutes: Value(bookingBufferMinutes),
      cancellationPolicy: Value(cancellationPolicy),
      appointmentDurationPresetsJson: Value(appointmentDurationPresetsJson),
      specialHoursJson: Value(specialHoursJson),
      notificationSettingsJson: Value(notificationSettingsJson),
      backupSettingsJson: Value(backupSettingsJson),
      linkedAccountsJson: Value(linkedAccountsJson),
      appFontSize: Value(appFontSize),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ShopSettingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShopSettingsTableData(
      id: serializer.fromJson<int>(json['id']),
      shopName: serializer.fromJson<String>(json['shopName']),
      logoPath: serializer.fromJson<String>(json['logoPath']),
      accentColor: serializer.fromJson<String>(json['accentColor']),
      sidebarArtworkPath: serializer.fromJson<String>(
        json['sidebarArtworkPath'],
      ),
      specialMessageText: serializer.fromJson<String>(
        json['specialMessageText'],
      ),
      loginBackgroundPath: serializer.fromJson<String>(
        json['loginBackgroundPath'],
      ),
      loginHeadlineFontFamily: serializer.fromJson<String>(
        json['loginHeadlineFontFamily'],
      ),
      loginTaglineFontFamily: serializer.fromJson<String>(
        json['loginTaglineFontFamily'],
      ),
      loginTextColor: serializer.fromJson<String>(json['loginTextColor']),
      tattooPerHour: serializer.fromJson<double>(json['tattooPerHour']),
      piercingSingle: serializer.fromJson<double>(json['piercingSingle']),
      piercingMulti: serializer.fromJson<double>(json['piercingMulti']),
      shopMinimumRate: serializer.fromJson<double>(json['shopMinimumRate']),
      enableAutomaticHolidayThemes: serializer.fromJson<bool>(
        json['enableAutomaticHolidayThemes'],
      ),
      isSpecialMessageEnabled: serializer.fromJson<bool>(
        json['isSpecialMessageEnabled'],
      ),
      shopHoursJson: serializer.fromJson<String>(json['shopHoursJson']),
      taxRate: serializer.fromJson<double>(json['taxRate']),
      depositType: serializer.fromJson<String>(json['depositType']),
      depositAmount: serializer.fromJson<double>(json['depositAmount']),
      bookingBufferMinutes: serializer.fromJson<int>(
        json['bookingBufferMinutes'],
      ),
      cancellationPolicy: serializer.fromJson<String>(
        json['cancellationPolicy'],
      ),
      appointmentDurationPresetsJson: serializer.fromJson<String>(
        json['appointmentDurationPresetsJson'],
      ),
      specialHoursJson: serializer.fromJson<String>(json['specialHoursJson']),
      notificationSettingsJson: serializer.fromJson<String>(
        json['notificationSettingsJson'],
      ),
      backupSettingsJson: serializer.fromJson<String>(
        json['backupSettingsJson'],
      ),
      linkedAccountsJson: serializer.fromJson<String>(
        json['linkedAccountsJson'],
      ),
      appFontSize: serializer.fromJson<double>(json['appFontSize']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'shopName': serializer.toJson<String>(shopName),
      'logoPath': serializer.toJson<String>(logoPath),
      'accentColor': serializer.toJson<String>(accentColor),
      'sidebarArtworkPath': serializer.toJson<String>(sidebarArtworkPath),
      'specialMessageText': serializer.toJson<String>(specialMessageText),
      'loginBackgroundPath': serializer.toJson<String>(loginBackgroundPath),
      'loginHeadlineFontFamily': serializer.toJson<String>(
        loginHeadlineFontFamily,
      ),
      'loginTaglineFontFamily': serializer.toJson<String>(
        loginTaglineFontFamily,
      ),
      'loginTextColor': serializer.toJson<String>(loginTextColor),
      'tattooPerHour': serializer.toJson<double>(tattooPerHour),
      'piercingSingle': serializer.toJson<double>(piercingSingle),
      'piercingMulti': serializer.toJson<double>(piercingMulti),
      'shopMinimumRate': serializer.toJson<double>(shopMinimumRate),
      'enableAutomaticHolidayThemes': serializer.toJson<bool>(
        enableAutomaticHolidayThemes,
      ),
      'isSpecialMessageEnabled': serializer.toJson<bool>(
        isSpecialMessageEnabled,
      ),
      'shopHoursJson': serializer.toJson<String>(shopHoursJson),
      'taxRate': serializer.toJson<double>(taxRate),
      'depositType': serializer.toJson<String>(depositType),
      'depositAmount': serializer.toJson<double>(depositAmount),
      'bookingBufferMinutes': serializer.toJson<int>(bookingBufferMinutes),
      'cancellationPolicy': serializer.toJson<String>(cancellationPolicy),
      'appointmentDurationPresetsJson': serializer.toJson<String>(
        appointmentDurationPresetsJson,
      ),
      'specialHoursJson': serializer.toJson<String>(specialHoursJson),
      'notificationSettingsJson': serializer.toJson<String>(
        notificationSettingsJson,
      ),
      'backupSettingsJson': serializer.toJson<String>(backupSettingsJson),
      'linkedAccountsJson': serializer.toJson<String>(linkedAccountsJson),
      'appFontSize': serializer.toJson<double>(appFontSize),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ShopSettingsTableData copyWith({
    int? id,
    String? shopName,
    String? logoPath,
    String? accentColor,
    String? sidebarArtworkPath,
    String? specialMessageText,
    String? loginBackgroundPath,
    String? loginHeadlineFontFamily,
    String? loginTaglineFontFamily,
    String? loginTextColor,
    double? tattooPerHour,
    double? piercingSingle,
    double? piercingMulti,
    double? shopMinimumRate,
    bool? enableAutomaticHolidayThemes,
    bool? isSpecialMessageEnabled,
    String? shopHoursJson,
    double? taxRate,
    String? depositType,
    double? depositAmount,
    int? bookingBufferMinutes,
    String? cancellationPolicy,
    String? appointmentDurationPresetsJson,
    String? specialHoursJson,
    String? notificationSettingsJson,
    String? backupSettingsJson,
    String? linkedAccountsJson,
    double? appFontSize,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ShopSettingsTableData(
    id: id ?? this.id,
    shopName: shopName ?? this.shopName,
    logoPath: logoPath ?? this.logoPath,
    accentColor: accentColor ?? this.accentColor,
    sidebarArtworkPath: sidebarArtworkPath ?? this.sidebarArtworkPath,
    specialMessageText: specialMessageText ?? this.specialMessageText,
    loginBackgroundPath: loginBackgroundPath ?? this.loginBackgroundPath,
    loginHeadlineFontFamily:
        loginHeadlineFontFamily ?? this.loginHeadlineFontFamily,
    loginTaglineFontFamily:
        loginTaglineFontFamily ?? this.loginTaglineFontFamily,
    loginTextColor: loginTextColor ?? this.loginTextColor,
    tattooPerHour: tattooPerHour ?? this.tattooPerHour,
    piercingSingle: piercingSingle ?? this.piercingSingle,
    piercingMulti: piercingMulti ?? this.piercingMulti,
    shopMinimumRate: shopMinimumRate ?? this.shopMinimumRate,
    enableAutomaticHolidayThemes:
        enableAutomaticHolidayThemes ?? this.enableAutomaticHolidayThemes,
    isSpecialMessageEnabled:
        isSpecialMessageEnabled ?? this.isSpecialMessageEnabled,
    shopHoursJson: shopHoursJson ?? this.shopHoursJson,
    taxRate: taxRate ?? this.taxRate,
    depositType: depositType ?? this.depositType,
    depositAmount: depositAmount ?? this.depositAmount,
    bookingBufferMinutes: bookingBufferMinutes ?? this.bookingBufferMinutes,
    cancellationPolicy: cancellationPolicy ?? this.cancellationPolicy,
    appointmentDurationPresetsJson:
        appointmentDurationPresetsJson ?? this.appointmentDurationPresetsJson,
    specialHoursJson: specialHoursJson ?? this.specialHoursJson,
    notificationSettingsJson:
        notificationSettingsJson ?? this.notificationSettingsJson,
    backupSettingsJson: backupSettingsJson ?? this.backupSettingsJson,
    linkedAccountsJson: linkedAccountsJson ?? this.linkedAccountsJson,
    appFontSize: appFontSize ?? this.appFontSize,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ShopSettingsTableData copyWithCompanion(ShopSettingsTableCompanion data) {
    return ShopSettingsTableData(
      id: data.id.present ? data.id.value : this.id,
      shopName: data.shopName.present ? data.shopName.value : this.shopName,
      logoPath: data.logoPath.present ? data.logoPath.value : this.logoPath,
      accentColor: data.accentColor.present
          ? data.accentColor.value
          : this.accentColor,
      sidebarArtworkPath: data.sidebarArtworkPath.present
          ? data.sidebarArtworkPath.value
          : this.sidebarArtworkPath,
      specialMessageText: data.specialMessageText.present
          ? data.specialMessageText.value
          : this.specialMessageText,
      loginBackgroundPath: data.loginBackgroundPath.present
          ? data.loginBackgroundPath.value
          : this.loginBackgroundPath,
      loginHeadlineFontFamily: data.loginHeadlineFontFamily.present
          ? data.loginHeadlineFontFamily.value
          : this.loginHeadlineFontFamily,
      loginTaglineFontFamily: data.loginTaglineFontFamily.present
          ? data.loginTaglineFontFamily.value
          : this.loginTaglineFontFamily,
      loginTextColor: data.loginTextColor.present
          ? data.loginTextColor.value
          : this.loginTextColor,
      tattooPerHour: data.tattooPerHour.present
          ? data.tattooPerHour.value
          : this.tattooPerHour,
      piercingSingle: data.piercingSingle.present
          ? data.piercingSingle.value
          : this.piercingSingle,
      piercingMulti: data.piercingMulti.present
          ? data.piercingMulti.value
          : this.piercingMulti,
      shopMinimumRate: data.shopMinimumRate.present
          ? data.shopMinimumRate.value
          : this.shopMinimumRate,
      enableAutomaticHolidayThemes: data.enableAutomaticHolidayThemes.present
          ? data.enableAutomaticHolidayThemes.value
          : this.enableAutomaticHolidayThemes,
      isSpecialMessageEnabled: data.isSpecialMessageEnabled.present
          ? data.isSpecialMessageEnabled.value
          : this.isSpecialMessageEnabled,
      shopHoursJson: data.shopHoursJson.present
          ? data.shopHoursJson.value
          : this.shopHoursJson,
      taxRate: data.taxRate.present ? data.taxRate.value : this.taxRate,
      depositType: data.depositType.present
          ? data.depositType.value
          : this.depositType,
      depositAmount: data.depositAmount.present
          ? data.depositAmount.value
          : this.depositAmount,
      bookingBufferMinutes: data.bookingBufferMinutes.present
          ? data.bookingBufferMinutes.value
          : this.bookingBufferMinutes,
      cancellationPolicy: data.cancellationPolicy.present
          ? data.cancellationPolicy.value
          : this.cancellationPolicy,
      appointmentDurationPresetsJson:
          data.appointmentDurationPresetsJson.present
          ? data.appointmentDurationPresetsJson.value
          : this.appointmentDurationPresetsJson,
      specialHoursJson: data.specialHoursJson.present
          ? data.specialHoursJson.value
          : this.specialHoursJson,
      notificationSettingsJson: data.notificationSettingsJson.present
          ? data.notificationSettingsJson.value
          : this.notificationSettingsJson,
      backupSettingsJson: data.backupSettingsJson.present
          ? data.backupSettingsJson.value
          : this.backupSettingsJson,
      linkedAccountsJson: data.linkedAccountsJson.present
          ? data.linkedAccountsJson.value
          : this.linkedAccountsJson,
      appFontSize: data.appFontSize.present
          ? data.appFontSize.value
          : this.appFontSize,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShopSettingsTableData(')
          ..write('id: $id, ')
          ..write('shopName: $shopName, ')
          ..write('logoPath: $logoPath, ')
          ..write('accentColor: $accentColor, ')
          ..write('sidebarArtworkPath: $sidebarArtworkPath, ')
          ..write('specialMessageText: $specialMessageText, ')
          ..write('loginBackgroundPath: $loginBackgroundPath, ')
          ..write('loginHeadlineFontFamily: $loginHeadlineFontFamily, ')
          ..write('loginTaglineFontFamily: $loginTaglineFontFamily, ')
          ..write('loginTextColor: $loginTextColor, ')
          ..write('tattooPerHour: $tattooPerHour, ')
          ..write('piercingSingle: $piercingSingle, ')
          ..write('piercingMulti: $piercingMulti, ')
          ..write('shopMinimumRate: $shopMinimumRate, ')
          ..write(
            'enableAutomaticHolidayThemes: $enableAutomaticHolidayThemes, ',
          )
          ..write('isSpecialMessageEnabled: $isSpecialMessageEnabled, ')
          ..write('shopHoursJson: $shopHoursJson, ')
          ..write('taxRate: $taxRate, ')
          ..write('depositType: $depositType, ')
          ..write('depositAmount: $depositAmount, ')
          ..write('bookingBufferMinutes: $bookingBufferMinutes, ')
          ..write('cancellationPolicy: $cancellationPolicy, ')
          ..write(
            'appointmentDurationPresetsJson: $appointmentDurationPresetsJson, ',
          )
          ..write('specialHoursJson: $specialHoursJson, ')
          ..write('notificationSettingsJson: $notificationSettingsJson, ')
          ..write('backupSettingsJson: $backupSettingsJson, ')
          ..write('linkedAccountsJson: $linkedAccountsJson, ')
          ..write('appFontSize: $appFontSize, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    shopName,
    logoPath,
    accentColor,
    sidebarArtworkPath,
    specialMessageText,
    loginBackgroundPath,
    loginHeadlineFontFamily,
    loginTaglineFontFamily,
    loginTextColor,
    tattooPerHour,
    piercingSingle,
    piercingMulti,
    shopMinimumRate,
    enableAutomaticHolidayThemes,
    isSpecialMessageEnabled,
    shopHoursJson,
    taxRate,
    depositType,
    depositAmount,
    bookingBufferMinutes,
    cancellationPolicy,
    appointmentDurationPresetsJson,
    specialHoursJson,
    notificationSettingsJson,
    backupSettingsJson,
    linkedAccountsJson,
    appFontSize,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShopSettingsTableData &&
          other.id == this.id &&
          other.shopName == this.shopName &&
          other.logoPath == this.logoPath &&
          other.accentColor == this.accentColor &&
          other.sidebarArtworkPath == this.sidebarArtworkPath &&
          other.specialMessageText == this.specialMessageText &&
          other.loginBackgroundPath == this.loginBackgroundPath &&
          other.loginHeadlineFontFamily == this.loginHeadlineFontFamily &&
          other.loginTaglineFontFamily == this.loginTaglineFontFamily &&
          other.loginTextColor == this.loginTextColor &&
          other.tattooPerHour == this.tattooPerHour &&
          other.piercingSingle == this.piercingSingle &&
          other.piercingMulti == this.piercingMulti &&
          other.shopMinimumRate == this.shopMinimumRate &&
          other.enableAutomaticHolidayThemes ==
              this.enableAutomaticHolidayThemes &&
          other.isSpecialMessageEnabled == this.isSpecialMessageEnabled &&
          other.shopHoursJson == this.shopHoursJson &&
          other.taxRate == this.taxRate &&
          other.depositType == this.depositType &&
          other.depositAmount == this.depositAmount &&
          other.bookingBufferMinutes == this.bookingBufferMinutes &&
          other.cancellationPolicy == this.cancellationPolicy &&
          other.appointmentDurationPresetsJson ==
              this.appointmentDurationPresetsJson &&
          other.specialHoursJson == this.specialHoursJson &&
          other.notificationSettingsJson == this.notificationSettingsJson &&
          other.backupSettingsJson == this.backupSettingsJson &&
          other.linkedAccountsJson == this.linkedAccountsJson &&
          other.appFontSize == this.appFontSize &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ShopSettingsTableCompanion
    extends UpdateCompanion<ShopSettingsTableData> {
  final Value<int> id;
  final Value<String> shopName;
  final Value<String> logoPath;
  final Value<String> accentColor;
  final Value<String> sidebarArtworkPath;
  final Value<String> specialMessageText;
  final Value<String> loginBackgroundPath;
  final Value<String> loginHeadlineFontFamily;
  final Value<String> loginTaglineFontFamily;
  final Value<String> loginTextColor;
  final Value<double> tattooPerHour;
  final Value<double> piercingSingle;
  final Value<double> piercingMulti;
  final Value<double> shopMinimumRate;
  final Value<bool> enableAutomaticHolidayThemes;
  final Value<bool> isSpecialMessageEnabled;
  final Value<String> shopHoursJson;
  final Value<double> taxRate;
  final Value<String> depositType;
  final Value<double> depositAmount;
  final Value<int> bookingBufferMinutes;
  final Value<String> cancellationPolicy;
  final Value<String> appointmentDurationPresetsJson;
  final Value<String> specialHoursJson;
  final Value<String> notificationSettingsJson;
  final Value<String> backupSettingsJson;
  final Value<String> linkedAccountsJson;
  final Value<double> appFontSize;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ShopSettingsTableCompanion({
    this.id = const Value.absent(),
    this.shopName = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.accentColor = const Value.absent(),
    this.sidebarArtworkPath = const Value.absent(),
    this.specialMessageText = const Value.absent(),
    this.loginBackgroundPath = const Value.absent(),
    this.loginHeadlineFontFamily = const Value.absent(),
    this.loginTaglineFontFamily = const Value.absent(),
    this.loginTextColor = const Value.absent(),
    this.tattooPerHour = const Value.absent(),
    this.piercingSingle = const Value.absent(),
    this.piercingMulti = const Value.absent(),
    this.shopMinimumRate = const Value.absent(),
    this.enableAutomaticHolidayThemes = const Value.absent(),
    this.isSpecialMessageEnabled = const Value.absent(),
    this.shopHoursJson = const Value.absent(),
    this.taxRate = const Value.absent(),
    this.depositType = const Value.absent(),
    this.depositAmount = const Value.absent(),
    this.bookingBufferMinutes = const Value.absent(),
    this.cancellationPolicy = const Value.absent(),
    this.appointmentDurationPresetsJson = const Value.absent(),
    this.specialHoursJson = const Value.absent(),
    this.notificationSettingsJson = const Value.absent(),
    this.backupSettingsJson = const Value.absent(),
    this.linkedAccountsJson = const Value.absent(),
    this.appFontSize = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ShopSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    this.shopName = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.accentColor = const Value.absent(),
    this.sidebarArtworkPath = const Value.absent(),
    this.specialMessageText = const Value.absent(),
    this.loginBackgroundPath = const Value.absent(),
    this.loginHeadlineFontFamily = const Value.absent(),
    this.loginTaglineFontFamily = const Value.absent(),
    this.loginTextColor = const Value.absent(),
    this.tattooPerHour = const Value.absent(),
    this.piercingSingle = const Value.absent(),
    this.piercingMulti = const Value.absent(),
    this.shopMinimumRate = const Value.absent(),
    this.enableAutomaticHolidayThemes = const Value.absent(),
    this.isSpecialMessageEnabled = const Value.absent(),
    this.shopHoursJson = const Value.absent(),
    this.taxRate = const Value.absent(),
    this.depositType = const Value.absent(),
    this.depositAmount = const Value.absent(),
    this.bookingBufferMinutes = const Value.absent(),
    this.cancellationPolicy = const Value.absent(),
    this.appointmentDurationPresetsJson = const Value.absent(),
    this.specialHoursJson = const Value.absent(),
    this.notificationSettingsJson = const Value.absent(),
    this.backupSettingsJson = const Value.absent(),
    this.linkedAccountsJson = const Value.absent(),
    this.appFontSize = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ShopSettingsTableData> custom({
    Expression<int>? id,
    Expression<String>? shopName,
    Expression<String>? logoPath,
    Expression<String>? accentColor,
    Expression<String>? sidebarArtworkPath,
    Expression<String>? specialMessageText,
    Expression<String>? loginBackgroundPath,
    Expression<String>? loginHeadlineFontFamily,
    Expression<String>? loginTaglineFontFamily,
    Expression<String>? loginTextColor,
    Expression<double>? tattooPerHour,
    Expression<double>? piercingSingle,
    Expression<double>? piercingMulti,
    Expression<double>? shopMinimumRate,
    Expression<bool>? enableAutomaticHolidayThemes,
    Expression<bool>? isSpecialMessageEnabled,
    Expression<String>? shopHoursJson,
    Expression<double>? taxRate,
    Expression<String>? depositType,
    Expression<double>? depositAmount,
    Expression<int>? bookingBufferMinutes,
    Expression<String>? cancellationPolicy,
    Expression<String>? appointmentDurationPresetsJson,
    Expression<String>? specialHoursJson,
    Expression<String>? notificationSettingsJson,
    Expression<String>? backupSettingsJson,
    Expression<String>? linkedAccountsJson,
    Expression<double>? appFontSize,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopName != null) 'shop_name': shopName,
      if (logoPath != null) 'logo_path': logoPath,
      if (accentColor != null) 'accent_color': accentColor,
      if (sidebarArtworkPath != null)
        'sidebar_artwork_path': sidebarArtworkPath,
      if (specialMessageText != null)
        'special_message_text': specialMessageText,
      if (loginBackgroundPath != null)
        'login_background_path': loginBackgroundPath,
      if (loginHeadlineFontFamily != null)
        'login_headline_font_family': loginHeadlineFontFamily,
      if (loginTaglineFontFamily != null)
        'login_tagline_font_family': loginTaglineFontFamily,
      if (loginTextColor != null) 'login_text_color': loginTextColor,
      if (tattooPerHour != null) 'tattoo_per_hour': tattooPerHour,
      if (piercingSingle != null) 'piercing_single': piercingSingle,
      if (piercingMulti != null) 'piercing_multi': piercingMulti,
      if (shopMinimumRate != null) 'shop_minimum_rate': shopMinimumRate,
      if (enableAutomaticHolidayThemes != null)
        'enable_automatic_holiday_themes': enableAutomaticHolidayThemes,
      if (isSpecialMessageEnabled != null)
        'is_special_message_enabled': isSpecialMessageEnabled,
      if (shopHoursJson != null) 'shop_hours_json': shopHoursJson,
      if (taxRate != null) 'tax_rate': taxRate,
      if (depositType != null) 'deposit_type': depositType,
      if (depositAmount != null) 'deposit_amount': depositAmount,
      if (bookingBufferMinutes != null)
        'booking_buffer_minutes': bookingBufferMinutes,
      if (cancellationPolicy != null) 'cancellation_policy': cancellationPolicy,
      if (appointmentDurationPresetsJson != null)
        'appointment_duration_presets_json': appointmentDurationPresetsJson,
      if (specialHoursJson != null) 'special_hours_json': specialHoursJson,
      if (notificationSettingsJson != null)
        'notification_settings_json': notificationSettingsJson,
      if (backupSettingsJson != null)
        'backup_settings_json': backupSettingsJson,
      if (linkedAccountsJson != null)
        'linked_accounts_json': linkedAccountsJson,
      if (appFontSize != null) 'app_font_size': appFontSize,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ShopSettingsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? shopName,
    Value<String>? logoPath,
    Value<String>? accentColor,
    Value<String>? sidebarArtworkPath,
    Value<String>? specialMessageText,
    Value<String>? loginBackgroundPath,
    Value<String>? loginHeadlineFontFamily,
    Value<String>? loginTaglineFontFamily,
    Value<String>? loginTextColor,
    Value<double>? tattooPerHour,
    Value<double>? piercingSingle,
    Value<double>? piercingMulti,
    Value<double>? shopMinimumRate,
    Value<bool>? enableAutomaticHolidayThemes,
    Value<bool>? isSpecialMessageEnabled,
    Value<String>? shopHoursJson,
    Value<double>? taxRate,
    Value<String>? depositType,
    Value<double>? depositAmount,
    Value<int>? bookingBufferMinutes,
    Value<String>? cancellationPolicy,
    Value<String>? appointmentDurationPresetsJson,
    Value<String>? specialHoursJson,
    Value<String>? notificationSettingsJson,
    Value<String>? backupSettingsJson,
    Value<String>? linkedAccountsJson,
    Value<double>? appFontSize,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ShopSettingsTableCompanion(
      id: id ?? this.id,
      shopName: shopName ?? this.shopName,
      logoPath: logoPath ?? this.logoPath,
      accentColor: accentColor ?? this.accentColor,
      sidebarArtworkPath: sidebarArtworkPath ?? this.sidebarArtworkPath,
      specialMessageText: specialMessageText ?? this.specialMessageText,
      loginBackgroundPath: loginBackgroundPath ?? this.loginBackgroundPath,
      loginHeadlineFontFamily:
          loginHeadlineFontFamily ?? this.loginHeadlineFontFamily,
      loginTaglineFontFamily:
          loginTaglineFontFamily ?? this.loginTaglineFontFamily,
      loginTextColor: loginTextColor ?? this.loginTextColor,
      tattooPerHour: tattooPerHour ?? this.tattooPerHour,
      piercingSingle: piercingSingle ?? this.piercingSingle,
      piercingMulti: piercingMulti ?? this.piercingMulti,
      shopMinimumRate: shopMinimumRate ?? this.shopMinimumRate,
      enableAutomaticHolidayThemes:
          enableAutomaticHolidayThemes ?? this.enableAutomaticHolidayThemes,
      isSpecialMessageEnabled:
          isSpecialMessageEnabled ?? this.isSpecialMessageEnabled,
      shopHoursJson: shopHoursJson ?? this.shopHoursJson,
      taxRate: taxRate ?? this.taxRate,
      depositType: depositType ?? this.depositType,
      depositAmount: depositAmount ?? this.depositAmount,
      bookingBufferMinutes: bookingBufferMinutes ?? this.bookingBufferMinutes,
      cancellationPolicy: cancellationPolicy ?? this.cancellationPolicy,
      appointmentDurationPresetsJson:
          appointmentDurationPresetsJson ?? this.appointmentDurationPresetsJson,
      specialHoursJson: specialHoursJson ?? this.specialHoursJson,
      notificationSettingsJson:
          notificationSettingsJson ?? this.notificationSettingsJson,
      backupSettingsJson: backupSettingsJson ?? this.backupSettingsJson,
      linkedAccountsJson: linkedAccountsJson ?? this.linkedAccountsJson,
      appFontSize: appFontSize ?? this.appFontSize,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (shopName.present) {
      map['shop_name'] = Variable<String>(shopName.value);
    }
    if (logoPath.present) {
      map['logo_path'] = Variable<String>(logoPath.value);
    }
    if (accentColor.present) {
      map['accent_color'] = Variable<String>(accentColor.value);
    }
    if (sidebarArtworkPath.present) {
      map['sidebar_artwork_path'] = Variable<String>(sidebarArtworkPath.value);
    }
    if (specialMessageText.present) {
      map['special_message_text'] = Variable<String>(specialMessageText.value);
    }
    if (loginBackgroundPath.present) {
      map['login_background_path'] = Variable<String>(
        loginBackgroundPath.value,
      );
    }
    if (loginHeadlineFontFamily.present) {
      map['login_headline_font_family'] = Variable<String>(
        loginHeadlineFontFamily.value,
      );
    }
    if (loginTaglineFontFamily.present) {
      map['login_tagline_font_family'] = Variable<String>(
        loginTaglineFontFamily.value,
      );
    }
    if (loginTextColor.present) {
      map['login_text_color'] = Variable<String>(loginTextColor.value);
    }
    if (tattooPerHour.present) {
      map['tattoo_per_hour'] = Variable<double>(tattooPerHour.value);
    }
    if (piercingSingle.present) {
      map['piercing_single'] = Variable<double>(piercingSingle.value);
    }
    if (piercingMulti.present) {
      map['piercing_multi'] = Variable<double>(piercingMulti.value);
    }
    if (shopMinimumRate.present) {
      map['shop_minimum_rate'] = Variable<double>(shopMinimumRate.value);
    }
    if (enableAutomaticHolidayThemes.present) {
      map['enable_automatic_holiday_themes'] = Variable<bool>(
        enableAutomaticHolidayThemes.value,
      );
    }
    if (isSpecialMessageEnabled.present) {
      map['is_special_message_enabled'] = Variable<bool>(
        isSpecialMessageEnabled.value,
      );
    }
    if (shopHoursJson.present) {
      map['shop_hours_json'] = Variable<String>(shopHoursJson.value);
    }
    if (taxRate.present) {
      map['tax_rate'] = Variable<double>(taxRate.value);
    }
    if (depositType.present) {
      map['deposit_type'] = Variable<String>(depositType.value);
    }
    if (depositAmount.present) {
      map['deposit_amount'] = Variable<double>(depositAmount.value);
    }
    if (bookingBufferMinutes.present) {
      map['booking_buffer_minutes'] = Variable<int>(bookingBufferMinutes.value);
    }
    if (cancellationPolicy.present) {
      map['cancellation_policy'] = Variable<String>(cancellationPolicy.value);
    }
    if (appointmentDurationPresetsJson.present) {
      map['appointment_duration_presets_json'] = Variable<String>(
        appointmentDurationPresetsJson.value,
      );
    }
    if (specialHoursJson.present) {
      map['special_hours_json'] = Variable<String>(specialHoursJson.value);
    }
    if (notificationSettingsJson.present) {
      map['notification_settings_json'] = Variable<String>(
        notificationSettingsJson.value,
      );
    }
    if (backupSettingsJson.present) {
      map['backup_settings_json'] = Variable<String>(backupSettingsJson.value);
    }
    if (linkedAccountsJson.present) {
      map['linked_accounts_json'] = Variable<String>(linkedAccountsJson.value);
    }
    if (appFontSize.present) {
      map['app_font_size'] = Variable<double>(appFontSize.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShopSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('shopName: $shopName, ')
          ..write('logoPath: $logoPath, ')
          ..write('accentColor: $accentColor, ')
          ..write('sidebarArtworkPath: $sidebarArtworkPath, ')
          ..write('specialMessageText: $specialMessageText, ')
          ..write('loginBackgroundPath: $loginBackgroundPath, ')
          ..write('loginHeadlineFontFamily: $loginHeadlineFontFamily, ')
          ..write('loginTaglineFontFamily: $loginTaglineFontFamily, ')
          ..write('loginTextColor: $loginTextColor, ')
          ..write('tattooPerHour: $tattooPerHour, ')
          ..write('piercingSingle: $piercingSingle, ')
          ..write('piercingMulti: $piercingMulti, ')
          ..write('shopMinimumRate: $shopMinimumRate, ')
          ..write(
            'enableAutomaticHolidayThemes: $enableAutomaticHolidayThemes, ',
          )
          ..write('isSpecialMessageEnabled: $isSpecialMessageEnabled, ')
          ..write('shopHoursJson: $shopHoursJson, ')
          ..write('taxRate: $taxRate, ')
          ..write('depositType: $depositType, ')
          ..write('depositAmount: $depositAmount, ')
          ..write('bookingBufferMinutes: $bookingBufferMinutes, ')
          ..write('cancellationPolicy: $cancellationPolicy, ')
          ..write(
            'appointmentDurationPresetsJson: $appointmentDurationPresetsJson, ',
          )
          ..write('specialHoursJson: $specialHoursJson, ')
          ..write('notificationSettingsJson: $notificationSettingsJson, ')
          ..write('backupSettingsJson: $backupSettingsJson, ')
          ..write('linkedAccountsJson: $linkedAccountsJson, ')
          ..write('appFontSize: $appFontSize, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AuditLogsTable extends AuditLogs
    with TableInfo<$AuditLogsTable, AuditLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    action,
    entityType,
    entityId,
    userId,
    timestamp,
    details,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      ),
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      ),
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      )!,
    );
  }

  @override
  $AuditLogsTable createAlias(String alias) {
    return $AuditLogsTable(attachedDatabase, alias);
  }
}

class AuditLog extends DataClass implements Insertable<AuditLog> {
  final int id;

  /// Type of action (CREATE, UPDATE, DELETE, LOGIN, etc.)
  final String action;

  /// Entity affected (Client, Appointment, etc.)
  final String? entityType;

  /// ID of the affected entity
  final String? entityId;

  /// User who performed the action
  final int? userId;

  /// When it happened
  final DateTime timestamp;

  /// Additional JSON details
  final String details;
  const AuditLog({
    required this.id,
    required this.action,
    this.entityType,
    this.entityId,
    this.userId,
    required this.timestamp,
    required this.details,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['action'] = Variable<String>(action);
    if (!nullToAbsent || entityType != null) {
      map['entity_type'] = Variable<String>(entityType);
    }
    if (!nullToAbsent || entityId != null) {
      map['entity_id'] = Variable<String>(entityId);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['details'] = Variable<String>(details);
    return map;
  }

  AuditLogsCompanion toCompanion(bool nullToAbsent) {
    return AuditLogsCompanion(
      id: Value(id),
      action: Value(action),
      entityType: entityType == null && nullToAbsent
          ? const Value.absent()
          : Value(entityType),
      entityId: entityId == null && nullToAbsent
          ? const Value.absent()
          : Value(entityId),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      timestamp: Value(timestamp),
      details: Value(details),
    );
  }

  factory AuditLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLog(
      id: serializer.fromJson<int>(json['id']),
      action: serializer.fromJson<String>(json['action']),
      entityType: serializer.fromJson<String?>(json['entityType']),
      entityId: serializer.fromJson<String?>(json['entityId']),
      userId: serializer.fromJson<int?>(json['userId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      details: serializer.fromJson<String>(json['details']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'action': serializer.toJson<String>(action),
      'entityType': serializer.toJson<String?>(entityType),
      'entityId': serializer.toJson<String?>(entityId),
      'userId': serializer.toJson<int?>(userId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'details': serializer.toJson<String>(details),
    };
  }

  AuditLog copyWith({
    int? id,
    String? action,
    Value<String?> entityType = const Value.absent(),
    Value<String?> entityId = const Value.absent(),
    Value<int?> userId = const Value.absent(),
    DateTime? timestamp,
    String? details,
  }) => AuditLog(
    id: id ?? this.id,
    action: action ?? this.action,
    entityType: entityType.present ? entityType.value : this.entityType,
    entityId: entityId.present ? entityId.value : this.entityId,
    userId: userId.present ? userId.value : this.userId,
    timestamp: timestamp ?? this.timestamp,
    details: details ?? this.details,
  );
  AuditLog copyWithCompanion(AuditLogsCompanion data) {
    return AuditLog(
      id: data.id.present ? data.id.value : this.id,
      action: data.action.present ? data.action.value : this.action,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      userId: data.userId.present ? data.userId.value : this.userId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      details: data.details.present ? data.details.value : this.details,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLog(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('userId: $userId, ')
          ..write('timestamp: $timestamp, ')
          ..write('details: $details')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, action, entityType, entityId, userId, timestamp, details);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLog &&
          other.id == this.id &&
          other.action == this.action &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.userId == this.userId &&
          other.timestamp == this.timestamp &&
          other.details == this.details);
}

class AuditLogsCompanion extends UpdateCompanion<AuditLog> {
  final Value<int> id;
  final Value<String> action;
  final Value<String?> entityType;
  final Value<String?> entityId;
  final Value<int?> userId;
  final Value<DateTime> timestamp;
  final Value<String> details;
  const AuditLogsCompanion({
    this.id = const Value.absent(),
    this.action = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.userId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.details = const Value.absent(),
  });
  AuditLogsCompanion.insert({
    this.id = const Value.absent(),
    required String action,
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.userId = const Value.absent(),
    required DateTime timestamp,
    this.details = const Value.absent(),
  }) : action = Value(action),
       timestamp = Value(timestamp);
  static Insertable<AuditLog> custom({
    Expression<int>? id,
    Expression<String>? action,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<int>? userId,
    Expression<DateTime>? timestamp,
    Expression<String>? details,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (action != null) 'action': action,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (userId != null) 'user_id': userId,
      if (timestamp != null) 'timestamp': timestamp,
      if (details != null) 'details': details,
    });
  }

  AuditLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? action,
    Value<String?>? entityType,
    Value<String?>? entityId,
    Value<int?>? userId,
    Value<DateTime>? timestamp,
    Value<String>? details,
  }) {
    return AuditLogsCompanion(
      id: id ?? this.id,
      action: action ?? this.action,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      userId: userId ?? this.userId,
      timestamp: timestamp ?? this.timestamp,
      details: details ?? this.details,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsCompanion(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('userId: $userId, ')
          ..write('timestamp: $timestamp, ')
          ..write('details: $details')
          ..write(')'))
        .toString();
  }
}

class $InventoryItemsTable extends InventoryItems
    with TableInfo<$InventoryItemsTable, InventoryItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
    'sync_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stockQuantityMeta = const VerificationMeta(
    'stockQuantity',
  );
  @override
  late final GeneratedColumn<double> stockQuantity = GeneratedColumn<double>(
    'stock_quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _minimumQuantityMeta = const VerificationMeta(
    'minimumQuantity',
  );
  @override
  late final GeneratedColumn<double> minimumQuantity = GeneratedColumn<double>(
    'minimum_quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierMeta = const VerificationMeta(
    'supplier',
  );
  @override
  late final GeneratedColumn<String> supplier = GeneratedColumn<String>(
    'supplier',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastOrderedAtMeta = const VerificationMeta(
    'lastOrderedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastOrderedAt =
      GeneratedColumn<DateTime>(
        'last_ordered_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    syncId,
    name,
    category,
    stockQuantity,
    minimumQuantity,
    unit,
    supplier,
    lastOrderedAt,
    updatedAt,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sync_id')) {
      context.handle(
        _syncIdMeta,
        syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('stock_quantity')) {
      context.handle(
        _stockQuantityMeta,
        stockQuantity.isAcceptableOrUnknown(
          data['stock_quantity']!,
          _stockQuantityMeta,
        ),
      );
    }
    if (data.containsKey('minimum_quantity')) {
      context.handle(
        _minimumQuantityMeta,
        minimumQuantity.isAcceptableOrUnknown(
          data['minimum_quantity']!,
          _minimumQuantityMeta,
        ),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('supplier')) {
      context.handle(
        _supplierMeta,
        supplier.isAcceptableOrUnknown(data['supplier']!, _supplierMeta),
      );
    }
    if (data.containsKey('last_ordered_at')) {
      context.handle(
        _lastOrderedAtMeta,
        lastOrderedAt.isAcceptableOrUnknown(
          data['last_ordered_at']!,
          _lastOrderedAtMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      syncId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      stockQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stock_quantity'],
      )!,
      minimumQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}minimum_quantity'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      supplier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier'],
      ),
      lastOrderedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_ordered_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $InventoryItemsTable createAlias(String alias) {
    return $InventoryItemsTable(attachedDatabase, alias);
  }
}

class InventoryItem extends DataClass implements Insertable<InventoryItem> {
  final int id;
  final String syncId;
  final String name;
  final String category;
  final double stockQuantity;
  final double minimumQuantity;
  final String unit;
  final String? supplier;
  final DateTime? lastOrderedAt;
  final DateTime updatedAt;
  final bool isDeleted;
  const InventoryItem({
    required this.id,
    required this.syncId,
    required this.name,
    required this.category,
    required this.stockQuantity,
    required this.minimumQuantity,
    required this.unit,
    this.supplier,
    this.lastOrderedAt,
    required this.updatedAt,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_id'] = Variable<String>(syncId);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['stock_quantity'] = Variable<double>(stockQuantity);
    map['minimum_quantity'] = Variable<double>(minimumQuantity);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || supplier != null) {
      map['supplier'] = Variable<String>(supplier);
    }
    if (!nullToAbsent || lastOrderedAt != null) {
      map['last_ordered_at'] = Variable<DateTime>(lastOrderedAt);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  InventoryItemsCompanion toCompanion(bool nullToAbsent) {
    return InventoryItemsCompanion(
      id: Value(id),
      syncId: Value(syncId),
      name: Value(name),
      category: Value(category),
      stockQuantity: Value(stockQuantity),
      minimumQuantity: Value(minimumQuantity),
      unit: Value(unit),
      supplier: supplier == null && nullToAbsent
          ? const Value.absent()
          : Value(supplier),
      lastOrderedAt: lastOrderedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastOrderedAt),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
    );
  }

  factory InventoryItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryItem(
      id: serializer.fromJson<int>(json['id']),
      syncId: serializer.fromJson<String>(json['syncId']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      stockQuantity: serializer.fromJson<double>(json['stockQuantity']),
      minimumQuantity: serializer.fromJson<double>(json['minimumQuantity']),
      unit: serializer.fromJson<String>(json['unit']),
      supplier: serializer.fromJson<String?>(json['supplier']),
      lastOrderedAt: serializer.fromJson<DateTime?>(json['lastOrderedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syncId': serializer.toJson<String>(syncId),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'stockQuantity': serializer.toJson<double>(stockQuantity),
      'minimumQuantity': serializer.toJson<double>(minimumQuantity),
      'unit': serializer.toJson<String>(unit),
      'supplier': serializer.toJson<String?>(supplier),
      'lastOrderedAt': serializer.toJson<DateTime?>(lastOrderedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  InventoryItem copyWith({
    int? id,
    String? syncId,
    String? name,
    String? category,
    double? stockQuantity,
    double? minimumQuantity,
    String? unit,
    Value<String?> supplier = const Value.absent(),
    Value<DateTime?> lastOrderedAt = const Value.absent(),
    DateTime? updatedAt,
    bool? isDeleted,
  }) => InventoryItem(
    id: id ?? this.id,
    syncId: syncId ?? this.syncId,
    name: name ?? this.name,
    category: category ?? this.category,
    stockQuantity: stockQuantity ?? this.stockQuantity,
    minimumQuantity: minimumQuantity ?? this.minimumQuantity,
    unit: unit ?? this.unit,
    supplier: supplier.present ? supplier.value : this.supplier,
    lastOrderedAt: lastOrderedAt.present
        ? lastOrderedAt.value
        : this.lastOrderedAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  InventoryItem copyWithCompanion(InventoryItemsCompanion data) {
    return InventoryItem(
      id: data.id.present ? data.id.value : this.id,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      stockQuantity: data.stockQuantity.present
          ? data.stockQuantity.value
          : this.stockQuantity,
      minimumQuantity: data.minimumQuantity.present
          ? data.minimumQuantity.value
          : this.minimumQuantity,
      unit: data.unit.present ? data.unit.value : this.unit,
      supplier: data.supplier.present ? data.supplier.value : this.supplier,
      lastOrderedAt: data.lastOrderedAt.present
          ? data.lastOrderedAt.value
          : this.lastOrderedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItem(')
          ..write('id: $id, ')
          ..write('syncId: $syncId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('stockQuantity: $stockQuantity, ')
          ..write('minimumQuantity: $minimumQuantity, ')
          ..write('unit: $unit, ')
          ..write('supplier: $supplier, ')
          ..write('lastOrderedAt: $lastOrderedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    syncId,
    name,
    category,
    stockQuantity,
    minimumQuantity,
    unit,
    supplier,
    lastOrderedAt,
    updatedAt,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryItem &&
          other.id == this.id &&
          other.syncId == this.syncId &&
          other.name == this.name &&
          other.category == this.category &&
          other.stockQuantity == this.stockQuantity &&
          other.minimumQuantity == this.minimumQuantity &&
          other.unit == this.unit &&
          other.supplier == this.supplier &&
          other.lastOrderedAt == this.lastOrderedAt &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted);
}

class InventoryItemsCompanion extends UpdateCompanion<InventoryItem> {
  final Value<int> id;
  final Value<String> syncId;
  final Value<String> name;
  final Value<String> category;
  final Value<double> stockQuantity;
  final Value<double> minimumQuantity;
  final Value<String> unit;
  final Value<String?> supplier;
  final Value<DateTime?> lastOrderedAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  const InventoryItemsCompanion({
    this.id = const Value.absent(),
    this.syncId = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.stockQuantity = const Value.absent(),
    this.minimumQuantity = const Value.absent(),
    this.unit = const Value.absent(),
    this.supplier = const Value.absent(),
    this.lastOrderedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  InventoryItemsCompanion.insert({
    this.id = const Value.absent(),
    this.syncId = const Value.absent(),
    required String name,
    required String category,
    this.stockQuantity = const Value.absent(),
    this.minimumQuantity = const Value.absent(),
    required String unit,
    this.supplier = const Value.absent(),
    this.lastOrderedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : name = Value(name),
       category = Value(category),
       unit = Value(unit);
  static Insertable<InventoryItem> custom({
    Expression<int>? id,
    Expression<String>? syncId,
    Expression<String>? name,
    Expression<String>? category,
    Expression<double>? stockQuantity,
    Expression<double>? minimumQuantity,
    Expression<String>? unit,
    Expression<String>? supplier,
    Expression<DateTime>? lastOrderedAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncId != null) 'sync_id': syncId,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (stockQuantity != null) 'stock_quantity': stockQuantity,
      if (minimumQuantity != null) 'minimum_quantity': minimumQuantity,
      if (unit != null) 'unit': unit,
      if (supplier != null) 'supplier': supplier,
      if (lastOrderedAt != null) 'last_ordered_at': lastOrderedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  InventoryItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? syncId,
    Value<String>? name,
    Value<String>? category,
    Value<double>? stockQuantity,
    Value<double>? minimumQuantity,
    Value<String>? unit,
    Value<String?>? supplier,
    Value<DateTime?>? lastOrderedAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
  }) {
    return InventoryItemsCompanion(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      name: name ?? this.name,
      category: category ?? this.category,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      minimumQuantity: minimumQuantity ?? this.minimumQuantity,
      unit: unit ?? this.unit,
      supplier: supplier ?? this.supplier,
      lastOrderedAt: lastOrderedAt ?? this.lastOrderedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (stockQuantity.present) {
      map['stock_quantity'] = Variable<double>(stockQuantity.value);
    }
    if (minimumQuantity.present) {
      map['minimum_quantity'] = Variable<double>(minimumQuantity.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (supplier.present) {
      map['supplier'] = Variable<String>(supplier.value);
    }
    if (lastOrderedAt.present) {
      map['last_ordered_at'] = Variable<DateTime>(lastOrderedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItemsCompanion(')
          ..write('id: $id, ')
          ..write('syncId: $syncId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('stockQuantity: $stockQuantity, ')
          ..write('minimumQuantity: $minimumQuantity, ')
          ..write('unit: $unit, ')
          ..write('supplier: $supplier, ')
          ..write('lastOrderedAt: $lastOrderedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $CommunicationsTableTable extends CommunicationsTable
    with TableInfo<$CommunicationsTableTable, CommunicationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommunicationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
    'sync_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
    'client_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clientNameMeta = const VerificationMeta(
    'clientName',
  );
  @override
  late final GeneratedColumn<String> clientName = GeneratedColumn<String>(
    'client_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _directionMeta = const VerificationMeta(
    'direction',
  );
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
    'direction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sentAtMeta = const VerificationMeta('sentAt');
  @override
  late final GeneratedColumn<DateTime> sentAt = GeneratedColumn<DateTime>(
    'sent_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('SENT'),
  );
  static const VerificationMeta _lastModifiedUtcMeta = const VerificationMeta(
    'lastModifiedUtc',
  );
  @override
  late final GeneratedColumn<DateTime> lastModifiedUtc =
      GeneratedColumn<DateTime>(
        'last_modified_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  static const VerificationMeta _lastModifiedByMeta = const VerificationMeta(
    'lastModifiedBy',
  );
  @override
  late final GeneratedColumn<String> lastModifiedBy = GeneratedColumn<String>(
    'last_modified_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    syncId,
    clientId,
    clientName,
    type,
    direction,
    content,
    sentAt,
    status,
    lastModifiedUtc,
    lastModifiedBy,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'communications_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CommunicationsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sync_id')) {
      context.handle(
        _syncIdMeta,
        syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta),
      );
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    }
    if (data.containsKey('client_name')) {
      context.handle(
        _clientNameMeta,
        clientName.isAcceptableOrUnknown(data['client_name']!, _clientNameMeta),
      );
    } else if (isInserting) {
      context.missing(_clientNameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(
        _directionMeta,
        direction.isAcceptableOrUnknown(data['direction']!, _directionMeta),
      );
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('sent_at')) {
      context.handle(
        _sentAtMeta,
        sentAt.isAcceptableOrUnknown(data['sent_at']!, _sentAtMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('last_modified_utc')) {
      context.handle(
        _lastModifiedUtcMeta,
        lastModifiedUtc.isAcceptableOrUnknown(
          data['last_modified_utc']!,
          _lastModifiedUtcMeta,
        ),
      );
    }
    if (data.containsKey('last_modified_by')) {
      context.handle(
        _lastModifiedByMeta,
        lastModifiedBy.isAcceptableOrUnknown(
          data['last_modified_by']!,
          _lastModifiedByMeta,
        ),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommunicationsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommunicationsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      syncId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      ),
      clientName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      direction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direction'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      sentAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sent_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      lastModifiedUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_modified_utc'],
      )!,
      lastModifiedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_modified_by'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $CommunicationsTableTable createAlias(String alias) {
    return $CommunicationsTableTable(attachedDatabase, alias);
  }
}

class CommunicationsTableData extends DataClass
    implements Insertable<CommunicationsTableData> {
  final int id;
  final String syncId;
  final int? clientId;
  final String clientName;
  final String type;
  final String direction;
  final String content;
  final DateTime sentAt;
  final String status;
  final DateTime lastModifiedUtc;
  final String lastModifiedBy;
  final bool isDeleted;
  const CommunicationsTableData({
    required this.id,
    required this.syncId,
    this.clientId,
    required this.clientName,
    required this.type,
    required this.direction,
    required this.content,
    required this.sentAt,
    required this.status,
    required this.lastModifiedUtc,
    required this.lastModifiedBy,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_id'] = Variable<String>(syncId);
    if (!nullToAbsent || clientId != null) {
      map['client_id'] = Variable<int>(clientId);
    }
    map['client_name'] = Variable<String>(clientName);
    map['type'] = Variable<String>(type);
    map['direction'] = Variable<String>(direction);
    map['content'] = Variable<String>(content);
    map['sent_at'] = Variable<DateTime>(sentAt);
    map['status'] = Variable<String>(status);
    map['last_modified_utc'] = Variable<DateTime>(lastModifiedUtc);
    map['last_modified_by'] = Variable<String>(lastModifiedBy);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  CommunicationsTableCompanion toCompanion(bool nullToAbsent) {
    return CommunicationsTableCompanion(
      id: Value(id),
      syncId: Value(syncId),
      clientId: clientId == null && nullToAbsent
          ? const Value.absent()
          : Value(clientId),
      clientName: Value(clientName),
      type: Value(type),
      direction: Value(direction),
      content: Value(content),
      sentAt: Value(sentAt),
      status: Value(status),
      lastModifiedUtc: Value(lastModifiedUtc),
      lastModifiedBy: Value(lastModifiedBy),
      isDeleted: Value(isDeleted),
    );
  }

  factory CommunicationsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommunicationsTableData(
      id: serializer.fromJson<int>(json['id']),
      syncId: serializer.fromJson<String>(json['syncId']),
      clientId: serializer.fromJson<int?>(json['clientId']),
      clientName: serializer.fromJson<String>(json['clientName']),
      type: serializer.fromJson<String>(json['type']),
      direction: serializer.fromJson<String>(json['direction']),
      content: serializer.fromJson<String>(json['content']),
      sentAt: serializer.fromJson<DateTime>(json['sentAt']),
      status: serializer.fromJson<String>(json['status']),
      lastModifiedUtc: serializer.fromJson<DateTime>(json['lastModifiedUtc']),
      lastModifiedBy: serializer.fromJson<String>(json['lastModifiedBy']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syncId': serializer.toJson<String>(syncId),
      'clientId': serializer.toJson<int?>(clientId),
      'clientName': serializer.toJson<String>(clientName),
      'type': serializer.toJson<String>(type),
      'direction': serializer.toJson<String>(direction),
      'content': serializer.toJson<String>(content),
      'sentAt': serializer.toJson<DateTime>(sentAt),
      'status': serializer.toJson<String>(status),
      'lastModifiedUtc': serializer.toJson<DateTime>(lastModifiedUtc),
      'lastModifiedBy': serializer.toJson<String>(lastModifiedBy),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  CommunicationsTableData copyWith({
    int? id,
    String? syncId,
    Value<int?> clientId = const Value.absent(),
    String? clientName,
    String? type,
    String? direction,
    String? content,
    DateTime? sentAt,
    String? status,
    DateTime? lastModifiedUtc,
    String? lastModifiedBy,
    bool? isDeleted,
  }) => CommunicationsTableData(
    id: id ?? this.id,
    syncId: syncId ?? this.syncId,
    clientId: clientId.present ? clientId.value : this.clientId,
    clientName: clientName ?? this.clientName,
    type: type ?? this.type,
    direction: direction ?? this.direction,
    content: content ?? this.content,
    sentAt: sentAt ?? this.sentAt,
    status: status ?? this.status,
    lastModifiedUtc: lastModifiedUtc ?? this.lastModifiedUtc,
    lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  CommunicationsTableData copyWithCompanion(CommunicationsTableCompanion data) {
    return CommunicationsTableData(
      id: data.id.present ? data.id.value : this.id,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      clientName: data.clientName.present
          ? data.clientName.value
          : this.clientName,
      type: data.type.present ? data.type.value : this.type,
      direction: data.direction.present ? data.direction.value : this.direction,
      content: data.content.present ? data.content.value : this.content,
      sentAt: data.sentAt.present ? data.sentAt.value : this.sentAt,
      status: data.status.present ? data.status.value : this.status,
      lastModifiedUtc: data.lastModifiedUtc.present
          ? data.lastModifiedUtc.value
          : this.lastModifiedUtc,
      lastModifiedBy: data.lastModifiedBy.present
          ? data.lastModifiedBy.value
          : this.lastModifiedBy,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CommunicationsTableData(')
          ..write('id: $id, ')
          ..write('syncId: $syncId, ')
          ..write('clientId: $clientId, ')
          ..write('clientName: $clientName, ')
          ..write('type: $type, ')
          ..write('direction: $direction, ')
          ..write('content: $content, ')
          ..write('sentAt: $sentAt, ')
          ..write('status: $status, ')
          ..write('lastModifiedUtc: $lastModifiedUtc, ')
          ..write('lastModifiedBy: $lastModifiedBy, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    syncId,
    clientId,
    clientName,
    type,
    direction,
    content,
    sentAt,
    status,
    lastModifiedUtc,
    lastModifiedBy,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommunicationsTableData &&
          other.id == this.id &&
          other.syncId == this.syncId &&
          other.clientId == this.clientId &&
          other.clientName == this.clientName &&
          other.type == this.type &&
          other.direction == this.direction &&
          other.content == this.content &&
          other.sentAt == this.sentAt &&
          other.status == this.status &&
          other.lastModifiedUtc == this.lastModifiedUtc &&
          other.lastModifiedBy == this.lastModifiedBy &&
          other.isDeleted == this.isDeleted);
}

class CommunicationsTableCompanion
    extends UpdateCompanion<CommunicationsTableData> {
  final Value<int> id;
  final Value<String> syncId;
  final Value<int?> clientId;
  final Value<String> clientName;
  final Value<String> type;
  final Value<String> direction;
  final Value<String> content;
  final Value<DateTime> sentAt;
  final Value<String> status;
  final Value<DateTime> lastModifiedUtc;
  final Value<String> lastModifiedBy;
  final Value<bool> isDeleted;
  const CommunicationsTableCompanion({
    this.id = const Value.absent(),
    this.syncId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.clientName = const Value.absent(),
    this.type = const Value.absent(),
    this.direction = const Value.absent(),
    this.content = const Value.absent(),
    this.sentAt = const Value.absent(),
    this.status = const Value.absent(),
    this.lastModifiedUtc = const Value.absent(),
    this.lastModifiedBy = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  CommunicationsTableCompanion.insert({
    this.id = const Value.absent(),
    this.syncId = const Value.absent(),
    this.clientId = const Value.absent(),
    required String clientName,
    required String type,
    required String direction,
    required String content,
    this.sentAt = const Value.absent(),
    this.status = const Value.absent(),
    this.lastModifiedUtc = const Value.absent(),
    this.lastModifiedBy = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : clientName = Value(clientName),
       type = Value(type),
       direction = Value(direction),
       content = Value(content);
  static Insertable<CommunicationsTableData> custom({
    Expression<int>? id,
    Expression<String>? syncId,
    Expression<int>? clientId,
    Expression<String>? clientName,
    Expression<String>? type,
    Expression<String>? direction,
    Expression<String>? content,
    Expression<DateTime>? sentAt,
    Expression<String>? status,
    Expression<DateTime>? lastModifiedUtc,
    Expression<String>? lastModifiedBy,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncId != null) 'sync_id': syncId,
      if (clientId != null) 'client_id': clientId,
      if (clientName != null) 'client_name': clientName,
      if (type != null) 'type': type,
      if (direction != null) 'direction': direction,
      if (content != null) 'content': content,
      if (sentAt != null) 'sent_at': sentAt,
      if (status != null) 'status': status,
      if (lastModifiedUtc != null) 'last_modified_utc': lastModifiedUtc,
      if (lastModifiedBy != null) 'last_modified_by': lastModifiedBy,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  CommunicationsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? syncId,
    Value<int?>? clientId,
    Value<String>? clientName,
    Value<String>? type,
    Value<String>? direction,
    Value<String>? content,
    Value<DateTime>? sentAt,
    Value<String>? status,
    Value<DateTime>? lastModifiedUtc,
    Value<String>? lastModifiedBy,
    Value<bool>? isDeleted,
  }) {
    return CommunicationsTableCompanion(
      id: id ?? this.id,
      syncId: syncId ?? this.syncId,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      type: type ?? this.type,
      direction: direction ?? this.direction,
      content: content ?? this.content,
      sentAt: sentAt ?? this.sentAt,
      status: status ?? this.status,
      lastModifiedUtc: lastModifiedUtc ?? this.lastModifiedUtc,
      lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (clientName.present) {
      map['client_name'] = Variable<String>(clientName.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (sentAt.present) {
      map['sent_at'] = Variable<DateTime>(sentAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (lastModifiedUtc.present) {
      map['last_modified_utc'] = Variable<DateTime>(lastModifiedUtc.value);
    }
    if (lastModifiedBy.present) {
      map['last_modified_by'] = Variable<String>(lastModifiedBy.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommunicationsTableCompanion(')
          ..write('id: $id, ')
          ..write('syncId: $syncId, ')
          ..write('clientId: $clientId, ')
          ..write('clientName: $clientName, ')
          ..write('type: $type, ')
          ..write('direction: $direction, ')
          ..write('content: $content, ')
          ..write('sentAt: $sentAt, ')
          ..write('status: $status, ')
          ..write('lastModifiedUtc: $lastModifiedUtc, ')
          ..write('lastModifiedBy: $lastModifiedBy, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientsTable clients = $ClientsTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $AppointmentsTable appointments = $AppointmentsTable(this);
  late final $QuotesTable quotes = $QuotesTable(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  late final $ShopSettingsTableTable shopSettingsTable =
      $ShopSettingsTableTable(this);
  late final $AuditLogsTable auditLogs = $AuditLogsTable(this);
  late final $InventoryItemsTable inventoryItems = $InventoryItemsTable(this);
  late final $CommunicationsTableTable communicationsTable =
      $CommunicationsTableTable(this);
  late final ClientsDao clientsDao = ClientsDao(this as AppDatabase);
  late final UsersDao usersDao = UsersDao(this as AppDatabase);
  late final AppointmentsDao appointmentsDao = AppointmentsDao(
    this as AppDatabase,
  );
  late final QuotesDao quotesDao = QuotesDao(this as AppDatabase);
  late final DocumentsDao documentsDao = DocumentsDao(this as AppDatabase);
  late final ShopSettingsDao shopSettingsDao = ShopSettingsDao(
    this as AppDatabase,
  );
  late final AuditLogsDao auditLogsDao = AuditLogsDao(this as AppDatabase);
  late final InventoryDao inventoryDao = InventoryDao(this as AppDatabase);
  late final CommunicationsDao communicationsDao = CommunicationsDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    clients,
    users,
    appointments,
    quotes,
    documents,
    shopSettingsTable,
    auditLogs,
    inventoryItems,
    communicationsTable,
  ];
}

typedef $$ClientsTableCreateCompanionBuilder =
    ClientsCompanion Function({
      Value<int> id,
      required String syncId,
      required String firstName,
      Value<String> middleName,
      required String lastName,
      Value<String> phone,
      Value<String> email,
      Value<String> notes,
      Value<int> visits,
      Value<String> photoPath,
      Value<String> status,
      required DateTime lastModifiedUtc,
      Value<String> lastModifiedBy,
      Value<bool> isDeleted,
    });
typedef $$ClientsTableUpdateCompanionBuilder =
    ClientsCompanion Function({
      Value<int> id,
      Value<String> syncId,
      Value<String> firstName,
      Value<String> middleName,
      Value<String> lastName,
      Value<String> phone,
      Value<String> email,
      Value<String> notes,
      Value<int> visits,
      Value<String> photoPath,
      Value<String> status,
      Value<DateTime> lastModifiedUtc,
      Value<String> lastModifiedBy,
      Value<bool> isDeleted,
    });

class $$ClientsTableFilterComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncId => $composableBuilder(
    column: $table.syncId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get visits => $composableBuilder(
    column: $table.visits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastModifiedUtc => $composableBuilder(
    column: $table.lastModifiedUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastModifiedBy => $composableBuilder(
    column: $table.lastModifiedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ClientsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncId => $composableBuilder(
    column: $table.syncId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get visits => $composableBuilder(
    column: $table.visits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastModifiedUtc => $composableBuilder(
    column: $table.lastModifiedUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastModifiedBy => $composableBuilder(
    column: $table.lastModifiedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get visits =>
      $composableBuilder(column: $table.visits, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedUtc => $composableBuilder(
    column: $table.lastModifiedUtc,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastModifiedBy => $composableBuilder(
    column: $table.lastModifiedBy,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$ClientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientsTable,
          Client,
          $$ClientsTableFilterComposer,
          $$ClientsTableOrderingComposer,
          $$ClientsTableAnnotationComposer,
          $$ClientsTableCreateCompanionBuilder,
          $$ClientsTableUpdateCompanionBuilder,
          (Client, BaseReferences<_$AppDatabase, $ClientsTable, Client>),
          Client,
          PrefetchHooks Function()
        > {
  $$ClientsTableTableManager(_$AppDatabase db, $ClientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> syncId = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> middleName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> visits = const Value.absent(),
                Value<String> photoPath = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> lastModifiedUtc = const Value.absent(),
                Value<String> lastModifiedBy = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => ClientsCompanion(
                id: id,
                syncId: syncId,
                firstName: firstName,
                middleName: middleName,
                lastName: lastName,
                phone: phone,
                email: email,
                notes: notes,
                visits: visits,
                photoPath: photoPath,
                status: status,
                lastModifiedUtc: lastModifiedUtc,
                lastModifiedBy: lastModifiedBy,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String syncId,
                required String firstName,
                Value<String> middleName = const Value.absent(),
                required String lastName,
                Value<String> phone = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> visits = const Value.absent(),
                Value<String> photoPath = const Value.absent(),
                Value<String> status = const Value.absent(),
                required DateTime lastModifiedUtc,
                Value<String> lastModifiedBy = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => ClientsCompanion.insert(
                id: id,
                syncId: syncId,
                firstName: firstName,
                middleName: middleName,
                lastName: lastName,
                phone: phone,
                email: email,
                notes: notes,
                visits: visits,
                photoPath: photoPath,
                status: status,
                lastModifiedUtc: lastModifiedUtc,
                lastModifiedBy: lastModifiedBy,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientsTable,
      Client,
      $$ClientsTableFilterComposer,
      $$ClientsTableOrderingComposer,
      $$ClientsTableAnnotationComposer,
      $$ClientsTableCreateCompanionBuilder,
      $$ClientsTableUpdateCompanionBuilder,
      (Client, BaseReferences<_$AppDatabase, $ClientsTable, Client>),
      Client,
      PrefetchHooks Function()
    >;
typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String username,
      Value<String> displayName,
      Value<String> passwordHash,
      Value<String> role,
      Value<String> themeKey,
      Value<String> avatarPath,
      Value<double> hourlyRate,
      Value<double> speedFactor,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> lastLoginAt,
      Value<bool> isActive,
      Value<bool> isDeleted,
      Value<DateTime?> deletedAt,
      Value<String> department,
      Value<double> commissionRate,
      Value<int> fontSize,
      Value<String> keyboardShortcutsJson,
      Value<String> permissionsJson,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> username,
      Value<String> displayName,
      Value<String> passwordHash,
      Value<String> role,
      Value<String> themeKey,
      Value<String> avatarPath,
      Value<double> hourlyRate,
      Value<double> speedFactor,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> lastLoginAt,
      Value<bool> isActive,
      Value<bool> isDeleted,
      Value<DateTime?> deletedAt,
      Value<String> department,
      Value<double> commissionRate,
      Value<int> fontSize,
      Value<String> keyboardShortcutsJson,
      Value<String> permissionsJson,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeKey => $composableBuilder(
    column: $table.themeKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hourlyRate => $composableBuilder(
    column: $table.hourlyRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get speedFactor => $composableBuilder(
    column: $table.speedFactor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastLoginAt => $composableBuilder(
    column: $table.lastLoginAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get commissionRate => $composableBuilder(
    column: $table.commissionRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fontSize => $composableBuilder(
    column: $table.fontSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get keyboardShortcutsJson => $composableBuilder(
    column: $table.keyboardShortcutsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get permissionsJson => $composableBuilder(
    column: $table.permissionsJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeKey => $composableBuilder(
    column: $table.themeKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hourlyRate => $composableBuilder(
    column: $table.hourlyRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get speedFactor => $composableBuilder(
    column: $table.speedFactor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastLoginAt => $composableBuilder(
    column: $table.lastLoginAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get commissionRate => $composableBuilder(
    column: $table.commissionRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fontSize => $composableBuilder(
    column: $table.fontSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keyboardShortcutsJson => $composableBuilder(
    column: $table.keyboardShortcutsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get permissionsJson => $composableBuilder(
    column: $table.permissionsJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get themeKey =>
      $composableBuilder(column: $table.themeKey, builder: (column) => column);

  GeneratedColumn<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => column,
  );

  GeneratedColumn<double> get hourlyRate => $composableBuilder(
    column: $table.hourlyRate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get speedFactor => $composableBuilder(
    column: $table.speedFactor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastLoginAt => $composableBuilder(
    column: $table.lastLoginAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => column,
  );

  GeneratedColumn<double> get commissionRate => $composableBuilder(
    column: $table.commissionRate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fontSize =>
      $composableBuilder(column: $table.fontSize, builder: (column) => column);

  GeneratedColumn<String> get keyboardShortcutsJson => $composableBuilder(
    column: $table.keyboardShortcutsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get permissionsJson => $composableBuilder(
    column: $table.permissionsJson,
    builder: (column) => column,
  );
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> passwordHash = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> themeKey = const Value.absent(),
                Value<String> avatarPath = const Value.absent(),
                Value<double> hourlyRate = const Value.absent(),
                Value<double> speedFactor = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> lastLoginAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> department = const Value.absent(),
                Value<double> commissionRate = const Value.absent(),
                Value<int> fontSize = const Value.absent(),
                Value<String> keyboardShortcutsJson = const Value.absent(),
                Value<String> permissionsJson = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                username: username,
                displayName: displayName,
                passwordHash: passwordHash,
                role: role,
                themeKey: themeKey,
                avatarPath: avatarPath,
                hourlyRate: hourlyRate,
                speedFactor: speedFactor,
                createdAt: createdAt,
                updatedAt: updatedAt,
                lastLoginAt: lastLoginAt,
                isActive: isActive,
                isDeleted: isDeleted,
                deletedAt: deletedAt,
                department: department,
                commissionRate: commissionRate,
                fontSize: fontSize,
                keyboardShortcutsJson: keyboardShortcutsJson,
                permissionsJson: permissionsJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String username,
                Value<String> displayName = const Value.absent(),
                Value<String> passwordHash = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> themeKey = const Value.absent(),
                Value<String> avatarPath = const Value.absent(),
                Value<double> hourlyRate = const Value.absent(),
                Value<double> speedFactor = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> lastLoginAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> department = const Value.absent(),
                Value<double> commissionRate = const Value.absent(),
                Value<int> fontSize = const Value.absent(),
                Value<String> keyboardShortcutsJson = const Value.absent(),
                Value<String> permissionsJson = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                username: username,
                displayName: displayName,
                passwordHash: passwordHash,
                role: role,
                themeKey: themeKey,
                avatarPath: avatarPath,
                hourlyRate: hourlyRate,
                speedFactor: speedFactor,
                createdAt: createdAt,
                updatedAt: updatedAt,
                lastLoginAt: lastLoginAt,
                isActive: isActive,
                isDeleted: isDeleted,
                deletedAt: deletedAt,
                department: department,
                commissionRate: commissionRate,
                fontSize: fontSize,
                keyboardShortcutsJson: keyboardShortcutsJson,
                permissionsJson: permissionsJson,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;
typedef $$AppointmentsTableCreateCompanionBuilder =
    AppointmentsCompanion Function({
      Value<int> id,
      required String syncId,
      required int clientId,
      required int userId,
      Value<String> clientName,
      required DateTime startTime,
      required int durationMinutes,
      Value<String> serviceType,
      Value<String> serviceCategory,
      Value<String> priceType,
      Value<double> priceCharged,
      Value<double?> quotedPrice,
      Value<double?> finalPrice,
      Value<String?> notes,
      Value<String?> photoPath,
      Value<String> color,
      Value<String> status,
      Value<bool> isBlockOff,
      required DateTime modifiedAt,
      Value<String> lastModifiedBy,
      Value<bool> isDeleted,
    });
typedef $$AppointmentsTableUpdateCompanionBuilder =
    AppointmentsCompanion Function({
      Value<int> id,
      Value<String> syncId,
      Value<int> clientId,
      Value<int> userId,
      Value<String> clientName,
      Value<DateTime> startTime,
      Value<int> durationMinutes,
      Value<String> serviceType,
      Value<String> serviceCategory,
      Value<String> priceType,
      Value<double> priceCharged,
      Value<double?> quotedPrice,
      Value<double?> finalPrice,
      Value<String?> notes,
      Value<String?> photoPath,
      Value<String> color,
      Value<String> status,
      Value<bool> isBlockOff,
      Value<DateTime> modifiedAt,
      Value<String> lastModifiedBy,
      Value<bool> isDeleted,
    });

class $$AppointmentsTableFilterComposer
    extends Composer<_$AppDatabase, $AppointmentsTable> {
  $$AppointmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncId => $composableBuilder(
    column: $table.syncId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceType => $composableBuilder(
    column: $table.serviceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceCategory => $composableBuilder(
    column: $table.serviceCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priceType => $composableBuilder(
    column: $table.priceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get priceCharged => $composableBuilder(
    column: $table.priceCharged,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quotedPrice => $composableBuilder(
    column: $table.quotedPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get finalPrice => $composableBuilder(
    column: $table.finalPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBlockOff => $composableBuilder(
    column: $table.isBlockOff,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastModifiedBy => $composableBuilder(
    column: $table.lastModifiedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppointmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppointmentsTable> {
  $$AppointmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncId => $composableBuilder(
    column: $table.syncId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceType => $composableBuilder(
    column: $table.serviceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceCategory => $composableBuilder(
    column: $table.serviceCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priceType => $composableBuilder(
    column: $table.priceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get priceCharged => $composableBuilder(
    column: $table.priceCharged,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quotedPrice => $composableBuilder(
    column: $table.quotedPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get finalPrice => $composableBuilder(
    column: $table.finalPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBlockOff => $composableBuilder(
    column: $table.isBlockOff,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastModifiedBy => $composableBuilder(
    column: $table.lastModifiedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppointmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppointmentsTable> {
  $$AppointmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<int> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serviceType => $composableBuilder(
    column: $table.serviceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serviceCategory => $composableBuilder(
    column: $table.serviceCategory,
    builder: (column) => column,
  );

  GeneratedColumn<String> get priceType =>
      $composableBuilder(column: $table.priceType, builder: (column) => column);

  GeneratedColumn<double> get priceCharged => $composableBuilder(
    column: $table.priceCharged,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quotedPrice => $composableBuilder(
    column: $table.quotedPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get finalPrice => $composableBuilder(
    column: $table.finalPrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get isBlockOff => $composableBuilder(
    column: $table.isBlockOff,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastModifiedBy => $composableBuilder(
    column: $table.lastModifiedBy,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$AppointmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppointmentsTable,
          Appointment,
          $$AppointmentsTableFilterComposer,
          $$AppointmentsTableOrderingComposer,
          $$AppointmentsTableAnnotationComposer,
          $$AppointmentsTableCreateCompanionBuilder,
          $$AppointmentsTableUpdateCompanionBuilder,
          (
            Appointment,
            BaseReferences<_$AppDatabase, $AppointmentsTable, Appointment>,
          ),
          Appointment,
          PrefetchHooks Function()
        > {
  $$AppointmentsTableTableManager(_$AppDatabase db, $AppointmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppointmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppointmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppointmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> syncId = const Value.absent(),
                Value<int> clientId = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> clientName = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
                Value<String> serviceType = const Value.absent(),
                Value<String> serviceCategory = const Value.absent(),
                Value<String> priceType = const Value.absent(),
                Value<double> priceCharged = const Value.absent(),
                Value<double?> quotedPrice = const Value.absent(),
                Value<double?> finalPrice = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<String> color = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> isBlockOff = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
                Value<String> lastModifiedBy = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => AppointmentsCompanion(
                id: id,
                syncId: syncId,
                clientId: clientId,
                userId: userId,
                clientName: clientName,
                startTime: startTime,
                durationMinutes: durationMinutes,
                serviceType: serviceType,
                serviceCategory: serviceCategory,
                priceType: priceType,
                priceCharged: priceCharged,
                quotedPrice: quotedPrice,
                finalPrice: finalPrice,
                notes: notes,
                photoPath: photoPath,
                color: color,
                status: status,
                isBlockOff: isBlockOff,
                modifiedAt: modifiedAt,
                lastModifiedBy: lastModifiedBy,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String syncId,
                required int clientId,
                required int userId,
                Value<String> clientName = const Value.absent(),
                required DateTime startTime,
                required int durationMinutes,
                Value<String> serviceType = const Value.absent(),
                Value<String> serviceCategory = const Value.absent(),
                Value<String> priceType = const Value.absent(),
                Value<double> priceCharged = const Value.absent(),
                Value<double?> quotedPrice = const Value.absent(),
                Value<double?> finalPrice = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<String> color = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> isBlockOff = const Value.absent(),
                required DateTime modifiedAt,
                Value<String> lastModifiedBy = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => AppointmentsCompanion.insert(
                id: id,
                syncId: syncId,
                clientId: clientId,
                userId: userId,
                clientName: clientName,
                startTime: startTime,
                durationMinutes: durationMinutes,
                serviceType: serviceType,
                serviceCategory: serviceCategory,
                priceType: priceType,
                priceCharged: priceCharged,
                quotedPrice: quotedPrice,
                finalPrice: finalPrice,
                notes: notes,
                photoPath: photoPath,
                color: color,
                status: status,
                isBlockOff: isBlockOff,
                modifiedAt: modifiedAt,
                lastModifiedBy: lastModifiedBy,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppointmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppointmentsTable,
      Appointment,
      $$AppointmentsTableFilterComposer,
      $$AppointmentsTableOrderingComposer,
      $$AppointmentsTableAnnotationComposer,
      $$AppointmentsTableCreateCompanionBuilder,
      $$AppointmentsTableUpdateCompanionBuilder,
      (
        Appointment,
        BaseReferences<_$AppDatabase, $AppointmentsTable, Appointment>,
      ),
      Appointment,
      PrefetchHooks Function()
    >;
typedef $$QuotesTableCreateCompanionBuilder =
    QuotesCompanion Function({
      Value<int> id,
      Value<int?> clientId,
      required int artistId,
      Value<String> placement,
      Value<String> style,
      Value<bool> isCoverUp,
      Value<double> width,
      Value<double> height,
      Value<int> coverageLevel,
      Value<int> lineComplexity,
      Value<int> shadingComplexity,
      Value<int> colorComplexity,
      Value<int> difficulty,
      Value<double> estimatedHoursLow,
      Value<double> estimatedHoursHigh,
      Value<double> priceLow,
      Value<double> priceHigh,
      Value<double> shopMinimum,
      Value<double> recommendedDeposit,
      Value<double> confidenceScore,
      Value<int> similarJobsCount,
      Value<String?> notes,
      Value<String?> photoPath,
      required DateTime createdAt,
    });
typedef $$QuotesTableUpdateCompanionBuilder =
    QuotesCompanion Function({
      Value<int> id,
      Value<int?> clientId,
      Value<int> artistId,
      Value<String> placement,
      Value<String> style,
      Value<bool> isCoverUp,
      Value<double> width,
      Value<double> height,
      Value<int> coverageLevel,
      Value<int> lineComplexity,
      Value<int> shadingComplexity,
      Value<int> colorComplexity,
      Value<int> difficulty,
      Value<double> estimatedHoursLow,
      Value<double> estimatedHoursHigh,
      Value<double> priceLow,
      Value<double> priceHigh,
      Value<double> shopMinimum,
      Value<double> recommendedDeposit,
      Value<double> confidenceScore,
      Value<int> similarJobsCount,
      Value<String?> notes,
      Value<String?> photoPath,
      Value<DateTime> createdAt,
    });

class $$QuotesTableFilterComposer
    extends Composer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get artistId => $composableBuilder(
    column: $table.artistId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get placement => $composableBuilder(
    column: $table.placement,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get style => $composableBuilder(
    column: $table.style,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCoverUp => $composableBuilder(
    column: $table.isCoverUp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get coverageLevel => $composableBuilder(
    column: $table.coverageLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineComplexity => $composableBuilder(
    column: $table.lineComplexity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get shadingComplexity => $composableBuilder(
    column: $table.shadingComplexity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorComplexity => $composableBuilder(
    column: $table.colorComplexity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estimatedHoursLow => $composableBuilder(
    column: $table.estimatedHoursLow,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estimatedHoursHigh => $composableBuilder(
    column: $table.estimatedHoursHigh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get priceLow => $composableBuilder(
    column: $table.priceLow,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get priceHigh => $composableBuilder(
    column: $table.priceHigh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get shopMinimum => $composableBuilder(
    column: $table.shopMinimum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get recommendedDeposit => $composableBuilder(
    column: $table.recommendedDeposit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidenceScore => $composableBuilder(
    column: $table.confidenceScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get similarJobsCount => $composableBuilder(
    column: $table.similarJobsCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$QuotesTableOrderingComposer
    extends Composer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get artistId => $composableBuilder(
    column: $table.artistId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get placement => $composableBuilder(
    column: $table.placement,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get style => $composableBuilder(
    column: $table.style,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCoverUp => $composableBuilder(
    column: $table.isCoverUp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coverageLevel => $composableBuilder(
    column: $table.coverageLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineComplexity => $composableBuilder(
    column: $table.lineComplexity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get shadingComplexity => $composableBuilder(
    column: $table.shadingComplexity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorComplexity => $composableBuilder(
    column: $table.colorComplexity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estimatedHoursLow => $composableBuilder(
    column: $table.estimatedHoursLow,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estimatedHoursHigh => $composableBuilder(
    column: $table.estimatedHoursHigh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get priceLow => $composableBuilder(
    column: $table.priceLow,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get priceHigh => $composableBuilder(
    column: $table.priceHigh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get shopMinimum => $composableBuilder(
    column: $table.shopMinimum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get recommendedDeposit => $composableBuilder(
    column: $table.recommendedDeposit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidenceScore => $composableBuilder(
    column: $table.confidenceScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get similarJobsCount => $composableBuilder(
    column: $table.similarJobsCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<int> get artistId =>
      $composableBuilder(column: $table.artistId, builder: (column) => column);

  GeneratedColumn<String> get placement =>
      $composableBuilder(column: $table.placement, builder: (column) => column);

  GeneratedColumn<String> get style =>
      $composableBuilder(column: $table.style, builder: (column) => column);

  GeneratedColumn<bool> get isCoverUp =>
      $composableBuilder(column: $table.isCoverUp, builder: (column) => column);

  GeneratedColumn<double> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<int> get coverageLevel => $composableBuilder(
    column: $table.coverageLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lineComplexity => $composableBuilder(
    column: $table.lineComplexity,
    builder: (column) => column,
  );

  GeneratedColumn<int> get shadingComplexity => $composableBuilder(
    column: $table.shadingComplexity,
    builder: (column) => column,
  );

  GeneratedColumn<int> get colorComplexity => $composableBuilder(
    column: $table.colorComplexity,
    builder: (column) => column,
  );

  GeneratedColumn<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<double> get estimatedHoursLow => $composableBuilder(
    column: $table.estimatedHoursLow,
    builder: (column) => column,
  );

  GeneratedColumn<double> get estimatedHoursHigh => $composableBuilder(
    column: $table.estimatedHoursHigh,
    builder: (column) => column,
  );

  GeneratedColumn<double> get priceLow =>
      $composableBuilder(column: $table.priceLow, builder: (column) => column);

  GeneratedColumn<double> get priceHigh =>
      $composableBuilder(column: $table.priceHigh, builder: (column) => column);

  GeneratedColumn<double> get shopMinimum => $composableBuilder(
    column: $table.shopMinimum,
    builder: (column) => column,
  );

  GeneratedColumn<double> get recommendedDeposit => $composableBuilder(
    column: $table.recommendedDeposit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get confidenceScore => $composableBuilder(
    column: $table.confidenceScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get similarJobsCount => $composableBuilder(
    column: $table.similarJobsCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$QuotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuotesTable,
          Quote,
          $$QuotesTableFilterComposer,
          $$QuotesTableOrderingComposer,
          $$QuotesTableAnnotationComposer,
          $$QuotesTableCreateCompanionBuilder,
          $$QuotesTableUpdateCompanionBuilder,
          (Quote, BaseReferences<_$AppDatabase, $QuotesTable, Quote>),
          Quote,
          PrefetchHooks Function()
        > {
  $$QuotesTableTableManager(_$AppDatabase db, $QuotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> clientId = const Value.absent(),
                Value<int> artistId = const Value.absent(),
                Value<String> placement = const Value.absent(),
                Value<String> style = const Value.absent(),
                Value<bool> isCoverUp = const Value.absent(),
                Value<double> width = const Value.absent(),
                Value<double> height = const Value.absent(),
                Value<int> coverageLevel = const Value.absent(),
                Value<int> lineComplexity = const Value.absent(),
                Value<int> shadingComplexity = const Value.absent(),
                Value<int> colorComplexity = const Value.absent(),
                Value<int> difficulty = const Value.absent(),
                Value<double> estimatedHoursLow = const Value.absent(),
                Value<double> estimatedHoursHigh = const Value.absent(),
                Value<double> priceLow = const Value.absent(),
                Value<double> priceHigh = const Value.absent(),
                Value<double> shopMinimum = const Value.absent(),
                Value<double> recommendedDeposit = const Value.absent(),
                Value<double> confidenceScore = const Value.absent(),
                Value<int> similarJobsCount = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => QuotesCompanion(
                id: id,
                clientId: clientId,
                artistId: artistId,
                placement: placement,
                style: style,
                isCoverUp: isCoverUp,
                width: width,
                height: height,
                coverageLevel: coverageLevel,
                lineComplexity: lineComplexity,
                shadingComplexity: shadingComplexity,
                colorComplexity: colorComplexity,
                difficulty: difficulty,
                estimatedHoursLow: estimatedHoursLow,
                estimatedHoursHigh: estimatedHoursHigh,
                priceLow: priceLow,
                priceHigh: priceHigh,
                shopMinimum: shopMinimum,
                recommendedDeposit: recommendedDeposit,
                confidenceScore: confidenceScore,
                similarJobsCount: similarJobsCount,
                notes: notes,
                photoPath: photoPath,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> clientId = const Value.absent(),
                required int artistId,
                Value<String> placement = const Value.absent(),
                Value<String> style = const Value.absent(),
                Value<bool> isCoverUp = const Value.absent(),
                Value<double> width = const Value.absent(),
                Value<double> height = const Value.absent(),
                Value<int> coverageLevel = const Value.absent(),
                Value<int> lineComplexity = const Value.absent(),
                Value<int> shadingComplexity = const Value.absent(),
                Value<int> colorComplexity = const Value.absent(),
                Value<int> difficulty = const Value.absent(),
                Value<double> estimatedHoursLow = const Value.absent(),
                Value<double> estimatedHoursHigh = const Value.absent(),
                Value<double> priceLow = const Value.absent(),
                Value<double> priceHigh = const Value.absent(),
                Value<double> shopMinimum = const Value.absent(),
                Value<double> recommendedDeposit = const Value.absent(),
                Value<double> confidenceScore = const Value.absent(),
                Value<int> similarJobsCount = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                required DateTime createdAt,
              }) => QuotesCompanion.insert(
                id: id,
                clientId: clientId,
                artistId: artistId,
                placement: placement,
                style: style,
                isCoverUp: isCoverUp,
                width: width,
                height: height,
                coverageLevel: coverageLevel,
                lineComplexity: lineComplexity,
                shadingComplexity: shadingComplexity,
                colorComplexity: colorComplexity,
                difficulty: difficulty,
                estimatedHoursLow: estimatedHoursLow,
                estimatedHoursHigh: estimatedHoursHigh,
                priceLow: priceLow,
                priceHigh: priceHigh,
                shopMinimum: shopMinimum,
                recommendedDeposit: recommendedDeposit,
                confidenceScore: confidenceScore,
                similarJobsCount: similarJobsCount,
                notes: notes,
                photoPath: photoPath,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$QuotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuotesTable,
      Quote,
      $$QuotesTableFilterComposer,
      $$QuotesTableOrderingComposer,
      $$QuotesTableAnnotationComposer,
      $$QuotesTableCreateCompanionBuilder,
      $$QuotesTableUpdateCompanionBuilder,
      (Quote, BaseReferences<_$AppDatabase, $QuotesTable, Quote>),
      Quote,
      PrefetchHooks Function()
    >;
typedef $$DocumentsTableCreateCompanionBuilder =
    DocumentsCompanion Function({
      Value<int> id,
      required String syncId,
      required int uploadedByUserId,
      required int clientId,
      required String title,
      required String filePath,
      required DateTime createdAt,
      required DateTime lastModifiedUtc,
      Value<String> lastModifiedBy,
      Value<bool> isDeleted,
    });
typedef $$DocumentsTableUpdateCompanionBuilder =
    DocumentsCompanion Function({
      Value<int> id,
      Value<String> syncId,
      Value<int> uploadedByUserId,
      Value<int> clientId,
      Value<String> title,
      Value<String> filePath,
      Value<DateTime> createdAt,
      Value<DateTime> lastModifiedUtc,
      Value<String> lastModifiedBy,
      Value<bool> isDeleted,
    });

class $$DocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncId => $composableBuilder(
    column: $table.syncId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get uploadedByUserId => $composableBuilder(
    column: $table.uploadedByUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastModifiedUtc => $composableBuilder(
    column: $table.lastModifiedUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastModifiedBy => $composableBuilder(
    column: $table.lastModifiedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncId => $composableBuilder(
    column: $table.syncId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get uploadedByUserId => $composableBuilder(
    column: $table.uploadedByUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastModifiedUtc => $composableBuilder(
    column: $table.lastModifiedUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastModifiedBy => $composableBuilder(
    column: $table.lastModifiedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<int> get uploadedByUserId => $composableBuilder(
    column: $table.uploadedByUserId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedUtc => $composableBuilder(
    column: $table.lastModifiedUtc,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastModifiedBy => $composableBuilder(
    column: $table.lastModifiedBy,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$DocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentsTable,
          Document,
          $$DocumentsTableFilterComposer,
          $$DocumentsTableOrderingComposer,
          $$DocumentsTableAnnotationComposer,
          $$DocumentsTableCreateCompanionBuilder,
          $$DocumentsTableUpdateCompanionBuilder,
          (Document, BaseReferences<_$AppDatabase, $DocumentsTable, Document>),
          Document,
          PrefetchHooks Function()
        > {
  $$DocumentsTableTableManager(_$AppDatabase db, $DocumentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> syncId = const Value.absent(),
                Value<int> uploadedByUserId = const Value.absent(),
                Value<int> clientId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> lastModifiedUtc = const Value.absent(),
                Value<String> lastModifiedBy = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => DocumentsCompanion(
                id: id,
                syncId: syncId,
                uploadedByUserId: uploadedByUserId,
                clientId: clientId,
                title: title,
                filePath: filePath,
                createdAt: createdAt,
                lastModifiedUtc: lastModifiedUtc,
                lastModifiedBy: lastModifiedBy,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String syncId,
                required int uploadedByUserId,
                required int clientId,
                required String title,
                required String filePath,
                required DateTime createdAt,
                required DateTime lastModifiedUtc,
                Value<String> lastModifiedBy = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => DocumentsCompanion.insert(
                id: id,
                syncId: syncId,
                uploadedByUserId: uploadedByUserId,
                clientId: clientId,
                title: title,
                filePath: filePath,
                createdAt: createdAt,
                lastModifiedUtc: lastModifiedUtc,
                lastModifiedBy: lastModifiedBy,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentsTable,
      Document,
      $$DocumentsTableFilterComposer,
      $$DocumentsTableOrderingComposer,
      $$DocumentsTableAnnotationComposer,
      $$DocumentsTableCreateCompanionBuilder,
      $$DocumentsTableUpdateCompanionBuilder,
      (Document, BaseReferences<_$AppDatabase, $DocumentsTable, Document>),
      Document,
      PrefetchHooks Function()
    >;
typedef $$ShopSettingsTableTableCreateCompanionBuilder =
    ShopSettingsTableCompanion Function({
      Value<int> id,
      Value<String> shopName,
      Value<String> logoPath,
      Value<String> accentColor,
      Value<String> sidebarArtworkPath,
      Value<String> specialMessageText,
      Value<String> loginBackgroundPath,
      Value<String> loginHeadlineFontFamily,
      Value<String> loginTaglineFontFamily,
      Value<String> loginTextColor,
      Value<double> tattooPerHour,
      Value<double> piercingSingle,
      Value<double> piercingMulti,
      Value<double> shopMinimumRate,
      Value<bool> enableAutomaticHolidayThemes,
      Value<bool> isSpecialMessageEnabled,
      Value<String> shopHoursJson,
      Value<double> taxRate,
      Value<String> depositType,
      Value<double> depositAmount,
      Value<int> bookingBufferMinutes,
      Value<String> cancellationPolicy,
      Value<String> appointmentDurationPresetsJson,
      Value<String> specialHoursJson,
      Value<String> notificationSettingsJson,
      Value<String> backupSettingsJson,
      Value<String> linkedAccountsJson,
      Value<double> appFontSize,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$ShopSettingsTableTableUpdateCompanionBuilder =
    ShopSettingsTableCompanion Function({
      Value<int> id,
      Value<String> shopName,
      Value<String> logoPath,
      Value<String> accentColor,
      Value<String> sidebarArtworkPath,
      Value<String> specialMessageText,
      Value<String> loginBackgroundPath,
      Value<String> loginHeadlineFontFamily,
      Value<String> loginTaglineFontFamily,
      Value<String> loginTextColor,
      Value<double> tattooPerHour,
      Value<double> piercingSingle,
      Value<double> piercingMulti,
      Value<double> shopMinimumRate,
      Value<bool> enableAutomaticHolidayThemes,
      Value<bool> isSpecialMessageEnabled,
      Value<String> shopHoursJson,
      Value<double> taxRate,
      Value<String> depositType,
      Value<double> depositAmount,
      Value<int> bookingBufferMinutes,
      Value<String> cancellationPolicy,
      Value<String> appointmentDurationPresetsJson,
      Value<String> specialHoursJson,
      Value<String> notificationSettingsJson,
      Value<String> backupSettingsJson,
      Value<String> linkedAccountsJson,
      Value<double> appFontSize,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$ShopSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ShopSettingsTableTable> {
  $$ShopSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopName => $composableBuilder(
    column: $table.shopName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accentColor => $composableBuilder(
    column: $table.accentColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sidebarArtworkPath => $composableBuilder(
    column: $table.sidebarArtworkPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get specialMessageText => $composableBuilder(
    column: $table.specialMessageText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loginBackgroundPath => $composableBuilder(
    column: $table.loginBackgroundPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loginHeadlineFontFamily => $composableBuilder(
    column: $table.loginHeadlineFontFamily,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loginTaglineFontFamily => $composableBuilder(
    column: $table.loginTaglineFontFamily,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loginTextColor => $composableBuilder(
    column: $table.loginTextColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tattooPerHour => $composableBuilder(
    column: $table.tattooPerHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get piercingSingle => $composableBuilder(
    column: $table.piercingSingle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get piercingMulti => $composableBuilder(
    column: $table.piercingMulti,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get shopMinimumRate => $composableBuilder(
    column: $table.shopMinimumRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enableAutomaticHolidayThemes => $composableBuilder(
    column: $table.enableAutomaticHolidayThemes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSpecialMessageEnabled => $composableBuilder(
    column: $table.isSpecialMessageEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopHoursJson => $composableBuilder(
    column: $table.shopHoursJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxRate => $composableBuilder(
    column: $table.taxRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get depositType => $composableBuilder(
    column: $table.depositType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get depositAmount => $composableBuilder(
    column: $table.depositAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bookingBufferMinutes => $composableBuilder(
    column: $table.bookingBufferMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cancellationPolicy => $composableBuilder(
    column: $table.cancellationPolicy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appointmentDurationPresetsJson =>
      $composableBuilder(
        column: $table.appointmentDurationPresetsJson,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get specialHoursJson => $composableBuilder(
    column: $table.specialHoursJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notificationSettingsJson => $composableBuilder(
    column: $table.notificationSettingsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backupSettingsJson => $composableBuilder(
    column: $table.backupSettingsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get linkedAccountsJson => $composableBuilder(
    column: $table.linkedAccountsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get appFontSize => $composableBuilder(
    column: $table.appFontSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShopSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ShopSettingsTableTable> {
  $$ShopSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopName => $composableBuilder(
    column: $table.shopName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accentColor => $composableBuilder(
    column: $table.accentColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sidebarArtworkPath => $composableBuilder(
    column: $table.sidebarArtworkPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get specialMessageText => $composableBuilder(
    column: $table.specialMessageText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loginBackgroundPath => $composableBuilder(
    column: $table.loginBackgroundPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loginHeadlineFontFamily => $composableBuilder(
    column: $table.loginHeadlineFontFamily,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loginTaglineFontFamily => $composableBuilder(
    column: $table.loginTaglineFontFamily,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loginTextColor => $composableBuilder(
    column: $table.loginTextColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tattooPerHour => $composableBuilder(
    column: $table.tattooPerHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get piercingSingle => $composableBuilder(
    column: $table.piercingSingle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get piercingMulti => $composableBuilder(
    column: $table.piercingMulti,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get shopMinimumRate => $composableBuilder(
    column: $table.shopMinimumRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enableAutomaticHolidayThemes => $composableBuilder(
    column: $table.enableAutomaticHolidayThemes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSpecialMessageEnabled => $composableBuilder(
    column: $table.isSpecialMessageEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopHoursJson => $composableBuilder(
    column: $table.shopHoursJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxRate => $composableBuilder(
    column: $table.taxRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get depositType => $composableBuilder(
    column: $table.depositType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get depositAmount => $composableBuilder(
    column: $table.depositAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bookingBufferMinutes => $composableBuilder(
    column: $table.bookingBufferMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cancellationPolicy => $composableBuilder(
    column: $table.cancellationPolicy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appointmentDurationPresetsJson =>
      $composableBuilder(
        column: $table.appointmentDurationPresetsJson,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get specialHoursJson => $composableBuilder(
    column: $table.specialHoursJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notificationSettingsJson => $composableBuilder(
    column: $table.notificationSettingsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backupSettingsJson => $composableBuilder(
    column: $table.backupSettingsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get linkedAccountsJson => $composableBuilder(
    column: $table.linkedAccountsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get appFontSize => $composableBuilder(
    column: $table.appFontSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShopSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShopSettingsTableTable> {
  $$ShopSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopName =>
      $composableBuilder(column: $table.shopName, builder: (column) => column);

  GeneratedColumn<String> get logoPath =>
      $composableBuilder(column: $table.logoPath, builder: (column) => column);

  GeneratedColumn<String> get accentColor => $composableBuilder(
    column: $table.accentColor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sidebarArtworkPath => $composableBuilder(
    column: $table.sidebarArtworkPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get specialMessageText => $composableBuilder(
    column: $table.specialMessageText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get loginBackgroundPath => $composableBuilder(
    column: $table.loginBackgroundPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get loginHeadlineFontFamily => $composableBuilder(
    column: $table.loginHeadlineFontFamily,
    builder: (column) => column,
  );

  GeneratedColumn<String> get loginTaglineFontFamily => $composableBuilder(
    column: $table.loginTaglineFontFamily,
    builder: (column) => column,
  );

  GeneratedColumn<String> get loginTextColor => $composableBuilder(
    column: $table.loginTextColor,
    builder: (column) => column,
  );

  GeneratedColumn<double> get tattooPerHour => $composableBuilder(
    column: $table.tattooPerHour,
    builder: (column) => column,
  );

  GeneratedColumn<double> get piercingSingle => $composableBuilder(
    column: $table.piercingSingle,
    builder: (column) => column,
  );

  GeneratedColumn<double> get piercingMulti => $composableBuilder(
    column: $table.piercingMulti,
    builder: (column) => column,
  );

  GeneratedColumn<double> get shopMinimumRate => $composableBuilder(
    column: $table.shopMinimumRate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enableAutomaticHolidayThemes => $composableBuilder(
    column: $table.enableAutomaticHolidayThemes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSpecialMessageEnabled => $composableBuilder(
    column: $table.isSpecialMessageEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get shopHoursJson => $composableBuilder(
    column: $table.shopHoursJson,
    builder: (column) => column,
  );

  GeneratedColumn<double> get taxRate =>
      $composableBuilder(column: $table.taxRate, builder: (column) => column);

  GeneratedColumn<String> get depositType => $composableBuilder(
    column: $table.depositType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get depositAmount => $composableBuilder(
    column: $table.depositAmount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bookingBufferMinutes => $composableBuilder(
    column: $table.bookingBufferMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cancellationPolicy => $composableBuilder(
    column: $table.cancellationPolicy,
    builder: (column) => column,
  );

  GeneratedColumn<String> get appointmentDurationPresetsJson =>
      $composableBuilder(
        column: $table.appointmentDurationPresetsJson,
        builder: (column) => column,
      );

  GeneratedColumn<String> get specialHoursJson => $composableBuilder(
    column: $table.specialHoursJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notificationSettingsJson => $composableBuilder(
    column: $table.notificationSettingsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get backupSettingsJson => $composableBuilder(
    column: $table.backupSettingsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get linkedAccountsJson => $composableBuilder(
    column: $table.linkedAccountsJson,
    builder: (column) => column,
  );

  GeneratedColumn<double> get appFontSize => $composableBuilder(
    column: $table.appFontSize,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ShopSettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShopSettingsTableTable,
          ShopSettingsTableData,
          $$ShopSettingsTableTableFilterComposer,
          $$ShopSettingsTableTableOrderingComposer,
          $$ShopSettingsTableTableAnnotationComposer,
          $$ShopSettingsTableTableCreateCompanionBuilder,
          $$ShopSettingsTableTableUpdateCompanionBuilder,
          (
            ShopSettingsTableData,
            BaseReferences<
              _$AppDatabase,
              $ShopSettingsTableTable,
              ShopSettingsTableData
            >,
          ),
          ShopSettingsTableData,
          PrefetchHooks Function()
        > {
  $$ShopSettingsTableTableTableManager(
    _$AppDatabase db,
    $ShopSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShopSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShopSettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShopSettingsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> shopName = const Value.absent(),
                Value<String> logoPath = const Value.absent(),
                Value<String> accentColor = const Value.absent(),
                Value<String> sidebarArtworkPath = const Value.absent(),
                Value<String> specialMessageText = const Value.absent(),
                Value<String> loginBackgroundPath = const Value.absent(),
                Value<String> loginHeadlineFontFamily = const Value.absent(),
                Value<String> loginTaglineFontFamily = const Value.absent(),
                Value<String> loginTextColor = const Value.absent(),
                Value<double> tattooPerHour = const Value.absent(),
                Value<double> piercingSingle = const Value.absent(),
                Value<double> piercingMulti = const Value.absent(),
                Value<double> shopMinimumRate = const Value.absent(),
                Value<bool> enableAutomaticHolidayThemes = const Value.absent(),
                Value<bool> isSpecialMessageEnabled = const Value.absent(),
                Value<String> shopHoursJson = const Value.absent(),
                Value<double> taxRate = const Value.absent(),
                Value<String> depositType = const Value.absent(),
                Value<double> depositAmount = const Value.absent(),
                Value<int> bookingBufferMinutes = const Value.absent(),
                Value<String> cancellationPolicy = const Value.absent(),
                Value<String> appointmentDurationPresetsJson =
                    const Value.absent(),
                Value<String> specialHoursJson = const Value.absent(),
                Value<String> notificationSettingsJson = const Value.absent(),
                Value<String> backupSettingsJson = const Value.absent(),
                Value<String> linkedAccountsJson = const Value.absent(),
                Value<double> appFontSize = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ShopSettingsTableCompanion(
                id: id,
                shopName: shopName,
                logoPath: logoPath,
                accentColor: accentColor,
                sidebarArtworkPath: sidebarArtworkPath,
                specialMessageText: specialMessageText,
                loginBackgroundPath: loginBackgroundPath,
                loginHeadlineFontFamily: loginHeadlineFontFamily,
                loginTaglineFontFamily: loginTaglineFontFamily,
                loginTextColor: loginTextColor,
                tattooPerHour: tattooPerHour,
                piercingSingle: piercingSingle,
                piercingMulti: piercingMulti,
                shopMinimumRate: shopMinimumRate,
                enableAutomaticHolidayThemes: enableAutomaticHolidayThemes,
                isSpecialMessageEnabled: isSpecialMessageEnabled,
                shopHoursJson: shopHoursJson,
                taxRate: taxRate,
                depositType: depositType,
                depositAmount: depositAmount,
                bookingBufferMinutes: bookingBufferMinutes,
                cancellationPolicy: cancellationPolicy,
                appointmentDurationPresetsJson: appointmentDurationPresetsJson,
                specialHoursJson: specialHoursJson,
                notificationSettingsJson: notificationSettingsJson,
                backupSettingsJson: backupSettingsJson,
                linkedAccountsJson: linkedAccountsJson,
                appFontSize: appFontSize,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> shopName = const Value.absent(),
                Value<String> logoPath = const Value.absent(),
                Value<String> accentColor = const Value.absent(),
                Value<String> sidebarArtworkPath = const Value.absent(),
                Value<String> specialMessageText = const Value.absent(),
                Value<String> loginBackgroundPath = const Value.absent(),
                Value<String> loginHeadlineFontFamily = const Value.absent(),
                Value<String> loginTaglineFontFamily = const Value.absent(),
                Value<String> loginTextColor = const Value.absent(),
                Value<double> tattooPerHour = const Value.absent(),
                Value<double> piercingSingle = const Value.absent(),
                Value<double> piercingMulti = const Value.absent(),
                Value<double> shopMinimumRate = const Value.absent(),
                Value<bool> enableAutomaticHolidayThemes = const Value.absent(),
                Value<bool> isSpecialMessageEnabled = const Value.absent(),
                Value<String> shopHoursJson = const Value.absent(),
                Value<double> taxRate = const Value.absent(),
                Value<String> depositType = const Value.absent(),
                Value<double> depositAmount = const Value.absent(),
                Value<int> bookingBufferMinutes = const Value.absent(),
                Value<String> cancellationPolicy = const Value.absent(),
                Value<String> appointmentDurationPresetsJson =
                    const Value.absent(),
                Value<String> specialHoursJson = const Value.absent(),
                Value<String> notificationSettingsJson = const Value.absent(),
                Value<String> backupSettingsJson = const Value.absent(),
                Value<String> linkedAccountsJson = const Value.absent(),
                Value<double> appFontSize = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => ShopSettingsTableCompanion.insert(
                id: id,
                shopName: shopName,
                logoPath: logoPath,
                accentColor: accentColor,
                sidebarArtworkPath: sidebarArtworkPath,
                specialMessageText: specialMessageText,
                loginBackgroundPath: loginBackgroundPath,
                loginHeadlineFontFamily: loginHeadlineFontFamily,
                loginTaglineFontFamily: loginTaglineFontFamily,
                loginTextColor: loginTextColor,
                tattooPerHour: tattooPerHour,
                piercingSingle: piercingSingle,
                piercingMulti: piercingMulti,
                shopMinimumRate: shopMinimumRate,
                enableAutomaticHolidayThemes: enableAutomaticHolidayThemes,
                isSpecialMessageEnabled: isSpecialMessageEnabled,
                shopHoursJson: shopHoursJson,
                taxRate: taxRate,
                depositType: depositType,
                depositAmount: depositAmount,
                bookingBufferMinutes: bookingBufferMinutes,
                cancellationPolicy: cancellationPolicy,
                appointmentDurationPresetsJson: appointmentDurationPresetsJson,
                specialHoursJson: specialHoursJson,
                notificationSettingsJson: notificationSettingsJson,
                backupSettingsJson: backupSettingsJson,
                linkedAccountsJson: linkedAccountsJson,
                appFontSize: appFontSize,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShopSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShopSettingsTableTable,
      ShopSettingsTableData,
      $$ShopSettingsTableTableFilterComposer,
      $$ShopSettingsTableTableOrderingComposer,
      $$ShopSettingsTableTableAnnotationComposer,
      $$ShopSettingsTableTableCreateCompanionBuilder,
      $$ShopSettingsTableTableUpdateCompanionBuilder,
      (
        ShopSettingsTableData,
        BaseReferences<
          _$AppDatabase,
          $ShopSettingsTableTable,
          ShopSettingsTableData
        >,
      ),
      ShopSettingsTableData,
      PrefetchHooks Function()
    >;
typedef $$AuditLogsTableCreateCompanionBuilder =
    AuditLogsCompanion Function({
      Value<int> id,
      required String action,
      Value<String?> entityType,
      Value<String?> entityId,
      Value<int?> userId,
      required DateTime timestamp,
      Value<String> details,
    });
typedef $$AuditLogsTableUpdateCompanionBuilder =
    AuditLogsCompanion Function({
      Value<int> id,
      Value<String> action,
      Value<String?> entityType,
      Value<String?> entityId,
      Value<int?> userId,
      Value<DateTime> timestamp,
      Value<String> details,
    });

class $$AuditLogsTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);
}

class $$AuditLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditLogsTable,
          AuditLog,
          $$AuditLogsTableFilterComposer,
          $$AuditLogsTableOrderingComposer,
          $$AuditLogsTableAnnotationComposer,
          $$AuditLogsTableCreateCompanionBuilder,
          $$AuditLogsTableUpdateCompanionBuilder,
          (AuditLog, BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>),
          AuditLog,
          PrefetchHooks Function()
        > {
  $$AuditLogsTableTableManager(_$AppDatabase db, $AuditLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String?> entityType = const Value.absent(),
                Value<String?> entityId = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> details = const Value.absent(),
              }) => AuditLogsCompanion(
                id: id,
                action: action,
                entityType: entityType,
                entityId: entityId,
                userId: userId,
                timestamp: timestamp,
                details: details,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String action,
                Value<String?> entityType = const Value.absent(),
                Value<String?> entityId = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                required DateTime timestamp,
                Value<String> details = const Value.absent(),
              }) => AuditLogsCompanion.insert(
                id: id,
                action: action,
                entityType: entityType,
                entityId: entityId,
                userId: userId,
                timestamp: timestamp,
                details: details,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditLogsTable,
      AuditLog,
      $$AuditLogsTableFilterComposer,
      $$AuditLogsTableOrderingComposer,
      $$AuditLogsTableAnnotationComposer,
      $$AuditLogsTableCreateCompanionBuilder,
      $$AuditLogsTableUpdateCompanionBuilder,
      (AuditLog, BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>),
      AuditLog,
      PrefetchHooks Function()
    >;
typedef $$InventoryItemsTableCreateCompanionBuilder =
    InventoryItemsCompanion Function({
      Value<int> id,
      Value<String> syncId,
      required String name,
      required String category,
      Value<double> stockQuantity,
      Value<double> minimumQuantity,
      required String unit,
      Value<String?> supplier,
      Value<DateTime?> lastOrderedAt,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
    });
typedef $$InventoryItemsTableUpdateCompanionBuilder =
    InventoryItemsCompanion Function({
      Value<int> id,
      Value<String> syncId,
      Value<String> name,
      Value<String> category,
      Value<double> stockQuantity,
      Value<double> minimumQuantity,
      Value<String> unit,
      Value<String?> supplier,
      Value<DateTime?> lastOrderedAt,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
    });

class $$InventoryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncId => $composableBuilder(
    column: $table.syncId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get minimumQuantity => $composableBuilder(
    column: $table.minimumQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplier => $composableBuilder(
    column: $table.supplier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastOrderedAt => $composableBuilder(
    column: $table.lastOrderedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InventoryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncId => $composableBuilder(
    column: $table.syncId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get minimumQuantity => $composableBuilder(
    column: $table.minimumQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplier => $composableBuilder(
    column: $table.supplier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastOrderedAt => $composableBuilder(
    column: $table.lastOrderedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InventoryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<double> get minimumQuantity => $composableBuilder(
    column: $table.minimumQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get supplier =>
      $composableBuilder(column: $table.supplier, builder: (column) => column);

  GeneratedColumn<DateTime> get lastOrderedAt => $composableBuilder(
    column: $table.lastOrderedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$InventoryItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryItemsTable,
          InventoryItem,
          $$InventoryItemsTableFilterComposer,
          $$InventoryItemsTableOrderingComposer,
          $$InventoryItemsTableAnnotationComposer,
          $$InventoryItemsTableCreateCompanionBuilder,
          $$InventoryItemsTableUpdateCompanionBuilder,
          (
            InventoryItem,
            BaseReferences<_$AppDatabase, $InventoryItemsTable, InventoryItem>,
          ),
          InventoryItem,
          PrefetchHooks Function()
        > {
  $$InventoryItemsTableTableManager(
    _$AppDatabase db,
    $InventoryItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> syncId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double> stockQuantity = const Value.absent(),
                Value<double> minimumQuantity = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String?> supplier = const Value.absent(),
                Value<DateTime?> lastOrderedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => InventoryItemsCompanion(
                id: id,
                syncId: syncId,
                name: name,
                category: category,
                stockQuantity: stockQuantity,
                minimumQuantity: minimumQuantity,
                unit: unit,
                supplier: supplier,
                lastOrderedAt: lastOrderedAt,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> syncId = const Value.absent(),
                required String name,
                required String category,
                Value<double> stockQuantity = const Value.absent(),
                Value<double> minimumQuantity = const Value.absent(),
                required String unit,
                Value<String?> supplier = const Value.absent(),
                Value<DateTime?> lastOrderedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => InventoryItemsCompanion.insert(
                id: id,
                syncId: syncId,
                name: name,
                category: category,
                stockQuantity: stockQuantity,
                minimumQuantity: minimumQuantity,
                unit: unit,
                supplier: supplier,
                lastOrderedAt: lastOrderedAt,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InventoryItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryItemsTable,
      InventoryItem,
      $$InventoryItemsTableFilterComposer,
      $$InventoryItemsTableOrderingComposer,
      $$InventoryItemsTableAnnotationComposer,
      $$InventoryItemsTableCreateCompanionBuilder,
      $$InventoryItemsTableUpdateCompanionBuilder,
      (
        InventoryItem,
        BaseReferences<_$AppDatabase, $InventoryItemsTable, InventoryItem>,
      ),
      InventoryItem,
      PrefetchHooks Function()
    >;
typedef $$CommunicationsTableTableCreateCompanionBuilder =
    CommunicationsTableCompanion Function({
      Value<int> id,
      Value<String> syncId,
      Value<int?> clientId,
      required String clientName,
      required String type,
      required String direction,
      required String content,
      Value<DateTime> sentAt,
      Value<String> status,
      Value<DateTime> lastModifiedUtc,
      Value<String> lastModifiedBy,
      Value<bool> isDeleted,
    });
typedef $$CommunicationsTableTableUpdateCompanionBuilder =
    CommunicationsTableCompanion Function({
      Value<int> id,
      Value<String> syncId,
      Value<int?> clientId,
      Value<String> clientName,
      Value<String> type,
      Value<String> direction,
      Value<String> content,
      Value<DateTime> sentAt,
      Value<String> status,
      Value<DateTime> lastModifiedUtc,
      Value<String> lastModifiedBy,
      Value<bool> isDeleted,
    });

class $$CommunicationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $CommunicationsTableTable> {
  $$CommunicationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncId => $composableBuilder(
    column: $table.syncId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastModifiedUtc => $composableBuilder(
    column: $table.lastModifiedUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastModifiedBy => $composableBuilder(
    column: $table.lastModifiedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CommunicationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CommunicationsTableTable> {
  $$CommunicationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncId => $composableBuilder(
    column: $table.syncId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastModifiedUtc => $composableBuilder(
    column: $table.lastModifiedUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastModifiedBy => $composableBuilder(
    column: $table.lastModifiedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CommunicationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CommunicationsTableTable> {
  $$CommunicationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<int> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get sentAt =>
      $composableBuilder(column: $table.sentAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModifiedUtc => $composableBuilder(
    column: $table.lastModifiedUtc,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastModifiedBy => $composableBuilder(
    column: $table.lastModifiedBy,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$CommunicationsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CommunicationsTableTable,
          CommunicationsTableData,
          $$CommunicationsTableTableFilterComposer,
          $$CommunicationsTableTableOrderingComposer,
          $$CommunicationsTableTableAnnotationComposer,
          $$CommunicationsTableTableCreateCompanionBuilder,
          $$CommunicationsTableTableUpdateCompanionBuilder,
          (
            CommunicationsTableData,
            BaseReferences<
              _$AppDatabase,
              $CommunicationsTableTable,
              CommunicationsTableData
            >,
          ),
          CommunicationsTableData,
          PrefetchHooks Function()
        > {
  $$CommunicationsTableTableTableManager(
    _$AppDatabase db,
    $CommunicationsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommunicationsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommunicationsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CommunicationsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> syncId = const Value.absent(),
                Value<int?> clientId = const Value.absent(),
                Value<String> clientName = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> direction = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DateTime> sentAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> lastModifiedUtc = const Value.absent(),
                Value<String> lastModifiedBy = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => CommunicationsTableCompanion(
                id: id,
                syncId: syncId,
                clientId: clientId,
                clientName: clientName,
                type: type,
                direction: direction,
                content: content,
                sentAt: sentAt,
                status: status,
                lastModifiedUtc: lastModifiedUtc,
                lastModifiedBy: lastModifiedBy,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> syncId = const Value.absent(),
                Value<int?> clientId = const Value.absent(),
                required String clientName,
                required String type,
                required String direction,
                required String content,
                Value<DateTime> sentAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> lastModifiedUtc = const Value.absent(),
                Value<String> lastModifiedBy = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => CommunicationsTableCompanion.insert(
                id: id,
                syncId: syncId,
                clientId: clientId,
                clientName: clientName,
                type: type,
                direction: direction,
                content: content,
                sentAt: sentAt,
                status: status,
                lastModifiedUtc: lastModifiedUtc,
                lastModifiedBy: lastModifiedBy,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CommunicationsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CommunicationsTableTable,
      CommunicationsTableData,
      $$CommunicationsTableTableFilterComposer,
      $$CommunicationsTableTableOrderingComposer,
      $$CommunicationsTableTableAnnotationComposer,
      $$CommunicationsTableTableCreateCompanionBuilder,
      $$CommunicationsTableTableUpdateCompanionBuilder,
      (
        CommunicationsTableData,
        BaseReferences<
          _$AppDatabase,
          $CommunicationsTableTable,
          CommunicationsTableData
        >,
      ),
      CommunicationsTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$AppointmentsTableTableManager get appointments =>
      $$AppointmentsTableTableManager(_db, _db.appointments);
  $$QuotesTableTableManager get quotes =>
      $$QuotesTableTableManager(_db, _db.quotes);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
  $$ShopSettingsTableTableTableManager get shopSettingsTable =>
      $$ShopSettingsTableTableTableManager(_db, _db.shopSettingsTable);
  $$AuditLogsTableTableManager get auditLogs =>
      $$AuditLogsTableTableManager(_db, _db.auditLogs);
  $$InventoryItemsTableTableManager get inventoryItems =>
      $$InventoryItemsTableTableManager(_db, _db.inventoryItems);
  $$CommunicationsTableTableTableManager get communicationsTable =>
      $$CommunicationsTableTableTableManager(_db, _db.communicationsTable);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(database)
final databaseProvider = DatabaseProvider._();

final class DatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  DatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'databaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$databaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return database(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$databaseHash() => r'e5a1fa0e8ff9aa131f847f28519ec2098e6d0f76';
