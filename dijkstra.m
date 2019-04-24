% T gibt die Reihenfolge von Kanten wieder, die wir laufen m�ssen
% d gibt die Distanzen der kurzesten Wege von s nach v fur alle Knoten
% I = Inzidenzmatrix
% c = Kostenfunktion, wobei  ci die Kosten fur die Kante i darstellt
% s Startknoten
function [knoten,gewicht] = dijkstra(I,c,s,e)
 
   % n Anzahl der Knoten
    n = size(I,1);
    % Z_i gibt die vorher gelaufende Kante an bei Knoten i
    Z = zeros(1,n); 

    % d gibt Distanzen wieder
    d = inf * ones(1,n);
    d(s) = 0;

    % Besuchten Knoten
    P = []; 

    % Solange es noch unbesuchte Knoten gibt
    while length(P) ~= n
        % Sortieren unsere unbesuchten Knoten
        Q = setdiff(1:n,P); 
        
        % Gibt kleinste Distanz an von den unbesuchten Knoten (Indize)
        [~,ind] = min(d(Q));
        
        % Betrachten Knoten mit kleinster Distanz und unbesucht
        u = Q(ind);

        % falls man ein Knoten nicht erreichen kann (in unserem Fall nicht
        % m�glich, da Graph zusammenh�ngend
        if d(u) == inf
            break;
        end
        
        % F�ge u in die besuchten Knoten hinzu
        P = [P, u];
        
        % Kanten, die von u raus gehen
        kanten = find(I(u,:) == 1);
        
        % Akualisiere Distanzen von den Knoten, die man vom 
        % ausgew�hlten Knoten erreichen kann
        for k = kanten
            % Knoten, die von Kanten k erreicht werden k�nnen
            v = find( [I(1:u-1,k); 0 ; I(u+1:n,k)] == 1); 
            if d(v) > d(u) + c(k)
                d(v) = d(u) + c(k);
                Z(v) = k;
            end
        end
    end
    % Algorithmus w�re hier f�r Dijkstra zu ende
    
    % knoten gibt uns die Knoten, die wir laufen m�ssen bis zum Endknoten f�r
    % minimalen Weg
    % Gibt uns die Knoten an
    knoten = [];
    % gibt Kantensumme an f�r Endknoten e.
    gewicht = d(e);
    % Solange wir noch nicht beim Startpunkt sind, gehen wir den Weg zur�ck
    while e ~= s
        knoten = [knoten e];
        % Knoten, die man mit der Kante zur�ckl�uft
        e = find( [I(1:(e-1),Z(e)); 0 ; I(e+1:n,Z(e))] == 1);
    end
    knoten = [ knoten e];
end