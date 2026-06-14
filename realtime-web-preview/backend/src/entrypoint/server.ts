import { existsSync } from 'node:fs'
import fastifyStatic from '@fastify/static'
import Fastify from 'fastify'
import { loadConfig } from '../config.js'
import { FsSourceWatcherGateway } from '../preview/adapter/gateways/fs-source-watcher-gateway.js'
import { MjsBlockSourceGateway } from '../preview/adapter/gateways/mjs-block-source-gateway.js'
import { makeEventsHandler } from './handlers/events-handler.js'
import { makeGetDocumentHandler } from './handlers/get-document-handler.js'

const config = loadConfig()
const app = Fastify({ logger: true })

// DI: adapter 実装を domain の interface に注入する。
const blockSource = new MjsBlockSourceGateway(config.sourceDir, config.sourceLabel)
const watcher = new FsSourceWatcherGateway(config.sourceDir)

app.get('/api/document', makeGetDocumentHandler(blockSource))
app.get('/api/events', makeEventsHandler(watcher))

// frontend ビルド成果物を同一ポートで静的配信する（未ビルドでも API は動く）。
if (existsSync(config.staticDir)) {
  await app.register(fastifyStatic, { root: config.staticDir })
  app.setNotFoundHandler((request, reply) => {
    if (request.url.startsWith('/api/')) {
      reply.code(404).send({ message: 'Not Found' })
      return
    }
    // SPA フォールバック。
    reply.sendFile('index.html')
  })
} else {
  app.log.warn(
    `frontend build not found at ${config.staticDir}. Run 'pnpm build' first. API is still available.`,
  )
}

try {
  await app.listen({ host: config.host, port: config.port })
  app.log.info(`source: ${config.sourceDir}`)
} catch (cause) {
  app.log.error(cause)
  process.exit(1)
}
