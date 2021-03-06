module Model exposing (Model, Job, model, decodeJob)

-- url is refs/landing_page, companyName is company/name

import Date exposing (Date)
import Json.Decode exposing (map8, field, int, string, list, Decoder)
import Json.Decode.Extra exposing (date)
import Select


type alias Job =
    { id : Int
    , name : String
    , contents : String
    , pubDate : Date
    , categories : List String
    , levels : List String
    , companyName : String
    , url : String
    }


decodeJob : Decoder Job
decodeJob =
    map8 Job
        (field "id" int)
        (field "name" string)
        (field "contents" string)
        (field "pub-date" date)
        (field "categories" (list string))
        (field "levels" (list string))
        (field "company-name" string)
        (field "url" string)


type alias Model =
    { page : Int
    , company : String
    , category : List String
    , categorySelectState : Select.Model
    , level : List String
    , location : List String
    , jobs : List Job
    }


{-| Produces an empty model
-}
model : Model
model =
    { page = 1
    , company = ""
    , category = []
    , categorySelectState = Select.newState "Engineering"
    , level = []
    , location = []
    , jobs = []
    }
