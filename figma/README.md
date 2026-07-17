# asiste — Diseño Figma

Esta carpeta contiene toda la especificación del diseño de la aplicación.

El objetivo es que el diseño sea reproducible y mantenible por cualquier desarrollador sin depender del archivo `.fig`.

## Organización

```
figma/

design-tokens.json

components.md

prototype.md

screens/

    DOC_Login.md
    DOC_Home.md
    DOC_NewClass.md
    DOC_QR.md
    DOC_DashboardCourse.md
    DOC_DashboardClass.md

    STD_DNI.md
    STD_Questions.md
    STD_End.md
```

Cada archivo representa exactamente una pantalla del sistema.

Cada pantalla corresponde a un módulo Shiny.

| Pantalla | Módulo |
|-----------|---------|
| DOC_Login | mod_login.R |
| DOC_Home | mod_home.R |
| DOC_NewClass | mod_class.R |
| DOC_QR | mod_qr.R |
| DOC_DashboardCourse | mod_dashboard_course.R |
| DOC_DashboardClass | mod_dashboard_class.R |
| STD_DNI | mod_student_dni.R |
| STD_Questions | mod_student_questions.R |
| STD_End | mod_student_finish.R |

El diseño utiliza Material Design 3.

No deben dibujarse componentes nuevos si ya existen en el Design System.
