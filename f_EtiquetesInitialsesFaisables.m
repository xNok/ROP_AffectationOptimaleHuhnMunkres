function [ L ] = f_EtiquetesInitialsesFaisables( E )
%F_ETIQUETESINITIALSESFAISABLES donne un �tiquetage faisable
%   L(x) = max(E(x,y)|y in N(x)}, L(y)=0

L.x = max(E,[],2); % o(n)
L.y = zeros(1, size(E,1)); % o(n)

end

