module Hangman (main) where


import Hangman.Game


import Html exposing (Html)
import Html.Attributes
import Html.Events
import StartApp


--

type alias Model =
  { game : Hangman.Game.Model
  }


init : String -> Model
init word =
  { game = Hangman.Game.init Nothing word
  }


--

type Action
  = Current Hangman.Game.Action
  | New


update : Action -> Model -> Model
update action model =
  case action of
    Current guess ->
      { model | game <- Hangman.Game.update guess model.game }

    New ->
      init defaultWord


--

view : Signal.Address Action -> Model -> Html
view address model =
  Html.div
    [ Html.Attributes.style [("text-align", "center")] ]
    [ Html.h1 [] [ Html.text "Hangman" ]
    , Hangman.Game.view (Signal.forwardTo address Current) model.game
    , Html.button
        [ Html.Events.onClick address New ]
        [ Html.text "New" ]
    ]


--

main : Signal Html
main =
  StartApp.start
    { model = init defaultWord
    , view = view
    , update = update
    }


defaultWord : String
defaultWord = "ecuador"
