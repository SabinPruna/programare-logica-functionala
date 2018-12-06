import Data.List


parse::String -> IO()
parse [] = putStrLn "---Done"
parse (headOfList : restOfList) = do {
                            putStr [headOfList]; 
                            parse restOfList
                        }
parse ('\n' : restOfList) = do { 
                            putStrLn " "; 
                            parse restOfList 
                        } 
parse (' ' : restOfList) = do { 
                            putStrLn " "; 
                            parse restOfList 
                        } 



main::IO()
main=do {
      putStrLn "Name of file?";
      fileName <- getLine;
      fileContent <- readFile fileName;
      parse fileContent;
      putStrLn "Continue? Y/N";
      answer <- getLine;
      if answer == "Y" then main else putStrLn "Program finished.";   --Control.Monad.when (answer == "Y") main;
    }       