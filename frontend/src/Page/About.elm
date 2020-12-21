module Page.About exposing (Model, Msg, init, update, view)

import Element
    exposing
        ( spacing
        , padding
        , text
        , row
        , paragraph
        , column
        , centerX
        , centerY
        , el
        , alignTop
        )
import Route
import Session exposing (Session)
import ViewHelpers exposing (..)
import Element.Font as Font


type alias Model =
    ()



type Msg = LogoutPressed
    | BrowsePressed
    | PortalPressed
    | HomePressed
    | LoginPressed


init : Session -> ( Session, Model, Cmd Msg )
init session =
    ( session, (), Cmd.none )

view session model =
    { title = "About"
    , body =
        [ headerPage <|
            column
                [ spacing 10 ]
                [row
                    [ spacing 50, centerX, alignTop ]
                    [ button [] { onPress = Just HomePressed, label = Element.text "Back to Home"}
                    --, button [] { onPress = Just BrowsePressed, label = Element.text "Search"  }
                    --, button [] { onPress = Just PortalPressed, label = Element.text "Portal" }
                    --, button [] { onPress = Just LoginPressed, label = Element.text "Log in" }
                    , currentButton [] { onPress = Nothing, label = Element.text "About"  }
                    ]
                , text ""
                , text ""
                , text ""
                , text ""
                , text ""
                , text ""
                , el [ centerX, Font.extraBold, Font.size 40, Font.underline ] (text "About Us")
                , text ""
                , paragraph [] [ text "Pullscription is a service that connects comicbook stores to their customers, and aggregates data for both of them to makes business easier, faster and better for both customer and store operator. Use pullscription.com to get your Comics in a Flash!" ]
                , text ""
                , text ""
                , text ""
                , el [ centerX, Font.extraBold, Font.size 30, Font.underline ] (text "Contributors:")
                , column 
                    [ centerX ]
                    [text " " 
                    , text "Jago Lourenco-Goddard" 
                    , text " " 
                    , text "Omid Hosseini Dehkordi" 
                    , text " " 
                    , text "Satsuki Liu" 
                    , text " " 
                    , text "Jonathan Martinez" 
                    , text " " 
                    , text "Wesley Lin" ]
                ]
        ]
    }


update : Msg -> Session -> Model -> ( Session, Model, Cmd Msg )
update msg session model =
    case msg of
        LogoutPressed ->
            ( session |> Session.navPush Route.Logout, model, Cmd.none )

        PortalPressed ->
            ( session |> Session.navPush Route.Portal, model, Cmd.none )

        BrowsePressed ->
            ( session |> Session.navPush Route.Browse, model, Cmd.none )

        HomePressed ->
            ( session |> Session.navPush Route.Root, model, Cmd.none )

        LoginPressed ->
            ( session |> Session.navPush (Route.Login Nothing), model, Cmd.none )
