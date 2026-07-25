import { z } from 'zod'

/**
 * 構造化テキスト（入力ソース）の正準スキーマ（SSOT）。
 * 入力ソースのリファレンス実装は
 * exact-solution-of-2d-ising-model/structured-latex/schema.{d.ts,mjs} であり、
 * 本スキーマはその契約と一致させる。入力は backend の境界（adapter）で safeParse する。
 */

/** 定理型ブロック（証明環境）の kind。 */
export const theoremLikeKindSchema = z.enum(['theorem', 'definition', 'claim', 'remark', 'note'])
export type TheoremLikeKind = z.infer<typeof theoremLikeKindSchema>

/** 章見出しの kind。文書構造を表し、本文を持たない。 */
export const headingKindSchema = z.literal('heading')

/** ブロックの kind。定理型ブロックに加えて章見出しを持つ。 */
export const blockKindSchema = z.enum([
  'theorem',
  'definition',
  'claim',
  'remark',
  'note',
  'heading',
])
export type BlockKind = z.infer<typeof blockKindSchema>

export type Node =
  | { type: 'text'; value: string }
  | { type: 'math'; tex: string }
  | { type: 'displayMath'; tex: string }
  | { type: 'paragraph'; children: Node[] }
  | { type: 'list'; items: Node[][] }
  | { type: 'ref'; target: string; label?: string }
  | { type: 'todo'; value: string }

export const nodeSchema: z.ZodType<Node> = z.lazy(() =>
  z.discriminatedUnion('type', [
    z.object({ type: z.literal('text'), value: z.string() }),
    z.object({ type: z.literal('math'), tex: z.string() }),
    z.object({ type: z.literal('displayMath'), tex: z.string() }),
    z.object({ type: z.literal('paragraph'), children: z.array(nodeSchema) }),
    z.object({ type: z.literal('list'), items: z.array(z.array(nodeSchema)) }),
    z.object({ type: z.literal('ref'), target: z.string(), label: z.string().optional() }),
    z.object({ type: z.literal('todo'), value: z.string() }),
  ]),
)

/** タイトルの中身。`text` は素のテキスト、`tex` は KaTeX で描画する LaTeX 文字列。 */
export const titleContentSchema = z.object({
  text: z.string().optional(),
  tex: z.string().optional(),
})
export type TitleContent = z.infer<typeof titleContentSchema>

export const titleSchema = titleContentSchema.nullable()
export type Title = z.infer<typeof titleSchema>

const conversionSchema = z.object({
  status: z.string(),
  notes: z.array(z.string()).optional(),
})

/** 全ブロック共通のフィールド。 */
const blockBaseShape = {
  id: z.string(),
  sourcePath: z.string(),
  /**
   * ソース内での通し番号。文書順ではない
   * （文書順はブロック配列の並びで表す。入力ソース側の schema 参照）。
   */
  sourceOrdinal: z.number().int(),
  labels: z.array(z.string()).default([]),
  conversion: conversionSchema.optional(),
}

/** 定理型ブロック（本文を持つ）。 */
export const theoremLikeBlockSchema = z.object({
  ...blockBaseShape,
  kind: theoremLikeKindSchema,
  title: titleSchema.optional(),
  statement: z.array(nodeSchema).default([]),
  proof: z.array(nodeSchema).optional(),
  notes: z.array(nodeSchema).optional(),
})
export type TheoremLikeBlock = z.infer<typeof theoremLikeBlockSchema>

/**
 * 章見出しブロック（文書構造のみ。本文を持たない）。
 * `level` は 1 が最上位。
 */
export const headingBlockSchema = z.object({
  ...blockBaseShape,
  kind: headingKindSchema,
  level: z.number().int().min(1).max(6),
  title: titleContentSchema,
})
export type HeadingBlock = z.infer<typeof headingBlockSchema>

/** 文書を構成するブロック。配列の並びが文書順。 */
export const blockSchema = z.discriminatedUnion('kind', [
  theoremLikeBlockSchema,
  headingBlockSchema,
])
export type Block = z.infer<typeof blockSchema>

export const blocksSchema = z.array(blockSchema)

/** ラベル文字列 → そのラベルを持つブロックの id。ref.target を id アンカーへ解決するための表。 */
export type LabelIndex = Readonly<Record<string, string>>

/**
 * 各ブロックの label（複数可）→ block.id の解決インデックスを作る。
 * ref.target（＝ラベル）を、対応ブロックの id アンカーへ解決するために使う。
 * ラベルの一意性は入力ソース側の検証責務（structured-latex/tools/validate-content.mjs）で
 * 担保される前提で、重複時は後勝ちで上書きする。ドメイン非依存の純関数。
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
