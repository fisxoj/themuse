module View exposing (view, selectConfig)

import Messages exposing (Msg(..))
import Model exposing (Model, Job)
import Html exposing (..)
import Html.Attributes exposing (href, class, type_, placeholder, value)
import Html.Events exposing (onInput, onClick)
import Html.Events.Extra exposing (onEnter)
import Date.Extra
import Select
import API.Values exposing (categories)


selectConfig : Select.Config Msg String
selectConfig =
    Select.newConfig CategorySelect identity
        |> Select.withCutoff 4


view : Model -> Html Msg
view model =
    let
        categoryView =
            Select.view selectConfig model.categorySelectState categories (List.head model.category)
                |> Html.map CategorySelectMsg

        categoryFacet str =
            span [ class "category", onClick (CategoryRemove str) ] [ text str ]
    in
        main_ []
            [ h1 [] [ text "The Muse Job Search" ]
            , div [ class "search-bar" ]
                [ input [ type_ "text", onInput CompanyChanged, onEnter Search, placeholder "Company Name", value model.company ] []
                , div [ class "categories" ]
                    [ categoryView
                    , div [] (List.map categoryFacet model.category)
                    ]
                , button [ class "search-button", onClick Search ] [ text "Search" ]
                ]
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
