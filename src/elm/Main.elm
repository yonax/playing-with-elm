module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Components.Hello exposing (hello)


main : Program Never Int Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    Int


model : number
model =
    0



-- UPDATE


type Msg
    = NoOp
    | Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        Increment ->
            model + 1

        Decrement ->
            model - 1



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "main container is-fluid" ]
        [ div
            [ class "block" ]
            [ a [ class "button", onClick Decrement ] [ text "-" ]
            , span [ class "tag is-primary is-medium" ] [ text <| toString model ]
            , a [ class "button", onClick Increment ] [ text "+" ]
            ]
        ]
