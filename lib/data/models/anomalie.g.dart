// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anomalie.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAnomalieCollection on Isar {
  IsarCollection<Anomalie> get anomalies => this.collection();
}

const AnomalieSchema = CollectionSchema(
  name: r'Anomalie',
  id: 5613994544006281620,
  properties: {
    r'agentSessionToken': PropertySchema(
      id: 0,
      name: r'agentSessionToken',
      type: IsarType.string,
    ),
    r'agentTelephone': PropertySchema(
      id: 1,
      name: r'agentTelephone',
      type: IsarType.string,
    ),
    r'codeKiosque': PropertySchema(
      id: 2,
      name: r'codeKiosque',
      type: IsarType.string,
    ),
    r'dateSignalement': PropertySchema(
      id: 3,
      name: r'dateSignalement',
      type: IsarType.dateTime,
    ),
    r'description': PropertySchema(
      id: 4,
      name: r'description',
      type: IsarType.string,
    ),
    r'enAttenteSynchro': PropertySchema(
      id: 5,
      name: r'enAttenteSynchro',
      type: IsarType.bool,
    ),
    r'gpsLatitude': PropertySchema(
      id: 6,
      name: r'gpsLatitude',
      type: IsarType.double,
    ),
    r'gpsLongitude': PropertySchema(
      id: 7,
      name: r'gpsLongitude',
      type: IsarType.double,
    ),
    r'reference': PropertySchema(
      id: 8,
      name: r'reference',
      type: IsarType.string,
    ),
    r'statut': PropertySchema(
      id: 9,
      name: r'statut',
      type: IsarType.string,
    ),
    r'typeAnomalie': PropertySchema(
      id: 10,
      name: r'typeAnomalie',
      type: IsarType.string,
    )
  },
  estimateSize: _anomalieEstimateSize,
  serialize: _anomalieSerialize,
  deserialize: _anomalieDeserialize,
  deserializeProp: _anomalieDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _anomalieGetId,
  getLinks: _anomalieGetLinks,
  attach: _anomalieAttach,
  version: '3.1.0+1',
);

int _anomalieEstimateSize(
  Anomalie object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.agentSessionToken.length * 3;
  bytesCount += 3 + object.agentTelephone.length * 3;
  bytesCount += 3 + object.codeKiosque.length * 3;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.reference.length * 3;
  bytesCount += 3 + object.statut.length * 3;
  bytesCount += 3 + object.typeAnomalie.length * 3;
  return bytesCount;
}

void _anomalieSerialize(
  Anomalie object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.agentSessionToken);
  writer.writeString(offsets[1], object.agentTelephone);
  writer.writeString(offsets[2], object.codeKiosque);
  writer.writeDateTime(offsets[3], object.dateSignalement);
  writer.writeString(offsets[4], object.description);
  writer.writeBool(offsets[5], object.enAttenteSynchro);
  writer.writeDouble(offsets[6], object.gpsLatitude);
  writer.writeDouble(offsets[7], object.gpsLongitude);
  writer.writeString(offsets[8], object.reference);
  writer.writeString(offsets[9], object.statut);
  writer.writeString(offsets[10], object.typeAnomalie);
}

Anomalie _anomalieDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Anomalie(
    agentSessionToken: reader.readString(offsets[0]),
    agentTelephone: reader.readString(offsets[1]),
    typeAnomalie: reader.readString(offsets[10]),
  );
  object.codeKiosque = reader.readString(offsets[2]);
  object.dateSignalement = reader.readDateTime(offsets[3]);
  object.description = reader.readString(offsets[4]);
  object.enAttenteSynchro = reader.readBool(offsets[5]);
  object.gpsLatitude = reader.readDouble(offsets[6]);
  object.gpsLongitude = reader.readDouble(offsets[7]);
  object.id = id;
  object.reference = reader.readString(offsets[8]);
  object.statut = reader.readString(offsets[9]);
  return object;
}

P _anomalieDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _anomalieGetId(Anomalie object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _anomalieGetLinks(Anomalie object) {
  return [];
}

void _anomalieAttach(IsarCollection<dynamic> col, Id id, Anomalie object) {
  object.id = id;
}

extension AnomalieQueryWhereSort on QueryBuilder<Anomalie, Anomalie, QWhere> {
  QueryBuilder<Anomalie, Anomalie, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AnomalieQueryWhere on QueryBuilder<Anomalie, Anomalie, QWhereClause> {
  QueryBuilder<Anomalie, Anomalie, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Anomalie, Anomalie, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterWhereClause> idBetween(
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
}

extension AnomalieQueryFilter
    on QueryBuilder<Anomalie, Anomalie, QFilterCondition> {
  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      agentSessionTokenEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'agentSessionToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      agentSessionTokenGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'agentSessionToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      agentSessionTokenLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'agentSessionToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      agentSessionTokenBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'agentSessionToken',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      agentSessionTokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'agentSessionToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      agentSessionTokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'agentSessionToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      agentSessionTokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'agentSessionToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      agentSessionTokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'agentSessionToken',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      agentSessionTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'agentSessionToken',
        value: '',
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      agentSessionTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'agentSessionToken',
        value: '',
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> agentTelephoneEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'agentTelephone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      agentTelephoneGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'agentTelephone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      agentTelephoneLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'agentTelephone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> agentTelephoneBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'agentTelephone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      agentTelephoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'agentTelephone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      agentTelephoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'agentTelephone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      agentTelephoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'agentTelephone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> agentTelephoneMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'agentTelephone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      agentTelephoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'agentTelephone',
        value: '',
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      agentTelephoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'agentTelephone',
        value: '',
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> codeKiosqueEqualTo(
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

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
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

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> codeKiosqueLessThan(
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

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> codeKiosqueBetween(
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

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> codeKiosqueStartsWith(
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

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> codeKiosqueEndsWith(
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

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> codeKiosqueContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'codeKiosque',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> codeKiosqueMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'codeKiosque',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> codeKiosqueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'codeKiosque',
        value: '',
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      codeKiosqueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'codeKiosque',
        value: '',
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      dateSignalementEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateSignalement',
        value: value,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      dateSignalementGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateSignalement',
        value: value,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      dateSignalementLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateSignalement',
        value: value,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      dateSignalementBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateSignalement',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      enAttenteSynchroEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enAttenteSynchro',
        value: value,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> gpsLatitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gpsLatitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      gpsLatitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gpsLatitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> gpsLatitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gpsLatitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> gpsLatitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gpsLatitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> gpsLongitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gpsLongitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      gpsLongitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gpsLongitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> gpsLongitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gpsLongitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> gpsLongitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gpsLongitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> referenceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> referenceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> referenceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> referenceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reference',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> referenceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'reference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> referenceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'reference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> referenceContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'reference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> referenceMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'reference',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> referenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reference',
        value: '',
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      referenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'reference',
        value: '',
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> statutEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> statutGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'statut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> statutLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'statut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> statutBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'statut',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> statutStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'statut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> statutEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'statut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> statutContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'statut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> statutMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'statut',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> statutIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statut',
        value: '',
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> statutIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'statut',
        value: '',
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> typeAnomalieEqualTo(
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

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
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

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> typeAnomalieLessThan(
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

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> typeAnomalieBetween(
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

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
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

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> typeAnomalieEndsWith(
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

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> typeAnomalieContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'typeAnomalie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition> typeAnomalieMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'typeAnomalie',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      typeAnomalieIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'typeAnomalie',
        value: '',
      ));
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterFilterCondition>
      typeAnomalieIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'typeAnomalie',
        value: '',
      ));
    });
  }
}

extension AnomalieQueryObject
    on QueryBuilder<Anomalie, Anomalie, QFilterCondition> {}

extension AnomalieQueryLinks
    on QueryBuilder<Anomalie, Anomalie, QFilterCondition> {}

extension AnomalieQuerySortBy on QueryBuilder<Anomalie, Anomalie, QSortBy> {
  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByAgentSessionToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agentSessionToken', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByAgentSessionTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agentSessionToken', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByAgentTelephone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agentTelephone', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByAgentTelephoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agentTelephone', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByCodeKiosque() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeKiosque', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByCodeKiosqueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeKiosque', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByDateSignalement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSignalement', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByDateSignalementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSignalement', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByEnAttenteSynchro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enAttenteSynchro', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByEnAttenteSynchroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enAttenteSynchro', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByGpsLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLatitude', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByGpsLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLatitude', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByGpsLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLongitude', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByGpsLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLongitude', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reference', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reference', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByStatut() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statut', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByStatutDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statut', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByTypeAnomalie() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeAnomalie', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> sortByTypeAnomalieDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeAnomalie', Sort.desc);
    });
  }
}

extension AnomalieQuerySortThenBy
    on QueryBuilder<Anomalie, Anomalie, QSortThenBy> {
  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByAgentSessionToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agentSessionToken', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByAgentSessionTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agentSessionToken', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByAgentTelephone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agentTelephone', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByAgentTelephoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agentTelephone', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByCodeKiosque() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeKiosque', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByCodeKiosqueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeKiosque', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByDateSignalement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSignalement', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByDateSignalementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSignalement', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByEnAttenteSynchro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enAttenteSynchro', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByEnAttenteSynchroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enAttenteSynchro', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByGpsLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLatitude', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByGpsLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLatitude', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByGpsLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLongitude', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByGpsLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLongitude', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reference', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reference', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByStatut() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statut', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByStatutDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statut', Sort.desc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByTypeAnomalie() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeAnomalie', Sort.asc);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QAfterSortBy> thenByTypeAnomalieDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeAnomalie', Sort.desc);
    });
  }
}

extension AnomalieQueryWhereDistinct
    on QueryBuilder<Anomalie, Anomalie, QDistinct> {
  QueryBuilder<Anomalie, Anomalie, QDistinct> distinctByAgentSessionToken(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'agentSessionToken',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QDistinct> distinctByAgentTelephone(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'agentTelephone',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QDistinct> distinctByCodeKiosque(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'codeKiosque', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QDistinct> distinctByDateSignalement() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateSignalement');
    });
  }

  QueryBuilder<Anomalie, Anomalie, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QDistinct> distinctByEnAttenteSynchro() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enAttenteSynchro');
    });
  }

  QueryBuilder<Anomalie, Anomalie, QDistinct> distinctByGpsLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gpsLatitude');
    });
  }

  QueryBuilder<Anomalie, Anomalie, QDistinct> distinctByGpsLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gpsLongitude');
    });
  }

  QueryBuilder<Anomalie, Anomalie, QDistinct> distinctByReference(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reference', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QDistinct> distinctByStatut(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statut', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Anomalie, Anomalie, QDistinct> distinctByTypeAnomalie(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'typeAnomalie', caseSensitive: caseSensitive);
    });
  }
}

extension AnomalieQueryProperty
    on QueryBuilder<Anomalie, Anomalie, QQueryProperty> {
  QueryBuilder<Anomalie, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Anomalie, String, QQueryOperations> agentSessionTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'agentSessionToken');
    });
  }

  QueryBuilder<Anomalie, String, QQueryOperations> agentTelephoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'agentTelephone');
    });
  }

  QueryBuilder<Anomalie, String, QQueryOperations> codeKiosqueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'codeKiosque');
    });
  }

  QueryBuilder<Anomalie, DateTime, QQueryOperations> dateSignalementProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateSignalement');
    });
  }

  QueryBuilder<Anomalie, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Anomalie, bool, QQueryOperations> enAttenteSynchroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enAttenteSynchro');
    });
  }

  QueryBuilder<Anomalie, double, QQueryOperations> gpsLatitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gpsLatitude');
    });
  }

  QueryBuilder<Anomalie, double, QQueryOperations> gpsLongitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gpsLongitude');
    });
  }

  QueryBuilder<Anomalie, String, QQueryOperations> referenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reference');
    });
  }

  QueryBuilder<Anomalie, String, QQueryOperations> statutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statut');
    });
  }

  QueryBuilder<Anomalie, String, QQueryOperations> typeAnomalieProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'typeAnomalie');
    });
  }
}
