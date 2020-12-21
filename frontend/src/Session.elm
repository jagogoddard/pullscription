module Session exposing
    ( Event(..)
    , Msg
    , Session
    , addAuthToken
    , clearAuthToken
    , getAuthToken
    , init
    , navBack
    , navPush
    , navPushUrl
    , navReplace
    , popCmd
    , reset
    , setUrl
    , update
    --, getPullList
    --, addPull
    )

import Browser.Navigation as Navigation
import Data
import Json.Decode exposing (Value)
import Ports
import Route exposing (Destination, urlFor)
import Url exposing (Url)
import Url.Builder as Builder


type alias Rep =
    { navKey : Navigation.Key
    , url : Url
    , authToken : Maybe Data.Token
    , cmdQueue : List (Cmd Msg)
    }


type Session
    = Session Rep


type Msg
    = Noop


type Event
    = NoEvent


init : Navigation.Key -> Url -> Maybe Data.Token -> Session
init key url authToken =
    Session <| Rep key url authToken [] 


reset : Session -> Session
reset (Session session) =
    init session.navKey session.url session.authToken 


update : Msg -> Session -> ( Session, Maybe Event )
update msg (Session session) =
    case msg of
        Noop ->
            ( Session session, Nothing )

--addPull token (Session session) =
   -- { session | pullList = Just token }
       -- |> addCmd (Ports.storeToken token)
       -- |> Session

--getPullList (Session session) =
   -- session.pullList

getAuthToken (Session session) =
    session.authToken


addAuthToken token (Session session) =
    { session | authToken = Just token }
        |> addCmd (Ports.storeToken token)
        |> Session


navBack (Session session) =
    Session (session |> addCmd (Navigation.back session.navKey 1))


clearAuthToken (Session session) =
    Session ({ session | authToken = Nothing } |> addCmd (Ports.clearToken ()))


addCmd : Cmd Msg -> Rep -> Rep
addCmd cmd session =
    { session | cmdQueue = session.cmdQueue ++ [ cmd ] }


navPush : Destination -> Session -> Session
navPush destination (Session session) =
    session
        |> addCmd (Navigation.pushUrl session.navKey (urlFor destination))
        |> Session


navPushUrl urlString (Session session) =
    session
        |> addCmd (Navigation.pushUrl session.navKey urlString)
        |> Session


navReplace : Destination -> Session -> Session
navReplace destination (Session session) =
    session
        |> addCmd (Navigation.replaceUrl session.navKey (urlFor destination))
        |> Session


navReplaceUrl urlString (Session session) =
    session
        |> addCmd (Navigation.replaceUrl session.navKey urlString)
        |> Session


popCmd (Session session) =
    ( Session { session | cmdQueue = [] }, Cmd.batch session.cmdQueue )


setUrl url (Session session) =
    Session { session | url = url }