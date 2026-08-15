/**
 * ドメインモデルの公開面。**このシステムの最下層であり、何にも依存しない。**
 *
 * 3 つの層を持つ（docs/domain-model.md §5）:
 *   L1 入力言語   … structured-text/（ブロック・ノード・ラベル・ノート）
 *   L2 文書の集約 … entities/ と api-contract/（文書・版・セグメント）
 *   L3 解決済み文書 … resolved/（採番・参照解決を終えた、出力形式に中立な中間表現）
 *
 * レンダラー（出力器）はこの上に載るモジュールであって、逆ではない。
 */

export { assertNever, err, ok, type Result } from './result.ts'

// --- L1: 入力言語 ------------------------------------------------------------
export {
  BLOCK_KINDS,
  HEADING_LEVELS,
  THEOREM_LIKE_KINDS,
  isHeadingBlock,
  type Block,
  type BlockKind,
  type FigureBlock,
  type FigureKind,
  type HeadingBlock,
  type HeadingKind,
  type HeadingLevel,
  type Note,
  type Origin,
  type TheoremLikeBlock,
  type TheoremLikeKind,
  type Title,
  type TitleContent,
} from './structured-text/block.ts'

export {
  BCP_47_LOCALE_PATTERN,
  canonicalLocaleOf,
  localeRuntimeSchema,
  type Locale,
} from './structured-text/locale.ts'

export {
  NODE_TYPES,
  cite,
  displayMath,
  image,
  list,
  math,
  paragraph,
  text,
  todo,
  type CiteNode,
  type DisplayMathNode,
  type ImageNode,
  type InlineInput,
  type ListNode,
  type MathNode,
  type Node,
  type NodeType,
  type ParagraphNode,
  type RefNode,
  type TextNode,
  type TodoNode,
} from './structured-text/node.ts'

export {
  createStructuredTextSchema,
  type StructuredTextSchema,
} from './structured-text/schema-factory.ts'

export {
  createRuntimeSchema,
  type RuntimeSchema,
  type ValidationIssue,
} from './structured-text/validate.ts'

export type {
  Assert,
  AssertNoDuplicate,
  BlockIdsOf,
  FindDuplicate,
  Identified,
  IdentifiedNote,
  LabelsOf,
  NoDuplicateBlockId,
  NoDuplicateLabel,
  NoDuplicateNoteId,
  NoteIdsOf,
} from './structured-text/uniqueness.ts'

// --- L3: 解決済み文書 --------------------------------------------------------
export { DEFAULT_NUMBERING_POLICY, type CounterKey, type NumberingPolicy } from './resolved/numbering.ts'

export {
  resolve,
  resolveTolerantly,
  type ResolveDiagnostic,
  type ResolveError,
  type ResolveOptions,
  type Resolution,
  type RevisionSnapshot,
  type SegmentKey,
  type SegmentSnapshot,
} from './resolved/resolve.ts'

export {
  availableLocalesOf,
  asSingleLocaleRevision,
  structuralNodesOf,
  validateLocalizedRevision,
  validateLocalizedRevisionSnapshot,
  type DivergenceVerdict,
  type LocalizationAllowance,
  type LocalizationAllowances,
  type LocalizedRevision,
  type LocalizedRevisionSnapshot,
  type LocalizationIssue,
  type LocalizationValidationError,
  type MissingTranslationError,
  type StructuralNode,
  type TranslationDivergence,
} from './resolved/localized-revision.ts'

export {
  resolveLocalized,
  resolveLocalizedTolerantly,
  type LocalizedResolution,
  type LocalizedResolveError,
  type LocalizedResolvedDocument,
} from './resolved/resolve-localized.ts'

export type {
  Audience,
  BlockNumber,
  OutlineEntry,
  ResolvedBlock,
  ResolvedDocument,
  ResolvedFigure,
  ResolvedHeading,
  ResolvedNode,
  ResolvedNote,
  ResolvedRef,
  ResolvedTheoremLike,
  RevisionNumber,
  UnresolvedRef,
} from './resolved/resolved-document.ts'

// --- L2: 公開サイトの配信と受け入れの契約 ------------------------------------
export type {
  DocumentManifest,
  GetFragmentError,
  GetLocalizedManifestError,
  GetLocalizedManifestInput,
  GetManifestError,
  LocalizedDocumentManifest,
  LiveEvent,
  UploadLocalizedSegmentsError,
  UploadLocalizedSegmentsInput,
  UploadSegmentsError,
  UploadSegmentsInput,
} from './api-contract/live-site.ts'

export {
  parseGetLocalizedManifestInput,
} from './api-contract/live-site.ts'
