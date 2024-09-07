# Load necessary libraries
library(caret)
library(GGally)
library(corrplot)
library(randomForest)
library(e1071)
library(gbm)
library(caret)
library(ggplot2) 
library(pROC)
library(reshape2)
library(nnet)

# ===== DATA PREPARATION =====

# Full path to the dataset
file_path <- "C:/Users/syedi/OneDrive/Desktop/Healthcare Analytics/Project/Datasets/breast+cancer+wisconsin+diagnostic 1993/wdbc.data"
# Read the dataset from the CSV file
data <- read.csv(file_path, header = FALSE)

# Assign simplified column names
column_names <- c("ID", "Diagnosis",
                  "Mean_R", "Mean_Tex", "Mean_Perim", "Mean_A",
                  "Mean_Smooth", "Mean_Comp", "Mean_Concav",
                  "Mean_CPts", "Mean_Sym", "Mean_FractDim",
                  "SE_R", "SE_Tex", "SE_Perim", "SE_A",
                  "SE_Smooth", "SE_Comp", "SE_Concav",
                  "SE_CPts", "SE_Sym", "SE_FractDim",
                  "Worst_R", "Worst_Tex", "Worst_Perim", "Worst_A",
                  "Worst_Smooth", "Worst_Comp", "Worst_Concav",
                  "Worst_CPts", "Worst_Sym", "Worst_FractDim")
colnames(data) <- column_names

# Encode 'Diagnosis' as a factor and scale the features
data$Diagnosis <- as.factor(data$Diagnosis)
scale_fit <- preProcess(data[, -c(1,2)], method = c("center", "scale"))
data_scaled <- predict(scale_fit, data[, -c(1,2)])
data_scaled <- cbind(data[, 1:2], data_scaled)

# Split the dataset into training and test sets
set.seed(123)
train_indices <- createDataPartition(data_scaled$Diagnosis, p = 0.8, list = FALSE)
train <- data_scaled[train_indices, ]
test <- data_scaled[-train_indices, ]

# ===== DATA VISUALIZATION =====

# Pair Plot for the first six features including diagnosis
ggpairs(data_scaled[, c("Diagnosis", "Mean_R", "Mean_Tex", "Mean_Perim", "Mean_A", "Mean_Smooth")])

# Calculate and visualize correlation matrix for all features excluding ID and Diagnosis
cor_matrix <- cor(train[, -c(1, 2)])
corrplot(cor_matrix, method = "circle")

# Calculate and visualize correlation matrix for specific feature groups (Mean, SE, Worst)
mean_columns <- grep("Mean_", names(data), value = TRUE)
cor_matrix_mean <- cor(data[, mean_columns])
corrplot(cor_matrix_mean, method = "circle")

worst_columns <- grep("Worst_", names(data), value = TRUE)
cor_matrix_worst <- cor(data[, worst_columns])
corrplot(cor_matrix_worst, method = "circle")

se_columns <- grep("SE_", names(data), value = TRUE)
cor_matrix_se <- cor(data[, se_columns])
corrplot(cor_matrix_se, method = "circle")

# Create a heatmap for mean feature correlations
melted_cor_matrix_mean <- melt(cor_matrix_mean)
ggplot(melted_cor_matrix_mean, aes(Var1, Var2, fill=value)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        axis.title = element_blank())

# Histograms for each feature by Diagnosis
features <- names(data)[3:32]  # Adjust index to match feature columns
for (feature in features) {
  p <- ggplot(data, aes_string(x = feature, fill = "Diagnosis")) + 
    geom_histogram(bins = 30, alpha = 0.6, position = "identity") + 
    facet_wrap(~Diagnosis) +
    theme_minimal() +
    labs(title = paste("Distribution of", feature), x = feature, fill = "Diagnosis")
  print(p)  # Explicitly print the plot
}


# Boxplots for features by Diagnosis
par(mfrow=c(7,5))  # Adjust grid layout based on the number of features
for (f in features) {
  ggplot(data, aes_string(x = "Diagnosis", y = f)) + 
    geom_boxplot(aes(color = Diagnosis)) +
    theme_minimal() +
    ggtitle(paste("Boxplot of", f))
}

# Violin plots
for (feature in features) {
  p <- ggplot(data, aes_string(x = "Diagnosis", y = feature)) + 
    geom_violin(trim = FALSE) +
    geom_jitter(height = 0, width = 0.1, aes(color = Diagnosis)) +
    theme_minimal() +
    labs(title = paste("Violin Plot of", feature))
  print(p)
}

# Scatter plot
p <- ggplot(data, aes_string(x = features[1], y = features[2], color = "Diagnosis")) + 
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm") +
  theme_minimal() +
  labs(title = paste("Scatter Plot of", features[1], "vs", features[2]))
print(p)

# Heatmap of Sample Similarity
scaled_data_matrix <- as.matrix(data_scaled[, -c(1, 2)])

distance_matrix <- as.dist(scale(t(scaled_data_matrix)))  # transpose for sample-to-sample distances
heatmap(as.matrix(distance_matrix), symm = TRUE)

# PCA
pca_result <- prcomp(scaled_data_matrix)

pca_data <- data.frame(Diagnosis = data_scaled$Diagnosis,
                       PC1 = pca_result$x[,1],
                       PC2 = pca_result$x[,2])

p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Diagnosis)) +
  geom_point(alpha = 0.6) +
  theme_minimal() +
  labs(title = "PCA of Breast Cancer Data")
print(p)


# Swarm Plot for Features

numeric_data <- data[ , !names(data) %in% c("ID", "Diagnosis")]

data_std <- as.data.frame(scale(numeric_data))

data_std$Diagnosis <- data$Diagnosis

data_melt <- melt(data_std, id.vars = "Diagnosis",
                  variable.name = "features",
                  value.name = "value")

ggplot(data_melt, aes(x = features, y = value, color = Diagnosis)) +
  geom_jitter() +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "Swarm Plot for Features",
       x = "Features",
       y = "Value",
       color = "Diagnosis")

# Swarm Plot for Mean Features

mean_features <- c("Mean_R", "Mean_Tex", "Mean_Perim", "Mean_A",
                   "Mean_Smooth", "Mean_Comp", "Mean_Concav",
                   "Mean_CPts", "Mean_Sym", "Mean_FractDim")

numeric_data <- data[mean_features]

data_std <- as.data.frame(scale(numeric_data))

data_std$Diagnosis <- data$Diagnosis

data_melt <- melt(data_std, id.vars = "Diagnosis",
                  variable.name = "features",
                  value.name = "value")

ggplot(data_melt, aes(x = features, y = value, color = Diagnosis)) +
  geom_jitter() +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "Swarm Plot for Mean Features",
       x = "Features",
       y = "Value",
       color = "Diagnosis")