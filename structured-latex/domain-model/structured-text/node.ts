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

/**
 * 図式の題に書けるノード。地の文と行中数式だけである。
 *
 * 相互参照・引用・箇条を題に置けないのは、題が箱の中に収まる短い名前だからである。
 * 参照を許すと、解決済み文書（`resolved/`）が図式の内側まで参照を解決しなければならなくなるが、
 * 箱の名前の中から別のブロックを指す実例は無い。
 */
export type DiagramLabelNode = TextNode | MathNode

/** 図式の枠。複数の箱をまとめて囲み、題を付ける。 */
export type DiagramGroup = {
  id: string
  title: readonly DiagramLabelNode[]
}

/**
 * 図式の箱。**位置は著者が格子の上で決める**（`column` が列、`row` が行。行は上から 0, 1, 2, …）。
 * 自動レイアウトをしないのは、矢印の並びを著者が決めればねじれが起きないためである。
 * 列は小数でもよい（箱を列の間に置くため）。行は整数で、矢印は上の行から下の行へ向かう。
 */
export type DiagramBox = {
  id: string
  title: readonly DiagramLabelNode[]
  /** 所属する枠の id。枠に入れない箱は省く。 */
  group?: string
  column: number
  row: number
}

/** 図式の矢印。`from` の箱から `to` の箱へ向かう。 */
export type DiagramEdge = { from: string; to: string }

/**
 * 箱・枠・矢印からなる図式。中身は構造で書き、座標は持たない。
 * 座標は出力器が共有する 1 か所（`renderers/diagram/`）が著者の格子位置から計算する。
 *
 * 文字しか出せない文脈へも劣化できる（箱の題と矢印の両端を並べれば中身が尽きる）ので、
 * 画像ノードのような代替文 `alt` は持たない（docs/domain-model.md §7.4 判定 2）。
 */
export type DiagramNode = {
  type: 'diagram'
  groups: readonly DiagramGroup[]
  boxes: readonly DiagramBox[]
  edges: readonly DiagramEdge[]
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
  | DiagramNode

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
  'diagram',
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

/** 図式の題の入力。素の文字列は地の文として扱う。 */
export type DiagramLabelInput = string | DiagramLabelNode

/** 題は 1 つ以上のノードを持つ（空の題の箱・枠は何も指さない）。 */
type DiagramTitleInput = readonly [DiagramLabelInput, ...DiagramLabelInput[]]

const normalizeDiagramLabel = (
  title: readonly DiagramLabelInput[],
): readonly DiagramLabelNode[] =>
  title.map((part) => (typeof part === 'string' ? text(part) : part))

/**
 * 図式。**枠・箱の id への参照を型で束縛する**:
 * 箱の `group` は宣言した枠の id だけ、矢印の `from` / `to` は宣言した箱の id だけを書ける
 * （打ち間違いはコンパイル時に TS2322 で落ちる）。
 *
 * id の重複・位置の重複・上向きの矢印は型では落とさず、実行時検証（`diagramIssuesOf`）が落とす。
 * 型で落とすには id の列全体の重複判定を再帰型で書く必要があり、`defineBlocks` の重複検出と
 * 同じ深さの問題（TS2589）を図式ごとに抱え込むことになるため。
 */
export const diagram = <const GroupId extends string, const BoxId extends string>(spec: {
  groups: readonly { id: GroupId; title: DiagramTitleInput }[]
  boxes: readonly {
    id: BoxId
    title: DiagramTitleInput
    group?: NoInfer<GroupId>
    column: number
    row: number
  }[]
  edges: readonly { from: NoInfer<BoxId>; to: NoInfer<BoxId> }[]
}): DiagramNode => ({
  type: 'diagram',
  groups: spec.groups.map((group) => ({ id: group.id, title: normalizeDiagramLabel(group.title) })),
  boxes: spec.boxes.map((box) => ({
    id: box.id,
    title: normalizeDiagramLabel(box.title),
    ...(box.group === undefined ? {} : { group: box.group }),
    column: box.column,
    row: box.row,
  })),
  edges: spec.edges.map((edge) => ({ from: edge.from, to: edge.to })),
})
