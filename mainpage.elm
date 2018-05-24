import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode as Decode
import Random
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- Model
type alias Model = Time

-- Init

init : (Model, Cmd Msg)
init =
  (0, Cmd.none)

-- Update

type Msg
  = Tick Time

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      (newTime, Cmd.none)

-- Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every second Tick

-- View

view : Model -> Html Msg
view model =
  let
      angle =
        turns (Time.inMinutes model)

      handX =
        toString (50 + 40 * cos angle)

      handY =
        toString (50 + 40 * sin angle)
  in
     svg [ viewBox "0 0 100 100", width "300px" ]
      [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
      , line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke "#023963" ] []
      ]

fragmentShader : Shader {} {} { vcolor : Vec3 }
fragmentShader =
  [glsl|

    precision mediump float;
    varying vec3 vcolor;

    void main() {
      gl_Fragcolor = vec4(vcolor, 1.0);
    }
  |]
