# Ejecutar una sola vez

usethis::create_package("asiste")

renv::init()

usethis::use_roxygen_md()

usethis::use_testthat()

usethis::use_gpl3_license()

usethis::use_git()

usethis::use_readme_md()

usethis::use_news_md()
