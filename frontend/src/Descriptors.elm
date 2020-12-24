module Descriptors exposing
    ( aboutDescriptor
    , landingDescriptor
    , loginDescriptor
    , logoutDescriptor
    , notFoundDescriptor
    , browseDescriptor
    , portalDescriptor
    , registerDescriptor
    )

import Browser exposing (Document)
import Page exposing (Descriptor)
import Page.About as About
import Page.Landing as Landing
import Page.Login2 as Login
import Page.Logout as Logout
import Page.NotFound as NotFound
import Page.Browse as Browse
import Page.Portal as Portal
import Page.Register as Register
import PageMsg exposing (PageMsg(..))
import Session exposing (Session)


loginDescriptor : Descriptor PageMsg Login.Msg Login.Model
loginDescriptor =
    { view = Login.view
    , update = Login.update
    , subscriptions = Nothing
    , wrapSessionEvent = Nothing
    , msgWrapper = LoginMsg
    , msgFilter =
        \main ->
            case main of
                LoginMsg msg ->
                    Just msg

                _ ->
                    Nothing
    }


logoutDescriptor : Descriptor PageMsg Logout.Msg Logout.Model
logoutDescriptor =
    { view = Logout.view
    , update = Logout.update
    , subscriptions = Nothing
    , msgWrapper = LogoutMsg
    , msgFilter =
        \main ->
            case main of
                LogoutMsg msg ->
                    Just msg

                _ ->
                    Nothing
    , wrapSessionEvent = Nothing
    }


browseDescriptor : Descriptor PageMsg Browse.Msg Browse.Model
browseDescriptor =
    { view = Browse.view
    , update = Browse.update
    , subscriptions = Nothing
    , msgWrapper = BrowseMsg
    , msgFilter =
        \main ->
            case main of
                BrowseMsg msg ->
                    Just msg

                _ ->
                    Nothing
    , wrapSessionEvent = Nothing
    }


portalDescriptor : Descriptor PageMsg Portal.Msg Portal.Model
portalDescriptor =
    { view = Portal.view
    , update = Portal.update
    , subscriptions = Nothing
    , msgWrapper = PortalMsg
    , msgFilter =
        \main ->
            case main of
                PortalMsg msg ->
                    Just msg

                _ ->
                    Nothing
    , wrapSessionEvent = Nothing
    }


notFoundDescriptor : Descriptor PageMsg NotFound.Msg NotFound.Model
notFoundDescriptor =
    { view = NotFound.view
    , update = NotFound.update
    , subscriptions = Nothing
    , msgWrapper = NotFoundMsg
    , msgFilter =
        \main ->
            case main of
                NotFoundMsg msg ->
                    Just msg

                _ ->
                    Nothing
    , wrapSessionEvent = Nothing
    }


aboutDescriptor : Descriptor PageMsg About.Msg About.Model
aboutDescriptor =
    { view = About.view
    , update = About.update
    , subscriptions = Nothing
    , msgWrapper = AboutMsg
    , msgFilter =
        \main ->
            case main of
                AboutMsg msg ->
                    Just msg

                _ ->
                    Nothing
    , wrapSessionEvent = Nothing
    }


landingDescriptor : Descriptor PageMsg Landing.Msg Landing.Model
landingDescriptor =
    { view = Landing.view
    , update = Landing.update
    , subscriptions = Nothing
    , msgWrapper = LandingMsg
    , msgFilter =
        \main ->
            case main of
                LandingMsg msg ->
                    Just msg

                _ ->
                    Nothing
    , wrapSessionEvent = Nothing
    }

registerDescriptor : Descriptor PageMsg Register.Msg Register.Model
registerDescriptor =
    { view = Register.view
    , update = Register.update
    , subscriptions = Nothing
    , msgWrapper = RegisterMsg
    , msgFilter =
        \main ->
            case main of
                RegisterMsg msg ->
                    Just msg

                _ ->
                    Nothing
    , wrapSessionEvent = Nothing
    }