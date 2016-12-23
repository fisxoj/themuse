module Messages exposing (Msg(..))

import Model exposing (Job)


type Msg
    = HttpError
    | GotJobs (List Job)



-- | Search
-- | CategoryChanged
-- | Page
-- | CompanyChanged String
-- | SortChanged Bool
-- | LevelChanged
-- | LocationChanged
