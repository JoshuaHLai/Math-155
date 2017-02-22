A = imread('image.jpg');

[M N] = size(A);

B = double(A);

for i = 1:M
    for j = 1:N
        d = (i - 1) + (j - 1);
        C(i,j) = B(i,j) * (-1)^d;
    end
end

fourier_transformation = fft2(C);

D = abs(fourier_transformation);

c=5; 
for i = 1:M
    for j = 1:N
        E(i,j) = c * log(1 + D(i,j));
    end
end

figure
image(E); colormap(gray);
composite_value = 0;
for i = 1:M
    for j = 1:N
        composite_value = composite_value + B(i,j);
    end
end

average_value = composite_value/(M * N);
