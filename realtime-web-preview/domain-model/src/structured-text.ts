/**
 * 構造化テキスト（入力言語）の**正本はこのパッケージに無い**。
 * リポジトリ直下の `structured-latex/`（システム）が 1 つだけ持つ
 * （structured-latex/docs/domain-model.md §0）。
 *
 * このファイルは、そのシステムの定義を本 workspace の公開面（`@rwp/domain-model`）へ
 * 橋渡しするだけの層である。**型・実行時スキーマ・ノードの語彙をここで再定義しない。**
 * 以前ここにあった独自定義（`src/block.ts`）は、同じ入力言語の 3 度目の定義だったため削除した。
 */

import { createRuntimeSchema } from '@structured-latex/system/domain-model'
import type { RuntimeSchema } from '@structured-latex/system/domain-model'

// --- L1（入力言語）の型と語彙: すべてシステムの再輸出 --------------------------
export {
  BLOCK_KINDS,
  HEADING_LEVELS,
  NODE_TYPES,
  THEOREM_LIKE_KINDS,
  isHeadingBlock,
  type Block,
  type BlockKind,
  type CiteNode,
  type DisplayMathNode,
  type FigureBlock,
  type FigureKind,
  type HeadingBlock,
  type HeadingKind,
  type HeadingLevel,
  type ImageNode,
  type ListNode,
  type MathNode,
  type Node,
  type NodeType,
  type Note,
  type Origin,
  type ParagraphNode,
  type RefNode,
  type RuntimeSchema,
  type TextNode,
  type TheoremLikeBlock,
  type TheoremLikeKind,
  type Title,
  type TitleContent,
  type TodoNode,
  type ValidationIssue,
} from '@structured-latex/system/domain-model'

/**
 * 本ビューア用に L1 の実行時スキーマを具体化する。
 *
 * **このビューアは入力言語の語彙を所有しない**（どのプロジェクトの文書でも読む立場）。
 * プロジェクト固有メタデータのキー名（integrable-lattice の `habitat` など）は知りようがないので、
 * 未知のキーを拒否しても打ち間違いの検出にはならず、正しい文書を読めなくするだけになる。
 * そのためシステムの `unknownBlockMeta: 'passthrough'` を使い、**値を落とさずそのまま通す**
 * （strip すると画面に出す前にメタデータが黙って消える）。
 *
 * 意味を解釈する検証は、語彙を所有する各プロジェクトの検証ツールが行う。
 */
export const createPreviewRuntimeSchema = (): RuntimeSchema<string, unknown> =>
  createRuntimeSchema<string, unknown>({ unknownBlockMeta: 'passthrough' })
