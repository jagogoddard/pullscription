module Page.Primary exposing (Model, Msg, init, update, view)

import Browser exposing (Document)
import Element exposing (..)
import Element.Input as Input
import Element.Font as Font
import Element.Background as Background
import Route
import Html exposing (div, Html)
-- import Html.Attributes exposing (..)
-- import Html.Events exposing (..)
import Session exposing (Session)
import ViewHelpers exposing (..)
import Page.Landing exposing (Model)
import Dialog exposing (..)




type alias Model =
    { content : String 
    , ispop : Bool 
    }


type Msg
    = LogoutPressed
    | AboutPressed
    | SecondaryPressed
    | PrimaryPressed
    | HomePressed
    | LoginPressed
    | SearchInput String 
    | Search
    | OpenPop 
    | ClosePop 

initModel : Model
initModel = 
    { content = "" 
    , ispop = False
    }

init : Session -> ( Session, Model, Cmd Msg )
init session =
    ( session, initModel , Cmd.none )


view : Session -> Model -> Document Msg
view session model =
    { title = "Browse Comics"
    , body =
        [ headerPage <|
            column
                [ spacing 10 ]
                [ -- text <| "Welcome " ++ (Session.getAuthToken session |> Maybe.withDefault "NO USERNAME") -- Find out how to center
                row
                    [ spacing 50 ]
                    [ button [] { onPress = Just HomePressed, label = Element.text "Home"}
                    , currentButton [] { onPress = Nothing, label = Element.text "Browse Comics"  }
                    , button [] { onPress = Just SecondaryPressed, label = Element.text "Portal" }
                    , button [] { onPress = Just LoginPressed, label = Element.text "Log in" }
                    , button [] { onPress = Nothing, label = Element.text "Sign up" }
                    , aboutButton AboutPressed
                    , logoutButton LogoutPressed session
                    
                    ]
                , text ""
                , text ""
                , text ""
                , text ""
                , text ""
                , text ""
                , text ""
                , Input.text
                    [ Font.color black ]
                    { onChange = SearchInput
                    , text = model.content
                    , placeholder = Just <| Input.placeholder [] (text "Search Comics")
                    , label = Input.labelAbove [ centerX ] (text "Find your Comic")
                    }
                , button [ centerX ] { onPress = Just Search, label = Element.text "Search" }
                , text ""
                , text ""
                , text ""
                , text ""
                , text ""
                , text ""
                , text ""
                , viewPop model
                , text ""
                , text ""
                , text ""
                , text ""
                , text ""
                , text ""
                , text ""
                , column 
                    [ centerX ] 
                    [ button [] { onPress = Just OpenPop , label = Element.text "PopTest" }
                    ]
                ]
                
        ]
    }

viewPop : Model -> Element Msg
viewPop model =
    let
        dialogConfig =
            if model.ispop == True then
                Just config

            else
                Nothing
    in
    column [ centerX, inFront (Dialog.view dialogConfig)] [text "This is where Search Results for Comics should show"] -- Add Searched Comics here

config =
    { closeMessage = Just ClosePop
    , maskAttributes = []
    , containerAttributes = [ padding 10, Background.color white, centerX ]
    , headerAttributes = [ Font.color black ]
    , bodyAttributes = [ Font.color black ]
    , footerAttributes = []
    , header = Just (text "Comic")
    , body = Just (text "Comic Description")
    , footer = Just (button [] { onPress = Nothing, label = Element.text "Pull"}) -- When ready add Pull Msg to on Press and then tell it what to do in update function
    }
    

        

update : Msg -> Session -> Model -> ( Session, Model, Cmd Msg )
update msg session model =
    case msg of
        LogoutPressed ->
            ( session |> Session.navPush Route.Logout, model, Cmd.none )

        AboutPressed ->
            ( session |> Session.navPush Route.About, model, Cmd.none )

        SecondaryPressed ->
            ( session |> Session.navPush Route.Secondary, model, Cmd.none )

        PrimaryPressed ->
            ( session |> Session.navPush Route.Root, model, Cmd.none )

        HomePressed ->
            ( session |> Session.navPush Route.Root, model, Cmd.none )

        LoginPressed ->
            ( session |> Session.navPush (Route.Login Nothing), model, Cmd.none )

        SearchInput content ->
            ( session, { initModel | content = content } , Cmd.none )

        Search ->
            ( session, model, Cmd.none )

        OpenPop ->
            ( session, { initModel | ispop = True } , Cmd.none )

        ClosePop ->
            ( session, { initModel | ispop = False } , Cmd.none )