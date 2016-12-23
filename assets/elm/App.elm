module App exposing (main)

import Update exposing (update)
import Messages exposing (Msg)
import Model exposing (Model, model)
import View exposing (view)
import Html


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = (\_ -> Sub.none)
        }
