import System.Directory
import System.IO
import Data.List.Split

------------------------------STRUCTURI PENTRU DATE CUSTOM------------------------------------------------------------------------

data TRecord = Record {word::String, occurance::Integer}  --pentru pastrare perechi (cuvant, numar aparitii)
     deriving (Read, Show) --read trasnforma sir caractere in float etc, Show trans date din tipuri prelucrate intr-un tip afisabil

--getter proprietate
getWord::TRecord->String
getWord (Record word _) = word

--getter proprietate
getOccurances::TRecord->Integer
getOccurances (Record _ occurances) = occurances

--afisare formatata a tipului record
-- displayRecordList::[TRecord] -> IO()
-- displayRecordList [] = putStrLn "----------------"
-- displayRecordList (record : restOfList) = do {
--     word <- getWord record;
--     occurance <- getOcurrannces record;
--     putStrLn $ word ++ ": " ++ show occurance
--     displayRecordList restOfList
--     }

---------------------------------------------------------------------------------------------------------------------------------------


-----------------------------------------------------MENU------------------------------------------------------------------------------

--afisare meniu
showMenu::String -> IO()
showMenu fileName = do {
  putStrLn "Options:";
  putStrLn "*******************";
  putStrLn "1-Show all word occurances";
  putStrLn "2-Find occurances of given word";
  putStrLn "3-Exit";
  putStrLn "*******************";
  putStrLn "Your option:";
  option<-getLine;

  if option == "1" 
    then do {getWordsOccurances fileName; showMenu fileName}
    else if option == "2"
            then do {getGivenWordOccurances fileName; showMenu fileName}
            else if option == "3"
                     then putStrLn "Exit"
                     else do {putStrLn "Wrong action."; showMenu fileName}      
}

--deschide fisierul pentru frecventa cuvinte si afiseaza
getWordsOccurances::String -> IO()
getWordsOccurances fileName = do {
    handle <- openFile fileName ReadMode;
    printTable handle; 
    hClose handle;
}

--afiseaza continultul fisierul primit
printTable::Handle->IO()
printTable handle = do {
    endOfFile <- hIsEOF handle;
    if not endOfFile  then do {
        recordHandle<-hGetLine handle;
        record <- return (read recordHandle::TRecord);
        putStrLn ("[ "++(getWord record)++" , "++(show(getOccurances record))++" ]");
        printTable handle;
    }
    else putStrLn "Listare terminata!"
}

--print the occurances of a certain word
getGivenWordOccurances::String -> IO() 
getGivenWordOccurances fileName = do {
    putStr "Word Searched: ";
    word <- getLine;
    handle <- openFile fileName ReadMode;
    customWordOccurances word handle; 
    hClose handle;
}

--searched for given word in file and prints it's occurances
customWordOccurances::String->Handle->IO()
customWordOccurances word handle = do {
    endOfFile <- hIsEOF handle;
    if not endOfFile then do {
            recordHandle <- hGetLine handle;
            record <- return (read recordHandle::TRecord);
            if (getWord record == word) then putStrLn ("[ "++(getWord record)++" , "++(show(getOccurances record))++" ]")
            else customWordOccurances word handle
            }
    else putStrLn "Cuvantul cautat nu apare in fisier!"
}


--creaza un fisier in care se va pune TRecord
createEmptyFile::IO String
createEmptyFile = do {
                        putStrLn "Filename to save record list:";
                        hFlush stdout;
                        filename <- getLine;
                        handleOut <- openFile filename WriteMode;
                        hClose handleOut;
                        return filename;
                    }

--primeste numele fisierului de parsat de la utilizator
getFileToParse::IO String
getFileToParse = do {
    putStrLn "Name of file?";
    fileName <- getLine;
    return fileName;
}

--verifica existenta fisierului de parsat pana cand acesta exista
getExistingFile::String->IO String
getExistingFile fileName = do {
    condition <- doesFileExist fileName;
    if not condition 
        then do { putStrLn "File does not exist.";
                  fileName <- getFileToParse;
                  getExistingFile fileName;}
        else return fileName;
}

--adaugare in fisier inregistrari TRecord
addRecords::[TRecord]->Handle->IO()
addRecords [] handle = hClose handle
addRecords ( head : restofList) handle = do {
                                            hPutStrLn handle (show(Record (getWord head) (getOccurances head)));
                                            addRecords restofList handle;
} 


-----------------------ELIMINARE DELIMITATORI--------------------------------------------------------------------

--preia un sir de caractere si delimiteaza cuvintele eliminand delimitatorii
token::String -> [String]
token [] = []
token list = returnToken list : token (deleteToken list)

--Parseaza un String si elimina delimitatorii din el
returnToken::String -> String
returnToken []= []
returnToken(' ':_) = []
returnToken(',':_) = []
returnToken('.':_) = []
returnToken('!':_) = []
returnToken('-':_) = []
returnToken('_':_) = []
returnToken('+':_) = []
returnToken('=':_) = []
returnToken('?':_) = []
returnToken('/':_) = []
returnToken('\\':_) = []
returnToken(')':_) = []
returnToken('(':_) = []
returnToken('[':_) = []
returnToken(']':_) = []
returnToken('{':_) = []
returnToken('}':_) = []
returnToken(';':_) = []
returnToken('\'':_) = []
returnToken('"':_) = []
returnToken(head : restOfList) = head : returnToken restOfList

--separa continutul fisierului, eliminand primul cuvant din sir pentru a continua parsarea
deleteToken::String -> String
deleteToken [] = []
deleteToken(' ':rl) = rl
deleteToken(head:rest) = deleteToken rest

--------------------------------------------------------------------------------------------------------------------                       

----------------------DETERMINARE NUMAR DE APARITII A CUVINTELOR----------------------------------------------------
--Contorizarea aparitiilor unui element intr-o lista de siruri de caractere
countOccurances::[String] -> String -> Integer
countOccurances [] _ = 0 
countOccurances(head : restOfList) wordToCount | wordToCount == head = 1 + countOccurances restOfList wordToCount
                                               | otherwise = countOccurances restOfList wordToCount

--Stergerea aparitiilor unui element intr-o lista de siruri de caractere
deleteWord::[String] -> String -> [String]
deleteWord [] _ = []
deleteWord (head : restOfList) wordToDelete  | wordToDelete /= head = head : deleteWord restOfList wordToDelete
                                             | otherwise = deleteWord restOfList wordToDelete

--Statistica aparitiilor elementelor intr-o lista de siruri de caractere
wordStatistics::[String]->[(String,Integer)]
wordStatistics [] = []
wordStatistics (head : restOfList) = (head, countOccurances (head : restOfList) head) : wordStatistics (deleteWord restOfList head)

--Conversie lista primitive la inregistrare de tip Record
wordStatisticsToTRecord::[(String, Integer)] -> [TRecord]
wordStatisticsToTRecord [] = []
wordStatisticsToTRecord (head : restOfList) = (Record (fst head) (snd head)) : wordStatisticsToTRecord restOfList

---------------------------------------------------------------------------------------------------------------------

main::IO()
main=do {   
          fileName <- getFileToParse;
          
          existingFile <- getExistingFile fileName;  

          contentHandle <- openFile existingFile ReadMode;
          fileContent <- hGetContents contentHandle;
          
          --normalizedRecords <- wordStatisticsToTRecord $ wordStatistics $ filter (not . null) $ token fileContent;

          fileOccurances<-createEmptyFile;
          handleOutOccurances<-openFile fileOccurances WriteMode;
          addRecords (wordStatisticsToTRecord $ wordStatistics $ filter (not . null) (token fileContent)) handleOutOccurances;
          hClose handleOutOccurances;

          showMenu fileOccurances;  
          hClose contentHandle;
    }       