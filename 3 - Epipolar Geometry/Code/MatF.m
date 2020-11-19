function F=MatF(X1,X2)
% p1,p2 : vectors of coordinates ...x...

% initialisation
A = [];

% Write a martix of homogeneous linear system Af=0
% ---> TODO <---
% X2(3,:) = ones(1,8);
% X1(3,:) = ones(1,8);
% transp2 = X2.';
% temp = zeros(0,9);
% for i = 1:8
% temp = X1(:,i).*transp2(i,:);
% A(i,:) = temp(:);
% end  


for i = 1:8
  A(i,:) = [X1(1,i)*X2(1,i); X1(2,i)*X2(1,i); X2(1,i); X1(1,i)*X2(2,i); X1(2,i)*X2(2,i); X2(2,i); X1(1,i); X1(2,i); 1];
end
% Solving the linear system for the estimate of F by SVD
% Ist step: Linear solution
[U,S,V] = svd(A)
Fest = reshape(V(:,end),3,3)

% 2nd step: Constraint enforcement
Fest=Fest';
[U,S,V] = svd(Fest);
F = U*diag([S(1,1) S(2,2) 0])*V';
