{-
    This file is automatically generated by elm-graphql. Do not modify!
-}
module GraphQL.Ahead (queryLinks, QueryLinksResult) where

import Task exposing (Task)
import Json.Decode exposing (..)
import Json.Encode exposing (encode, object)
import Http
import GraphQL exposing (apply)

url : String
url =
    "http://localhost:4000/graphql"


type alias QueryLinksResult =
    { store :
        { linkConnection :
            { edges :
                List { node :
                    { id : Maybe String
                    , title : Maybe String
                    , url : Maybe String
                    }
                }
            }
        }
    }


queryLinks : String -> Task Http.Error QueryLinksResult
queryLinks queryParam =
    let query = """query queryLinks($queryParam: String!) { store { linkConnection(query: $queryParam) { edges { node { id title url } } } } }""" in
    let params =
            object
                [ ("queryParam", Json.Encode.string queryParam)
                ]
    in
    GraphQL.query url query "queryLinks" (encode 0 params) queryLinksResult


queryLinksResult : Decoder QueryLinksResult
queryLinksResult =
    map QueryLinksResult ("store" :=
        (map (\linkConnection -> { linkConnection = linkConnection }) ("linkConnection" :=
        (map (\edges -> { edges = edges }) ("edges" :=
        (list (map (\node -> { node = node }) ("node" :=
        (map (\id title url -> { id = id, title = title, url = url }) (maybe ("id" := string))
        `apply` (maybe ("title" := string))
        `apply` (maybe ("url" := string)))))))))))
