import assert from 'node:assert/strict'
import { spawnSync } from 'node:child_process'
import { mkdtempSync, mkdirSync, rmSync, writeFileSync } from 'node:fs'
import { join } from 'node:path'
import { tmpdir } from 'node:os'
import { test } from 'node:test'
import { fileURLToPath } from 'node:url'

const cli = fileURLToPath(new URL('./cli.ts', import.meta.url))

const blockSource = (text: string, math = 'x'): string => `export default [{
  id: 'claim',
  kind: 'claim',
  labels: ['claim:one'],
  title: { text: ${JSON.stringify(text)} },
  statement: [
    { type: 'text', value: ${JSON.stringify(text)} },
    { type: 'math', tex: ${JSON.stringify(math)} },
  ],
}]
`

const run = (project: string, check = false): string => {
  const result = spawnSync(process.execPath, [cli, '--project', project, ...(check ? ['--check'] : [])], {
    encoding: 'utf8',
  })
  if (result.error !== undefined) throw result.error
  if (result.status !== 0) {
    throw Object.assign(new Error(`codegen failed with status ${result.status}`), {
      stdout: result.stdout,
      stderr: result.stderr,
    })
  }
  return result.stdout
}

test('生成器は設定した翻訳を原文構造と照合し、既存設定なしは暗黙 ja として扱う', () => {
  const project = mkdtempSync(join(tmpdir(), 'structured-latex-locales-'))
  try {
    mkdirSync(join(project, 'content'), { recursive: true })
    mkdirSync(join(project, 'locales', 'en', 'content'), { recursive: true })
    writeFileSync(join(project, 'content', '001.ts'), blockSource('原文'), 'utf8')
    writeFileSync(join(project, 'locales', 'en', 'content', '001.ts'), blockSource('Translation'), 'utf8')
    writeFileSync(
      join(project, 'locales.config.ts'),
      `export default {
  sourceLocale: 'ja',
  translations: [{ locale: 'en', translatedFrom: 'ja', contentDir: 'locales/en/content' }],
}
`,
      'utf8',
    )

    assert.match(run(project), /generated labels\.generated\.ts/)
    assert.match(run(project, true), /generated files are up to date/)

    // TypeScript を迂回して書かれた翻訳の形も、generator の実行時検査で拒否する。
    writeFileSync(
      join(project, 'locales', 'en', 'content', '001.ts'),
      blockSource('Translation').replace(`title: { text: "Translation" }`, 'title: {}'),
      'utf8',
    )
    assert.throws(
      () => run(project, true),
      (error: unknown) => {
        if (!(error instanceof Error)) return false
        const processError = error as Error & { stdout?: string; stderr?: string }
        return `${processError.stdout ?? ''}${processError.stderr ?? ''}`.includes('localization_validation_error')
      },
    )

    // 翻訳の文字列は変えられるが、数式を変えたら同じ翻訳版ではない。
    writeFileSync(join(project, 'locales', 'en', 'content', '001.ts'), blockSource('Translation', 'y'), 'utf8')
    assert.throws(
      () => run(project, true),
      (error: unknown) => {
        if (!(error instanceof Error)) return false
        const processError = error as Error & { stdout?: string; stderr?: string }
        return `${processError.stdout ?? ''}${processError.stderr ?? ''}`.includes('structural_drift')
      },
    )
  } finally {
    rmSync(project, { recursive: true, force: true })
  }
})
