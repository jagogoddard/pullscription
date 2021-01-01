module Page.Portal exposing (Model, Msg, init, update, view)

import Browser exposing (Document)
import Element
    exposing
        ( spacing
        , text
        , row
        , el
        , html
        , column
        , paddingXY
        , centerX
        )
import Element.Input as Input
import Element.Font as Font
import Element.Background as Background
import Element.Border as Border
import Element.Background as Background
import Route
import Session exposing (Session)
import ViewHelpers exposing (..)
import Html exposing (div)
import Page.Browse as Browse 


type alias Model =
    ()


type Msg
    = BrowsePressed
    | LoginPressed
    | AboutPressed
    | LogoutPressed
    | HomePressed
    | PortalPressed


init : Session -> ( Session, Model, Cmd Msg )
init session =
    ( session, (), Cmd.none ) -- replace Cmd.none with getPullList 


view : Session -> Model -> Document Msg
view session model =
    { title = "Portal"
    , body =
        [ secondaryPage <|
            (column
                [ spacing 80, centerX]
                [ row
                    [ spacing 50 ]
                    [ button [] { onPress = Just HomePressed, label = text "Home"}
                    , button [] { onPress = Just BrowsePressed, label = text "Search" }
                    , currentButton [] { onPress = Nothing, label = text "Pull List"}
                    , aboutButton AboutPressed
                    , logoutButton LogoutPressed session
                    ]
                --, text <| "Session user's Pulls are: " ++ (Session.getPullList session |> Maybe.withDefault "NO PULLLIST AVAILABLE")
                ]
            )
        ]
    }


update : Msg -> Session -> Model -> ( Session, Model, Cmd Msg )
update msg session model =
    case msg of
        BrowsePressed ->
            ( session |> Session.navPush Route.Root, model, Cmd.none )

        LoginPressed ->
            ( session |> Session.navPush (Route.Login Nothing), model, Cmd.none )

        LogoutPressed ->
            ( session |> Session.navPush Route.Logout, model, Cmd.none )

        AboutPressed ->
            ( session |> Session.navPush Route.About, model, Cmd.none )

        HomePressed ->
            ( session |> Session.navPush Route.Root, model, Cmd.none )

        PortalPressed ->
            ( session |> Session.navPush Route.Portal, model, Cmd.none )

--getPullList : String -> Cmd Msg
--getPullList user = 
    --Http.get { url = ("https://cors-anywhere.herokuapp.com/http://173.255.241.100:8080/api/comics/pulls/" ++ user), expect = Http.expectJson } -- need to figure out way to decode pullList

windowComic attributes =
    el
        ([ Background.color white
         , Font.color black
         , Border.rounded windowRounded
         , paddingXY 220 180
         ]
            ++ attributes
        )