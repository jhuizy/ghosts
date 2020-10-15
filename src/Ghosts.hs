{-# LANGUAGE OverloadedStrings #-}

module Ghosts where

import User
import Database.User
import Web.Scotty
import Proofs.Authenticated
import Named
import Proofs.Admin (admin)

updatePassword' :: MonadFail m => String -> String -> String -> m ()
updatePassword' username password newPassword = do
  Just user <- findUserByName username
  withName user $ \namedUser -> do
    Just authed <- authenticate namedUser password
    Just admind <- admin namedUser authed
    updatePassword namedUser admind newPassword 

main :: IO ()
main = scotty 3000 $ do
  get ":/user/update-password" $ do
    username <- param "username"
    password <- param "password"
    newPassword <- param "new-password"

    updatePassword' username password newPassword
    text "success"
