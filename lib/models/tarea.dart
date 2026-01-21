import 'package:isar/isar.dart';

part 'tarea.g.dart';

enum Prioridad { baja, media, alta, critica }

enum Columna { porHacer, enProceso, pendientes, completadas }

@collection
class Tarea {
  Id id = Isar.autoIncrement;

  late String titulo;

  String proyecto = 'Proyecto';

  String? descripcion;

  @enumerated
  late Prioridad prioridad;

  late double storyPoints;

  @enumerated
  late Columna columna;

  late DateTime fechaCreacion;

  Tarea({
    this.id = Isar.autoIncrement,
    required this.titulo,
    this.proyecto = 'Proyecto',
    this.descripcion,
    this.prioridad = Prioridad.media,
    this.storyPoints = 1.0,
    this.columna = Columna.porHacer,
  }) {
    fechaCreacion = DateTime.now();
  }
}
