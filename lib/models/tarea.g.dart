// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarea.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTareaCollection on Isar {
  IsarCollection<Tarea> get tareas => this.collection();
}

const TareaSchema = CollectionSchema(
  name: r'Tarea',
  id: -5244095887261032780,
  properties: {
    r'columna': PropertySchema(
      id: 0,
      name: r'columna',
      type: IsarType.byte,
      enumMap: _TareacolumnaEnumValueMap,
    ),
    r'descripcion': PropertySchema(
      id: 1,
      name: r'descripcion',
      type: IsarType.string,
    ),
    r'fechaCreacion': PropertySchema(
      id: 2,
      name: r'fechaCreacion',
      type: IsarType.dateTime,
    ),
    r'prioridad': PropertySchema(
      id: 3,
      name: r'prioridad',
      type: IsarType.byte,
      enumMap: _TareaprioridadEnumValueMap,
    ),
    r'proyecto': PropertySchema(
      id: 4,
      name: r'proyecto',
      type: IsarType.string,
    ),
    r'storyPoints': PropertySchema(
      id: 5,
      name: r'storyPoints',
      type: IsarType.double,
    ),
    r'titulo': PropertySchema(
      id: 6,
      name: r'titulo',
      type: IsarType.string,
    )
  },
  estimateSize: _tareaEstimateSize,
  serialize: _tareaSerialize,
  deserialize: _tareaDeserialize,
  deserializeProp: _tareaDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _tareaGetId,
  getLinks: _tareaGetLinks,
  attach: _tareaAttach,
  version: '3.1.0+1',
);

int _tareaEstimateSize(
  Tarea object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.descripcion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.proyecto.length * 3;
  bytesCount += 3 + object.titulo.length * 3;
  return bytesCount;
}

void _tareaSerialize(
  Tarea object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.columna.index);
  writer.writeString(offsets[1], object.descripcion);
  writer.writeDateTime(offsets[2], object.fechaCreacion);
  writer.writeByte(offsets[3], object.prioridad.index);
  writer.writeString(offsets[4], object.proyecto);
  writer.writeDouble(offsets[5], object.storyPoints);
  writer.writeString(offsets[6], object.titulo);
}

Tarea _tareaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Tarea(
    columna: _TareacolumnaValueEnumMap[reader.readByteOrNull(offsets[0])] ??
        Columna.porHacer,
    descripcion: reader.readStringOrNull(offsets[1]),
    id: id,
    prioridad: _TareaprioridadValueEnumMap[reader.readByteOrNull(offsets[3])] ??
        Prioridad.media,
    proyecto: reader.readStringOrNull(offsets[4]) ?? 'Proyecto',
    storyPoints: reader.readDoubleOrNull(offsets[5]) ?? 1.0,
    titulo: reader.readString(offsets[6]),
  );
  object.fechaCreacion = reader.readDateTime(offsets[2]);
  return object;
}

P _tareaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_TareacolumnaValueEnumMap[reader.readByteOrNull(offset)] ??
          Columna.porHacer) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (_TareaprioridadValueEnumMap[reader.readByteOrNull(offset)] ??
          Prioridad.media) as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? 'Proyecto') as P;
    case 5:
      return (reader.readDoubleOrNull(offset) ?? 1.0) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TareacolumnaEnumValueMap = {
  'porHacer': 0,
  'enProceso': 1,
  'pendientes': 2,
  'completadas': 3,
};
const _TareacolumnaValueEnumMap = {
  0: Columna.porHacer,
  1: Columna.enProceso,
  2: Columna.pendientes,
  3: Columna.completadas,
};
const _TareaprioridadEnumValueMap = {
  'baja': 0,
  'media': 1,
  'alta': 2,
  'critica': 3,
};
const _TareaprioridadValueEnumMap = {
  0: Prioridad.baja,
  1: Prioridad.media,
  2: Prioridad.alta,
  3: Prioridad.critica,
};

Id _tareaGetId(Tarea object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tareaGetLinks(Tarea object) {
  return [];
}

void _tareaAttach(IsarCollection<dynamic> col, Id id, Tarea object) {
  object.id = id;
}

extension TareaQueryWhereSort on QueryBuilder<Tarea, Tarea, QWhere> {
  QueryBuilder<Tarea, Tarea, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TareaQueryWhere on QueryBuilder<Tarea, Tarea, QWhereClause> {
  QueryBuilder<Tarea, Tarea, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Tarea, Tarea, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterWhereClause> idBetween(
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

extension TareaQueryFilter on QueryBuilder<Tarea, Tarea, QFilterCondition> {
  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> columnaEqualTo(
      Columna value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'columna',
        value: value,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> columnaGreaterThan(
    Columna value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'columna',
        value: value,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> columnaLessThan(
    Columna value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'columna',
        value: value,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> columnaBetween(
    Columna lower,
    Columna upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'columna',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> descripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'descripcion',
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> descripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'descripcion',
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> descripcionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> descripcionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> descripcionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> descripcionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'descripcion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> descripcionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> descripcionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> descripcionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> descripcionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'descripcion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> descripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> descripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'descripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> fechaCreacionEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaCreacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> fechaCreacionGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaCreacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> fechaCreacionLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaCreacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> fechaCreacionBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaCreacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> prioridadEqualTo(
      Prioridad value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prioridad',
        value: value,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> prioridadGreaterThan(
    Prioridad value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'prioridad',
        value: value,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> prioridadLessThan(
    Prioridad value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'prioridad',
        value: value,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> prioridadBetween(
    Prioridad lower,
    Prioridad upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'prioridad',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> proyectoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proyecto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> proyectoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proyecto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> proyectoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proyecto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> proyectoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proyecto',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> proyectoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'proyecto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> proyectoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'proyecto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> proyectoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'proyecto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> proyectoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'proyecto',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> proyectoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proyecto',
        value: '',
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> proyectoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'proyecto',
        value: '',
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> storyPointsEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'storyPoints',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> storyPointsGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'storyPoints',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> storyPointsLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'storyPoints',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> storyPointsBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'storyPoints',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> tituloEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> tituloGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> tituloLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> tituloBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'titulo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> tituloStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> tituloEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> tituloContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> tituloMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'titulo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> tituloIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titulo',
        value: '',
      ));
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterFilterCondition> tituloIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'titulo',
        value: '',
      ));
    });
  }
}

extension TareaQueryObject on QueryBuilder<Tarea, Tarea, QFilterCondition> {}

extension TareaQueryLinks on QueryBuilder<Tarea, Tarea, QFilterCondition> {}

extension TareaQuerySortBy on QueryBuilder<Tarea, Tarea, QSortBy> {
  QueryBuilder<Tarea, Tarea, QAfterSortBy> sortByColumna() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'columna', Sort.asc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> sortByColumnaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'columna', Sort.desc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> sortByDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.asc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> sortByDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.desc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> sortByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.asc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> sortByFechaCreacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.desc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> sortByPrioridad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prioridad', Sort.asc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> sortByPrioridadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prioridad', Sort.desc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> sortByProyecto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proyecto', Sort.asc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> sortByProyectoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proyecto', Sort.desc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> sortByStoryPoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storyPoints', Sort.asc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> sortByStoryPointsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storyPoints', Sort.desc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> sortByTitulo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.asc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> sortByTituloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.desc);
    });
  }
}

extension TareaQuerySortThenBy on QueryBuilder<Tarea, Tarea, QSortThenBy> {
  QueryBuilder<Tarea, Tarea, QAfterSortBy> thenByColumna() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'columna', Sort.asc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> thenByColumnaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'columna', Sort.desc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> thenByDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.asc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> thenByDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.desc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> thenByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.asc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> thenByFechaCreacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.desc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> thenByPrioridad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prioridad', Sort.asc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> thenByPrioridadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prioridad', Sort.desc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> thenByProyecto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proyecto', Sort.asc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> thenByProyectoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proyecto', Sort.desc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> thenByStoryPoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storyPoints', Sort.asc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> thenByStoryPointsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storyPoints', Sort.desc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> thenByTitulo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.asc);
    });
  }

  QueryBuilder<Tarea, Tarea, QAfterSortBy> thenByTituloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.desc);
    });
  }
}

extension TareaQueryWhereDistinct on QueryBuilder<Tarea, Tarea, QDistinct> {
  QueryBuilder<Tarea, Tarea, QDistinct> distinctByColumna() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'columna');
    });
  }

  QueryBuilder<Tarea, Tarea, QDistinct> distinctByDescripcion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descripcion', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tarea, Tarea, QDistinct> distinctByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaCreacion');
    });
  }

  QueryBuilder<Tarea, Tarea, QDistinct> distinctByPrioridad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prioridad');
    });
  }

  QueryBuilder<Tarea, Tarea, QDistinct> distinctByProyecto(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proyecto', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tarea, Tarea, QDistinct> distinctByStoryPoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'storyPoints');
    });
  }

  QueryBuilder<Tarea, Tarea, QDistinct> distinctByTitulo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'titulo', caseSensitive: caseSensitive);
    });
  }
}

extension TareaQueryProperty on QueryBuilder<Tarea, Tarea, QQueryProperty> {
  QueryBuilder<Tarea, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Tarea, Columna, QQueryOperations> columnaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'columna');
    });
  }

  QueryBuilder<Tarea, String?, QQueryOperations> descripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descripcion');
    });
  }

  QueryBuilder<Tarea, DateTime, QQueryOperations> fechaCreacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaCreacion');
    });
  }

  QueryBuilder<Tarea, Prioridad, QQueryOperations> prioridadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prioridad');
    });
  }

  QueryBuilder<Tarea, String, QQueryOperations> proyectoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proyecto');
    });
  }

  QueryBuilder<Tarea, double, QQueryOperations> storyPointsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'storyPoints');
    });
  }

  QueryBuilder<Tarea, String, QQueryOperations> tituloProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'titulo');
    });
  }
}
