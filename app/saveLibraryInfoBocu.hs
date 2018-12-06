import System.IO

data TCarte = Carte String String Float --it's like a C Strunct
     deriving (Read, Show) --read trasnforma sir caractere in float etc, Show trans date din tipuri prelucrate intr-un tip afisabil

creareFisierVid::IO String

creareFisierVid = do {
                    putStrLn "Nume fisier:";
                    hFlush stdout;
                    numeFisier <- getLine;
                    handleOut <- openFile numeFisier WriteMode;
                    hClose handleOut;
                    return numeFisier;
                    }

adaugaCarti::Handle -> IO()

adaugaCarti handle = do {
                        putStr "Titlu carte:";
                        hFlush stdout;
                        titlu <- getLine; 
                        --do author
                        putStr "Pret carte";
                        hFlush stdout;
                        pret <- getLine;
                        floatPret <- return (read pret::Float); --conversie String in float;
                        hPutStrLn handle ( show(Carte titlu titlu floatPret) );
    
    
                        putStr"Mai adaugati(D/N):";
                        hFlush stdout;
                        raspuns <- getLine;
                        if(raspuns == "D") then adaugaCarti handle
                                           else return();
                       }

loop::Handle->IO()

loop handle = do {
               endOfFile <- hIsEOF handle;
               if endOfFile then putStrLn "Listare terminata..."
                             else  do {
                                    inregistrare <- hGetLine handle;

                                    inregistrareTCarte <- return (read inregistrare::TCarte);

                                    --print inregistrare;
                                    putStrLn (getTitle inregistrareTCarte);
                                    putStrLn (getAuthor inregistrareTCarte);
                                    putStrLn (show(getPrice inregistrareTCarte));


                                    loop handle;
                                    }
                }   


getTitle::TCarte->String

getTitle (Carte titlu _ _) = titlu

--one each for author and price
getAuthor::TCarte->String

getAuthor (Carte _ author _) = author

getPrice::TCarte->Float

getPrice (Carte _ _ pret) = pret

main::IO()
main = do {
        numeFisier <- creareFisierVid;
        
        handleOut <- openFile numeFisier WriteMode;
        adaugaCarti handleOut;
        hClose handleOut;
        
        handleIn <- openFile numeFisier ReadMode;
        loop handleIn;
        }