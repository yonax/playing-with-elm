module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Components.Counter as Counter


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias CounterWithId =
    { id : Int
    , counter : Counter.Model
    }


type alias Model =
    { counters : List CounterWithId
    , nextId : Int
    }


model : Model
model =
    { counters = [ CounterWithId 0 <| Counter.init 0 ]
    , nextId = 1
    }



-- UPDATE


type Msg
    = NoOp
    | AddCounter
    | RemoveCounter Int
    | CounterMsg Int Counter.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        AddCounter ->
            { model
                | counters = (CounterWithId model.nextId <| Counter.init 0) :: model.counters
                , nextId = model.nextId + 1
            }

        RemoveCounter counterId ->
            { model | counters = List.filter (\c -> c.id /= counterId) model.counters }

        CounterMsg counterId msg ->
            let
                update counter =
                    if counter.id == counterId then
                        { counter | counter = Counter.update msg counter.counter }
                    else
                        counter
            in
                { model | counters = List.map update model.counters }



-- VIEW


view : Model -> Html Msg
view model =
    section [ class "section" ]
        (List.concat
            [ [ a [ class "button is-primary", onClick AddCounter ] [ text "add counter" ] ]
            , (List.map
                (\counter ->
                    div
                        [ class "block" ]
                        [ Counter.view counter.counter |> Html.map (CounterMsg counter.id)
                        , a [ class "button is-danger", onClick (RemoveCounter counter.id) ] [ text "remove" ]
                        ]
                )
                model.counters
              )
            ]
        )
