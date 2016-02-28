function [C AB C2] = f_CouplageMax( GL )
%F_COUPLAGEMAX donne le couplage max a partir de l'algorithme
%   FlotMaxEdmondsKarp


GB = f_GBiparti2Reseau(GL) %Convertie GL en ajoutant un puit et une source
[FMax, L, Cmin, Smin] = f_FlotMaxEdmondsKarp(GB, 1, GB.NbVertices, 2) %determine le flotMax

% Construit le vercteur C et C2

departL = (GB.NbVertices/2);
ArriveeL = (size(L,1)-(GB.NbVertices/2));
Cond = find(L(departL:ArriveeL,4)==1)+(GB.NbVertices/2)-1;

V1 = L(Cond,1);
V2 = L(Cond,2);
C = [V1-1 V2-1]

departL2 = (GB.NbVertices/2);
ArriveeL2 = (size(L,1)-(GB.NbVertices/2));
Cond2 = find(L(departL:ArriveeL,4)==0)+(GB.NbVertices/2)-1;

V12 = L(Cond2,1);
V22 = L(Cond2,2);
C2 = [V12-1 V22-1]

W = L(:,4)';
L1 =L(:,1)';
L2=L(:,2)';

S1 = size(L1);
S2 = size(L2);
S3 = size(W);

AB = sparse(L1,L2,W,22,22);
d = size(AB);
AB2 = full(AB);
h = view(biograph(AB,[],'ShowWeights','on'))


end

