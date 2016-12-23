module API exposing (jobs)

import Http
import Task
import Json.Decode exposing (list)
import API.CSRF exposing (csrfToken)
import Model exposing (Model, decodeJob)
import Messages exposing (Msg(..))
import QueryString exposing (empty, add, render)


apiBase : String
apiBase =
    "/api"


encodeQuery : Model -> String -> String
encodeQuery model endpoint =
    let
        qs =
            empty
                |> add "company" model.company
                |> add "category" (toString model.category)
                |> add "level" (toString model.level)
                |> add "location" (toString model.location)
                |> render
    in
        apiBase ++ endpoint ++ qs


jobs : Model -> Cmd Msg
jobs model =
    send "GET" (encodeQuery model "/jobs") Http.emptyBody (list decodeJob)
        |> Http.send GotJobs


{-| Sends a HTTP request with the CSRF token added into the headers
-}
send : String -> String -> Http.Body -> Json.Decode.Decoder value -> Http.Request value
send method url body decoder =
    Http.request
        { method = method
        , headers =
            [ Http.header "X-CSRF-Token" (Maybe.withDefault "" csrfToken)
            , Http.header "Content-Type" "application/json"
            ]
        , url = url
        , body = body
        , expect = Http.expectJson decoder
        , timeout = Nothing
        , withCredentials = False
        }
