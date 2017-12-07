# Perform a query against the UCL API using RCurl and then return the result.
UCLApiQueryJSON <- function(endpoint, parameters, apikey = Sys.getenv(c("UCLAPIKEY")),  baseurl = "https://uclapi.com/") {
    suppressPackageStartupMessages(library(RCurl))

    query <- ""

    for (a in names(parameters)) {
        b <- gsub(" ", "+", parameters[[a]])
        query <- paste(query, "&", a, "=", b, sep="")
    }
    

    url <- paste(baseurl, endpoint, "?token=", apikey, query, sep="")

    response <- getURL(url)

    return(response)
}