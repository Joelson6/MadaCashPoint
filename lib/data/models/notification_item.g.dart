// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNotificationItemCollection on Isar {
  IsarCollection<NotificationItem> get notificationItems => this.collection();
}

const NotificationItemSchema = CollectionSchema(
  name: r'NotificationItem',
  id: -7199237222073952696,
  properties: {
    r'codeKiosque': PropertySchema(
      id: 0,
      name: r'codeKiosque',
      type: IsarType.string,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'destinataire': PropertySchema(
      id: 2,
      name: r'destinataire',
      type: IsarType.string,
    ),
    r'idUnique': PropertySchema(
      id: 3,
      name: r'idUnique',
      type: IsarType.string,
    ),
    r'important': PropertySchema(
      id: 4,
      name: r'important',
      type: IsarType.bool,
    ),
    r'lu': PropertySchema(
      id: 5,
      name: r'lu',
      type: IsarType.bool,
    ),
    r'messageAgent': PropertySchema(
      id: 6,
      name: r'messageAgent',
      type: IsarType.string,
    ),
    r'referenceAnomalie': PropertySchema(
      id: 7,
      name: r'referenceAnomalie',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 8,
      name: r'type',
      type: IsarType.string,
    ),
    r'typeAnomalie': PropertySchema(
      id: 9,
      name: r'typeAnomalie',
      type: IsarType.string,
    )
  },
  estimateSize: _notificationItemEstimateSize,
  serialize: _notificationItemSerialize,
  deserialize: _notificationItemDeserialize,
  deserializeProp: _notificationItemDeserializeProp,
  idName: r'id',
  indexes: {
    r'idUnique': IndexSchema(
      id: -3435020272860028034,
      name: r'idUnique',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'idUnique',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'destinataire': IndexSchema(
      id: 4556885131016566130,
      name: r'destinataire',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'destinataire',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _notificationItemGetId,
  getLinks: _notificationItemGetLinks,
  attach: _notificationItemAttach,
  version: '3.1.0+1',
);

int _notificationItemEstimateSize(
  NotificationItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.codeKiosque.length * 3;
  bytesCount += 3 + object.destinataire.length * 3;
  bytesCount += 3 + object.idUnique.length * 3;
  bytesCount += 3 + object.messageAgent.length * 3;
  bytesCount += 3 + object.referenceAnomalie.length * 3;
  bytesCount += 3 + object.type.length * 3;
  bytesCount += 3 + object.typeAnomalie.length * 3;
  return bytesCount;
}

void _notificationItemSerialize(
  NotificationItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.codeKiosque);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeString(offsets[2], object.destinataire);
  writer.writeString(offsets[3], object.idUnique);
  writer.writeBool(offsets[4], object.important);
  writer.writeBool(offsets[5], object.lu);
  writer.writeString(offsets[6], object.messageAgent);
  writer.writeString(offsets[7], object.referenceAnomalie);
  writer.writeString(offsets[8], object.type);
  writer.writeString(offsets[9], object.typeAnomalie);
}

NotificationItem _notificationItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NotificationItem(
    codeKiosque: reader.readString(offsets[0]),
    destinataire: reader.readString(offsets[2]),
    idUnique: reader.readString(offsets[3]),
    important: reader.readBoolOrNull(offsets[4]) ?? true,
    lu: reader.readBoolOrNull(offsets[5]) ?? false,
    messageAgent: reader.readString(offsets[6]),
    referenceAnomalie: reader.readString(offsets[7]),
    type: reader.readString(offsets[8]),
    typeAnomalie: reader.readString(offsets[9]),
  );
  object.date = reader.readDateTime(offsets[1]);
  object.id = id;
  return object;
}

P _notificationItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 5:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _notificationItemGetId(NotificationItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _notificationItemGetLinks(NotificationItem object) {
  return [];
}

void _notificationItemAttach(
    IsarCollection<dynamic> col, Id id, NotificationItem object) {
  object.id = id;
}

extension NotificationItemByIndex on IsarCollection<NotificationItem> {
  Future<NotificationItem?> getByIdUnique(String idUnique) {
    return getByIndex(r'idUnique', [idUnique]);
  }

  NotificationItem? getByIdUniqueSync(String idUnique) {
    return getByIndexSync(r'idUnique', [idUnique]);
  }

  Future<bool> deleteByIdUnique(String idUnique) {
    return deleteByIndex(r'idUnique', [idUnique]);
  }

  bool deleteByIdUniqueSync(String idUnique) {
    return deleteByIndexSync(r'idUnique', [idUnique]);
  }

  Future<List<NotificationItem?>> getAllByIdUnique(
      List<String> idUniqueValues) {
    final values = idUniqueValues.map((e) => [e]).toList();
    return getAllByIndex(r'idUnique', values);
  }

  List<NotificationItem?> getAllByIdUniqueSync(List<String> idUniqueValues) {
    final values = idUniqueValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'idUnique', values);
  }

  Future<int> deleteAllByIdUnique(List<String> idUniqueValues) {
    final values = idUniqueValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'idUnique', values);
  }

  int deleteAllByIdUniqueSync(List<String> idUniqueValues) {
    final values = idUniqueValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'idUnique', values);
  }

  Future<Id> putByIdUnique(NotificationItem object) {
    return putByIndex(r'idUnique', object);
  }

  Id putByIdUniqueSync(NotificationItem object, {bool saveLinks = true}) {
    return putByIndexSync(r'idUnique', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByIdUnique(List<NotificationItem> objects) {
    return putAllByIndex(r'idUnique', objects);
  }

  List<Id> putAllByIdUniqueSync(List<NotificationItem> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'idUnique', objects, saveLinks: saveLinks);
  }
}

extension NotificationItemQueryWhereSort
    on QueryBuilder<NotificationItem, NotificationItem, QWhere> {
  QueryBuilder<NotificationItem, NotificationItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NotificationItemQueryWhere
    on QueryBuilder<NotificationItem, NotificationItem, QWhereClause> {
  QueryBuilder<NotificationItem, NotificationItem, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterWhereClause>
      idUniqueEqualTo(String idUnique) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'idUnique',
        value: [idUnique],
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterWhereClause>
      idUniqueNotEqualTo(String idUnique) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'idUnique',
              lower: [],
              upper: [idUnique],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'idUnique',
              lower: [idUnique],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'idUnique',
              lower: [idUnique],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'idUnique',
              lower: [],
              upper: [idUnique],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterWhereClause>
      destinataireEqualTo(String destinataire) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'destinataire',
        value: [destinataire],
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterWhereClause>
      destinataireNotEqualTo(String destinataire) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'destinataire',
              lower: [],
              upper: [destinataire],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'destinataire',
              lower: [destinataire],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'destinataire',
              lower: [destinataire],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'destinataire',
              lower: [],
              upper: [destinataire],
              includeUpper: false,
            ));
      }
    });
  }
}

extension NotificationItemQueryFilter
    on QueryBuilder<NotificationItem, NotificationItem, QFilterCondition> {
  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      codeKiosqueEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'codeKiosque',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      codeKiosqueGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'codeKiosque',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      codeKiosqueLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'codeKiosque',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      codeKiosqueBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'codeKiosque',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      codeKiosqueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'codeKiosque',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      codeKiosqueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'codeKiosque',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      codeKiosqueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'codeKiosque',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      codeKiosqueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'codeKiosque',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      codeKiosqueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'codeKiosque',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      codeKiosqueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'codeKiosque',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      destinataireEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'destinataire',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      destinataireGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'destinataire',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      destinataireLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'destinataire',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      destinataireBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'destinataire',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      destinataireStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'destinataire',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      destinataireEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'destinataire',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      destinataireContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'destinataire',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      destinataireMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'destinataire',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      destinataireIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'destinataire',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      destinataireIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'destinataire',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      idUniqueEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idUnique',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      idUniqueGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idUnique',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      idUniqueLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idUnique',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      idUniqueBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idUnique',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      idUniqueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'idUnique',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      idUniqueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'idUnique',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      idUniqueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'idUnique',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      idUniqueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'idUnique',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      idUniqueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idUnique',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      idUniqueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'idUnique',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      importantEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'important',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      luEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lu',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      messageAgentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageAgent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      messageAgentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageAgent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      messageAgentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageAgent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      messageAgentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageAgent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      messageAgentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'messageAgent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      messageAgentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'messageAgent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      messageAgentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'messageAgent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      messageAgentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'messageAgent',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      messageAgentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageAgent',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      messageAgentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'messageAgent',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      referenceAnomalieEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'referenceAnomalie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      referenceAnomalieGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'referenceAnomalie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      referenceAnomalieLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'referenceAnomalie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      referenceAnomalieBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'referenceAnomalie',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      referenceAnomalieStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'referenceAnomalie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      referenceAnomalieEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'referenceAnomalie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      referenceAnomalieContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'referenceAnomalie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      referenceAnomalieMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'referenceAnomalie',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      referenceAnomalieIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'referenceAnomalie',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      referenceAnomalieIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'referenceAnomalie',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      typeAnomalieEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'typeAnomalie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      typeAnomalieGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'typeAnomalie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      typeAnomalieLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'typeAnomalie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      typeAnomalieBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'typeAnomalie',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      typeAnomalieStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'typeAnomalie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      typeAnomalieEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'typeAnomalie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      typeAnomalieContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'typeAnomalie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      typeAnomalieMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'typeAnomalie',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      typeAnomalieIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'typeAnomalie',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterFilterCondition>
      typeAnomalieIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'typeAnomalie',
        value: '',
      ));
    });
  }
}

extension NotificationItemQueryObject
    on QueryBuilder<NotificationItem, NotificationItem, QFilterCondition> {}

extension NotificationItemQueryLinks
    on QueryBuilder<NotificationItem, NotificationItem, QFilterCondition> {}

extension NotificationItemQuerySortBy
    on QueryBuilder<NotificationItem, NotificationItem, QSortBy> {
  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      sortByCodeKiosque() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeKiosque', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      sortByCodeKiosqueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeKiosque', Sort.desc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      sortByDestinataire() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'destinataire', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      sortByDestinataireDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'destinataire', Sort.desc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      sortByIdUnique() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idUnique', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      sortByIdUniqueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idUnique', Sort.desc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      sortByImportant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'important', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      sortByImportantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'important', Sort.desc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy> sortByLu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lu', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      sortByLuDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lu', Sort.desc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      sortByMessageAgent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageAgent', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      sortByMessageAgentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageAgent', Sort.desc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      sortByReferenceAnomalie() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referenceAnomalie', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      sortByReferenceAnomalieDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referenceAnomalie', Sort.desc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      sortByTypeAnomalie() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeAnomalie', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      sortByTypeAnomalieDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeAnomalie', Sort.desc);
    });
  }
}

extension NotificationItemQuerySortThenBy
    on QueryBuilder<NotificationItem, NotificationItem, QSortThenBy> {
  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      thenByCodeKiosque() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeKiosque', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      thenByCodeKiosqueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeKiosque', Sort.desc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      thenByDestinataire() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'destinataire', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      thenByDestinataireDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'destinataire', Sort.desc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      thenByIdUnique() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idUnique', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      thenByIdUniqueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idUnique', Sort.desc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      thenByImportant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'important', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      thenByImportantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'important', Sort.desc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy> thenByLu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lu', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      thenByLuDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lu', Sort.desc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      thenByMessageAgent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageAgent', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      thenByMessageAgentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageAgent', Sort.desc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      thenByReferenceAnomalie() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referenceAnomalie', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      thenByReferenceAnomalieDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referenceAnomalie', Sort.desc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      thenByTypeAnomalie() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeAnomalie', Sort.asc);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QAfterSortBy>
      thenByTypeAnomalieDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeAnomalie', Sort.desc);
    });
  }
}

extension NotificationItemQueryWhereDistinct
    on QueryBuilder<NotificationItem, NotificationItem, QDistinct> {
  QueryBuilder<NotificationItem, NotificationItem, QDistinct>
      distinctByCodeKiosque({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'codeKiosque', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QDistinct>
      distinctByDestinataire({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'destinataire', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QDistinct>
      distinctByIdUnique({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idUnique', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QDistinct>
      distinctByImportant() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'important');
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QDistinct> distinctByLu() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lu');
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QDistinct>
      distinctByMessageAgent({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageAgent', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QDistinct>
      distinctByReferenceAnomalie({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'referenceAnomalie',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationItem, NotificationItem, QDistinct>
      distinctByTypeAnomalie({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'typeAnomalie', caseSensitive: caseSensitive);
    });
  }
}

extension NotificationItemQueryProperty
    on QueryBuilder<NotificationItem, NotificationItem, QQueryProperty> {
  QueryBuilder<NotificationItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<NotificationItem, String, QQueryOperations>
      codeKiosqueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'codeKiosque');
    });
  }

  QueryBuilder<NotificationItem, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<NotificationItem, String, QQueryOperations>
      destinataireProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'destinataire');
    });
  }

  QueryBuilder<NotificationItem, String, QQueryOperations> idUniqueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idUnique');
    });
  }

  QueryBuilder<NotificationItem, bool, QQueryOperations> importantProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'important');
    });
  }

  QueryBuilder<NotificationItem, bool, QQueryOperations> luProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lu');
    });
  }

  QueryBuilder<NotificationItem, String, QQueryOperations>
      messageAgentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageAgent');
    });
  }

  QueryBuilder<NotificationItem, String, QQueryOperations>
      referenceAnomalieProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'referenceAnomalie');
    });
  }

  QueryBuilder<NotificationItem, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<NotificationItem, String, QQueryOperations>
      typeAnomalieProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'typeAnomalie');
    });
  }
}
