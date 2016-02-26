function [ C ] = f_CouplageMax( GL )
%F_COUPLAGEMAX donne le couplage max a partir de l'algorithme
%   FlotMaxEdmondsKarp


GB = f_GBiparti2Reseau(GL)
[FMax, L, Cmin, Smin] = f_FlotMaxEdmondsKarp(GB, 1, size(GB.AdjList), 1)

C = []

end

