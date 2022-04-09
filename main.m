function main(n)
    import OCR.*;
    ocr = OCR();
    
    %Importing the dataset
    trainImages = ocr.loadMNISTImages(ocr.getPath("TRI"));
    trainLabels =  ocr.loadMNISTLabels(ocr.getPath("TRL"));
    testImages = ocr.loadMNISTImages(ocr.getPath("TEI"));
    testLabels = ocr.loadMNISTLabels(ocr.getPath("TEL"));

    [~, colsTest] = size(testImages);
    if n < 1 || n > colsTest
        fprintf("Invalid input n!\n")
        fprintf("Please enter a value from 1 to %li\n", colsTest);
        return;
    end
    
    %Pre-calculate weight of all images in training set
    trainWeights = ocr.calcTrainWeights(trainImages);
    numCorrect = 0;
    
    for i = 1:n
        image = ocr.toMatrix(testImages, i);
        label = testLabels(i);
        prediction = ocr.findMinEuclidean(trainWeights, trainLabels, image);
        fprintf("Image Number: %i, Predicted Number: %i\n", label, prediction);
        if label == prediction
            numCorrect = numCorrect + 1;
        end
    end
    
    fprintf("Accuracy: %.2f%%\n", numCorrect / n * 100);
end
