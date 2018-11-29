--tok::[Char] -> [[Char]] 
tok::String->[String]

-- if ends with s its list
tok[] = []
tok ls = rettok ls : tok (deltok ls)

rettok::String -> String
rettok []= []
rettok(' ':_) = []
rettok(cap:restlista)=cap : rettok restlista

deltok::String -> String
deltok [] = []
deltok(' ':rl) = rl
deltok(cap:rest) = deltok rest

normalizare::String->String
normalizare [] = []
normalizare ls = eliminareinautru(elsrf ls)

eliminareinauntru (c: rl) = c : eliminareinauntru rl

elsrf::String->String
elsrf [] = []
elsrf (' ':rl) = elsrf rl
elrsf rl = rl

main :: IO()
main = print(tok "Ion urca dealul")