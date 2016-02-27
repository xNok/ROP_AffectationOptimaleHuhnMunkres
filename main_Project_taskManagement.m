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
%
% hypothesis :
% La graphe G est un graphe biparti complet, il peut donc �tre d�finit de
% mani�re unique par la matrice des performances E

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
% 2. Algorythm
%--------------------------------------------------
L = f_EtiquetesInitialsesFaisables(E);
GL = f_GrapheEgalite(E,L);
C = f_CouplageMax(GL);

%--------------------------------------------------
% 3. Algorythm Optimiser avec les fonction de Matlab
%--------------------------------------------------
h = f_viewGraph(E);

% Etape 1 - �tiquette faisables
L = f_EtiquetesInitialsesFaisables(E);
% Etape 2 - Matrice d'agalit�
    %Pour construire ML :
    % on construit une matrice tels que M(x,y)= 1 <=> L(x)+L(y)=E(x,y)
    % on multiplie terme � terme avec E pour r�cup�rer les coefficients
ML = (E==L.x*ones(1,size(E,1))+ones(size(E,1),1)*L.y) .* E;
h = f_viewGraph(ML);

% Etape 3 Ajout du puis et de la source
stML = [zeros(size(ML)) ML ; zeros(size(ML)) zeros(size(ML))]
st = [ zeros(n,1) zeros(n,1) ;  zeros(n,1) Inf*ones(n,1)]
ts = [ Inf*ones(1,n) zeros(1,n) ; zeros(1,n)  zeros(1,n)]
stML = [ stML st ; ts zeros(2,2) ]

h = view(biograph(stML,[],'ShowWeights','on'))

% Etape 4 CouplageMax
[M,F,K] = graphmaxflow(sparse(stML),21,22)
view(biograph(F,[],'ShowWeights','on'))
set(h.Nodes(K(1,:)),'Color',[1 0 0])


%--------------------------------------------------
% 3. Verification avec un algoritme de professionelle
%--------------------------------------------------

% Transformation de la matrice des performance en matrice de co�t
B=E;
for i=1:10 
    B(i,:) = - ( E(i,:) - max(E(i,:)));
end
assignment = munkres(B)

% ====== SUB Fonctions =======================








