# Optical Character Recognition (OCR) with MATLAB

OCR was performed using Principle Component Analysis (PCA) of handwritten digits from the MNIST database. Based on the weight of each image obtained, the Euclidean distance between the training set and test image was obtained. The lower the Euclidean distance the better.

## Usage

Change directory in MATLAB to the one containing `main.m`

Modify `numTest` in `main.m` line 11 to change the number of data points to your desired value.

Execute `main.m` in MATLAB, with `OCR.m` and the `MNIST` folder in the same directory

## Acknowledgements

OCR was based on the algorithm from [algosome.com](https://www.algosome.com/articles/optical-character-recognition-java.html)

Credits to [the MNIST database](http://yann.lecun.com/exdb/mnist/) for the processed data. Files can also be found in `MNIST/`

All code snippets used were referenced in comments where they were used in the code.

## Further Improvements

Current algorithm only outputs the digit with the lowest Euclidean distance (Accuracy = 34.98%). Possible to implement k-nearest neighbours by taking the most common digit among the k lowest Euclidean distances.
