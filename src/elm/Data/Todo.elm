module Data.Todo exposing (Todo, decoder, encode)

import Json.Decode exposing (Decoder, map3, field, int, string, bool)
import Json.Encode as Encode


type alias Todo =
    { id : Int
    , text : String
    , completed : Bool
    }


decoder : Decoder Todo
decoder =
    map3 Todo
        (field "id" int)
        (field "text" string)
        (field "completed" bool)

encode : Todo -> Encode.Value
encode todo = 
  Encode.object
    [ ("id", Encode.int todo.id)
    , ("text", Encode.string todo.text)
    , ("completed", Encode.bool todo.completed)
    ]