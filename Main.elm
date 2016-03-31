import StartApp
import Task exposing(Task)
import Effects exposing (Never)

import Choker exposing(init, view, update)

app =
  StartApp.start { init = init, view = view, update = update, inputs = [] }

main =
  app.html

port tasks : Signal (Task Never ())
port tasks =
  app.tasks
