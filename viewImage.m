function viewImage(dataSet, startIndex, endIndex, imageType)
    arguments
        dataSet string;
        startIndex int32;
        endIndex int32;
        imageType string = "raw";
    end
    
    %Check if input index is valid
    if startIndex <= 0 || endIndex <= 0
        fprintf("Error: Invalid input. Input indices must be positive\n");
        return;
    end
    if startIndex > endIndex
        fprintf("Error: Invalid input. End must be greater than or equal to start.\n");
        return;
    end
    if imageType ~= "raw" && imageType ~= "face"
        fprintf("Error: Invalid input. Image type must either be 'raw' (default) or 'face'\n");
        return;
    end
    
    import OCR.*;
    ocr = OCR();
    
    %Set size of canvas to display images
    FIG_WIDTH = 4;
    FIG_SIZE = FIG_WIDTH * FIG_WIDTH;
            
    %Get path to data set
    switch dataSet
        case "train"
            path = ocr.getPath("TRI");
        case "test"
            path = ocr.getPath("TEI");
        otherwise
            fprintf("Error: Invalid data set '%s', enter either 'train' or 'test'\n", dataSet); 
            return;
    end
    
    images = ocr.loadMNISTImages(path);
    [~, numImages] = size(images);
    
    %Check if input index is valid
    if endIndex > numImages
        fprintf("Error: End index is greater than number of images.\n");
        return;
    end
    
    n = endIndex - startIndex + 1;
    nFigures = ceil(n / FIG_SIZE);
    
    if nFigures > 4
        prompt = "Warning: Are you sure you want to display " + n + " images in " + nFigures + " windows? (y/n) ";
        txt = input(prompt, "s");
        
        switch txt
            case "y"
                fprintf("Continuing execution.\n");
            case "n"
                fprintf("Exiting.\n");
                return;
            otherwise
                fprintf("Invalid input!\n");
                return;
        end
    end
    
    rem = mod(n, FIG_SIZE);
    for i = 1:nFigures
        figure;
        colormap gray;
        for j = 1:FIG_SIZE
            %If n is less than k * FIG_SIZE
            if i == nFigures && rem ~= 0 && j > rem 
                break
            end
            
            if FIG_WIDTH ~= 1
                subplot(FIG_WIDTH, FIG_WIDTH, j);
            end
            
            image = ocr.toMatrix(images, startIndex + ((i - 1) * FIG_SIZE + j - 1));
            
            if imageType == "face"
                C = cov(image); %Calculate covariance matrix
                [V, ~] = eig(C); %Perform Eigen Decomposition
                
                %Normalise each eigenvector to pixel values (0-255)
                normV = V - min(V(:));
                normV = 255 * normV ./ max(normV(:));
                imagesc(normV)
            else
                imagesc(image);
            end
        end
    end    
end
