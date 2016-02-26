function [FMax, L, Cmin, Smin] = f_FlotMaxEdmondsKarp(G, s, t, ICap)

% Finds the Flow Max and the Min Cut in the network G
% from source s to the sink t. IC is the index of capacity line
% in the original network G

% The structure of Gf : Gf.AdjList{k} has 3 rows
% first row : the neighbours of k
% second row : the residual capacities in G
% third row : arc of type st - value = 1 or ts - value = -1

% Initialize flow
[G, IFlow] = s_InitialiseFlow(G);
% Calculate residual graph & tst of optimality
Gf = s_REsidualGraph(G, ICap, IFlow);
[pst, typst, delta, Pf] = s_PathST(Gf, s, t);
iter = 0;
% Principal loop
while Pf(t) ~= -1  % path(s,t) found
    iter =iter + 1; L = f_ListOfEdges(G);
    % Modify Flow in path pst
    for k = 1 : length(pst) - 1
        u = pst(k); v = pst(k + 1); typ = typst(k);
        if typ == 1 % ST - arc
            iv = find(G.AdjList{u}(1, :) == v);
            fuv = G.AdjList{u}(IFlow, iv) + delta;
            G.AdjList{u}(IFlow, iv) = fuv;
        end
        if typ == -1 % TS - arc
            iu = find(G.AdjList{v}(1, :) == u);
            fvu = G.AdjList{v}(IFlow, iu) - delta;
            G.AdjList{v}(IFlow, iu) = fvu;
        end
    end % for
    % Calculate residual graph & tst of optimality
    Gf = s_REsidualGraph(G, ICap, IFlow);
    [pst, typst, delta, Pf] = s_PathST(Gf, s, t);    
end

% Write results
L = f_ListOfEdges(G); 
V = 1 : G.NbVertices; Pf(s) = s;
Smin_c = V(Pf < 0); Smin = V(Pf > 0); 
Cmin = 0;
for k = 1 : length(L(:, 1))
    u = L(k, 1); v = L(k, 2);
    iu = find(Smin == u); iv = find(Smin_c == v);
    if ~isempty(iu) && ~isempty(iv)
        Cmin = Cmin + L(k, ICap + 1);           
    end       
end
FMax = sum(G.AdjList{s}(IFlow,:));

% ====== SUB Fonctions =======================
function [pst, typst, delta, Pf] = s_PathST(Gf, s, t)

% Calculate the path from s to t using BFS in Gf
% the type of arcs and delta modification of flow

pst = t; typst = []; delta = Inf;

[Df, Pf, Cf] = f_BFS(Gf, s);
if Pf(t) ~= -1
    pst = t; typst = []; delta = Inf;
    x = pst(1);
    while x ~= s
        v = Pf(x);
        Adj_v = Gf.AdjList{v}; ix = find(Adj_v(1,:) == x);
        typvx = Adj_v(3,ix); deltavx = Adj_v(2,ix);
        
        if deltavx < delta, delta = deltavx; end
        pst = [v, pst]; typst = [typvx,typst];
        x = pst(1);
    end
end

function Gf = s_REsidualGraph(G, ICap, IFlow)

% The structure of Gf : Gf.AdjList{k} has 3 rows
% first row : the neighbours of k
% second row : the residual capacities in G
% third row : arc of type st - value = 1 or ts - value = -1

Gf = G; st = 1;  ts = -1;
for k = 1 : G.NbVertices, Gf.AdjList{k} = []; end

for k = 1 : G.NbVertices
    Adj_k = G.AdjList{k};
    if ~isempty(Adj_k)
        u = k; [nl,nc] = size(Adj_k);
        for i = 1 : nc
            v = Adj_k(1, i);
            f = Adj_k(IFlow, i); c = Adj_k(ICap, i);
            if f < c
                Gf.AdjList{u} = [Gf.AdjList{u}, [v ; c - f; st]];
            end
            if f > 0
                Gf.AdjList{v} = [Gf.AdjList{v}, [u ; f; ts]];
            end
        end
    end
end

function [G, IFlow] = s_InitialiseFlow(G0)

% Initialize all arc flows at 0
% Returns the Adjadjency of each vertex augmented with
% the line of flows and the IFlow

G = G0;
for k = 1 : G0.NbVertices
    Adj_k = G0.AdjList{k};
    if ~isempty(Adj_k)
        [nl,nc] = size(Adj_k);
        IFlow = nl + 1;
        G.AdjList{k} = [Adj_k; zeros(1, nc)];
    end
end
