module Page.Secondary exposing (Model, Msg, init, update, view)

import Browser exposing (Document)
import Element
    exposing
        ( spacing
        , text
        , row
        )
import Route
import Session exposing (Session)
import ViewHelpers exposing (..)


type alias Model =
    ()


type Msg
    = PrimaryPressed
    | LoginPressed
    | AboutPressed
    | LogoutPressed
    | HomePressed
    | SecondaryPressed


init : Session -> ( Session, Model, Cmd Msg )
init session =
    ( session, (), Cmd.none )


view : Session -> Model -> Document Msg
view session model =
    { title = "Portal"
    , body =
        [ secondaryPage <|
            row
                [ spacing 50 ]
                [ button [] { onPress = Just HomePressed, label = text "Home"}
                --, text <| (Session.getAuthToken session |> Maybe.withDefault "NO USERNAME")
                , button [] { onPress = Just PrimaryPressed, label = text "Browse Comics" }
                , currentButton [] { onPress = Nothing, label = text "Portal"}
                , aboutButton AboutPressed
                , logoutButton LogoutPressed session
                --, button [] { onPress = Just LoginPressed, label = text "Log in - inappropriately" }
                ]
        ]
    }


update : Msg -> Session -> Model -> ( Session, Model, Cmd Msg )
update msg session model =
    case msg of
        PrimaryPressed ->
            ( session |> Session.navPush Route.Root, model, Cmd.none )

        LoginPressed ->
            ( session |> Session.navPush (Route.Login Nothing), model, Cmd.none )

        LogoutPressed ->
            ( session |> Session.navPush Route.Logout, model, Cmd.none )

        AboutPressed ->
            ( session |> Session.navPush Route.About, model, Cmd.none )

        HomePressed ->
            ( session |> Session.navPush Route.Root, model, Cmd.none )

        SecondaryPressed ->
            ( session |> Session.navPush Route.Secondary, model, Cmd.none )