% Input: Inzidenzmatrix I, ungKnoten Knoten die man im Matching beachten soll, Kosten c
% Output: Kanten in Knotenschreibweise
function kanten = minMatching (I,ungKnoten,c)
% path gibt uns  die Kosten des Weges an, wobei Knoten i Startpunkt, Knoten j Endpunkt, den
% k�rzesten Weg zwischen den beiden
path = [];
kosten = 0;
% Neue Kosten f�r neue Kanten
newc = [];
pth = {[]}; 
for i = 1:size(ungKnoten,2)
    for j = i+1:size(ungKnoten,2)
        % Gibt uns k�rzesten Weg in Knoten an (1 2 3) = Knoten eins zu Knoten 2 zu
        % Knoten 3
        % pth gibt uns den k�rzesten Weg und kosten die Kosten des Weges
        pth = {[]}; 
        [pth{1,1} kosten] = dijkstra(I, c, ungKnoten(1,i), ungKnoten(1,j));
        newc = [newc kosten];
        path = [path  kosten ungKnoten(i) ungKnoten(j) pth];
        end    
end
% path gibt uns nun an f�r eine neue konstruierte Kante die Kosten,
% Startpunkt, EndPunkt, den urspr�nglichen Weg
% 4 Eintr�ge f�r eine neue konstruierte Kante
kantenindex = 1;
% Neue Inzidenzmatrix
newI = zeros(size(ungKnoten,2),size(path,2)/4);
for i = 2 : 4 : size(path,2)
   newI(path{1,i},kantenindex) = 1;
   newI(path{1,i+1},kantenindex) = 1;
   kantenindex = kantenindex + 1;
end

% Erstelle eine Matrix mit:
% 1.Spalte Anfangsknoten,
% 2. Spalte Endknoten zu den Anfangsknoten in 1 Spalte (und selbe Zeile) 
% 3. Spalte Kosten dieses Weges
% Diese Form, da die funktion maxWeightMatching fordert

for i = 1:size(newI,2)
    % Gibt die Indizes der Knoten, die verbunden werden (Spalteneintr�ger
    % der Inzidenzmatrix gibt diese an)
    E(i,:) = find(newI (:,i))';
end
% Minus, da wir nur maximales Matching l�sen k�nnen
E = [E -newc'];
[a,b] = maxWeightMatching(E,true);

% Nun wieder in einzelne urspr�ngliche Kanten umwandeln
% Kanten, die wir in unser urspr�nglichen Graphen hinzuf�gen stehen nun in
% Cell Array kanten
kanten = { path{1,4*b} };

