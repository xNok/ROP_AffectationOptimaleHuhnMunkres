function [M,F,K] = f_CouplageEdmonds(ML)
%F_COUPLAGEEDMONDS Retourne le couplage Max pour une matrice d"�galit� donn�es
% ML : Matrice d'agalit�
% [M,F,K] : sortie de la fonction flotMaxEdmondKarp

stML = f_PerforMat2ReseauMat( ML ); %conversion de la matrice en reseau
[M,F,K] = graphmaxflow(sparse(stML),21,22,'Method','Edmonds'); %FlowMax Edmonds

end

