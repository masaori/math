/**
 * 採番方針。**体裁の側の宣言**である（「何番と呼ぶか」は意味ではない。§7.2）。
 * したがってテーマが持つが、**採番の結果は解決済み文書に固定される**ので、
 * 本文の参照と番号が食い違わない（§5.5）。
 */

import type { FigureKind, HeadingLevel, TheoremLikeKind } from '../structured-text/block.ts'

/** 番号を共有するグループの名前。同じ名前を宣言した kind は 1 本のカウンタを共有する。 */
export type CounterKey = string

/**
 * 見出しの番号の振り出し。同じ親の下で最初に現れる見出しの番号である。
 * 0 なら「第 0 章」から振る（数学書で準備の章を 0 にする慣習）。0 と 1 以外の振り出しは使われていないので受けない。
 */
export type HeadingStartNumber = 0 | 1

export type NumberingPolicy = {
  /**
   * 番号を振る見出しの深さ。これより深い見出しは番号を持たない（`number` が null になる）。
   * 0 なら見出しには番号を振らない。
   */
  numberedHeadingDepth: number
  /**
   * 見出しの深さ → 番号の振り出し。**全深さ必須**（書き忘れを静かに通さないため）。
   * 例: level 1 だけを 0 にすると、見出しは「0」「0.1」「0.2」「1」「1.1」と振られる。
   */
  headingStartNumbers: Record<HeadingLevel, HeadingStartNumber>
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
 * 定理型（概要を含む）は 1 本のカウンタを共有し、節ごとにリセットされる。
 * 図表は別カウンタ（「定理 2.7」と「図 3」が別番号になる）。
 */
export const DEFAULT_NUMBERING_POLICY: NumberingPolicy = {
  numberedHeadingDepth: 6,
  headingStartNumbers: { 1: 1, 2: 1, 3: 1, 4: 1, 5: 1, 6: 1 },
  resetAt: 1,
  counters: {
    theorem: 'theoremLike',
    definition: 'theoremLike',
    claim: 'theoremLike',
    remark: 'theoremLike',
    note: 'theoremLike',
    overview: 'theoremLike',
    figure: 'figure',
  },
  separator: '.',
}
