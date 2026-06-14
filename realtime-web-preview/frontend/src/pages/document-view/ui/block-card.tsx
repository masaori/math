import type { Block } from '@rwp/domain-model'
import type { ReactElement } from 'react'
import { NodeList } from './nodes'

const kindLabels: Record<Block['kind'], string> = {
  theorem: 'Theorem',
  definition: 'Definition',
  claim: 'Claim',
  remark: 'Remark',
  note: 'Note',
}

const kindAccent: Record<Block['kind'], string> = {
  theorem: 'border-l-indigo-500',
  definition: 'border-l-emerald-500',
  claim: 'border-l-sky-500',
  remark: 'border-l-amber-500',
  note: 'border-l-slate-400',
}

/** ブロック1件を kind 別体裁で描画する。 */
export const BlockCard = ({ block }: { block: Block }): ReactElement => {
  const title = block.title?.text ?? block.title?.tex
  const hasProof = block.proof !== undefined && block.proof.length > 0
  const hasNotes = block.notes !== undefined && block.notes.length > 0

  return (
    <section
      id={block.id}
      className={`scroll-mt-16 rounded-md border border-l-4 ${kindAccent[block.kind]} bg-white p-4 shadow-sm`}
    >
      <header className="mb-2 flex flex-wrap items-baseline gap-x-2 gap-y-1">
        <span className="text-xs font-semibold uppercase tracking-wide text-slate-500">
          {kindLabels[block.kind]}
        </span>
        {title ? <h2 className="text-base font-bold text-slate-800">{title}</h2> : null}
        {block.labels.length > 0 ? (
          <span className="text-xs text-slate-400">[{block.labels.join(', ')}]</span>
        ) : null}
      </header>

      <div className="text-slate-800">
        <NodeList nodes={block.statement} />
      </div>

      {hasProof ? (
        <div className="mt-3 border-t border-slate-100 pt-2">
          <div className="text-xs font-semibold text-slate-500">Proof</div>
          <div className="text-slate-700">
            <NodeList nodes={block.proof ?? []} />
          </div>
        </div>
      ) : null}

      {hasNotes ? (
        <div className="mt-3 rounded bg-slate-50 p-2 text-sm text-slate-600">
          <NodeList nodes={block.notes ?? []} />
        </div>
      ) : null}

      <footer className="mt-2 text-[11px] text-slate-400">{block.sourcePath}</footer>
    </section>
  )
}
