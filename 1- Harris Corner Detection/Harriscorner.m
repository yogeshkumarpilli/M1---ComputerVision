clc
I=imread('chessboard00.png');
I = im2double(I);
% PART 1 - Construct necessary form of images

[ix,iy] =imgradientxy(I);
%  subplot(221);imshow(ix) 
%  subplot(222);imshow(iy)

%gaussian filter
sigma =2;
size = 9;
filter = fspecial("gaussian",[9 9],2);
gauss = imfilter(ix,filter);

G_Ix2 = imfilter(ix.*ix,filter);
G_Iy2 = imfilter(iy.*iy,filter);
G_Ixy = imfilter(ix.*iy,filter);
%  subplot(221);imshow(G_Ix2)
%   subplot(222);imshow(G_Iy2)
%  subplot(223);imshow(G_Ixy)

% PART 2 - Compute Matrix E which contains for every point the value  

E= zeros(253,250);
R = zeros(253,250);
for i = 2:1:252;
    for j = 2:1:249;
        mxx = sum(sum(G_Ix2(i-1:i+1,j-1:j+1)));
        mxy = sum(sum(G_Ixy(i-1:i+1,j-1:j+1)));
        myy = sum(sum(G_Iy2(i-1:i+1,j-1:j+1)));
    M = [mxx mxy; mxy myy];
    V = eig(M);
    E(i,j) = min(V);
    R(i,j) = det(M)- 0.04*(trace(M)^2);
    end
end
        
%  imshow(E)

% PART 3 - Compute Matrix R which contains for every point the cornerness score
% figure, imshow(mat2gray(R));

% PART 4 - Select for E and R the 81 most salient points.
R1 = ordfilt2(R,11*11,ones(11));
R2 =(R1==R) & (R>10);
[sortR2,Index] = sort(R2(:),'descend');
[X, Y] = ind2sub([253 250],Index);
figure; imshow(I); hold on; xlabel('Max 81 points');     
for i=1:81 
	plot(X(i), Y(i), 'r+'); 
end
hold off













