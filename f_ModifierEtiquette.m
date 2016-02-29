function L = f_ModifierEtiquette(ML,L,F,E)
%F_MODIFIERETIQUETTE Summary of this function goes here
%   Detailed explanation goes here

%*************************************************
% Etape 0 Création du reseau
%%
stML = f_PerforMat2ReseauMat(ML); %o(n^2)
n = size(ML,1);

%*************************************************
% Etape 1 Création du graphe GLO
%%

F(2*n+1,:) = zeros(1,2*n+2);stML(2*n+1,:) = zeros(1,2*n+2); %on retire les sources
F(:,2*n+2) = zeros(2*n+2,1);stML(:,2*n+2) = zeros(2*n+2,1); % on retire les puits

[i_f,j_f,k_f] = find(F);[i_stML,j_stML,k_stML] = find(stML); %transformation des matices sparses
f_LEdge = [i_f,j_f]; %liste des arrètes de F
stML_LEdge = [i_stML,j_stML]; %liste des arrêtes de stML

GLO = []; %init GLO

for i=1:size(i_stML,1) % pour chaque colonne de F
    if  sum(ismember(stML_LEdge(i,:),f_LEdge,'rows'))< 1 % danc arc de stML dans F
        GLO = [ GLO ; [i_stML(i),j_stML(i),k_stML(i)]]; % dans F de T vers P
    else
        GLO = [ GLO ; [j_stML(i),i_stML(i),k_stML(i)]]; % Pas dans F de P vers T
    end
end %o(m)

%*************************************************
% Etape 2 éléments qui font que C n'est pas parfait
%%
r = find(ismember([1:n],i_f)==0); %o(n)

%*************************************************
% Etape 3 BFS
%%
GLO = sparse(GLO(:,1),GLO(:,2),GLO(:,3),2*n,2*n);
[disc, pred, Arbre_BFS] = graphtraverse(GLO,r(1),'Method','BFS'); %o(n+m)

%*************************************************
% Etape 4 définition de X et Y
%%
X = find(ismember([1:n],Arbre_BFS)==1); %Sommet de Arbre-BFS dans P
Y = find(ismember([n+1:2*n],Arbre_BFS)==1); % Sommet de Arbre-BFS dans T
Y_T = find(ismember([n+1:2*n],Arbre_BFS)==0); % //!\\ Sommet de Arbre-BFS non dans T
delta = Inf;

for x=X
    for y=Y_T
        delta = min(L.x(x) + L.y(y) - E(x,y),delta); % on le garde que la plus petite valeurs
    end
end %o(n^2)

%*************************************************
% Etape 4 modifier étiquettes
%%

for x=X
    L.x(x) = L.x(x) - delta; %o(n)
end

for y=Y
    L.y(y) = L.y(y) + delta; %o(n)
end

end

