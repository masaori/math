/**
 * L1（入力言語）を、あるプロジェクトのラベル集合 `L` とメタデータ `M` で具体化するファクトリ。
 *
 * このシステムが提供するのは**スキーマの実体ではなくファクトリと生成器**である
 * （docs/domain-model.md §5.4）。ラベルのユニオン型と文書集約モジュールは
 * プロジェクトの内容に強く結びつくので、生成物としてプロジェクト側に置く。
 *
 * ここから出るのは「`L` に依存するもの」だけである。ノードの構築子（`text` / `math` /
 * `paragraph` …）は `L` に依存しないので `./node.ts` から直接 import する。
 * 同じものを 2 経路で import できる状態を作らない。
 *
 * **この関数は実行時検証を行わない。** 実行時検証は `./validate.ts` の 1 か所に集約し、
 * Result で返す（docs/error-handling-strategy.md が throw による伝搬を禁じている）。
 * 先行実装は `defineBlocks` の中で throw していたが、それだと検証の入口が
 * 「定義時」と「受け入れ時」の 2 つに割れる。
 */

import type { Block, Note } from './block.ts'
import type { DocumentStructure } from './document-structure.ts'
import type { RefNode } from './node.ts'
import type { NoDuplicateBlockId, NoDuplicateLabel, NoDuplicateNoteId } from './uniqueness.ts'

export type StructuredTextSchema<L extends string, M> = {
  /**
   * 1 セグメント分のブロック列を定義する。**配列の並びが文書順の正準表現**。
   *
   * 引数を `T & readonly Block<L, M>[]` という交差にしてあるのは、`const` 型引数だけだと
   * 余剰プロパティ検査（`proof` を `proofs` と打ち間違える等）が効かなくなるため
   * （先行実装で実測済み。docs/type-coverage.md）。
   */
  defineBlocks: <const T extends readonly Block<L, M>[]>(
    blocks: T & readonly Block<L, M>[] & NoDuplicateBlockId<T> & NoDuplicateLabel<T>,
  ) => T

  /** 1 セグメント分の参照用ノート列を定義する。ノートは文書本体ではない（I5）。 */
  defineNotes: <const T extends readonly Note<L>[]>(
    notes: T & readonly Note<L>[] & NoDuplicateNoteId<T>,
  ) => T

  /** 節・要素グループ・主要／補助所属を明示した文書構造を定義する。 */
  defineDocumentStructure: <const T extends DocumentStructure<L, M>>(document: T) => T

  /** 相互参照。実在しないラベルはコンパイル時に落ちる（I2 の型側の担保）。 */
  ref: (target: L, label?: string) => RefNode<L>
}

/**
 * ラベル集合 `L` とメタデータ `M` で入力言語を具体化する。
 *
 * 使い方（プロジェクト側）:
 * ```ts
 * import { createStructuredTextSchema } from '<system>/domain-model/index.ts'
 * import type { Label } from './labels.generated.ts'
 *
 * type Meta = { habitat: Habitat }
 * export const { defineBlocks, defineNotes, ref } = createStructuredTextSchema<Label, Meta>()
 * ```
 */
export const createStructuredTextSchema = <
  L extends string,
  M = unknown,
>(): StructuredTextSchema<L, M> => ({
  defineBlocks: <const T extends readonly Block<L, M>[]>(
    blocks: T & readonly Block<L, M>[] & NoDuplicateBlockId<T> & NoDuplicateLabel<T>,
  ): T => blocks,
  defineNotes: <const T extends readonly Note<L>[]>(
    notes: T & readonly Note<L>[] & NoDuplicateNoteId<T>,
  ): T => notes,
  defineDocumentStructure: <const T extends DocumentStructure<L, M>>(document: T): T => document,
  ref: (target: L, label?: string): RefNode<L> =>
    label === undefined ? { type: 'ref', target } : { type: 'ref', target, label },
})
