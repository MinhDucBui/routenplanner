% Input: Inzidenzmatrix I, ungKnoten Knoten die man im Matching beachten soll, Kosten c
% Output: Kanten in Knotenschreibweise
function kanten = minMatching (I,ungKnoten,c)
% path gibt uns  die Kosten des Weges an, wobei Knoten i Startpunkt, Knoten j Endpunkt, den
% kürzesten Weg zwischen den beiden
path = [];
kosten = 0;
% Neue Kosten für neue Kanten
newc = [];
pth = {[]}; 
for i = 1:size(ungKnoten,2)
    for j = i+1:size(ungKnoten,2)
        % Gibt uns kürzesten Weg in Knoten an (1 2 3) = Knoten eins zu Knoten 2 zu
        % Knoten 3
        % pth gibt uns den kürzesten Weg und kosten die Kosten des Weges
        pth = {[]}; 
        [pth{1,1} kosten] = dijkstra(I, c, ungKnoten(1,i), ungKnoten(1,j));
        newc = [newc kosten];
        path = [path  kosten ungKnoten(i) ungKnoten(j) pth];
        end    
end
% path gibt uns nun an für eine neue konstruierte Kante die Kosten,
% Startpunkt, EndPunkt, den ursprünglichen Weg
% 4 Einträge für eine neue konstruierte Kante
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
    % Gibt die Indizes der Knoten, die verbunden werden (Spalteneinträger
    % der Inzidenzmatrix gibt diese an)
    E(i,:) = find(newI (:,i))';
end
% Minus, da wir nur maximales Matching lösen können
E = [E -newc'];
[a,b] = maxWeightMatching(E,true);

% Nun wieder in einzelne ursprüngliche Kanten umwandeln
% Kanten, die wir in unser ursprünglichen Graphen hinzufügen stehen nun in
% Cell Array kanten
kanten = { path{1,4*b} };

