parse::String -> IO()
parse [] = putStrLn "---Done"
parse (head : restOfList) = do {
                            putStr [head]; 
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
    Control.Monad.when (answer == "Y") main
}       