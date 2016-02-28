% Main program for the ROP Project : Task Management
% Authors : Alexandre Couedelo, Flavien Isidore
%
% Problem :
% Soit n t�ches � r�aliser et n machines pour les r�aliser.
% Connaissant A(i,j) la perfommance de r�alisation de la t�che Ti par le processeur la Pj
% On cherche l'affectation conduissant � la performance total maximum
%
% Resources :
% Fondamentaux de Recherche Op�rationnelle, EMA, Stephane Janaqi
% cours.ensem.inpl-nancy.fr/cours-dm/graphes/Graphes.pdf
% https://en.wikipedia.org/wiki/Hungarian_algorithm
% https://wikimpri.dptinfo.ens-cachan.fr/lib/exe/fetch.php?media=cours:upload:2-24-1-kuhn-munkres.pdf
% http://fr.slideshare.net/binnasser2007/kuhn-munkres-algorithm
%
% hypothesis :
% La graphe G est un graphe biparti complet, il peut donc �tre d�finit de
% mani�re unique par la matrice des performances E

%--------------------------------------------------
% 0. Nettoyage
%--------------------------------------------------
close all, clear all, , clc

%--------------------------------------------------
% 1. Laod Matrix
%--------------------------------------------------
path = 'D:\03-Ecole\2A\ROP\Projet_AC_FI\';
filename = strcat(path , 'M10.txt');
E = importdata(filename);
n = size(E,1);

%--------------------------------------------------
% 2. Algorythm
%--------------------------------------------------
L = f_EtiquetesInitialsesFaisables(E);
GL = f_GrapheEgalite(E,L);
[C, AdjL] = f_CouplageMax(GL);
%---
% representation graphique
%W  = AdjL(:,3)'; L1 = AdjL(:,1)';  L2 = AdjL(:,2)';
%AB = sparse(L1,L2,W,22,22); h = view(biograph(AB,[],'ShowWeights','on'));
%---

%while ~isempty(find(ismember([(GL.NbVertices/2+1):GL.NbVertices], C)==0))
% L = f_ModifierEtiquette(GL, C, L);
% GL = f_GrapheEgalite(E,L);
% [C, AdjL] = f_CouplageMax(GL);
%---
% representation graphique
%---
%W  = AdjL(:,3)'; L1 = AdjL(:,1)';  L2 = AdjL(:,2)';
%AB = sparse(L1,L2,W,22,22); h = view(biograph(AB,[],'ShowWeights','on'));
%end

%--------------------------------------------------
% 3. Algorythm Optimiser avec les fonction de Matlab
%--------------------------------------------------
% Etape 1 - �tiquette faisables
%*************************************************
L = f_EtiquetesInitialsesFaisables(E);
%----%---
% representation graphique
h = f_viewGraph(E);
for i = 1:2*n
    if i < n+1
        h.Nodes(i).Label =...
            sprintf('%s:%d',h.Nodes(i).ID,L.y(i));
    else
        h.Nodes(i).Label =...
            sprintf('%s:%d',h.Nodes(i).ID,L.x(i-n));
    end
end
h.ShowTextInNodes = 'label';
%----%---

% Etape 2 - Matrice d'agalit�
%*************************************************
%Pour construire ML :
% on construit une matrice tels que M(x,y)= 1 <=> L(x)+L(y)=E(x,y)
% on multiplie terme � terme avec E pour r�cup�rer les coefficients
ML = (E==L.x*ones(1,size(E,1))+ones(size(E,1),1)*L.y) .* E;
%----%---
% representation graphique
h = f_viewGraph(ML);
for i = 1:2*n
    if i < n+1
        h.Nodes(i).Label =...
            sprintf('%s:%d',h.Nodes(i).ID,L.y(i));
    else
        h.Nodes(i).Label =...
            sprintf('%s:%d',h.Nodes(i).ID,L.x(i-n));
    end
end
h.ShowTextInNodes = 'label';
%----%---

% Etape 3 Ajout du puis et de la source
%*************************************************
% sommet 21 la source
% sommet 22 le puit
stML = [zeros(size(ML)) ML ; zeros(size(ML)) zeros(size(ML))]; %expantion de la matrice ML pour obtenir la matrice du graphe
% construction des vecteurs reliant la source au tachet et le puis au processeur
st = [ zeros(n,1) zeros(n,1) ;  zeros(n,1) ones(n,1)]; ts = [ ones(1,n) zeros(1,n) ; zeros(1,n)  zeros(1,n)];
stML = [ stML st ; ts zeros(2,2) ]; % assemblage de la matrice
%----%---
% representation graphique
h = view(biograph(stML,[],'ShowWeights','on'));
%----%---

% Etape 4 CouplageMax
%*************************************************
[M,F,K] = graphmaxflow(sparse(stML),21,22,'Method','Edmonds');
%----%---
% representation graphique
h = view(biograph(F,[],'ShowWeights','on'));
%----%---

% Etape 5 Determiner si le couplage est maximal
%*************************************************

%on regarde si tout les �l�ments sont bien pr�sent dans la liste des arr�tes
while ~isempty(find(ismember(1:GL.NbVertices,i)==0))
    % Etape 6 changement des �tiquettes
    r = find(ismember(1:GL.NbVertices,i)==0); % �l�ments qui font que C n'est pas parfait
    % Cr�ation du graphe GLO
    %F(2*n+1,:) = zeros(1,2*n+2); %suppression de la source
    %F(:,2*n+2) = zeros(2*n+2,1); %supprestion du puit
    [i_f,j_f,k_f] = find(F);[i_stML,j_stML,k_stML] = find(stML); %transformation des matices sparses
    f_LEdge = [i_f,j_f]; %liste des arr�tes de F
    stML_LEdge = [i_stML,j_stML]; %liste des arr�tes de stML
    
    GLO = [i_f,j_f,k_f]; % on commance GLO avec les �l�ments de F
    
    for i=1:size(i_stML,1) % pour chaque colonne de F
        %si [i_f,j_f,k_f](i) in [i_stML,j_stML,k_stML]
        if  sum(ismember(stML_LEdge(i,:),f_LEdge,'rows'))< 1
            % Pour construire GLO on ajoute � F des �l�ments de GL qui ne
            % sont pas dans F.
            % On invers i et j pour que les �l�ments qui ne sont pas dans C aillent de P a T
            if(i_stML(i)==2*n+1 || i_stML(i)==2*n+2 || j_stML(i)==2*n+1 || j_stML(i)==2*n+2)
                GLO = [ GLO ; [i_stML(i),j_stML(i),k_stML(i)]]; 
            else
                GLO = [ GLO ; [j_stML(i),i_stML(i),k_stML(i)]]; 
            end
        end
    end
    %----%---
    % representation graphique
        GLO_sp = sparse(GLO(:,1),GLO(:,2),GLO(:,3),2*n+2,2*n+2);
        g = view(biograph(GLO_sp,[],'ShowWeights','on'));
    %----%---
    order = graphtraverse(F,r(1),'Method','BFS');
    break
end

% graphshortestpath(DG,1,6)

%--------------------------------------------------
% 4. Verification avec un algoritme de professionelle
%--------------------------------------------------

% Transformation de la matrice des performance en matrice de co�t
B=E;
for i=1:n
    B(i,:) = - ( E(i,:) - max(E(i,:)));
end
assignment = munkres(B)