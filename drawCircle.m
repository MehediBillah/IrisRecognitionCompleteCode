function [ X, Y ] = drawCircle( A, B, R )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    th = 0:pi/50:2*pi;
    X = R * cos(th) + A;
    Y = R * sin(th) + B;

end