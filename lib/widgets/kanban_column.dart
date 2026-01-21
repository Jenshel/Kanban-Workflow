import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/tarea.dart';
import '../services/isar_service.dart';
import '../widgets/tarea_card.dart';
import '../theme/app_theme.dart';
import 'tarea_dialog.dart';

class KanbanColumn extends StatefulWidget {
  final String titulo;
  final Columna columna;
  final Color color;
  final String proyecto;

  const KanbanColumn({
    super.key,
    required this.titulo,
    required this.columna,
    required this.color,
    required this.proyecto,
  });

  @override
  State<KanbanColumn> createState() => _KanbanColumnState();
}

class _KanbanColumnState extends State<KanbanColumn> {
  final IsarService isarService = IsarService();
  bool _isDragOver = false;
  // Lista local para mostrar tareas pendientes de confirmación
  final List<Tarea> _pendingTareas = [];
  // Set de IDs de tareas que están siendo movidas (para ocultarlas temporalmente)
  static final Set<int> _movingTareaIds = {};

  String _getColumnaTitulo(Columna columna) {
    switch (columna) {
      case Columna.porHacer:
        return 'Por hacer';
      case Columna.enProceso:
        return 'En proceso';
      case Columna.pendientes:
        return 'Pendientes';
      case Columna.completadas:
        return 'Completadas';
    }
  }

  Future<void> _handleDrop(Tarea tarea) async {
    // Agregar a la lista visual inmediatamente
    final tareaMovida = Tarea(
      id: tarea.id,
      titulo: tarea.titulo,
      proyecto: widget.proyecto,
      descripcion: tarea.descripcion,
      prioridad: tarea.prioridad,
      storyPoints: tarea.storyPoints,
      columna: widget.columna,
    );
    tareaMovida.fechaCreacion = tarea.fechaCreacion;

    setState(() {
      _movingTareaIds.add(tarea.id);
      _pendingTareas.add(tareaMovida);
    });

    // Actualizar en la base de datos
    final success = await isarService.actualizarColumnaYProyecto(
      tarea.id,
      widget.columna,
      widget.proyecto,
    );

    // Limpiar estado temporal
    if (mounted) {
      setState(() {
        _movingTareaIds.remove(tarea.id);
        _pendingTareas.removeWhere((t) => t.id == tarea.id);
      });
    }

    if (!success && mounted) {
      // Si falló, mostrar error
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error al mover la tarea')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      width: 320,
      margin: const EdgeInsets.only(right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: _isDragOver
                  ? widget.color.withOpacity(0.15)
                  : AppTheme.glassColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isDragOver
                    ? widget.color.withOpacity(0.5)
                    : AppTheme.glassBorder,
                width: _isDragOver ? 2 : 1,
              ),
              boxShadow: _isDragOver
                  ? [
                      BoxShadow(
                        color: widget.color.withOpacity(0.2),
                        blurRadius: 30,
                        spreadRadius: -5,
                      ),
                    ]
                  : [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header con efecto glass
                Container(
                  padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppTheme.glassBorder, width: 1),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: StreamBuilder<List<Tarea>>(
                          stream: isarService.getTareasPorColumna(
                            widget.columna,
                            widget.proyecto,
                          ),
                          builder: (context, snapshot) {
                            final count = snapshot.data?.length ?? 0;
                            return Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        widget.color,
                                        widget.color.withOpacity(0.6),
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: widget.color.withOpacity(0.5),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    '${_getColumnaTitulo(widget.columna)} / $count',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -0.3,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      GlassIconButton(
                        icon: Icons.add_rounded,
                        tooltip: 'Nueva tarea',
                        accentColor: widget.color,
                        onPressed: () async {
                          final result = await showDialog<Tarea>(
                            context: context,
                            builder: (context) => TareaDialog(
                              columna: widget.columna,
                              proyecto: widget.proyecto,
                            ),
                          );
                          if (result != null) {
                            await isarService.crearTarea(result);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                // Lista de tareas
                Expanded(
                  child: DragTarget<Tarea>(
                    onWillAcceptWithDetails: (details) {
                      final willAccept =
                          details.data.columna != widget.columna &&
                          details.data.proyecto == widget.proyecto;
                      if (willAccept && !_isDragOver) {
                        setState(() => _isDragOver = true);
                      }
                      return willAccept;
                    },
                    onLeave: (_) => setState(() => _isDragOver = false),
                    onAcceptWithDetails: (details) {
                      setState(() => _isDragOver = false);
                      // Usar el nuevo método que maneja estado visual
                      _handleDrop(details.data);
                    },
                    builder: (context, candidateData, rejectedData) {
                      return StreamBuilder<List<Tarea>>(
                        stream: isarService.getTareasPorColumna(
                          widget.columna,
                          widget.proyecto,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: widget.color,
                                strokeWidth: 2,
                              ),
                            );
                          }

                          // Combinar tareas de DB con tareas pendientes
                          final tareasDb = snapshot.data ?? [];
                          final pendingIds = _pendingTareas
                              .map((t) => t.id)
                              .toSet();

                          // Filtrar tareas que están siendo movidas a otra columna
                          final tareasVisibles = tareasDb
                              .where(
                                (t) =>
                                    !_movingTareaIds.contains(t.id) ||
                                    t.columna == widget.columna,
                              )
                              .where((t) => !pendingIds.contains(t.id))
                              .toList();

                          // Agregar tareas pendientes que vienen de otras columnas
                          final tareas = [...tareasVisibles, ..._pendingTareas];

                          if (tareas.isEmpty) {
                            return Center(
                              child: Opacity(
                                opacity: 0.4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.inbox_outlined,
                                      size: 48,
                                      color: widget.color,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Sin tareas',
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          return ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: tareas.length,
                            itemBuilder: (context, index) {
                              final tarea = tareas[index];
                              return Draggable<Tarea>(
                                key: ValueKey('drag-${tarea.id}'),
                                data: tarea,
                                feedback: Material(
                                  color: Colors.transparent,
                                  child: Transform.rotate(
                                    angle: 0.02,
                                    child: Container(
                                      width: 288,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.3,
                                            ),
                                            blurRadius: 20,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: TareaCard(tarea: tarea),
                                    ),
                                  ),
                                ),
                                childWhenDragging: Opacity(
                                  opacity: 0.3,
                                  child: TareaCard(tarea: tarea),
                                ),
                                child: TareaCard(
                                  tarea: tarea,
                                  onTap: () async {
                                    final result = await showDialog<Tarea>(
                                      context: context,
                                      builder: (context) => TareaDialog(
                                        tarea: tarea,
                                        columna: widget.columna,
                                        proyecto: widget.proyecto,
                                      ),
                                    );
                                    if (result != null) {
                                      await isarService.actualizarTarea(result);
                                    }
                                  },
                                  onDelete: () async {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Eliminar tarea'),
                                        content: const Text(
                                          '¿Estás seguro de que deseas eliminar esta tarea?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: const Text('Cancelar'),
                                          ),
                                          FilledButton(
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            style: FilledButton.styleFrom(
                                              backgroundColor:
                                                  AppTheme.prioridadCritica,
                                            ),
                                            child: const Text('Eliminar'),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (confirm == true) {
                                      await isarService.eliminarTarea(tarea.id);
                                    }
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
