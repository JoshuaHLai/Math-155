A = imread('image.jpg');

[M N] = size(A); 

B=double(A);

% multiply f by (-1)^(x+y) to shift the center 
for i = 1:M
   for j = 1:N
         d = (i - 1) + (j - 1);
         C(i,j) = B(i,j)*(-1)^d;
   end
end

% compute the DFT of f*(-1)^{x+y} 
D=fft2(C);

%Create filter
for u = 1:M
    for v = 1:N
        P = (u - ((2 * M - 1) / 2))^2;
        Q = (v - ((2 * N - 1) / 2))^2;
        H(u,v) = exp(-(P + Q) / 1250);
    end
end

%Apply filter to image
for i = 1:M
    for j = 1:N
        E(i,j) = D(i,j).*H(u,v);
    end
end

%Use inverse Fourier transformation
F = ifft2(E);

imshow(F);
