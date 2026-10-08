// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kiosque.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetKiosqueCollection on Isar {
  IsarCollection<Kiosque> get kiosques => this.collection();
}

const KiosqueSchema = CollectionSchema(
  name: r'Kiosque',
  id: 1053209029122429147,
  properties: {
    r'autorisationDate': PropertySchema(
      id: 0,
      name: r'autorisationDate',
      type: IsarType.string,
    ),
    r'autorisationNumero': PropertySchema(
      id: 1,
      name: r'autorisationNumero',
      type: IsarType.string,
    ),
    r'avisPaiementDate': PropertySchema(
      id: 2,
      name: r'avisPaiementDate',
      type: IsarType.string,
    ),
    r'avisPaiementNumero': PropertySchema(
      id: 3,
      name: r'avisPaiementNumero',
      type: IsarType.string,
    ),
    r'campagneRecensement': PropertySchema(
      id: 4,
      name: r'campagneRecensement',
      type: IsarType.string,
    ),
    r'codeKiosque': PropertySchema(
      id: 5,
      name: r'codeKiosque',
      type: IsarType.string,
    ),
    r'codeReponseServeur': PropertySchema(
      id: 6,
      name: r'codeReponseServeur',
      type: IsarType.string,
    ),
    r'dateSoumission': PropertySchema(
      id: 7,
      name: r'dateSoumission',
      type: IsarType.string,
    ),
    r'dossierEncoursDate': PropertySchema(
      id: 8,
      name: r'dossierEncoursDate',
      type: IsarType.string,
    ),
    r'dossierEncoursNumero': PropertySchema(
      id: 9,
      name: r'dossierEncoursNumero',
      type: IsarType.string,
    ),
    r'emplacementRepere': PropertySchema(
      id: 10,
      name: r'emplacementRepere',
      type: IsarType.string,
    ),
    r'etatGeneral': PropertySchema(
      id: 11,
      name: r'etatGeneral',
      type: IsarType.string,
    ),
    r'fokontany': PropertySchema(
      id: 12,
      name: r'fokontany',
      type: IsarType.string,
    ),
    r'gpsLatitude': PropertySchema(
      id: 13,
      name: r'gpsLatitude',
      type: IsarType.double,
    ),
    r'gpsLongitude': PropertySchema(
      id: 14,
      name: r'gpsLongitude',
      type: IsarType.double,
    ),
    r'isSynchronised': PropertySchema(
      id: 15,
      name: r'isSynchronised',
      type: IsarType.bool,
    ),
    r'kiosqueLargeur': PropertySchema(
      id: 16,
      name: r'kiosqueLargeur',
      type: IsarType.double,
    ),
    r'kiosqueLongueur': PropertySchema(
      id: 17,
      name: r'kiosqueLongueur',
      type: IsarType.double,
    ),
    r'lastSeenAt': PropertySchema(
      id: 18,
      name: r'lastSeenAt',
      type: IsarType.dateTime,
    ),
    r'materiauxConstruction': PropertySchema(
      id: 19,
      name: r'materiauxConstruction',
      type: IsarType.string,
    ),
    r'moisRetardCalcules': PropertySchema(
      id: 20,
      name: r'moisRetardCalcules',
      type: IsarType.long,
    ),
    r'observationTerrain': PropertySchema(
      id: 21,
      name: r'observationTerrain',
      type: IsarType.string,
    ),
    r'operationsActives': PropertySchema(
      id: 22,
      name: r'operationsActives',
      type: IsarType.stringList,
    ),
    r'photoLocalPath': PropertySchema(
      id: 23,
      name: r'photoLocalPath',
      type: IsarType.string,
    ),
    r'photoUrl': PropertySchema(
      id: 24,
      name: r'photoUrl',
      type: IsarType.string,
    ),
    r'proprietaireNom': PropertySchema(
      id: 25,
      name: r'proprietaireNom',
      type: IsarType.string,
    ),
    r'proprietaireTelephone': PropertySchema(
      id: 26,
      name: r'proprietaireTelephone',
      type: IsarType.string,
    ),
    r'quittanceDate': PropertySchema(
      id: 27,
      name: r'quittanceDate',
      type: IsarType.string,
    ),
    r'quittanceNumero': PropertySchema(
      id: 28,
      name: r'quittanceNumero',
      type: IsarType.string,
    ),
    r'statutDroitInstallation': PropertySchema(
      id: 29,
      name: r'statutDroitInstallation',
      type: IsarType.string,
    ),
    r'statutFiche': PropertySchema(
      id: 30,
      name: r'statutFiche',
      type: IsarType.string,
    ),
    r'statutTaxeMensuelle': PropertySchema(
      id: 31,
      name: r'statutTaxeMensuelle',
      type: IsarType.string,
    ),
    r'taxesAnnuel': PropertySchema(
      id: 32,
      name: r'taxesAnnuel',
      type: IsarType.stringList,
    ),
    r'terrainOccupation': PropertySchema(
      id: 33,
      name: r'terrainOccupation',
      type: IsarType.string,
    ),
    r'totalDetteAriary': PropertySchema(
      id: 34,
      name: r'totalDetteAriary',
      type: IsarType.long,
    ),
    r'typeIdentification': PropertySchema(
      id: 35,
      name: r'typeIdentification',
      type: IsarType.string,
    ),
    r'voisins': PropertySchema(
      id: 36,
      name: r'voisins',
      type: IsarType.stringList,
    )
  },
  estimateSize: _kiosqueEstimateSize,
  serialize: _kiosqueSerialize,
  deserialize: _kiosqueDeserialize,
  deserializeProp: _kiosqueDeserializeProp,
  idName: r'id',
  indexes: {
    r'codeKiosque': IndexSchema(
      id: 8637926485884125188,
      name: r'codeKiosque',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'codeKiosque',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _kiosqueGetId,
  getLinks: _kiosqueGetLinks,
  attach: _kiosqueAttach,
  version: '3.1.0+1',
);

int _kiosqueEstimateSize(
  Kiosque object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.autorisationDate.length * 3;
  bytesCount += 3 + object.autorisationNumero.length * 3;
  bytesCount += 3 + object.avisPaiementDate.length * 3;
  bytesCount += 3 + object.avisPaiementNumero.length * 3;
  bytesCount += 3 + object.campagneRecensement.length * 3;
  bytesCount += 3 + object.codeKiosque.length * 3;
  bytesCount += 3 + object.codeReponseServeur.length * 3;
  bytesCount += 3 + object.dateSoumission.length * 3;
  bytesCount += 3 + object.dossierEncoursDate.length * 3;
  bytesCount += 3 + object.dossierEncoursNumero.length * 3;
  bytesCount += 3 + object.emplacementRepere.length * 3;
  bytesCount += 3 + object.etatGeneral.length * 3;
  bytesCount += 3 + object.fokontany.length * 3;
  bytesCount += 3 + object.materiauxConstruction.length * 3;
  bytesCount += 3 + object.observationTerrain.length * 3;
  bytesCount += 3 + object.operationsActives.length * 3;
  {
    for (var i = 0; i < object.operationsActives.length; i++) {
      final value = object.operationsActives[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.photoLocalPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.photoUrl.length * 3;
  bytesCount += 3 + object.proprietaireNom.length * 3;
  bytesCount += 3 + object.proprietaireTelephone.length * 3;
  bytesCount += 3 + object.quittanceDate.length * 3;
  bytesCount += 3 + object.quittanceNumero.length * 3;
  bytesCount += 3 + object.statutDroitInstallation.length * 3;
  bytesCount += 3 + object.statutFiche.length * 3;
  bytesCount += 3 + object.statutTaxeMensuelle.length * 3;
  bytesCount += 3 + object.taxesAnnuel.length * 3;
  {
    for (var i = 0; i < object.taxesAnnuel.length; i++) {
      final value = object.taxesAnnuel[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.terrainOccupation.length * 3;
  bytesCount += 3 + object.typeIdentification.length * 3;
  bytesCount += 3 + object.voisins.length * 3;
  {
    for (var i = 0; i < object.voisins.length; i++) {
      final value = object.voisins[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _kiosqueSerialize(
  Kiosque object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.autorisationDate);
  writer.writeString(offsets[1], object.autorisationNumero);
  writer.writeString(offsets[2], object.avisPaiementDate);
  writer.writeString(offsets[3], object.avisPaiementNumero);
  writer.writeString(offsets[4], object.campagneRecensement);
  writer.writeString(offsets[5], object.codeKiosque);
  writer.writeString(offsets[6], object.codeReponseServeur);
  writer.writeString(offsets[7], object.dateSoumission);
  writer.writeString(offsets[8], object.dossierEncoursDate);
  writer.writeString(offsets[9], object.dossierEncoursNumero);
  writer.writeString(offsets[10], object.emplacementRepere);
  writer.writeString(offsets[11], object.etatGeneral);
  writer.writeString(offsets[12], object.fokontany);
  writer.writeDouble(offsets[13], object.gpsLatitude);
  writer.writeDouble(offsets[14], object.gpsLongitude);
  writer.writeBool(offsets[15], object.isSynchronised);
  writer.writeDouble(offsets[16], object.kiosqueLargeur);
  writer.writeDouble(offsets[17], object.kiosqueLongueur);
  writer.writeDateTime(offsets[18], object.lastSeenAt);
  writer.writeString(offsets[19], object.materiauxConstruction);
  writer.writeLong(offsets[20], object.moisRetardCalcules);
  writer.writeString(offsets[21], object.observationTerrain);
  writer.writeStringList(offsets[22], object.operationsActives);
  writer.writeString(offsets[23], object.photoLocalPath);
  writer.writeString(offsets[24], object.photoUrl);
  writer.writeString(offsets[25], object.proprietaireNom);
  writer.writeString(offsets[26], object.proprietaireTelephone);
  writer.writeString(offsets[27], object.quittanceDate);
  writer.writeString(offsets[28], object.quittanceNumero);
  writer.writeString(offsets[29], object.statutDroitInstallation);
  writer.writeString(offsets[30], object.statutFiche);
  writer.writeString(offsets[31], object.statutTaxeMensuelle);
  writer.writeStringList(offsets[32], object.taxesAnnuel);
  writer.writeString(offsets[33], object.terrainOccupation);
  writer.writeLong(offsets[34], object.totalDetteAriary);
  writer.writeString(offsets[35], object.typeIdentification);
  writer.writeStringList(offsets[36], object.voisins);
}

Kiosque _kiosqueDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Kiosque(
    codeKiosque: reader.readString(offsets[5]),
  );
  object.autorisationDate = reader.readString(offsets[0]);
  object.autorisationNumero = reader.readString(offsets[1]);
  object.avisPaiementDate = reader.readString(offsets[2]);
  object.avisPaiementNumero = reader.readString(offsets[3]);
  object.campagneRecensement = reader.readString(offsets[4]);
  object.codeReponseServeur = reader.readString(offsets[6]);
  object.dateSoumission = reader.readString(offsets[7]);
  object.dossierEncoursDate = reader.readString(offsets[8]);
  object.dossierEncoursNumero = reader.readString(offsets[9]);
  object.emplacementRepere = reader.readString(offsets[10]);
  object.etatGeneral = reader.readString(offsets[11]);
  object.fokontany = reader.readString(offsets[12]);
  object.gpsLatitude = reader.readDouble(offsets[13]);
  object.gpsLongitude = reader.readDouble(offsets[14]);
  object.id = id;
  object.isSynchronised = reader.readBool(offsets[15]);
  object.kiosqueLargeur = reader.readDouble(offsets[16]);
  object.kiosqueLongueur = reader.readDouble(offsets[17]);
  object.lastSeenAt = reader.readDateTimeOrNull(offsets[18]);
  object.materiauxConstruction = reader.readString(offsets[19]);
  object.moisRetardCalcules = reader.readLong(offsets[20]);
  object.observationTerrain = reader.readString(offsets[21]);
  object.operationsActives = reader.readStringList(offsets[22]) ?? [];
  object.photoLocalPath = reader.readStringOrNull(offsets[23]);
  object.photoUrl = reader.readString(offsets[24]);
  object.proprietaireNom = reader.readString(offsets[25]);
  object.proprietaireTelephone = reader.readString(offsets[26]);
  object.quittanceDate = reader.readString(offsets[27]);
  object.quittanceNumero = reader.readString(offsets[28]);
  object.statutDroitInstallation = reader.readString(offsets[29]);
  object.statutFiche = reader.readString(offsets[30]);
  object.statutTaxeMensuelle = reader.readString(offsets[31]);
  object.taxesAnnuel = reader.readStringList(offsets[32]) ?? [];
  object.terrainOccupation = reader.readString(offsets[33]);
  object.totalDetteAriary = reader.readLong(offsets[34]);
  object.typeIdentification = reader.readString(offsets[35]);
  object.voisins = reader.readStringList(offsets[36]) ?? [];
  return object;
}

P _kiosqueDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readDouble(offset)) as P;
    case 14:
      return (reader.readDouble(offset)) as P;
    case 15:
      return (reader.readBool(offset)) as P;
    case 16:
      return (reader.readDouble(offset)) as P;
    case 17:
      return (reader.readDouble(offset)) as P;
    case 18:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 19:
      return (reader.readString(offset)) as P;
    case 20:
      return (reader.readLong(offset)) as P;
    case 21:
      return (reader.readString(offset)) as P;
    case 22:
      return (reader.readStringList(offset) ?? []) as P;
    case 23:
      return (reader.readStringOrNull(offset)) as P;
    case 24:
      return (reader.readString(offset)) as P;
    case 25:
      return (reader.readString(offset)) as P;
    case 26:
      return (reader.readString(offset)) as P;
    case 27:
      return (reader.readString(offset)) as P;
    case 28:
      return (reader.readString(offset)) as P;
    case 29:
      return (reader.readString(offset)) as P;
    case 30:
      return (reader.readString(offset)) as P;
    case 31:
      return (reader.readString(offset)) as P;
    case 32:
      return (reader.readStringList(offset) ?? []) as P;
    case 33:
      return (reader.readString(offset)) as P;
    case 34:
      return (reader.readLong(offset)) as P;
    case 35:
      return (reader.readString(offset)) as P;
    case 36:
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _kiosqueGetId(Kiosque object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _kiosqueGetLinks(Kiosque object) {
  return [];
}

void _kiosqueAttach(IsarCollection<dynamic> col, Id id, Kiosque object) {
  object.id = id;
}

extension KiosqueByIndex on IsarCollection<Kiosque> {
  Future<Kiosque?> getByCodeKiosque(String codeKiosque) {
    return getByIndex(r'codeKiosque', [codeKiosque]);
  }

  Kiosque? getByCodeKiosqueSync(String codeKiosque) {
    return getByIndexSync(r'codeKiosque', [codeKiosque]);
  }

  Future<bool> deleteByCodeKiosque(String codeKiosque) {
    return deleteByIndex(r'codeKiosque', [codeKiosque]);
  }

  bool deleteByCodeKiosqueSync(String codeKiosque) {
    return deleteByIndexSync(r'codeKiosque', [codeKiosque]);
  }

  Future<List<Kiosque?>> getAllByCodeKiosque(List<String> codeKiosqueValues) {
    final values = codeKiosqueValues.map((e) => [e]).toList();
    return getAllByIndex(r'codeKiosque', values);
  }

  List<Kiosque?> getAllByCodeKiosqueSync(List<String> codeKiosqueValues) {
    final values = codeKiosqueValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'codeKiosque', values);
  }

  Future<int> deleteAllByCodeKiosque(List<String> codeKiosqueValues) {
    final values = codeKiosqueValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'codeKiosque', values);
  }

  int deleteAllByCodeKiosqueSync(List<String> codeKiosqueValues) {
    final values = codeKiosqueValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'codeKiosque', values);
  }

  Future<Id> putByCodeKiosque(Kiosque object) {
    return putByIndex(r'codeKiosque', object);
  }

  Id putByCodeKiosqueSync(Kiosque object, {bool saveLinks = true}) {
    return putByIndexSync(r'codeKiosque', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByCodeKiosque(List<Kiosque> objects) {
    return putAllByIndex(r'codeKiosque', objects);
  }

  List<Id> putAllByCodeKiosqueSync(List<Kiosque> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'codeKiosque', objects, saveLinks: saveLinks);
  }
}

extension KiosqueQueryWhereSort on QueryBuilder<Kiosque, Kiosque, QWhere> {
  QueryBuilder<Kiosque, Kiosque, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension KiosqueQueryWhere on QueryBuilder<Kiosque, Kiosque, QWhereClause> {
  QueryBuilder<Kiosque, Kiosque, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Kiosque, Kiosque, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterWhereClause> idBetween(
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

  QueryBuilder<Kiosque, Kiosque, QAfterWhereClause> codeKiosqueEqualTo(
      String codeKiosque) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'codeKiosque',
        value: [codeKiosque],
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterWhereClause> codeKiosqueNotEqualTo(
      String codeKiosque) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'codeKiosque',
              lower: [],
              upper: [codeKiosque],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'codeKiosque',
              lower: [codeKiosque],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'codeKiosque',
              lower: [codeKiosque],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'codeKiosque',
              lower: [],
              upper: [codeKiosque],
              includeUpper: false,
            ));
      }
    });
  }
}

extension KiosqueQueryFilter
    on QueryBuilder<Kiosque, Kiosque, QFilterCondition> {
  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> autorisationDateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autorisationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      autorisationDateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'autorisationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      autorisationDateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'autorisationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> autorisationDateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'autorisationDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      autorisationDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'autorisationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      autorisationDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'autorisationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      autorisationDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'autorisationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> autorisationDateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'autorisationDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      autorisationDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autorisationDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      autorisationDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'autorisationDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      autorisationNumeroEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autorisationNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      autorisationNumeroGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'autorisationNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      autorisationNumeroLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'autorisationNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      autorisationNumeroBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'autorisationNumero',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      autorisationNumeroStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'autorisationNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      autorisationNumeroEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'autorisationNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      autorisationNumeroContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'autorisationNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      autorisationNumeroMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'autorisationNumero',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      autorisationNumeroIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autorisationNumero',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      autorisationNumeroIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'autorisationNumero',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> avisPaiementDateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avisPaiementDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      avisPaiementDateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avisPaiementDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      avisPaiementDateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avisPaiementDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> avisPaiementDateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avisPaiementDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      avisPaiementDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avisPaiementDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      avisPaiementDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avisPaiementDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      avisPaiementDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avisPaiementDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> avisPaiementDateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avisPaiementDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      avisPaiementDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avisPaiementDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      avisPaiementDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avisPaiementDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      avisPaiementNumeroEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avisPaiementNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      avisPaiementNumeroGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avisPaiementNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      avisPaiementNumeroLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avisPaiementNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      avisPaiementNumeroBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avisPaiementNumero',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      avisPaiementNumeroStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avisPaiementNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      avisPaiementNumeroEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avisPaiementNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      avisPaiementNumeroContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avisPaiementNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      avisPaiementNumeroMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avisPaiementNumero',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      avisPaiementNumeroIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avisPaiementNumero',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      avisPaiementNumeroIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avisPaiementNumero',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      campagneRecensementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'campagneRecensement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      campagneRecensementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'campagneRecensement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      campagneRecensementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'campagneRecensement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      campagneRecensementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'campagneRecensement',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      campagneRecensementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'campagneRecensement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      campagneRecensementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'campagneRecensement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      campagneRecensementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'campagneRecensement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      campagneRecensementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'campagneRecensement',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      campagneRecensementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'campagneRecensement',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      campagneRecensementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'campagneRecensement',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> codeKiosqueEqualTo(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> codeKiosqueGreaterThan(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> codeKiosqueLessThan(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> codeKiosqueBetween(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> codeKiosqueStartsWith(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> codeKiosqueEndsWith(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> codeKiosqueContains(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> codeKiosqueMatches(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> codeKiosqueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'codeKiosque',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      codeKiosqueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'codeKiosque',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      codeReponseServeurEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'codeReponseServeur',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      codeReponseServeurGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'codeReponseServeur',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      codeReponseServeurLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'codeReponseServeur',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      codeReponseServeurBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'codeReponseServeur',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      codeReponseServeurStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'codeReponseServeur',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      codeReponseServeurEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'codeReponseServeur',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      codeReponseServeurContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'codeReponseServeur',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      codeReponseServeurMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'codeReponseServeur',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      codeReponseServeurIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'codeReponseServeur',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      codeReponseServeurIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'codeReponseServeur',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> dateSoumissionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateSoumission',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dateSoumissionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateSoumission',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> dateSoumissionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateSoumission',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> dateSoumissionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateSoumission',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dateSoumissionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dateSoumission',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> dateSoumissionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dateSoumission',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> dateSoumissionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dateSoumission',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> dateSoumissionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dateSoumission',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dateSoumissionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateSoumission',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dateSoumissionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dateSoumission',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dossierEncoursDateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dossierEncoursDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dossierEncoursDateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dossierEncoursDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dossierEncoursDateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dossierEncoursDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dossierEncoursDateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dossierEncoursDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dossierEncoursDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dossierEncoursDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dossierEncoursDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dossierEncoursDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dossierEncoursDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dossierEncoursDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dossierEncoursDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dossierEncoursDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dossierEncoursDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dossierEncoursDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dossierEncoursDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dossierEncoursDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dossierEncoursNumeroEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dossierEncoursNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dossierEncoursNumeroGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dossierEncoursNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dossierEncoursNumeroLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dossierEncoursNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dossierEncoursNumeroBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dossierEncoursNumero',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dossierEncoursNumeroStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dossierEncoursNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dossierEncoursNumeroEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dossierEncoursNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dossierEncoursNumeroContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dossierEncoursNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dossierEncoursNumeroMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dossierEncoursNumero',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dossierEncoursNumeroIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dossierEncoursNumero',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      dossierEncoursNumeroIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dossierEncoursNumero',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      emplacementRepereContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emplacementRepere',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      emplacementRepereMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emplacementRepere',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      emplacementRepereIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emplacementRepere',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      emplacementRepereIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emplacementRepere',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> etatGeneralEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'etatGeneral',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> etatGeneralGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'etatGeneral',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> etatGeneralLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'etatGeneral',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> etatGeneralBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'etatGeneral',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> etatGeneralStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'etatGeneral',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> etatGeneralEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'etatGeneral',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> etatGeneralContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'etatGeneral',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> etatGeneralMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'etatGeneral',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> etatGeneralIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'etatGeneral',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      etatGeneralIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'etatGeneral',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> fokontanyEqualTo(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> fokontanyGreaterThan(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> fokontanyLessThan(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> fokontanyBetween(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> fokontanyStartsWith(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> fokontanyEndsWith(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> fokontanyContains(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> fokontanyMatches(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> fokontanyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fokontany',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> fokontanyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fokontany',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> gpsLatitudeEqualTo(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> gpsLatitudeGreaterThan(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> gpsLatitudeLessThan(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> gpsLatitudeBetween(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> gpsLongitudeEqualTo(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> gpsLongitudeGreaterThan(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> gpsLongitudeLessThan(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> gpsLongitudeBetween(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> isSynchronisedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynchronised',
        value: value,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> kiosqueLargeurEqualTo(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> kiosqueLargeurLessThan(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> kiosqueLargeurBetween(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> kiosqueLongueurEqualTo(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> kiosqueLongueurLessThan(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> kiosqueLongueurBetween(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> lastSeenAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastSeenAt',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> lastSeenAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastSeenAt',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> lastSeenAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastSeenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> lastSeenAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastSeenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> lastSeenAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastSeenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> lastSeenAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastSeenAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      materiauxConstructionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'materiauxConstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      materiauxConstructionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'materiauxConstruction',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      materiauxConstructionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'materiauxConstruction',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      moisRetardCalculesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'moisRetardCalcules',
        value: value,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      moisRetardCalculesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'moisRetardCalcules',
        value: value,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      moisRetardCalculesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'moisRetardCalcules',
        value: value,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      moisRetardCalculesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'moisRetardCalcules',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      observationTerrainEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'observationTerrain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      observationTerrainGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'observationTerrain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      observationTerrainLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'observationTerrain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      observationTerrainBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'observationTerrain',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      observationTerrainStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'observationTerrain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      observationTerrainEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'observationTerrain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      observationTerrainContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'observationTerrain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      observationTerrainMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'observationTerrain',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      observationTerrainIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'observationTerrain',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      observationTerrainIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'observationTerrain',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      operationsActivesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'operationsActives',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      operationsActivesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'operationsActives',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      operationsActivesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'operationsActives',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      operationsActivesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'operationsActives',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      operationsActivesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'operationsActives',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      operationsActivesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'operationsActives',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      operationsActivesElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'operationsActives',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      operationsActivesElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'operationsActives',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      operationsActivesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'operationsActives',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      operationsActivesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'operationsActives',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      operationsActivesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'operationsActives',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      operationsActivesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'operationsActives',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      operationsActivesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'operationsActives',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      operationsActivesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'operationsActives',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      operationsActivesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'operationsActives',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      operationsActivesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'operationsActives',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> photoLocalPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'photoLocalPath',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      photoLocalPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'photoLocalPath',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> photoLocalPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoLocalPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      photoLocalPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'photoLocalPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> photoLocalPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'photoLocalPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> photoLocalPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'photoLocalPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      photoLocalPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'photoLocalPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> photoLocalPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'photoLocalPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> photoLocalPathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'photoLocalPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> photoLocalPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'photoLocalPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      photoLocalPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoLocalPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      photoLocalPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'photoLocalPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> photoUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> photoUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> photoUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> photoUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'photoUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> photoUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> photoUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> photoUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> photoUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'photoUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> photoUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> photoUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'photoUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> proprietaireNomEqualTo(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> proprietaireNomLessThan(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> proprietaireNomBetween(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> proprietaireNomEndsWith(
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> proprietaireNomContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'proprietaireNom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> proprietaireNomMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'proprietaireNom',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      proprietaireNomIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proprietaireNom',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      proprietaireNomIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'proprietaireNom',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      proprietaireTelephoneEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proprietaireTelephone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      proprietaireTelephoneGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proprietaireTelephone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      proprietaireTelephoneLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proprietaireTelephone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      proprietaireTelephoneBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proprietaireTelephone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      proprietaireTelephoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'proprietaireTelephone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      proprietaireTelephoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'proprietaireTelephone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      proprietaireTelephoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'proprietaireTelephone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      proprietaireTelephoneMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'proprietaireTelephone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      proprietaireTelephoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proprietaireTelephone',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      proprietaireTelephoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'proprietaireTelephone',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> quittanceDateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quittanceDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      quittanceDateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quittanceDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> quittanceDateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quittanceDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> quittanceDateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quittanceDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> quittanceDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'quittanceDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> quittanceDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'quittanceDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> quittanceDateContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'quittanceDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> quittanceDateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'quittanceDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> quittanceDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quittanceDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      quittanceDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quittanceDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> quittanceNumeroEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quittanceNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      quittanceNumeroGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quittanceNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> quittanceNumeroLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quittanceNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> quittanceNumeroBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quittanceNumero',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      quittanceNumeroStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'quittanceNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> quittanceNumeroEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'quittanceNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> quittanceNumeroContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'quittanceNumero',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> quittanceNumeroMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'quittanceNumero',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      quittanceNumeroIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quittanceNumero',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      quittanceNumeroIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quittanceNumero',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      statutDroitInstallationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statutDroitInstallation',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      statutDroitInstallationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'statutDroitInstallation',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> statutFicheEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statutFiche',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> statutFicheGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'statutFiche',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> statutFicheLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'statutFiche',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> statutFicheBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'statutFiche',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> statutFicheStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'statutFiche',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> statutFicheEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'statutFiche',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> statutFicheContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'statutFiche',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> statutFicheMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'statutFiche',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> statutFicheIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statutFiche',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      statutFicheIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'statutFiche',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      statutTaxeMensuelleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statutTaxeMensuelle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      statutTaxeMensuelleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'statutTaxeMensuelle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      statutTaxeMensuelleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'statutTaxeMensuelle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      statutTaxeMensuelleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'statutTaxeMensuelle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      statutTaxeMensuelleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'statutTaxeMensuelle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      statutTaxeMensuelleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'statutTaxeMensuelle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      statutTaxeMensuelleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'statutTaxeMensuelle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      statutTaxeMensuelleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'statutTaxeMensuelle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      statutTaxeMensuelleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statutTaxeMensuelle',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      statutTaxeMensuelleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'statutTaxeMensuelle',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      taxesAnnuelElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taxesAnnuel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      taxesAnnuelElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'taxesAnnuel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      taxesAnnuelElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'taxesAnnuel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      taxesAnnuelElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'taxesAnnuel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      taxesAnnuelElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'taxesAnnuel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      taxesAnnuelElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'taxesAnnuel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      taxesAnnuelElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'taxesAnnuel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      taxesAnnuelElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'taxesAnnuel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      taxesAnnuelElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taxesAnnuel',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      taxesAnnuelElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'taxesAnnuel',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      taxesAnnuelLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'taxesAnnuel',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> taxesAnnuelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'taxesAnnuel',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      taxesAnnuelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'taxesAnnuel',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      taxesAnnuelLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'taxesAnnuel',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      taxesAnnuelLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'taxesAnnuel',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      taxesAnnuelLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'taxesAnnuel',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      terrainOccupationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'terrainOccupation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      terrainOccupationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'terrainOccupation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      terrainOccupationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'terrainOccupation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      terrainOccupationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'terrainOccupation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      terrainOccupationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'terrainOccupation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      terrainOccupationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'terrainOccupation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      terrainOccupationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'terrainOccupation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      terrainOccupationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'terrainOccupation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      terrainOccupationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'terrainOccupation',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      terrainOccupationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'terrainOccupation',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> totalDetteAriaryEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalDetteAriary',
        value: value,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      totalDetteAriaryGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalDetteAriary',
        value: value,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      totalDetteAriaryLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalDetteAriary',
        value: value,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> totalDetteAriaryBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalDetteAriary',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
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

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      typeIdentificationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'typeIdentification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      typeIdentificationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'typeIdentification',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      typeIdentificationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'typeIdentification',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      typeIdentificationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'typeIdentification',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> voisinsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'voisins',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      voisinsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'voisins',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> voisinsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'voisins',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> voisinsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'voisins',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      voisinsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'voisins',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> voisinsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'voisins',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> voisinsElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'voisins',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> voisinsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'voisins',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      voisinsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'voisins',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      voisinsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'voisins',
        value: '',
      ));
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> voisinsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'voisins',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> voisinsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'voisins',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> voisinsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'voisins',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> voisinsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'voisins',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition>
      voisinsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'voisins',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterFilterCondition> voisinsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'voisins',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension KiosqueQueryObject
    on QueryBuilder<Kiosque, Kiosque, QFilterCondition> {}

extension KiosqueQueryLinks
    on QueryBuilder<Kiosque, Kiosque, QFilterCondition> {}

extension KiosqueQuerySortBy on QueryBuilder<Kiosque, Kiosque, QSortBy> {
  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByAutorisationDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autorisationDate', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByAutorisationDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autorisationDate', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByAutorisationNumero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autorisationNumero', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByAutorisationNumeroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autorisationNumero', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByAvisPaiementDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avisPaiementDate', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByAvisPaiementDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avisPaiementDate', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByAvisPaiementNumero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avisPaiementNumero', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByAvisPaiementNumeroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avisPaiementNumero', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByCampagneRecensement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'campagneRecensement', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByCampagneRecensementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'campagneRecensement', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByCodeKiosque() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeKiosque', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByCodeKiosqueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeKiosque', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByCodeReponseServeur() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeReponseServeur', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByCodeReponseServeurDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeReponseServeur', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByDateSoumission() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSoumission', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByDateSoumissionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSoumission', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByDossierEncoursDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dossierEncoursDate', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByDossierEncoursDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dossierEncoursDate', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByDossierEncoursNumero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dossierEncoursNumero', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy>
      sortByDossierEncoursNumeroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dossierEncoursNumero', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByEmplacementRepere() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emplacementRepere', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByEmplacementRepereDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emplacementRepere', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByEtatGeneral() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'etatGeneral', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByEtatGeneralDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'etatGeneral', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByFokontany() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fokontany', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByFokontanyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fokontany', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByGpsLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLatitude', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByGpsLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLatitude', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByGpsLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLongitude', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByGpsLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLongitude', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByIsSynchronised() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynchronised', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByIsSynchronisedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynchronised', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByKiosqueLargeur() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kiosqueLargeur', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByKiosqueLargeurDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kiosqueLargeur', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByKiosqueLongueur() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kiosqueLongueur', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByKiosqueLongueurDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kiosqueLongueur', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByLastSeenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeenAt', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByLastSeenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeenAt', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByMateriauxConstruction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materiauxConstruction', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy>
      sortByMateriauxConstructionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materiauxConstruction', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByMoisRetardCalcules() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moisRetardCalcules', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByMoisRetardCalculesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moisRetardCalcules', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByObservationTerrain() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observationTerrain', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByObservationTerrainDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observationTerrain', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByPhotoLocalPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoLocalPath', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByPhotoLocalPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoLocalPath', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByPhotoUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoUrl', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByPhotoUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoUrl', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByProprietaireNom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proprietaireNom', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByProprietaireNomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proprietaireNom', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByProprietaireTelephone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proprietaireTelephone', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy>
      sortByProprietaireTelephoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proprietaireTelephone', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByQuittanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quittanceDate', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByQuittanceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quittanceDate', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByQuittanceNumero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quittanceNumero', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByQuittanceNumeroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quittanceNumero', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByStatutDroitInstallation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statutDroitInstallation', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy>
      sortByStatutDroitInstallationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statutDroitInstallation', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByStatutFiche() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statutFiche', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByStatutFicheDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statutFiche', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByStatutTaxeMensuelle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statutTaxeMensuelle', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByStatutTaxeMensuelleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statutTaxeMensuelle', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByTerrainOccupation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'terrainOccupation', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByTerrainOccupationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'terrainOccupation', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByTotalDetteAriary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDetteAriary', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByTotalDetteAriaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDetteAriary', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByTypeIdentification() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeIdentification', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> sortByTypeIdentificationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeIdentification', Sort.desc);
    });
  }
}

extension KiosqueQuerySortThenBy
    on QueryBuilder<Kiosque, Kiosque, QSortThenBy> {
  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByAutorisationDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autorisationDate', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByAutorisationDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autorisationDate', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByAutorisationNumero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autorisationNumero', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByAutorisationNumeroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autorisationNumero', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByAvisPaiementDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avisPaiementDate', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByAvisPaiementDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avisPaiementDate', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByAvisPaiementNumero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avisPaiementNumero', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByAvisPaiementNumeroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avisPaiementNumero', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByCampagneRecensement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'campagneRecensement', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByCampagneRecensementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'campagneRecensement', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByCodeKiosque() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeKiosque', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByCodeKiosqueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeKiosque', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByCodeReponseServeur() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeReponseServeur', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByCodeReponseServeurDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codeReponseServeur', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByDateSoumission() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSoumission', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByDateSoumissionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSoumission', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByDossierEncoursDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dossierEncoursDate', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByDossierEncoursDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dossierEncoursDate', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByDossierEncoursNumero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dossierEncoursNumero', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy>
      thenByDossierEncoursNumeroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dossierEncoursNumero', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByEmplacementRepere() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emplacementRepere', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByEmplacementRepereDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emplacementRepere', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByEtatGeneral() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'etatGeneral', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByEtatGeneralDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'etatGeneral', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByFokontany() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fokontany', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByFokontanyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fokontany', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByGpsLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLatitude', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByGpsLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLatitude', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByGpsLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLongitude', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByGpsLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLongitude', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByIsSynchronised() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynchronised', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByIsSynchronisedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynchronised', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByKiosqueLargeur() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kiosqueLargeur', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByKiosqueLargeurDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kiosqueLargeur', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByKiosqueLongueur() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kiosqueLongueur', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByKiosqueLongueurDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kiosqueLongueur', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByLastSeenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeenAt', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByLastSeenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeenAt', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByMateriauxConstruction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materiauxConstruction', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy>
      thenByMateriauxConstructionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materiauxConstruction', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByMoisRetardCalcules() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moisRetardCalcules', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByMoisRetardCalculesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moisRetardCalcules', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByObservationTerrain() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observationTerrain', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByObservationTerrainDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observationTerrain', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByPhotoLocalPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoLocalPath', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByPhotoLocalPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoLocalPath', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByPhotoUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoUrl', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByPhotoUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoUrl', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByProprietaireNom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proprietaireNom', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByProprietaireNomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proprietaireNom', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByProprietaireTelephone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proprietaireTelephone', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy>
      thenByProprietaireTelephoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proprietaireTelephone', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByQuittanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quittanceDate', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByQuittanceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quittanceDate', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByQuittanceNumero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quittanceNumero', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByQuittanceNumeroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quittanceNumero', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByStatutDroitInstallation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statutDroitInstallation', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy>
      thenByStatutDroitInstallationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statutDroitInstallation', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByStatutFiche() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statutFiche', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByStatutFicheDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statutFiche', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByStatutTaxeMensuelle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statutTaxeMensuelle', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByStatutTaxeMensuelleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statutTaxeMensuelle', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByTerrainOccupation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'terrainOccupation', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByTerrainOccupationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'terrainOccupation', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByTotalDetteAriary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDetteAriary', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByTotalDetteAriaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDetteAriary', Sort.desc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByTypeIdentification() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeIdentification', Sort.asc);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QAfterSortBy> thenByTypeIdentificationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeIdentification', Sort.desc);
    });
  }
}

extension KiosqueQueryWhereDistinct
    on QueryBuilder<Kiosque, Kiosque, QDistinct> {
  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByAutorisationDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'autorisationDate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByAutorisationNumero(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'autorisationNumero',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByAvisPaiementDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avisPaiementDate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByAvisPaiementNumero(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avisPaiementNumero',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByCampagneRecensement(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'campagneRecensement',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByCodeKiosque(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'codeKiosque', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByCodeReponseServeur(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'codeReponseServeur',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByDateSoumission(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateSoumission',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByDossierEncoursDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dossierEncoursDate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByDossierEncoursNumero(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dossierEncoursNumero',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByEmplacementRepere(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emplacementRepere',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByEtatGeneral(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'etatGeneral', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByFokontany(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fokontany', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByGpsLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gpsLatitude');
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByGpsLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gpsLongitude');
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByIsSynchronised() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynchronised');
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByKiosqueLargeur() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kiosqueLargeur');
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByKiosqueLongueur() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kiosqueLongueur');
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByLastSeenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSeenAt');
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByMateriauxConstruction(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'materiauxConstruction',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByMoisRetardCalcules() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'moisRetardCalcules');
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByObservationTerrain(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'observationTerrain',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByOperationsActives() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'operationsActives');
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByPhotoLocalPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoLocalPath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByPhotoUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByProprietaireNom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proprietaireNom',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByProprietaireTelephone(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proprietaireTelephone',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByQuittanceDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quittanceDate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByQuittanceNumero(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quittanceNumero',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByStatutDroitInstallation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statutDroitInstallation',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByStatutFiche(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statutFiche', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByStatutTaxeMensuelle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statutTaxeMensuelle',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByTaxesAnnuel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'taxesAnnuel');
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByTerrainOccupation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'terrainOccupation',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByTotalDetteAriary() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalDetteAriary');
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByTypeIdentification(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'typeIdentification',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Kiosque, Kiosque, QDistinct> distinctByVoisins() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'voisins');
    });
  }
}

extension KiosqueQueryProperty
    on QueryBuilder<Kiosque, Kiosque, QQueryProperty> {
  QueryBuilder<Kiosque, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations> autorisationDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'autorisationDate');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations> autorisationNumeroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'autorisationNumero');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations> avisPaiementDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avisPaiementDate');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations> avisPaiementNumeroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avisPaiementNumero');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations>
      campagneRecensementProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'campagneRecensement');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations> codeKiosqueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'codeKiosque');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations> codeReponseServeurProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'codeReponseServeur');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations> dateSoumissionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateSoumission');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations> dossierEncoursDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dossierEncoursDate');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations>
      dossierEncoursNumeroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dossierEncoursNumero');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations> emplacementRepereProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emplacementRepere');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations> etatGeneralProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'etatGeneral');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations> fokontanyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fokontany');
    });
  }

  QueryBuilder<Kiosque, double, QQueryOperations> gpsLatitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gpsLatitude');
    });
  }

  QueryBuilder<Kiosque, double, QQueryOperations> gpsLongitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gpsLongitude');
    });
  }

  QueryBuilder<Kiosque, bool, QQueryOperations> isSynchronisedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynchronised');
    });
  }

  QueryBuilder<Kiosque, double, QQueryOperations> kiosqueLargeurProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kiosqueLargeur');
    });
  }

  QueryBuilder<Kiosque, double, QQueryOperations> kiosqueLongueurProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kiosqueLongueur');
    });
  }

  QueryBuilder<Kiosque, DateTime?, QQueryOperations> lastSeenAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSeenAt');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations>
      materiauxConstructionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'materiauxConstruction');
    });
  }

  QueryBuilder<Kiosque, int, QQueryOperations> moisRetardCalculesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'moisRetardCalcules');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations> observationTerrainProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'observationTerrain');
    });
  }

  QueryBuilder<Kiosque, List<String>, QQueryOperations>
      operationsActivesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'operationsActives');
    });
  }

  QueryBuilder<Kiosque, String?, QQueryOperations> photoLocalPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoLocalPath');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations> photoUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoUrl');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations> proprietaireNomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proprietaireNom');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations>
      proprietaireTelephoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proprietaireTelephone');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations> quittanceDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quittanceDate');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations> quittanceNumeroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quittanceNumero');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations>
      statutDroitInstallationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statutDroitInstallation');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations> statutFicheProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statutFiche');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations>
      statutTaxeMensuelleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statutTaxeMensuelle');
    });
  }

  QueryBuilder<Kiosque, List<String>, QQueryOperations> taxesAnnuelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taxesAnnuel');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations> terrainOccupationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'terrainOccupation');
    });
  }

  QueryBuilder<Kiosque, int, QQueryOperations> totalDetteAriaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalDetteAriary');
    });
  }

  QueryBuilder<Kiosque, String, QQueryOperations> typeIdentificationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'typeIdentification');
    });
  }

  QueryBuilder<Kiosque, List<String>, QQueryOperations> voisinsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'voisins');
    });
  }
}
