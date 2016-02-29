function [M,F] = f_CouplageEdmonds(ML,L) %O(n^2*sqrt(m))
%F_COUPLAGEEDMONDS Retourne le couplage Max pour une matrice d"égalité données
% ML : Matrice d'agalité
% [M,F,K] : sortie de la fonction flotMaxEdmondKarp
n = size(ML,1);

stML = f_PerforMat2ReseauMat(ML); %conversion de la matrice en reseau % o(n^2)
stML = sparse(stML); % conversion
[M,F] = graphmaxflow(stML,2*n+1,2*n+2); %FlowMax natif de matlab  O(n^2*sqrt(m))

end

