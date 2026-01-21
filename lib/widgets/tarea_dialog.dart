import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../models/tarea.dart';
import '../theme/app_theme.dart';

class TareaDialog extends StatefulWidget {
  final Tarea? tarea;
  final Columna columna;
  final String? proyecto;

  const TareaDialog({
    super.key,
    this.tarea,
    required this.columna,
    this.proyecto,
  });

  @override
  State<TareaDialog> createState() => _TareaDialogState();
}

class _TareaDialogState extends State<TareaDialog> {
  late TextEditingController _tituloController;
  late TextEditingController _descripcionController;
  late TextEditingController _storyPointsController;
  late Prioridad _prioridad;
  late Columna _columna;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.tarea?.titulo ?? '');
    _descripcionController = TextEditingController(
      text: widget.tarea?.descripcion ?? '',
    );
    _storyPointsController = TextEditingController(
      text: widget.tarea?.storyPoints.toString() ?? '1.0',
    );
    _prioridad = widget.tarea?.prioridad ?? Prioridad.media;
    _columna = widget.tarea?.columna ?? widget.columna;
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    _storyPointsController.dispose();
    super.dispose();
  }

  String _getPrioridadText(Prioridad prioridad) {
    switch (prioridad) {
      case Prioridad.baja:
        return 'Baja';
      case Prioridad.media:
        return 'Media';
      case Prioridad.alta:
        return 'Alta';
      case Prioridad.critica:
        return 'Crítica';
    }
  }

  Color _getPrioridadColor(Prioridad prioridad) {
    switch (prioridad) {
      case Prioridad.baja:
        return AppTheme.prioridadBaja;
      case Prioridad.media:
        return AppTheme.prioridadMedia;
      case Prioridad.alta:
        return AppTheme.prioridadAlta;
      case Prioridad.critica:
        return AppTheme.prioridadCritica;
    }
  }

  String _getColumnaText(Columna columna) {
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

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.tarea != null;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            width: 480,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor.withOpacity(0.95),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppTheme.glassBorder, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 40,
                  spreadRadius: -10,
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.porHacerColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          isEditing
                              ? Icons.edit_rounded
                              : Icons.add_task_rounded,
                          color: AppTheme.porHacerColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        isEditing ? 'Editar Tarea' : 'Nueva Tarea',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Título
                  TextField(
                    controller: _tituloController,
                    decoration: InputDecoration(
                      labelText: 'Título',
                      hintText: 'Ingresa el título de la tarea',
                      prefixIcon: Icon(
                        Icons.title_rounded,
                        color: Colors.white38,
                        size: 20,
                      ),
                    ),
                    autofocus: true,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 18),

                  // Descripción
                  TextField(
                    controller: _descripcionController,
                    decoration: InputDecoration(
                      labelText: 'Descripción (opcional)',
                      hintText: 'Ingresa notas adicionales',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Icon(
                          Icons.notes_rounded,
                          color: Colors.white38,
                          size: 20,
                        ),
                      ),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 3,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 22),

                  // Prioridad
                  Text(
                    'Prioridad',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white60,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: Prioridad.values.map((prioridad) {
                      final isSelected = _prioridad == prioridad;
                      final color = _getPrioridadColor(prioridad);
                      return GestureDetector(
                        onTap: () => setState(() => _prioridad = prioridad),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? color.withOpacity(0.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected
                                  ? color.withOpacity(0.6)
                                  : AppTheme.glassBorder,
                              width: isSelected ? 2 : 1,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: color.withOpacity(0.2),
                                      blurRadius: 12,
                                      spreadRadius: -2,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: color.withOpacity(0.5),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _getPrioridadText(prioridad),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 22),

                  // Columna
                  Text(
                    'Columna',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white60,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<Columna>(
                    value: _columna,
                    dropdownColor: AppTheme.surfaceColor,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    items: Columna.values.map((columna) {
                      return DropdownMenuItem(
                        value: columna,
                        child: Text(
                          _getColumnaText(columna),
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _columna = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 28),

                  // Botones
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('Cancelar'),
                      ),
                      const SizedBox(width: 12),
                      FilledButton(
                        onPressed: () {
                          if (_tituloController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('El título es requerido'),
                                backgroundColor: AppTheme.prioridadCritica,
                              ),
                            );
                            return;
                          }

                          final tarea = Tarea(
                            id: widget.tarea?.id ?? Isar.autoIncrement,
                            titulo: _tituloController.text,
                            proyecto:
                                widget.tarea?.proyecto ??
                                widget.proyecto ??
                                'Proyecto',
                            descripcion: _descripcionController.text.isEmpty
                                ? null
                                : _descripcionController.text,
                            prioridad: _prioridad,
                            storyPoints: 1.0,
                            columna: _columna,
                          );

                          Navigator.pop(context, tarea);
                        },
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),
                        ),
                        child: Text(isEditing ? 'Actualizar' : 'Crear'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
