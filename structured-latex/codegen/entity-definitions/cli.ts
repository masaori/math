#!/usr/bin/env node
/**
 * SSOT（`domain-model/entities/`）から framework-agnostic な Entity Definition と
 * Relation を生成する（docs/architecture-overview.md「コード生成」）。
 *
 * 生成の順序は「SSOT 読込 → 宣言の解決（storage を relation graph と突合・検証）→ 生成」。
 * 解決を先に走らせ、抜け漏れ・曖昧をこの段で落としてから生成に入る。
 *
 *   node codegen/entity-definitions/cli.ts           生成（書き込み）
 *   node codegen/entity-definitions/cli.ts --check   現物との一致だけ検査（CI 用）
 */

import { mkdirSync, readFileSync, writeFileSync } from 'node:fs'
import { dirname, join } from 'node:path'
import { fileURLToPath } from 'node:url'

import { generateEntities, generateRelations } from '@masaori/zod-to-entity-definitions'

import { allEntities } from '../../domain-model/entities/index.ts'
import { storageAssignments } from '../config/storage.ts'
import { resolveStorage } from '../_shared/resolve-storage.ts'

const systemDir = join(dirname(fileURLToPath(import.meta.url)), '..', '..')
const outDir = join(systemDir, 'domain-model', '_gen')

const definitions = generateEntities(allEntities)
const relations = generateRelations(definitions)

const storage = resolveStorage(definitions, storageAssignments)
if (!storage.success) {
  console.error(
    `storage 宣言が SSOT と一致しない [${storage.error.code}]: ${storage.error.entities.join(', ')}`,
  )
  process.exit(1)
}

const outputs = [
  { path: join(outDir, 'entity-definitions.json'), value: definitions },
  { path: join(outDir, 'entity-relations.json'), value: relations },
  { path: join(outDir, 'entity-storage.json'), value: storage.data },
]

const render = (value: unknown): string => `${JSON.stringify(value, null, 2)}\n`

if (process.argv.includes('--check')) {
  for (const output of outputs) {
    let current: string | null = null
    try {
      current = readFileSync(output.path, 'utf8')
    } catch {
      current = null
    }
    if (current !== render(output.value)) {
      console.error(
        `${output.path} が entities/ の実状と一致していない。` +
          '\n  修正: node codegen/entity-definitions/cli.ts',
      )
      process.exit(1)
    }
  }
  console.log(`entity definitions are up to date (${definitions.length} entities)`)
} else {
  mkdirSync(outDir, { recursive: true })
  for (const output of outputs) writeFileSync(output.path, render(output.value), 'utf8')
  console.log(
    `generated ${definitions.length} entity definitions, ` +
      `${relations.length} relations, ${Object.keys(storage.data).length} storage assignments`,
  )
}
