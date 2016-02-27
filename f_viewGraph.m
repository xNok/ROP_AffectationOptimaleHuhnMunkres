function h = s_viewGraph(G, boolean)
    % Affiche le grape à partir de la matrice des performances
    superG = [zeros(size(G)) G ; zeros(size(G)) zeros(size(G))];
    h = view(biograph(superG,[],'ShowWeights','on'))
end

