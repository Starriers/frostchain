# 使用官方 Node.js 作为构建环境
FROM node:16 AS build
# 工作端口
ENV PORT 3000

# 设置工作目录
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# 复制 package.json 和 yarn.lock 文件
# 如果不是使用 yarn 进行包管理，去掉 yarn.lock 即可
COPY package.json yarn.lock /usr/src/app/
# 安装项目依赖
RUN yarn install

# 复制项目文件
COPY . /usr/src/app

# 构建应用
RUN yarn build
EXPOSE 3000

# 给 image 打标签
LABEL image.name="frostchain"\ image.version="1.0.0"\ image.description="forst-chain-v1":

# 运行环境使用 nginx
FROM nginx:1.27-alpine

# 从构建阶段复制构建产物到 nginx 目录
COPY --from=build /app/build /usr/share/nginx/html

# 暴露 80 端口
# EXPOSE 80

# 启动 nginx
CMD ["nginx", "-g", "daemon off;"]