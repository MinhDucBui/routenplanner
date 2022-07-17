% Input Inzidenzmatrix
% Ouput: gasse sind die inzidenten Knoten,  Kante ist der Kantenindex
function [gassen,kante] = sackgasse(I)
n = size (I,1);
kante = [];
for i = 1:n 
    if (sum (I(i,:)) == 1);
        kante = [kante find(I(i,:) == 1)];
    end
end
% Knoten angeben der sackgassekante
gassen = {};
for i = 1:size(kante,2)
   gassen = [gassen {find(I(:,kante(i)) == 1)'}];
end