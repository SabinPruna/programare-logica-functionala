%trace
domains
  data=date(integer,integer,integer,integer,integer)
  lista=string*
  
database
  persoana(string,string,string,string,string)
  agenda(string,string,string)
  eveniment(string,data,string)
  
predicates
  scriereTemporizata(string)
  citireData(data)
  incarcareBazaDeFapte()
  
  meniuPrincipal
  alegereOptiuneMeniuPrincipal(char)

  creareAgenda
  deschidereAgenda
  detalii
  iesire
  
  meniuAgendaPersonala(string)
  alegereOptiuneAgenda(char,string)

  inserareContact(string)
  stergereContact(string)
  modificareContact(string)
  detaliiContact(string)
  
  inserareEveniment(string)
  stergereEveniment(string)
  modificareEveniment(string) 
  detaliiEveniment(string)  

clauses
  %scriere temporizata, se afiseaza un mesaj si se asteapta introducerea unui caracter de la tastatura
  scriereTemporizata(Message):-
    write(Message),
    readchar(_).

  %citire si validare data pentru eveniment
  citireData(Data):-
    write("An:"),
	  readInt(An),
	  An>0,
	  An<2100,
	  write("Luna:"),
	  readInt(Luna),
	  Luna>0,
	  Luna<13,
	  write("Ziua:"),
	  readInt(Ziua),
	  Ziua>0,
	  Ziua<32,
	  write("Ora:"),
	  readInt(Ora),
	  Ora>0,
	  Ora<25,
	  write("Minut:"),
	  readInt(Minut),
	  Minut>0,
	  Minut<61,
	  Data=date(Ziua,Luna,An,Ora,Minut).
	
  citireData(Data):-
    scriereTemporizata("Data este invalida. Reincearca"),nl,
	  citireData(Data).

  incarcareBazaDeFapte():-
    existfile("AGENDA.DAT"),
    consult("AGENDA.DAT").
	
  incarcareBazaDeFapte():-
    scriereTemporizata("Exista o problema la incarcarea bazei."),
    exit(1).

  %Meniu Principal, creeare agenda, deschidere cu informatii despre evenimente,
  %detalii despre utilizator, iesire
  meniuPrincipal:-
    clearwindow(),
	  makewindow(1,6,7,"Meniu Principal",6,15,15,50),
    write("1. Creaza agenda"),nl,
    write("2. Deschide agenda"),nl,
    write("3. Detalii"),nl,
    write("4. Iesire"),nl,
	  readchar(Optiune),
	  alegereOptiuneMeniuPrincipal(Optiune).
	
  %Deschidere meniuPrincipal nou pentru fiecare optiune.
  alegereOptiuneMeniuPrincipal('1'):-
    creareAgenda().  
  alegereOptiuneMeniuPrincipal('2'):-
    deschidereAgenda().  
  alegereOptiuneMeniuPrincipal('3'):-
    detalii().	
  alegereOptiuneMeniuPrincipal('4'):-
    iesire().
  alegereOptiuneMeniuPrincipal(_):-
    scriereTemporizata("Optiune invalida."),
	  meniuPrincipal().

%----Creaza agenda noua pentru utilizator detaliile date
  creareAgenda():-
    clearwindow(),
	  makewindow(1,6,7,"Creare Agenda",6,15,15,50),
	  write("Prenume:"),
    readln(Prenume),nl,
    write("Nume:"),
    readln(Nume),nl,
    write("Telefon:"),
    readln(Telefon),nl,
	  not(agenda(Prenume,Nume,_)),
    assert(agenda(Prenume,Nume,Telefon)),
	  meniuPrincipal().
	
  %Agenda nu se creeaza daca utilizatorul exista deja
  creareAgenda():-
    scriereTemporizata("Utilizatorul deja exista."),
	  meniuPrincipal().
	
  deschidereAgenda():-
    clearwindow(),
  	makewindow(1,6,7,"Agenda Personala",6,15,15,50),
    write("Prenume:"),
    readln(Prenume),nl,
    write("Nume:"),
    readln(Nume),nl,
	  agenda(Prenume,Nume,_),
	  concat(Prenume," ",Aux),
	  concat(Aux,Nume,NumeComplet),
	  meniuAgendaPersonala(NumeComplet).
	
  deschidereAgenda():-
    scriereTemporizata("Detinatorul agendei nu exista"),
	  meniuPrincipal().
	
  detalii():-
    clearwindow(),
	  makewindow(1,6,7,"Detalii",6,15,15,50),
    write("Prenume:"),
    readln(Prenume),nl,
    write("Nume:"),
    readln(Nume),nl,
	  agenda(Prenume,Nume,Telefon),
	  write("Telefon ", Telefon),nl,
    readchar(_),
  	meniuPrincipal.
  
  detalii():-
    scriereTemporizata("Utilizatorul nu are o agenda"),
  	meniuPrincipal.

  meniuAgendaPersonala(NumeComplet):-
    clearwindow(),
	  makewindow(1,6,7,"Meniu Agenda Personala",6,15,15,50),
    write("1.Inserare Contact"),nl,
    write("2.Stergere Contact"),nl,
    write("3.Modificare Contact"),nl,
    write("4.Detalii Contact"),nl,
    write("5.Inserare Eveniment"),nl,
    write("6.Stergere Eveniment"),nl,
    write("7.Modificare Eveniment"),nl,
    write("8.Detalii Eveniment"),nl,
    write("9.Intoarcere meniu principal."),nl,
	  readchar(Optiune),
	  alegereOptiuneAgenda(Optiune,NumeComplet).
  
  alegereOptiuneAgenda('1',NumeComplet):-
    inserareContact(NumeComplet).
	
  alegereOptiuneAgenda('2',NumeComplet):-
    stergereContact(NumeComplet),
	  meniuAgendaPersonala(NumeComplet).
	
  alegereOptiuneAgenda('3',NumeComplet):-
    modificareContact(NumeComplet),
	  meniuAgendaPersonala(NumeComplet).
	
  alegereOptiuneAgenda('4',NumeComplet):-
    detaliiContact(NumeComplet).
	
  alegereOptiuneAgenda('5',NumeComplet):-
    inserareEveniment(NumeComplet),
	  meniuAgendaPersonala(NumeComplet).
	
  alegereOptiuneAgenda('6',NumeComplet):-
    stergereEveniment(NumeComplet),
	  meniuAgendaPersonala(NumeComplet).
	
  alegereOptiuneAgenda('7',NumeComplet):-
    modificareEveniment(NumeComplet),
	  meniuAgendaPersonala(NumeComplet).
	
  alegereOptiuneAgenda('8',NumeComplet):-
    detaliiEveniment(NumeComplet).
	
  alegereOptiuneAgenda('9',_):-
    meniuPrincipal().
    
    
  inserareContact(NumeComplet):-	
    clearwindow(),
	  makewindow(1,6,7,"Inserare contact",6,15,15,50),
    write("Prenume:"),
    readln(Prenume),nl,
    write("Nume:"),
    readln(Nume),nl,
	  write("Telefon:"),
    readln(Telefon),nl,
	  write("Email:"),
    readln(Email),nl,
	  not(persoana(Prenume,Nume,_,_,NumeComplet)),
    assert(persoana(Prenume,Nume,Telefon,Email,NumeComplet)),
	  scriereTemporizata("Contact adaugat!"),
	  meniuAgendaPersonala(NumeComplet).
	
  inserareContact(NumeComplet):-
    scriereTemporizata("Contactul deja exista."),
    meniuAgendaPersonala(NumeComplet).

  stergereContact(NumeComplet):-
    clearwindow(),
	  makewindow(1,6,7,"Sterge contact",6,15,15,50),
    write("Prenume:"),
    readln(Prenume),nl,
    write("Nume:"),
    readln(Nume),nl,
	  persoana(Prenume,Nume,_,_,NumeComplet),
    retract(persoana(Prenume,Nume,_,_,NumeComplet)),
	  scriereTemporizata("Contact sters!").
	
  stergereContact(_):-
    scriereTemporizata("Contactul nu exista in lista de contacte.").
  
  %manarie
  modificareContact(NumeComplet):-
    stergereContact(NumeComplet),
	  inserareContact(NumeComplet).
	
  %cautare dupa nume , prezentare detalii
  detaliiContact(NumeComplet):-
    clearwindow(),
	  makewindow(1,6,7,"Detalii",6,15,15,50),
    write("Prenume:"),
    readln(Prenume),nl,
    write("Nume:"),
    readln(Nume),nl,
	  persoana(Prenume,Nume,Telefon,Email,NumeComplet),
	  write("Telefon ", Telefon),nl,
	  write("Email ",Email),nl,
	  readchar(_),
	  meniuAgendaPersonala(NumeComplet).
	
  inserareEveniment(NumeComplet):-
    clearwindow(),
	  makewindow(1,6,7,"Adaugare eveniment",6,15,15,50),
    write("Descriere:"),
    readln(Descriere),nl,
    write("Data"),nl,
	  citireData(Data),
	  not(eveniment(_,Data,NumeComplet)),
	  assert(eveniment(Descriere,Data,NumeComplet)),
	  scriereTemporizata("Eveniment adaugat").
	
  inserareEveniment(_):-
    scriereTemporizata("Un eveniment deja exista.").
	
  stergereEveniment(NumeComplet):-
    clearwindow(),
	  makewindow(1,6,7,"Adaugare eveniment",6,15,15,50),
    citireData(Data),
	  eveniment(_,Data,NumeComplet),
	  retract(eveniment(_,Data,NumeComplet)),
	  scriereTemporizata("Eveniment sters").
	
  stergereEveniment(_):-
    scriereTemporizata("Nu exista acest eveniment.").
	
  modificareEveniment(NumeComplet):-
    stergereEveniment(NumeComplet),
	  inserareEveniment(NumeComplet).  
		
  detaliiEveniment(NumeComplet):-
    clearwindow(),
	  makewindow(1,6,7,"Detalii eveniment",6,15,15,50),
	  citireData(Data),
	  eveniment(Descriere,Data,NumeComplet),
    write("Descriere: "),
	  scriereTemporizata(Descriere),
	  meniuAgendaPersonala(NumeComplet).
	
  detaliiEveniment(NumeComplet):-
    scriereTemporizata("Nu se poate gasi acest eveniment."),
	  meniuAgendaPersonala(NumeComplet).
	
  iesire():-
    save("AGENDA.DAT"),
    retractall(persoana(_,_,_,_,_)),
    retractall(eveniment(_,date(_,_,_,_,_),_)),
    retractall(agenda(_,_,_)),
    exit(0).
	
goal
  incarcareBazaDeFapte(),
  meniuPrincipal.
