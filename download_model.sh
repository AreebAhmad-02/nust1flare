echo "Downloading model from Hugging Face..."


if [ ! -f "/workspace/results/baseline/model-00004-of-00004.safetensors" ]; then
    echo "[INFO] Model not found. Downloading from Hugging Face..."
    
    MODEL_DIR="/workspace/results/baseline"
    HF_REPO="Areeb-02/M3D-LaMed-Phi-3-4B-finetuned"

    huggingface-cli download $HF_REPO --local-dir $MODEL_DIR

    echo "[INFO] Model downloaded to $MODEL_DIR"

else
    echo "[INFO] Model already present, skipping download."
fi

