{-# LANGUAGE TemplateHaskell #-}

module Main where

import Hedgehog
import Hedgehog.Main
import Ghosts

prop_test :: Property
prop_test = property $ do
  doGhosts === "Ghosts"

main :: IO ()
main = defaultMain [checkParallel $$(discover)]
