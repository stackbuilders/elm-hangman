module Hangman.Status where


import Html exposing (Html)


--

type Model
  = Lost
  | Playing Int
  | Won


init : Maybe Int -> Model
init n =
  Playing (Maybe.withDefault 6 n)


isPlaying : Model -> Bool
isPlaying status =
  case status of
    Playing _ -> True
    _ -> False


toHtml : Model -> Html
toHtml status =
  Html.pre [] [ Html.text (toString status) ]


toString : Model -> String
toString status =
  case status of
    Lost ->
      " ____ \n" ++
      " |  | \n" ++
      " |  O \n" ++
      " | /|\\\n" ++
      " | / \\\n" ++
      " |    \n" ++
      "---   "

    Playing 1 ->
      " ____ \n" ++
      " |  | \n" ++
      " |  O \n" ++
      " | /|\\\n" ++
      " | /  \n" ++
      " |    \n" ++
      "---   "

    Playing 2 ->
      " ____ \n" ++
      " |  | \n" ++
      " |  O \n" ++
      " | /|\\\n" ++
      " |    \n" ++
      " |    \n" ++
      "---   "

    Playing 3 ->
      " ____ \n" ++
      " |  | \n" ++
      " |  O \n" ++
      " | /| \n" ++
      " |    \n" ++
      " |    \n" ++
      "---   "

    Playing 4 ->
      " ____ \n" ++
      " |  | \n" ++
      " |  O \n" ++
      " |  | \n" ++
      " |    \n" ++
      " |    \n" ++
      "---   "

    Playing 5 ->
      " ____ \n" ++
      " |  | \n" ++
      " |  O \n" ++
      " |    \n" ++
      " |    \n" ++
      " |    \n" ++
      "---   "

    Playing _ ->
      " ____ \n" ++
      " |  | \n" ++
      " |    \n" ++
      " |    \n" ++
      " |    \n" ++
      " |    \n" ++
      "---   "

    Won ->
      "\n" ++
      "\n" ++
      "   \\O/\n" ++
      "    | \n" ++
      "   / \\\n" ++
      "\n" ++
      " "
