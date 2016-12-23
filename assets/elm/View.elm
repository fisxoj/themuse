module View exposing (view)

import Messages exposing (Msg(..))
import Model exposing (Model)
import Html exposing (..)


view : Model -> Html Msg
view model =
    main_ []
        [ h1 [] [ text "The Muse Job Search" ]
        ]
