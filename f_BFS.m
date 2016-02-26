function [dist, prec, color]= f_BFS(G, s)

% Breadth First Search of G from vertex s
% Syntaxe d'appel : [d,p,c] = f_BFS(G,s)

% Initialisation
n = G.NbVertices;
dist = Inf(1, n); prec = -ones(1, n);
color = zeros(1, n); % color - 0 = white; 1 = grey; 2 = black;

color(s) = 1; dist(s) = 0; PILE = s;

% Explore
while ~isempty(PILE)
    u = PILE(1); % Head of PILE
    Adju = [];% List of Neighbours of u
    if ~isempty(G.AdjList{u}), Adju = G.AdjList{u}(1,:);  end
    for v = Adju
        if color(v) == 0
            color(v) = 1; % grey
            dist(v) = dist(u) + 1;
            prec(v) = u;
            PILE = [PILE, v]; % empile
        end
    end
    PILE(1) = []; color(u) = 2; % black
end