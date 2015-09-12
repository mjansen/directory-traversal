module System.Directory.Traversal
       ( findFilesRecursive
       , ensureDirectory
       ) where

import Control.Applicative
import Control.Monad
import System.FilePath
import System.Directory

-- | Scan the file tree, collect names

findFilesRecursive :: (FilePath -> IO Bool) -> FilePath -> IO [FilePath]
findFilesRecursive condition dir = do
  entries <- map (dir </>) . filter (`notElem` [".", ".."]) <$> getDirectoryContents dir
  entries' <- filterM condition entries
  dirEntries <- filterM doesDirectoryExist entries
  rest <- concat <$> mapM (findFilesRecursive condition) dirEntries
  return $ entries' ++ rest
  
isPlainFile :: FilePath -> IO Bool
isPlainFile = doesFileExist

-- | Make sure that the given directory exists:

ensureDirectory :: FilePath -> IO ()
ensureDirectory dirName = do
  ok <- doesDirectoryExist dirName
  when (not ok) $ do
    ensureDirectory $ takeDirectory dirName
    createDirectory dirName
