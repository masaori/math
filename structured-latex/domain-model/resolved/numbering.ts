/**
 * 採番方針。**体裁の側の宣言**である（「何番と呼ぶか」は意味ではない。§7.2）。
 * したがってテーマが持つが、**採番の結果は解決済み文書に固定される**ので、
 * 本文の参照と番号が食い違わない（§5.5）。
 */

import type { FigureKind, HeadingLevel, TheoremLikeKind } from '../structured-text/block.ts'

/** 番号を共有するグループの名前。同じ名前を宣言した kind は 1 本のカウンタを共有する。 */
export type CounterKey = string

export type NumberingPolicy = {
  /**
   * 番号を振る見出しの深さ。これより深い見出しは番号を持たない（`number` が null になる）。
   * 0 なら見出しには番号を振らない。
   */
  numberedHeadingDepth: number
  /**
   * 定理型・図表の番号を、どの深さの見出しごとにリセットするか。
   * 例: 2 なら「1.2.7」（level 1・2 の見出し番号 + 通し番号）。null なら文書通しの番号。
   */
  resetAt: HeadingLevel | null
  /**
   * kind → カウンタ名。**全 kind 必須**（`Partial` にしない）。
   * 宣言の書き忘れを静かに通さないため（docs/architecture-overview.md の resolver 方針）。
   */
  counters: Record<TheoremLikeKind | FigureKind, CounterKey>
  /** 番号の区切り。 */
  separator: string
}

/**
 * 既定の採番方針。先行実装（`build-latex.ts`）の実状に合わせてある:
 * 定理型 5 種は 1 本のカウンタを共有し、節ごとにリセットされる。
 * 図表は別カウンタ（「定理 2.7」と「図 3」が別番号になる）。
 */
export const DEFAULT_NUMBERING_POLICY: NumberingPolicy = {
  numberedHeadingDepth: 6,
  resetAt: 1,
  counters: {
    theorem: 'theoremLike',
    definition: 'theoremLike',
    claim: 'theoremLike',
    remark: 'theoremLike',
    note: 'theoremLike',
    figure: 'figure',
  },
  separator: '.',
}
