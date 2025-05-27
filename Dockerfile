# Base image mới nhất Ubuntu 22.04 LTS
FROM ubuntu:22.04

# Thiết lập biến môi trường để không bị tương tác khi cài đặt gói
ENV DEBIAN_FRONTEND=noninteractive

# Cập nhật hệ thống và cài đặt đầy đủ các công cụ hệ thống cơ bản và nâng cao
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    curl \
    wget \
    vim \
    nano \
    htop \
    unzip \
    zip \
    software-properties-common \
    locales \
    ca-certificates \
    apt-transport-https \
    lsb-release \
    gnupg \
    python3 \
    python3-pip \
    python3-dev \
    python3-venv \
    openjdk-11-jdk \
    libssl-dev \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libjpeg-dev \
    ffmpeg \
    pkg-config \
    libpq-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Cài đặt locales UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# Cài đặt Jupyter Notebook và các thư viện Python phổ biến cho khoa học dữ liệu, AI, web...
RUN pip3 install --no-cache-dir --upgrade pip setuptools wheel && \
    pip3 install --no-cache-dir \
    notebook \
    numpy \
    scipy \
    pandas \
    matplotlib \
    seaborn \
    scikit-learn \
    tensorflow \
    torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu \
    jupyterlab \
    fastapi uvicorn \
    requests \
    flask \
    sqlalchemy \
    psycopg2-binary \
    ipython

# Tạo user không phải root để chạy an toàn hơn
RUN useradd -m -s /bin/bash appuser
USER appuser
WORKDIR /home/appuser

# Expose cổng Jupyter Notebook và FastAPI
EXPOSE 8888 8000

# Command mặc định khởi động Jupyter Notebook, bạn có thể thay đổi chạy FastAPI hoặc app khác
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
