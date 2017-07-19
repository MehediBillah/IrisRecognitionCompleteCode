function [ pupilX, pupilY, pupilR ] = houghTransform( img )

    %hough transform
    I=double(img);
    [y,x]=find(I);
    [r,c]=size(I);
    
%Find all the require information for the transformatin. the 'totalpix' is the numbers of '1' in the image.
    totalpix = length(x);

%Preallocate memory for the Hough Matrix. 
    HM = zeros(r,c,70);
    R = 1:70;
    R2 = R.^2;
    sz = r*c;

%Performing Hough Transform. This portion of codes will map the original image to the a-b domain.

    for i = 1:totalpix
        for cntR = 1:70
            b = 1:r;
            a = (round(x(i) - sqrt(R2(cntR) - (y(i) - [1:r]).^2)));
            b = b(imag(a)==0 & real(a)>0);
            a = a(imag(a)==0 & real(a)>0);
            ind = sub2ind([r,c],b,a); %returns the linear index equivalents to the row and column subscripts 
            HM(sz*(cntR-1)+ind) = HM(sz*(cntR-1)+ind) + 1;
        end
    end


%Find for the maximum value for each layer, or in other words, the layer with maximum value will indicate the correspond R for the circle.
    for i = 1:70
        H(i) = max(max(HM(:,:,i)));
    end

%Extract the information from the layer with maximum value, and overlap with the original image.

    [maxval, maxind] = max(H);
    [B,A] = find(HM(:,:,maxind)==maxval);
    R=maxind;
    
    pupilX=A;
    pupilY=B;
    pupilR=R;

end

