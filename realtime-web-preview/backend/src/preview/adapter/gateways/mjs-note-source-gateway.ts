import { existsSync } from 'node:fs'
import {
  type LoadDocumentError,
  type Note,
  type Result,
  type ValidationIssue,
  err,
  notesSchema,
  ok,
} from '@rwp/domain-model'
import type { NoteSourceGateway } from '../../domain/interfaces/gateways/note-source-gateway.js'
import { loadMjsDefaultExports } from './mjs-module-loader.js'

/**
 * `.mjs` 形式の参照用ノートソースを読む adapter。
 * ノートは任意なので、dir が無い / 空の場合は「ノート 0 件」の成功として扱う
 * （本文が読めていれば画面は成立するため、ここで document 全体を落とさない）。
 */
export class MjsNoteSourceGateway implements NoteSourceGateway {
  private importVersion = 0

  constructor(private readonly notesDir: string) {}

  async load(): Promise<Result<Note[], LoadDocumentError>> {
    if (!existsSync(this.notesDir)) {
      return ok([])
    }

    this.importVersion += 1
    const outcome = await loadMjsDefaultExports(this.notesDir, this.importVersion)
    if (!outcome.ok) {
      const { failure } = outcome
      return err({
        code: 'source_read_error',
        message:
          failure.kind === 'read_error'
            ? failure.message
            : `${failure.fileName}: ${failure.message}`,
      })
    }

    const notes: Note[] = []
    const issues: ValidationIssue[] = []

    for (const { fileName, defaultExport } of outcome.modules) {
      const parsed = notesSchema.safeParse(defaultExport)
      if (!parsed.success) {
        for (const issue of parsed.error.issues) {
          issues.push({ path: `${fileName}:${issue.path.join('.')}`, message: issue.message })
        }
        continue
      }
      notes.push(...parsed.data)
    }

    if (issues.length > 0) {
      return err({ code: 'validation_error', issues })
    }
    return ok(notes)
  }
}
