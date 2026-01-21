import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/tarea.dart';

class IsarService {
  static final IsarService _instance = IsarService._internal();
  factory IsarService() => _instance;
  IsarService._internal();

  Isar? _isar;

  Future<Isar> get isar async {
    if (_isar != null) return _isar!;
    _isar = await _initIsar();
    return _isar!;
  }

  /// Acceso sincrónico a Isar (solo usar después de inicialización)
  Isar? get isarSync => _isar;

  Future<Isar> _initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    final isarInstance = await Isar.open([TareaSchema], directory: dir.path);
    await _migrateProjectField(isarInstance);
    return isarInstance;
  }

  Future<void> _migrateProjectField(Isar db) async {
    final tareasSinProyecto = await db.tareas
        .filter()
        .proyectoEqualTo('')
        .findAll();

    if (tareasSinProyecto.isEmpty) return;

    await db.writeTxn(() async {
      for (final tarea in tareasSinProyecto) {
        tarea.proyecto = 'Proyecto';
        await db.tareas.put(tarea);
      }
    });
  }

  // CRUD operations
  Future<void> crearTarea(Tarea tarea) async {
    final db = await isar;
    await db.writeTxn(() async {
      await db.tareas.put(tarea);
    });
  }

  Stream<List<Tarea>> getTareasPorColumna(
    Columna columna,
    String proyecto,
  ) async* {
    final db = await isar;
    yield* db.tareas
        .filter()
        .columnaEqualTo(columna)
        .proyectoEqualTo(proyecto)
        .watch(fireImmediately: true);
  }

  Future<List<Tarea>> getAllTareas() async {
    final db = await isar;
    return await db.tareas.where().findAll();
  }

  Future<void> actualizarTarea(Tarea tarea) async {
    final db = await isar;
    await db.writeTxn(() async {
      await db.tareas.put(tarea);
    });
  }

  Future<void> eliminarTarea(int id) async {
    final db = await isar;
    await db.writeTxn(() async {
      await db.tareas.delete(id);
    });
  }

  Future<void> actualizarColumna(int id, Columna nuevaColumna) async {
    final db = await isar;
    await db.writeTxn(() async {
      final tarea = await db.tareas.get(id);
      if (tarea != null) {
        tarea.columna = nuevaColumna;
        await db.tareas.put(tarea);
      }
    });
  }

  /// Actualiza columna y proyecto de forma síncrona y segura
  /// Retorna true si la actualización fue exitosa
  Future<bool> actualizarColumnaYProyecto(
    int id,
    Columna nuevaColumna,
    String proyecto,
  ) async {
    final db = await isar;
    bool success = false;
    await db.writeTxn(() async {
      final tarea = await db.tareas.get(id);
      if (tarea != null) {
        tarea.columna = nuevaColumna;
        tarea.proyecto = proyecto;
        await db.tareas.put(tarea);
        success = true;
      }
    });
    // Pequeña espera para asegurar que el watcher emita el cambio
    await Future.delayed(const Duration(milliseconds: 50));
    return success;
  }

  Future<void> actualizarProyecto(String actual, String nuevo) async {
    final db = await isar;
    final tareas = await db.tareas.filter().proyectoEqualTo(actual).findAll();
    if (tareas.isEmpty) return;
    await db.writeTxn(() async {
      for (final tarea in tareas) {
        tarea.proyecto = nuevo;
        await db.tareas.put(tarea);
      }
    });
  }
}
