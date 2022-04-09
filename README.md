# Optical Character Recognition (OCR) with MATLAB

OCR was performed using Prinicpal Component Analysis (PCA) of handwritten digits from the MNIST database. Based on the weight of each image obtained, the Euclidean distance between the training set and test image was obtained. The lower the Euclidean distance the better.

## Usage

Change directory in MATLAB to the one containing `main.m`

`n` - The number of test images to predict

```MATLAB
>> main(n)
```

## Viewing the images

```MATLAB
>> viewImage(dataSet, startIndex, endIndex)
```

`dataSet` - Either "train" or "test" to view the images from the training and test set respectively
 
`startIndex` - Minimum: 1, must be less than or equal to `endIndex`

`endIndex` - Maximum: The number of images in the data set chosen, must be greater than or equal to `startIndex`

**Set output size**

By default, MATLAB will output 16 images per window (4 x 4)

To change this value, modify `FIG_WIDTH` in `viewImage.m` [line 27](viewImage.m/#L27) to the desired number of rows/columns.

**Visualising eigenvectors**

To visualise the eigenvectors of the images, we can convert them into eigenfaces. 

To do so, the `imageType` parameter of `viewImage()` must be set to "face". The parameter can be left blank to display the raw image.

```MATLAB
>> viewImage("train", 1, 16, "face");
```

## Acknowledgements

OCR was based on the algorithm from [algosome.com](https://www.algosome.com/articles/optical-character-recognition-java.html)

Credits to [the MNIST database](http://yann.lecun.com/exdb/mnist/) for [the processed data](MNIST/).

All code snippets used were referenced in comments where they were used in the code.

## Further Improvements

Current algorithm only outputs the digit with the lowest Euclidean distance (Accuracy = 34.89%). 
Possible to implement k-nearest neighbours by taking the most common digit among the k lowest Euclidean distances. 
Images can also be preprocessed to improve accuracy.
