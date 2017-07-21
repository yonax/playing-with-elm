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
    , secondCounter : Counter.Model
    }


model : Model
model =
    { counter = Counter.init 0
    , secondCounter = Counter.init 100
    }



-- UPDATE


type Msg
    = NoOp
    | CounterMsg Counter.Msg
    | SecondCounterMsg Counter.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        CounterMsg msg ->
            { model | counter = Counter.update msg model.counter }

        SecondCounterMsg msg ->
            { model | secondCounter = Counter.update msg model.secondCounter }



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "main container is-fluid" ]
        [ div
            [ class "block" ]
            [ Counter.view model.counter |> Html.map CounterMsg
            , Counter.view model.secondCounter |> Html.map SecondCounterMsg
            ]
        ]
