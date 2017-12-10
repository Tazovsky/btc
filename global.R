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
