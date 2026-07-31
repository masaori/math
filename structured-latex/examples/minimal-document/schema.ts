/**
 * 最小の利用例（＝生成器と型検査の実証対象）。
 *
 * プロジェクト側がやることはこれだけである:
 *   1. 生成された `Label`（実在するラベルのユニオン型）を受け取る
 *   2. プロジェクト固有メタデータ `M` を宣言する（要らなければ省略できる）
 *   3. ファクトリを具体化して `defineBlocks` / `defineNotes` / `ref` を得る
 *
 * 入力言語そのもの（ブロック・ノードの語彙）はシステム側にあり、ここには複製しない。
 */

import { createStructuredTextSchema, createRuntimeSchema } from '../../domain-model/index.ts'
import { z } from 'zod'

import type { Label } from './labels.generated.ts'

/**
 * プロジェクト固有メタデータの例。
 * 判別共用体にしてあるので、「非可算側を宣言したのに脱出箇所を書いていない」は
 * コンパイル時に落ちる（integrable-lattice の `habitat` / `realEscape` と同じ形）。
 */
export type Habitation =
  | { habitat: 'countable'; realEscape?: never }
  | { habitat: 'uncountable'; realEscape: string }

export const { defineBlocks, defineNotes, ref } = createStructuredTextSchema<Label, Habitation>()

/** 実行時検証。メタデータのキーもここで宣言しないと `.strict()` に弾かれる。 */
export const runtimeSchema = createRuntimeSchema<Label, Habitation, { habitat: z.ZodTypeAny; realEscape: z.ZodTypeAny }>({
  blockMeta: {
    habitat: z.enum(['countable', 'uncountable']),
    realEscape: z.string().min(1).optional(),
  },
})
