% Main program for the ROP Project : Task Management
% Authors : Alexandre Couedelo, Flavien Isidore
%
% Problem :
% Soit n tâches à réaliser et n machines pour les réaliser.
% Connaissant A(i,j) la perfommance de réalisation de la tâche Ti par le processeur la Pj
% On cherche l'affectation conduissant à la performance total maximum 
%
% Resources :
% Fondamentaux de Recherche Opérationnelle, EMA, Stephane Janaqi
% cours.ensem.inpl-nancy.fr/cours-dm/graphes/Graphes.pdf
% https://en.wikipedia.org/wiki/Hungarian_algorithm
% https://wikimpri.dptinfo.ens-cachan.fr/lib/exe/fetch.php?media=cours:upload:2-24-1-kuhn-munkres.pdf
% http://fr.slideshare.net/binnasser2007/kuhn-munkres-algorithm
%
% hypothesis :
% La graphe G est un graphe biparti complet, il peut donc être définit de
% manière unique par la matrice des performances E

%--------------------------------------------------
% 0. Nettoyage
%--------------------------------------------------
clear all, close all, clc


%--------------------------------------------------
% 1. Laod Matrix
%--------------------------------------------------
path = 'D:\03-Ecole\2A\ROP\Projet_AC_FI\';
filename = strcat(path , 'M10.txt');
E = importdata(filename);
n = size(E,1);

%--------------------------------------------------
%2. Algorythm
%--------------------------------------------------
L = f_EtiquetesInitialsesFaisables(E);
GL = f_GrapheEgalite(E,L);
[C AB C2] = f_CouplageMax(GL);
%while
    [L GLO X Y sommetNonAtteint B A]= f_ModifierEtiquettes(GL,C2,L)
    GL = f_GrapheEgalite(E,L);
    [C AB C2] = f_CouplageMax(GL);
%end

%--------------------------------------------------
% 3. Algorythm Optimiser avec les fonction de Matlab
%--------------------------------------------------
%*************************************************
% Etape 1 - Étiquette faisables
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

%*************************************************
% Etape 2 - Matrice d'agalité
%*************************************************
%Pour construire ML :
% on construit une matrice tels que M(x,y)= 1 <=> L(x)+L(y)=E(x,y)
% on multiplie terme à terme avec E pour récupérer les coefficients
ML = f_MatriceEgalite(E,L)
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

%*************************************************
% Etape 3 CouplageMax
%*************************************************
[M,F,K] = f_CouplageEdmonds(ML)
%----%---
% representation graphique
h = view(biograph(F,[],'ShowWeights','on'));
%----%---

%*************************************************
% Etape 4 Determiner si le couplage est maximal
%*************************************************
%on regarde si tout les éléments sont bien présent dans la liste des arrètes
while ~isempty(find(ismember(1:GL.NbVertices,i)==0))
    %*************************************************
    % Etape 6 changement des étiquettes
    %*************************************************
    
    break
end

% graphshortestpath(DG,1,6)

%--------------------------------------------------
% 4. Verification avec un algoritme de professionelle
%--------------------------------------------------

% Transformation de la matrice des performance en matrice de coût
B=E;
for i=1:n
    B(i,:) = - ( E(i,:) - max(E(i,:)));
end
assignment = munkres(B)










