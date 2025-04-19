# 使用官方 Node.js 作为构建环境
FROM node:16 AS build

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 yarn.lock 文件
# 如果不是使用 yarn 进行包管理，去掉 yarn.lock 即可
COPY package.json yarn.lock ./

# 安装项目依赖
RUN yarn install

# 复制项目文件
COPY . .

# 构建应用
RUN yarn build

# 运行环境使用 nginx
FROM nginx:stable-alpine

# 从构建阶段复制构建产物到 nginx 目录
COPY --from=build /app/build /usr/share/nginx/html

# 暴露 80 端口
EXPOSE 80

# 启动 nginx
CMD ["nginx", "-g", "daemon off;"]
