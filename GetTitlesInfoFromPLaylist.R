#previously to using read de ReadMe. You need to create a Spotify Developper account.

#library
library(jsonlite,httr)

#parameters
playlistID<-"37i9dQZF1DZ06evO05tE88" #Put here the playlist ID as it appears in the url of the spotify playlist
saveDirectory<-"." #directory where to save the .txt files with the audacity markers
client_id<-""      #Spotify for developers  client_id
client_secret<-""  #Spotify for developers  client_secret
market<-"FR"       #Spotify market indentification. It helps if songs in the playlist are not available in your area.


#####code

# Obtain the access token
response <- httr::POST(
  url = "https://accounts.spotify.com/api/token",
  body = list(
    grant_type = "client_credentials",
    client_id = client_id,
    client_secret = client_secret
  ),
  encode = "form"
)

# Extract the token from the response
token <- httr::content(response)$access_token

# Define the headers with the token
headers <- httr::add_headers(Authorization = paste("Bearer", token))

# get playlist general info to find the title
resTitle <- httr::GET(
  url = paste0("https://api.spotify.com/v1/playlists/", playlistID, "?market=",market),
  headers
)
resTitle_content <- httr::content(resTitle, as = "text", encoding = "UTF-8")
title<-jsonlite::fromJSON(resTitle_content)$name 

# get tracks info to get tracks title, artists and duration
res <- httr::GET(
  url = paste0("https://api.spotify.com/v1/playlists/", playlistID, "/tracks"),
  headers
)
response_content <- httr::content(res, as = "text", encoding = "UTF-8")

#construct the markers .txt file as expected by audacity
json<-jsonlite::fromJSON(response_content)
data<-json[["items"]]$track
data<-data[,c("name","artists","duration_ms")]
startYT=0
stopYT=0
file.create(paste0(saveDirectory,"/",title,".txt"))
for(k in 1:nrow(data)){
  X<-data[k,]
  ar<-paste(X$artists[[1]]$name,collapse=",")
  titleYoto<-paste0(X$name,"-",ar)
  stopYT<-startYT+X$duration_ms/1000
  nltxt<-paste0(startYT,"	",stopYT,"	",titleYoto)
  write(nltxt, file = paste0(title,".txt"), append = TRUE)
  startYT=stopYT
}
