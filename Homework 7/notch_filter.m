original_image = imread('image.jpg');
original_image_double = im2double(original_image);

[M, N] = size(original_image_double);

A = input('Amplitude:');
frequency1 = input('Frequency 1:');
frequency2 = input('Frequency 2:');

for i = 1:M
    for j = 1:N
        noise(i,j) = A * sin(2 * pi * frequency1 * i + 2 * pi * frequency2 * j);
    end
end

for k = 1:M
    for l = 1:N
        B(k,l) = original_image_double(k,l) + noise(k,l);
    end
end

imshow(B); title('Degraded Image');

for i = 1:M
    for j = 1:N
        d = (i-1) + (j - 1);
        shift(i,j) = B(i,j)*(-1)^d;
    end
end

fourier_transform = fft2(shift);
spectrum = abs(fourier_transform);

for i = 1:M
    for j = 1:N
        plot_spectrum(i,j) = 5 * log(1 + spectrum(i,j));
    end
end

fourier_transform2 = fftshift(fft2(original_image));
norm_img = @(img) (img - min(img(:))) / (max(img(:)) - min(img(:)));
gNotch = @(v,mu,cov) 1-exp(-0.5*sum((bsxfun(@minus,v,mu).*(cov\bsxfun(@minus,v,mu)))));
center_x = 129;
center_y = 129;

% distance of noise from center
wx1 = 149.5-129;
wx2 = 165.5-129;
wy  = 157.5-129;

% create notch filter
notch_filt = ones(M,N);

[y,x] = meshgrid(1:N, 1:M);
X = [y(:) x(:)].';
notch_filt = notch_filt .* reshape(gNotch(X,[center_x+wx1;center_y+wy],eye(2)*25),[M,N]);
notch_filt = notch_filt .* reshape(gNotch(X,[center_x+wx2;center_y+wy],eye(2)*25),[M,N]);
notch_filt = notch_filt .* reshape(gNotch(X,[center_x-wx1;center_y-wy],eye(2)*25),[M,N]);
notch_filt = notch_filt .* reshape(gNotch(X,[center_x-wx2;center_y-wy],eye(2)*25),[M,N]);

% apply filter
fourier_transform2 = fourier_transform2 .* notch_filt;
% compute inverse
ifft_ = ifft2(ifftshift(fourier_transform2));
restored_image = histeq(norm_img(ifft_));

figure();
imshow(restored_image); title('Restored Image');