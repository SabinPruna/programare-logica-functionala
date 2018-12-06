import System.IO

concatString::String->String->String->String->String

concatString t a p=return ( "(" ++ t ++ "," ++ a ++ "," ++ p ++ ")")

main :: IO ()
main = do {
        putStrLn "Title?";
        title <- getLine;
        putStrLn "Authir(s)?";
        authors <- getLine;
        putStrLn "price?";
        price <- getLine;
        --record <- concatString title authors price; --"(" ++ title + "," ++ authors ++ "," ++ price ++ ")"; --{1},{2})." [title, authors, show price]

        handle <- openFile "library.txt" ReadWriteMode;
        hPutStrLn handle $ "(" ++ title ++ "," ++ authors ++ "," ++ price ++ ")";
        hClose handle;

        putStrLn "Continue? Y/N";
        answer <- getLine;
    if answer == "Y" then main else putStrLn "Program finished.";
        }