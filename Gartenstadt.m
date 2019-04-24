clear all
%% Schritt 1
% Kostenfunktion, wobei c_i das Kantengewicht der i-ten Kante ist.
c = [2 3 3 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2, 1 1 1 1 1 1 1 1 4 4 4 4,...
     2 2 2 2 2 1 1 1 1 2 2 2 2 2, 1 1 1 1 1 1 1 1 4 3 2.5 2 1 1 1 1 1 1, ...
     1 1 1 1 1];

 % Kantencode in Latex als String
 S = {'\draw(1)--(2)node[midway,above=1pt]{1};\draw(3)--(2)node[midway,above=1pt]{2};\draw(4)--(1)node[midway,below=1pt,right]{4};\draw(6)--(2)node[midway,below=3pt,right]{5};\draw(5)--(4)node[midway,above=1pt]{6};\draw(5)--(6)node[midway,above=1pt]{7};\draw(19)--(6)node[midway,right=1pt]{15};\draw(5)--(20)node[midway,right=1pt]{14};\draw(4)--(21)node[midway,right=1pt]{13};\draw(20)--(21)node[midway,above=1pt]{22};\draw(19)--(20)node[midway,above=1pt]{23};\draw(19)--(18)node[midway,above=1pt]{24};\draw(17)--(18)node[midway,above=1pt]{25};\draw(17)--(16)node[midway,above=1pt]{26};\draw(16)--(15)node[midway,above=1pt]{27};\draw(14)--(13)node[midway,above=1pt]{29};\draw(15)--(14)node[midway,above=1pt]{28};\draw(7)--(8)node[midway,above=1pt]{8};\draw(9)--(8)node[midway,above=1pt]{9};\draw(9)--(10)node[midway,above=1pt]{10};\draw(11)--(10)node[midway,above=1pt]{11};\draw(12)--(11)node[midway,above=1pt]{12};\draw(12)--(3)node[midway,below=1pt]{3};\draw(12)--(13)node[midway,right=1pt]{21};\draw(11)--(14)node[midway,right=1pt]{20};\draw(10)--(15)node[midway,right=1pt]{19};\draw(9)--(16)node[midway,right=1pt]{18};\draw(8)--(17)node[midway,right=1pt]{17};\draw(18)--(7)node[midway,right=1pt]{16};\draw(13)--(22)node[midway,right=1pt]{38};\draw(14)--(23)node[midway,right=1pt]{37};\draw(15)--(24)node[midway,right=1pt]{36};\draw(16)--(25)node[midway,right=1pt]{35};\draw(17)--(26)node[midway,right=1pt]{34};\draw(18)--(31)node[midway,right=1pt]{33};\draw(19)--(32)node[midway,right=1pt]{32};\draw(20)--(33)node[midway,right=1pt]{31};\draw(21)--(34)node[midway,right=1pt]{30};\draw(34)--(33)node[midway,above=1pt]{48};\draw(33)--(32)node[midway,above=1pt]{49};\draw(32)--(31)node[midway,above=1pt]{50};\draw(31)--(30)node[midway,above=1pt]{51};\draw(30)--(29)node[midway,above=1pt]{52};\draw(29)--(28)node[midway,above=1pt]{53};\draw(28)--(27)node[midway,above=1pt]{54};\draw(27)--(35)node[midway,below=10pt,left]{55};\draw(27)--(36)node[midway,right=1pt]{63};\draw(35)--(36)node[midway,left=5pt,above]{70};\draw(37)--(36)node[midway,left=4pt,above]{69};\draw(38)--(37)node[midway,left=4pt,above]{68};\draw(38)--(39)node[midway,left=4pt,above]{67};\draw(39)--(40)node[midway,left=4pt,above]{66};\draw(40)--(41)node[midway,left=4pt,above]{65};\draw(41)--(42)node[midway,left=4pt,above]{64};\draw(43)--(37)node[midway,below=10pt,left]{62};\draw(43)--(38)node[midway,above=1,left]{61};\draw(29)--(43)node[midway,right=1pt]{60};\draw(39)--(30)node[midway,right=1pt]{59};\draw(40)--(31)node[midway,right=1pt]{58};\draw(41)--(32)node[midway,right=1pt]{57};\draw(42)--(33)node[midway,right=1pt]{56};\draw(22)--(35)node[midway,right=1pt]{47};\draw(27)--(23)node[midway,right=1pt]{46};\draw(28)--(24)node[midway,right=1pt]{45};\draw(29)--(25)node[midway,right=1pt]{44};\draw(26)--(30)node[midway,right=1pt]{43};\draw(22)--(23)node[midway,above=1pt]{42};\draw(23)--(24)node[midway,above=1pt]{41};\draw(24)--(25)node[midway,above=1pt]{40};\draw(26)--(25)node[midway,above=1pt]{39}'};
 I = inzidenzmatrix(S);
 % gasse sind die inzidenten Knoten, sackG Kanten die eine Sackgasse sind
 [gasse,sackG] = sackgasse(I);
 % Sollen erstmal ignoriert werden
 % I Inzidenzmatrix ohne sackgassen
 I(:,sackG) = []; 
 
 %% Schritt 2
 % Gibt die Knoten mit ungeraden Grad wieder.
 ungKnoten = knotengrad(I);
 neuekanten = minMatching (I,ungKnoten,c);

 %% Schritt 3
 % Gefundenen Kanten in Graph einfügen um Euler Graph zubekommen
 I = kantenhinzufugen (I, neuekanten);
 
 %% Schrit 4
 % Sackgasse mit 2 Kanten hinzufügen
 I = kantenhinzufugen (I, gasse);
 I = kantenhinzufugen (I, gasse);
 %% Schritt 5:
 % Startknoten s
 s = 1;
 kantenfleury = fleury(I,s);
 wegfleury = kanten2knoten(I,kantenfleury,1)
 
 kantenhierholzer = hierholzer (I,s);
 weghierholzer = kanten2knoten (I,kantenhierholzer,1)
 



 


    
