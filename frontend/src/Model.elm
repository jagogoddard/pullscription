module Model exposing (Model, wrapPage)

import Msg
import Page
import PageMsg exposing (PageMsg)
import Session exposing (Session)


type alias Model =
    { session : Session
    , page : Page.Model PageMsg
    }


wrapPage ( session, pageModel, cmd ) =
    ( Model session pageModel, Cmd.map Msg.Page cmd )