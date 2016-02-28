function [M,F,K] = f_CouplageEdmonds(ML)
%F_COUPLAGEEDMONDS Retourne le couplage Max pour une matrice d"égalité données
% ML : Matrice d'agalité
% [M,F,K] : sortie de la fonction flotMaxEdmondKarp

n = size(ML,1);

% sommet 21 la source
% sommet 22 le puit
stML = [zeros(size(ML)) ML ; zeros(size(ML)) zeros(size(ML))]; %expantion de la matrice ML pour obtenir la matrice du graphe
% construction des vecteurs reliant la source au tachet et le puis au processeur
st = [ zeros(n,1) zeros(n,1) ;  zeros(n,1) ones(n,1)]; ts = [ ones(1,n) zeros(1,n) ; zeros(1,n)  zeros(1,n)];
stML = [ stML st ; ts zeros(2,2) ]; % assemblage de la matrice
[M,F,K] = graphmaxflow(sparse(stML),21,22,'Method','Edmonds'); %FlowMax Edmonds

end

