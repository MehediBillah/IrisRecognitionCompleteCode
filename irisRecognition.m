clc;
%Reading image and the convert to binary image.

inputImage=imread('img/1.bmp');
[ pupilX, pupilY, pupilR ] = segmentation( inputImage );


%[ pupilX, pupilY, pupilR ] = houghTransform( img );

[ X, Y ] = drawCircle( pupilX, pupilY, pupilR );
[ X2, Y2, R2 ] = irisOuter( pupilX, pupilY, pupilR, inputImage );
figure, imshow(inputImage);
hold on;
plot(X, Y);
plot(X2, Y2);
hold off;

inputImage=double(inputImage)/255.0;
image = rubberSheetNormalisation( inputImage, pupilY, pupilX, pupilR, R2,  240, 60);
figure,imshow(image);


template = encode(image);
figure,imshow(template);



