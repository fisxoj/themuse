module Update exposing (update)

import Messages exposing (Msg(..))
import Model exposing (Model)
import API exposing (jobs)
import Select
import View exposing (selectConfig)


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

        CompanyChanged company ->
            ( { model | company = company }, Cmd.none )

        CategorySelectMsg msg ->
            let
                ( updated, cmd ) =
                    Select.update selectConfig msg model.categorySelectState
            in
                ( { model | categorySelectState = updated }, cmd )

        CategorySelect str ->
            ( { model | category = str :: model.category }, Cmd.none )

        CategoryRemove str ->
            let
                categories =
                    List.filter (\a -> a /= str) model.category
            in
                ( { model | category = categories }, Cmd.none )
