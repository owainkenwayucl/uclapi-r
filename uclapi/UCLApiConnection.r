# Perform a query against the UCL API using RCurl and then return the result.
UCLApiQueryJSON <- function(endpoint, parameters, apikey = Sys.getenv(c("UCLAPIKEY")),  baseurl = "https://uclapi.com/") {
    suppressPackageStartupMessages(library(RCurl))

    query <- parameters

    url <- paste(baseurl, endpoint, "?token=", apikey, query, sep="")

    response <- getURL(url)

    return(response)
}