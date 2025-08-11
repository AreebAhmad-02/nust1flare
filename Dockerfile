# Use the specified base image from the challenge
# FROM mrigroupopbg/mri-python3
FROM pytorch/pytorch:2.2.1-cuda11.8-cudnn8-runtime

# Set working directory
WORKDIR /workspace

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
RUN python --version
# ENV PYTHONPATH="/workspace:/workspace/LaMed/src:$PYTHONPATH"
RUN apt-get update && apt-get upgrade -y && apt-get clean
# # Install system dependencies
# RUN apt-get update && apt-get install -y \
#     git \
#     wget \
#     curl \
#     unzip \
#     build-essential \
#     && rm -rf /var/lib/apt/lists/*


# Copy the entire project
COPY . /workspace/

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip
RUN python --version
RUN pip install --no-cache-dir -r requirements.txt
# Install huggingface_hub (and optionally git-lfs if you decide to use git)
RUN pip install --no-cache-dir huggingface_hub


# Create necessary directories
RUN mkdir -p /workspace/outputs
# Make predict.sh executable
RUN chmod +x /workspace/predict.sh
RUN chmod +x /workspace/download_model.sh
RUN bash /workspace/download_model.sh
# Set default command
# CMD ["bash", "predict.sh"]