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
import Element.Background as Background
import Element.Border as Border
import Session exposing (Session)
import ViewHelpers exposing (..)
import Page.Landing exposing (Model)
import Dialog exposing (..)
import Json.Decode as Jd exposing (Decoder, field, string, map7, list)
import Http


type alias Model = 
    { content : String 
    , popUp : Bool
    , comicsList : (List Comic)
    , comicLoadStatus : LoadStatus
    }

type LoadStatus = Loading
    | Success (List Comic)
    | Failure (Result Http.Error (List Comic))
    | None

type Msg = LogoutPressed
    | AboutPressed
    | SecondaryPressed
    | PrimaryPressed
    | HomePressed
    | LoginPressed
    | SearchInput String 
    | Search
    | Reload
    | OpenPop 
    | ClosePop 
    | GotComics (Result Http.Error (List Comic))

initModel : Model
initModel = 
    { content = ""
    , popUp = False
    , comicsList = []
    , comicLoadStatus = Loading
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
                    , currentButton [] { onPress = Nothing, label = Element.text "Search"  }
                    , button [] { onPress = Just SecondaryPressed, label = Element.text "Portal" }
                    , button [] { onPress = Just LoginPressed, label = Element.text "Log in" }
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
                , column 
                    [ centerX , alignBottom ]
                    [ el [ centerX ] ( viewList model ) 
                    ]
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
                ]
                
        ]
    }

viewPop : Model -> Element Msg
viewPop model =
    let
        dialogConfig =
            if model.popUp == True then
                Just (config (individualComic model.comicsList))

            else
                Nothing
    in
    column [ centerX, inFront (Dialog.view dialogConfig)] [text "This is where Search Results for Comics should show"] -- Add Searched Comics here

viewList : Model -> Element Msg
viewList model =
    windowComic []
      (column []
        [ text "Next Week's New Issues" 
        , viewComic model
        ]
      )

config comic =
    { closeMessage = Just ClosePop
    , maskAttributes = []
    , containerAttributes = [ padding 15, Background.color white, centerX, centerY ]
    , headerAttributes = [ Font.color black ]
    , bodyAttributes = [ Font.color black ]
    , footerAttributes = []
    , header = Just (text (""++comic.title))
    , body = Just (el [] (row [] [image [width (px 350)] { 
        src=("http://www.pullscription.com/pictures/LowRes/" ++ comic.stockNo ++ ".jpg")
      , description=(comic.title ++ " Cover Image")}, 
      text (("Description: " ++ comic.description ++ " | ") ++ ("Price: " ++ comic.price++ " | ") ++ ("Stock No: " ++ comic.stockNo ++ " | ") ++ ("Diamond No: " ++ comic.diamondNo++ " | "))]))
    , footer = Just (button [] { onPress = Nothing, label = Element.text "Pull"}) -- When ready add Pull Msg to on Press and then tell it what to do in update function
    }
    
dummyComic : Comic
dummyComic =
   { title= "Dummy Value", price= "Dummy Value", creators= "Dummy Value", publisher= "Dummy Value",  releaseDate= "Dummy Value", description= "Dummy Value", diamondNo= "Dummy Value", stockNo= "Dummy Value"}

viewSearch : Model -> Element Msg
viewSearch model =
    windowComic []
      (column []
        [ text "Next Week's New Issues" 
        , viewComic model
        ]
      )
individualComic : (List Comic) -> Comic
individualComic comicsList =
   Maybe.withDefault dummyComic (List.head comicsList)

viewComic : Model -> Element Msg
viewComic model =
  case model.comicLoadStatus of
    Failure err ->
      wrappedRow [ centerX, spacing 60]
        [ text ("I could not load the comics for this reason: " ++ (Debug.toString err) ++ ". ")
        , button [] { onPress = Just Reload, label = text "Try Again! (Doesn't work, too bad.)" }
        ]

    Loading ->
      text "Loading..."

    Success comicsList ->
      column [] [ comicsListInHtml comicsList ]

    None ->
        Element.none

comicsListInHtml : (List Comic) -> Element Msg
comicsListInHtml comicsList = 
  el [] (row [] [
      image [width (px 150)] { 
        src=("http://www.pullscription.com/pictures/LowRes/" ++ (individualComic comicsList).stockNo ++ ".jpg")
      , description=((individualComic comicsList).title ++ " Cover Image")}
      , button [] { 
            onPress = Just OpenPop
          , label = Element.text ((individualComic comicsList).title ++ " Info")
          }
          ]
          )

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
            ( session, {initModel | content = content} , Cmd.none )

        Search ->
            ( session, model, (getComicSearchData model.content) )

        OpenPop ->
            ( session, {initModel | popUp = True, comicsList = model.comicsList, comicLoadStatus = model.comicLoadStatus} , Cmd.none )

        ClosePop ->
            ( session, {initModel | popUp = False}, Cmd.none )

        Reload ->
            ( session, {initModel | comicLoadStatus = Loading}, (getComicSearchData model.content) )

        GotComics result ->
            case result of
                Ok comicList ->
                    (session, {initModel | comicsList = comicList, comicLoadStatus = (Success comicList)}, Cmd.none)
                Err _ ->
                    (session, {initModel | comicLoadStatus = (Failure result)}, Cmd.none)

getComicSearchData : String -> Cmd Msg
getComicSearchData searchterms = 
    Http.get { url = ("https://cors-anywhere.herokuapp.com/http://173.255.241.100:8080/api/comics/search/" ++ searchterms), expect = Http.expectJson GotComics comicListDecoder}

type alias Comic = { title: String, price: String, creators: String, publisher: String,  releaseDate: String, description: String, diamondNo: String, stockNo: String}

comicDecoder : Decoder Comic
comicDecoder = 
    Jd.map8 Comic
        (field "full_title" string)
        (field "price" string)
        (field "writer" string)
        (field "publisher" string)
        (field "ship_date" string)
        (field "main_desc" string)
        (field "diamd_no" string)
        (field "stock_no" string)

comicListDecoder : Decoder (List Comic)
comicListDecoder =
    Jd.list comicDecoder

windowComic attributes =
    el
        ([ Background.color gray
         , Font.color white
         , Border.rounded windowRounded
         , paddingXY 220 180
         ]
            ++ attributes
        )