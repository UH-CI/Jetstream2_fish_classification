# Fish Image Classification with Using Simple ANN Architecture

**This project aims to classify images of various fish species using a basic Artificial Neural Network (ANN) model. The task involves processing image data as input, applying appropriate preprocessing steps, and developing a model to accurately predict the fish species from the images. While advanced techniques like Convolutional Neural Networks (CNNs) and transfer learning (ResNet, EfficientNet, MobileNet) could be employed, the focus of this study is to evaluate the effectiveness of image classification using a simple ANN architecture.** 

**Notes**

**Although the dataset information was provided, I approached it as if the images were scraped from the internet and processed the data with that in mind. Therefore, methods like smart cropping and image clustering, which are not necessary for this dataset, were applied for demonstration purposes.**

**All helper functions used in this study are thoroughly documented in the corresponding docstrings.**

**During the model training process, the `Training Device: GPU P100` provided by Kaggle was utilized to accelerate computation and improve training efficiency.**

**If you don't want to wait for the model training, I have uploaded the trained model to the Kaggle environment (`fish_classification_ann_model`). In section 4, activate the related command line.**

```
model = load_model("/kaggle/working/models/best_model.keras")
# model = load_model("/kaggle/input/fish_classification_ann_model/keras/default/1/best_model.keras")
```

**Technologies Used:**

- **Programming Language:** Python

- **Libraries:**
  - **TensorFlow (Keras API):** For model training and neural network implementation.
  - **Scikit-learn:** Used for scoring metrics, Principal Component Analysis (PCA), and KMeans clustering.
  - **Matplotlib & Seaborn:** Employed for data visualization and graphical representation.
  - **NumPy & Pandas:** For numerical computations and data manipulation.
  - **Pillow & OpenCV:** Utilized for image processing tasks.
  - **Other Helper Libraries:** Various additional Python libraries to support auxiliary tasks.

**Project Kaggle Notebook**

[fish_classification_akbank](https://www.kaggle.com/code/iskorpittt/fish-classification-akbank)

### Installation:
```
git clone https://github.com/kanitvural/fish_classification_akbank.git
cd fish_classification_akbank
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
```

### Steps:

1. **Data Collection and Validation:**
   
   The dataset used contains images of 9 different fish species, created and uploaded by O. Ulucan, D. Karakaya, and M. Turkan from Izmir University of Economics. Dataset includes, gilt head bream, red sea bream, sea bass, red mullet, horse mackerel, black sea sprat, striped red mullet, trout, shrimp image samples. The images are resized to 590 x 445 pixels and are publicly available on Kaggle.
   The original images are located in folders ending with "GT," but they were not used in this study.
 

2. **Exploratory Data Analysis and Visualization:**

   Before preprocessing, the image dimensions and color channels were analyzed, and necessary visualizations were created.

3. **Image Preprocessing:**

   Image data must be preprocessed before feeding it into the ANN. 
   
   First, `smart cropping` was applied to center the fish images and eliminate unnecessary parts. Then, considering that unrelated images might be mixed in with the fish images, the embeddings of the images were extracted, followed by dimensionality reduction using `PCA`. After that, `K-means clustering`  was applied to classify the images. As a result of the classification, no images that could not be used in the model were detected.

4. **Artificial Neural Network (ANN) Model Creation:**

    The Fish dataset has been split into training, validation, and test sets, comprising 80% for training, 10% for validation, and 10% for testing. The training and validation sets are used during the training process, while the test set is reserved for evaluation and prediction.
    
    To prevent overfitting, dropout and batch normalization techniques were applied.
    
    Early stopping, learning rate decay, and TensorBoard callbacks were utilized. Early stopping was implemented to prevent prolonged training times, while learning rate decay (ReduceLROnPlateau) was used to reduce the learning rate if there was no improvement in training progress. The TensorBoard callback was employed to monitor training results; however, since it does not work on Kaggle notebooks, the history object was used for visualization instead.

   Selected Hyperparameters:
   
      ```
        - Number of Layers: 6
        - Number of Neurons: 512, 256, 256, 128, 64, 10
        - Batch size: 32
        - Activation Function: relu
        - Optimization Algorithm: Adam
        - Learning Rate: 0.01 with decay
        - Image size: 128 x 128
    ```
    Selected Performance Metric: `Accuracy`
    

6. **Conclusions and Recommendations:**
   
    The results of this study indicate that the simple Artificial Neural Network (ANN) model successfully classified fish species from images with %91 accuracy. 
    
    - Model Enhancement: The number of layers and dropout rates of the ANN model can be adjusted to achieve better results. Due to out-of-memory errors, no attempts were made after reaching 91% accuracy. Additionally, CNN layers can be added to the model, or transfer learning can be performed using well-known model architectures to achieve better results.
      
    - Hyperparameter Tuning: Automating hyperparameter tuning using Bayesian optimization or grid search could lead to better model performance.
      
    - Scaling Resources: If computational resources allow, parallel processing or cloud-based solutions can be used for faster model training and hyperparameter search. 
