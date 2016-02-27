function [C L] = f_CouplageMax( GL )
%F_COUPLAGEMAX donne le couplage max a partir de l'algorithme
%   FlotMaxEdmondsKarp


GB = f_GBiparti2Reseau(GL) %Convertie GL en ajoutant un puit et une source
[FMax, L, Cmin, Smin] = f_FlotMaxEdmondsKarp(GB, 1, GB.NbVertices, 2) %determine le flotMax

% Construit le vercteur C
C = [L((GB.NbVertices/2):(size(L,1)-(GB.NbVertices/2)),1)-1 L((GB.NbVertices/2):(size(L,1)-(GB.NbVertices/2)),2)-1]

end

