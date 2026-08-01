/**
 * ローカライズされた版の入力モデルと検証。
 *
 * 既存の `RevisionSnapshot` は 1 ロケール分の入力言語を表す。その形を置換せず、
 * `LocalizedRevisionSnapshot` が同一の document / revision に属する各ロケールの
 * `RevisionSnapshot` を束ねる。これにより既存の日本語だけの文書は従来の
 * `RevisionSnapshot` と `resolve` をそのまま使い続けられる。
 *
 * 翻訳は文言だけを差し替えた別文書ではない。source locale を基準に、文書同一性、
 * セグメント順、ブロックの同一性、ラベル、数式、参照先、引用先、画像資産、および
 * 意味メタデータが同一であることを検証する。そうでない値は翻訳ではなく別の版であり、
 * 同じ Revision に混在させない。
 */

import { z } from 'zod'

import { err, ok, type Result } from '../result.ts'
import type { Block, Note } from '../structured-text/block.ts'
import { localeRuntimeSchema, type Locale } from '../structured-text/locale.ts'
import type { Node } from '../structured-text/node.ts'
import { createRuntimeSchema, type RuntimeSchema, type ValidationIssue } from '../structured-text/validate.ts'
import type { RevisionSnapshot, SegmentSnapshot } from './resolve.ts'

export type LocalizedRevision<L extends string = string, M = unknown> = {
  /** この入力言語版を読むために選ぶロケール。 */
  locale: Locale
  /**
   * 直近の翻訳元。source locale は `null`、翻訳版は存在する別 locale を明示する。
   *
   * 翻訳の作業経路は原文 → 英語 → 他言語のように連鎖してよい。ただし検証は常に
   * source locale の構造を基準に行い、連鎖は必ず source locale へ到達しなければならない。
  */
  translatedFrom: Locale | null
  /** 翻訳元 locale の対応する版番号。原文ロケールでは null。 */
  translatedFromRevision: number | null
  revision: RevisionSnapshot<L, M>
}

/**
 * 同じ文書・同じ revision のロケール別スナップショット。
 *
 * documentId は言語中立の同一性として外側に持つ。版番号はロケールごとに独立であり、
 * 翻訳元との正確な対応は `translatedFromRevision` が明示する。内側の
 * `RevisionSnapshot` は既存の単一ロケール API をそのまま再利用する。
 */
export type LocalizedRevisionSnapshot<L extends string = string, M = unknown> = {
  documentId: string
  sourceLocale: Locale
  localizations: readonly LocalizedRevision<L, M>[]
}

/** 構造ドリフトを含む、ローカライズ集約の不変条件違反。 */
export type LocalizationIssue =
  | { code: 'source_locale_missing'; sourceLocale: Locale }
  | { code: 'duplicate_locale'; locale: Locale }
  | {
      code: 'invalid_translation_source'
      locale: Locale
      translatedFrom: Locale | null
      reason:
        | 'source_locale_must_not_have_translation_source'
        | 'translation_must_have_source'
        | 'self_reference'
        | 'unknown_locale'
        | 'cycle'
        | 'does_not_reach_source_locale'
    }
  | {
      code: 'document_identity_mismatch'
      locale: Locale
      expectedDocumentId: string
      actualDocumentId: string
    }
  | {
      code: 'translation_revision_mismatch'
      locale: Locale
      translatedFrom: Locale
      expectedRevision: number
      actualRevision: number | null
    }
  | { code: 'structural_drift'; locale: Locale; path: string; expected: string; actual: string }

export type LocalizationValidationError =
  | { code: 'localization_validation_error'; issues: readonly ValidationIssue[] }
  | { code: 'invalid_localization'; issues: readonly LocalizationIssue[] }

/** locale を明示して取り出そうとしたが、その翻訳がまだ無い場合のエラー。 */
export type MissingTranslationError = {
  code: 'missing_translation'
  locale: Locale
  availableLocales: readonly Locale[]
}

export const availableLocalesOf = <L extends string, M>(
  localized: LocalizedRevisionSnapshot<L, M>,
): readonly Locale[] => localized.localizations.map((entry) => entry.locale)

/**
 * 既存の単一ロケール RevisionSnapshot をローカライズ集約へ適応する。
 *
 * 既存プロジェクトの `content/` / `notes/` はこの関数を通すだけで、原文ロケール 1 件の
 * 文書として新しい入口を使える。元の `RevisionSnapshot` 自体は変更も複製もされない。
 */
export const asSingleLocaleRevision = <L extends string, M>(
  revision: RevisionSnapshot<L, M>,
  sourceLocale: Locale,
): LocalizedRevisionSnapshot<L, M> => ({
  documentId: revision.documentId,
  sourceLocale,
  localizations: [{ locale: sourceLocale, translatedFrom: null, translatedFromRevision: null, revision }],
})

/**
 * ロケールごとの文書構造を比較するための表示。値そのものを埋め込まず、
 * 診断で比較対象を特定できる形にする。
 */
const kindOf = (value: unknown): string => {
  if (Array.isArray(value)) return `array(${value.length})`
  if (value === null) return 'null'
  return typeof value
}

const sameStringArray = (left: readonly string[], right: readonly string[]): boolean =>
  left.length === right.length && left.every((value, index) => value === right[index])

/** JSON 相当の意味メタデータを比較する。体裁・文言以外を黙って差し替えないため。 */
const deeplyEqual = (left: unknown, right: unknown): boolean => {
  if (Object.is(left, right)) return true
  if (left === null || right === null || typeof left !== 'object' || typeof right !== 'object') {
    return false
  }
  if (Array.isArray(left) || Array.isArray(right)) {
    return (
      Array.isArray(left) &&
      Array.isArray(right) &&
      left.length === right.length &&
      left.every((value, index) => deeplyEqual(value, right[index]))
    )
  }
  const leftRecord = left as Record<string, unknown>
  const rightRecord = right as Record<string, unknown>
  const leftKeys = Object.keys(leftRecord).sort()
  const rightKeys = Object.keys(rightRecord).sort()
  return (
    sameStringArray(leftKeys, rightKeys) &&
    leftKeys.every((key) => deeplyEqual(leftRecord[key], rightRecord[key]))
  )
}

type StructuralNode =
  | { type: 'math'; tex: string }
  | { type: 'displayMath'; tex: string }
  | { type: 'image'; assetKey: string }
  | { type: 'ref'; target: string }
  | { type: 'cite'; keys: readonly string[] }
  | { type: 'paragraph'; children: readonly StructuralNode[] }
  | { type: 'list'; items: readonly (readonly StructuralNode[])[] }

/**
 * 翻訳で変わる文字列を除いたノード骨格。
 *
 * text / todo はロケール固有であり、これらだけで構成された paragraph / list は語順・
 * 文分割を変えられる。そのため骨格から取り除く。一方、数式・参照・引用・画像を含む
 * paragraph / list はそれらの親子関係自体が意味を持つので、コンテナを残して比較する。
 */
const structuralNodesOf = <L extends string>(nodes: readonly Node<L>[]): StructuralNode[] => {
  const structural: StructuralNode[] = []
  for (const node of nodes) {
    switch (node.type) {
      case 'text':
      case 'todo':
        break
      case 'math':
        structural.push({ type: 'math', tex: node.tex })
        break
      case 'displayMath':
        structural.push({ type: 'displayMath', tex: node.tex })
        break
      case 'image':
        structural.push({ type: 'image', assetKey: node.assetKey })
        break
      case 'ref':
        structural.push({ type: 'ref', target: node.target })
        break
      case 'cite':
        structural.push({ type: 'cite', keys: node.keys })
        break
      case 'paragraph': {
        const children = structuralNodesOf(node.children)
        if (children.length > 0) structural.push({ type: 'paragraph', children })
        break
      }
      case 'list': {
        const items = node.items.map((item) => structuralNodesOf(item))
        if (items.some((item) => item.length > 0)) structural.push({ type: 'list', items })
        break
      }
    }
  }
  return structural
}

const theoremMetaOf = <L extends string, M>(block: Block<L, M>): unknown => {
  if (block.kind === 'heading' || block.kind === 'figure') return null
  const {
    id: _id,
    labels: _labels,
    kind: _kind,
    title: _title,
    statement: _statement,
    proof: _proof,
    origin: _origin,
    ...meta
  } = block
  return meta
}

const addDrift = (
  issues: LocalizationIssue[],
  locale: Locale,
  path: string,
  expected: unknown,
  actual: unknown,
): void => {
  issues.push({
    code: 'structural_drift',
    locale,
    path,
    expected: kindOf(expected),
    actual: kindOf(actual),
  })
}

const compareNodes = <L extends string>(
  source: readonly Node<L>[],
  translation: readonly Node<L>[],
  locale: Locale,
  path: string,
  issues: LocalizationIssue[],
): void => {
  const sourceStructure = structuralNodesOf(source)
  const translationStructure = structuralNodesOf(translation)
  if (!deeplyEqual(sourceStructure, translationStructure)) {
    addDrift(issues, locale, path, sourceStructure, translationStructure)
  }
}

const compareNotes = <L extends string>(
  source: readonly Note<L>[] | undefined,
  translation: readonly Note<L>[] | undefined,
  locale: Locale,
  path: string,
  issues: LocalizationIssue[],
): void => {
  const sourceNotes = source ?? []
  const translationNotes = translation ?? []
  if (sourceNotes.length !== translationNotes.length) {
    addDrift(issues, locale, `${path}.length`, sourceNotes, translationNotes)
    return
  }
  sourceNotes.forEach((sourceNote, noteIndex) => {
    const translatedNote = translationNotes[noteIndex]
    if (translatedNote === undefined) return
    const notePath = `${path}[${noteIndex}]`
    if (sourceNote.id !== translatedNote.id) {
      addDrift(issues, locale, `${notePath}.id`, sourceNote.id, translatedNote.id)
    }
    if (!sameStringArray(sourceNote.targets, translatedNote.targets)) {
      addDrift(issues, locale, `${notePath}.targets`, sourceNote.targets, translatedNote.targets)
    }
    // title は完全にロケール固有。body は本文と同じノード境界で比較する。
    compareNodes(sourceNote.body, translatedNote.body, locale, `${notePath}.body`, issues)
  })
}

const compareBlocks = <L extends string, M>(
  source: readonly Block<L, M>[],
  translation: readonly Block<L, M>[],
  locale: Locale,
  path: string,
  issues: LocalizationIssue[],
): void => {
  if (source.length !== translation.length) {
    addDrift(issues, locale, `${path}.length`, source, translation)
    return
  }
  source.forEach((sourceBlock, blockIndex) => {
    const translatedBlock = translation[blockIndex]
    if (translatedBlock === undefined) return
    const blockPath = `${path}[${blockIndex}]`
    if (sourceBlock.id !== translatedBlock.id) {
      addDrift(issues, locale, `${blockPath}.id`, sourceBlock.id, translatedBlock.id)
      return
    }
    if (sourceBlock.kind !== translatedBlock.kind) {
      addDrift(issues, locale, `${blockPath}.kind`, sourceBlock.kind, translatedBlock.kind)
      return
    }
    if (!sameStringArray(sourceBlock.labels, translatedBlock.labels)) {
      addDrift(issues, locale, `${blockPath}.labels`, sourceBlock.labels, translatedBlock.labels)
    }
    if (sourceBlock.kind === 'heading' && translatedBlock.kind === 'heading') {
      if (sourceBlock.level !== translatedBlock.level) {
        addDrift(issues, locale, `${blockPath}.level`, sourceBlock.level, translatedBlock.level)
      }
      // TitleContent（text / tex のいずれも）はロケール固有。形の検証は各 locale の
      // RuntimeSchema が済ませるので、ここでは比較しない。
      return
    }
    if (sourceBlock.kind === 'figure' && translatedBlock.kind === 'figure') {
      compareNodes(sourceBlock.content, translatedBlock.content, locale, `${blockPath}.content`, issues)
      compareNodes(sourceBlock.caption ?? [], translatedBlock.caption ?? [], locale, `${blockPath}.caption`, issues)
      return
    }
    if (
      sourceBlock.kind !== 'heading' &&
      sourceBlock.kind !== 'figure' &&
      translatedBlock.kind !== 'heading' &&
      translatedBlock.kind !== 'figure'
    ) {
      if (!deeplyEqual(theoremMetaOf(sourceBlock), theoremMetaOf(translatedBlock))) {
        addDrift(
          issues,
          locale,
          `${blockPath}.meta`,
          theoremMetaOf(sourceBlock),
          theoremMetaOf(translatedBlock),
        )
      }
      compareNodes(sourceBlock.statement, translatedBlock.statement, locale, `${blockPath}.statement`, issues)
      compareNodes(sourceBlock.proof ?? [], translatedBlock.proof ?? [], locale, `${blockPath}.proof`, issues)
    }
  })
}

const compareSegments = <L extends string, M>(
  source: readonly SegmentSnapshot<L, M>[],
  translation: readonly SegmentSnapshot<L, M>[],
  locale: Locale,
  issues: LocalizationIssue[],
): void => {
  if (source.length !== translation.length) {
    addDrift(issues, locale, 'segments.length', source, translation)
    return
  }
  source.forEach((sourceSegment, segmentIndex) => {
    const translatedSegment = translation[segmentIndex]
    if (translatedSegment === undefined) return
    const segmentPath = `segments[${segmentIndex}]`
    if (sourceSegment.key !== translatedSegment.key) {
      addDrift(issues, locale, `${segmentPath}.key`, sourceSegment.key, translatedSegment.key)
      return
    }
    compareBlocks(sourceSegment.blocks, translatedSegment.blocks, locale, `${segmentPath}.blocks`, issues)
    compareNotes(sourceSegment.notes, translatedSegment.notes, locale, `${segmentPath}.notes`, issues)
  })
}

/**
 * 型付きのローカライズ版に対する集約不変条件の検証。
 *
 * raw JSON の形を検査する `validateLocalizedRevisionSnapshot` と分けることで、既に
 * TypeScript 型を持つ呼び出し側も source locale・翻訳元・構造ドリフトを必ず検査できる。
 */
export const validateLocalizedRevision = <L extends string, M>(
  localized: LocalizedRevisionSnapshot<L, M>,
): Result<LocalizedRevisionSnapshot<L, M>, LocalizationValidationError> => {
  // TypeScript 上の Locale は著者側のリテラルを保つため string のままである。`as` や
  // 動的生成で境界を迂回した値もあるので、型付き入口でも locale 値域は再確認する。
  const localeValueIssues: ValidationIssue[] = []
  const checkLocale = (value: Locale, path: string): void => {
    const parsed = localeRuntimeSchema.safeParse(value)
    if (!parsed.success) localeValueIssues.push(...issuesOfZodError(parsed.error, path))
  }
  checkLocale(localized.sourceLocale, 'sourceLocale')
  localized.localizations.forEach((entry, index) => {
    checkLocale(entry.locale, `localizations[${index}].locale`)
    if (entry.translatedFrom !== null) {
      checkLocale(entry.translatedFrom, `localizations[${index}].translatedFrom`)
    }
  })
  if (localeValueIssues.length > 0) {
    return err({ code: 'localization_validation_error', issues: localeValueIssues })
  }

  const issues: LocalizationIssue[] = []
  const localeCounts = new Map<Locale, number>()
  for (const entry of localized.localizations) {
    localeCounts.set(entry.locale, (localeCounts.get(entry.locale) ?? 0) + 1)
  }
  for (const [locale, count] of localeCounts) {
    if (count > 1) issues.push({ code: 'duplicate_locale', locale })
  }

  const sourceEntries = localized.localizations.filter(
    (entry) => entry.locale === localized.sourceLocale,
  )
  if (sourceEntries.length === 0) {
    issues.push({ code: 'source_locale_missing', sourceLocale: localized.sourceLocale })
  }

  const localeByName = new Map(localized.localizations.map((entry) => [entry.locale, entry]))
  for (const entry of localized.localizations) {
    if (entry.revision.documentId !== localized.documentId) {
      issues.push({
        code: 'document_identity_mismatch',
        locale: entry.locale,
        expectedDocumentId: localized.documentId,
        actualDocumentId: entry.revision.documentId,
      })
    }
    if (entry.locale === localized.sourceLocale) {
      if (entry.translatedFrom !== null || entry.translatedFromRevision !== null) {
        issues.push({
          code: 'invalid_translation_source',
          locale: entry.locale,
          translatedFrom: entry.translatedFrom,
          reason: 'source_locale_must_not_have_translation_source',
        })
      }
      continue
    }
    if (entry.translatedFrom === null) {
      issues.push({
        code: 'invalid_translation_source',
        locale: entry.locale,
        translatedFrom: null,
        reason: 'translation_must_have_source',
      })
      continue
    }
    if (entry.translatedFromRevision === null) {
      issues.push({
        code: 'translation_revision_mismatch',
        locale: entry.locale,
        translatedFrom: entry.translatedFrom,
        expectedRevision: localeByName.get(entry.translatedFrom)?.revision.revision ?? -1,
        actualRevision: null,
      })
    }
    if (entry.translatedFrom === entry.locale) {
      issues.push({
        code: 'invalid_translation_source',
        locale: entry.locale,
        translatedFrom: entry.translatedFrom,
        reason: 'self_reference',
      })
    } else if (!localeByName.has(entry.translatedFrom)) {
      issues.push({
        code: 'invalid_translation_source',
        locale: entry.locale,
        translatedFrom: entry.translatedFrom,
        reason: 'unknown_locale',
      })
    }
    const sourceEntry = localeByName.get(entry.translatedFrom)
    if (sourceEntry !== undefined && entry.translatedFromRevision !== sourceEntry.revision.revision) {
      issues.push({
        code: 'translation_revision_mismatch',
        locale: entry.locale,
        translatedFrom: entry.translatedFrom,
        expectedRevision: sourceEntry.revision.revision,
        actualRevision: entry.translatedFromRevision,
      })
    }
  }

  // 各翻訳元の連鎖を原文まで辿る。翻訳の基準文言は中間 locale に置けるが、構造の
  // 基準は常に source locale である。循環・原文へ届かない鎖を別々に診断する。
  for (const entry of localized.localizations) {
    if (entry.locale === localized.sourceLocale || entry.translatedFrom === null) continue
    const visited = new Set<Locale>([entry.locale])
    let cursor: Locale | null = entry.translatedFrom
    let reachesSource = false
    while (cursor !== null) {
      if (cursor === localized.sourceLocale) {
        reachesSource = true
        break
      }
      if (visited.has(cursor)) {
        issues.push({
          code: 'invalid_translation_source',
          locale: entry.locale,
          translatedFrom: entry.translatedFrom,
          reason: 'cycle',
        })
        break
      }
      visited.add(cursor)
      const ancestor = localeByName.get(cursor)
      if (ancestor === undefined) break
      cursor = ancestor.translatedFrom
    }
    if (!reachesSource && !issues.some(
      (issue) =>
        issue.code === 'invalid_translation_source' &&
        issue.locale === entry.locale &&
        issue.reason === 'cycle',
    )) {
      issues.push({
        code: 'invalid_translation_source',
        locale: entry.locale,
        translatedFrom: entry.translatedFrom,
        reason: 'does_not_reach_source_locale',
      })
    }
  }

  const source = sourceEntries[0]
  if (source !== undefined) {
    for (const translation of localized.localizations) {
      if (translation.locale === localized.sourceLocale) continue
      compareSegments(source.revision.segments, translation.revision.segments, translation.locale, issues)
    }
  }
  return issues.length === 0 ? ok(localized) : err({ code: 'invalid_localization', issues })
}

const localizedRevisionEnvelopeSchema = z
  .object({
    documentId: z.string().min(1),
    sourceLocale: localeRuntimeSchema,
    localizations: z
      .array(
        z
          .object({
            locale: localeRuntimeSchema,
            translatedFrom: localeRuntimeSchema.nullable(),
            translatedFromRevision: z.number().int().positive().nullable(),
            revision: z
              .object({
                documentId: z.string().min(1),
                revision: z.number().int().positive(),
                segments: z.array(
                  z
                    .object({
                      key: z.string().min(1),
                      blocks: z.array(z.unknown()),
                      notes: z.array(z.unknown()).optional(),
                    })
                    .strict(),
                ),
              })
              .strict(),
          })
          .strict(),
      )
      .min(1),
  })
  .strict()

const issuesOfZodError = (error: z.ZodError, prefix: string): ValidationIssue[] =>
  error.issues.map((issue) => ({
    path: [prefix, ...issue.path.map(String)].filter((part) => part !== '').join('.'),
    message: issue.message,
  }))

/**
 * raw JSON をローカライズされた版として受け入れる境界。
 *
 * locale の BCP 47 形式、版・セグメントの外枠、そして各 locale の Block / Note は
 * RuntimeSchema を通す。後者を省くと、翻訳版だけ title の形が壊れても構造比較で
 * 見逃すので、必ず全 locale を個別に検査する。
 */
export const validateLocalizedRevisionSnapshot = <L extends string = string, M = unknown>(
  value: unknown,
  runtimeSchema: RuntimeSchema<L, M> = createRuntimeSchema<L, M>(),
  where = 'localizedRevision',
): Result<LocalizedRevisionSnapshot<L, M>, LocalizationValidationError> => {
  const envelope = localizedRevisionEnvelopeSchema.safeParse(value)
  if (!envelope.success) {
    return err({ code: 'localization_validation_error', issues: issuesOfZodError(envelope.error, where) })
  }

  const validationIssues: ValidationIssue[] = []
  const localizations: LocalizedRevision<L, M>[] = []
  envelope.data.localizations.forEach((entry, localeIndex) => {
    const segments: SegmentSnapshot<L, M>[] = []
    entry.revision.segments.forEach((segment, segmentIndex) => {
      const segmentPath = `${where}.localizations[${localeIndex}].revision.segments[${segmentIndex}]`
      const blocks = runtimeSchema.validateBlocks(segment.blocks, `${segmentPath}.blocks`)
      const notes =
        segment.notes === undefined
          ? ok<readonly Note<L>[]>([])
          : runtimeSchema.validateNotes(segment.notes, `${segmentPath}.notes`)
      if (!blocks.success) validationIssues.push(...blocks.error)
      if (!notes.success) validationIssues.push(...notes.error)
      if (blocks.success && notes.success) {
        segments.push({
          key: segment.key,
          blocks: blocks.data,
          ...(segment.notes === undefined ? {} : { notes: notes.data }),
        })
      }
    })
    if (segments.length === entry.revision.segments.length) {
      localizations.push({
        locale: entry.locale,
        translatedFrom: entry.translatedFrom,
        translatedFromRevision: entry.translatedFromRevision,
        revision: {
          documentId: entry.revision.documentId,
          revision: entry.revision.revision,
          segments,
        },
      })
    }
  })
  if (validationIssues.length > 0) {
    return err({ code: 'localization_validation_error', issues: validationIssues })
  }
  return validateLocalizedRevision({
    documentId: envelope.data.documentId,
    sourceLocale: envelope.data.sourceLocale,
    localizations,
  })
}
