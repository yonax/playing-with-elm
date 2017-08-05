module Data.Todo exposing (Todo, decoder)

import Json.Decode exposing (Decoder, map3, field, int, string, bool)


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
