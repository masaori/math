import type { LoadDocumentError } from '@rwp/domain-model'
import type { ReactElement } from 'react'
import type { ConnectionStatus, DocumentViewPageDomainModel } from '../model/page-domain-model'
import { BlockCard } from './block-card'

const errorMessages: Record<LoadDocumentError['code'], string> = {
  source_not_found: '入力ソースが見つかりません。サーバ起動時のソース dir 設定を確認してください。',
  source_empty: '表示できるブロックがありません。',
  validation_error: '構造化テキストの検証に失敗しました。下記の該当箇所を修正してください。',
  source_read_error: 'ソースの読み込み中にエラーが発生しました。',
}

const connectionLabels: Record<ConnectionStatus, { text: string; className: string }> = {
  connecting: { text: '接続中…', className: 'bg-slate-100 text-slate-500' },
  live: { text: '● ライブ', className: 'bg-emerald-100 text-emerald-700' },
  disconnected: { text: '切断', className: 'bg-rose-100 text-rose-700' },
}

const ConnectionBadge = ({ status }: { status: ConnectionStatus }): ReactElement => {
  const { text, className } = connectionLabels[status]
  return <span className={`rounded-full px-2 py-0.5 text-xs font-medium ${className}`}>{text}</span>
}

const ErrorPanel = ({ error }: { error: LoadDocumentError }): ReactElement => (
  <div className="rounded-md border border-rose-200 bg-rose-50 p-4 text-sm text-rose-800">
    <p className="font-semibold">{errorMessages[error.code]}</p>
    {error.code === 'validation_error' ? (
      <ul className="mt-2 list-disc space-y-1 pl-5">
        {error.issues.map((issue, index) => (
          <li key={`${issue.path}-${index}`}>
            <code className="font-mono text-xs">{issue.path}</code>: {issue.message}
          </li>
        ))}
      </ul>
    ) : null}
    {error.code === 'source_read_error' ? (
      <pre className="mt-2 overflow-x-auto rounded bg-rose-100 p-2 text-xs">{error.message}</pre>
    ) : null}
  </div>
)

/** PageDomainModel を Props で受け取り描画する（外界を一切知らない）。 */
export const DocumentView = ({
  document,
  connection,
  onManualReloadClick,
}: DocumentViewPageDomainModel): ReactElement => (
  <div className="mx-auto max-w-3xl p-4 sm:p-6">
    <header className="sticky top-0 z-10 -mx-4 mb-4 flex items-center justify-between border-b border-slate-200 bg-white/90 px-4 py-2 backdrop-blur sm:-mx-6 sm:px-6">
      <h1 className="text-lg font-bold text-slate-800">realtime-web-preview</h1>
      <div className="flex items-center gap-3">
        <ConnectionBadge status={connection} />
        <button
          type="button"
          onClick={onManualReloadClick}
          className="rounded border border-slate-300 px-2 py-1 text-xs text-slate-600 hover:bg-slate-50"
        >
          再読込
        </button>
      </div>
    </header>

    {document.status === 'loading' ? <p className="text-slate-500">読み込み中…</p> : null}

    {document.status === 'error' ? <ErrorPanel error={document.error} /> : null}

    {document.status === 'ready' ? (
      <>
        <p className="mb-4 text-xs text-slate-400">
          {document.value.meta.sourceLabel} · {document.value.blocks.length} blocks ·{' '}
          {document.value.meta.generatedAt}
        </p>
        <div className="space-y-4">
          {document.value.blocks.map((block) => (
            <BlockCard key={block.id} block={block} />
          ))}
        </div>
      </>
    ) : null}
  </div>
)
