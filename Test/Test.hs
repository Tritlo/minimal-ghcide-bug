{-# OPTIONS_GHC -fplugin Plugin #-}
{-# LANGUAGE TypeFamilies #-}
module Main where

-- We need an unsolveable constraint to trigger the plugin
f :: () ~ Bool => IO ()
f = print "bug"

main :: IO ()
main = f
