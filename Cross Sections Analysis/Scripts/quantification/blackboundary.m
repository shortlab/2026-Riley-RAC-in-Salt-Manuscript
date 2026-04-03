% Takes ""_binarized_edited.tiff image files, which removes all corrosion
% artifacts from the binarized cross sections, to determine a sample
% boundary for depth normalization.

image = im2double(cdata);
height1 = height(image);
width1 = width(image);
black_boundary = zeros(height1,1);

for i = 1:height1
    for j = 1:width1
        if cdata(i,j) == 0
            black_boundary(i) = j;
            break
        end
    end
end