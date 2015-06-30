module Hangman where


import Char
import Html exposing (Html)
import Html.Attributes
import Html.Events
import StartApp
import String


-- Model

type alias Model =
  List (Char, Bool)


init : String -> Model
init word =
  String.foldr (::) [] word
    |> List.map (\letter -> (letter, False))


-- Update

type alias Action =
  Char


update : Action -> Model -> Model
update guess letters =
  let
    match guess (letter, guessed) =
      (letter, guess == letter || guessed)
  in
    List.map (match guess) letters


-- View

view : Signal.Address Action -> Model -> Html
view address model =
  Html.div
    [ Html.Attributes.style [ ("text-align", "center") ]

    ]
    [ Html.h1 [] [ Html.text "Hangman" ]
    , Html.h3 [] [ Html.text (toString model) ]
    , Html.input
        [ Html.Attributes.autofocus True
        , Html.Attributes.placeholder "guess"
        , Html.Attributes.style [ ("text-align", "center") ]
        , Html.Events.onKeyPress address Char.fromCode
        ]
        []
    ]


toString : Model -> String
toString letters =
  let
    fromLetter (letter, guessed) =
      if guessed then letter else '-'
  in
    List.map fromLetter letters
      |> List.foldr String.cons ""


--

main : Signal Html
main =
  StartApp.start
    { model = init "guayaquil"
    , view = view
    , update = update
    }
