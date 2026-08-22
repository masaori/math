/**
 * 生成物のレンダリング（純関数。決定性・冪等性を持つ）。
 *
 * 生成するのは 2 つ:
 *   1. `labels.generated.ts`   … 実在するラベルのユニオン型 `Label`
 *   2. `document.generated.ts` … 全ファイルを 1 本のタプル型へ連結し、
 *                                **ファイルを跨いだ一意性**をコンパイル時に主張するモジュール
 *
 * なぜ 2 が要るか: 1 ファイル内の重複は `defineBlocks` の型引数で落とせるが、
 * **ファイルを跨いだ重複**は、その 2 ファイルを同時に見る場所が無いと型で判定できない。
 * 全ファイルを import して連結する生成モジュールが、その「同時に見る場所」になる。
 */

const identifierFor = (prefix: string, fileName: string): string =>
  `${prefix}_${fileName.replace(/\.ts$/, '').replace(/[^A-Za-z0-9_]/g, '_')}`

export const renderLabels = (
  sortedLabels: readonly string[],
  sortedTranslationOnlyLabels: readonly string[] = [],
): string => {
  const body = sortedLabels.map((label) => `  ${JSON.stringify(label)},`).join('\n')
  const translationOnlyBody = sortedTranslationOnlyLabels
    .map((label) => `  ${JSON.stringify(label)},`)
    .join('\n')
  return `// 自動生成ファイル — 直接編集しない。
// 生成元: content/ の全ブロックの labels（と、翻訳ロケールにしか無いブロックの labels）
// 再生成: node <system>/codegen/structured-text-index/cli.ts --project <このディレクトリ>
//
// このユニオン型が「実在するラベル」の全体であり、ref() / ノートの targets は
// これ以外を受け付けない。存在しないラベルへの参照はコンパイル時に落ちる。

export const ALL_LABELS = [
${body}
] as const

/** content/ に実在するラベル。相互参照はこの型の値しか指せない。 */
export type Label = (typeof ALL_LABELS)[number]

/**
 * 翻訳ロケールにしか無いブロックのラベル（locales.config.ts が理由つきで認めたもの）。
 * **原文はこれを指せない**。原文から指せば、原文の解決で未解決参照になる。
 */
export const TRANSLATION_ONLY_LABELS = [
${translationOnlyBody}
] as const

export type TranslationOnlyLabel = (typeof TRANSLATION_ONLY_LABELS)[number]

/** 翻訳ロケールの content が使うラベル。原文のラベルに翻訳限定のものを足しただけ。 */
export type AnyLocaleLabel = Label | TranslationOnlyLabel
`
}

/** 翻訳ロケール 1 件ぶんの入力（生成物へ型検査の対象として取り込む）。 */
export type TranslationRender = {
  locale: string
  /** プロジェクト root からの相対ディレクトリ（POSIX 区切り）。 */
  contentDir: string
  files: readonly string[]
}

const localeSuffix = (locale: string): string => locale.replace(/[^A-Za-z0-9_]/g, '_')

export const renderDocument = (options: {
  /** このファイルから見た domain-model の import 指定子（例: `../../domain-model/index.ts`）。 */
  domainModelSpecifier: string
  contentFiles: readonly string[]
  /** 木を正本にするファイル。未指定のファイルは従来のブロックタプル。 */
  structuredContent?: Readonly<Record<string, 'sections' | 'documentStructure'>>
  noteFiles: readonly string[]
  translations?: readonly TranslationRender[]
}): string => {
  const structuredTypeImports = [
    Object.values(options.structuredContent ?? {}).includes('documentStructure')
      ? '  BlocksOfDocumentStructure,'
      : undefined,
    Object.values(options.structuredContent ?? {}).includes('sections')
      ? '  BlocksOfSections,'
      : undefined,
  ].filter((line): line is string => line !== undefined).join('\n')
  const renderedStructuredTypeImports = structuredTypeImports === '' ? '' : `${structuredTypeImports}\n`
  const contentImports = options.contentFiles
    .map((file) => `import ${identifierFor('blocks', file)} from './content/${file}'`)
    .join('\n')
  const noteImports = options.noteFiles
    .map((file) => `import ${identifierFor('notes', file)} from './notes/${file}'`)
    .join('\n')
  const contentSpread = options.contentFiles
    .map((file) => {
      const identifier = identifierFor('blocks', file)
      const kind = options.structuredContent?.[file]
      if (kind === 'sections') return `  ...BlocksOfSections<typeof ${identifier}>,`
      if (kind === 'documentStructure') return `  ...BlocksOfDocumentStructure<typeof ${identifier}>,`
      return `  ...typeof ${identifier},`
    })
    .join('\n')
  const noteSpread = options.noteFiles
    .map((file) => `  ...typeof ${identifierFor('notes', file)},`)
    .join('\n')

  const translations = options.translations ?? []
  const translationImports = translations
    .flatMap((translation) =>
      translation.files.map(
        (file) =>
          `import ${identifierFor(`blocks_${localeSuffix(translation.locale)}`, file)} ` +
          `from './${translation.contentDir}/${file}'`,
      ),
    )
    .join('\n')
  const translationSections = translations
    .map((translation) => {
      const suffix = localeSuffix(translation.locale)
      const spread = translation.files
        .map((file) => `  ...typeof ${identifierFor(`blocks_${suffix}`, file)},`)
        .join('\n')
      return `
/** 翻訳ロケール ${translation.locale} の全ブロック（文書順）。 */
export type AllBlocks_${suffix} = ${spread === '' ? '[]' : `[\n${spread}\n]`}

export type _TranslationBlocksAreBlocks_${suffix} = Assert<
  AllBlocks_${suffix} extends readonly Block<AnyLocaleLabel>[] ? true : never
>
export type _TranslationIsNotEmpty_${suffix} = Assert<AllBlocks_${suffix} extends readonly [] ? never : true>
export type _UniqueTranslationBlockIds_${suffix} = AssertNoDuplicate<
  FindDuplicate<BlockIdsOf<AllBlocks_${suffix}>>
>
export type _UniqueTranslationLabels_${suffix} = AssertNoDuplicate<
  FindDuplicate<LabelsOf<AllBlocks_${suffix}>>
>`
    })
    .join('\n')
  const translationLabelUnion = translations
    .map((translation) => `LabelsOf<AllBlocks_${localeSuffix(translation.locale)}>[number]`)
    .join(' | ')
  const translationLabelChecks =
    translations.length === 0
      ? ''
      : `
/** 翻訳ロケールが実際に持つラベルの全体。 */
type AllTranslationLabels = ${translationLabelUnion}

/** 生成した TranslationOnlyLabel と、翻訳ロケールの実状が一致すること（両方向）。 */
export type _NoStaleTranslationOnlyLabel = AssertNoDuplicate<
  Exclude<TranslationOnlyLabel, AllTranslationLabels>
>
export type _NoMissingTranslationOnlyLabel = AssertNoDuplicate<
  Exclude<AllTranslationLabels, AnyLocaleLabel>
>
`

  return `// 自動生成ファイル — 直接編集しない。
// 生成元: content/ notes/ のファイル一覧
// 再生成: node <system>/codegen/structured-text-index/cli.ts --project <このディレクトリ>
//
// 文書全体を 1 本のタプル型へ連結し、**ファイルを跨いだ一意性**をコンパイル時に主張する。
// 1 ファイル内の重複は defineBlocks / defineNotes の型引数が落とすが、ファイル間の重複は
// 両方を同時に見るこのモジュールでしか判定できない。実行時には誰も import しない
// （型検査の対象に入れるためだけに存在する）。

import type {
  Assert,
  AssertNoDuplicate,
  Block,
  BlockIdsOf,
${renderedStructuredTypeImports}  FindDuplicate,
  LabelsOf,
  Note,
  NoteIdsOf,
} from '${options.domainModelSpecifier}'
import type { AnyLocaleLabel, Label, TranslationOnlyLabel } from './labels.generated.ts'
${contentImports}
${noteImports}
${translationImports}

/** 文書順（キー昇順 × 配列順）に連結した全ブロック。 */
export type AllBlocks = ${contentSpread === '' ? '[]' : `[\n${contentSpread}\n]`}

/** 全ノート。 */
export type AllNotes = ${noteSpread === '' ? '[]' : `[\n${noteSpread}\n]`}

type AllBlockIds = BlockIdsOf<AllBlocks>
type AllNoteIds = NoteIdsOf<AllNotes>
type AllLabels = LabelsOf<AllBlocks>

/**
 * 型が壊れていないことの確認（ここが落ちたら生成物かスキーマの不整合）。
 * Assert<T extends true> の制約で包む。制約なしの "A extends B ? true : never" だと
 * 条件が偽でも「never という別名が定義されるだけ」でエラーにならない。
 */
export type _BlocksAreBlocks = Assert<AllBlocks extends readonly Block<Label>[] ? true : never>
export type _NotesAreNotes = Assert<AllNotes extends readonly Note<Label>[] ? true : never>

/** content が空でないこと（I3。空なら「0 件で検証通過」という無意味な状態になる）。 */
export type _ContentIsNotEmpty = Assert<AllBlocks extends readonly [] ? never : true>

/** ブロック id・ノート id・ラベルは文書全体で一意（I1）。重複するとその値が型エラーに出る。 */
export type _UniqueBlockIds = AssertNoDuplicate<FindDuplicate<AllBlockIds>>
export type _UniqueNoteIds = AssertNoDuplicate<FindDuplicate<AllNoteIds>>
export type _UniqueLabels = AssertNoDuplicate<FindDuplicate<AllLabels>>

/** ノート id はブロック id とも衝突しない（アンカーが一意に決まらなくなるため）。 */
export type _NoIdCollision = AssertNoDuplicate<FindDuplicate<[...AllBlockIds, ...AllNoteIds]>>

/** labels.generated.ts と content の実状が一致すること（両方向）。 */
export type _NoStaleGeneratedLabel = AssertNoDuplicate<Exclude<Label, AllLabels[number]>>
export type _NoMissingGeneratedLabel = AssertNoDuplicate<Exclude<AllLabels[number], Label>>

/** 翻訳ロケール用のラベル型は原文のラベルを必ず含む。 */
export type _AnyLocaleLabelIncludesLabel = Assert<Label extends AnyLocaleLabel ? true : never>

/** 翻訳限定のラベルは原文のラベルと交わらない（交わればどちらの版のものか決まらない）。 */
export type _TranslationOnlyLabelIsDisjoint = AssertNoDuplicate<Extract<TranslationOnlyLabel, Label>>
${translationSections}${translationLabelChecks}`
}
