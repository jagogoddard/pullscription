module PageMsg exposing (PageMsg(..))

import Page.About as About
import Page.Landing as Landing
import Page.Login as Login
import Page.Logout as Logout
import Page.NotFound as NotFound
import Page.Browse as Browse
import Page.Portal as Portal


type PageMsg
    = AboutMsg About.Msg
    | LandingMsg Landing.Msg
    | LoginMsg Login.Msg
    | LogoutMsg Logout.Msg
    | NotFoundMsg NotFound.Msg
    | BrowseMsg Browse.Msg
    | PortalMsg Portal.Msg