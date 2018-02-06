#' Import Lake Files
#'
#' @return
#' @export stringr, here, readr
#' @examples
importLakeFiles <- function(path.to.files){
path.to.files  <-  "~/GitHub/NAULakes/inst/extdata"
allCsvs <-  list.files(path.to.files,pattern = ".csv")

#parse lakes...
p <- stringr::str_split(allCsvs,"_")

#get unique lakes
allLakes = unique(sapply(p,"[[",1))

#make sure that all filenames are appropriate
app = c("depthMatchTable.csv","ageSummaryTable.csv","ageEnsembleTable.csv")
allFiles = unique(sapply(p,"[[",2))

if(any(!allFiles %in% app)){
  stop("Filenames in directory do match appropriate structure")
}

#Work through depth tables first

  dt <- read_csv(here::here(path.to.files,)


}


