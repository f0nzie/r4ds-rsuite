# Detect proper script_path (you cannot use args yet as they are build with tools in set_env.r)
script_path <- (function() {
  args <- commandArgs(trailingOnly = FALSE)
  script_path <- dirname(sub("--file=", "", args[grep("--file=", args)]))
  if (!length(script_path)) { return(".") }
  return(normalizePath(script_path))
})()

###########################################################
library(r4ds.book.pkgs)

# Setting .libPaths() to point to libs folder
source(file.path(script_path, "set_env.R"), chdir = T)


loginfo("--> Pandoc version: %s", rmarkdown::pandoc_version())


project_root <- rprojroot::find_rstudio_root_file()
book_folder <- file.path(project_root, "work", "r4ds")
input_file <- file.path(book_folder, "index.rmd")
output_folder <- file.path(book_folder, "_book")

loginfo(book_folder)
loginfo(output_folder)

setwd(book_folder)

if (file.exists("_main.Rmd")) {
  file.remove("_main.Rmd")
}



bookdown::render_book(input = input_file,
                      output_format = "bookdown::gitbook",
                      output_dir = output_folder, clean_envir = FALSE)
