lib_path <- file.path(rprojroot::find_rstudio_root_file(), "libs")
sbox_path <- file.path(rprojroot::find_rstudio_root_file(), "sbox")
if (!file.exists(lib_path)) {
  lib_path <- file.path(rprojroot::find_rstudio_root_file(), "deployment", "libs")
  sbox_path <- file.path(rprojroot::find_rstudio_root_file(), "deployment", "sbox")
}

if (!dir.exists(sbox_path)) {
  dir.create(sbox_path, recursive = T)
}

.libPaths(c(normalizePath(sbox_path), normalizePath(lib_path), .libPaths()))

library(logging)
logging::logReset()
logging::setLevel(level = "INFO")
logging::addHandler(logging::writeToConsole, level = "FINEST")

log_fpath <- (function() {
  log_file <- gsub("-", "_", sprintf("%s.log", Sys.Date()))
  log_dir <- normalizePath(file.path(rprojroot::find_rstudio_root_file(), "logs"))
  fpath <- file.path(log_dir, log_file)
  if (file.exists(fpath) && file.access(fpath, 2) == -1) {
    fpath <- paste0(fpath, ".", Sys.info()[["user"]])
  }
  return(fpath)
})()

log_dir <- normalizePath(file.path(rprojroot::find_rstudio_root_file(), "logs"))
if (dir.exists(log_dir)) {
  logging::addHandler(logging::writeToFile, level = "FINEST", file = log_fpath)
}

script_path <- getwd()

args_parser <- function() {
  args <- commandArgs(trailingOnly = FALSE)
  list(
    get = function(name, required = TRUE,  default = NULL) {
      prefix <- sprintf("--%s=", name)
      value <- sub(prefix, "", args[grep(prefix, args)])

      if (length(value) != 1 || is.null(value)) {
        if (required) {
          logerror("--%s parameter is required", name)
          stop(1)
        }
        return(default)
      }
      return(value)
    }
  )
}

load_config <- function() {
  config_file <- file.path(script_path, "..", "config.txt")
  if (!file.exists(config_file)) {
    templ_file <- file.path(script_path, "..", "config_templ.txt")
    if (!file.exists(templ_file)) {
      return(list())
    }
    file.copy(templ_file, config_file)
  }

  config <- read.dcf(config_file)
  if ("LogLevel" %in% colnames(config)) {
    logging::setLevel(config[, "LogLevel"])
  }

  config_lst <- as.list(config)
  names(config_lst) <- colnames(config)

  return(config_lst)
}

# customized folders

folder_exists <- function(folder) {
  if (!dir.exists(folder)) {
    dir.create(folder, recursive = T)
  }
  return(folder)
}

project_root <- rprojroot::find_rstudio_root_file()
book_src_dir <- file.path(project_root, "work", "book")
book_out_dir <- file.path(project_root, "export", "book_out")
model_out_dir <- folder_exists(file.path(project_root, "export", "model_out"))
data_raw_dir <- file.path(project_root, "import")
data_out_dir <- folder_exists(file.path(project_root, "export"))
assets_dir   <- file.path(project_root, "import", "assets")
r_code_dir   <- file.path(project_root, "R")

save.image(file.path(project_root, "workspace.RData"))
