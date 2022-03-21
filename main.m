function main()
    import OCR.*;
    ocr = OCR();
    
    %Importing the dataset
    trainImages = ocr.loadMNISTImages(ocr.getPath("TRI"));
    trainLabels =  ocr.loadMNISTLabels(ocr.getPath("TRL"));
    testImages = ocr.loadMNISTImages(ocr.getPath("TEI"));
    testLabels = ocr.loadMNISTLabels(ocr.getPath("TEL"));
    
    %Pre-calculate weight of all images in training set
    trainWeights = ocr.calcTrainWeights(trainImages);
    numTest = 10000;
    numCorrect = 0;
    
    for i = 1:numTest
        image = ocr.toMatrix(testImages, i);
        label = testLabels(i);
        prediction = ocr.findMinEuclidean(trainImages, trainLabels, image, trainWeights);
        fprintf("Image Number: %i, Predicted Number: %i\n", label, prediction);
        if label == prediction
            numCorrect = numCorrect + 1;
        end
    end
    
    fprintf("Accuracy: %.2f%%\n", numCorrect / numTest * 100);
end
