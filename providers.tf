terraform {
  required_providers {
    spotify = {
      source = "conradludgate/spotify"
      version = "0.2.7"
    }
  }
}

provider "spotify" {
  # Configuration options
  api_key = var.spotify_api_key
}

# See https://github.com/conradludgate/terraform-provider-spotify#how-to-use
# for how to get an api key

