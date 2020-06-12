-- Copyright (c) 2020 Matthías Páll Gissurarson
module Plugin ( plugin) where

import GhcPlugins hiding (TcPlugin)
import TcRnTypes (TcPlugin(..),TcPluginResult(TcPluginOk))
import TcPluginM 

plugin :: Plugin
plugin = defaultPlugin { tcPlugin = Just . minimalPlugin
                       , pluginRecompile = purePlugin }
 where minimalPlugin _ = TcPlugin initialize solve stop
       initialize = return ()
       solve _ _ _ _ = do pluginTyCons <- getPluginTyCon
                          return $ TcPluginOk [] [] 
       stop _ = return ()

data PluginTyCon = PTC { minimal :: TyCon }

getPluginTyCon :: TcPluginM PluginTyCon
getPluginTyCon =
   do fpmRes <- findImportedModule (mkModuleName "Plugin") Nothing
      case fpmRes of
         Found _ mod  ->
             -- To simplify, we just lookup the PluginTyCon TyCon
             -- though this also fails if we look for any other modules 
             -- in the plugin package. 
             do min_name <- lookupOrig mod (mkTcOcc "PluginTyCon")
                minimal <- tcLookupTyCon min_name -- This line triggers the bug
                return $ PTC minimal
         _ -> pprPanic "Plugin module not found!" empty
