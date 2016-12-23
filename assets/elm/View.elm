module View exposing (view)

import Messages exposing (Msg(..))
import Model exposing (Model, Job)
import Html exposing (..)
import Html.Attributes exposing (href, class)
import Date.Extra


view : Model -> Html Msg
view model =
    main_ []
        [ h1 [] [ text "The Muse Job Search" ]
        , div [ class "job-list" ] (List.map jobView model.jobs)
        ]


jobView : Job -> Html Msg
jobView job =
    let
        categoryPill : String -> Html Msg
        categoryPill cat =
            div [ class "category" ] [ text cat ]

        levelPill : String -> Html Msg
        levelPill level =
            div [ class "level" ] [ text level ]
    in
        section [ class "job" ]
            [ h2 [] [ a [ href job.url ] [ text job.name ] ]
            , div [ class "subheader" ]
                [ span [ class "company" ] [ text job.companyName ]
                , span [ class "date" ]
                    [ text (Date.Extra.toFormattedString "EEE, MMM, d, y" job.pubDate) ]
                , div [ class "categories" ] (List.map categoryPill job.categories)
                , div [ class "levels" ] (List.map levelPill job.levels)
                ]
            , p [] [ text job.contents ]
            ]
