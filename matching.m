function [ result, n1, n2 ] = matching( template, data )

    A=xor(template,data);
    
    n1=length(A(A==1));
    n2=length(A(A==0));
    
    result=n1/n2;


end

