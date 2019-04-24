% I Inzidenzmatrix, s Startknoten
% Output: Weg in Kanten
function K = fleury(I,s)

[n,m] = size(I);

% Wähle beliebigen Knoten -> Hier: Startknoten vorgeben
v_temp = s;
% Unsere besuchten Kanten bzw. Weg
K =[];
p = 0;
v = 0;
while size(K,2) ~= m
    % Wähle nächste Kante aus, die soll aber inzident sein mit
    % aktuellen Knoten
    % Dafür schauen wir als erstes an, welche Kanten inzident sind mit
    % unserem aktuellen Knoten
    % Sie darf jedoch keine Brücke sein, wir überprüfen mit Tiefensuche
    p = 0;
    i = 1;
    v = v_temp;
    % Zuerst keine Kanten wählen, die Brücken sind, aber wenn keine
    % Möglichkeit mehr offen sind, dann wähle diese Kante
    while p ~= 1 && i ~= sum(I(v,:))+1
        k = find( I(v,:) == 1);
        % Potenzieller nächster Knoten -> Überprüfen, ob ausgewählte Kante eine
        % Brücke ist.
        v_temp = find( [I(1:v-1,k(i)); 0;  I(v+1:n,k(i))]== 1);
        I_temp = I;
        I_temp(:,k(i)) = 0;
        k = k(i);
        % Betrachte Graph ohne die ausgewählte kante und überprüfe, ob es ein
        % Weg im Teilgraphen gibt von aktuellen Knoten zu potenziellen Knoten
      p = bfs(inc2adj(I_temp), v, v_temp);
      p = ~(p(v_temp) == -1);
        i = i + 1;
    end
    % Füge in unser Weg hinzu
    K = [K k];
    % Aktualisiere Knoten
    % Streiche die besuchten Kanten
    I(:,K) = 0;
end
end