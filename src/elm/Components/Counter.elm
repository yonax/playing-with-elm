module Components.Counter exposing (Model, Msg, init, view, update)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


type alias Model =
    Int


init : Int -> Model
init n =
    n



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
    div
        [ class "block" ]
        [ a [ class "button", onClick Decrement ] [ text "-" ]
        , span [ class "tag is-primary is-medium" ] [ text <| toString model ]
        , a [ class "button", onClick Increment ] [ text "+" ]
        ]
