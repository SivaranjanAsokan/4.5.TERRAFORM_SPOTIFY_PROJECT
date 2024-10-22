# 🎶Spotify_PlayList_Creation💽

## 🎧PLAYLIST-1🎉
![PLAYLIST-1](https://github.com/user-attachments/assets/47938fe6-ce08-45d0-bd89-cb6ba2ce5533)

## 🎧PLAYLIST-2🎉
![PLAYLIST-2](https://github.com/user-attachments/assets/a0184966-c07f-4ddd-aa93-dec61535d9aa)


[![docs](https://img.shields.io/static/v1?label=docs&message=terraform&color=informational&style=for-the-badge&logo=terraform)](https://registry.terraform.io/providers/conradludgate/spotify/latest/docs)
![downloads](https://img.shields.io/badge/dynamic/json?label=downloads&query=%24.data.attributes.downloads&url=https%3A%2F%2Fregistry.terraform.io%2Fv2%2Fproviders%2F1325&style=for-the-badge&color=brightgreen&logo=terraform)
![latest version](https://img.shields.io/badge/dynamic/json?label=version&query=%24.data[(%40.length-1)].attributes.version&url=https%3A%2F%2Fregistry.terraform.io%2Fv2%2Fproviders%2F1325%2Fprovider-versions&style=for-the-badge&color=orange&logo=terraform)
[![code coverage](https://img.shields.io/codecov/c/gh/conradludgate/terraform-provider-spotify?style=for-the-badge)](https://app.codecov.io/gh/conradludgate/terraform-provider-spotify/)

This is a terraform provider for managing your spotify playlists.

Featured tutorial - https://learn.hashicorp.com/tutorials/terraform/spotify-playlist

Featured interview - https://www.hashicorp.com/blog/build-your-summer-spotify-playlist-with-terraform

> I am not affiliated with Hashicorp or Terraform.
>
> If you are having trouble with the provider, try updating to the latest version
> before submitting a bug report

## Example

```tf
resource "spotify_playlist" "playlist" {
  name        = "My playlist"
  description = "My playlist is so awesome"
  public      = false

  tracks = flatten([
    data.spotify_track.overkill.id,
    data.spotify_track.blackwater.id,
    data.spotify_track.overkill.id,
    data.spotify_search_track.search.tracks[*].id,
  ])
}

data "spotify_track" "overkill" {
  url = "https://open.spotify.com/track/4XdaaDFE881SlIaz31pTAG"
}
data "spotify_track" "blackwater" {
  spotify_id = "4lE6N1E0L8CssgKEUCgdbA"
}

data "spotify_search_track" "search" {
  name   = "Somebody Told Me"
  artist = "The Killers"
  album  = "Hot Fuss"
}

output "test" {
  value = data.spotify_search_track.search.tracks
}
```


## Installation

Add the following to your terraform configuration

```tf
terraform {
  required_providers {
    spotify = {
      source  = "conradludgate/spotify"
      version = "~> 0.2.0"
    }
  }
}
```

## How to use

First, you need an instance of a spotify oauth2 server running. This acts as a middleware between terraform and spotify to allow easy access to access tokens.

### Public proxy

For a simple way to manage your spotify oauth2 tokens is to use https://oauth2.conrad.cafe. ([source code](https://github.com/conradludgate/oauth2-proxy))

Register a new account, create a spotify token with the following scopes

* user-read-email
* user-read-private
* playlist-read-private
* playlist-modify-private
* playlist-modify-public
* user-library-read
* user-library-modify

Then take note of the token id in the URL and the API key that is shown on the page

Configure the terraform provider like so

```tf
provider "spotify" {
  auth_server = "https://oauth2.conrad.cafe"
  api_key     = var.spotify_api_key
  username    = "your username"
  token_id    = "your token id"
}

variable "spotify_api_key" {
  type = string
}
```

### Self hosted

If you want a bit more control over your tokens, you can self host a simple instance of the oauth2 proxy designed specifically for this terraform provider

See [spotify_auth_proxy](/spotify_auth_proxy) to get started.

Once you have the server running, make note of the API Key it gives you.

Configure the terraform provider like so

```tf
variable "spotify_api_key" {
  type = string
}

provider "spotify" {
  api_key = var.spotify_api_key
}
```
Step-1: Open Spotify Developer page & create app :
![1 Create-app](https://github.com/user-attachments/assets/4f4cb14f-c32c-44e6-bd90-e818b02a2631)

Step-2: Enter name, description & Redirect path: http://localhost:27228/spotify_callback.
![2](https://github.com/user-attachments/assets/ce08a6c8-cf95-494e-b432-2c806a8e0fcf)

Step-3: Open created App:
![3](https://github.com/user-attachments/assets/d0ccdb4d-4207-42fa-9fbe-6a52b04d44c2)

Step-4: Open Settings Option:
![4](https://github.com/user-attachments/assets/d6952e01-a8c7-4ab8-a1a5-1aa277e95f76)

Step-5: Get the Client ID & Serect:
![5](https://github.com/user-attachments/assets/8cc2a070-dece-4171-a3ed-eabd1e059ea6)

Step-6: Set env variable :
i)export SPOTIFY_PROXY_BASE_URI=http://localhost:27228/spotify_callback
ii)create environment file with 
![6](https://github.com/user-attachments/assets/3d30eb81-de38-4ddb-bcae-ef3a04d7c408)

Step-7: Set value:  
SPOTIFY_CLIENT_ID=
SPOTIFY_CLIENT_SECRET=
![7](https://github.com/user-attachments/assets/e7913977-1c76-40f0-9880-e4ba8fc58ab3)

Step-8: Run docker command
$ docker run --rm -it -p 27228:27228 --env-file ./.env ghcr.io/conradludgate/spotify-auth-proxy
![6api](https://github.com/user-attachments/assets/14e653c0-1d16-4b47-b95d-f02491bef4fb)

Step-9: Click the link & approve in browser:
![7api](https://github.com/user-attachments/assets/2a3c2e19-93a9-43b9-8894-51f4982956a0)

Step-10: Crete terraform files:
![8](https://github.com/user-attachments/assets/32fe98f8-123b-4345-be57-fcd7bf3ccbd4)

![9](https://github.com/user-attachments/assets/7f759938-816e-490a-9c2c-6328a606dcda)

![10](https://github.com/user-attachments/assets/c660436d-2538-4eb8-a50b-f43422cfa2cf)

# After All this Run Terraform commands & See the Result 🎉🎉🎉

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# spotify_auth_proxy

This is an instance of a 'Spotify auth server' which acts as an interface between a client and the Spotify oauth API.

## Installation

With `go` installed, run

```sh
go get -u github.com/conradludgate/terraform-provider-spotify/spotify_auth_proxy
```

## Usage

First, you need a Spotify client ID and secret. Visit https://developer.spotify.com/dashboard/ to create an application.

If you plan to run this proxy locally, set the redirect URI of the application to `http://localhost:27228/spotify_callback`.
If you're running it remotely, substitute an appropiate base url (eg `https://spotify.example.com/spotify_callback`)

You will also need to register the callback URI with Spotify for your application. Visit https://developer.spotify.com/dashboard/, click on your application, find and click the "Edit Settings" button, and paste the `spotify_callback` URI above into "Redirect URIs". Scroll down and click "Save".

To start the server, make sure the environment variables `SPOTIFY_CLIENT_ID` and `SPOTIFY_CLIENT_SECRET` are set from the values on the Spotify dashboard.
If running remotely, also configure your base url

```sh
export SPOTIFY_PROXY_BASE_URI=https://spotify.example.com
```

Finally, run

```sh
spotify_auth_proxy
```

It should output the following:

```
APIKey:   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
Auth URL: ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
```

Take note of these values.

Now, open a browser and navigate to the Auth URL. It should redirect you to Spotify to log in. After you log in, the auth server will redirect you back to the page where it should confirm that you've authorized correctly.

The API Key is how you will retrieve the access token. The server will handle the token expiration and refreshes for you.

The API Key is random on each invocation, you can specify the `SPOTIFY_PROXY_API_KEY` environment variable to keep it consistent

## Docker

Alternatively, you can use the Docker to run the Spotify auth proxy.

First, create a file named `.env` and populate it with your `SPOTIFY_CLIENT_ID` and `SPOTIFY_CLIENT_SECRET` values. Your file should look similar to the following.

```
SPOTIFY_CLIENT_ID=
SPOTIFY_CLIENT_SECRET=
```

Then, run the following command to start the auth proxy.

```
$ docker run --rm -it -p 27228:27228 --env-file ./.env ghcr.io/conradludgate/spotify-auth-proxy
APIKey: OK7b1j...
Token:  aoIvJT...
Auth:   http://localhost:27228/authorize?token=aoIvJT...
```







