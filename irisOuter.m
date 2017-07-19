function [ X2, Y2, R2 ] = irisOuter( pupilX, pupilY, pupilR, Z )
    irisX=pupilX;
    irisY=pupilY;
    %irisR=pupilR+70; %For CASIA IRIS image database version 1.0
    
E2=edge(Z,'canny');
figure,imshow(E2);

tMax=75;
tMin=40;

J = imcrop(E2,[pupilX-pupilR-tMax, pupilY-20, tMin, tMin]);
figure, imshow(J);
[r,c]=find(J);
rm1=median(r);


J2 = imcrop(E2,[pupilX+pupilR+tMin, pupilY-20, tMin, tMin]);
figure, imshow(J2);
[r, c]=find(J2);
rm2=median(r);

if isnumeric(rm1) && isnumeric(rm2),
    addR=(rm1+rm2)/2;
end

if isnan(rm1),
    addR=rm2;
end

if isnan(rm2),
    addR=rm1;
end
irisR=pupilR+40+addR;
[X2, Y2]=drawCircle( irisX,irisY,irisR );
    R2=irisR;

end

