module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Components.Counter as Counter


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { counter : Counter.Model
    }


model : Model
model =
    { counter = Counter.init 0 }



-- UPDATE


type Msg
    = NoOp
    | CounterMessage Counter.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        CounterMessage msg ->
            { model | counter = Counter.update msg model.counter }



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "main container is-fluid" ]
        [ div
            [ class "block" ]
            [ Counter.view model.counter |> Html.map CounterMessage ]
        ]
