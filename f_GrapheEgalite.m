function [ GL ] = f_GrapheEgalite( E, L )
%F_GRAPHEEGALITE create d'un graphe d'égalité 
%   GL = (P union T, A), (x,y) in A <=> L(x)+L(y)=E(x,y)

% Matrice d'égalité
ML = E==L.x*ones(1,10)+ones(10,1)*L.y

% Initialisation
GL.NbVertices = 2*size(E,1);   % Initially empty graph
GL.NbEdges = nnz(ML==1);      % Initially empty graph
GL.Orientation = 1;  % [0] - Non directed; 1 - directed; 2 - mixte
GL.AdjList = [];     % Initially empty graph

GL.AdjList = cell(1,GL.NbVertices);
for k = 1 : GL.NbVertices, GL.AdjList{k} = []; end

for i = 1:GL.NbVertices
 nProcesseur = GL.NbVertices/2;
 
 if i <  nProcesseur+1
    i_vertices = find(ML(i,:)==1);
 else
    i_vertices = find(ML(:,i-nProcesseur)==1);
 end
    GL.AdjList{i} = [i_vertices; E(i_vertices)];
end

