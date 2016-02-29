function [M,F,K] = f_CouplageEdmonds(ML,L)
%F_COUPLAGEEDMONDS Retourne le couplage Max pour une matrice d"égalité données
% ML : Matrice d'agalité
% [M,F,K] : sortie de la fonction flotMaxEdmondKarp
n = size(ML,1);

stML = f_PerforMat2ReseauMat(ML); %conversion de la matrice en reseau
[M,F,K] = graphmaxflow(sparse(stML),2*n+1,2*n+2,'Method','Edmonds'); %FlowMax Edmonds

end

