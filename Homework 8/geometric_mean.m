original_image = imread('Fig5.07(b).jpg');
original_image_double = im2double(original_image);

%Create seperate matrix to duplicate and show image
B = zeros(size(original_image_double));
[M N] = size(original_image_double);

%Loop through internior pixels of image
for i = 2:size(original_image_double,1) - 2
    for j = 2:size(original_image_double,2)-2
        
        %Create the filter with zeros and counter
        filter = [0 0 0 0 0 0 0 0 0];
        count = 1;
        
        %Loop through the filter
        for x = 1:3
            for y = 1:3
                %Replace values of filter with those of the image
                filter(count) = original_image_double(i + x - 1, j + y - 1);
                count = count + 1;
            end
        end
        
        value = 1;
        for a = 1:9
            value = value * filter(a);
        end
        
        value = (value)^(1/9);
        
        B(i,j) = value;

    end
end

SNR_value = 0;
SNR_value_original = 0;
for i = 1:M
    for j = 1:N
        SNR_value = SNR_value + (B(i,j) ^ 2);
        SNR_value_original = SNR_value_original + ((original_image_double(i,j) - B(i,j)) ^ 2);
    end
end

SNR_final = 10 * log10(SNR_value / SNR_value_original);
%Convert image to uint8 and then display
imshow(B); title('Geometric Mean Filter');