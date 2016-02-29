function stML = f_PerforMat2ReseauMat(ML)
%F_PERFORMAT2RESEAUMAT transforme une matrice de performance en matrice de
%reseau avec une source et un puis

n = size(ML,1);
% sommet 21 la source
% sommet 22 le puit
stML = [zeros(size(ML)) ML ; zeros(size(ML)) zeros(size(ML))]; %expantion de la matrice ML pour obtenir la matrice du graphe
% construction des vecteurs reliant la source au tachet et le puis au processeur
st = [ zeros(n,1) zeros(n,1) ;  zeros(n,1) ones(n,1)]; ts = [ ones(1,n) zeros(1,n) ; zeros(1,n)  zeros(1,n)];
stML = [ stML st ; ts zeros(2,2) ]; % assemblage de la matrice
end

