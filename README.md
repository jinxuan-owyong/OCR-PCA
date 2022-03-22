# Optical Character Recognition (OCR) with MATLAB

OCR was performed using Principle Component Analysis (PCA) of handwritten digits from the MNIST database. Based on the weight of each image obtained, the Euclidean distance between the training set and test image was obtained. The lower the Euclidean distance the better.

## Usage

Change directory in MATLAB to the one containing `main.m`

Modify `numTest` in `main.m` line 11 to change the number of data points to your desired value.

Execute `main.m` in MATLAB, with `OCR.m` and the `MNIST` folder in the same directory

## Viewing the images

`>> viewImage(dataSet, startIndex, endIndex)`

`dataSet` - Either "train" or "test" to view the images from the training and test set respectively
 
`startIndex` - Minimum: 1, must be less than or equal to `endIndex`

`endIndex` - Maximum: The number of images in the data set chosen, must be greater than or equal to `startIndex`

**Set output size**

By default, MATLAB will output 16 images per window (4 x 4)

To change this value, modify `FIG_WIDTH` in `viewImage.m` line 16 to the desired number of rows/columns.

**Visualising eigenvectors**

To visualise the eigenvectors of the images, we can convert them into eigenfaces. 

To do so, the `imageType` parameter of `viewImage()` must be set to "face". The parameter can be left blank if 

`>> viewImage("train", 1, 16, "face");`

## Acknowledgements

OCR was based on the algorithm from [algosome.com](https://www.algosome.com/articles/optical-character-recognition-java.html)

Credits to [the MNIST database](http://yann.lecun.com/exdb/mnist/) for the processed data. Files can also be found in `MNIST/`

All code snippets used were referenced in comments where they were used in the code.

## Further Improvements

Current algorithm only outputs the digit with the lowest Euclidean distance (Accuracy = 34.98%). Possible to implement k-nearest neighbours by taking the most common digit among the k lowest Euclidean distances.
