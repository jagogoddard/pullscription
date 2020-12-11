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
        )
import Route
import Session exposing (Session)
import ViewHelpers exposing (..)
-- import Html.Attributes exposing (rows)


type alias Model =
    ()


type alias Msg =
    ()


init : Session -> ( Session, Model, Cmd Msg )
init session =
    ( session, (), Cmd.none )

view session model =
    { title = "About"
    , body =
        [ aboutPage <|
            column 
                [ centerX,  centerY ]
                [ el [ centerX ] (text "Contributors:")
                , text " " 
                , text "Jago Lourenco-Goddard" 
                , text " " 
                , text "Omid Hosseini Dehkordi" 
                , text " " 
                , text "Satsuki Liu" 
                , text " " 
                , text "Jonathan Martinez" 
                , text " " 
                , text "Wesley Lin" 
                ]
        ]
    }


update msg session model =
    ( session, model, Cmd.none )