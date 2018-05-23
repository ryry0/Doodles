import Html exposing (Html, button, div, text, input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)


main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- Model
type alias Model =
  { content : String
  }

model : Model
model =
  { content = "" }

-- Update

type Msg = Change String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | content = newContent }

-- View

view : Model -> Html Msg
view model =
  div []
  [ input [ placeholder "Text to reverse", onInput Change ] []
  , div [] [ text (String.reverse model.content) ]
  ]
