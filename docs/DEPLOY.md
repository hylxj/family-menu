# 部署指南

## 服务器要求

- **最低配置**：1核 1GB（家庭版）
- **推荐配置**：2核 2GB
- **系统**：Linux（Ubuntu 22.04 / CentOS 8+）
- **必需**：Docker 24+、Docker Compose 2+

## 部署步骤

### 1. 准备项目

```bash
# 上传项目到服务器（示例）
scp -r family-menu user@server:/opt/

# SSH 到服务器
ssh user@server
cd /opt/family-menu/deploy
```

### 2. 配置环境变量

```bash
cp .env.example .env
vim .env
```

**必须修改**：
```bash
MYSQL_ROOT_PASSWORD=你的强密码  # 数据库密码，建议随机字符串
DEEPSEEK_API_KEY=sk-xxx       # DeepSeek API Key（可选）
```

### 3. 一键启动

```bash
docker-compose up -d --build
```

首次启动会：
- 构建后端镜像（5-10 分钟）
- 构建前端镜像（3-5 分钟）
- 启动 MySQL，自动执行 init.sql
- 后端启动并连接 MySQL
- 前端启动（Nginx）

### 4. 查看状态

```bash
docker-compose ps
docker-compose logs -f backend
docker-compose logs -f frontend
```

### 5. 验证

访问 `http://服务器IP`，能显示 "🍽️ 家庭饭桌决策系统" 即成功。

API 文档：`http://服务器IP/doc.html`

## 端口说明

| 端口 | 服务 | 是否暴露 |
|------|------|----------|
| 80 | 前端 Nginx | ✅ 暴露 |
| 8080 | 后端 | 仅内网访问（通过 Nginx 反代） |
| 3306 | MySQL | 仅内网访问 |

如果需要外网访问后端 API，修改 `docker-compose.yml`：
```yaml
backend:
  ports:
    - "8080:8080"  # 取消注释
```

## 域名 + HTTPS（可选）

### 方案 A：Caddy（推荐）

```bash
# 安装 Caddy
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/caddy-stable-archive-keyring.gpg] https://dl.cloudsmith.io/public/caddy/stable/deb deb main" | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy

# 配置 Caddy
cat > /etc/caddy/Caddyfile <<EOF
menu.yourdomain.com {
    reverse_proxy localhost:80
}
EOF

sudo systemctl restart caddy
```

Caddy 自动申请 HTTPS 证书。

### 方案 B：Nginx + Let's Encrypt

```bash
sudo apt install -y nginx certbot python3-certbot-nginx

# 配置 Nginx 反代
cat > /etc/nginx/sites-available/family-menu <<EOF
server {
    listen 80;
    server_name menu.yourdomain.com;
    location / {
        proxy_pass http://localhost:80;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF

sudo ln -s /etc/nginx/sites-available/family-menu /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx

# 申请证书
sudo certbot --nginx -d menu.yourdomain.com
```

## 数据备份

```bash
# 备份数据库
docker exec family-menu-mysql sh -c 'mysqldump -uroot -p"$MYSQL_ROOT_PASSWORD" family_menu' > backup_$(date +%Y%m%d).sql

# 恢复数据库
docker exec -i family-menu-mysql mysql -uroot -p"$MYSQL_ROOT_PASSWORD" family_menu < backup_20261006.sql
```

建议设置 crontab 自动备份：

```bash
crontab -e
# 每天凌晨 3 点备份
0 3 * * * cd /opt/family-menu/deploy && ./backup.sh
```

## 升级

```bash
cd /opt/family-menu
git pull  # 或重新上传代码

cd deploy
docker-compose down
docker-compose up -d --build
```

## 常见问题

### Q1: 端口 80 被占用

修改 `.env`：
```bash
FRONTEND_PORT=8081
```

### Q2: MySQL 启动失败

```bash
docker-compose logs mysql
# 常见原因：密码设置不合法、磁盘空间不足
df -h
```

### Q3: 前端访问后端 404

检查 Nginx 配置：
```bash
docker exec family-menu-frontend cat /etc/nginx/conf.d/default.conf
```

### Q4: 性能优化

如果菜品数据量大：
- MySQL 加索引（已在 schema.sql 中）
- 后端增加缓存（Redis）
- 前端做 PWA 离线缓存

## 监控

简单监控（可选）：
```bash
# 安装 docker-cAdvisor
docker run -d --name=monitor -p 8088:8080 \
  -v /:/rootfs:ro -v /var/run:/var/run:ro -v /sys:/sys:ro \
  google/cadvisor:latest
```

访问 `http://服务器IP:8088` 查看容器资源使用情况。