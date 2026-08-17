/**
 * 版のスナップショットを解決済み文書へ写す**純関数**。
 *
 * ここが「F9 の反復（ラベル解決が出力形式ごとに書かれる）」を止める 1 か所である。
 * 文書全体にかかる不変条件（I1 一意性・I2 参照解決・I3 非空）を判定できるのもここだけで、
 * ブロック 1 件やセグメント 1 つでは判定できない（＝集約の境界が文書 1 つである根拠）。
 *
 * **解決の実装はこのファイルの `resolveTolerantly` 1 つだけである。**
 * 出力の種類ごとに 2 つの入口を用意するが、両方とも同じ実装を通る:
 *
 * | 入口 | 返すもの | 使う側 |
 * | --- | --- | --- |
 * | `resolve` | `Result<ResolvedDocument, ResolveError>`（壊れていれば解決済み文書を返さない） | 出版物の生成（未解決参照を含む LaTeX/PDF を出してはならない） |
 * | `resolveTolerantly` | 解決済み文書 + 診断リスト（壊れていても文書を返す） | 執筆支援ツール（壊れた箇所を画面に描き続ける） |
 *
 * 以前は後者が無かったため、執筆支援側がラベル解決とノート配置を
 * 独立に再実装していた（F9 の反復が別の形で残っていた）。それをここへ吸収した。
 *
 * throw しない。エラーは Result で返す（docs/error-handling-strategy.md §1）。
 */

import { err, ok, type Result } from '../result.ts'
import { standingOf } from '../structured-text/block.ts'
import type { Block, HeadingLevel, Note, Origin, TitleContent } from '../structured-text/block.ts'
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

/**
 * 解決中に見つかった不備を 1 件ずつ表したもの。
 *
 * `ResolveError` が「文書を出力してはならない理由」を集約 1 件で述べるのに対し、
 * こちらは**捨てずに画面へ出すための素材**なので 1 件ずつ独立に持つ。
 * `code` は `ResolveError` と同じ語彙にしてあり、両者を突き合わせられる。
 */
export type ResolveDiagnostic =
  | { code: 'duplicate_segment_key'; key: SegmentKey }
  | { code: 'empty_document' }
  | { code: 'duplicate_block_id'; blockId: string }
  | { code: 'duplicate_label'; label: string }
  | { code: 'duplicate_note_id'; noteId: string }
  | { code: 'unresolved_reference'; fromBlockId: string; target: string }
  | { code: 'orphan_note'; noteId: string; targets: readonly string[] }

/** 寛容な解決の結果。**壊れていても文書は必ず返す**。 */
export type Resolution = {
  document: ResolvedDocument
  /**
   * targets がどのブロックのラベルにも解決しなかったノート。
   * `document.notesByBlockId` には現れない（置き場所が決まらないため）が、
   * 黙って捨てると気付けないので、ここに集めて呼び出し側が表示できるようにする。
   */
  orphanNotes: readonly ResolvedNote[]
  diagnostics: readonly ResolveDiagnostic[]
}

const titleOf = (title: TitleContent | null | undefined): TitleContent | null => title ?? null

const originOf = (origin: Origin | undefined): Origin | null => origin ?? null

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

/**
 * 版のスナップショットを解決済み文書へ写す。**不備があっても解決を止めない。**
 *
 * 不備は `diagnostics` に集め、文書側では次のように「壊れたまま表現」する:
 *   - 未解決参照 … `unresolvedRef` ノードとして残る（本文から消さない）
 *   - 迷子ノート … `orphanNotes` に残る（配置先が決まらないだけで、中身は解決済み）
 *   - id・ラベルの重複 … 後勝ちで解決し、重複した事実を診断に残す
 *   - 空文書 … ブロック 0 件の文書を返す
 */
export const resolveTolerantly = <L extends string, M>(
  revision: RevisionSnapshot<L, M>,
  options: ResolveOptions,
): Resolution => {
  const anchorPrefix = options.anchorPrefix ?? ''
  const anchorOf = (id: string): string => `${anchorPrefix}${id}`
  const diagnostics: ResolveDiagnostic[] = []

  for (const key of duplicatesOf(revision.segments.map((segment) => segment.key))) {
    diagnostics.push({ code: 'duplicate_segment_key', key })
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

  if (blocks.length === 0) diagnostics.push({ code: 'empty_document' })

  for (const blockId of duplicatesOf(blocks.map((block) => block.id))) {
    diagnostics.push({ code: 'duplicate_block_id', blockId })
  }

  for (const label of duplicatesOf(blocks.flatMap((block) => [...block.labels]))) {
    diagnostics.push({ code: 'duplicate_label', label })
  }

  // ノート id はブロック id とも衝突しない（衝突するとアンカーが一意に決まらない）。
  const duplicatedNoteIds = duplicatesOf([
    ...notes.map((note) => note.id),
    ...blocks.map((block) => block.id),
  ]).filter((id) => notes.some((note) => note.id === id))
  for (const noteId of duplicatedNoteIds) {
    diagnostics.push({ code: 'duplicate_note_id', noteId })
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
            diagnostics.push({
              code: 'unresolved_reference',
              fromBlockId,
              target: node.target,
            })
            // 本文から消さずに「未解決である」という事実ごと残す。
            // 出版ターゲットではこの後 `resolve` がエラーにするので出力へは出ない。
            return {
              type: 'unresolvedRef',
              target: node.target,
              fromBlockId,
              overrideText: node.label ?? null,
            }
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
    const labels = [...block.labels]
    const origin = originOf(block.origin)
    if (block.kind === 'heading') {
      return {
        kind: 'heading',
        blockId: block.id,
        level: block.level,
        number: numberByBlockId.get(block.id) ?? null,
        title: block.title,
        anchor,
        labels,
        origin,
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
        labels,
        origin,
      }
    }
    const {
      id: _id,
      labels: _labels,
      kind,
      title,
      statement,
      proof,
      origin: _origin,
      // 身分は入力言語の第一級のフィールドであってプロジェクト固有メタデータではない。
      // ここで取り出さないと `meta` の中へ紛れ込み、出力器から意味のある形で読めなくなる。
      standing: _standing,
      ...meta
    } = block
    return {
      kind,
      standing: standingOf(block),
      blockId: block.id,
      number,
      title: titleOf(title),
      statement: resolveNodes(statement, block.id),
      proof: proof === undefined ? null : resolveNodes(proof, block.id),
      anchor,
      labels,
      origin,
      meta,
    }
  })

  // --- ノートの配置 ---------------------------------------------------------
  const notesByBlockId: Record<string, ResolvedNote[]> = {}
  const orphanNotes: ResolvedNote[] = []
  for (const note of notes) {
    const targetBlockIds = new Set<string>()
    for (const target of note.targets) {
      const block = blockByLabel.get(target)
      if (block !== undefined) targetBlockIds.add(block.id)
    }
    const resolvedNote: ResolvedNote = {
      noteId: note.id,
      title: titleOf(note.title),
      // 出版ターゲットでも本文の解決は走らせる（ノート内の未解決参照を見逃さないため）。
      //
      // ここは**先行実装から意図的に変えた 1 点**である。以前は迷子ノート（targets がどの
      // ブロックにも解決しないノート）の本文を解決せずに読み飛ばしていたため、
      // 「迷子でありかつ本文に未解決参照を含むノート」の未解決参照は検出されなかった。
      // 今は迷子かどうかに関わらず本文を解決するので、その未解決参照も診断に出る。
      // 副作用として `firstErrorOf` の優先順位により、そのようなノートがあるときに
      // `resolve` が返すエラー種別が `orphan_note` から `unresolved_reference` へ変わる。
      // 検出漏れが減る方向の変化であり、どちらにせよ出版は止まるので、こちらを採る。
      body: resolveNodes(note.body, note.id),
      anchor: anchorOf(note.id),
      targets: [...note.targets],
      origin: originOf(note.origin),
    }
    if (targetBlockIds.size === 0) {
      diagnostics.push({
        code: 'orphan_note',
        noteId: note.id,
        targets: [...note.targets],
      })
      orphanNotes.push(resolvedNote)
      continue
    }
    // 出版ターゲットでは**配置しない**（`notesByBlockId` は空で固定される。I5）。
    if (options.audience === 'publication') continue
    for (const blockId of targetBlockIds) {
      const bucket = notesByBlockId[blockId]
      if (bucket === undefined) notesByBlockId[blockId] = [resolvedNote]
      else bucket.push(resolvedNote)
    }
  }

  return {
    document: {
      documentId: revision.documentId,
      revision: revision.revision,
      blocks: resolvedBlocks,
      notesByBlockId,
      outline,
    },
    orphanNotes,
    diagnostics,
  }
}

/**
 * 診断リストを、出版を止める理由 1 件へ畳む。
 *
 * 判定の順序は「文書の形が壊れている → 中身の参照が壊れている」の順で、
 * 先に見つかった種別だけを返す（種別ごとに集約するのは、修正するとき同種をまとめて直すため）。
 */
const firstErrorOf = (diagnostics: readonly ResolveDiagnostic[]): ResolveError | null => {
  const keys = diagnostics.flatMap((d) => (d.code === 'duplicate_segment_key' ? [d.key] : []))
  if (keys.length > 0) return { code: 'duplicate_segment_key', keys }

  if (diagnostics.some((d) => d.code === 'empty_document')) return { code: 'empty_document' }

  const blockIds = diagnostics.flatMap((d) => (d.code === 'duplicate_block_id' ? [d.blockId] : []))
  if (blockIds.length > 0) return { code: 'duplicate_block_id', blockIds }

  const labels = diagnostics.flatMap((d) => (d.code === 'duplicate_label' ? [d.label] : []))
  if (labels.length > 0) return { code: 'duplicate_label', labels }

  const duplicatedNoteIds = diagnostics.flatMap((d) =>
    d.code === 'duplicate_note_id' ? [d.noteId] : [],
  )
  if (duplicatedNoteIds.length > 0) return { code: 'duplicate_note_id', noteIds: duplicatedNoteIds }

  const references = diagnostics.flatMap((d) =>
    d.code === 'unresolved_reference' ? [{ fromBlockId: d.fromBlockId, target: d.target }] : [],
  )
  if (references.length > 0) return { code: 'unresolved_reference', references }

  const orphanNoteIds = diagnostics.flatMap((d) => (d.code === 'orphan_note' ? [d.noteId] : []))
  if (orphanNoteIds.length > 0) return { code: 'orphan_note', noteIds: orphanNoteIds }

  return null
}

/**
 * 厳格な解決。不備が 1 件でもあれば**解決済み文書を返さない**。
 *
 * 出版物（LaTeX / PDF / 公開サイト）の生成はこちらを使う。壊れた文書を出力してはならないため。
 * 執筆中の画面のように「壊れていても表示し続ける」側は `resolveTolerantly` を使う。
 */
export const resolve = <L extends string, M>(
  revision: RevisionSnapshot<L, M>,
  options: ResolveOptions,
): Result<ResolvedDocument, ResolveError> => {
  const resolution = resolveTolerantly(revision, options)
  const error = firstErrorOf(resolution.diagnostics)
  return error === null ? ok(resolution.document) : err(error)
}
