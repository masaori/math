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
  Origin,
  TitleContent,
} from '../structured-text/block.ts'
import type {
  CiteNode,
  DisplayMathNode,
  ImageNode,
  MathNode,
  TextNode,
  TodoNode,
} from '../structured-text/node.ts'
import type { Locale } from '../structured-text/locale.ts'

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

/**
 * 宛先のラベルが文書内に存在しなかった相互参照。
 *
 * **本文から消さずに残す**ための種別である。`resolveTolerantly` だけが作り、
 * `resolve`（厳格）は 1 件でもあれば文書自体を返さないので、出版物の出力器はこれを受け取らない。
 * 執筆支援画面は、これを「壊れている箇所」として明示的に描画する。
 */
export type UnresolvedRef = {
  type: 'unresolvedRef'
  /** 解決できなかったラベル。 */
  target: string
  /** どのブロック（またはノート）の中にあったか。 */
  fromBlockId: string
  overrideText: string | null
}

export type ResolvedNode =
  | TextNode
  | MathNode
  | DisplayMathNode
  | TodoNode
  | ImageNode
  // 引用は文書内の解決対象を持たない（宛先は `.bib`）ので、L1 の形のまま素通しする。
  | CiteNode
  | ResolvedRef
  | UnresolvedRef
  | { type: 'paragraph'; children: readonly ResolvedNode[] }
  | { type: 'list'; items: readonly (readonly ResolvedNode[])[] }

/**
 * 解決済みブロックが共通して持つ**由来の情報**。
 *
 * 体裁の判断には使わない（§8.5 の「意味と体裁を混ぜない」）。
 * 正本のどこから来たかを画面や診断に出すためだけに運ぶ。
 */
type ResolvedProvenance = {
  /** 正本で宣言されていたラベル（参照の宛先になれる名前）。 */
  labels: readonly string[]
  /** 正本での位置。宣言されていなければ null。 */
  origin: Origin | null
}

export type ResolvedHeading = ResolvedProvenance & {
  kind: 'heading'
  blockId: string
  level: HeadingLevel
  number: BlockNumber | null
  title: TitleContent
  anchor: string
}

export type ResolvedTheoremLike = ResolvedProvenance & {
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

export type ResolvedFigure = ResolvedProvenance & {
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
  /**
   * 正本で宣言されていた紐づけ先のラベル。**解決結果ではなく入力のまま**運ぶ。
   * どのブロックにも解決しなかった（迷子の）ノートを画面に出すとき、
   * 「どのラベルを指していたのか」が分からないと直しようがないため。
   */
  targets: readonly string[]
  origin: Origin | null
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
  /**
   * `resolveLocalized` が選択したローカライズ文脈。
   *
   * 既存の単一 `RevisionSnapshot` を解決する `resolve` / `resolveTolerantly` はこれらを
   * 持たないままでよい。optional にすることで、既存の日本語単一ロケール文書と出力を
   * 壊さずに移行できる。ローカライズ入口の返り値は required な
   * `LocalizedResolvedDocument` として具体化される。
   */
  sourceLocale?: Locale
  locale?: Locale
  translatedFrom?: Locale | null
  translatedFromRevision?: RevisionNumber | null
  availableLocales?: readonly Locale[]
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
