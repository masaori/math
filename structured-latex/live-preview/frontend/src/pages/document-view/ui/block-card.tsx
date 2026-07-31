import type {
  ResolvedNote,
  ResolvedTheoremLike,
  TheoremLikeKind,
} from '@structured-latex/system/domain-model'
import type { ReactElement } from 'react'
import { BLOCK_KIND_LABELS } from './kind-labels'
import { NodeList, TitleView } from './nodes'
import { AttachedNotes } from './note-view'

const kindAccent: Record<TheoremLikeKind, string> = {
  theorem: 'border-l-indigo-500',
  definition: 'border-l-emerald-500',
  claim: 'border-l-sky-500',
  remark: 'border-l-amber-500',
  note: 'border-l-slate-400',
}

/**
 * 定理型ブロック1件を kind 別体裁で描画する。
 * `notes` はこのブロックのラベルに紐づく参照用ノート（文書本体ではない）。
 * 番号・アンカーは解決済み（システムの `resolveTolerantly` が確定させている）。
 */
export const BlockCard = ({
  block,
  notes,
}: {
  block: ResolvedTheoremLike
  notes: readonly ResolvedNote[]
}): ReactElement => {
  const hasProof = block.proof !== null && block.proof.length > 0

  return (
    <section
      id={block.anchor}
      className={`scroll-mt-16 rounded-md border border-l-4 ${kindAccent[block.kind]} bg-white p-4 shadow-sm`}
    >
      <header className="mb-2 flex flex-wrap items-baseline gap-x-2 gap-y-1">
        <span className="text-xs font-semibold uppercase tracking-wide text-slate-500">
          {BLOCK_KIND_LABELS[block.kind]} {block.number.display}
        </span>
        {block.title ? (
          <h2 className="text-base font-bold text-slate-800">
            <TitleView title={block.title} />
          </h2>
        ) : null}
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

      <AttachedNotes notes={notes} />

      <footer className="mt-2 text-[11px] text-slate-400">{block.origin?.path}</footer>
    </section>
  )
}
