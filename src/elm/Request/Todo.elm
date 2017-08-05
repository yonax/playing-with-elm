module Request.Todo exposing (list)

import Data.Todo as Todo exposing (Todo, decoder)
import Http
import Json.Decode as Decode

list : Http.Request (List Todo)
list = 
  let 
    listDecoder = Decode.list decoder
  in
    Http.get "http://localhost:3000/tasks" listDecoder