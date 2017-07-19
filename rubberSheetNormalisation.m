function image = rubberSheetNormalisation( img, xPosPupil, yPosPupil, rPupil , rIris , varargin)
%rubberSheetNormalisation, function that normalizes the iris region. 
    % parse input
    xPosIris=xPosPupil;
    yPosIris=yPosPupil;
    p = inputParser();
    addRequired( p , 'xPosPupil' , @isnumeric );
    addRequired( p , 'yPosPupil' , @isnumeric );
    addRequired( p , 'rPupil' , @isnumeric );
    addRequired( p , 'xPosIris' , @isnumeric );
    addRequired( p , 'yPosIris' , @isnumeric );
    addRequired( p , 'rIris' , @isnumeric );
    addOptional( p , 'AngleSamples', 360 ,@isnumeric );
    addOptional( p , 'RadiusSamples',@isnumeric );
    parse( p , xPosPupil, yPosPupil, rPupil , xPosIris , yPosIris , rIris , varargin{:} )
    
    xp = p.Results.xPosPupil;
    yp = p.Results.yPosPupil;
    rp = p.Results.rPupil;
    xi = p.Results.xPosIris;
    yi = p.Results.yPosIris;
    ri = p.Results.rIris;
    angleSamples = p.Results.AngleSamples;
    RadiusSamples = p.Results.RadiusSamples;
    
    % Initialize samples 
    angles = (0:pi/angleSamples:pi-pi/angleSamples) + pi/(2*angleSamples);%avoiding infinite slope
    r = 0:1/RadiusSamples:1;
    nAngles = length(angles);
    
    % Calculate pupil points and iris points that are on the same line
    x1 = ones(size(angles)).*xi;
    y1 = ones(size(angles)).*yi;
    x2 = xi + 10*sin(angles);
    y2 = yi + 10*cos(angles);
    dx = x2 - x1;
    dy = y2 - y1;
    slope = dy./dx;
    intercept = yi - xi .* slope;
    
    xout = zeros(nAngles,2);
    yout = zeros(nAngles,2);
    for i = 1:nAngles
        [xout(i,:),yout(i,:)] = linecirc(slope(i),intercept(i),xp,yp,rp);
    end
       
    % Get samples on limbus boundary
    xRightIris = yi + ri * cos(angles);
    yRightIris = xi + ri * sin(angles);
    xLeftIris = yi - ri * cos(angles);
    yLeftIris = xi - ri * sin(angles);
    
    
    % Get samples in radius direction
    xrt = (1-r)' * xout(:,1)' + r' * yRightIris;
    yrt = (1-r)' * yout(:,1)' + r' * xRightIris;
    xlt = (1-r)' * xout(:,2)' + r' * yLeftIris;
    ylt = (1-r)' * yout(:,2)' + r' * xLeftIris;
    
    % Create Normalized Iris Image
    image = vec2mat(interp2(double(img),[yrt(:);ylt(:)],[xrt(:);xlt(:)]),length(r))';
        
end