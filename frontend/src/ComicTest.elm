module ComicTest exposing (..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Jd exposing (Decoder, field, string, map7, list)

--MAIN

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

--INIT

init: () -> (Model, Cmd Msg)
init _ = 
  (Loading, getComicData)

--MODEL

type Model = Failure (Result Http.Error (List Comic))
 | Loading
 | Success (List Comic)

--UPDATE

type Msg
  = Next
  | Prev
  | Reload
  | GotComics (Result Http.Error (List Comic))


update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Next ->
          (model, Cmd.none) --Go to next
        Prev ->
          (model, Cmd.none) --Go to prev comic
        Reload ->
          (Loading, getComicData)
        GotComics result ->
          case result of
            Ok comicList ->
              (Success comicList, Cmd.none)
            Err _ ->
              (Failure result, Cmd.none)

--VIEW

view : Model -> Html Msg
view model =
  div []
    [ h2 [] [ text "Next Week's New Issues" ]
    , viewComic model
    ]

viewComic : Model -> Html Msg
viewComic model =
  case model of
    Failure err ->
      div []
        [ text ("I could not load the comics for this reason: " ++ (Debug.toString err) ++ ". ")
        , button [ onClick Reload ] [ text "Try Again! (Doesn't work, too bad.)" ]
        ]

    Loading ->
      text "Loading..."

    Success comicsList ->
      div [] [ comicsListInHtml comicsList ]


comicsListInHtml : (List Comic) -> Html Msg
comicsListInHtml comicsList = 
  div [] (List.map (\l -> div [] [text l.title]) comicsList)

--SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

getComicData : Cmd Msg
getComicData = 
    Http.get { url = "http://173.255.241.100:8080/api/search/man", expect = Http.expectJson GotComics comicListDecoder}

type alias Comic = { title: String, price: String, creators: String, publisher: String,  releaseDate: String, description: String, diamondNo: String}

comicDecoder : Decoder Comic
comicDecoder = 
    Jd.map7 Comic
        (field "full_title" string)
        (field "srp" string)
        (field "writer" string)
        (field "publisher" string)
        (field "ship_date" string)
        (field "main_desc" string)
        (field "diamd_no" string)

comicListDecoder : Decoder (List Comic)
comicListDecoder =
    Jd.list comicDecoder