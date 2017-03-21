original_image = imread('Fig5.08(b).jpg');
original_image_double = im2double(original_image);

%Create seperate matrix to duplicate and show image
B = zeros(size(original_image_double));

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
        
        value_1 = 0;
        value_2 = 0;
        for a = 1:9
            value_1 = (value_1 + filter(a)) ^ 0.5;
            value_2 = (value_2 + filter(a)) ^ (-1.5);
        end
            
        final_value = value_1 / value_2;
        
        B(i,j) = final_value;

    end
end

%Convert image to uint8 and then display
imshow(B); title('Contraharmonic Filter (Q = 0.5)');