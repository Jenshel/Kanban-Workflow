import 'dart:ui';
import 'package:flutter/material.dart';

class AppTheme {
  // Premium dark palette with depth
  static const Color darkBackground = Color(0xFF0D0F14);
  static const Color darkBackgroundAlt = Color(0xFF141821);
  static const Color cardBackground = Color(0xFF1A1F2E);
  static const Color surfaceColor = Color(0xFF232938);

  // Refined accent colors
  static const Color porHacerColor = Color(0xFFFFB74D);
  static const Color enProcesoColor = Color(0xFF64B5F6);
  static const Color pendientesColor = Color(0xFFBA68C8);
  static const Color completadasColor = Color(0xFF81C784);

  // Priority colors
  static const Color prioridadBaja = Color(0xFF66BB6A);
  static const Color prioridadMedia = Color(0xFFFFCA28);
  static const Color prioridadAlta = Color(0xFFFF7043);
  static const Color prioridadCritica = Color(0xFFEF5350);

  // Glass effect colors
  static const Color glassColor = Color(0x18FFFFFF);
  static const Color glassBorder = Color(0x15FFFFFF);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    cardColor: cardBackground,
    primaryColor: porHacerColor,
    colorScheme: const ColorScheme.dark(
      primary: porHacerColor,
      secondary: enProcesoColor,
      surface: cardBackground,
      onSurface: Colors.white,
      tertiary: pendientesColor,
    ),
    cardTheme: CardThemeData(
      color: cardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: glassBorder, width: 1),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: glassBorder, width: 1),
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: -0.5,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: -0.2,
      ),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: porHacerColor,
        foregroundColor: Colors.black87,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: porHacerColor,
        foregroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white70,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: Colors.white70),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: glassBorder, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: glassBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: porHacerColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    dividerTheme: DividerThemeData(color: glassBorder, thickness: 1),
    popupMenuTheme: PopupMenuThemeData(
      color: surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: glassBorder, width: 1),
      ),
    ),
  );

  static Color getColumnaColor(String columna) {
    switch (columna) {
      case 'porHacer':
        return porHacerColor;
      case 'enProceso':
        return enProcesoColor;
      case 'pendientes':
        return pendientesColor;
      case 'completadas':
        return completadasColor;
      default:
        return porHacerColor;
    }
  }

  static Color getPrioridadColor(String prioridad) {
    switch (prioridad) {
      case 'baja':
        return prioridadBaja;
      case 'media':
        return prioridadMedia;
      case 'alta':
        return prioridadAlta;
      case 'critica':
        return prioridadCritica;
      default:
        return prioridadMedia;
    }
  }
}

/// Widget para crear efecto glassmorphism
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? borderColor;
  final double blur;
  final Color? backgroundColor;

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.padding,
    this.margin,
    this.borderColor,
    this.blur = 10,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor ?? AppTheme.glassColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: borderColor ?? AppTheme.glassBorder,
                width: 1,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Botón con efecto glass animado
class GlassIconButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String? tooltip;
  final Color? accentColor;
  final double size;

  const GlassIconButton({
    super.key,
    this.onPressed,
    required this.icon,
    this.tooltip,
    this.accentColor,
    this.size = 18,
  });

  @override
  State<GlassIconButton> createState() => _GlassIconButtonState();
}

class _GlassIconButtonState extends State<GlassIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.accentColor ?? Colors.white70;

    Widget button = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _isHovered ? color.withOpacity(0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHovered ? color.withOpacity(0.3) : Colors.transparent,
              width: 1,
            ),
          ),
          child: AnimatedScale(
            scale: _isHovered ? 1.1 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              widget.icon,
              size: widget.size,
              color: _isHovered ? color : Colors.white60,
            ),
          ),
        ),
      ),
    );

    if (widget.tooltip != null) {
      button = Tooltip(message: widget.tooltip!, child: button);
    }

    return button;
  }
}
