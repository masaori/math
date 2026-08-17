/**
 * L1（入力言語）: ブロックとノート。
 *
 * ブロックは 2 種だけ（見出し・定理型）。**ブロック種別を増やせるのはこのシステムだけ**
 * （docs/domain-model.md §8.3）。図表を語彙に入れていない理由と、入れるときの形は
 * docs/design-notes/figure-node-decision.md に記録してある。
 *
 * 型引数:
 *   `L` … その文書に実在するラベルのユニオン型（生成物 `labels.generated.ts`）
 *   `M` … プロジェクト固有メタデータ（意味の拡張。§5.4 / §8.5）。既定の `unknown` は
 *          交差しても何も足さないので、拡張しないプロジェクトは意識しなくてよい。
 */

import type { Node } from './node.ts'

export type HeadingLevel = 1 | 2 | 3 | 4 | 5 | 6

export const HEADING_LEVELS = [1, 2, 3, 4, 5, 6] as const satisfies readonly HeadingLevel[]

export type TheoremLikeKind = 'theorem' | 'definition' | 'claim' | 'remark' | 'note'

export const THEOREM_LIKE_KINDS = [
  'theorem',
  'definition',
  'claim',
  'remark',
  'note',
] as const satisfies readonly TheoremLikeKind[]

/**
 * 主張の**身分**。その主張が文書の到達点（主定理）か、そこへ至る道具（サブ定理）かを宣言する。
 *
 * 意味であって体裁ではない（docs/domain-model.md §7.2 の判定: この情報を落とすと
 * 「この節で何を示したのか」という文書の主張そのものが読み取れなくなる）。
 * 主定理を目立たせる・サブ定理を折りたたむといった見せ方は体裁であり、出力器側が決める。
 */
export type TheoremStanding = 'mainTheorem' | 'subTheorem'

export const THEOREM_STANDINGS = [
  'mainTheorem',
  'subTheorem',
] as const satisfies readonly TheoremStanding[]

/**
 * 身分を宣言できる種別。**主張型（定理・主張）だけ**である。
 * 定義・注意・ノートは何かを主張して証明する対象ではないので、到達点にも道具にもならない。
 */
export type StandingBearingKind = Extract<TheoremLikeKind, 'theorem' | 'claim'>

export const STANDING_BEARING_KINDS = [
  'theorem',
  'claim',
] as const satisfies readonly StandingBearingKind[]

/**
 * 宣言が無いときの身分。**サブ定理**を既定にする。
 * 到達点は文書全体でごく少数であり、全主張へ宣言を必須にすると分類の判断が大量に発生する。
 * 「印を付けたものだけが主定理」という形にして、付け忘れが主定理の乱造にならないようにする。
 */
export const DEFAULT_THEOREM_STANDING: TheoremStanding = 'subTheorem'

export type HeadingKind = 'heading'

export type FigureKind = 'figure'

export type BlockKind = TheoremLikeKind | HeadingKind | FigureKind

export const BLOCK_KINDS = [
  ...THEOREM_LIKE_KINDS,
  'heading',
  'figure',
] as const satisfies readonly BlockKind[]

/**
 * タイトルの中身。`text`（素のテキスト）と `tex`（数式を含む LaTeX）の
 * **少なくとも一方が必須**。空の `{}` はコンパイル時に落ちる。
 */
export type TitleContent = { text: string; tex?: string } | { text?: string; tex: string }

export type Title = TitleContent | null

/**
 * 由来。先行実装の `sourcePath` / `sourceOrdinal` を一般化したもの。
 *
 * **任意である。** 先行 2 実装では必須だが、これは Typst 原本からの移行という一時的な事情に
 * 由来するものであって、入力言語の契約に属さない（原本を持たない文書でも正本は成立する）。
 */
export type Origin = { path: string; ordinal: number }

type BlockCommon<L extends string> = {
  id: string
  labels: readonly L[]
  origin?: Origin
}

/**
 * 定理型ブロック（本文を持つ）。
 * メタデータ `M` の拡張が定理型にだけ効くのは、integrable-lattice が
 * 「住処は本文ブロックでは必須、見出しには書けない」と定めているのに合わせたもの。
 */
type TheoremLikeCommon<L extends string, M> = BlockCommon<L> &
  M & {
    title?: Title
    statement: readonly Node<L>[]
    proof?: readonly Node<L>[]
    /** 見出し専用のフィールド。定理型では書けない（コンパイル時に拒否）。 */
    level?: never
    /** 図表専用のフィールド。定理型では書けない。 */
    content?: never
    caption?: never
    /** 注記欄は持てない。参照用ノートは Note として分離する（I5 の入口を塞ぐ）。 */
    notes?: never
  }

/** 主張型（定理・主張）。身分 `standing` を宣言できる唯一のブロック。 */
export type StandingBearingBlock<L extends string = string, M = unknown> = TheoremLikeCommon<L, M> & {
  kind: StandingBearingKind
  /** 省略時は `DEFAULT_THEOREM_STANDING`（サブ定理）として扱う。 */
  standing?: TheoremStanding
}

/** 定義・注意・ノート。身分は宣言できない（コンパイル時に拒否）。 */
export type UnrankedTheoremLikeBlock<L extends string = string, M = unknown> = TheoremLikeCommon<
  L,
  M
> & {
  kind: Exclude<TheoremLikeKind, StandingBearingKind>
  standing?: never
}

/** 本文を持つブロック（定理型）。 */
export type TheoremLikeBlock<L extends string = string, M = unknown> =
  | StandingBearingBlock<L, M>
  | UnrankedTheoremLikeBlock<L, M>

/** 見出しブロック（文書構造だけを持ち、本文を持たない）。 */
export type HeadingBlock<L extends string = string> = BlockCommon<L> & {
  kind: HeadingKind
  level: HeadingLevel
  title: TitleContent
  /** 見出しは本文を持たない（コンパイル時に拒否）。 */
  statement?: never
  proof?: never
  content?: never
  caption?: never
  notes?: never
  /** 見出しは主張ではないので身分を持てない。 */
  standing?: never
}

/**
 * 図表ブロック。
 *
 * ブロックである根拠（ブロックとノードの判定基準。docs/domain-model.md §5.3.1）:
 * 文書順に位置を占め、`id` を持ち、`labels` を宣言して**参照の宛先になれ**、番号が振られる。
 * ノード（同一性を持たない中身）ではこれを満たせない。
 *
 * キャプションは**ノード列**であってノートではない。ノート（`Note`）は出版物に載らない
 * 補足（I5）であり、キャプションをそこへ置くと出版物から図の説明が消える。
 */
export type FigureBlock<L extends string = string> = BlockCommon<L> & {
  kind: FigureKind
  /** 図の本体。画像ノードのほか、数式や箇条で図式を書いてもよい。 */
  content: readonly Node<L>[]
  /** キャプション。段落・数式・相互参照が書ける。 */
  caption?: readonly Node<L>[]
  /** 定理型・見出し専用のフィールドは書けない（コンパイル時に拒否）。 */
  statement?: never
  proof?: never
  level?: never
  notes?: never
  /** 図表は主張ではないので身分を持てない。 */
  standing?: never
}

/** 文書を構成するブロック。**配列の並びが文書順の正準表現**。 */
export type Block<L extends string = string, M = unknown> =
  | TheoremLikeBlock<L, M>
  | HeadingBlock<L>
  | FigureBlock<L>

/**
 * 参照用ノート。**文書本体ではない**（I5）。
 * `targets` は 1 件以上（空タプルはコンパイル時に落ちる）。
 */
export type Note<L extends string = string> = {
  id: string
  targets: readonly [L, ...L[]]
  title?: Title
  origin?: Origin
  body: readonly Node<L>[]
}

/**
 * ブロックの身分を読む。**宣言が無ければサブ定理**（`DEFAULT_THEOREM_STANDING`）。
 * 既定値をここ 1 か所に置き、出力器ごとに「宣言が無いときどうするか」を書かせない。
 *
 * 引数を `Block<L, M>` ではなく最小の形にしてあるのは、プロジェクト固有メタデータ `M` が
 * 判別共用体のとき（住処 ↔ ℝ 脱出の対応など）`TheoremLikeCommon & M` の共用体が
 * `Block<L, M>` へ代入できず、呼び出し側が型検査で落ちるためである（実測）。
 */
export const standingOf = (block: { standing?: TheoremStanding }): TheoremStanding =>
  block.standing ?? DEFAULT_THEOREM_STANDING

/** 見出しか判定する（`M` に依存せず narrowing できる形にしておく）。 */
export const isHeadingBlock = <L extends string, M>(
  block: Block<L, M>,
): block is HeadingBlock<L> => block.kind === 'heading'
