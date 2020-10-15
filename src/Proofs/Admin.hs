module Proofs.Admin
  (IsAdmin, admin) where

import Named
import User
import Proofs.Authenticated
data IsAdmin a = TrustMe

admin :: Monad m => Named a User -> IsAuthenticated a -> m (Maybe (IsAdmin a))
admin user _ = pure $ case userName $ unNamed user of
  "admin" -> Just TrustMe
  _ -> Nothing

  