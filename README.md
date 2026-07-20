1| # asiste
2| **Open-source attendance and formative assessment system for higher education.**
3| ---
4| 
5| ## Philosophy
6| 
7| The application is **never** the center of the system.
8| The center of the system is **Google Sheets**.
9| The application simply reads and writes information in Google Sheets and provides a simple interface for teachers and students.
10| A teacher should be able to manage an entire course **without editing a single line of R code**.
11| 
12| ---
13| ## Main features
14| - Attendance using QR codes.
15| - Formative assessment after attendance.
16| - Automatic correction of multiple-choice questions.
17| - Teacher dashboards.
18| - Course evolution.
19| - Attendance tracking by student.
20| - Google Sheets as the only database.
21| - Mobile-friendly interface.
22| - Open source.
23| 
24| ---
25| 
26| ## Project principles
27| 
28| - Simple.
29| - Modular.
30| - Reproducible.
31| - Easy to maintain.
32| - Community-driven.
33| - Open source.
34| - Minimal dependencies.
35| 
36| ---
37| 
38| ## Project status
39| 
40| 🚧 Under active development.
41| 
42| ---
43| 
44| ## Author
45| 
46| **SJWatson**
47| 
48| ---
49| 
50| ## License
51| 
52| GNU General Public License v3.0
53| 
54| ---
55| 
56| ## Citation
57| 
58| If you use this software in publications, please cite it using the information provided in `CITATION.cff`.
59| 
60| ---
61| 
62| ## Contributing
63| 
64| See `CONTRIBUTING.md`.
65| 
66| ---
67| 
68| ## Quick start (desarrollo local)
69| 
70| Estos pasos permiten ejecutar la aplicación desde un clon del repositorio en una máquina con R instalada.
71| 
72| 1) Instalar dependencias (ejecutar en R):
73| 
74| ```r
75| install.packages(c("shiny","bslib","googlesheets4","purrr","config"))
76| ```
77| 
78| 2) Configuración: el archivo `config.yml` ya contiene un `google: sheet_id` apuntando a una hoja pública de ejemplo. Si vas a usar tu propio Google Sheet, reemplaza `google: sheet_id` con el ID de tu hoja.
79| 
80| 3) Si querés leer la hoja pública sin autenticación (solo lectura pública):
81| 
82| ```r
83| library(googlesheets4)
84| googlesheets4::gs4_deauth()
85| googlesheets4::read_sheet("1tzLeVkurlV0_-FFY_bQA32G_xmIfTWIxR8oatLD2S9Y")
86| ```
87| 
88| 4) Para operar con autenticación interactiva (lectura y escritura):
89| 
90| ```r
91| library(googlesheets4)
92| googlesheets4::gs4_auth() # abrirá el navegador para autorizar
93| ```
94| 
95| 5) Ejecutar la app desde la raíz del repo (donde está `config.yml`):
96| 
97| ```r
98| source("app.R")
99| # o
100| run_app()
101| # o
102| shiny::runApp(".")
103| ```
104| 
105| Nota: antes de iniciar la app `run_app()` ejecuta automáticamente una validación (validate_sheets) que comprueba que la hoja de Google es accesible, que las pestañas necesarias existen y que contienen las columnas mínimas esperadas. Si la validación falla, la app no iniciará y mostraré mensajes de error claros.
106| 
107| ---
108| 
109| ## Estructura mínima de las hojas (columnas esperadas)
110| 
111| Las hojas y las columnas mínimas que la app espera por defecto (pueden adaptarse en `config.yml`):
112| sheets ejemplo: https://docs.google.com/spreadsheets/d/1tzLeVkurlV0_-FFY_bQA32G_xmIfTWIxR8oatLD2S9Y/edit?usp=sharing
113| - Docentes / Usuarios: `email`, `nombre`, `rol`, `comision`, `activo`
114| - Estudiantes: `dni`, `nombre`, `email`
115| - Clases: `id_clase`, (otras columnas opcionales como `curso`, `fecha`)
116| - Preguntas: `id_pregunta`, `id_clase`, (enunciado, opciones, correcta)
117| - Asistencia: `id_clase`, `dni`, `fecha_hora`, `puntos`
118| - Respuestas: `id_clase`, `dni`, `id_pregunta`, `respuesta`, `puntos`
119| 
120| Si alguna hoja usa nombres distintos, la validación te indicará qué columnas faltan y podés renombrarlas en la hoja o adaptar `R/google_config.R::expected_columns`.
121| 
122| ---
123| 
124| ## Notas para desarrolladores
125| 
126| - `R/google_config.R` contiene `get_google_config()` y `validate_sheets()`.
127| - `R/services/sheet_service.R` ahora es robusto frente a que la hoja de docentes se llame `docentes` o `usuarios` (compatibilidad automática).
128| - `R/run_app.R` llama a `validate_sheets()` antes de iniciar la app.
129| 
130| ---
131| 
132| Si querés que haga cambios adicionales en la validación, el inventario de columnas o la UI, decime y lo implemento.
