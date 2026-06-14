import { RELOAD_EVENT } from '@rwp/domain-model'
import type { FastifyReply, FastifyRequest } from 'fastify'
import type { SourceWatcherGateway } from '../../preview/domain/interfaces/gateways/source-watcher-gateway.js'
import { subscribeToChanges } from '../../preview/domain/usecases/subscribe-to-changes.js'

const HEARTBEAT_MS = 25_000

/**
 * GET /api/events ハンドラ（SSE）。
 * 入力ソースの変更を購読し、変更のたびに `reload` イベントを push する（F-5）。
 */
export const makeEventsHandler =
  (watcher: SourceWatcherGateway) =>
  (request: FastifyRequest, reply: FastifyReply): void => {
    // 生のソケットを直接扱うため Fastify のレスポンス管理から外す。
    reply.hijack()
    reply.raw.writeHead(200, {
      'Content-Type': 'text/event-stream',
      'Cache-Control': 'no-cache, no-transform',
      Connection: 'keep-alive',
    })
    reply.raw.write('event: connected\ndata: {}\n\n')

    const unsubscribe = subscribeToChanges(watcher, () => {
      reply.raw.write(`event: ${RELOAD_EVENT}\ndata: {}\n\n`)
    })

    // プロキシ等による idle 切断を避けるための heartbeat。
    const heartbeat = setInterval(() => {
      reply.raw.write(': ping\n\n')
    }, HEARTBEAT_MS)

    request.raw.on('close', () => {
      clearInterval(heartbeat)
      unsubscribe()
    })
  }
