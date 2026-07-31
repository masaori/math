/**
 * 版のスナップショットを解決済み文書へ写す**純関数**。
 *
 * ここが「F9 の反復（ラベル解決が出力形式ごとに書かれる）」を止める 1 か所である。
 * 文書全体にかかる不変条件（I1 一意性・I2 参照解決・I3 非空）を判定できるのもここだけで、
 * ブロック 1 件やセグメント 1 つでは判定できない（＝集約の境界が文書 1 つである根拠）。
 *
 * throw しない。エラーは Result で返す（docs/error-handling-strategy.md §1）。
 */

import { err, ok, type Result } from '../result.ts'
import type { Block, HeadingLevel, Note, TitleContent } from '../structured-text/block.ts'
import type { Node } from '../structured-text/node.ts'
import type { NumberingPolicy } from './numbering.ts'
import type {
  Audience,
  BlockNumber,
  OutlineEntry,
  ResolvedBlock,
  ResolvedDocument,
  ResolvedNode,
  ResolvedNote,
  RevisionNumber,
} from './resolved-document.ts'

/** 文書順のキー。先行実装のファイル名に相当する（ファイルシステムに依存しない語にしてある）。 */
export type SegmentKey = string

export type SegmentSnapshot<L extends string = string, M = unknown> = {
  key: SegmentKey
  blocks: readonly Block<L, M>[]
  notes?: readonly Note<L>[]
}

export type RevisionSnapshot<L extends string = string, M = unknown> = {
  documentId: string
  revision: RevisionNumber
  segments: readonly SegmentSnapshot<L, M>[]
}

export type ResolveOptions = {
  numbering: NumberingPolicy
  audience: Audience
  /**
   * アンカーの前置。既定は空。
   *
   * 書籍形式は「本体文書 + 解説文書」の合成として扱う（論点 A-3 の確定）。
   * ブロック id は**文書内でしか一意でない**ので、2 文書を合成するとアンカーが衝突しうる。
   * 合成する側が文書ごとに異なる前置を与えることで衝突を防ぐ。
   */
  anchorPrefix?: string
}

export type ResolveError =
  | { code: 'duplicate_segment_key'; keys: readonly string[] }
  | { code: 'empty_document' }
  | { code: 'duplicate_block_id'; blockIds: readonly string[] }
  | { code: 'duplicate_label'; labels: readonly string[] }
  | { code: 'duplicate_note_id'; noteIds: readonly string[] }
  | { code: 'unresolved_reference'; references: readonly { fromBlockId: string; target: string }[] }
  | { code: 'orphan_note'; noteIds: readonly string[] }

const titleOf = (title: TitleContent | null | undefined): TitleContent | null => title ?? null

/** セグメントは key の昇順が文書順（F1 の「ファイル名昇順」を一般化したもの）。 */
const byKey = (a: SegmentSnapshot, b: SegmentSnapshot): number =>
  a.key < b.key ? -1 : a.key > b.key ? 1 : 0

const duplicatesOf = (values: readonly string[]): string[] => {
  const seen = new Set<string>()
  const duplicated = new Set<string>()
  for (const value of values) {
    if (seen.has(value)) duplicated.add(value)
    seen.add(value)
  }
  return [...duplicated]
}

export const resolve = <L extends string, M>(
  revision: RevisionSnapshot<L, M>,
  options: ResolveOptions,
): Result<ResolvedDocument, ResolveError> => {
  const anchorPrefix = options.anchorPrefix ?? ''
  const anchorOf = (id: string): string => `${anchorPrefix}${id}`

  const duplicatedKeys = duplicatesOf(revision.segments.map((segment) => segment.key))
  if (duplicatedKeys.length > 0) {
    return err({ code: 'duplicate_segment_key', keys: duplicatedKeys })
  }

  const ordered = [...revision.segments].sort(byKey)
  const blocks: Block<L, M>[] = []
  const notes: Note<L>[] = []
  for (const segment of ordered) {
    blocks.push(...segment.blocks)
    // ノートは audience に関わらず**検証の対象**にする（id の一意性・targets の解決可能性は
    // 出版物に載るかどうかと無関係に成り立つべき条件であり、迷子のノートを黙認しない）。
    // 出版ターゲットで外れるのは**配置**だけである（I5）。
    notes.push(...(segment.notes ?? []))
  }

  if (blocks.length === 0) return err({ code: 'empty_document' })

  const duplicatedBlockIds = duplicatesOf(blocks.map((block) => block.id))
  if (duplicatedBlockIds.length > 0) {
    return err({ code: 'duplicate_block_id', blockIds: duplicatedBlockIds })
  }

  const duplicatedLabels = duplicatesOf(blocks.flatMap((block) => [...block.labels]))
  if (duplicatedLabels.length > 0) {
    return err({ code: 'duplicate_label', labels: duplicatedLabels })
  }

  // ノート id はブロック id とも衝突しない（衝突するとアンカーが一意に決まらない）。
  const duplicatedNoteIds = duplicatesOf([
    ...notes.map((note) => note.id),
    ...blocks.map((block) => block.id),
  ]).filter((id) => notes.some((note) => note.id === id))
  if (duplicatedNoteIds.length > 0) {
    return err({ code: 'duplicate_note_id', noteIds: duplicatedNoteIds })
  }

  // --- 採番（1 パス目）------------------------------------------------------
  const { numbering } = options
  const headingCounters = [0, 0, 0, 0, 0, 0]
  const runningCounters = new Map<string, number>()
  const numberByBlockId = new Map<string, BlockNumber | null>()
  const outline: OutlineEntry[] = []

  const displayOf = (path: readonly number[]): string => path.join(numbering.separator)

  for (const block of blocks) {
    if (block.kind === 'heading') {
      const level: HeadingLevel = block.level
      headingCounters[level - 1] = (headingCounters[level - 1] ?? 0) + 1
      for (let deeper = level; deeper < headingCounters.length; deeper += 1) {
        headingCounters[deeper] = 0
      }
      const number: BlockNumber | null =
        level <= numbering.numberedHeadingDepth
          ? { path: headingCounters.slice(0, level), display: displayOf(headingCounters.slice(0, level)) }
          : null
      numberByBlockId.set(block.id, number)
      outline.push({
        blockId: block.id,
        level,
        number,
        title: block.title,
        anchor: anchorOf(block.id),
      })
      continue
    }

    // 見出しがまだ現れていない区間では前置を付けない（「0.1」のような番号を作らない）。
    const resetAt = numbering.resetAt
    const prefix =
      resetAt === null || (headingCounters[resetAt - 1] ?? 0) === 0
        ? []
        : headingCounters.slice(0, resetAt)
    const counterKey = numbering.counters[block.kind]
    const runningKey = `${counterKey}|${prefix.join(',')}`
    const next = (runningCounters.get(runningKey) ?? 0) + 1
    runningCounters.set(runningKey, next)
    const path = [...prefix, next]
    numberByBlockId.set(block.id, { path, display: displayOf(path) })
  }

  // --- 参照解決（2 パス目）--------------------------------------------------
  const blockByLabel = new Map<string, Block<L, M>>()
  for (const block of blocks) {
    for (const label of block.labels) blockByLabel.set(label, block)
  }

  const unresolved: { fromBlockId: string; target: string }[] = []

  const resolveNodes = (nodes: readonly Node<L>[], fromBlockId: string): ResolvedNode[] =>
    nodes.map((node): ResolvedNode => {
      switch (node.type) {
        case 'paragraph':
          return { type: 'paragraph', children: resolveNodes(node.children, fromBlockId) }
        case 'list':
          return {
            type: 'list',
            items: node.items.map((item) => resolveNodes(item, fromBlockId)),
          }
        case 'ref': {
          const target = blockByLabel.get(node.target)
          if (target === undefined) {
            unresolved.push({ fromBlockId, target: node.target })
            // 未解決は下でエラーになるので、ここで返す値は使われない。
            return { type: 'text', value: '' }
          }
          return {
            type: 'ref',
            targetBlockId: target.id,
            targetKind: target.kind,
            targetNumber: numberByBlockId.get(target.id) ?? null,
            targetTitle: target.kind === 'figure' ? null : titleOf(target.title),
            anchor: anchorOf(target.id),
            overrideText: node.label ?? null,
          }
        }
        default:
          return node
      }
    })

  const resolvedBlocks: ResolvedBlock[] = blocks.map((block): ResolvedBlock => {
    const anchor = anchorOf(block.id)
    if (block.kind === 'heading') {
      return {
        kind: 'heading',
        blockId: block.id,
        level: block.level,
        number: numberByBlockId.get(block.id) ?? null,
        title: block.title,
        anchor,
      }
    }
    // 見出し以外は必ず番号を持つ（採番パスで全件入れている）。
    const number = numberByBlockId.get(block.id) ?? { path: [], display: '' }
    if (block.kind === 'figure') {
      return {
        kind: 'figure',
        blockId: block.id,
        number,
        content: resolveNodes(block.content, block.id),
        caption: block.caption === undefined ? null : resolveNodes(block.caption, block.id),
        anchor,
      }
    }
    const { id: _id, labels: _labels, kind, title, statement, proof, origin: _origin, ...meta } = block
    return {
      kind,
      blockId: block.id,
      number,
      title: titleOf(title),
      statement: resolveNodes(statement, block.id),
      proof: proof === undefined ? null : resolveNodes(proof, block.id),
      anchor,
      meta,
    }
  })

  // --- ノートの配置 ---------------------------------------------------------
  const notesByBlockId: Record<string, ResolvedNote[]> = {}
  const orphanNoteIds: string[] = []
  for (const note of notes) {
    const targetBlockIds = new Set<string>()
    for (const target of note.targets) {
      const block = blockByLabel.get(target)
      if (block !== undefined) targetBlockIds.add(block.id)
    }
    if (targetBlockIds.size === 0) {
      orphanNoteIds.push(note.id)
      continue
    }
    const resolvedNote: ResolvedNote = {
      noteId: note.id,
      title: titleOf(note.title),
      // 出版ターゲットでも本文の解決は走らせる（ノート内の未解決参照を見逃さないため）。
      body: resolveNodes(note.body, note.id),
      anchor: anchorOf(note.id),
    }
    // 出版ターゲットでは**配置しない**（`notesByBlockId` は空で固定される。I5）。
    if (options.audience === 'publication') continue
    for (const blockId of targetBlockIds) {
      const bucket = notesByBlockId[blockId]
      if (bucket === undefined) notesByBlockId[blockId] = [resolvedNote]
      else bucket.push(resolvedNote)
    }
  }

  if (unresolved.length > 0) return err({ code: 'unresolved_reference', references: unresolved })
  if (orphanNoteIds.length > 0) return err({ code: 'orphan_note', noteIds: orphanNoteIds })

  return ok({
    documentId: revision.documentId,
    revision: revision.revision,
    blocks: resolvedBlocks,
    notesByBlockId,
    outline,
  })
}
