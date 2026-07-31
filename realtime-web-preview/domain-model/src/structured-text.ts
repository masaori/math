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
import { z } from 'zod'

// --- L1（入力言語）の型と語彙: すべてシステムの再輸出 --------------------------
export {
  BLOCK_KINDS,
  HEADING_LEVELS,
  NODE_TYPES,
  THEOREM_LIKE_KINDS,
  isHeadingBlock,
  type Block,
  type BlockKind,
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
 * `blockMetaKeys` は、その文書のブロックが持つ**プロジェクト固有メタデータのキー名**
 * （integrable-lattice の `habitat` / `realEscape` など。同 §5.4）。
 * システムの実行時スキーマは `.strict()` であり、宣言していないキーを拒否する。
 * 本ビューアは**ドメイン非依存**でキー名を知りえないため、キー名は外から与える
 * （サーバは設定から、ブラウザはレスポンスの `blockMetaKeys` から受け取る）。
 *
 * 値の中身は検査しない（`z.unknown()`）。メタデータの意味を解釈するのは各プロジェクトの
 * 検証ツールであって、体裁を持たない汎用ビューアではない。
 */
export const createPreviewRuntimeSchema = (
  blockMetaKeys: readonly string[] = [],
): RuntimeSchema<string, unknown> =>
  createRuntimeSchema<string, unknown, Record<string, z.ZodTypeAny>>({
    blockMeta: Object.fromEntries(blockMetaKeys.map((key) => [key, z.unknown()])),
  })
