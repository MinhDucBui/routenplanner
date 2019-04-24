% Gibt ungerade Knoten wieder.
function k = knotengrad(I)

% n: Anzahl der Knoten, m: Anzahl der Kanten
n = size(I,1);

% k gibt alle ungeraden Knoten an
k = [];

% zählt die inzidenten Kanten zu einem Knoten
for i = 1:n
    if mod(sum(I(i,:)),2) ~= 0
        k = [k i];
    end
end
end