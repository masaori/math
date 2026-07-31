/**
 * L1（入力言語）: ブロック本文を構成するノード。
 *
 * 語彙は閉じている。**ノード種別を増やせるのはこのシステムだけ**であり、
 * 利用者側（テーマ・プロジェクト固有メタデータ）からは増やせない
 * （docs/domain-model.md §8.3）。増やすと全出力ターゲットが対応を迫られるため。
 *
 * 型引数 `L` は「その文書に実在するラベル」のユニオン型で具体化される。
 * 既定の `string` はラベル束縛を持たない文脈（受け取り側・検証側）のための緩い形であり、
 * 著者が書く文脈では必ず生成済みのユニオン型で具体化する。
 */

export type TextNode = { type: 'text'; value: string }
export type MathNode = { type: 'math'; tex: string }
export type DisplayMathNode = { type: 'displayMath'; tex: string }
export type TodoNode = { type: 'todo'; value: string }

/**
 * 画像。**実体は正本の外にある**ので、正本が持つのは資産の名前（`assetKey`）だけである。
 * LaTeX のビルドディレクトリ相対パスと Web の配信 URL では解決規則が違うので、
 * 解決は出力器へ渡す資産解決器が持つ（正本が出力形式を知らないための分離。§7.1）。
 *
 * `alt` は必須。テキストしか出せない文脈へ劣化させられない要素を正本に入れないため
 * （§7.4 判定 2: 全ターゲットが劣化つきで表現できること）。
 */
export type ImageNode = { type: 'image'; assetKey: string; alt: string }

/** 相互参照。宛先は実在するラベルだけ（存在しないラベルはコンパイル時に落ちる）。 */
export type RefNode<L extends string = string> = {
  type: 'ref'
  target: L
  /** 参照の表示テキストの上書き。省略時はテーマの採番規則が決める。 */
  label?: string
}

/**
 * 文献引用。**宛先は文書の外**（BibTeX データベースのキー）なので、`RefNode` とは別の種別である。
 * `RefNode` の宛先は同じ文書に実在するラベルで、型で束縛できる。引用のキーは正本の外側にある
 * `.bib` に属するので型では束縛できず、実在確認は出力器（`.bib` を読める立場）の仕事になる。
 *
 * `keys` は**空にできない**（引用先の無い引用は意味を持たない。実行時検証で拒否する）。
 * 複数キーは 1 つの引用としてまとめて出す（LaTeX の `\cite{a,b}`）。
 *
 * `note` は箇所指定（"Theorem 3.1" など）。LaTeX の `\cite[note]{keys}` の省略可能引数に対応する。
 */
export type CiteNode = { type: 'cite'; keys: readonly string[]; note?: string }

export type ParagraphNode<L extends string = string> = {
  type: 'paragraph'
  children: readonly Node<L>[]
}

export type ListNode<L extends string = string> = {
  type: 'list'
  items: readonly (readonly Node<L>[])[]
}

export type Node<L extends string = string> =
  | TextNode
  | MathNode
  | DisplayMathNode
  | TodoNode
  | ImageNode
  | RefNode<L>
  | CiteNode
  | ParagraphNode<L>
  | ListNode<L>

/** ノード種別の全体。実行時検証と、語彙が閉じていることの表明に使う。 */
export const NODE_TYPES = [
  'text',
  'math',
  'displayMath',
  'todo',
  'image',
  'ref',
  'cite',
  'paragraph',
  'list',
] as const satisfies readonly Node['type'][]

export type NodeType = (typeof NODE_TYPES)[number]

/** 段落・箇条の子として素の文字列を書けるようにするための入力型。 */
export type InlineInput<L extends string = string> = string | Node<L>

export const text = (value: string): TextNode => ({ type: 'text', value })

/**
 * 行中数式。`tex` は **LaTeX と KaTeX の共通部分集合**でなければならない
 * （docs/domain-model.md §7.3 / 論点 D-1）。部分集合から外れた入力は生成段で落とす。
 */
export const math = (tex: string): MathNode => ({ type: 'math', tex })

/** 別行立て数式。制約は `math` と同じ。 */
export const displayMath = (tex: string): DisplayMathNode => ({ type: 'displayMath', tex })

/** 未完であるという事実そのもの。体裁ではなく意味なので正本に載る（§7.2）。 */
export const todo = (value: string): TodoNode => ({ type: 'todo', value })

/** 画像。`assetKey` は資産の名前で、実体の所在はターゲットごとに解決する。 */
export const image = (assetKey: string, alt: string): ImageNode => ({
  type: 'image',
  assetKey,
  alt,
})

/**
 * 文献引用。`keys` は BibTeX のキー。**空配列は禁止**（実行時検証が拒否する。
 * 型で空配列を禁じないのは、`readonly string[]` の非空性を素直に表す型が
 * 可変長引数以外に無く、可変長にすると `note` を後置できなくなるため）。
 */
export const cite = (keys: readonly string[], note?: string): CiteNode =>
  note === undefined ? { type: 'cite', keys } : { type: 'cite', keys, note }

const normalize = <L extends string>(children: readonly InlineInput<L>[]): readonly Node<L>[] =>
  children.map((child) => (typeof child === 'string' ? text(child) : child))

export const paragraph = <L extends string = string>(
  children: readonly InlineInput<L>[],
): ParagraphNode<L> => ({ type: 'paragraph', children: normalize(children) })

export const list = <L extends string = string>(
  items: readonly (readonly InlineInput<L>[])[],
): ListNode<L> => ({ type: 'list', items: items.map(normalize) })
