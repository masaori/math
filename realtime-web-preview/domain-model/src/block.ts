import { z } from 'zod'

/**
 * 構造化テキスト（入力ソース）の正準スキーマ（SSOT）。
 * 入力ソースのリファレンス実装は
 * exact-solution-of-2d-ising-model/structured-latex/schema.{d.ts,mjs} であり、
 * 本スキーマはその契約と一致させる。入力は backend の境界（adapter）で safeParse する。
 */

export const blockKindSchema = z.enum(['theorem', 'definition', 'claim', 'remark', 'note'])
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

export const titleSchema = z
  .object({
    text: z.string().optional(),
    tex: z.string().optional(),
  })
  .nullable()
export type Title = z.infer<typeof titleSchema>

export const blockSchema = z.object({
  id: z.string(),
  kind: blockKindSchema,
  sourcePath: z.string(),
  sourceOrdinal: z.number().int(),
  title: titleSchema.optional(),
  labels: z.array(z.string()).default([]),
  statement: z.array(nodeSchema).default([]),
  proof: z.array(nodeSchema).optional(),
  notes: z.array(nodeSchema).optional(),
  conversion: z
    .object({
      status: z.string(),
      notes: z.array(z.string()).optional(),
    })
    .optional(),
})
export type Block = z.infer<typeof blockSchema>

export const blocksSchema = z.array(blockSchema)
