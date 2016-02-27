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
n = size(E);

%--------------------------------------------------
% 2. Algorythm
%--------------------------------------------------
L = f_EtiquetesInitialsesFaisables(E);
GL = f_GrapheEgalite(E,L);
C = f_CouplageMax(GL);

%--------------------------------------------------
% 3. Verification avec un algoritme de professionelle
%--------------------------------------------------

% Transformation de la matrice des performance en matrice de coût
B=E;
for i=1:10 
    B(i,:) = - ( E(i,:) - max(E(i,:)));
end


assignment = munkres(B)







