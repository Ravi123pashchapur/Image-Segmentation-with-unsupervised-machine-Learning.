function outputImage1 = Pix(s)

     A = s;
    [L1,N1] = superpixels(A,5000);
    
    outputImage1 = zeros(size(A),'like',A);
    idx1 = label2idx(L1);
    numRows1 = size(A,1);
    numCols1 = size(A,2);
    for labelVal1 = 1:N1
        redIdx1 = idx1{labelVal1};
        greenIdx1 = idx1{labelVal1}+numRows1*numCols1;
        blueIdx1 = idx1{labelVal1}+2*numRows1*numCols1;
        outputImage1(redIdx1) = mean(A(redIdx1));
        outputImage1(greenIdx1) = mean(A(greenIdx1));
        outputImage1(blueIdx1) = mean(A(blueIdx1));
    end
end