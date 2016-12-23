module Messages exposing (Msg(..))

import Model exposing (Job)
import Http


type Msg
    = GotJobs (Result Http.Error (List Job))
    | Search
      -- | CategoryChanged
      -- | Page
    | CompanyChanged String



-- | SortChanged Bool
-- | LevelChanged
-- | LocationChanged
