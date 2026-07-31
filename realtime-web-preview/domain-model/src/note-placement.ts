/**
 * ラベル解決とノート配置。
 *
 * システム側にも同じことをする `resolve`（`structured-latex/domain-model/resolved/resolve.ts`）が
 * あるが、**本ビューアはそれを使えない**。理由は 1 点で、`resolve` は未解決参照・迷子ノートを
 * `Result` の**エラーとして返す**（同ファイル 274-275 行: `unresolved_reference` / `orphan_note`）ため、
 * 文書が 1 箇所でも壊れていると解決済み文書が一切得られない。
 * 本ビューアの要件 F-9 は「検証に失敗しても画面を落とさず、壊れている箇所を表示し続ける」であり、
 * 未解決 ref は赤字点線で、迷子ノートは警告パネルで**描画する**（`ui/nodes.tsx`・`ui/note-view.tsx`）。
 * この 2 つは両立しないので、ここは意図的にビューア側の寛容な解決を持つ。
 */

import type { Block, Note } from './structured-text.js'

/** ラベル文字列 → そのラベルを持つブロックの id。ref.target を id アンカーへ解決するための表。 */
export type LabelIndex = Readonly<Record<string, string>>

/**
 * 各ブロックの label（複数可）→ block.id の解決インデックスを作る。
 * ラベルの一意性は正本側（システムの `resolve` / 各プロジェクトの検証）の責務であり、
 * ここでは重複しても落とさず後勝ちで上書きする（壊れていても表示し続けるため）。
 */
export function buildLabelIndex(blocks: readonly Block[]): LabelIndex {
  const index: Record<string, string> = {}
  for (const block of blocks) {
    for (const label of block.labels) {
      index[label] = block.id
    }
  }
  return index
}

/** ノートの配置先。block.id ごとの一覧と、どのブロックにも解決できなかったもの。 */
export type NotePlacement = {
  byBlockId: Readonly<Record<string, readonly Note[]>>
  /** targets がどのブロックのラベルにも解決しなかったノート（黙って捨てず表示するため）。 */
  orphans: readonly Note[]
}

/**
 * ノートを targets（ラベル）経由で block.id へ割り当てる。
 * 同一ブロックに複数の targets が当たっても 1 回だけ現れる。
 * 未解決 targets は捨てずに orphans へ集める（未解決 ref と同じ思想で、画面上で気付けるようにする）。
 */
export function placeNotes(blocks: readonly Block[], notes: readonly Note[]): NotePlacement {
  const labelIndex = buildLabelIndex(blocks)
  const byBlockId: Record<string, Note[]> = {}
  const orphans: Note[] = []

  for (const note of notes) {
    const blockIds = new Set<string>()
    for (const target of note.targets) {
      const blockId = labelIndex[target]
      if (blockId !== undefined) {
        blockIds.add(blockId)
      }
    }
    if (blockIds.size === 0) {
      orphans.push(note)
      continue
    }
    for (const blockId of blockIds) {
      const bucket = byBlockId[blockId]
      if (bucket === undefined) {
        byBlockId[blockId] = [note]
      } else {
        bucket.push(note)
      }
    }
  }

  return { byBlockId, orphans }
}
