/**
 * `@rwp/domain-model` の公開面。
 *
 * 構造化テキスト（入力言語）の正本は本パッケージではなく、リポジトリ直下の
 * `structured-latex/`（システム）にある。ここはその再輸出と、ビューア固有の
 * 寛容なラベル解決・ノート配置、API 契約だけを持つ。
 */

export {
  BLOCK_KINDS,
  HEADING_LEVELS,
  NODE_TYPES,
  THEOREM_LIKE_KINDS,
  createPreviewRuntimeSchema,
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
} from './structured-text.js'

export {
  buildLabelIndex,
  placeNotes,
  type LabelIndex,
  type NotePlacement,
} from './note-placement.js'

export {
  RELOAD_EVENT,
  errorResponseSchema,
  loadDocumentErrorSchema,
  parseDocumentResponse,
  validationIssueSchema,
  type DocumentResponseBody,
  type ErrorResponseBody,
  type LoadDocumentError,
  type LoadDocumentErrorCode,
} from './api-contract.js'

export { assertNever, err, ok, type Result } from './result.js'
