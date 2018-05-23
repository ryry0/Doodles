import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode as Decode
import Random

main =
  Html.program
    { init = init "clouds"
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- Model
type alias Model =
  { topic : String
  , gifUrl : String
  }


-- Init

init : String -> (Model, Cmd Msg)
init topic =
  (Model topic "waiting.gif", getRandomGif topic)

-- Update

type Msg
  = Fetch
  | NewGif (Result Http.Error String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Fetch ->
      (model, getRandomGif model.topic)

    NewGif (Ok newUrl) ->
      ( { model | gifUrl = newUrl }, Cmd.none )

    NewGif (Err _) ->
      (model, Cmd.none)

getRandomGif : String -> Cmd Msg
getRandomGif topic =
  let
      url =
        "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic

      request =
        Http.get url decodeGifUrl
  in
     Http.send NewGif request

decodeGifUrl : Decode.Decoder String
decodeGifUrl =
  Decode.at ["data", "image_url"] Decode.string

-- View

view : Model -> Html Msg
view model =
  div []
  [ h2 [] [ text (toString model.topic ) ]
  , img [ src model.gifUrl ] []
  , button [ onClick Fetch ] [ text "Fetch" ]
  ]

-- Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
