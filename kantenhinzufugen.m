% Input: Inzidenzmatrix, Kanten die hinzugefügt werden soll
% Ouput: Neue Inzidenzmatrix
function newI = kantenhinzufugen ( I, kanten)
% newI wird unsere neue Inzidenzmatrix, wobei die neue Kanten als neue
% Spalten an die Matrix hinzugefügt werden
newI = I;
% i Anzahl der Wege

% Zählt die Iterationen -> Gibt uns damit das Indize der Spalte an, die wir neu
% hinzufügen
iter = 1;
for i = 1:size(kanten,2)
    % j gibt uns die Anzahl der Kanten pro Weg i an, die wir hinzufügen
    % müssen
    for j = 1:(size(kanten{1,i},2)-1)
      newI = [newI zeros(size(I,1),1)];
      % size(I,2)+i+(j-1), da wir ab der ursprünglichen Matrix Spalten
      % hinzufügen wollen und zu jedem Weg und zu jeder Kante kommt eine
      % neue Spalte hinzu
      newI( kanten{1,i}(1,j) , size(I,2) + iter ) = 1;
      newI( kanten{1,i}(1,j+1) , size(I,2) + iter ) = 1;
      iter = iter + 1;
    end
end