module Choker where

import Html exposing (h1, div, text, a, p, br)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Http exposing (Error)
import Json.Decode as Json
import Effects exposing (Effects)
import Task
import Regex exposing (replace, regex)

type alias Model = String
type Action = RequestJoke | DisplayJoke (Maybe String)

init : (Model, Effects Action)
init =
  ( "Loading...", getRandomJoke )

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    RequestJoke -> ( model, getRandomJoke )
    DisplayJoke joke -> (Maybe.withDefault model joke, Effects.none )

view : Signal.Address Action -> Model -> Html.Html
view address model =
  div []
    [ h1 [ class "splash-head"] [ text (replaceQuotes model) ]
    , p []
      [ a [ class "pure-button pure-button-primary", onClick address RequestJoke ] [ text "MORE!" ]
      ]
    ]

-- Private shit ----------------------------------------------
getRandomJoke : Effects Action
getRandomJoke =
  Http.get decodeJokeText jokeUrl
    |> Task.toMaybe
    |> Task.map DisplayJoke
    |> Effects.task

jokeUrl =
  "http://api.icndb.com/jokes/random/"

decodeJokeText =
  Json.at [ "value", "joke" ] Json.string

replaceQuotes : String -> String
replaceQuotes text =
  replace Regex.All (regex "&quot;") (\_ -> "\"") text
