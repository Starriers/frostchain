import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import svgr from 'vite-plugin-svgr'

export default defineConfig({
    plugins: [
        react(),
        svgr() // 支持 SVG 作为组件
    ],
    server: {
        port: 3000,
        open: true
    },
    resolve: {
        alias: {
            // 配置路径别名（按需）
            '@': '/src'
        }
    }
})