module Request.Common exposing (patch)

import Json.Decode exposing (Decoder)
import Http exposing (Body, Request, request, expectJson)

patch : String -> Body -> Decoder a -> Request a
patch url body decoder =
  request
    { method = "PATCH"
    , headers = []
    , url = url
    , body = body
    , expect = expectJson decoder
    , timeout = Nothing
    , withCredentials = False
    }