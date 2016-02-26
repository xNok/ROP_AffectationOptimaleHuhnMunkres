function GB = f_GBiparti2Reseau(G)

% Transfoms a bipartite graph G to a network GB
% Attention ce programme est très particulier :
% Il différencie les éléments de droite comme étant des sommets sans
% adjacent

n = G.NbVertices; 
GB.NbVertices = n + 2; % n + 1source + 1puits
GB.NbEdges = 0; % intialize to 0
GB.AdjList = cell(1, GB.NbVertices);
BigValue = n + 1; % instead of Inf
Left = []; Right = []; % vertices in Left and Right sides

for u = 2 : n + 1
    V_u = G.AdjList{u-1};
    if ~isempty(V_u) % u is Left
        Left = [Left, u];
        V_uu = V_u + 1; % new neighbours
        C_uu = BigValue + zeros(size(V_u)); % infinite capacities
        GB.AdjList{u} = [V_uu; C_uu];
    else
        Right = [Right, u]; % u is Right
        GB.AdjList{u} = [n + 2; 1];
    end   
end
GB.Left = Left; L = length(Left); 
GB.Right = Right; R = length(Right);
GB.AdjList{1} = [Left; 1 + zeros(1,L)];
GB.NbEdges = G.NbEdges + L + R;