getLast90ticksUrl <- function(interval, market, available.markets) {
  stopifnot(market %in% available.markets)
  gsub("MARKET", market, .last.90.ticks[[interval]])
}


getDataFromUrl <- function(url, output = "res.json", tz = "UTC") {
  
  system(sprintf("phantomjs save.js %s > %s", url, output))
  
  json <- fromJSON(output)
  
  dt <- as.data.frame(do.call(rbind, json))
  
  dt <- dt %>%
    mutate(time = as.POSIXct(as.numeric(time), origin = '1970-01-01', tz = tz))
  
  dt
}

getLastN <- function(n) {
  json.data <- getURL(sprintf("https://www.bitmarket.pl/json/LTCPLN/trades.json?since=%s", n))
  data <- fromJSON(json.data)
  data <- do.call(rbind, data)
  dt <- data.frame(t(data))
}

# public api: https://www.bitmarket.pl/docs.php?file=api_public.html
getCurrentData <- function(.public.json.url = "https://www.bitmarket.pl/json/BTCPLN/ticker.json") {
  # raw.result <- GET(url = .public.json.url, path = "data")
  
  # grab the data
  json.data <- getURL(.public.json.url)
  # Then covert from JSON into a list in R
  data <- fromJSON(json.data)
  data <- t(do.call(rbind, as.list(data)))
  data.frame(data)
}