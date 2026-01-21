import 'package:flutter/material.dart';
import '../models/tarea.dart';
import '../theme/app_theme.dart';

class TareaCard extends StatefulWidget {
  final Tarea tarea;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const TareaCard({super.key, required this.tarea, this.onTap, this.onDelete});

  @override
  State<TareaCard> createState() => _TareaCardState();
}

class _TareaCardState extends State<TareaCard> {
  bool _isHovered = false;

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

  @override
  Widget build(BuildContext context) {
    final prioridadColor = AppTheme.getPrioridadColor(
      widget.tarea.prioridad.name,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.only(bottom: 12),
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _isHovered
                ? prioridadColor.withOpacity(0.4)
                : AppTheme.glassBorder,
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: prioridadColor.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(14),
            hoverColor: Colors.transparent,
            splashColor: prioridadColor.withOpacity(0.1),
            highlightColor: prioridadColor.withOpacity(0.05),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.tarea.titulo,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      if (widget.onDelete != null)
                        AnimatedOpacity(
                          opacity: _isHovered ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: GlassIconButton(
                            icon: Icons.close_rounded,
                            onPressed: widget.onDelete,
                            tooltip: 'Eliminar',
                            accentColor: AppTheme.prioridadCritica,
                            size: 16,
                          ),
                        ),
                    ],
                  ),
                  if (widget.tarea.descripcion != null &&
                      widget.tarea.descripcion!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        widget.tarea.descripcion!,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white54),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          prioridadColor,
                          prioridadColor.withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: prioridadColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      _getPrioridadText(widget.tarea.prioridad),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
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
