import { type Block, type LoadDocumentError, type Note, type Result, ok } from '@rwp/domain-model'
import type { BlockSourceGateway } from '../interfaces/gateways/block-source-gateway.js'
import type { NoteSourceGateway } from '../interfaces/gateways/note-source-gateway.js'

/** 画面に渡す文書一式。`notes` は文書本体ではなく参照用（出版物には載らない）。 */
export type DocumentWithNotes = {
  blocks: Block[]
  notes: Note[]
  sourceLabel: string
}

/**
 * 入力ソースから現在のドキュメント（本体 + 参照用ノート）を取得する。
 * gateway を DI で受け取り、Result をそのまま伝搬する（throw しない）。
 */
export const getDocument = async (
  blockSource: BlockSourceGateway,
  noteSource: NoteSourceGateway,
): Promise<Result<DocumentWithNotes, LoadDocumentError>> => {
  const document = await blockSource.load()
  if (!document.success) {
    return document
  }
  const notes = await noteSource.load()
  if (!notes.success) {
    return notes
  }
  return ok({
    blocks: document.data.blocks,
    notes: notes.data,
    sourceLabel: document.data.sourceLabel,
  })
}
