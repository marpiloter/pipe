#!/bin/bash

# 检查是否为root用户
if [ "$(id -u)" -ne 0 ]; then
  echo "请以root用户或使用sudo运行此脚本"
  exit 1
fi

# 更新系统
echo "正在更新系统..."
apt update -y && apt upgrade -y

# 安装必要的依赖
echo "正在安装必要的依赖..."
apt install -y curl

# 下载Pop二进制文件
echo "正在下载Pop二进制文件..."
curl -L -o pop "https://dl.pipecdn.app/v0.2.4/pop"

# 为Pop文件赋予执行权限
chmod +x pop

# 创建缓存目录
echo "请输入缓存目录路径（例如 /data）："
read cache_dir
mkdir -p "$cache_dir"

# 获取Solana公钥
echo "请输入您的Solana公钥："
read pub_key

# 获取RAM配置
echo "请输入RAM大小（GB）："
read ram_size

# 获取最大磁盘空间
echo "请输入最大磁盘空间（GB）："
read max_disk

# 启动Pop节点
echo "正在启动Pop节点..."
./pop --ram "$ram_size" --max-disk "$max_disk" --cache-dir "$cache_dir" --pubKey "$pub_key" &

# 提供状态检查命令
echo "Pop节点正在运行。您可以使用以下命令查看状态："
echo "./pop --status"
echo "输入 ./pop --status 查看节点的当前状态。"

echo "安装完成，祝您运行顺利！"

