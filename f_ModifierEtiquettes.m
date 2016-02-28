function [L GLO X Y sommetNonAtteint B A] = f_ModifierEtiquettes(GL, C1, L)

GLO.NbVertices = GL.NbVertices;
GLO.NbEdges = 0;
GLO.Orientation = GL.Orientation;
GLO.AdjList = []
size(GLO.AdjList,1) = GL.NbVertices;

for i = 1:(GL.NbVertices/2)
    GLO.AdjList{i} = GL.AdjList{i};
end

for i = 1:size(C1,1)
    a=C1(i,2);
    b=C1(i,1);
    GLO.AdjList{a} = GLO.AdjList{a} + b;
end

% for i = (GL.NbVertices/2)+1:GL.NbVertices
%     GLO.AdjList{i} = (1:GL.NbVertices/2);
%     
%     for j = 1:(GL.NbVertices/2)
%         GLO.AdjList{i}(2,j) = 1;
%     end
% end


ListComp = [];

% for i = (GL.NbVertices/2)+1 : GL.NbVertices  % On fabrique le vecteur des nombres des processeurs pour ensuite le comperer aux processeurs pris en compte par C
%     ListComp = [ListComp i];
% end
 
 B = [1:GL.NbVertices ; ismember(1:GL.NbVertices,C)]; % A est la matrice de comparaison avec des 1 là aux indices des sommets 
 
 A = find(B(2,:)==0)
 
%  A = [1:(GL.NbVertices/2) ; ismember(ListComp,C(:,2))]; % A est la matrice de comparaison avec des 1 là aux indices des sommets 
%  
%  A = find(A(2,:)==0)+10
 
 
 
 [dist,prec, couleur] = f_BFS(GLO,A(1,1))
 
 %--- Tracer 
D1 = f_ListOfEdges(GLO)

W = D1(:,3)';
L1 =D1(:,1)';
L2=D1(:,2)';

D2 = sparse(L1,L2,W,20,20);

view(biograph(D2,[],'ShowWeights','on'))

%---- Répartition X Y
sommetNonAtteint = []
X = [];
Y = [];

for i = 1 : GLO.NbVertices
    
    if couleur(i)==2
        if i <= GLO.NbVertices/2
            Y = [Y,i];
        else
            X = [X,i];
        end
    else
        if i ~= A(1,1)
        sommetNonAtteint = [sommetNonAtteint, i];
        end
    end
      
end



end

