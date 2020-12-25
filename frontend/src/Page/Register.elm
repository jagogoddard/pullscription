module Page.Register exposing (..)

import Browser exposing (Document)
import Browser.Navigation as Navigation
import Element
    exposing
        ( Element
        , alignRight
        , centerX
        , centerY
        , column
        , el
        , fill
        , padding
        , rgb255
        , row
        , spacing
        , text
        , width
        , wrappedRow
        )
import Element.Font as Font
import Element.Input as Input
import Route
import Session exposing (Session)
import Url exposing (Url)
import ViewHelpers exposing (..)

type alias Model =
    { username : String
    , rawPassword : String
    --, fullname : String
    --, favcomic : String
    --, email : String
    }


type Msg
    = UsernameChanged String
    | PasswordChanged String
    --| NameChanged String
    --| ComicChanged String
    --| EmailChanged String
    | CancelPressed
    | RegisterPressed

initModel : Model
initModel =
    { username = ""
    , rawPassword = ""
    --, fullname = ""
    --, favcomic = ""
    --, email = ""
    }


init : Session -> ( Session, Model, Cmd Msg )
init session =
    ( session, initModel , Cmd.none )

update : Msg -> Session -> Model -> ( Session, Model, Cmd Msg )
update msg session model =
    case msg of
        UsernameChanged username ->
            ( session, { model | username = username }, Cmd.none )

        PasswordChanged password ->
            ( session, { model | rawPassword = password }, Cmd.none )

        RegisterPressed ->
            ( session
                |> Session.addAuthToken model.username -- don't know exactly how to store User info here
                |> Session.navBack
            , model
            , Cmd.none
            )

        CancelPressed ->
            ( session |> Session.navBack, model, Cmd.none )


view : Session -> Model -> Document Msg
view session model =
    { title = "Login"
    , body =
        [ loginPage <|
            column
                [ spacing 30 ]
                [el [centerX, Font.extraBold] (text "Register here")
                ,Input.username
                    [ Font.color black
                    ]
                    { onChange = UsernameChanged
                    , text = model.username
                    , placeholder = Just <| Input.placeholder [] (text "username")
                    , label = Input.labelBelow [] (text "Username")
                    }
                , Input.currentPassword
                    [ Font.color black
                    ]
                    { onChange = PasswordChanged
                    , text = model.rawPassword
                    , placeholder = Just <| Input.placeholder [] (text "password")
                    , label = Input.labelBelow [] (text "Password")
                    , show = False
                    }
                , row   
                    [ spacing 10 ]
                    [ button [] { onPress = Just RegisterPressed, label = text "Register" }
                    , button [] { onPress = Just CancelPressed, label = text "Cancel" }
                    ]
                ]
        ]

    }