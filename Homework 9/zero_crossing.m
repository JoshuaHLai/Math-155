original_image = imread('Fig10.15a.jpg');
new_image = edge(original_image, 'zerocross');
imshow(new_image); title('Zero-Crossing of Image');