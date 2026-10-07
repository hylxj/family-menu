# ====== 构建阶段 ======
FROM node:20-alpine AS builder
WORKDIR /build

# 优先装依赖（缓存）
RUN npm config set registry https://registry.npmmirror.com

COPY package*.json ./
RUN npm install --silent

COPY . .
RUN npm run build

# ====== 运行阶段 ======
FROM nginx:1.25-alpine
WORKDIR /usr/share/nginx/html

# 复制构建产物
COPY --from=builder /build/dist .

# 复制 Nginx 配置
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]