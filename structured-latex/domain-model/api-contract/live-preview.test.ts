/**
 * ライブプレビューの配信契約の単体テスト。
 * 境界（HTTP レスポンス）で throw せず Result になること、
 * 語彙を所有しない立場でプロジェクト固有メタデータを落とさないことを見る。
 */

import assert from 'node:assert/strict'
import { test } from 'node:test'

import {
  PREVIEW_RELOAD_EVENT,
  localizedErrorResponseSchema,
  parseDocumentResponse,
  parseLoadLocalizedDocumentInput,
  parseLocalizedDocumentResponse,
} from './live-preview.ts'

const validBody = {
  blocks: [
    { id: 'a', kind: 'claim', labels: ['c:1'], statement: [{ type: 'text', value: 'x' }] },
  ],
  notes: [{ id: 'n1', targets: ['c:1'], body: [] }],
  generatedAt: '2026-08-01T00:00:00.000Z',
  sourceLabel: 'proj/structured-latex/content',
}

test('正しいレスポンスは blocks / notes ごと通る', () => {
  const parsed = parseDocumentResponse(validBody)
  assert.equal(parsed.success, true)
  if (!parsed.success) return
  assert.equal(parsed.data.blocks.length, 1)
  assert.equal(parsed.data.notes.length, 1)
  assert.equal(parsed.data.sourceLabel, 'proj/structured-latex/content')
})

test('notes が無いレスポンスはノート 0 件として通る（ノートは任意）', () => {
  const { notes: _notes, ...withoutNotes } = validBody
  const parsed = parseDocumentResponse(withoutNotes)
  assert.equal(parsed.success && parsed.data.notes.length, 0)
})

test('プロジェクト固有メタデータは未知のキーでも落とさずに通す', () => {
  const parsed = parseDocumentResponse({
    ...validBody,
    blocks: [{ ...validBody.blocks[0], habitat: 'countable' }],
  })
  assert.equal(parsed.success, true)
  if (!parsed.success) return
  assert.equal((parsed.data.blocks[0] as { habitat?: unknown }).habitat, 'countable')
})

test('外枠が壊れていれば throw せず validation_error になる', () => {
  const parsed = parseDocumentResponse({ blocks: 'not an array' })
  assert.equal(parsed.success, false)
  assert.equal(parsed.success === false && parsed.error.code, 'validation_error')
})

test('入力言語として不正なブロックは validation_error になり、位置が分かる', () => {
  const parsed = parseDocumentResponse({
    ...validBody,
    blocks: [{ id: 'a', kind: 'claim', labels: [], statement: [{ type: 'unknown-node' }] }],
  })
  assert.equal(parsed.success, false)
  if (parsed.success || parsed.error.code !== 'validation_error') return
  assert.ok(parsed.error.issues.length > 0)
  assert.ok(parsed.error.issues[0]?.path.startsWith('blocks[0]:a'))
})

test('既存の単一ロケール応答を壊さず、locale 明示の別入口でローカライズ版を受け入れる', () => {
  // 先に既存入口の互換性を確認する。`blocks` / `notes` だけの応答は従来どおり通る。
  assert.equal(parseDocumentResponse(validBody).success, true)

  const parsed = parseLocalizedDocumentResponse({
    locale: 'en',
    localizedRevision: {
      documentId: 'document',
      sourceLocale: 'ja',
      localizations: [
        {
          locale: 'ja',
          translatedFrom: null,
          translatedFromRevision: null,
          revision: {
            documentId: 'document',
            revision: 1,
            segments: [
              {
                key: '001',
                blocks: [
                  {
                    id: 'heading',
                    kind: 'heading',
                    level: 1,
                    labels: ['sec:intro'],
                    title: { text: '導入' },
                  },
                  {
                    id: 'claim',
                    kind: 'claim',
                    labels: ['claim:main'],
                    statement: [{ type: 'text', value: '本文' }],
                  },
                ],
              },
            ],
          },
        },
        {
          locale: 'en',
          translatedFrom: 'ja',
          translatedFromRevision: 1,
          revision: {
            documentId: 'document',
            revision: 1,
            segments: [
              {
                key: '001',
                blocks: [
                  {
                    id: 'heading',
                    kind: 'heading',
                    level: 1,
                    labels: ['sec:intro'],
                    title: { text: 'Introduction' },
                  },
                  {
                    id: 'claim',
                    kind: 'claim',
                    labels: ['claim:main'],
                    statement: [{ type: 'text', value: 'Body' }],
                  },
                ],
              },
            ],
          },
        },
      ],
    },
    generatedAt: '2026-08-01T00:00:00.000Z',
    sourceLabel: 'proj/structured-latex/content',
  })
  assert.equal(parsed.success, true)
  assert.deepEqual(
    parsed.success ? parsed.data.localizedRevision.localizations.map((entry) => entry.locale) : [],
    ['ja', 'en'],
  )
})

test('ローカライズ応答は選択 locale が利用可能であることを境界で確認する', () => {
  const parsed = parseLocalizedDocumentResponse({
    locale: 'fr',
    localizedRevision: {
      documentId: 'document',
      sourceLocale: 'ja',
      localizations: [
        {
          locale: 'ja',
          translatedFrom: null,
          translatedFromRevision: null,
          revision: {
            documentId: 'document',
            revision: 1,
            segments: [
              { key: '001', blocks: [{ id: 'claim', kind: 'claim', labels: [], statement: [] }] },
            ],
          },
        },
      ],
    },
    generatedAt: '2026-08-01T00:00:00.000Z',
    sourceLabel: 'proj/structured-latex/content',
  })
  assert.deepEqual(parsed, {
    success: false,
    error: { code: 'response_locale_not_available', locale: 'fr', availableLocales: ['ja'] },
  })
})

test('ローカライズ取得要求は locale を明示し、BCP 47 でない値を境界で拒否する', () => {
  assert.deepEqual(parseLoadLocalizedDocumentInput({ locale: 'en-US' }), {
    success: true,
    data: { locale: 'en-US' },
  })
  const invalid = parseLoadLocalizedDocumentInput({ locale: 'english' })
  assert.equal(invalid.success, false)
  assert.equal(invalid.success === false && invalid.error.code, 'validation_error')
})

test('ローカライズ endpoint のエラー応答は構造ドリフトと利用不能 locale を表現できる', () => {
  assert.equal(
    localizedErrorResponseSchema.safeParse({
      error: { code: 'invalid_localization', issues: [{ code: 'structural_drift', locale: 'en' }] },
    }).success,
    true,
  )
  assert.equal(
    localizedErrorResponseSchema.safeParse({
      error: { code: 'response_locale_not_available', locale: 'fr', availableLocales: ['ja', 'en'] },
    }).success,
    true,
  )
})

test('SSE のイベント名は reload', () => {
  assert.equal(PREVIEW_RELOAD_EVENT, 'reload')
})
