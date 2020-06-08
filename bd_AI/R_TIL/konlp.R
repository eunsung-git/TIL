install.packages("Sejong")
install.packages("hash")
install.packages("tau")
install.packages("RSQLite")
install.packages("rgdal")
install.packages("geojsonio")
install.packages("rgeos")

library(Sejong)
library(hash)
library(tau)
library(RSQLite)
library(rgdal)
library(geojsonio)
library(rgeos)

install.packages('KoNLP')
library(KoNLP)

sentence <- '아버지가 방에 들어가신다'
extractNoun(sentence)
