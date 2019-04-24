% Input: Inzidenzmatrix, Weg als kanten, Startknoten s
% Ouput: Weg als Knoten
function V = kanten2knoten ( I, kantenweg,s)
% v aktueller Knoten, wo wir uns befinden
v = s;

% V unser Output
V = [v];
m = size(kantenweg,2);
n = size(I,1);
for i = 1:m
    % Nächster Knoten 
    v = find( [I(1:v-1, kantenweg(i) ); 0;  I(v+1:n,kantenweg(i))]== 1);
    V = [V v];
end