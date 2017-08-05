module Request.Todo exposing (list, check)

import Data.Todo as Todo exposing (Todo, decoder, encode)
import Http
import Json.Decode as Decode
import Json.Encode as Encode
import Request.Common as Common

list : Http.Request (List Todo)
list = 
  let 
    listDecoder = Decode.list decoder
  in
    Http.get "http://localhost:3000/tasks" listDecoder

check : Int -> Bool -> Http.Request Todo
check todoId completed = 
  let
    object = 
      Encode.object
        [ ("completed", Encode.bool completed)]
    body = Http.jsonBody object
  in
    Common.patch ("http://localhost:3000/tasks/" ++ toString todoId) body decoder