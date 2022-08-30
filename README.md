# SpotifyTracks

SpotifyTracks is search application for your favourite track using spotify APIs.

Architecture
MVP (Model for data layer , View for viewcontrollers and XIB, presenters for getting APIs response from services and notify viewcontroller)

Used Packages: using "Swift Package manager"
Kingfisher : for getting images from URL
NetworkingLayer : package I created for http requests

Features:
Login to Spotify and request token
Search for your favourite track 
Cache searched track track 
Refresh token if expired
Navigate to track details

Things to improve:
More unit testing
Add dependency injection framework
