--tok::[Char] -> [[Char]] 
tok::String-> [String]

-- if ends with s its list
tok[] = []
tok ls = rettok ls : tok (deltok ls)

rettok::String -> String
rettok []= []
rettok(' ':_) = []
rettok(',':_) = []
rettok('.':_) = []
rettok('!':_) = []
rettok('-':_) = []
rettok('_':_) = []
rettok('+':_) = []
rettok('=':_) = []
rettok('?':_) = []
rettok('/':_) = []
rettok('\\':_) = []
rettok(')':_) = []
rettok('(':_) = []
rettok('[':_) = []
rettok(']':_) = []
rettok('{':_) = []
rettok('}':_) = []
rettok(';':_) = []
rettok('\'':_) = []
rettok('"':_) = []
rettok(cap:restlista)=cap : rettok restlista

deltok::String -> String
deltok [] = []
deltok(' ':rl) = rl
deltok(cap:rest) = deltok rest

normalizare::String->String
normalizare [] = []
normalizare ls = eliminareinauntru(elsrf ls)

eliminareinauntru (c: rl) = c : eliminareinauntru rl

elsrf::String->String
elsrf [] = []
elsrf (' ':rl) = elsrf rl
elrsf rl = rl


main :: IO()
main = do  {
              print $  filter (not . null) $ tok "Ion, urca  !! ? <   dealul (greu";

           }