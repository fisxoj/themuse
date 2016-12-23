module Messages exposing (Msg(..))

import Model exposing (Job)
import Http
import Select


type Msg
    = GotJobs (Result Http.Error (List Job))
    | Search
    | CategorySelectMsg (Select.Msg String)
    | CategorySelect String
    | CategoryRemove String
      -- | CategoryChanged
      -- | Page
    | CompanyChanged String



-- | SortChanged Bool
-- | LevelChanged
-- | LocationChanged
