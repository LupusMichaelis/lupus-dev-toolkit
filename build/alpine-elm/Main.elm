module App exposing (main)

import Browser

type alias Model =
    { title : String
    }

type Msg
    = Never

initialModel : Model
initialModel =
    { title = "My exemple"
    }

main : Program () Model Msg
main =
    Browser.document
        { init = always ( initialModel, Cmd.none )
        , update = (updateState, Cmd.none)
        , subscriptions = subscriptions
        , view = view
        }


view : Model -> Browser.Document Controls.Msg
view model =
    { title = model.title
    , body =
        [ Html.Element.h1 [] [ model.title ]
        ]
    }


subscriptions : Sub Controls.Msg
subscriptions =
        Sub.none


updateState : Msg -> Model -> Model
updateState _ model =
    model
