module Hangman where


import Char
import Html exposing (Html)
import Html.Attributes
import Html.Events
import StartApp
import String


-- Model

type alias Model =
  { letters : List (Char, Bool)
  , status : Status
  }


type Status
  = Lost
  | Playing Int
  | Won


init : String -> Model
init word =
  { letters =
      String.foldr (::) [] word
        |> List.map (\letter -> (letter, False))
  , status = Playing 6
  }


-- Update

type alias Action =
  Char


update : Action -> Model -> Model
update guess game =
  let
    match guess (letter, guessed) =
      (letter, guess == letter || guessed)

    letters =
      List.map (match guess) game.letters

    status =
      case (game.status, game.letters == letters) of
        (Playing 1, True) ->
          Lost

        (Playing n, True) ->
          Playing (n - 1)

        (Playing _, False) ->
          if List.all snd letters
             then Won
             else game.status

        (otherStatus, _) ->
          otherStatus
  in
    { game | letters <- letters, status <- status }


-- view

view : Signal.Address Action -> Model -> Html
view address game =
  Html.div
    [ Html.Attributes.style [ ("text-align", "center") ]

    ]
    [ Html.h1 [] [ Html.text "Hangman" ]
    , toHtml game
    , Html.input
        [ Html.Attributes.autofocus True
        , Html.Attributes.placeholder "guess"
        , Html.Attributes.style [ ("text-align", "center") ]
        , Html.Events.onKeyPress address Char.fromCode
        ]
        []
    ]


toHtml : Model -> Html
toHtml game =
  let
    fromLetter (letter, guessed) =
      if guessed then letter else '-'

    letters =
      List.map fromLetter game.letters
        |> List.foldr String.cons ""
  in
    Html.div
      []
      [ Html.h3 [] [ Html.text (Basics.toString game.status) ]
      , Html.h3 [] [ Html.text letters ]
      ]


--

main : Signal Html
main =
  StartApp.start
    { model = init "guayaquil"
    , view = view
    , update = update
    }
