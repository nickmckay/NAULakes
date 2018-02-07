#' Import Lake Files
#'
#' @return
#' @export stringr, readr
#' @examples
importLakeFiles <- function(path.to.files){
  set_here(path.to.files) #setup here
  allCsvs <-  list.files(path.to.files,pattern = ".csv")

  #parse lakes...
  p <- stringr::str_split(allCsvs,"_")

  #get unique lakes
  allLakes = unique(sapply(p,"[[",1))

  #make sure that all filenames are appropriate
  app = c("coreMetadata","depthMatchTable","ageSummaryTable","ageEnsembleTable","instantaneousEventTable")
  allFiles = unique(sapply(p,"[[",2))

  if(any(!allFiles %in% app)){
    stop("Filenames in directory do match appropriate structure")
  }

  #Setup a list to store the data
  lakes = vector(mode = "list",length = length(allLakes))
  names(lakes) = allLakes

  #Work through depth tables first
  for(l in 1:length(lakes)){
    for(t in 1:length(app)){
      fname = stringr::str_c(allLakes[l],"_",app[t],".csv")
      if(file.exists(file.path(path.to.files,fname))){
        tib = read_csv(file.path(path.to.files,fname))
        lakes[[l]][[app[t]]] <- tib[apply(!is.na(tib),1,all),] #remove rows of all NAs
      }
    }
  }

}


