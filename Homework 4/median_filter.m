%Import image
A = imread('original_image_problem_2.jpg');

%Create seperate matrix to duplicate and show image
B = zeros(size(A));

%Loop through interior pixels of image
for i = 2:size(A,1) - 2
    for j = 2:size(A,2)-2
        
        %Create the filter with zeros and counter
        filter = [0 0 0 0 0 0 0 0 0];
        count = 1;
        
        %Loop through the filter
        for x = 1:3
            for y = 1:3
                %Replace values of filter with those of the image
                filter(count) = A(i + x - 1, j + y - 1);
                count = count + 1;
            end
        end
        
        for a = 1: 50
            for b = 1:8
                if filter(b) > filter(b + 1)
                        temp = filter(b);
                        filter(b) = filter(b + 1);
                        filter(b + 1) = temp;
                end
            end
        end
        
        %Sort the filter to obtain median (index 5)
        B(i,j)=filter(5);
    end
end

%Convert image to uint8 and then display
C = uint8(B);
imshow(C);
