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

# Perform a query against the UCL API and use jsonlite to convert this into a data frame or list.
UCLApiQuery <- function(endpoint, parameters, apikey = Sys.getenv(c("UCLAPIKEY")),  baseurl = "https://uclapi.com/") {

    suppressPackageStartupMessages(library(jsonlite))

    json <- UCLApiQueryJSON(endpoint, parameters, apikey, baseurl)

    objectname <- UCLApiEndpointToObject(endpoint)

    result <- fromJSON(json)

    if (objectname != "") {
        result <- result[[objectname]]
    }
    return(result)
}

# Work out which object to pull out of the json based on the endpoint.
UCLApiEndpointToObject <- function(endpoint) {
    retval <- ""

    endpoints <- list()
    endpoints[["search/people"]] <- "people"
    endpoints[["roombookings/rooms"]] <- "rooms"
    endpoints[["roombookings/equipment"]] <- "equipment"
    endpoints[["roombookings/bookings"]] <- "bookings"


    if (is.element(endpoint, names(endpoints))) {
        retval <- endpoints[[endpoint]]
    }

    return(retval)
}