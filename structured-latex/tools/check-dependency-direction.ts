#!/usr/bin/env node
/**
 * 依存方向の機械検査（docs/domain-model.md §10、docs/architecture-overview.md 設計原則 3）。
 *
 * 規約を散文の約束にせず、実際の import を読んで確かめる:
 *   - `domain-model/` は**何にも依存しない**。他のディレクトリも、Node の組み込みモジュールも
 *     import しない（純粋であること。I/O を持つと出力器やツールへ依存が漏れる）。
 *   - `codegen/` と `examples/` は `domain-model/` にだけ依存してよい。
 *   - 逆方向・循環は禁止。
 */

import { readFileSync, readdirSync, statSync } from 'node:fs'
import { dirname, join, relative } from 'node:path'
import { fileURLToPath } from 'node:url'

const systemDir = join(dirname(fileURLToPath(import.meta.url)), '..')

/**
 * 検査対象のソース。テスト（`*.test.ts`）は除く。
 * テストは「その層を外から動かすもの」なので、テストランナー（`node:test`）へ依存してよい。
 * 出荷される依存関係ではないため、層の規約の対象外とする。
 */
const listFiles = (dir: string): string[] => {
  const out: string[] = []
  for (const entry of readdirSync(dir)) {
    if (entry === 'node_modules' || entry.startsWith('.')) continue
    const full = join(dir, entry)
    if (statSync(full).isDirectory()) out.push(...listFiles(full))
    else if (entry.endsWith('.ts') && !entry.endsWith('.test.ts')) out.push(full)
  }
  return out
}

const importsOf = (file: string): string[] => {
  const source = readFileSync(file, 'utf8')
  return [...source.matchAll(/(?:^|\n)\s*(?:import|export)[^'"\n]*from\s*['"]([^'"]+)['"]/g)].map(
    (match) => match[1] ?? '',
  )
}

type Violation = { file: string; specifier: string; reason: string }
const violations: Violation[] = []

/** domain-model: 外部パッケージは zod と SSOT 記述用ライブラリだけ、相対 import は自分の中だけ。 */
const domainModelAllowedPackages = new Set(['zod', '@masaori/zod-to-entity-definitions'])

for (const file of listFiles(join(systemDir, 'domain-model'))) {
  for (const specifier of importsOf(file)) {
    if (specifier.startsWith('.')) {
      const resolved = join(dirname(file), specifier)
      if (!resolved.startsWith(join(systemDir, 'domain-model'))) {
        violations.push({
          file: relative(systemDir, file),
          specifier,
          reason: 'domain-model は自分の外へ依存してはならない',
        })
      }
      continue
    }
    if (specifier.startsWith('node:')) {
      violations.push({
        file: relative(systemDir, file),
        specifier,
        reason: 'domain-model は純粋に保つ（Node の組み込みモジュールを使わない）',
      })
      continue
    }
    if (!domainModelAllowedPackages.has(specifier)) {
      violations.push({
        file: relative(systemDir, file),
        specifier,
        reason: `domain-model が依存してよい外部パッケージは ${[...domainModelAllowedPackages].join(' / ')} だけ`,
      })
    }
  }
}

/** codegen / examples: domain-model へだけ依存してよい（互いには依存しない）。 */
for (const layer of ['codegen', 'examples'] as const) {
  const layerDir = join(systemDir, layer)
  for (const file of listFiles(layerDir)) {
    for (const specifier of importsOf(file)) {
      if (!specifier.startsWith('.')) continue
      const resolved = join(dirname(file), specifier)
      const insideOwnLayer = resolved.startsWith(layerDir)
      const insideDomainModel = resolved.startsWith(join(systemDir, 'domain-model'))
      if (!insideOwnLayer && !insideDomainModel) {
        violations.push({
          file: relative(systemDir, file),
          specifier,
          reason: `${layer} は domain-model へだけ依存してよい`,
        })
      }
    }
  }
}

if (violations.length > 0) {
  for (const violation of violations) {
    console.error(`✗ ${violation.file} → ${violation.specifier}\n  ${violation.reason}`)
  }
  console.error(`\n依存方向: ${violations.length} 件の違反`)
  process.exit(1)
}
console.log('依存方向: 違反なし')
