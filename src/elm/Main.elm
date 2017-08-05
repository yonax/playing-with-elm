module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Json.Decode as Decode
import Components.Task as Task


main : Program Never Model Msg
main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }



-- Load data


type alias Tasks =
    List Task.Model


getTasks : Http.Request Tasks
getTasks =
    Http.get "http://localhost:3000/tasks" decodeTasks


decodeTasks : Decode.Decoder Tasks
decodeTasks =
    Decode.list decodeTask


decodeTask : Decode.Decoder Task.Model
decodeTask =
    Decode.map2 Task.Model
        (Decode.field "title" Decode.string)
        (Decode.field "completed" Decode.bool)


loadTasks : Cmd Msg
loadTasks =
    Http.send TasksLoaded getTasks



-- MODEL


init : ( Model, Cmd Msg )
init =
    ( model, loadTasks )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


type alias Model =
    { entries : List Task.Model
    , error : Maybe Http.Error
    }


model : Model
model =
    { entries = []
    , error = Nothing
    }



-- UPDATE


type Msg
    = NoOp
    | TasksLoaded (Result Http.Error Tasks)
    | TaskMsg Int Task.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        TasksLoaded (Ok tasks) ->
            ( { model | entries = tasks, error = Nothing }, Cmd.none )

        TasksLoaded (Err error) ->
            ( { model | error = Just error }, Cmd.none )

        TaskMsg index msg ->
            let
                update msg i taskModel =
                    if index == i then
                        Task.update msg taskModel
                    else
                        taskModel
            in
                ( { model | entries = List.indexedMap (update msg) model.entries }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    section
        [ class "section" ]
        ([ div [] [ text <| toString model.error ] ]
            ++ (List.indexedMap (\index t -> Task.view t |> Html.map (TaskMsg index)) model.entries)
        )
