{-# LANGUAGE RankNTypes #-}

module Named (Named, unNamed, withName) where

newtype Named n a = Named { unNamed :: a }

withName :: a -> (forall a. Named n a -> t) -> t
withName a f = f (Named a)