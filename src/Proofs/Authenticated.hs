module Proofs.Authenticated (IsAuthenticated, authenticate) where

import Named
import User

data IsAuthenticated a = TrustMe

authenticate :: Monad m => Named a User -> String -> m (Maybe (IsAuthenticated a))
authenticate user password = pure $ if password == userPassword (unNamed user) then Just TrustMe else Nothing
