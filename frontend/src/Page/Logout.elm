module Page.Logout exposing (Model, Msg, init, update, view)

import Browser exposing (Document)
import Element
    exposing
        ( spacing
        , text
        , column
        )
import Route
import Session exposing (Session)
import ViewHelpers exposing (..)


type alias Model =
    ()


type Msg
    = HomePressed


init : Session -> ( Session, Model, Cmd Msg )
init session =
    ( session |> Session.clearAuthToken, (), Cmd.none )


view : Session -> Model -> Document Msg
view session model =
    { title = "Log out"
    , body =
        [ headerPage <|
            column
                [ spacing 10 ]
                [ text "You have logged out"
                , button [] { onPress = Just HomePressed, label = text "Return home" }
                ]
        ]
    }


update : Msg -> Session -> Model -> ( Session, Model, Cmd Msg )
update msg session model =
    case msg of
        HomePressed ->
            ( session |> Session.navPush Route.Root, model, Cmd.none )