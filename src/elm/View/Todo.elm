module View.Todo exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Data.Todo exposing (Todo)


view : Todo -> Html msg
view todo =
    div [ class "level" ]
        [ div [ class "level-left" ]
            [ div [ class "level-item" ]
                [ input [ type_ "checkbox", checked todo.completed ]
                    []
                ]
            , div [ class "level-item" ]
                [ div [ class "control is-expanded" ]
                    [ input [ class "input", type_ "text", value todo.text ]
                        []
                    ]
                ]
            ]
        ]
