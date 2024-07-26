resource "spotify_playlist" "kollywood" {
  name        = "kollywood"
  description = "I created playlist is so awesome"
  tracks       = ["34jOQQkZnyo4v5k0T8PD67"]
    
}

resource "spotify_playlist" "Ilaiyaraaja" {
  name        = "My Ilaiyaraaja Playlist"

  tracks = [
    data.spotify_search_track.Ilaiyaraaja.tracks[0].id,
    data.spotify_search_track.Ilaiyaraaja.tracks[1].id,
    data.spotify_search_track.Ilaiyaraaja.tracks[2].id,
    data.spotify_search_track.Ilaiyaraaja.tracks[3].id,
    data.spotify_search_track.Ilaiyaraaja.tracks[4].id,
    data.spotify_search_track.Ilaiyaraaja.tracks[5].id,
    data.spotify_search_track.Ilaiyaraaja.tracks[6].id,
    data.spotify_search_track.Ilaiyaraaja.tracks[7].id,
    data.spotify_search_track.Ilaiyaraaja.tracks[8].id,
    data.spotify_search_track.Ilaiyaraaja.tracks[9].id
  ]
}

data "spotify_search_track" "Ilaiyaraaja" {
  artist = "Ilaiyaraaja"
  limit = 10
}

#Method-2
locals {
  track_ids = [
    null,
    "34jOQQkZnyo4v5k0T8PD67",
    # other track IDs
  ]
}

resource "spotify_playlist" "kollywood" {
  name   = "kollywood"
  tracks = compact(local.track_ids)
}
