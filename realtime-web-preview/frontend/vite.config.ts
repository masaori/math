import react from '@vitejs/plugin-react'
import { defineConfig } from 'vite'

// dev サーバ時は /api を backend(4321) にプロキシする。
// 本番（LAN 配信）は backend が dist を静的配信するため、このプロキシは使われない。
export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0',
    proxy: {
      '/api': { target: 'http://localhost:4321', changeOrigin: true },
    },
  },
  build: {
    outDir: 'dist',
    emptyOutDir: true,
  },
})
