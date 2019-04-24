% Input: Inzidenzmatrix, s Startknoten
% Ouput: Weg als Kanten, V als Knoten
function [K,V] = hierholzer (I,s)

[n,m] = size(I);
K =[];
% Wähle einen Knoten v0
v0 = s;
v = 0;
kante = 0;
% Besuchte Knoten
V =[v0];
% Besuchte Kanten
K = [];
% Z_i gibt die vorher gelaufende Kante an bei Knoten i
Z = zeros(1,n);
% Schritt 1:
while v ~= v0
    if v == 0
        v = v0;
    end
    % v ist unser aktueller Knoten
    % Wir suchen eine unbesuchten Kante, die dem Knoten v inzident ist
    kante = find( I(v,:) == 1, 1);
    % Gibt uns den Weg an, den wir bisher gelaufen sind
    K = [K kante];
    % Suche nächsten Knoten, der mit der Kante erreicht werden kann
    v = find([I(1:v-1,kante); 0; I(v+1:n,kante)] == 1 );
    V = [V v];
    Z(1,v) = kante;
    % Lösche Spalte von den Kanten, die wir schon besucht haben
    I(:,K) = 0;
end
while size(K,2) ~= m
    K1 = K;
    testI = zeros(size(I,1),size(I,2));
    testI(V,:) = I(V,:);
    [v0,kante] = find( testI == 1, 1);
    v = 0;
    K2 = [];
    Z1 = zeros(1,n);
    while v ~= v0
        if v == 0
            v = v0;
        end
        
        % v ist unser aktueller Knoten
        % Wir suchen eine unbesuchten Kante, die dem Knoten v inzident ist
        kante = find( I(v,:) == 1, 1);
        % Gibt uns den Weg an, den wir bisher gelaufen sind
        K2 = [K2 kante];
        % Suche nächsten Knoten, der mit der Kante erreicht werden kann
        v = find([I(1:v-1,kante); 0; I(v+1:n,kante)] == 1 );
        V = [ V v];
        Z1(1,v) = kante;
        % Lösche Spalte von den Kanten, die wir schon besucht haben
        I(:,K2) = 0;
    end
    % Hier wird sichergestellt, dass der Kreis mit der richtigen
    % Reihenfolge zusammengefügt werden,
    Z(Z==0) = Z(Z==0) + Z1(Z==0);
    % Finde Indez von K1, wo K2 eingeführt werden muss.
    insert = find ( K1 == Z(v0));
    K = [ K1(1,1:insert) K2 K1(1,insert+1:size(K1,2))];
    % Aktualisiere die Liste mit vorherigen Kanten bei Knoten i
    Z(Z1~=0) = Z1(Z1~=0);
    
end
end
    
