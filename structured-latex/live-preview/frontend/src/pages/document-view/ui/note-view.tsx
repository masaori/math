import type { ResolvedNote } from '@structured-latex/system/domain-model'
import type { ReactElement } from 'react'
import { NodeList, TitleView } from './nodes'

/** ノートが本文でないことを、どの表示箇所でも同じ文言で示す。 */
const NOTE_DISCLAIMER = '参照用ノート・最終成果物には載りません'

/** ノート1件の中身（タイトル + 本文 + 由来）。 */
const NoteBody = ({ note }: { note: ResolvedNote }): ReactElement => (
  <article
    id={note.anchor}
    className="scroll-mt-16 border-t border-dashed border-amber-300 py-2 first:border-t-0 first:pt-0"
  >
    {note.title ? (
      <h3 className="text-sm font-semibold text-amber-900">
        <TitleView title={note.title} />
      </h3>
    ) : null}
    <div className="text-sm text-amber-950">
      <NodeList nodes={note.body} />
    </div>
    {note.origin !== null ? (
      <p className="mt-1 text-[11px] text-amber-700">{note.origin.path}</p>
    ) : null}
  </article>
)

/**
 * ブロックに紐づく参照用ノートを、本文と視覚的に区別して（破線・別色・折りたたみ）描画する。
 * 既定で折りたたみ、本文の読みを妨げないようにする。
 */
export const AttachedNotes = ({
  notes,
}: { notes: readonly ResolvedNote[] }): ReactElement | null => {
  if (notes.length === 0) {
    return null
  }
  return (
    <details className="mt-3 rounded border border-dashed border-amber-400 bg-amber-50/60 px-3 py-2">
      <summary className="cursor-pointer text-xs font-semibold text-amber-800">
        ノート {notes.length} 件（{NOTE_DISCLAIMER}）
      </summary>
      <div className="mt-1">
        {notes.map((note) => (
          <NoteBody key={note.noteId} note={note} />
        ))}
      </div>
    </details>
  )
}

/**
 * どのブロックにも紐づかなかったノート（targets 未解決）。
 * 黙って捨てると気付けないので、未解決 ref と同じ思想で明示的に警告表示する。
 * 解決を止めずにここまで運んでくるのはシステムの `resolveTolerantly` の役目。
 */
export const OrphanNotes = ({ notes }: { notes: readonly ResolvedNote[] }): ReactElement | null => {
  if (notes.length === 0) {
    return null
  }
  return (
    <section className="mt-6 rounded-md border border-rose-300 bg-rose-50 p-4">
      <h2 className="text-sm font-semibold text-rose-800">
        紐づけ先が見つからないノート {notes.length} 件（{NOTE_DISCLAIMER}）
      </h2>
      <p className="mt-1 text-xs text-rose-700">
        targets のラベルが本文のどのブロックにも存在しません。ラベル名の変更漏れが疑われます。
      </p>
      <div className="mt-2">
        {notes.map((note) => (
          <div
            key={note.noteId}
            className="border-t border-dashed border-rose-300 py-2 first:border-t-0"
          >
            <p className="text-[11px] text-rose-700">targets: [{note.targets.join(', ')}]</p>
            <NoteBody note={note} />
          </div>
        ))}
      </div>
    </section>
  )
}
