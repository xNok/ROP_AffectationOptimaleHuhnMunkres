function L = f_ListOfEdges(G)

% Returns the list of edges with the informations of each edge

% Find the dimension of L : NbRows = Nb of Edges; NbColumns = Nb
% Informations + 2 (vertices)
for k = 1 : G.NbVertices
    if ~isempty(G.AdjList{k})
        [nc,nl] = size(G.AdjList{k});
        break
    end
end
NbColumns = nc + 1;

L = zeros(G.NbEdges, NbColumns); lig = 0;
for k = 1 : G.NbVertices
    if ~isempty(G.AdjList{k})
        N = G.AdjList{k}(1,:); % List of neighbors
        
        % Test of rendondant edges
        for j = 1 : length(N)
            for i = 1 : lig
                C1 = L(i,1) == k && L(i,2) == N(j);
                C2 = L(i,2) == k && L(i,1) == N(j);
                if C1 || C2, N(j) = 0; end
            end
        end
        
        % Add new edges
        for j = 1 : length(N)
            if N(j) > 0
                lig = lig + 1;
                L(lig,:) = [k,G.AdjList{k}(:,j)'];
            end
        end
    end
end
L = L(1 : lig,:);