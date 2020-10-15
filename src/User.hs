module User
  ( User(..)  
  )
  where

data User = User
  { userName :: String
  , userPassword :: String
  }