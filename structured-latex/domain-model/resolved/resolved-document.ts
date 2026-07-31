/**
 * L3: 解決済み文書。**出力形式に中立**な中間表現。
 *
 * 存在理由（docs/domain-model.md F9）: ラベル → ブロックの解決が、LaTeX 生成器と
 * Web ビューアで**独立に 2 度実装されていた**。出力形式の数だけ同じロジックが増えるのを止める。
 * 採番・参照解決・ノート配置・文書順の確定は、ここまでで全部終わる。
 */

import type {
  BlockKind,
  HeadingLevel,
  TitleContent,
} from '../structured-text/block.ts'
import type {
  DisplayMathNode,
  ImageNode,
  MathNode,
  TextNode,
  TodoNode,
} from '../structured-text/node.ts'

/** 版番号。1 始まりの単調増加（順序比較で収束を判定するため文字列にしない）。 */
export type RevisionNumber = number

/** ブロック番号（例: 節 2 の 7 番目 → `{ path: [2, 7], display: '2.7' }`）。 */
export type BlockNumber = { path: readonly number[]; display: string }

/**
 * 解決済みの相互参照。宛先のアンカーと番号が確定している。
 * **番号は null になりうる**（番号を振らない見出しを参照した場合）。
 * その場合にどう表示するかはテーマが決める（省略できない。§8.2）。
 */
export type ResolvedRef = {
  type: 'ref'
  targetBlockId: string
  targetKind: BlockKind
  targetNumber: BlockNumber | null
  targetTitle: TitleContent | null
  anchor: string
  /** 正本側で表示テキストが上書きされていた場合のみ非 null。 */
  overrideText: string | null
}

export type ResolvedNode =
  | TextNode
  | MathNode
  | DisplayMathNode
  | TodoNode
  | ImageNode
  | ResolvedRef
  | { type: 'paragraph'; children: readonly ResolvedNode[] }
  | { type: 'list'; items: readonly (readonly ResolvedNode[])[] }

export type ResolvedHeading = {
  kind: 'heading'
  blockId: string
  level: HeadingLevel
  number: BlockNumber | null
  title: TitleContent
  anchor: string
}

export type ResolvedTheoremLike = {
  kind: Exclude<BlockKind, 'heading' | 'figure'>
  blockId: string
  number: BlockNumber
  title: TitleContent | null
  statement: readonly ResolvedNode[]
  proof: readonly ResolvedNode[] | null
  anchor: string
  /**
   * プロジェクト固有メタデータ。テーマから**読めるが解釈されない**。
   * 出力器はこれを体裁の判断に使わない（§8.5 の「意味と体裁を混ぜない」）。
   */
  meta: unknown
}

export type ResolvedFigure = {
  kind: 'figure'
  blockId: string
  number: BlockNumber
  content: readonly ResolvedNode[]
  caption: readonly ResolvedNode[] | null
  anchor: string
}

export type ResolvedBlock = ResolvedHeading | ResolvedTheoremLike | ResolvedFigure

export type ResolvedNote = {
  noteId: string
  title: TitleContent | null
  body: readonly ResolvedNode[]
  anchor: string
}

export type OutlineEntry = {
  blockId: string
  level: HeadingLevel
  number: BlockNumber | null
  title: TitleContent
  anchor: string
}

export type ResolvedDocument = {
  documentId: string
  revision: RevisionNumber
  /** 文書順に並んだブロック（F1 の順序をここで確定させる）。 */
  blocks: readonly ResolvedBlock[]
  /** ブロック id → 配置されたノート。出版ターゲットでは常に空（I5）。 */
  notesByBlockId: Readonly<Record<string, readonly ResolvedNote[]>>
  /** 目次。Web の目次と LaTeX の `\tableofcontents` が同じものから出る。 */
  outline: readonly OutlineEntry[]
}

/**
 * 誰向けに解決するか。**I5 を型で担う**引数。
 * `publication` ならノートは解決の入力から外れ、`notesByBlockId` は空で固定される。
 * 先行実装が「生成器が `loadNoteFiles` を呼ばない」という実装上の約束で守っていたものを、
 * 引数として明示する。
 */
export type Audience = 'publication' | 'working'
