#!/usr/bin/env node
/**
 * ラベルのユニオン型と文書集約モジュールの生成器（先行実装 `tools/generate-index.ts` の一般化）。
 *
 *   node codegen/structured-text-index/cli.ts --project <dir>           生成（書き込み）
 *   node codegen/structured-text-index/cli.ts --project <dir> --check   現物との一致だけ検査
 *
 * `<dir>` は `content/`（と任意で `notes/`）を持つプロジェクトのディレクトリ。
 * 生成物は `<dir>/labels.generated.ts` と `<dir>/document.generated.ts`。
 */

import { existsSync, readFileSync, writeFileSync } from 'node:fs'
import { dirname, join, relative, resolve as resolvePath } from 'node:path'
import { fileURLToPath } from 'node:url'

import {
  contentDirOf,
  listSourceFiles,
  loadBlockFiles,
  loadContentFiles,
  loadNoteFiles,
  loadNotesFiles,
  notesDirOf,
} from './content-modules.ts'
import { directoryFromProject, loadProjectLocalizationConfig } from './locales.ts'
import { renderDocument, renderLabels, type TranslationRender } from './render.ts'
import {
  DEFAULT_NUMBERING_POLICY,
  createRuntimeSchema,
  resolveLocalized,
  validateLocalizedRevisionSnapshot,
} from '../../domain-model/index.ts'
import type {
  LocalizationAllowance,
  LocalizationAllowances,
  LocalizedRevision,
  Note,
} from '../../domain-model/index.ts'

const systemDir = join(dirname(fileURLToPath(import.meta.url)), '..', '..')

const projectIndex = process.argv.indexOf('--project')
const projectArg = projectIndex >= 0 ? process.argv[projectIndex + 1] : undefined
if (projectArg === undefined) {
  console.error('使い方: node codegen/structured-text-index/cli.ts --project <dir> [--check]')
  process.exit(1)
}
const projectDir = resolvePath(process.cwd(), projectArg)
const checkOnly = process.argv.includes('--check')

const labelsPath = join(projectDir, 'labels.generated.ts')
const documentPath = join(projectDir, 'document.generated.ts')

/**
 * 初回だけの種まき。`content/*.ts` は `labels.generated.ts` を import しているので、
 * 生成物が 1 つも無い状態では読み込めない（鶏と卵）。空のユニオンを一度だけ書いてから読む。
 * 型は消えるので、この種まきが実行時の読み込みに影響することはない。
 */
if (!existsSync(labelsPath) && !checkOnly) {
  writeFileSync(labelsPath, renderLabels([]), 'utf8')
  console.log(`種まき: ${labelsPath} を空で作成した（この後、実状で上書きする）`)
}

const contentFiles = listSourceFiles(contentDirOf(projectDir))
const noteFiles = listSourceFiles(notesDirOf(projectDir))
if (contentFiles.length === 0) {
  console.error(`${contentDirOf(projectDir)} にソースが 1 件も無い`)
  process.exit(1)
}

type LabelOrigin = { label: string; blockId: string; file: string }

const origins: LabelOrigin[] = []
const loadedSourceContent = await loadContentFiles(projectDir)
for (const { file, blocks } of loadedSourceContent) {
  for (const block of blocks) {
    for (const label of block.labels) origins.push({ label, blockId: block.id, file })
  }
}

// 重複ラベルは参照の一意解決を壊す（どのブロックを指すか決まらない）。同じ検査は
// document.generated.ts 経由でコンパイル時にも行われるが、生成物そのものが壊れるのを防ぐ。
const seen = new Map<string, LabelOrigin>()
const duplicates: string[] = []
for (const origin of origins) {
  const previous = seen.get(origin.label)
  if (previous !== undefined) {
    duplicates.push(
      `  ${origin.label}: ${previous.file}:${previous.blockId} と ${origin.file}:${origin.blockId}`,
    )
    continue
  }
  seen.set(origin.label, origin)
}
if (duplicates.length > 0) {
  console.error(`ラベルが重複している:\n${duplicates.join('\n')}`)
  process.exit(1)
}

const labels = [...seen.keys()].sort()
if (labels.length === 0) {
  console.error('content/ からラベルを 1 件も抽出できなかった（読み込み経路が壊れている可能性が高い）')
  process.exit(1)
}

/**
 * 翻訳が設定されていれば、原文を基準に全ロケールを実値で検証する。
 * ラベル生成は原文だけを読む（翻訳側へ同じ label を再宣言させると global unique を壊す）一方、
 * ロケール別の構造・翻訳元・欠落はここで必ず拒否する。
 */
const localizationConfig = await loadProjectLocalizationConfig(projectDir)
const sourceSegments = loadedSourceContent.map(({ file, blocks }) => ({
  key: file,
  blocks,
  notes: [] as readonly Note[],
}))
const sourceNotes = await loadNoteFiles(projectDir)
for (const segment of sourceSegments) {
  segment.notes = sourceNotes.find((notes) => notes.file === segment.key)?.notes ?? []
}
const localizations: LocalizedRevision[] = [
  {
    locale: localizationConfig.sourceLocale,
    translatedFrom: null,
    translatedFromRevision: null,
    revision: { documentId: '__codegen__', revision: 1, segments: sourceSegments },
  },
]
const allowances: Record<string, LocalizationAllowance> = {}
const translationRenders: TranslationRender[] = []
/** 翻訳ロケールにしか無いブロックのラベル（生成物のユニオン型に足す）。 */
const translationOnlyLabels = new Set<string>()
const sourceBlockIds = new Set(sourceSegments.flatMap((segment) => segment.blocks.map((b) => b.id)))
for (const translation of localizationConfig.translations) {
  const contentDir = directoryFromProject(projectDir, translation.contentDir)
  const content = await loadBlockFiles(contentDir)
  const notes = translation.notesDir === undefined
    ? []
    : await loadNotesFiles(directoryFromProject(projectDir, translation.notesDir))
  if (translation.allowance !== undefined) allowances[translation.locale] = translation.allowance
  translationRenders.push({
    locale: translation.locale,
    contentDir: translation.contentDir,
    files: listSourceFiles(contentDir),
  })
  for (const { blocks } of content) {
    for (const block of blocks) {
      if (sourceBlockIds.has(block.id)) continue
      for (const label of block.labels) translationOnlyLabels.add(label)
    }
  }
  localizations.push({
    locale: translation.locale,
    translatedFrom: translation.translatedFrom,
    translatedFromRevision: 1,
    revision: {
      documentId: '__codegen__',
      revision: 1,
      segments: content.map(({ file, blocks }) => ({
        key: file,
        blocks,
        notes: notes.find((note) => note.file === file)?.notes ?? [],
      })),
    },
  })
}

// 翻訳限定ラベルが原文のラベルと衝突すると、どちらの版のブロックを指すか決まらない。
const collidingLabels = [...translationOnlyLabels].filter((label) => seen.has(label)).sort()
if (collidingLabels.length > 0) {
  console.error(`翻訳限定ブロックのラベルが原文のラベルと衝突している:\n  ${collidingLabels.join('\n  ')}`)
  process.exit(1)
}

const localizationAllowances: LocalizationAllowances = allowances
const localizedSnapshot = validateLocalizedRevisionSnapshot(
  {
    documentId: '__codegen__',
    sourceLocale: localizationConfig.sourceLocale,
    localizations,
  },
  // generator はプロジェクト固有メタデータのキーを知らない。汎用プレビューと同様、
  // 既知の語彙は検査しつつ、定理型に載る未知の意味メタデータは落とさない。
  createRuntimeSchema({ unknownBlockMeta: 'passthrough' }),
  'localization',
  localizationAllowances,
)
if (!localizedSnapshot.success) {
  console.error(`ローカライズ入力検証に失敗:\n${JSON.stringify(localizedSnapshot.error, null, 2)}`)
  process.exit(1)
}
for (const locale of localizedSnapshot.data.localizations) {
  const localized = resolveLocalized(
    localizedSnapshot.data,
    locale.locale,
    { numbering: DEFAULT_NUMBERING_POLICY, audience: 'publication' },
    localizationAllowances,
  )
  if (!localized.success) {
    console.error(`ローカライズ検証に失敗 (${locale.locale}):\n${JSON.stringify(localized.error, null, 2)}`)
    process.exit(1)
  }
}

/** 生成物から domain-model を指す import 指定子（POSIX 区切りで、必ず相対にする）。 */
const domainModelSpecifier = (() => {
  const raw = relative(projectDir, join(systemDir, 'domain-model', 'index.ts')).split('\\').join('/')
  return raw.startsWith('.') ? raw : `./${raw}`
})()

const sortedTranslationOnlyLabels = [...translationOnlyLabels].sort()
const outputs = [
  {
    path: labelsPath,
    rendered: renderLabels(labels, sortedTranslationOnlyLabels),
    what:
      `${labels.length} labels` +
      (sortedTranslationOnlyLabels.length === 0
        ? ''
        : ` + ${sortedTranslationOnlyLabels.length} translation-only labels`),
  },
  {
    path: documentPath,
    rendered: renderDocument({
      domainModelSpecifier,
      contentFiles,
      structuredContent: Object.fromEntries(
        loadedSourceContent
          .filter(({ sourceKind }) => sourceKind !== 'blocks')
          .map(({ file, sourceKind }) => [
            file,
            sourceKind as 'sections' | 'documentStructure',
          ]),
      ),
      noteFiles,
      translations: translationRenders,
    }),
    what:
      `${contentFiles.length} content + ${noteFiles.length} notes files` +
      (translationRenders.length === 0
        ? ''
        : ` + ${translationRenders.reduce((n, t) => n + t.files.length, 0)} translated files`),
  },
]

// 生成物が型検査の対象に入っていること。document.generated.ts は誰からも import されないため、
// include から外れると**ファイル跨ぎの検査が無音で全滅する**（先行実装で実際に起きた事故）。
const projectTsconfig = join(projectDir, 'tsconfig.json')
if (existsSync(projectTsconfig)) {
  const source = readFileSync(projectTsconfig, 'utf8')
  for (const required of ['labels.generated.ts', 'document.generated.ts']) {
    if (!source.includes(`"${required}"`)) {
      console.error(
        `${projectTsconfig} の include に ${required} が無い` +
          '（生成物が型検査の対象から外れると、検査が無音で無効になる）',
      )
      process.exit(1)
    }
  }
}

if (checkOnly) {
  for (const output of outputs) {
    let current: string | null = null
    try {
      current = readFileSync(output.path, 'utf8')
    } catch {
      current = null
    }
    if (current !== output.rendered) {
      console.error(
        `${output.path} が content/ notes/ の実状と一致していない。` +
          `\n  修正: node codegen/structured-text-index/cli.ts --project ${projectArg}`,
      )
      process.exit(1)
    }
  }
  console.log(`generated files are up to date (${outputs.map((o) => o.what).join(', ')})`)
} else {
  for (const output of outputs) writeFileSync(output.path, output.rendered, 'utf8')
  console.log(`generated ${outputs.map((o) => `${o.path.split('/').pop()} (${o.what})`).join(', ')}`)
}
