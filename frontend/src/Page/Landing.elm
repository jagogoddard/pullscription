module Page.Landing exposing (Model, Msg, init, update, view)

import Browser exposing (Document)
import Route
import Session exposing (Session)
import ViewHelpers exposing (..)
import Html.Attributes exposing (rows)
import Html exposing (div, Html, map)
import Element.Region as Region
import Json.Decode as Jd exposing (Decoder, field, string, map7, list)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Http
import Dialog exposing (..)


type Model 
    = Failure (Result Http.Error (List Comic))
    | Loading
    | Success (List Comic)
    | None



type Msg
    = LoginPressed
    | PrimaryPressed
    | SecondaryPressed
    | AboutPressed
    | HomePressed
    | Next
    | Prev
    | Reload
    | GotComics (Result Http.Error (List Comic))


--INIT


init : Session -> ( Session, Model, Cmd Msg )
init session =
    ( session, Loading , getComicData )


-- VIEWMAIN   

view : Session -> Model -> Document Msg
view session model =
    { title = "Landing"
    , body =
        [ headerPage <|
            column
                [ spacing 10, centerX, alignTop ]
                [ row
                    [ spacing 50, alignTop]
                    [ currentButton [] { onPress = Nothing, label = text "Home"}
                    , button [] { onPress = Just PrimaryPressed, label = text "Search" }
                    , button [] { onPress = Just LoginPressed, label = text "Log in" }
                    , aboutButton AboutPressed
                    ]
                , text ""
                , text ""
                , text ""
                , text ""
                , text ""
                , text ""
                , text ""
                , text ""
                , text ""
                , column 
                    [ centerX , alignBottom ]
                    [ el [ centerX ] ( viewList model ) 
                    ]
                ]
        ]
    }



-- UPDATE

update : Msg -> Session -> Model -> ( Session, Model, Cmd Msg )
update msg session model =
    case msg of
        LoginPressed ->
            ( session |> Session.navPush (Route.Login Nothing), model, Cmd.none )
        
        PrimaryPressed ->
            ( session |> Session.navPush Route.Primary, model, Cmd.none )

        SecondaryPressed ->
            ( session |> Session.navPush Route.Secondary, model, Cmd.none )

        AboutPressed ->
            ( session |> Session.navPush Route.About, model, Cmd.none )

        HomePressed ->
            ( session |> Session.navPush Route.Root, model, Cmd.none )
        
        Next ->
            ( session, model, Cmd.none )

        Prev ->
            ( session, model, Cmd.none ) --Go to prev comic

        Reload ->
            ( session, Loading, getComicData )

        GotComics result ->
            case result of
                Ok comicList ->
                    (session, Success comicList, Cmd.none)
                Err _ ->
                    (session, Failure result, Cmd.none)


--VIEWCOMICS

viewList : Model -> Element Msg
viewList model =
    windowComic []
      (column []
        [ text "Next Week's New Issues" 
        , viewComic model
        ]
      )

viewComic : Model -> Element Msg
viewComic model =
  case model of
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
  el [] (row [] [image [width (px 150)] {src=("http://www.pullscription.com/pictures/LowRes/" ++ (individualComic comicsList).stockNo ++ ".jpg"), description="Comic Cover"}])

individualComic : (List Comic) -> Comic
individualComic comicsList =
   Maybe.withDefault dummyComic (List.head comicsList)

dummyComic : Comic
dummyComic =
   { title= "Dummy Value", price= "Dummy Value", creators= "Dummy Value", publisher= "Dummy Value",  releaseDate= "Dummy Value", description= "Dummy Value", diamondNo= "Dummy Value", stockNo= "Dummy Value"}
--SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- COMICINFO
getComicData : Cmd Msg
getComicData = 
    Http.get { url = "https://cors-anywhere.herokuapp.com/http://173.255.241.100:8080/api/comics/browse", expect = Http.expectJson GotComics comicListDecoder}

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

-- HELPERS

gray =
    rgb255 128 128 128


white =
    rgb255 255 255 255

buttonRounded =
    10

button attributes =
    Input.button
        ([ Border.rounded buttonRounded
         , padding 20
         , Background.color gray
         , Border.color white
         , Border.width 5
         ]
            ++ attributes
        )

windowComic attributes =
    el
        ([ Background.color gray
         , Font.color white
         , Border.rounded windowRounded
         , paddingXY 220 180
         ]
            ++ attributes
        )
windowRounded =
    10

