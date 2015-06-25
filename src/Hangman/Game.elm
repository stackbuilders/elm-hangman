module Hangman.Game where


import Hangman.Status


import Char
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Set exposing (Set)
import String


--

type alias Model =
  { guesses : Set Char
  , letters : List Letter
  , status : Hangman.Status.Model
  , word : String
  }


type alias Letter =
  { guessed : Bool
  , letter : Char
  }


init : Maybe Int -> String -> Model
init n word =
  let
    letters =
      String.foldr (::) [] word
        |> List.map (\letter -> {guessed = False, letter = letter})
  in
    { guesses = Set.empty
    , letters = letters
    , status = Hangman.Status.init Nothing
    , word = word
    }


--

type Action
  = Guess Char


update : Action -> Model -> Model
update (Guess guess) model =
  let
    match guess {guessed, letter} =
      {letter = letter, guessed = guess == letter || guessed}

    letters = List.map (match guess) model.letters

    status =
      if model.letters == letters
         then
           case model.status of
             Hangman.Status.Playing 1 ->
               Hangman.Status.Lost

             Hangman.Status.Playing n ->
               Hangman.Status.Playing (n - 1)

             _ -> model.status
         else
           if List.all .guessed letters
              then Hangman.Status.Won
              else model.status
  in
    { model | guesses <- Set.insert guess model.guesses
            , letters <- letters
            , status <- status
    }


--

view : Signal.Address Action -> Model -> Html
view address model =
  Html.div
    []
    [ toHtml model
    , Html.input
        [ Html.Attributes.autofocus True
        , Html.Attributes.disabled
            (not (Hangman.Status.isPlaying model.status))
        , Html.Attributes.placeholder "guess"
        , Html.Attributes.style [ ("text-align", "center") ]
        , Html.Attributes.value
            (Set.foldr String.cons "" model.guesses)
        , Html.Events.onKeyPress address (Guess << Char.fromCode)
        ]
        []
    ]


toHtml : Model -> Html
toHtml model =
  Html.div
    []
    [ Hangman.Status.toHtml model.status
    , Html.h3 [] [ Html.text (toString model) ]
    ]


toString : Model -> String
toString model =
  let
    fromLetter {guessed, letter} =
      if guessed then letter else '-'
  in
    List.map fromLetter model.letters
      |> List.foldr String.cons ""
