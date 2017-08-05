module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Components.Task as Task


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { entries : List Task.Model
    }


model : Model
model =
    { entries = [ Task.init "Hello", Task.init "Hello 2" ]
    }



-- UPDATE


type Msg
    = NoOp
    | TaskMsg Int Task.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        TaskMsg index msg ->
            let
                update msg i taskModel =
                    if index == i then
                        Task.update msg taskModel
                    else
                        taskModel
            in
                { model | entries = List.indexedMap (update msg) model.entries }



-- VIEW


view : Model -> Html Msg
view model =
    section
        [ class "section" ]
        (List.indexedMap (\index t -> Task.view t |> Html.map (TaskMsg index)) model.entries)
