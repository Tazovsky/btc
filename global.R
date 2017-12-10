library(shiny)
library(plotly)
library(dplyr)
library(httr)
library(RJSONIO)
library(RCurl)

.markets <- c("BTCPLN",
              "BTCEUR",
              "LTCPLN",
              "LTCBTC",
              "LiteMineXBTC")

.last.90.ticks <- list(
  "90m" = "https://www.bitmarket.pl/graphs/MARKET/90m.json",
  "6h" = "https://www.bitmarket.pl/graphs/MARKET/6h.json",
  "1d" = "https://www.bitmarket.pl/graphs/MARKET/1d.json",
  "7d" = "https://www.bitmarket.pl/graphs/MARKET/7d.json",
  "1m" = "https://www.bitmarket.pl/graphs/MARKET/1m.json",
  "3m" = "https://www.bitmarket.pl/graphs/MARKET/3m.json",
  "6m" = "https://www.bitmarket.pl/graphs/MARKET/6m.json",
  "1y" = "https://www.bitmarket.pl/graphs/MARKET/1y.json"
)

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