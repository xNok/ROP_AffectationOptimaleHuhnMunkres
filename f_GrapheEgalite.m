function [ GL ] = f_GrapheEgalite( E, L )
%F_GRAPHEEGALITE create d'un graphe d'égalité 
%   GL = (P union T, A), (x,y) in A <=> L(x)+L(y)=E(x,y)
%   

% Initialisation
GL.NbVertices = 0;   % Initially empty graph
GL.NbEdges = 0;      % Initially empty graph
GL.Orientation = 0;  % [0] - Non directed; 1 - directed; 2 - mixte
GL.AdjList = [];     % Initially empty graph

% Matrice d'égalité
ML = E==L.x*ones(1,10)+ones(10,1)*L.y
max(ML)
GL.AdjList = cell(1,GL.NbVertices);


end

