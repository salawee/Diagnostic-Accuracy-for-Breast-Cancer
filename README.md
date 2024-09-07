# 🩺 Optimizing Diagnostic Accuracy for Breast Cancer through Advanced Predictive Models

## 🔍 Overview
This repository demonstrates the development and application of machine learning models to improve the diagnostic accuracy of breast cancer. Leveraging the **Wisconsin Breast Cancer Diagnostic Dataset**, this project applies models such as **Logistic Regression**, **Support Vector Machines (SVM)**, **Random Forest**, and **K-Nearest Neighbors (KNN)** to predict whether a breast tumor is benign or malignant. The project aims to support early detection and optimize diagnostic decisions using robust predictive models.

---

## 📑 Table of Contents
- [Introduction](#introduction)
- [Data Sources](#data-sources)
- [Methodology](#methodology)
  - [Feature Engineering](#feature-engineering)
  - [Modeling](#modeling)
  - [Evaluation](#evaluation)
- [Results](#results)
  - [Key Findings](#key-findings)
- [Discussion](#discussion)
- [Contributions](#contributions)
- [Citation](#citation)

---

## 📘 Introduction
Breast cancer remains one of the most common and deadly forms of cancer worldwide. Early detection significantly increases the survival rate, making accurate and timely diagnosis crucial. This project explores the use of machine learning models to improve diagnostic accuracy, particularly in distinguishing between **benign** and **malignant** breast tumors. By analyzing cell nucleus characteristics from biopsy images, this project seeks to reduce false positives and false negatives, leading to better patient outcomes.

<div align="center">
    <img src="https://github.com/user-attachments/assets/fc216abf-c5bc-4725-83dd-4d05651d406b" alt="Image description">
</div>

---

## 🛠️ Data Sources
The dataset used in this project is the **Wisconsin Breast Cancer Diagnostic Dataset**, which contains features extracted from fine needle aspirates of breast tissue. These features include measurements such as **radius**, **texture**, **perimeter**, and **concavity** of cell nuclei, providing valuable data for tumor classification.

---

## 📊 Methodology

### 🧠 Feature Engineering
Feature selection and engineering were performed using correlation matrices and **Principal Component Analysis (PCA)**. This enabled the identification of the most discriminative features, such as **mean radius**, **perimeter**, and **area** for tumor diagnosis. The features were processed to standardize values and prepare the dataset for modeling.

<div align="center">
    <img src="https://github.com/user-attachments/assets/0a6bb236-7c73-4ed1-9887-3ce249083b0b" alt="Image description" width="900">
</div>

### 🔄 Modeling
Several machine learning algorithms were used to predict tumor malignancy:
- **Logistic Regression**: Straightforward and effective for binary classification.
- **Support Vector Machines (SVM)**: Powerful for separating non-linear data.
- **Random Forest**: Effective in handling complex datasets by combining multiple decision trees.
- **K-Nearest Neighbors (KNN)**: Non-parametric and adaptable to data structure.

Each model was trained and evaluated using **cross-validation** and **grid search** for hyperparameter optimization.

<div align="center">
    <img src="https://github.com/user-attachments/assets/f33ff800-d615-45ee-947b-90e30873bf27" alt="Image description" width="500">
</div>


### 📊 Evaluation
The models were evaluated using key metrics including:
- **Accuracy**: Proportion of correctly predicted cases.
- **Sensitivity**: Ability to correctly identify malignant tumors.
- **Specificity**: Ability to correctly identify benign tumors.
- **AUC-ROC**: The area under the ROC curve for evaluating classification performance.

<div align="center">
    <img src="https://github.com/user-attachments/assets/434e7d7f-cabb-4486-b75b-e38a2c42fbd6" alt="Image description">
</div>

---

## 🎯 Results

### 📊 Key Findings
- **Support Vector Machines (SVM)** outperformed other models, achieving the highest accuracy and AUC scores, particularly when using the mean and worst features.
- **Logistic Regression** demonstrated stable performance, making it a reliable choice for healthcare applications where interpretability is crucial.
- **Random Forest** showed some overfitting tendencies but provided useful feature importance insights.

<div align="center">
    <img src="https://github.com/user-attachments/assets/c6267855-9b4e-4d0e-9e7b-07a1e1c0fd3b">
</div>
<div align="center">
    <img src="https://github.com/user-attachments/assets/0f04fd96-e4eb-497c-a771-a32157f01ea1">
</div>
<div align="center">
    <img src="https://github.com/user-attachments/assets/540b197b-1c45-4653-b80b-602800de193d">
</div>

---

## 💬 Discussion
This project highlights the importance of model selection and feature engineering in medical diagnostics. **Support Vector Machines** showed consistent performance across various feature sets, aligning with other healthcare studies. Logistic regression remains valuable due to its interpretability, and **Random Forest** models provided useful insights into feature importance, aiding decision-making.

Further investigation into hyperparameter tuning, larger datasets, and integrating additional diagnostic data (e.g., genetic markers) could enhance model performance.

---

## 🤝 Contributions
We welcome contributions from data scientists and healthcare professionals who wish to improve the models or incorporate new datasets. Collaboration on feature engineering, model tuning, and integration of additional medical data (e.g., genetic markers) is encouraged to further refine the predictive accuracy.

---

## 📚 Citation
Please cite this work using the following format: Alawee, S.I., **Optimizing Diagnostic Accuracy for Breast Cancer through Advanced Predictive Models**, 2024.

---

Thank you for exploring this project! If you'd like to collaborate or discuss potential improvements, feel free to connect on GitHub.
