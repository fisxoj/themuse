module Model exposing (Model, Job, model)

-- url is refs/landing_page, companyName is company/name

import Date exposing (Date)


type alias Job =
    { name : String
    , contents : String
    , pubDate : Date
    , categories : List String
    , levels : List String
    , companyName : String
    , url : String
    }


type alias Model =
    { page : Int
    , company : String
    , category : List String
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
    , level = []
    , location = []
    , jobs = []
    }
