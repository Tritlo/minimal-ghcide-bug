Minimal ghcide bug
==================

Building with `cabal run test` triggers the expected type error when compiling
Test.hs. When run with `ghcide version: 0.2.0 (GHC: 8.10.1)` however, it will
fail with an error saying that the interface for `PluginTyCon` cannot be found:

```console
  • Can't find interface-file declaration for type constructor or class PluginTyCon
  Probable cause: bug in .hi-boot file, or inconsistent .hi file
  Use -ddump-if-trace to get an idea of which file caused the error
  • In the type signature: f :: () ~ Bool => IO ()
```
