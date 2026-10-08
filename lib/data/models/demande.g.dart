// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demande.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDemandeCollection on Isar {
  IsarCollection<Demande> get demandes => this.collection();
}

const DemandeSchema = CollectionSchema(
  name: r'Demande',
  id: 3521960455251351831,
  properties: {
    r'cin': PropertySchema(
      id: 0,
      name: r'cin',
      type: IsarType.string,
    ),
    r'cinDate': PropertySchema(
      id: 1,
      name: r'cinDate',
      type: IsarType.string,
    ),
    r'cinLieu': PropertySchema(
      id: 2,
      name: r'cinLieu',
      type: IsarType.string,
    ),
    r'codeDossier': PropertySchema(
      id: 3,
      name: r'codeDossier',
      type: IsarType.string,
    ),
    r'dateCreation': PropertySchema(
      id: 4,
      name: r'dateCreation',
      type: IsarType.dateTime,
    ),
    r'dateSoumission': PropertySchema(
      id: 5,
      name: r'dateSoumission',
      type: IsarType.dateTime,
    ),
    r'emplacementRepere': PropertySchema(
      id: 6,
      name: r'emplacementRepere',
      type: IsarType.string,
    ),
    r'fokontany': PropertySchema(
      id: 7,
      name: r'fokontany',
      type: IsarType.string,
    ),
    r'georestrictionResultat': PropertySchema(
      id: 8,
      name: r'georestrictionResultat',
      type: IsarType.string,
    ),
    r'gpsLatitude': PropertySchema(
      id: 9,
      name: r'gpsLatitude',
      type: IsarType.double,
    ),
    r'gpsLongitude': PropertySchema(
      id: 10,
      name: r'gpsLongitude',
      type: IsarType.double,
    ),
    r'kiosqueLargeur': PropertySchema(
      id: 11,
      name: r'kiosqueLargeur',
      type: IsarType.double,
    ),
    r'kiosqueLongueur': PropertySchema(
      id: 12,
      name: r'kiosqueLongueur',
      type: IsarType.double,
    ),
    r'materiauxConstruction': PropertySchema(
      id: 13,
      name: r'materiauxConstruction',
      type: IsarType.string,
    ),
    r'montantDroitInstallation': PropertySchema(
      id: 14,
      name: r'montantDroitInstallation',
      type: IsarType.long,
    ),
    r'nomCommercial': PropertySchema(
      id: 15,
      name: r'nomCommercial',
      type: IsarType.string,
    ),
    r'nomPrenoms': PropertySchema(
      id: 16,
      name: r'nomPrenoms',
      type: IsarType.string,
    ),
    r'noteRejet': PropertySchema(
      id: 17,
      name: r'noteRejet',
      type: IsarType.string,
    ),
    r'operateurs': PropertySchema(
      id: 18,
      name: r'operateurs',
      type: IsarType.stringList,
    ),
    r'photoCinRectoPath': PropertySchema(
      id: 19,
      name: r'photoCinRectoPath',
      type: IsarType.string,
    ),
    r'photoCinVersoPath': PropertySchema(
      id: 20,
      name: r'photoCinVersoPath',
      type: IsarType.string,
    ),
    r'photoEmplacementPath': PropertySchema(
      id: 21,
      name: r'photoEmplacementPath',
      type: IsarType.string,
    ),
    r'quartier': PropertySchema(
      id: 22,
      name: r'quartier',
      type: IsarType.string,
    ),
    r'soumiseLocalement': PropertySchema(
      id: 23,
      name: r'soumiseLocalement',
      type: IsarType.bool,
    ),
    r'statut': PropertySchema(
      id: 24,
      name: r'statut',
      type: IsarType.string,
    ),
    r'statutDroitInstallation': PropertySchema(
      id: 25,
      name: r'statutDroitInstallation',
      type: IsarType.string,
    ),
    r'synchronise': PropertySchema(
      id: 26,
      name: r'synchronise',
      type: IsarType.bool,
    ),
    r'telephone': PropertySchema(
      id: 27,
      name: r'telephone',
      type: IsarType.string,
    ),
    r'typeIdentification': PropertySchema(
      id: 28,
      name: r'typeIdentification',
      type: IsarType.string,
    )
  },
  estimateSize: _demandeEstimateSize,
  serialize: _demandeSerialize,
  deserialize: _demandeDeserialize,
  deserializeProp: _demandeDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _demandeGetId,
  getLinks: _demandeGetLinks,
  attach: _demandeAttach,
  version: '3.1.0+1',
);

int _demandeEstimateSize(
  Demande object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cin.length * 3;
  bytesCount += 3 + object.cinDate.length * 3;
  bytesCount += 3 + object.cinLieu.length * 3;
  bytesCount += 3 + object.codeDossier.length * 3;
  bytesCount += 3 + object.emplacementRepere.length * 3;
  bytesCount += 3 + object.fokontany.length * 3;
  bytesCount += 3 + object.georestrictionResultat.length * 3;
  bytesCount += 3 + object.materiauxConstruction.length * 3;
  bytesCount += 3 + object.nomCommercial.length * 3;
  bytesCount += 3 + object.nomPrenoms.length * 3;
  bytesCount += 3 + object.noteRejet.length * 3;
  bytesCount += 3 + object.operateurs.length * 3;
  {
    for (var i = 0; i < object.operateurs.length; i++) {
      final value = object.operateurs[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.photoCinRectoPath.length * 3;
  bytesCount += 3 + object.photoCinVersoPath.length * 3;
  bytesCount += 3 + object.photoEmplacementPath.length * 3;
  bytesCount += 3 + object.quartier.length * 3;
  bytesCount += 3 + object.statut.length * 3;
  bytesCount += 3 + object.statutDroitInstallation.length * 3;
  bytesCount += 3 + object.telephone.length * 3;
  bytesCount += 3 + object.typeIdentification.length * 3;
  return bytesCount;
}

void _demandeSerialize(
  Demande object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.cin);
  writer.writeString(offsets[1], object.cinDate);
  writer.writeString(offsets[2], object.cinLieu);
  writer.writeString(offsets[3], object.codeDossier);
  writer.writeDateTime(offsets[4], object.dateCreation);
  writer.writeDateTime(offsets[5], object.dateSoumission);
  writer.writeString(offsets[6], object.emplacementRepere);
  writer.writeString(offsets[7], object.fokontany);
  writer.writeString(offsets[8], object.georestrictionResultat);
  writer.writeDouble(offsets[9], object.gpsLatitude);
  writer.writeDouble(offsets[10], object.gpsLongitude);
  writer.writeDouble(offsets[11], object.kiosqueLargeur);
  writer.writeDouble(offsets[12], object.kiosqueLongueur);
  writer.writeString(offsets[13], object.materiauxConstruction);
  writer.writeLong(offsets[14], object.montantDroitInstallation);
  writer.writeString(offsets[15], object.nomCommercial);
  writer.writeString(offsets[16], object.nomPrenoms);
  writer.writeString(offsets[17], object.noteRejet);
  writer.writeStringList(offsets[18], object.operateurs);
  writer.writeString(offsets[19], object.photoCinRectoPath);
  writer.writeString(offsets[20], object.photoCinVersoPath);
  writer.writeString(offsets[21], object.photoEmplacementPath);
  writer.writeString(offsets[22], object.quartier);
  writer.writeBool(offsets[23], object.soumiseLocalement);
  writer.writeString(offsets[24], object.statut);
  writer.writeString(offsets[25], object.statutDroitInstallation);
  writer.writeBool(offsets[26], object.synchronise);
  writer.writeString(offsets[27], object.telephone);
  writer.writeString(offsets[28], object.typeIdentification);
}

Demande _demandeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Demande(
    codeDossier: reader.readString(offsets[3]),
    telephone: reader.readString(offsets[27]),
  );
  object.cin = reader.readString(offsets[0]);
  object.cinDate = reader.readString(offsets[1]);
  object.cinLieu = reader.readString(offsets[2]);
  object.dateCreation = reader.readDateTime(offsets[4]);
  object.dateSoumission = reader.readDateTimeOrNull(offsets[5]);
  object.emplacementRepere = reader.readString(offsets[6]);
  object.fokontany = reader.readString(offsets[7]);
  object.georestrictionResultat = reader.readString(offsets[8]);
  object.gpsLatitude = reader.readDouble(offsets[9]);
  object.gpsLongitude = reader.readDouble(offsets[10]);
  object.id = id;
  object.kiosqueLargeur = reader.readDouble(offsets[11]);
  object.kiosqueLongueur = reader.readDouble(offsets[12]);
  object.materiauxConstruction = reader.readString(offsets[13]);
  object.montantDroitInstallation = reader.readLong(offsets[14]);
  object.nomCommercial = reader.readString(offsets[15]);
  object.nomPrenoms = reader.readString(offsets[16]);
  object.noteRejet = reader.readString(offsets[17]);
  object.operateurs = reader.readStringList(offsets[18]) ?? [];
  object.photoCinRectoPath = reader.readString(offsets[19]);
  object.photoCinVersoPath = reader.readString(offsets[20]);
  object.photoEmplacementPath = reader.readString(offsets[21]);
  object.quartier = reader.readString(offsets[22]);
  object.soumiseLocalement = reader.readBool(offsets[23]);
  object.statut = reader.readString(offsets[24]);
  object.statutDroitInstallation = reader.readString(offsets[25]);
  object.synchronise = reader.readBool(offsets[26]);
  object.typeIdentification = reader.readString(offsets[28]);
  return object;
}

P _demandeDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readDouble(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readDouble(offset)) as P;
    case 12:
      return (reader.readDouble(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readLong(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readString(offset)) as P;
    case 17:
      return (reader.readString(offset)) as P;
    case 18:
      return (reader.readStringList(offset) ?? []) as P;
    case 19:
      return (reader.readString(offset)) as P;
    case 20:
      return (reader.readString(offset)) as P;
    case 21:
      return (reader.readString(offset)) as P;
    case 22:
      return (reader.readString(offset)) as P;
    case 23:
      return (reader.readBool(offset)) as P;
    case 24:
      return (reader.readString(offset)) as P;
    case 25:
      return (reader.readString(offset)) as P;
    case 26:
      return (reader.readBool(offset)) as P;
    case 27:
      return (reader.readString(offset)) as P;
    case 28:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _demandeGetId(Demande object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _demandeGetLinks(Demande object) {
  return [];
}

void _demandeAttach(IsarCollection<dynamic> col, Id id, Demande object) {
  object.id = id;
}

extension DemandeQueryWhereSort on QueryBuilder<Demande, Demande, QWhere> {
  QueryBuilder<Demande, Demande, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DemandeQueryWhere on QueryBuilder<Demande, Demande, QWhereClause> {
  QueryBuilder<Demande, Demande, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Demande, Demande, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Demande, Demande, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Demande, Demande, QAfterWhereClause> idBetween(
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

extension DemandeQueryFilter
    on QueryBuilder<Demande, Demande, QFilterCondition> {
  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cin',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cin',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cin',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinDateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cinDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinDateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cinDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinDateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cinDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinDateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cinDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cinDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cinDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinDateContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cinDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinDateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cinDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cinDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cinDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinLieuEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cinLieu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinLieuGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cinLieu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinLieuLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cinLieu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinLieuBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cinLieu',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinLieuStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cinLieu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinLieuEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cinLieu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinLieuContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cinLieu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinLieuMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cinLieu',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinLieuIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cinLieu',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> cinLieuIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cinLieu',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> codeDossierEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'codeDossier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> codeDossierGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'codeDossier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> codeDossierLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'codeDossier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> codeDossierBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'codeDossier',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> codeDossierStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'codeDossier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> codeDossierEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'codeDossier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> codeDossierContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'codeDossier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> codeDossierMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'codeDossier',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> codeDossierIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'codeDossier',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      codeDossierIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'codeDossier',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> dateCreationEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateCreation',
        value: value,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> dateCreationGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateCreation',
        value: value,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> dateCreationLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateCreation',
        value: value,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> dateCreationBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateCreation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> dateSoumissionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateSoumission',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      dateSoumissionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateSoumission',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> dateSoumissionEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateSoumission',
        value: value,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      dateSoumissionGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateSoumission',
        value: value,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> dateSoumissionLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateSoumission',
        value: value,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> dateSoumissionBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateSoumission',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      emplacementRepereEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emplacementRepere',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      emplacementRepereGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emplacementRepere',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      emplacementRepereLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emplacementRepere',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      emplacementRepereBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emplacementRepere',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      emplacementRepereStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emplacementRepere',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      emplacementRepereEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emplacementRepere',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      emplacementRepereContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emplacementRepere',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      emplacementRepereMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emplacementRepere',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      emplacementRepereIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emplacementRepere',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      emplacementRepereIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emplacementRepere',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> fokontanyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fokontany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> fokontanyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fokontany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> fokontanyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fokontany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> fokontanyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fokontany',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> fokontanyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fokontany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> fokontanyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fokontany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> fokontanyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fokontany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> fokontanyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fokontany',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> fokontanyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fokontany',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> fokontanyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fokontany',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      georestrictionResultatEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'georestrictionResultat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      georestrictionResultatGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'georestrictionResultat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      georestrictionResultatLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'georestrictionResultat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      georestrictionResultatBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'georestrictionResultat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      georestrictionResultatStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'georestrictionResultat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      georestrictionResultatEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'georestrictionResultat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      georestrictionResultatContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'georestrictionResultat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      georestrictionResultatMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'georestrictionResultat',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      georestrictionResultatIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'georestrictionResultat',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      georestrictionResultatIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'georestrictionResultat',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> gpsLatitudeEqualTo(
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

  QueryBuilder<Demande, Demande, QAfterFilterCondition> gpsLatitudeGreaterThan(
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

  QueryBuilder<Demande, Demande, QAfterFilterCondition> gpsLatitudeLessThan(
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

  QueryBuilder<Demande, Demande, QAfterFilterCondition> gpsLatitudeBetween(
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

  QueryBuilder<Demande, Demande, QAfterFilterCondition> gpsLongitudeEqualTo(
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

  QueryBuilder<Demande, Demande, QAfterFilterCondition> gpsLongitudeGreaterThan(
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

  QueryBuilder<Demande, Demande, QAfterFilterCondition> gpsLongitudeLessThan(
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

  QueryBuilder<Demande, Demande, QAfterFilterCondition> gpsLongitudeBetween(
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

  QueryBuilder<Demande, Demande, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Demande, Demande, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Demande, Demande, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Demande, Demande, QAfterFilterCondition> kiosqueLargeurEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kiosqueLargeur',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      kiosqueLargeurGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kiosqueLargeur',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> kiosqueLargeurLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kiosqueLargeur',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> kiosqueLargeurBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kiosqueLargeur',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> kiosqueLongueurEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kiosqueLongueur',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      kiosqueLongueurGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kiosqueLongueur',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> kiosqueLongueurLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kiosqueLongueur',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> kiosqueLongueurBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kiosqueLongueur',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      materiauxConstructionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'materiauxConstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      materiauxConstructionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'materiauxConstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      materiauxConstructionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'materiauxConstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      materiauxConstructionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'materiauxConstruction',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      materiauxConstructionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'materiauxConstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      materiauxConstructionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'materiauxConstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      materiauxConstructionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'materiauxConstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      materiauxConstructionMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'materiauxConstruction',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      materiauxConstructionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'materiauxConstruction',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      materiauxConstructionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'materiauxConstruction',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      montantDroitInstallationEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'montantDroitInstallation',
        value: value,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      montantDroitInstallationGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'montantDroitInstallation',
        value: value,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      montantDroitInstallationLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'montantDroitInstallation',
        value: value,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      montantDroitInstallationBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'montantDroitInstallation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> nomCommercialEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomCommercial',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      nomCommercialGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nomCommercial',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> nomCommercialLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nomCommercial',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> nomCommercialBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nomCommercial',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> nomCommercialStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nomCommercial',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> nomCommercialEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nomCommercial',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> nomCommercialContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nomCommercial',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> nomCommercialMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nomCommercial',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> nomCommercialIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomCommercial',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      nomCommercialIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nomCommercial',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> nomPrenomsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomPrenoms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> nomPrenomsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nomPrenoms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> nomPrenomsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nomPrenoms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> nomPrenomsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nomPrenoms',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> nomPrenomsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nomPrenoms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> nomPrenomsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nomPrenoms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> nomPrenomsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nomPrenoms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> nomPrenomsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nomPrenoms',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> nomPrenomsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomPrenoms',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> nomPrenomsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nomPrenoms',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> noteRejetEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'noteRejet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> noteRejetGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'noteRejet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> noteRejetLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'noteRejet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> noteRejetBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'noteRejet',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> noteRejetStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'noteRejet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> noteRejetEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'noteRejet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> noteRejetContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'noteRejet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> noteRejetMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'noteRejet',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> noteRejetIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'noteRejet',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> noteRejetIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'noteRejet',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      operateursElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'operateurs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      operateursElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'operateurs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      operateursElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'operateurs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      operateursElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'operateurs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      operateursElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'operateurs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      operateursElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'operateurs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      operateursElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'operateurs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      operateursElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'operateurs',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      operateursElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'operateurs',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      operateursElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'operateurs',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> operateursLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'operateurs',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> operateursIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'operateurs',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> operateursIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'operateurs',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      operateursLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'operateurs',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      operateursLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'operateurs',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> operateursLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'operateurs',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoCinRectoPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoCinRectoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoCinRectoPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'photoCinRectoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoCinRectoPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'photoCinRectoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoCinRectoPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'photoCinRectoPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoCinRectoPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'photoCinRectoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoCinRectoPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'photoCinRectoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoCinRectoPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'photoCinRectoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoCinRectoPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'photoCinRectoPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoCinRectoPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoCinRectoPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoCinRectoPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'photoCinRectoPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoCinVersoPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoCinVersoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoCinVersoPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'photoCinVersoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoCinVersoPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'photoCinVersoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoCinVersoPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'photoCinVersoPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoCinVersoPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'photoCinVersoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoCinVersoPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'photoCinVersoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoCinVersoPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'photoCinVersoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoCinVersoPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'photoCinVersoPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoCinVersoPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoCinVersoPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoCinVersoPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'photoCinVersoPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoEmplacementPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoEmplacementPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoEmplacementPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'photoEmplacementPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoEmplacementPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'photoEmplacementPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoEmplacementPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'photoEmplacementPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoEmplacementPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'photoEmplacementPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoEmplacementPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'photoEmplacementPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoEmplacementPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'photoEmplacementPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoEmplacementPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'photoEmplacementPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoEmplacementPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoEmplacementPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      photoEmplacementPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'photoEmplacementPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> quartierEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quartier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> quartierGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quartier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> quartierLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quartier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> quartierBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quartier',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> quartierStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'quartier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> quartierEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'quartier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> quartierContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'quartier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> quartierMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'quartier',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> quartierIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quartier',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> quartierIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quartier',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      soumiseLocalementEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soumiseLocalement',
        value: value,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> statutEqualTo(
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

  QueryBuilder<Demande, Demande, QAfterFilterCondition> statutGreaterThan(
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

  QueryBuilder<Demande, Demande, QAfterFilterCondition> statutLessThan(
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

  QueryBuilder<Demande, Demande, QAfterFilterCondition> statutBetween(
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

  QueryBuilder<Demande, Demande, QAfterFilterCondition> statutStartsWith(
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

  QueryBuilder<Demande, Demande, QAfterFilterCondition> statutEndsWith(
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

  QueryBuilder<Demande, Demande, QAfterFilterCondition> statutContains(
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

  QueryBuilder<Demande, Demande, QAfterFilterCondition> statutMatches(
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

  QueryBuilder<Demande, Demande, QAfterFilterCondition> statutIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statut',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> statutIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'statut',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      statutDroitInstallationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statutDroitInstallation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      statutDroitInstallationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'statutDroitInstallation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      statutDroitInstallationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'statutDroitInstallation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      statutDroitInstallationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'statutDroitInstallation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      statutDroitInstallationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'statutDroitInstallation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      statutDroitInstallationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'statutDroitInstallation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      statutDroitInstallationContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'statutDroitInstallation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      statutDroitInstallationMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'statutDroitInstallation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      statutDroitInstallationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statutDroitInstallation',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      statutDroitInstallationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'statutDroitInstallation',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> synchroniseEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'synchronise',
        value: value,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> telephoneEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'telephone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> telephoneGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'telephone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> telephoneLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'telephone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> telephoneBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'telephone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> telephoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'telephone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> telephoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'telephone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> telephoneContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'telephone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> telephoneMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'telephone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> telephoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'telephone',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition> telephoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'telephone',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      typeIdentificationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'typeIdentification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      typeIdentificationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'typeIdentification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      typeIdentificationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'typeIdentification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      typeIdentificationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'typeIdentification',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      typeIdentificationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'typeIdentification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      typeIdentificationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'typeIdentification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      typeIdentificationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'typeIdentification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      typeIdentificationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'typeIdentification',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      typeIdentificationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'typeIdentification',
        value: '',
      ));
    });
  }

  QueryBuilder<Demande, Demande, QAfterFilterCondition>
      typeIdentificationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'typeIdentification',
        value: '',
      ));
    });
  }
}

extension DemandeQueryObject
    on QueryBuilder<Demande, Demande, QFilterCondition> {}

extension DemandeQueryLinks
    on QueryBuilder<Demande, Demande, QFilterCondition> {}

extension DemandeQuerySortBy on QueryBuilder<Demande, Demande, QSortBy> {
  QueryBuilder<Demande, Demande, QAfterSortBy> sortByCin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cin', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByCinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cin', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByCinDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cinDate', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByCinDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cinDate', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByCinLieu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cinLieu', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByCinLieuDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cinLieu', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByCodeDossier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeDossier', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByCodeDossierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeDossier', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByDateCreation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateCreation', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByDateCreationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateCreation', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByDateSoumission() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSoumission', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByDateSoumissionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSoumission', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByEmplacementRepere() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emplacementRepere', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByEmplacementRepereDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emplacementRepere', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByFokontany() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fokontany', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByFokontanyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fokontany', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByGeorestrictionResultat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'georestrictionResultat', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy>
      sortByGeorestrictionResultatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'georestrictionResultat', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByGpsLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLatitude', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByGpsLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLatitude', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByGpsLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLongitude', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByGpsLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLongitude', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByKiosqueLargeur() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kiosqueLargeur', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByKiosqueLargeurDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kiosqueLargeur', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByKiosqueLongueur() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kiosqueLongueur', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByKiosqueLongueurDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kiosqueLongueur', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByMateriauxConstruction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materiauxConstruction', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy>
      sortByMateriauxConstructionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materiauxConstruction', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy>
      sortByMontantDroitInstallation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'montantDroitInstallation', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy>
      sortByMontantDroitInstallationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'montantDroitInstallation', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByNomCommercial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomCommercial', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByNomCommercialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomCommercial', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByNomPrenoms() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomPrenoms', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByNomPrenomsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomPrenoms', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByNoteRejet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteRejet', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByNoteRejetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteRejet', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByPhotoCinRectoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoCinRectoPath', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByPhotoCinRectoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoCinRectoPath', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByPhotoCinVersoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoCinVersoPath', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByPhotoCinVersoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoCinVersoPath', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByPhotoEmplacementPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoEmplacementPath', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy>
      sortByPhotoEmplacementPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoEmplacementPath', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByQuartier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quartier', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByQuartierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quartier', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortBySoumiseLocalement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soumiseLocalement', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortBySoumiseLocalementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soumiseLocalement', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByStatut() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statut', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByStatutDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statut', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByStatutDroitInstallation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statutDroitInstallation', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy>
      sortByStatutDroitInstallationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statutDroitInstallation', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortBySynchronise() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synchronise', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortBySynchroniseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synchronise', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByTelephone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'telephone', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByTelephoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'telephone', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByTypeIdentification() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeIdentification', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> sortByTypeIdentificationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeIdentification', Sort.desc);
    });
  }
}

extension DemandeQuerySortThenBy
    on QueryBuilder<Demande, Demande, QSortThenBy> {
  QueryBuilder<Demande, Demande, QAfterSortBy> thenByCin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cin', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByCinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cin', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByCinDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cinDate', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByCinDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cinDate', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByCinLieu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cinLieu', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByCinLieuDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cinLieu', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByCodeDossier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeDossier', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByCodeDossierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeDossier', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByDateCreation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateCreation', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByDateCreationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateCreation', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByDateSoumission() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSoumission', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByDateSoumissionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSoumission', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByEmplacementRepere() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emplacementRepere', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByEmplacementRepereDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emplacementRepere', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByFokontany() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fokontany', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByFokontanyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fokontany', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByGeorestrictionResultat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'georestrictionResultat', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy>
      thenByGeorestrictionResultatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'georestrictionResultat', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByGpsLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLatitude', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByGpsLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLatitude', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByGpsLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLongitude', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByGpsLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLongitude', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByKiosqueLargeur() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kiosqueLargeur', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByKiosqueLargeurDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kiosqueLargeur', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByKiosqueLongueur() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kiosqueLongueur', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByKiosqueLongueurDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kiosqueLongueur', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByMateriauxConstruction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materiauxConstruction', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy>
      thenByMateriauxConstructionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materiauxConstruction', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy>
      thenByMontantDroitInstallation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'montantDroitInstallation', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy>
      thenByMontantDroitInstallationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'montantDroitInstallation', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByNomCommercial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomCommercial', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByNomCommercialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomCommercial', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByNomPrenoms() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomPrenoms', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByNomPrenomsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomPrenoms', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByNoteRejet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteRejet', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByNoteRejetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteRejet', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByPhotoCinRectoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoCinRectoPath', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByPhotoCinRectoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoCinRectoPath', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByPhotoCinVersoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoCinVersoPath', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByPhotoCinVersoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoCinVersoPath', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByPhotoEmplacementPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoEmplacementPath', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy>
      thenByPhotoEmplacementPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoEmplacementPath', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByQuartier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quartier', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByQuartierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quartier', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenBySoumiseLocalement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soumiseLocalement', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenBySoumiseLocalementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soumiseLocalement', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByStatut() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statut', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByStatutDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statut', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByStatutDroitInstallation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statutDroitInstallation', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy>
      thenByStatutDroitInstallationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statutDroitInstallation', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenBySynchronise() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synchronise', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenBySynchroniseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synchronise', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByTelephone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'telephone', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByTelephoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'telephone', Sort.desc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByTypeIdentification() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeIdentification', Sort.asc);
    });
  }

  QueryBuilder<Demande, Demande, QAfterSortBy> thenByTypeIdentificationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeIdentification', Sort.desc);
    });
  }
}

extension DemandeQueryWhereDistinct
    on QueryBuilder<Demande, Demande, QDistinct> {
  QueryBuilder<Demande, Demande, QDistinct> distinctByCin(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cin', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByCinDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cinDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByCinLieu(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cinLieu', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByCodeDossier(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'codeDossier', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByDateCreation() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateCreation');
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByDateSoumission() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateSoumission');
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByEmplacementRepere(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emplacementRepere',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByFokontany(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fokontany', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByGeorestrictionResultat(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'georestrictionResultat',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByGpsLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gpsLatitude');
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByGpsLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gpsLongitude');
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByKiosqueLargeur() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kiosqueLargeur');
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByKiosqueLongueur() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kiosqueLongueur');
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByMateriauxConstruction(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'materiauxConstruction',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Demande, Demande, QDistinct>
      distinctByMontantDroitInstallation() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'montantDroitInstallation');
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByNomCommercial(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nomCommercial',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByNomPrenoms(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nomPrenoms', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByNoteRejet(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'noteRejet', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByOperateurs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'operateurs');
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByPhotoCinRectoPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoCinRectoPath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByPhotoCinVersoPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoCinVersoPath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByPhotoEmplacementPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoEmplacementPath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByQuartier(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quartier', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctBySoumiseLocalement() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'soumiseLocalement');
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByStatut(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statut', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByStatutDroitInstallation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statutDroitInstallation',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctBySynchronise() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'synchronise');
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByTelephone(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'telephone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Demande, Demande, QDistinct> distinctByTypeIdentification(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'typeIdentification',
          caseSensitive: caseSensitive);
    });
  }
}

extension DemandeQueryProperty
    on QueryBuilder<Demande, Demande, QQueryProperty> {
  QueryBuilder<Demande, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Demande, String, QQueryOperations> cinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cin');
    });
  }

  QueryBuilder<Demande, String, QQueryOperations> cinDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cinDate');
    });
  }

  QueryBuilder<Demande, String, QQueryOperations> cinLieuProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cinLieu');
    });
  }

  QueryBuilder<Demande, String, QQueryOperations> codeDossierProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'codeDossier');
    });
  }

  QueryBuilder<Demande, DateTime, QQueryOperations> dateCreationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateCreation');
    });
  }

  QueryBuilder<Demande, DateTime?, QQueryOperations> dateSoumissionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateSoumission');
    });
  }

  QueryBuilder<Demande, String, QQueryOperations> emplacementRepereProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emplacementRepere');
    });
  }

  QueryBuilder<Demande, String, QQueryOperations> fokontanyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fokontany');
    });
  }

  QueryBuilder<Demande, String, QQueryOperations>
      georestrictionResultatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'georestrictionResultat');
    });
  }

  QueryBuilder<Demande, double, QQueryOperations> gpsLatitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gpsLatitude');
    });
  }

  QueryBuilder<Demande, double, QQueryOperations> gpsLongitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gpsLongitude');
    });
  }

  QueryBuilder<Demande, double, QQueryOperations> kiosqueLargeurProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kiosqueLargeur');
    });
  }

  QueryBuilder<Demande, double, QQueryOperations> kiosqueLongueurProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kiosqueLongueur');
    });
  }

  QueryBuilder<Demande, String, QQueryOperations>
      materiauxConstructionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'materiauxConstruction');
    });
  }

  QueryBuilder<Demande, int, QQueryOperations>
      montantDroitInstallationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'montantDroitInstallation');
    });
  }

  QueryBuilder<Demande, String, QQueryOperations> nomCommercialProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nomCommercial');
    });
  }

  QueryBuilder<Demande, String, QQueryOperations> nomPrenomsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nomPrenoms');
    });
  }

  QueryBuilder<Demande, String, QQueryOperations> noteRejetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'noteRejet');
    });
  }

  QueryBuilder<Demande, List<String>, QQueryOperations> operateursProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'operateurs');
    });
  }

  QueryBuilder<Demande, String, QQueryOperations> photoCinRectoPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoCinRectoPath');
    });
  }

  QueryBuilder<Demande, String, QQueryOperations> photoCinVersoPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoCinVersoPath');
    });
  }

  QueryBuilder<Demande, String, QQueryOperations>
      photoEmplacementPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoEmplacementPath');
    });
  }

  QueryBuilder<Demande, String, QQueryOperations> quartierProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quartier');
    });
  }

  QueryBuilder<Demande, bool, QQueryOperations> soumiseLocalementProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'soumiseLocalement');
    });
  }

  QueryBuilder<Demande, String, QQueryOperations> statutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statut');
    });
  }

  QueryBuilder<Demande, String, QQueryOperations>
      statutDroitInstallationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statutDroitInstallation');
    });
  }

  QueryBuilder<Demande, bool, QQueryOperations> synchroniseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'synchronise');
    });
  }

  QueryBuilder<Demande, String, QQueryOperations> telephoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'telephone');
    });
  }

  QueryBuilder<Demande, String, QQueryOperations> typeIdentificationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'typeIdentification');
    });
  }
}
