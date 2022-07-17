% I Inzidenzmatrix, s Startknoten
% Output: Weg in Kanten
function K = fleury(I,s)

[n,m] = size(I);

% W�hle beliebigen Knoten -> Hier: Startknoten vorgeben
v_temp = s;
% Unsere besuchten Kanten bzw. Weg
K =[];
p = 0;
v = 0;
while size(K,2) ~= m
    % W�hle n�chste Kante aus, die soll aber inzident sein mit
    % aktuellen Knoten
    % Daf�r schauen wir als erstes an, welche Kanten inzident sind mit
    % unserem aktuellen Knoten
    % Sie darf jedoch keine Br�cke sein, wir �berpr�fen mit Tiefensuche
    p = 0;
    i = 1;
    v = v_temp;
    % Zuerst keine Kanten w�hlen, die Br�cken sind, aber wenn keine
    % M�glichkeit mehr offen sind, dann w�hle diese Kante
    while p ~= 1 && i ~= sum(I(v,:))+1
        k = find( I(v,:) == 1);
        % Potenzieller n�chster Knoten -> �berpr�fen, ob ausgew�hlte Kante eine
        % Br�cke ist.
        v_temp = find( [I(1:v-1,k(i)); 0;  I(v+1:n,k(i))]== 1);
        I_temp = I;
        I_temp(:,k(i)) = 0;
        k = k(i);
        % Betrachte Graph ohne die ausgew�hlte kante und �berpr�fe, ob es ein
        % Weg im Teilgraphen gibt von aktuellen Knoten zu potenziellen Knoten
      p = bfs(inc2adj(I_temp), v, v_temp);
      p = ~(p(v_temp) == -1);
        i = i + 1;
    end
    % F�ge in unser Weg hinzu
    K = [K k];
    % Aktualisiere Knoten
    % Streiche die besuchten Kanten
    I(:,K) = 0;
end
end