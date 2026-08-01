import assert from 'node:assert/strict'
import { test } from 'node:test'

import type { Block } from '../structured-text/block.ts'
import { cite, image, math, paragraph, text } from '../structured-text/node.ts'
import { DEFAULT_NUMBERING_POLICY } from './numbering.ts'
import {
  asSingleLocaleRevision,
  validateLocalizedRevision,
  validateLocalizedRevisionSnapshot,
  type LocalizedRevisionSnapshot,
} from './localized-revision.ts'
import { resolveLocalized, resolveLocalizedTolerantly } from './resolve-localized.ts'
import type { RevisionSnapshot } from './resolve.ts'

const options = { numbering: DEFAULT_NUMBERING_POLICY, audience: 'working' as const }

const sourceBlocks: readonly Block[] = [
  { id: 'heading', kind: 'heading', level: 1, labels: ['sec:intro'], title: { text: '導入' } },
  {
    id: 'claim',
    kind: 'claim',
    labels: ['claim:main'],
    title: { text: '主張' },
    statement: [
      paragraph([
        text('数式'),
        math('x^2'),
        { type: 'ref', target: 'claim:main' },
        cite(['Reference2026']),
        image('figure:overview', '概要図'),
        text('を使う'),
      ]),
    ],
  },
]

const translatedBlocks: readonly Block[] = [
  { id: 'heading', kind: 'heading', level: 1, labels: ['sec:intro'], title: { tex: '\\text{Introduction}' } },
  {
    id: 'claim',
    kind: 'claim',
    labels: ['claim:main'],
    title: { text: 'Claim' },
    // 文言だけの段落を list へ分けても、数式を含む paragraph の骨格は同じなので許可する。
    statement: [
      paragraph([
        text('We use'),
        math('x^2'),
        { type: 'ref', target: 'claim:main', label: 'this claim' },
        cite(['Reference2026'], 'p. 1'),
        image('figure:overview', 'Overview'),
      ]),
      { type: 'list', items: [[text('here')]] },
    ],
  },
]

const localized = (): LocalizedRevisionSnapshot => ({
  documentId: 'document',
  sourceLocale: 'ja',
  localizations: [
    {
      locale: 'ja',
      translatedFrom: null,
      translatedFromRevision: null,
      revision: {
        documentId: 'document',
        revision: 3,
        segments: [
          {
            key: '001',
            blocks: sourceBlocks,
            notes: [{ id: 'note', targets: ['claim:main'], title: { text: '補足' }, body: [text('補足本文')] }],
          },
        ],
      },
    },
    {
      locale: 'en',
      translatedFrom: 'ja',
      translatedFromRevision: 3,
      revision: {
        documentId: 'document',
        revision: 3,
        segments: [
          {
            key: '001',
            blocks: translatedBlocks,
            notes: [
              { id: 'note', targets: ['claim:main'], title: { text: 'Note' }, body: [text('Translated')] },
            ],
          },
        ],
      },
    },
  ],
})

test('既存の単一 RevisionSnapshot は ja 原文だけのローカライズ版へ可逆に適応できる', () => {
  const revision: RevisionSnapshot = {
    documentId: 'legacy',
    revision: 1,
    segments: [{ key: '001', blocks: [{ id: 'c', kind: 'claim', labels: [], statement: [] }] }],
  }
  const result = resolveLocalized(asSingleLocaleRevision(revision, 'ja'), 'ja', options)
  assert.equal(result.success, true)
  if (!result.success) return
  assert.equal(result.data.documentId, 'legacy')
  assert.equal(result.data.sourceLocale, 'ja')
  assert.equal(result.data.locale, 'ja')
  assert.equal(result.data.translatedFrom, null)
  assert.equal(result.data.translatedFromRevision, null)
  assert.deepEqual(result.data.availableLocales, ['ja'])
})

test('英訳は原文と同じ構造なら、題名・本文・純テキストの段落形を変えても解決できる', () => {
  const result = resolveLocalized(localized(), 'en', options)
  assert.equal(result.success, true)
  if (!result.success) return
  assert.equal(result.data.sourceLocale, 'ja')
  assert.equal(result.data.locale, 'en')
  assert.equal(result.data.translatedFrom, 'ja')
  assert.equal(result.data.translatedFromRevision, 3)
  assert.deepEqual(result.data.availableLocales, ['ja', 'en'])
  assert.equal(result.data.blocks[0]?.kind === 'heading' && result.data.blocks[0].title.tex, '\\text{Introduction}')
})

test('翻訳版は原文と独立した版番号を持ち、翻訳元の版番号で対応を明示する', () => {
  const value = localized()
  const independentlyVersioned: LocalizedRevisionSnapshot = {
    ...value,
    localizations: value.localizations.map((entry) =>
      entry.locale === 'en'
        ? { ...entry, revision: { ...entry.revision, revision: 1 }, translatedFromRevision: 3 }
        : entry,
    ),
  }
  const resolved = resolveLocalized(independentlyVersioned, 'en', options)
  assert.equal(resolved.success, true)
  assert.equal(resolved.success && resolved.data.revision, 1)

  const wrongSourceRevision: LocalizedRevisionSnapshot = {
    ...independentlyVersioned,
    localizations: independentlyVersioned.localizations.map((entry) =>
      entry.locale === 'en' ? { ...entry, translatedFromRevision: 2 } : entry,
    ),
  }
  const invalid = validateLocalizedRevision(wrongSourceRevision)
  assert.equal(invalid.success, false)
  assert.ok(
    invalid.success === false &&
      invalid.error.code === 'invalid_localization' &&
      invalid.error.issues.some((issue) => issue.code === 'translation_revision_mismatch'),
  )
})

test('翻訳元は連鎖してよいが、原文へ到達しなければならない', () => {
  const value = localized()
  const english = value.localizations[1]
  if (english === undefined) throw new Error('fixture is incomplete')
  const chained: LocalizedRevisionSnapshot = {
    ...value,
    localizations: [
      ...value.localizations,
      { locale: 'en-GB', translatedFrom: 'en', translatedFromRevision: 3, revision: { ...english.revision } },
    ],
  }
  assert.equal(validateLocalizedRevision(chained).success, true)

  const cycle: LocalizedRevisionSnapshot = {
    ...chained,
    localizations: chained.localizations.map((entry) =>
      entry.locale === 'en' ? { ...entry, translatedFrom: 'en-GB' } : entry,
    ),
  }
  const result = validateLocalizedRevision(cycle)
  assert.equal(result.success, false)
  assert.ok(
    result.success === false &&
      result.error.code === 'invalid_localization' &&
      result.error.issues.some(
        (issue) => issue.code === 'invalid_translation_source' && issue.reason === 'cycle',
      ),
  )
})

test('原文不在、重複 locale、不正な翻訳元は集約不変条件違反として検出する', () => {
  const invalid: LocalizedRevisionSnapshot = {
    ...localized(),
    sourceLocale: 'fr',
    localizations: [
      ...localized().localizations,
      {
        ...localized().localizations[1]!,
        locale: 'en',
        translatedFrom: 'en',
      },
    ],
  }
  const result = validateLocalizedRevision(invalid)
  assert.equal(result.success, false)
  if (result.success || result.error.code !== 'invalid_localization') return
  assert.ok(result.error.issues.some((issue) => issue.code === 'source_locale_missing'))
  assert.ok(result.error.issues.some((issue) => issue.code === 'duplicate_locale'))
  assert.ok(
    result.error.issues.some(
      (issue) => issue.code === 'invalid_translation_source' && issue.reason === 'self_reference',
    ),
  )
})

test('数式・参照先・引用先・画像資産の共有骨格が変われば構造ドリフトになる', () => {
  const value = localized()
  const drifts: readonly [string, (nodes: Array<Record<string, unknown>>) => void][] = [
    ['数式', (nodes) => {
      nodes[1]!.tex = 'y^2'
    }],
    ['参照先', (nodes) => {
      nodes[2]!.target = 'sec:intro'
    }],
    ['引用キー', (nodes) => {
      nodes[3]!.keys = ['Other2026']
    }],
    ['画像資産', (nodes) => {
      nodes[4]!.assetKey = 'figure:other'
    }],
  ]
  for (const [name, mutate] of drifts) {
    const drifted = JSON.parse(JSON.stringify(value))
    const nodes = drifted.localizations[1].revision.segments[0].blocks[1].statement[0]
      .children as Array<Record<string, unknown>>
    mutate(nodes)
    const result = validateLocalizedRevisionSnapshot(drifted)
    assert.equal(result.success, false, name)
    assert.ok(
      result.success === false &&
        result.error.code === 'invalid_localization' &&
        result.error.issues.some(
          (issue) => issue.code === 'structural_drift' && issue.path.endsWith('.statement'),
        ),
      name,
    )
  }
})

test('要求された locale が無ければ原文へフォールバックせず missing_translation にする', () => {
  const value = localized()
  const sourceOnly: LocalizedRevisionSnapshot = { ...value, localizations: [value.localizations[0]!] }
  assert.deepEqual(resolveLocalized(sourceOnly, 'en', options), {
    success: false,
    error: { code: 'missing_translation', locale: 'en', availableLocales: ['ja'] },
  })
  assert.deepEqual(resolveLocalizedTolerantly(sourceOnly, 'en', options), {
    success: false,
    error: { code: 'missing_translation', locale: 'en', availableLocales: ['ja'] },
  })
})

test('解決入口の要求 locale は BCP 47 でなければ missing_translation ではなく入力エラーになる', () => {
  const expected = { success: false, error: { code: 'localization_validation_error' } }
  const strict = resolveLocalized(localized(), 'english', options)
  const tolerant = resolveLocalizedTolerantly(localized(), 'english', options)
  assert.equal(strict.success, expected.success)
  assert.equal(strict.success === false && strict.error.code, expected.error.code)
  assert.equal(tolerant.success, expected.success)
  assert.equal(tolerant.success === false && tolerant.error.code, expected.error.code)
})

test('外部 JSON は BCP 47 でない locale と各 locale の壊れた TitleContent を Result で拒否する', () => {
  const invalidLocale = validateLocalizedRevisionSnapshot({ ...localized(), sourceLocale: 'ja--JP' })
  assert.equal(invalidLocale.success, false)
  assert.equal(invalidLocale.success === false && invalidLocale.error.code, 'localization_validation_error')

  const nonCanonicalLocale = validateLocalizedRevision({
    ...localized(),
    sourceLocale: 'JA',
    localizations: localized().localizations.map((entry) =>
      entry.locale === 'ja' ? { ...entry, locale: 'JA' } : entry,
    ),
  })
  assert.equal(nonCanonicalLocale.success, false)
  assert.equal(
    nonCanonicalLocale.success === false && nonCanonicalLocale.error.code,
    'localization_validation_error',
  )

  const invalidTitle = validateLocalizedRevisionSnapshot({
    ...localized(),
    localizations: localized().localizations.map((entry) =>
      entry.locale === 'en'
        ? {
            ...entry,
            revision: {
              ...entry.revision,
              segments: entry.revision.segments.map((segment) => ({
                ...segment,
                blocks: segment.blocks.map((block) =>
                  block.id === 'heading' ? { ...block, title: {} } : block,
                ),
              })),
            },
          }
        : entry,
    ),
  })
  assert.equal(invalidTitle.success, false)
  assert.equal(invalidTitle.success === false && invalidTitle.error.code, 'localization_validation_error')
})

test('寛容なローカライズ解決は、選択 locale 内の未解決参照を diagnostics として残す', () => {
  const value = localized()
  const broken: LocalizedRevisionSnapshot = {
    ...value,
    // 原文と翻訳の双方で同じ未解決参照を持たせる。ローカライズ構造は正しいまま、
    // 通常の文書解決だけが壊れている状態になる。
    localizations: value.localizations.map((entry) => ({
      ...entry,
      revision: {
        ...entry.revision,
        segments: entry.revision.segments.map((segment) => ({
          ...segment,
          blocks: segment.blocks.map((block) =>
            block.kind !== 'claim' || block.id !== 'claim'
              ? block
              : { ...block, statement: [{ type: 'ref', target: 'missing' }] },
          ),
        })),
      },
    })),
  }
  const result = resolveLocalizedTolerantly(broken, 'en', options)
  assert.equal(result.success, true)
  assert.deepEqual(
    result.success ? result.data.diagnostics : [],
    [{ code: 'unresolved_reference', fromBlockId: 'claim', target: 'missing' }],
  )
})
