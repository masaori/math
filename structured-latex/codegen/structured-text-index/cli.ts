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
  loadContentFiles,
  notesDirOf,
} from './content-modules.ts'
import { renderDocument, renderLabels } from './render.ts'

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
for (const { file, blocks } of await loadContentFiles(projectDir)) {
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

/** 生成物から domain-model を指す import 指定子（POSIX 区切りで、必ず相対にする）。 */
const domainModelSpecifier = (() => {
  const raw = relative(projectDir, join(systemDir, 'domain-model', 'index.ts')).split('\\').join('/')
  return raw.startsWith('.') ? raw : `./${raw}`
})()

const outputs = [
  { path: labelsPath, rendered: renderLabels(labels), what: `${labels.length} labels` },
  {
    path: documentPath,
    rendered: renderDocument({ domainModelSpecifier, contentFiles, noteFiles }),
    what: `${contentFiles.length} content + ${noteFiles.length} notes files`,
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
