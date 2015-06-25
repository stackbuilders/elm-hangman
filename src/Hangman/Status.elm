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
      " O \n" ++
      "/|\\\n" ++
      "/ \\"

    Playing 1 ->
      " O \n" ++
      "/|\\\n" ++
      "/  "

    Playing 2 ->
      " O \n" ++
      "/|\\\n" ++
      ""

    Playing 3 ->
      " O \n" ++
      "/| \n" ++
      ""

    Playing 4 ->
      " O \n" ++
      " | \n" ++
      ""

    Playing 5 ->
      " O \n" ++
      "\n" ++
      ""

    Playing _ ->
      "\n" ++
      "\n" ++
      ""

    Won ->
      "\\O/\n" ++
      " | \n" ++
      "/ \\"
