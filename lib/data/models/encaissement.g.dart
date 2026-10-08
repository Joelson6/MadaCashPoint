// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encaissement.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEncaissementCollection on Isar {
  IsarCollection<Encaissement> get encaissements => this.collection();
}

const EncaissementSchema = CollectionSchema(
  name: r'Encaissement',
  id: 8462000631765292877,
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
    r'enAttenteSynchro': PropertySchema(
      id: 3,
      name: r'enAttenteSynchro',
      type: IsarType.bool,
    ),
    r'gpsLatitude': PropertySchema(
      id: 4,
      name: r'gpsLatitude',
      type: IsarType.double,
    ),
    r'gpsLongitude': PropertySchema(
      id: 5,
      name: r'gpsLongitude',
      type: IsarType.double,
    ),
    r'horodatage': PropertySchema(
      id: 6,
      name: r'horodatage',
      type: IsarType.dateTime,
    ),
    r'montant': PropertySchema(
      id: 7,
      name: r'montant',
      type: IsarType.long,
    ),
    r'natureTaxe': PropertySchema(
      id: 8,
      name: r'natureTaxe',
      type: IsarType.string,
    ),
    r'nomKiosque': PropertySchema(
      id: 9,
      name: r'nomKiosque',
      type: IsarType.string,
    ),
    r'numeroQuittance': PropertySchema(
      id: 10,
      name: r'numeroQuittance',
      type: IsarType.string,
    ),
    r'proprietaireNom': PropertySchema(
      id: 11,
      name: r'proprietaireNom',
      type: IsarType.string,
    ),
    r'synchroniseAt': PropertySchema(
      id: 12,
      name: r'synchroniseAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _encaissementEstimateSize,
  serialize: _encaissementSerialize,
  deserialize: _encaissementDeserialize,
  deserializeProp: _encaissementDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _encaissementGetId,
  getLinks: _encaissementGetLinks,
  attach: _encaissementAttach,
  version: '3.1.0+1',
);

int _encaissementEstimateSize(
  Encaissement object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.agentSessionToken.length * 3;
  bytesCount += 3 + object.agentTelephone.length * 3;
  bytesCount += 3 + object.codeKiosque.length * 3;
  bytesCount += 3 + object.natureTaxe.length * 3;
  bytesCount += 3 + object.nomKiosque.length * 3;
  bytesCount += 3 + object.numeroQuittance.length * 3;
  bytesCount += 3 + object.proprietaireNom.length * 3;
  return bytesCount;
}

void _encaissementSerialize(
  Encaissement object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.agentSessionToken);
  writer.writeString(offsets[1], object.agentTelephone);
  writer.writeString(offsets[2], object.codeKiosque);
  writer.writeBool(offsets[3], object.enAttenteSynchro);
  writer.writeDouble(offsets[4], object.gpsLatitude);
  writer.writeDouble(offsets[5], object.gpsLongitude);
  writer.writeDateTime(offsets[6], object.horodatage);
  writer.writeLong(offsets[7], object.montant);
  writer.writeString(offsets[8], object.natureTaxe);
  writer.writeString(offsets[9], object.nomKiosque);
  writer.writeString(offsets[10], object.numeroQuittance);
  writer.writeString(offsets[11], object.proprietaireNom);
  writer.writeDateTime(offsets[12], object.synchroniseAt);
}

Encaissement _encaissementDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Encaissement(
    agentSessionToken: reader.readString(offsets[0]),
    agentTelephone: reader.readString(offsets[1]),
    codeKiosque: reader.readString(offsets[2]),
    montant: reader.readLong(offsets[7]),
    natureTaxe: reader.readString(offsets[8]),
    nomKiosque: reader.readString(offsets[9]),
    proprietaireNom: reader.readString(offsets[11]),
  );
  object.enAttenteSynchro = reader.readBool(offsets[3]);
  object.gpsLatitude = reader.readDouble(offsets[4]);
  object.gpsLongitude = reader.readDouble(offsets[5]);
  object.horodatage = reader.readDateTime(offsets[6]);
  object.id = id;
  object.numeroQuittance = reader.readString(offsets[10]);
  object.synchroniseAt = reader.readDateTimeOrNull(offsets[12]);
  return object;
}

P _encaissementDeserializeProp<P>(
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
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _encaissementGetId(Encaissement object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _encaissementGetLinks(Encaissement object) {
  return [];
}

void _encaissementAttach(
    IsarCollection<dynamic> col, Id id, Encaissement object) {
  object.id = id;
}

extension EncaissementQueryWhereSort
    on QueryBuilder<Encaissement, Encaissement, QWhere> {
  QueryBuilder<Encaissement, Encaissement, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EncaissementQueryWhere
    on QueryBuilder<Encaissement, Encaissement, QWhereClause> {
  QueryBuilder<Encaissement, Encaissement, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<Encaissement, Encaissement, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterWhereClause> idBetween(
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

extension EncaissementQueryFilter
    on QueryBuilder<Encaissement, Encaissement, QFilterCondition> {
  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      agentSessionTokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'agentSessionToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      agentSessionTokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'agentSessionToken',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      agentSessionTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'agentSessionToken',
        value: '',
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      agentSessionTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'agentSessionToken',
        value: '',
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      agentTelephoneEqualTo(
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      agentTelephoneBetween(
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      agentTelephoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'agentTelephone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      agentTelephoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'agentTelephone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      agentTelephoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'agentTelephone',
        value: '',
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      agentTelephoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'agentTelephone',
        value: '',
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      codeKiosqueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'codeKiosque',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      codeKiosqueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'codeKiosque',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      codeKiosqueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'codeKiosque',
        value: '',
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      codeKiosqueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'codeKiosque',
        value: '',
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      enAttenteSynchroEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enAttenteSynchro',
        value: value,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      gpsLatitudeEqualTo(
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      gpsLatitudeLessThan(
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      gpsLatitudeBetween(
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      gpsLongitudeEqualTo(
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      gpsLongitudeLessThan(
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      gpsLongitudeBetween(
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      horodatageEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'horodatage',
        value: value,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      horodatageGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'horodatage',
        value: value,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      horodatageLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'horodatage',
        value: value,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      horodatageBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'horodatage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      montantEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'montant',
        value: value,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      montantGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'montant',
        value: value,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      montantLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'montant',
        value: value,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      montantBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'montant',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      natureTaxeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'natureTaxe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      natureTaxeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'natureTaxe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      natureTaxeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'natureTaxe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      natureTaxeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'natureTaxe',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      natureTaxeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'natureTaxe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      natureTaxeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'natureTaxe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      natureTaxeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'natureTaxe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      natureTaxeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'natureTaxe',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      natureTaxeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'natureTaxe',
        value: '',
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      natureTaxeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'natureTaxe',
        value: '',
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      nomKiosqueEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomKiosque',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      nomKiosqueGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nomKiosque',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      nomKiosqueLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nomKiosque',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      nomKiosqueBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nomKiosque',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      nomKiosqueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nomKiosque',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      nomKiosqueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nomKiosque',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      nomKiosqueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nomKiosque',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      nomKiosqueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nomKiosque',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      nomKiosqueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomKiosque',
        value: '',
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      nomKiosqueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nomKiosque',
        value: '',
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      numeroQuittanceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroQuittance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      numeroQuittanceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numeroQuittance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      numeroQuittanceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numeroQuittance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      numeroQuittanceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numeroQuittance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      numeroQuittanceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'numeroQuittance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      numeroQuittanceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'numeroQuittance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      numeroQuittanceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'numeroQuittance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      numeroQuittanceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'numeroQuittance',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      numeroQuittanceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroQuittance',
        value: '',
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      numeroQuittanceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'numeroQuittance',
        value: '',
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      proprietaireNomEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proprietaireNom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      proprietaireNomGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proprietaireNom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      proprietaireNomLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proprietaireNom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      proprietaireNomBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proprietaireNom',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      proprietaireNomStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'proprietaireNom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      proprietaireNomEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'proprietaireNom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      proprietaireNomContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'proprietaireNom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      proprietaireNomMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'proprietaireNom',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      proprietaireNomIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proprietaireNom',
        value: '',
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      proprietaireNomIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'proprietaireNom',
        value: '',
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      synchroniseAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'synchroniseAt',
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      synchroniseAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'synchroniseAt',
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      synchroniseAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'synchroniseAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      synchroniseAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'synchroniseAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      synchroniseAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'synchroniseAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterFilterCondition>
      synchroniseAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'synchroniseAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension EncaissementQueryObject
    on QueryBuilder<Encaissement, Encaissement, QFilterCondition> {}

extension EncaissementQueryLinks
    on QueryBuilder<Encaissement, Encaissement, QFilterCondition> {}

extension EncaissementQuerySortBy
    on QueryBuilder<Encaissement, Encaissement, QSortBy> {
  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      sortByAgentSessionToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agentSessionToken', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      sortByAgentSessionTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agentSessionToken', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      sortByAgentTelephone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agentTelephone', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      sortByAgentTelephoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agentTelephone', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy> sortByCodeKiosque() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeKiosque', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      sortByCodeKiosqueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeKiosque', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      sortByEnAttenteSynchro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enAttenteSynchro', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      sortByEnAttenteSynchroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enAttenteSynchro', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy> sortByGpsLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLatitude', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      sortByGpsLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLatitude', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy> sortByGpsLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLongitude', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      sortByGpsLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLongitude', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy> sortByHorodatage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horodatage', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      sortByHorodatageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horodatage', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy> sortByMontant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'montant', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy> sortByMontantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'montant', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy> sortByNatureTaxe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'natureTaxe', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      sortByNatureTaxeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'natureTaxe', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy> sortByNomKiosque() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomKiosque', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      sortByNomKiosqueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomKiosque', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      sortByNumeroQuittance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroQuittance', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      sortByNumeroQuittanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroQuittance', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      sortByProprietaireNom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proprietaireNom', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      sortByProprietaireNomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proprietaireNom', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy> sortBySynchroniseAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synchroniseAt', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      sortBySynchroniseAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synchroniseAt', Sort.desc);
    });
  }
}

extension EncaissementQuerySortThenBy
    on QueryBuilder<Encaissement, Encaissement, QSortThenBy> {
  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      thenByAgentSessionToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agentSessionToken', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      thenByAgentSessionTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agentSessionToken', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      thenByAgentTelephone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agentTelephone', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      thenByAgentTelephoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agentTelephone', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy> thenByCodeKiosque() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeKiosque', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      thenByCodeKiosqueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeKiosque', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      thenByEnAttenteSynchro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enAttenteSynchro', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      thenByEnAttenteSynchroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enAttenteSynchro', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy> thenByGpsLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLatitude', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      thenByGpsLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLatitude', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy> thenByGpsLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLongitude', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      thenByGpsLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLongitude', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy> thenByHorodatage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horodatage', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      thenByHorodatageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horodatage', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy> thenByMontant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'montant', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy> thenByMontantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'montant', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy> thenByNatureTaxe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'natureTaxe', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      thenByNatureTaxeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'natureTaxe', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy> thenByNomKiosque() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomKiosque', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      thenByNomKiosqueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomKiosque', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      thenByNumeroQuittance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroQuittance', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      thenByNumeroQuittanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroQuittance', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      thenByProprietaireNom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proprietaireNom', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      thenByProprietaireNomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proprietaireNom', Sort.desc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy> thenBySynchroniseAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synchroniseAt', Sort.asc);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QAfterSortBy>
      thenBySynchroniseAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synchroniseAt', Sort.desc);
    });
  }
}

extension EncaissementQueryWhereDistinct
    on QueryBuilder<Encaissement, Encaissement, QDistinct> {
  QueryBuilder<Encaissement, Encaissement, QDistinct>
      distinctByAgentSessionToken({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'agentSessionToken',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QDistinct> distinctByAgentTelephone(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'agentTelephone',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QDistinct> distinctByCodeKiosque(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'codeKiosque', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QDistinct>
      distinctByEnAttenteSynchro() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enAttenteSynchro');
    });
  }

  QueryBuilder<Encaissement, Encaissement, QDistinct> distinctByGpsLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gpsLatitude');
    });
  }

  QueryBuilder<Encaissement, Encaissement, QDistinct> distinctByGpsLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gpsLongitude');
    });
  }

  QueryBuilder<Encaissement, Encaissement, QDistinct> distinctByHorodatage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'horodatage');
    });
  }

  QueryBuilder<Encaissement, Encaissement, QDistinct> distinctByMontant() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'montant');
    });
  }

  QueryBuilder<Encaissement, Encaissement, QDistinct> distinctByNatureTaxe(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'natureTaxe', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QDistinct> distinctByNomKiosque(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nomKiosque', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QDistinct> distinctByNumeroQuittance(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroQuittance',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QDistinct> distinctByProprietaireNom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proprietaireNom',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Encaissement, Encaissement, QDistinct>
      distinctBySynchroniseAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'synchroniseAt');
    });
  }
}

extension EncaissementQueryProperty
    on QueryBuilder<Encaissement, Encaissement, QQueryProperty> {
  QueryBuilder<Encaissement, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Encaissement, String, QQueryOperations>
      agentSessionTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'agentSessionToken');
    });
  }

  QueryBuilder<Encaissement, String, QQueryOperations>
      agentTelephoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'agentTelephone');
    });
  }

  QueryBuilder<Encaissement, String, QQueryOperations> codeKiosqueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'codeKiosque');
    });
  }

  QueryBuilder<Encaissement, bool, QQueryOperations>
      enAttenteSynchroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enAttenteSynchro');
    });
  }

  QueryBuilder<Encaissement, double, QQueryOperations> gpsLatitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gpsLatitude');
    });
  }

  QueryBuilder<Encaissement, double, QQueryOperations> gpsLongitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gpsLongitude');
    });
  }

  QueryBuilder<Encaissement, DateTime, QQueryOperations> horodatageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'horodatage');
    });
  }

  QueryBuilder<Encaissement, int, QQueryOperations> montantProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'montant');
    });
  }

  QueryBuilder<Encaissement, String, QQueryOperations> natureTaxeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'natureTaxe');
    });
  }

  QueryBuilder<Encaissement, String, QQueryOperations> nomKiosqueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nomKiosque');
    });
  }

  QueryBuilder<Encaissement, String, QQueryOperations>
      numeroQuittanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroQuittance');
    });
  }

  QueryBuilder<Encaissement, String, QQueryOperations>
      proprietaireNomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proprietaireNom');
    });
  }

  QueryBuilder<Encaissement, DateTime?, QQueryOperations>
      synchroniseAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'synchroniseAt');
    });
  }
}
