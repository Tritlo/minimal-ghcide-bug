{-# OPTIONS_GHC -fplugin Plugin #-}
{-# LANGUAGE TypeFamilies #-}
module Main where

-- Even if we import the TyCon being used  and use it in the code,
--  we still get the same error
-- import Plugin (PluginTyCon(..))

-- fP :: () ~ Bool => PluginTyCon -> IO ()
-- fP PTC{} = print "bug"
-- main :: IO ()
-- main = f (PTC undefined)

-- We need an unsolveable constraint to trigger the plugin
f :: () ~ Bool => IO ()
f = print "bug"

main :: IO ()
main = f 
