# Use the specified base image from the challenge
FROM mrigroupopbg/mri-python3

# Set working directory
WORKDIR /workspace

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
# ENV PYTHONPATH="/workspace:/workspace/LaMed/src:$PYTHONPATH"

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
# Make download script executable
RUN chmod +x /workspace/download_model.sh
# Make predict.sh executable
RUN chmod +x /workspace/predict.sh

# Set default command
# CMD ["bash", "predict.sh"]