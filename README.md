# SpotifyPlaylist2AudacityMarkers
A small script to request information of a spotify playlist via its API, in order to create a marker txt file delimiting marker for Audacity.
It does note take care of ad interludes. So you might need a premium spotify account or to manually make the adjustment in Audacity.

#Spotify credential
To be able to run the script you need spotify for developers credential.
Visit https://developer.spotify.com/, go to your Dashboard and click on "Create app".
* The App name and App description doesn't matter here. Put anything.
* For the redirect Redirect URIs, you can choose any valide adresse. For instance, https://www.google.fr hworks.
* Tick Web API for the "Which API/SDKs are you planning to use?" section.

Once the app saved, go bask to the dashboard and open the newly created app.
In the settings, in the first section you will find the Client ID. Click on View client secret to get the Client secret value.
These two values need to be copy and paste in the R code.

#run the code
To run the code, you will need to install the libraries jsonlite and httr.
In the R script, fill the required parameters.
The result file will be saved in the directory given as a parameter of the script. The name of the file is the name of the playlist.

#usage of Audacity
This script is intended to be used as a help when making a legal private copy of a spotify playlist.
It means :
* open audacity
* choose the source of the sound
* press the record button
* press play on spotify to listen to the playlist. Audacity will not start to record if their is no song or music.
* when the playlist is over, stop the recording.
* Then import the marker file. The marker should be aligned with the start and the end of each song.
* Finaly export the song as mp3 with file names based on the markers.