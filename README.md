# SpotifyTracks

SpotifyTracks is search application for your favourite track using spotify APIs.

## Architecture
MVP (Model for data layer , View for viewcontrollers and XIB, presenters for getting APIs response from services and notify viewcontroller)

## Used Packages: using "Swift Package manager"
-  Kingfisher : for getting images from URL
-  NetworkingLayer : package I created for http requests

## Features:
- [x] Login to Spotify and request token
- [x] Search for your favourite track 
- [x] Cache searched track track 
- [x] Refresh token if expired
- [x] Navigate to track details

## Things to improve:
-  Add unit testing for authentication
-  Implement search for artist 
-  Refresh Track Details
-  Add any dependency injection framework

