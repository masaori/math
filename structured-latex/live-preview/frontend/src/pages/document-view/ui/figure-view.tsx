import type { ResolvedFigure, ResolvedNote } from '@structured-latex/system/domain-model'
import type { ReactElement } from 'react'
import { BLOCK_KIND_LABELS } from './kind-labels'
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
  block: ResolvedFigure
  notes: readonly ResolvedNote[]
}): ReactElement => (
  <figure
    id={block.anchor}
    className="scroll-mt-16 rounded-md border border-l-4 border-l-violet-500 bg-white p-4 shadow-sm"
  >
    <header className="mb-2 flex flex-wrap items-baseline gap-x-2">
      <span className="text-xs font-semibold uppercase tracking-wide text-slate-500">
        {BLOCK_KIND_LABELS.figure} {block.number.display}
      </span>
      {block.labels.length > 0 ? (
        <span className="text-xs text-slate-400">[{block.labels.join(', ')}]</span>
      ) : null}
    </header>

    <div className="text-slate-800">
      <NodeList nodes={block.content} />
    </div>

    {block.caption !== null ? (
      <figcaption className="mt-2 border-t border-slate-100 pt-2 text-sm text-slate-600">
        <NodeList nodes={block.caption} />
      </figcaption>
    ) : null}

    <AttachedNotes notes={notes} />

    <footer className="mt-2 text-[11px] text-slate-400">{block.origin?.path}</footer>
  </figure>
)
