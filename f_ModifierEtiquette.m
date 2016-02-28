function L = f_ModifierEtiquette(ML,L,M,F,K)
%F_MODIFIERETIQUETTE Summary of this function goes here
%   Detailed explanation goes here

%*************************************************
% Etape 0 Création du reseau
%%
stML = f_PerforMat2ReseauMat( ML )
n = size(ML,1);

%*************************************************
% Etape 1 Création du graphe GLO
%%

[i_f,j_f,k_f] = find(F);[i_stML,j_stML,k_stML] = find(stML); %transformation des matices sparses
f_LEdge = [i_f,j_f]; %liste des arrètes de F
stML_LEdge = [i_stML,j_stML]; %liste des arrêtes de stML

GLO = [i_f,j_f,k_f]; % on commance GLO avec les éléments de F

for i=1:size(i_stML,1) % pour chaque colonne de F
    %si [i_f,j_f,k_f](i) in [i_stML,j_stML,k_stML]
    if  sum(ismember(stML_LEdge(i,:),f_LEdge,'rows'))< 1
        % Pour construire GLO on ajoute à F des éléments de GL qui ne
        % sont pas dans F.
        % On invers i et j pour que les éléments qui ne sont pas dans C aillent de P a T
        if(i_stML(i)==2*n+1 || i_stML(i)==2*n+2 || j_stML(i)==2*n+1 || j_stML(i)==2*n+2)
            GLO = [ GLO ; [i_stML(i),j_stML(i),k_stML(i)]]; 
        else
            GLO = [ GLO ; [j_stML(i),i_stML(i),k_stML(i)]]; 
        end
    end
end

%*************************************************
% Etape 2 éléments qui font que C n'est pas parfait
%%
r = find(ismember([1:n],i_f)==0);

%*************************************************
% Etape 3 BFS
%%
order = graphtraverse(F,r(1),'Method','BFS');

%*************************************************
% Etape 4 définition de X et Y
%%

end

