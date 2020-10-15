module Database.User (updatePassword, findUserByName) where

import User
import Named
import Proofs.Admin

findUserByName :: Monad m => String -> m (Maybe User)
findUserByName s = pure . Just $ User s "password"

updatePassword :: Monad m => Named user User -> IsAdmin user -> String -> m ()
updatePassword user _ password = pure ()
