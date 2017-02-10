%Import image
A = im2double(imread('original_image_problem_3.jpg'));

%Hard-code Laplacian filter
laplacian_filter = [-1 -1 -1 ; -1 9 -1 ; -1 -1 -1];

%Create dummy matrix to hold output image
B = zeros(size(A));

%Loop through image
for i = 2:size(A,1)-1
    for j = 2:size(A,2)-1
        
        %Apply filter to pixels
        temp = A(i-1:i+1,j-1:j+1) .* laplacian_filter;
        
        %Store filtered pixels in new matrix
        B(i,j) = sum(temp(:));
    end
end

imshow(B);


% linear filtering linera spatial filtering
% smoothing mask
% sharpening laplacian

% f(x+1,y) + f(x-1,y) + f(x,y+1) + f(x,y-1) - 4f(x,y)