import assert from 'node:assert/strict'
import { test } from 'node:test'

import type {
  LocalizedDocumentManifest,
  GetLocalizedManifestInput,
  UploadLocalizedSegmentsError,
  UploadLocalizedSegmentsInput,
} from './live-site.ts'
import { parseGetLocalizedManifestInput } from './live-site.ts'
import { parseGetLocalizedManifestInput as parseFromPublicApi } from '../index.ts'

test('公開サイトのローカライズ契約は locale・原文・翻訳元を明示する', () => {
  const upload = {
    documentId: 'doc',
    baseRevision: 4,
    upserts: [],
    deletes: [],
    sourceLocale: 'ja',
    locale: 'en',
    translatedFrom: 'ja',
    translatedFromRevision: 4,
  } satisfies UploadLocalizedSegmentsInput
  const manifest = {
    documentId: 'doc',
    revision: 5,
    publishedAt: '2026-08-01T00:00:00.000Z',
    segments: [],
    sourceLocale: 'ja',
    locale: 'en',
    translatedFrom: 'ja',
    translatedFromRevision: 4,
    availableLocales: ['ja', 'en'],
  } satisfies LocalizedDocumentManifest

  assert.equal(upload.locale, manifest.locale)
  assert.deepEqual(manifest.availableLocales, ['ja', 'en'])

  const drift = {
    code: 'invalid_localization',
    issues: [{ code: 'source_locale_missing', sourceLocale: 'ja' }],
  } satisfies UploadLocalizedSegmentsError
  assert.equal(drift.code, 'invalid_localization')

  const get = { documentId: 'doc', locale: 'en' } satisfies GetLocalizedManifestInput
  assert.equal(get.locale, 'en')
  assert.equal(parseGetLocalizedManifestInput(get).success, true)
  assert.equal(parseFromPublicApi(get).success, true)
  assert.equal(parseGetLocalizedManifestInput({ documentId: 'doc', locale: 'English' }).success, false)
})
