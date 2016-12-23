module View exposing (view)

import Messages exposing (Msg(..))
import Model exposing (Model)
import Html exposing (..)


view : Model -> Html Msg
view model =
    h1 [] [ text "Potato!" ]
