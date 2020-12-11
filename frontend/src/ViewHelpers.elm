module ViewHelpers exposing (currentButton, secondaryPage,loginPage, aboutButton, appName, black, button, buttonRounded, headerPage, gray, logoutButton, pageTitle, white, window, windowRounded, aboutPage, windowAbout)

import Element
    exposing
        ( Element
        , alignRight
        , alignLeft
        , centerX
        , centerY
        , alignTop
        , alignBottom
        , column
        , el
        , fill
        , padding
        , rgb255
        , row
        , spacing
        , text
        , width
        , paragraph
        )
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Route
import Session
import Element exposing (paddingXY)


appName =
    "PULLSCRIPTION"


pageTitle pageName =
    appName ++ ": " ++ pageName

headerPage rest =
    Element.layout [] <|
        window[ centerX, alignTop ]
            (column
                [ spacing 50, centerX, alignTop]
                [ row 
                    [ spacing 550, alignTop ]
                    [ el [ alignLeft, alignTop ] (text appName)
                    , el [ alignRight, alignTop ] (text "Get your Comics in a Flash!")
                    ]
                , el [centerX, alignTop] rest
                ]
            )

loginPage rest =
    Element.layout [] <|
        window[ centerX, centerY ]
            (column
                [ spacing 50, centerX, centerY]
                [ row 
                    [ spacing 340, alignTop ]
                    [ el [ alignLeft, alignTop ] (text appName)
                    , el [ alignRight, alignTop ] (text "Get your Comics in a Flash!")
                    ]
                , el [centerX, centerY] rest
                ]
            )
secondaryPage rest =
    Element.layout [] <|
        window[ centerX, alignTop ]
            (column
                [ spacing 50, centerX, alignTop]
                [ row 
                    [ spacing 420, alignTop ]
                    [ el [ alignLeft, alignTop ] (text appName)
                    , el [ alignRight, alignTop ] (text "Get your Comics in a Flash!")
                    ]
                , el [centerX, alignTop] rest
                ]
            )

aboutPage rest =
    Element.layout [] <|
        windowAbout [ centerX, alignTop ]
            (column
                [ spacing 50]
                [ el [ centerX ] (text "About Us")
                , paragraph [] [ text "Pullscription is a service that connects comicbook stores to their customers, and aggregates data for both of them to makes business easier, faster and better for both customer and store operator. Use pullscription.com to get your Comics in a Flash!" ]
                , rest
                ]
            )
    


aboutButton msg =
    button [] { onPress = Just msg, label = text "About" }


logoutButton msg session =
    if Session.getAuthToken session == Nothing then
        Element.none

    else
        button [] { onPress = Just msg, label = text "Log out" }


window attributes =
    el 
        ([ Background.color black
         , Font.color white
         , Border.rounded windowRounded
         , paddingXY 240 190
         , centerX
         , alignTop
         ]
            ++ attributes
        )

windowAbout attributes =
    el
        ([ Background.color gray
         , Font.color white
         , Border.rounded windowRounded
         , padding 350
         ]
            ++ attributes
        )


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
    
currentButton attributes =
    Input.button
        ([ Border.rounded buttonRounded
         , padding 20
         , Background.color gray
         , Border.color black
         , Border.width 5
         ]
            ++ attributes
        )


windowRounded =
    10


buttonRounded =
    10


black =
    rgb255 0 0 0


gray =
    rgb255 128 128 128


white =
    rgb255 255 255 255