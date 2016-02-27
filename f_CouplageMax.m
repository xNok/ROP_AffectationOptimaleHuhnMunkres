function [ C ] = f_CouplageMax( GL )
%F_COUPLAGEMAX donne le couplage max a partir de l'algorithme
%   FlotMaxEdmondsKarp


GB = f_GBiparti2Reseau(GL) %Convertie GL en ajoutant un puit et une source
[FMax, L, Cmin, Smin] = f_FlotMaxEdmondsKarp(GB, 1, GB.NbVertices, 2)

C = []

end

