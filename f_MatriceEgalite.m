function ML = f_MatriceEgalite(E,L)
%F_MATRICEEGALITE retourne la matrice d'agalit� pour la matice de
% performance E avec l'�tiquetage L

ML = (E==L.x*ones(1,size(E,1))+ones(size(E,1),1)*L.y) .* E;
end

