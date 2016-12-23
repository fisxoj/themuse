module App exposing (main)

import Update exposing (update)
import Messages exposing (Msg)
import API exposing (jobs)
import Model exposing (Model, model)
import View exposing (view)
import Html


init : ( Model, Cmd Msg )
init =
    ( model, jobs model )


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = (\_ -> Sub.none)
        }
