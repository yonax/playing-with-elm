module Main exposing (..)

import Html exposing (Html, section, div, text)
import Html.Attributes exposing (class)
import Http
import Data.Todo exposing (Todo)
import Request.Todo as TodoRequest
import View.Todo as TodoView


main : Program Never Model Msg
main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }



-- Load data


loadTodos : Cmd Msg
loadTodos =
    Http.send TodosLoaded TodoRequest.list



-- MODEL


init : ( Model, Cmd Msg )
init =
    ( model, loadTodos )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


type alias Model =
    { entries : List Todo
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
    | TodosLoaded (Result Http.Error (List Todo))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        TodosLoaded (Ok tasks) ->
            ( { model | entries = tasks, error = Nothing }, Cmd.none )

        TodosLoaded (Err error) ->
            ( { model | error = Just error }, Cmd.none )



-- VIEW


view : Model -> Html msg
view model =
    section
        [ class "section" ]
        ([ div [] [ text <| toString model.error ] ]
            ++ (List.map TodoView.view model.entries)
        )
