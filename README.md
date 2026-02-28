# Generador de Mapa de Carpetas

Herramienta de productividad para Windows que genera reportes visuales en árbol
de la estructura de cualquier directorio, accesible desde el menú contextual del
Explorador de Archivos.

**Autor:** NEXUS_CALDERON | **Versión:** 2.0

---

## Requisitos

- Windows 7 / 8 / 10 / 11
- PowerShell 5.0 o superior
- Permisos de Administrador (solo para la instalación)

---

## Estructura del Proyecto

```
Mapear_Capetas/
├── Installer.bat              <- Instalador dinámico (ejecutar como Admin)
├── Mapa_Carpeta.bat           <- Lanzador del escaneo
├── Mapa_Carpeta.ps1           <- Motor principal de escaneo
├── MapaCarpeta_Uninstall.reg  <- Desinstalador del menú contextual
├── ico.ico                    <- Ícono del menú contextual
└── README.md                  <- Este archivo
```

> **Nota:** `MapaCarpeta_Install.reg` fue deprecado en v2.0. Usar `Installer.bat`.

---

## Instalación

1. Coloca todos los archivos en una carpeta permanente (ej. `C:\Tools\MapaCarpeta\`).
2. Ejecuta `Installer.bat` **como Administrador**.
3. El instalador resolverá las rutas automáticamente y registrará la opción en el menú contextual.

---

## Uso

1. Abre el Explorador de Windows.
2. Haz clic derecho sobre cualquier carpeta **o** en el fondo de una carpeta abierta.
3. Selecciona **"Generar Mapa de Carpeta"**.
4. El reporte `MAPA_CARPETA___<fecha>.txt` se creará en la carpeta escaneada y se abrirá automáticamente.

### Uso desde línea de comandos

```powershell
# Básico
.\Mapa_Carpeta.ps1 -TargetPath "C:\MiProyecto"

# Con editor personalizado
.\Mapa_Carpeta.ps1 -TargetPath "C:\MiProyecto" -EditorPath "C:\Program Files\Notepad++\notepad++.exe"

# Con exclusiones personalizadas
.\Mapa_Carpeta.ps1 -TargetPath "C:\MiProyecto" -ExcludedDirs @("node_modules", ".git", "dist")
```

---

## Parámetros del Motor (Mapa_Carpeta.ps1)

| Parámetro | Tipo | Requerido | Descripción |
|---|---|---|---|
| `-TargetPath` | `string` | ✅ Sí | Ruta del directorio a escanear |
| `-EditorPath` | `string` | No | Editor para abrir el reporte. Default: `notepad.exe` |
| `-ExcludedDirs` | `string[]` | No | Carpetas a omitir. Tiene un conjunto predeterminado |

### Exclusiones predeterminadas

`node_modules`, `.git`, `.vscode`, `bin`, `obj`, `__pycache__`, `.idea`,
`System Volume Information`, `$RECYCLE.BIN`, `.next`, `dist`, `build`, `coverage`, `.cache`

---

## Desinstalación

Doble clic en `MapaCarpeta_Uninstall.reg` y confirma la operación.

---

## Formato del Reporte

```
+==========================================================+
  Reporte de la estructura del directorio
  Programador : NEXUS_CALDERON  |  Version: 2.0
+==========================================================+
  PROYECTO : MiProyecto
  RUTA     : C:\MiProyecto
  FECHA    : 28/02/2026 13:30:00
+==========================================================+
    TAMANO    |    ESTRUCTURA DE ARCHIVOS
+==========================================================+
    ROOT     |  [DIR] MIPROYECTO
              |-- [DIR] SRC
              |   |-- [SRC] index.js
              |   L-- [SRC] app.css
              L-- [TXT] README.md
+==========================================================+
  RESUMEN TECNICO:
  Archivos     : 3
  Carpetas     : 1
  Peso Total   : 12.50 KB
  Errores acc. : 0 directorios inaccesibles
+==========================================================+
```

---

## Iconos de Tipo de Archivo

| Tag | Tipos |
|---|---|
| `[IMG]` | jpg, png, gif, svg, webp, bmp, ico... |
| `[ZIP]` | zip, rar, 7z, tar, gz, iso... |
| `[VID]` | mp4, mkv, avi, mov... |
| `[AUD]` | mp3, wav, flac, aac... |
| `[EXE]` | exe, msi, bat, ps1, cmd, sh... |
| `[SRC]` | py, js, ts, html, css, cpp, cs, java... |
| `[DOC]` | pdf, doc, docx, xls, xlsx... |
| `[TXT]` | txt, md, log, json, ini, yml... |
| `[DB]`  | sql, db, sqlite... |
| `[SYS]` | reg, dll, sys, inf |

---

## Historial de Versiones

### v2.0
- Parámetros `-EditorPath` y `-ExcludedDirs` configurables desde CLI
- Manejo de errores con `try/catch`: carpetas inaccesibles registradas en el reporte
- Fallback automático a `notepad.exe` si el editor especificado no existe
- `ExecutionPolicy` aplicado con `-Scope Process` (más seguro)
- Carpetas ordenadas antes que archivos en cada nivel
- Iconos extendidos: `[DB]`, `[SYS]`, `[AUD]`, `[VID]` añadidos
- Documentación completa (docstrings y README)
- `Installer.bat` resuelve el ícono dinámicamente con fallback al sistema

### v1.0
- Versión inicial funcional# GENERADOR-DE-MAPA-DE-CARPETAS
