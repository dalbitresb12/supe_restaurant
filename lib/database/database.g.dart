// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class Restaurant extends DataClass implements Insertable<Restaurant> {
  final int id;
  final String title;
  final String poster;
  const Restaurant(
      {required this.id, required this.title, required this.poster});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['poster'] = Variable<String>(poster);
    return map;
  }

  RestaurantsCompanion toCompanion(bool nullToAbsent) {
    return RestaurantsCompanion(
      id: Value(id),
      title: Value(title),
      poster: Value(poster),
    );
  }

  factory Restaurant.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Restaurant(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      poster: serializer.fromJson<String>(json['poster']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'poster': serializer.toJson<String>(poster),
    };
  }

  Restaurant copyWith({int? id, String? title, String? poster}) => Restaurant(
        id: id ?? this.id,
        title: title ?? this.title,
        poster: poster ?? this.poster,
      );
  @override
  String toString() {
    return (StringBuffer('Restaurant(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('poster: $poster')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, poster);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Restaurant &&
          other.id == this.id &&
          other.title == this.title &&
          other.poster == this.poster);
}

class RestaurantsCompanion extends UpdateCompanion<Restaurant> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> poster;
  const RestaurantsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.poster = const Value.absent(),
  });
  RestaurantsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String poster,
  })  : title = Value(title),
        poster = Value(poster);
  static Insertable<Restaurant> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? poster,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (poster != null) 'poster': poster,
    });
  }

  RestaurantsCompanion copyWith(
      {Value<int>? id, Value<String>? title, Value<String>? poster}) {
    return RestaurantsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      poster: poster ?? this.poster,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (poster.present) {
      map['poster'] = Variable<String>(poster.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RestaurantsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('poster: $poster')
          ..write(')'))
        .toString();
  }
}

class $RestaurantsTable extends Restaurants
    with TableInfo<$RestaurantsTable, Restaurant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RestaurantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _posterMeta = const VerificationMeta('poster');
  @override
  late final GeneratedColumn<String> poster = GeneratedColumn<String>(
      'poster', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, poster];
  @override
  String get aliasedName => _alias ?? 'restaurants';
  @override
  String get actualTableName => 'restaurants';
  @override
  VerificationContext validateIntegrity(Insertable<Restaurant> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('poster')) {
      context.handle(_posterMeta,
          poster.isAcceptableOrUnknown(data['poster']!, _posterMeta));
    } else if (isInserting) {
      context.missing(_posterMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Restaurant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Restaurant(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      poster: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}poster'])!,
    );
  }

  @override
  $RestaurantsTable createAlias(String alias) {
    return $RestaurantsTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $RestaurantsTable restaurants = $RestaurantsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [restaurants];
}
