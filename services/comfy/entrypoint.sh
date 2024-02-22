#!/bin/bash

apt-get install -y wget

set -Eeuo pipefail

mkdir -vp /data/config/comfy/custom_nodes
mkdir -vp /data/models/clip_vision
mkdir -vp /data/models/upscale_models
mkdir -vp /data/models/ipadapter

# mkdir -vp /data/models/con


declare -A MOUNTS

MOUNTS["/root/.cache"]="/data/.cache"
MOUNTS["${ROOT}/input"]="/data/config/comfy/input"
MOUNTS["${ROOT}/output"]="/output/comfy"
MOUNTS["${ROOT}/models/clip_vision"]="/data/models/clip_vision"
MOUNTS["${ROOT}/custom_nodes"]="/data/config/comfy/custom_nodes"
MOUNTS["${ROOT}/models/upscale_models"]="/data/models/upscale_models"
MOUNTS["${ROOT}/models/ipadapter"]="/data/models/ipadapter"
MOUNTS["${ROOT}/models/controlnet"]="/data/config/auto/extensions/sd-webui-controlnet/models"
MOUNTS["${ROOT}/models/loras"]="/data/models/Lora/"

mkdir -vp /data/models/inpaint
MOUNTS["${ROOT}/models/inpaint"]="/data/models/inpaint/"
if [ ! -f "/data/models/inpaint/MAT_Places512_G_fp16.safetensors" ]; then
  wget -O "/data/models/inpaint/MAT_Places512_G_fp16.safetensors" "https://huggingface.co/Acly/MAT/resolve/main/MAT_Places512_G_fp16.safetensors"
fi

for to_path in "${!MOUNTS[@]}"; do
  set -Eeuo pipefail
  from_path="${MOUNTS[${to_path}]}"
  rm -rf "${to_path}"
  if [ ! -f "$from_path" ]; then
    mkdir -vp "$from_path"
  fi
  mkdir -vp "$(dirname "${to_path}")"
  ln -sT "${from_path}" "${to_path}"
  echo Mounted $(basename "${from_path}")
done

if [ -f "/data/config/comfy/startup.sh" ]; then
  pushd ${ROOT}
  . /data/config/comfy/startup.sh
  popd
fi

pip install diffusers==0.26.3
pip install opencv-python-headless==4.9.0.80
pip install tomesd==0.1.3
pip install rembg==2.0.54
pip install lark==1.1.9

pip install compel==2.0.2

pip install icecream==2.1.3

pip install simpleeval==0.9.13
pip install matplotlib==3.8.3

exec "$@"
