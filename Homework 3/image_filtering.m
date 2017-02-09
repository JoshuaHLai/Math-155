%Import image
original_image = imread('original_image.jpg');

%Use built-in functions to filter image
image_filtered_1 = conv2(double(original_image), 1/9 * [1 1 1; 1 1 1; 1 1 1], 'same');
image_filtered_2 = filter2(1/9 * [1 1 1;1 1 1;1 1 1], double(original_image));
image_filtered_3 = imfilter(original_image, 1/9 * [1 1 1; 1 1 1; 1 1 1]);

%Display filtered image
imshow(uint8(image_filtered_1));
imshow(uint8(image_filtered_2));
imshow(uint8(image_filtered_3));
