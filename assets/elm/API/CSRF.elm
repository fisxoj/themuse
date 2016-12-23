module API.CSRF exposing (csrfToken)

import Native.CSRF


csrfToken : Maybe String
csrfToken =
    Native.CSRF.csrfToken
