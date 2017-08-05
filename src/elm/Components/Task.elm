module Components.Task exposing (Model, Msg, init, view, update)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { title : String
    , completed : Bool
    }


init : String -> Model
init title =
    Model title False


type Msg
    = ChangeTitle String
    | SetCompleted Bool


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeTitle newTitle ->
            { model | title = newTitle }

        SetCompleted newCompleted ->
            { model | completed = newCompleted }


view : Model -> Html Msg
view model =
    div [ class "level" ]
        [ div [ class "level-left" ]
            [ div [ class "level-item" ]
                [ input [ type_ "checkbox", checked model.completed, onCheck SetCompleted ]
                    []
                ]
            , div [ class "level-item" ]
                [ div [ class "control is-expanded" ]
                    [ input [ class "input", type_ "text", value model.title, onInput ChangeTitle ]
                        []
                    ]
                ]
            ]
        ]
