# Testing Guide for asiste

## Unit Tests

### Setup

```r
install.packages(c("testthat", "mockery"))
```

### Ejecutar tests

```r
# En la consola R desde el directorio raíz
testthat::test_dir("tests")

# O con devtools
devtools::test()
```

## Test Files

Crear en `tests/`:

### `tests/test_validation.R`

```r
test_that("validate_student_dni validates correctly", {
  expect_true(validate_answers(data.frame(pregunta = "Q1", respuesta = "A")))
  expect_false(validate_answers("not a dataframe"))
})

test_that("validate_questions checks required columns", {
  df <- data.frame(
    id_pregunta = 1,
    id_clase = "C1",
    pregunta = "Q?",
    opciones = "A|B|C",
    correcta = "A"
  )
  expect_true(validate_questions(df))
})
```

### `tests/test_grading.R`

```r
test_that("grade_answers calculates score correctly", {
  preguntas <- data.frame(
    pregunta = c("Q1", "Q2"),
    correcta = c("A", "B"),
    puntos = c(10, 10)
  )
  
  respuestas <- data.frame(
    pregunta = c("Q1", "Q2"),
    respuesta = c("A", "B")
  )
  
  resultado <- grade_answers(preguntas, respuestas)
  expect_equal(resultado$correct_answers, 2)
  expect_equal(resultado$score_percent, 100)
})
```

## GitHub Actions CI/CD

Crear en `.github/workflows/tests.yml`:

```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v2
    
    - name: Set up R
      uses: r-lib/actions/setup-r@v2
      
    - name: Install dependencies
      run: |
        install.packages(c('testthat', 'googlesheets4', 'shiny', 'config'))
      shell: Rscript {0}
    
    - name: Run tests
      run: testthat::test_dir("tests")
      shell: Rscript {0}
```

## Manual Testing Checklist

- [ ] Login con email válido
- [ ] Login rechaza email inválido
- [ ] DNI válido pasa validación
- [ ] DNI inválido es rechazado
- [ ] Crear clase guarda en Google Sheets
- [ ] QR se genera correctamente
- [ ] Preguntas se cargan correctamente
- [ ] Respuestas se guardan
- [ ] Puntaje se calcula correctamente
- [ ] Dashboard muestra estadísticas
- [ ] Logout funciona

## Performance Testing

```r
# Benchmark de carga de estudiantes
benchmark_students <- function() {
  start <- Sys.time()
  students <- sheet_get_students()
  end <- Sys.time()
  cat("Load time:", difftime(end, start), "seconds\n")
  cat("Rows:", nrow(students), "\n")
}

benchmark_students()
```
