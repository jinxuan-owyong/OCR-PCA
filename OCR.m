classdef OCR
    % to load images/labels
    % images = OCR.loadMNISTImages(OCR.getPath("TRI"))
    properties (Access = private)
        TRAIN_IMAGE = "\\MNIST\\train-images.idx3-ubyte"
        TRAIN_LABEL = "\\MNIST\\train-labels.idx1-ubyte"
        TEST_IMAGE = "\\MNIST\\t10k-images.idx3-ubyte"
        TEST_LABEL = "\\MNIST\\t10k-labels.idx1-ubyte"
        IMAGE_SIZE = [28, 28];
        IMAGE_HEIGHT = 28;
        i = 1;
    end
 
    methods
        function path = getPath(obj, p)
            path = strrep(pwd, "\", "\\");
            switch p
                case "TRI"
                    path = strcat(path, obj.TRAIN_IMAGE);
                case "TRL"
                    path = strcat(path, obj.TRAIN_LABEL);
                case "TEI"
                    path = strcat(path, obj.TEST_IMAGE);
                case "TEL"
                    path = strcat(path, obj.TEST_LABEL);
            end
        end    
        
        function images = loadMNISTImages(~, filename)
            %Reference: https://github.com/davidstutz/matlab-mnist-two-layer-perceptron/blob/master/loadMNISTImages.m    
            %loadMNISTImages returns a 28x28x[number of MNIST images] matrix containing
            %the raw MNIST images
            fprintf("File path: ")
            fprintf(strcat(filename, "\n"))
            fp = fopen(filename, 'rb');
            assert(fp ~= -1, ['Could not open ', filename, '']);

            magic = fread(fp, 1, 'int32', 0, 'ieee-be');
            assert(magic == 2051, ['Bad magic number in ', filename, '']);

            numImages = fread(fp, 1, 'int32', 0, 'ieee-be');
            numRows = fread(fp, 1, 'int32', 0, 'ieee-be');
            numCols = fread(fp, 1, 'int32', 0, 'ieee-be');

            images = fread(fp, inf, 'unsigned char');
            images = reshape(images, numCols, numRows, numImages);
            images = permute(images,[2 1 3]);

            fclose(fp);

            % Reshape to #pixels x #examples
            images = reshape(images, size(images, 1) * size(images, 2), size(images, 3));
            % Convert to double and rescale to [0,1]
            images = double(images) / 255;
        end       
        
        function labels = loadMNISTLabels(~, filename)
            % Reference: https://github.com/davidstutz/matlab-mnist-two-layer-perceptron/blob/master/loadMNISTLabels.m
            %loadMNISTLabels returns a [number of MNIST images]x1 matrix containing
            %the labels for the MNIST images

            fprintf("File path: ")
            fprintf(strcat(filename, "\n"))
            fp = fopen(filename, 'rb');
            assert(fp ~= -1, ['Could not open ', filename, '']);

            magic = fread(fp, 1, 'int32', 0, 'ieee-be');
            assert(magic == 2049, ['Bad magic number in ', filename, '']);

            numLabels = fread(fp, 1, 'int32', 0, 'ieee-be');

            labels = fread(fp, inf, 'unsigned char');

            assert(size(labels,1) == numLabels, 'Mismatch in label count');

            fclose(fp);

        end
        
        function M = toMatrix(obj, image_data, col)
           img = image_data(:, col);
           M = reshape(img, obj.IMAGE_SIZE);
        end
        
        function weight = calcImageWeight(~, M)
            %Calculate covariance matrix
            C = cov(M);

            %Perform Eigen Decomposition
            [V, ~] = eig(C);

            %Normalise each eigenvector to pixel values (0-255)
%             normV = V - min(V(:));
%             normV = 255 * normV ./ max(normV(:));

            %Calculate the mean centered matrix of the input image
            mean_M = bsxfun(@minus, M, mean(M));

            %Calculate the image weight 
            weight = dot(V, mean_M);
        end
        
        function trainWeights = calcTrainWeights(obj, trainImages)
            [~, TW] = size(trainImages);
            %Initialise empty matrix
            trainWeights = zeros(obj.IMAGE_HEIGHT, TW);
            for j = 1:TW
                trainImage = obj.toMatrix(trainImages, j);
                trainWeight = obj.calcImageWeight(trainImage);
                trainWeights(:, j) = trainWeight';           
            end
        end
        
        function prediction = findMinEuclidean(obj, trainImages, trainLabels, testImage, trainWeights)
            [~, cols] = size(trainImages);
            testWeight = (obj.calcImageWeight(testImage))';
                        
            %Calculate Euclidean distance between first image and test image
            bestE = norm(testWeight - trainWeights(:, 1));
            bestLabel = trainLabels(1, :);
            
            for j = 2:cols
                newE = norm(testWeight - trainWeights(:, j));
                
                %Replace if lower Euclidean distance
                if newE < bestE
                    bestE = newE;
                    bestLabel = trainLabels(j, :);
                end
            end
            
            prediction = bestLabel;
        end
     end
end 	