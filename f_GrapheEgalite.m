function [ GL ] = f_GrapheEgalite( E, L )
%F_GRAPHEEGALITE create d'un graphe d'�galit� 
%   GL = (P union T, A), (x,y) in A <=> L(x)+L(y)=E(x,y)

% Matrice d'�galit�
ML = E==L.x*ones(1,size(E,1))+ones(size(E,1),1)*L.y;

% Initialisation
GL.NbVertices = 2*size(E,1);   % Initially empty graph
GL.NbEdges = nnz(ML==1);      % Initially empty graph
GL.Orientation = 1;  % [0] - Non directed; 1 - directed; 2 - mixte
GL.AdjList = [];     % Initially empty graph

% Creation du Graphe d'�galit� � partir de la matrice d'�galit�
GL.AdjList = cell(1,GL.NbVertices);
for k = 1 : GL.NbVertices, GL.AdjList{k} = []; end

% On numerote arbitraiement :
% les processeurs de 1 � n
% les taches de n+1 � 2n
for i = 1:GL.NbVertices/2
    i_vertices = find(ML(i,:)==1);
    GL.AdjList{i} = [i_vertices+10*ones(size(i_vertices)); E(i, i_vertices)];
end
% pour s'adapter au programe f_GBiparti2Reseau le liens n'est pas
% bidirectionnel (Les vertices 

