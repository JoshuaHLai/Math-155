%Import image
importImage = imread('Homework_1.jpg');

%Obtain histogram of raw imported image
%Find the size of the image
[M N] = size(importImage);

%Create separate array for image histogram
vector = zeros(256, 1);

for i = 0:255
    for j = 1:M
        for k = 1:N
            if i == importImage(j, k)
                vector(i + 1) = vector(i + 1) + 1;
            end
        end
    end
end

figure, plot(vector), title('Imported Image (Non-Equalized)');
xlabel('Gray Level');
ylabel('# of Pixels');

%End of obtaining histogram of raw imported image

%Apply histogram equalization
transition = vector/numel(importImage);

cSum = cumsum(transition);
histogram_eq = cSum(importImage + 1);
histogram_eq = uint8(histogram_eq * 255);

figure, plot(histogram_eq), title('Imported Image Transform');

%End of applying histogram equalization
