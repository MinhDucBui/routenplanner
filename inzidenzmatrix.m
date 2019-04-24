function  I = inzidenzmatrix(S)

% B gibt cell array von cell Elementen, wobei im cell alle vorkommenden
% Nummern in S stehen
B = regexp(S,'\d*','Match');
% A gibt uns nun den Cell an mit diesen Nummern
A = B{1};
% Wir konvertieren den Cell in ein Vektor Num
Num = zeros(1,size(A,2));
for i= 1:size(A,2)
    if ~isempty(A{i})
        Num(1,i)=str2double(A{i});
    else
        Num(1,i)=NaN;
    end
end
% Num ist nun mit allen vorkommenden Zahlen im String als Vektor

% Im String sind immer 4 Zahlen eine zeile von draw Latex
for k = 1:4:size(A,2)
    % p gibt uns die aktuelle Kante an
    p = Num(1,k+3);
    % i gibt uns den aktuellen Knoten an, j ist der Knoten mit den der
    % Knoten i verbunden ist
    i = Num(1,k);
    j = Num (1,k+1);
    I (i,p) = 1;
    I (j,p) = 1;
end