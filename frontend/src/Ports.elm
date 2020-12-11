port module Ports exposing (clearToken, storeToken)

import Data
import Json.Decode as Decode
import Json.Encode as Encode


port clearToken : () -> Cmd msg


port storeToken : Data.Token -> Cmd msg

--Connect BACKEND to store AuthTokens (Username and Password for now; later add NAME/SHOPNAME and if shop address)

