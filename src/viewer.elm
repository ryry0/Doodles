-- bad because I am completely sidestepping problem of signals of signals
import Task exposing (Task)
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Window

-- Main

main = -- map our scene onto webgl
    Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- Model
type alias Model =
  { source :String
  , resolution: (Int, Int)
  }

initial_model : Model
initial_model = { source = "gl1-rect.html", resolution = (1000, 1000) }

init : ( Model, Cmd Msg )
init =
    ( initial_model, Cmd.none )

-- Update
type Msg = Select String | Resolution (Int, Int)

update : Msg -> Model -> ( Model, Cmd Msg)
update action model =
  case action of
    Select string ->
      ({ model | source = string } , Cmd.none)

    Resolution a ->
      ({ model | resolution = a }, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Window.resizes windowSizeToResolution
        --, AnimationFrame.diffs DeltaTime
        ]

windowSizeToResolution : Window.Size -> Msg
windowSizeToResolution windowsize =
    Resolution ( windowsize.width, windowsize.height )

-- View


pageList : List (String, String)
pageList =
  [ ("Rectangle",  "index.html")
  , ("Randomly Moving Rectangle",  "gl2-random-rect.html")
  , ("Randomly Moving Rectangle via Uniforms",  "gl3-random-rect-uniform.html")
  , ("Pretty Cube",  "gl4-prettycube.html")
  , ("Cube Mouse Control",  "gl5-cube-control.html")
  , ("Textured Rectangle",  "gl6-textured-rec.html")
  , ("Lambda Fractal",  "gl7-lambda-fractal.html")
  , ("4th Power Julia Fractal",  "gl8-julia4-fractal.html")
  , ("Colored Point Field",  "gl9-point-field.html")
  , ("Point Cube",  "gl10-point-cube.html")
  , ("Strange Attractors",  "gl11-strange-attractor.html")
  , ("Signed Distance Fields",  "gl13-distance-fields.html")
  , ("Multiple Render Objects",  "gl14-multi-cube.html")
  ]

pageOption : (String, String) -> Html Msg
pageOption (name, address) =
    option [ Html.Attributes.value address ] [ text name ]

view : Model -> Html Msg
view model =
  div []
  [ select [ Html.Events.onInput Select ] (List.map pageOption pageList)
  , iframe [ Html.Attributes.src model.source
           , Html.Attributes.width <| (Tuple.first model.resolution) - 10
           , Html.Attributes.height <| (Tuple.second model.resolution) - 40
           ] []
  ]
