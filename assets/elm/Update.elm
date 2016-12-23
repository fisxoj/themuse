module Update exposing (update)

import Messages exposing (Msg(..))
import Model exposing (Model)
import API exposing (jobs)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotJobs result ->
            case result of
                Err _ ->
                    ( model, Cmd.none )

                Ok jobs ->
                    ( { model | jobs = jobs }, Cmd.none )

        Search ->
            ( model, jobs model )
