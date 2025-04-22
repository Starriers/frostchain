# 第一阶段：构建阶段
FROM node:20.4-alpine AS builder
WORKDIR /usr/src/app
# 安装依赖
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build

# 第二阶段：生产环境
FROM nginx:1.25-alpine

# 复制构建产物到 Nginx
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html

# 暴露端口并启动
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]