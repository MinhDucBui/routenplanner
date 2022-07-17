clear all
%% Schritt 1
I = [1 0 0 1 0 0 0 1 0; 1 0 1 0 0 1 0 0 0;0 1 1 0 0 0 1 0 0;0 1 0 1 1 0 0 0 0;0 0 0 0 1 1 0 0 1; 0 0 0 0 0 0 1 1 0; 0 0 0 0 0 0 0 0 1 ];
c = [10 10 5 5 2 2 2 2];
% gasse sind die inzidenten Knoten, sackG Kanten die eine Sackgasse sind
[gasse,sackG] = sackgasse(I)
% Sollen erstmal ignoriert werden
% I Inzidenzmatrix ohne sackgassen
I(:,sackG) = []; 
%% Schritt 2
ungKnoten = knotengrad(I);

% for i = 1:size(I,2)
%     % Gibt die Indizes der Knoten, die verbunden werden (Spalteneinträger
%     % der Inzidenzmatrix gibt diese an)
%     E(i,:) = find(I (:,i))';
% end
% % Minus, da wir nur maximales Matching lösen können
% E = [E -c'];
% [a,b] = maxWeightMatching(E,true);

kanten = minMatching(I,ungKnoten,c);
%% Schritt 3
I = kantenhinzufugen(I,kanten);

%% Schritt 4
 I = kantenhinzufugen (I, gasse);
 I = kantenhinzufugen (I, gasse);
 
 %% Schritt 5
s = 1;
kanten = fleury(I,1);
weg = kanten2knoten(I,kanten,1)
kanten = hierholzer(I,1);
weg = kanten2knoten(I,kanten,1)

