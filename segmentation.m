function [ pupilX, pupilY, pupilR ] = segmentation( inputImage )

    Z=inputImage;
    meanFilter = fspecial('average', [5 5]);
    F = imfilter(Z, meanFilter);
    figure, imshow(F);

    I=edge(F,'sobel');
    figure,imshow(I);
    img=I;
    %figure,imshow(img);
    %title('Edge Detected and Binarized Image');
    
    [ pupilX, pupilY, pupilR ] = houghTransform( img );

end

