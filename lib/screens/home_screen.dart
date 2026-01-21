import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/tarea.dart';
import '../services/isar_service.dart';
import '../widgets/kanban_column.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _appTitleKey = 'app_title';
  static const _projectsKey = 'projects';
  static const _selectedProjectKey = 'selected_project';

  String _appTitle = 'Jenshel App';
  List<String> _projects = ['Proyecto'];
  String _selectedProject = 'Proyecto';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    final storedProjects = prefs.getStringList(_projectsKey);
    final selectedProject = prefs.getString(_selectedProjectKey);
    setState(() {
      _appTitle = prefs.getString(_appTitleKey) ?? _appTitle;
      _projects = (storedProjects == null || storedProjects.isEmpty)
          ? _projects
          : storedProjects;
      _selectedProject = selectedProject ?? _projects.first;
    });
  }

  Future<void> _saveAppTitle(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_appTitleKey, value);
    if (!mounted) return;
    setState(() => _appTitle = value);
  }

  Future<void> _saveProjects() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_projectsKey, _projects);
  }

  Future<void> _selectProject(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedProjectKey, value);
    if (!mounted) return;
    setState(() => _selectedProject = value);
  }

  Future<void> _renameSelectedProject(String value) async {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return;
    if (_projects.contains(trimmed)) {
      await _selectProject(trimmed);
      return;
    }
    final index = _projects.indexOf(_selectedProject);
    if (index == -1) return;
    final previousProject = _selectedProject;
    setState(() {
      _projects[index] = trimmed;
      _selectedProject = trimmed;
    });
    await IsarService().actualizarProyecto(previousProject, trimmed);
    await _saveProjects();
    await _selectProject(trimmed);
  }

  Future<void> _addProject(String value) async {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return;
    if (_projects.contains(trimmed)) {
      await _selectProject(trimmed);
      return;
    }
    setState(() {
      _projects.add(trimmed);
      _selectedProject = trimmed;
    });
    await _saveProjects();
    await _selectProject(trimmed);
  }

  Future<String?> _showEditDialog({
    required String title,
    required String initialValue,
    required String hintText,
    String actionLabel = 'Guardar',
  }) {
    final controller = TextEditingController(text: initialValue);
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(hintText: hintText),
            textInputAction: TextInputAction.done,
            onSubmitted: (value) {
              final trimmed = value.trim();
              if (trimmed.isNotEmpty) {
                Navigator.of(context).pop(trimmed);
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                final trimmed = controller.text.trim();
                if (trimmed.isEmpty) return;
                Navigator.of(context).pop(trimmed);
              },
              child: Text(actionLabel),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTitleRow(BuildContext context, {bool isCompact = false}) {
    return Row(
      children: [
        Flexible(
          child: Text(
            _appTitle,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: isCompact ? 24 : 32,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
        ),
        const SizedBox(width: 8),
        GlassIconButton(
          tooltip: 'Editar título',
          accentColor: AppTheme.porHacerColor,
          onPressed: () async {
            final result = await _showEditDialog(
              title: 'Editar título principal',
              initialValue: _appTitle,
              hintText: 'Jenshel App',
            );
            if (result != null) {
              await _saveAppTitle(result);
            }
          },
          icon: Icons.edit_rounded,
        ),
        const SizedBox(width: 4),
        Text('✨', style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }

  Widget _buildProjectRow(BuildContext context, {bool isCompact = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ProjectSelector(
          projects: _projects,
          selectedProject: _selectedProject,
          onSelected: _selectProject,
          isCompact: isCompact,
        ),
        const SizedBox(width: 8),
        GlassIconButton(
          tooltip: 'Editar proyecto',
          accentColor: AppTheme.enProcesoColor,
          onPressed: () async {
            final result = await _showEditDialog(
              title: 'Editar proyecto',
              initialValue: _selectedProject,
              hintText: 'Nombre del proyecto',
            );
            if (result != null) {
              await _renameSelectedProject(result);
            }
          },
          icon: Icons.edit_rounded,
        ),
        const SizedBox(width: 4),
        GlassIconButton(
          tooltip: 'Nuevo proyecto',
          accentColor: AppTheme.completadasColor,
          onPressed: () async {
            final result = await _showEditDialog(
              title: 'Nuevo proyecto',
              initialValue: '',
              hintText: 'Nombre del proyecto',
              actionLabel: 'Crear',
            );
            if (result != null) {
              await _addProject(result);
            }
          },
          icon: Icons.add_rounded,
        ),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return '¡Buenos días!';
    if (hour < 18) return '¡Buenas tardes!';
    return '¡Buenas noches!';
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateFormat = DateFormat('EEEE, d MMMM yyyy', 'es_ES');
    final formattedDate = dateFormat.format(now);
    final isCompact = MediaQuery.of(context).size.width < 760;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.darkBackground,
              AppTheme.darkBackgroundAlt,
              AppTheme.cardBackground,
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Column(
          children: [
            // Custom AppBar con glass effect
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 16,
                    left: 24,
                    right: 24,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.glassColor,
                    border: Border(
                      bottom: BorderSide(color: AppTheme.glassBorder, width: 1),
                    ),
                  ),
                  child: isCompact
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: _buildTitleRow(
                                    context,
                                    isCompact: true,
                                  ),
                                ),
                                GlassIconButton(
                                  tooltip: 'Refrescar',
                                  icon: Icons.refresh_rounded,
                                  accentColor: AppTheme.enProcesoColor,
                                  onPressed: () {
                                    _loadPreferences();
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildProjectRow(context, isCompact: true),
                            const SizedBox(height: 8),
                            Text(
                              '${_getGreeting()} • $formattedDate',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildTitleRow(context),
                                  const SizedBox(height: 6),
                                  Text(
                                    '${_getGreeting()} • $formattedDate',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _buildProjectRow(context),
                            const SizedBox(width: 12),
                            GlassIconButton(
                              tooltip: 'Refrescar',
                              icon: Icons.refresh_rounded,
                              accentColor: AppTheme.enProcesoColor,
                              onPressed: () {
                                _loadPreferences();
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                ),
              ),
            ),
            // Body
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KanbanColumn(
                        key: ValueKey('$_selectedProject-porHacer'),
                        titulo: 'Por hacer',
                        columna: Columna.porHacer,
                        color: AppTheme.porHacerColor,
                        proyecto: _selectedProject,
                      ),
                      KanbanColumn(
                        key: ValueKey('$_selectedProject-enProceso'),
                        titulo: 'En proceso',
                        columna: Columna.enProceso,
                        color: AppTheme.enProcesoColor,
                        proyecto: _selectedProject,
                      ),
                      KanbanColumn(
                        key: ValueKey('$_selectedProject-pendientes'),
                        titulo: 'Pendientes',
                        columna: Columna.pendientes,
                        color: AppTheme.pendientesColor,
                        proyecto: _selectedProject,
                      ),
                      KanbanColumn(
                        key: ValueKey('$_selectedProject-completadas'),
                        titulo: 'Completadas',
                        columna: Columna.completadas,
                        color: AppTheme.completadasColor,
                        proyecto: _selectedProject,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget selector de proyectos con popup menu estilizado
class _ProjectSelector extends StatefulWidget {
  final List<String> projects;
  final String selectedProject;
  final Function(String) onSelected;
  final bool isCompact;

  const _ProjectSelector({
    required this.projects,
    required this.selectedProject,
    required this.onSelected,
    this.isCompact = false,
  });

  @override
  State<_ProjectSelector> createState() => _ProjectSelectorState();
}

class _ProjectSelectorState extends State<_ProjectSelector> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: PopupMenuButton<String>(
        tooltip: 'Seleccionar proyecto',
        offset: const Offset(0, 45),
        color: AppTheme.surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: AppTheme.glassBorder, width: 1),
        ),
        elevation: 8,
        shadowColor: Colors.black54,
        onSelected: widget.onSelected,
        itemBuilder: (context) => widget.projects.map((project) {
          final isSelected = project == widget.selectedProject;
          return PopupMenuItem<String>(
            value: project,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.enProcesoColor.withOpacity(0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  if (isSelected)
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: AppTheme.enProcesoColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.enProcesoColor.withOpacity(0.5),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  Text(
                    project,
                    style: TextStyle(
                      fontSize: widget.isCompact ? 14 : 16,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isSelected ? Colors.white : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppTheme.enProcesoColor.withOpacity(0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHovered
                  ? AppTheme.enProcesoColor.withOpacity(0.3)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.selectedProject,
                style: TextStyle(
                  fontSize: widget.isCompact ? 16 : 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              AnimatedRotation(
                turns: _isHovered ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: _isHovered ? AppTheme.enProcesoColor : Colors.white60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
