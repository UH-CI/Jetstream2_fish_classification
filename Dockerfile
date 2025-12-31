FROM tensorflow/tensorflow:2.16.1-gpu-jupyter

# Install system dependencies for OpenCV
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --no-cache-dir \
    numpy pandas matplotlib seaborn Pillow \
    opencv-python scikit-learn tqdm scipy

WORKDIR /tf/notebooks