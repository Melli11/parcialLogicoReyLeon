
%comio(Personaje, Bicho)
comio(pumba, vaquitaSanAntonio(gervasia,3)).
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger,15,6)).
comio(pumba, cucaracha(erikElRojo,25,70)).
 
comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno,12,8)).
comio(timon, cucaracha(cucurucha,12,5)).
 
comio(simba, vaquitaSanAntonio(remeditos,4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).
pesoHormiga(2).
 
%peso(Personaje, Peso)
peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).


% a) Qué cucaracha es jugosita: ó sea, hay otra con su mismo tamaño pero ella es más gordita

% Predicados Auxiliares

tamanioCuca(cucaracha(Nombre,Tamanio,Peso),Tamanio):-
    comio(_,cucaracha(Nombre,Tamanio,Peso)).

pesoCuca(cucaracha(Nombre,Tamanio,Peso),Peso):-
    comio(_,cucaracha(Nombre,Tamanio,Peso)).

cucarachas(Cucaracha):-
    comio(_,cucaracha(Cucaracha,_,_)).

hormigas(Hormiga):-
    comio(_,hormiga(Hormiga,_,_)).

personaje(Personaje):-
    comio(Personaje,_).


mismoTamanio(Cucaracha,OtraCucaracha):-
    tamanioCuca(Cucaracha,Tamanio),
    tamanioCuca(OtraCucaracha,Tamanio),
    Cucaracha \= OtraCucaracha.

pesaMas(Cucaracha,OtraCucaracha):-
    pesoCuca(Cucaracha,Peso),
    pesoCuca(OtraCucaracha,OtroPeso),
    Peso>OtroPeso.
    
jugosita(Cucaracha):-
    mismoTamanio(Cucaracha,OtraCucaracha),
    pesaMas(Cucaracha,OtraCucaracha),
    Cucaracha \= OtraCucaracha.

:- begin_tests(resolucion).

test(punto1a,nondet):-
    jugosita(cucaracha(gimeno,12,8)).

:- end_tests(resolucion).

% 1b) Si un personaje es hormigofílico... (Comió al menos dos hormigas).

hormigofilico(Personaje):-
personaje(Personaje),
comio(Personaje,hormiga(Hormiga)),
findall(Hormiga,(comio(Personaje,hormigas(Hormiga))),Hormigas),
sumlist(Hormigas,Total),
Total>2.


    
:- begin_tests(resolucion).
test(punto1b,nondet):-
    hormigofilico(pumba),
    hormigofilico(simba).
:- end_tests(resolucion).

% 1c) Si un personaje es cucarachofóbico (no comió cucarachas)

comioCucarachas(Personaje):-
    comio(Personaje,cucaracha(_,_,_)).

cucarachaComidaXPersonaje(Personaje,Cucaracha):-
    comio(Personaje,cucaracha(Cucaracha,_,_)).


cucarachofobico(Personaje):-
    personaje(Personaje),
    not(comioCucarachas(Personaje)).


:- begin_tests(resolucion).
test(punto1c,nondet):-
    cucarachofobico(simba).
:- end_tests(resolucion).


% d) Conocer al conjunto de los picarones. Un personaje es picarón si comió 
% una cucaracha jugosita ó si se come a Remeditos la vaquita. 
% Además, pumba es picarón de por sí.

picarones(Conjunto):-
    personaje(Personaje),
    findall(Personaje,esPicaron(Personaje),Conjunto).

esPicaron(Personaje):-
    comio(Personaje,cucaracha(Cucaracha,_,_)),
    jugosita(Cucaracha).

esPicaron(Personaje):-
    comio(Personaje,vaquitaSanAntonio(remeditos,_)).

esPicaron(pumba).

% vaquitaSanAntonio(gervasia,3)
% hormiga(tuNoEresLaReina)
% cucaracha(ginger,15,6)

% vaquitaSanAntonio(Nombre,Peso).
% hormiga(Nombre)
% cucaracha(Nombre,Tamanio,Peso)
% pesoHormiga(Peso).
% comio(simba, hormiga(schwartzenegger)).
% comio(simba, hormiga(niato)).
% comio(simba, hormiga(lula)).
