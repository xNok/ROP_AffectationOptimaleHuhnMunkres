function [M,F] = f_CouplageEdmonds(ML,L)
%F_COUPLAGEEDMONDS Retourne le couplage Max pour une matrice d"�galit� donn�es
% ML : Matrice d'agalit�
% [M,F,K] : sortie de la fonction flotMaxEdmondKarp
n = size(ML,1);

stML = f_PerforMat2ReseauMat(ML); %conversion de la matrice en reseau
stML = sparse(stML);
[M,F] = graphmaxflow(stML,2*n+1,2*n+2); %FlowMax Edmonds

end

