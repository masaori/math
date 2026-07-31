import type { FigureBlock, Note } from '@rwp/domain-model'
import type { ReactElement } from 'react'
import { NodeList } from './nodes'
import { AttachedNotes } from './note-view'

/**
 * 図表ブロック1件を描画する。
 * キャプションは**ノード列**であってノートではない（structured-latex/docs/domain-model.md §7.5）ので、
 * 折りたたまず本文と同じ扱いで見せる。
 */
export const FigureView = ({
  block,
  notes,
}: {
  block: FigureBlock
  notes: readonly Note[]
}): ReactElement => (
  <figure
    id={block.id}
    className="scroll-mt-16 rounded-md border border-l-4 border-l-violet-500 bg-white p-4 shadow-sm"
  >
    <header className="mb-2 flex flex-wrap items-baseline gap-x-2">
      <span className="text-xs font-semibold uppercase tracking-wide text-slate-500">Figure</span>
      {block.labels.length > 0 ? (
        <span className="text-xs text-slate-400">[{block.labels.join(', ')}]</span>
      ) : null}
    </header>

    <div className="text-slate-800">
      <NodeList nodes={block.content} />
    </div>

    {block.caption !== undefined ? (
      <figcaption className="mt-2 border-t border-slate-100 pt-2 text-sm text-slate-600">
        <NodeList nodes={block.caption} />
      </figcaption>
    ) : null}

    <AttachedNotes notes={notes} />

    <footer className="mt-2 text-[11px] text-slate-400">{block.origin?.path}</footer>
  </figure>
)
