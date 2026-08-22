/** 静的 HTML の既定 UI: 節の主要な定義・定理・主張を読む前に示す。 */

import type { Block } from '../../domain-model/structured-text/block.ts'
import type { CompiledDocumentStructure } from '../../domain-model/structured-text/document-structure.ts'

export type PrimaryElementEntry = {
  anchor: string
  kind: 'definition' | 'theorem' | 'claim'
  /** 採番と題名を含む、既に HTML として安全な表示文字列。 */
  text: string
}

/**
 * 構造索引から節の主要要素だけを取り出す。所属を文書順から推測しない。
 * 表示文字列は採番済み情報を持つ利用側が与える。
 */
export const primaryElementEntriesOf = <L extends string, M>(
  structure: CompiledDocumentStructure<L, M>,
  sectionId: string,
  textOf: (block: Block<L, M>) => string,
): PrimaryElementEntry[] => {
  const section = structure.sections.find((candidate) => candidate.sectionId === sectionId)
  if (section === undefined) return []
  const groupById = new Map(structure.groups.map((group) => [group.groupId, group]))
  const blockById = new Map(structure.blocks.map((block) => [block.id, block]))
  const entries: PrimaryElementEntry[] = []
  for (const groupId of section.primaryGroupIds) {
    const group = groupById.get(groupId)
    const block = group === undefined ? undefined : blockById.get(group.focusBlockId)
    if (block === undefined) continue
    if (block.kind !== 'definition' && block.kind !== 'theorem' && block.kind !== 'claim') continue
    entries.push({ anchor: block.id, kind: block.kind, text: textOf(block) })
  }
  return entries
}

const renderGroup = (title: string, entries: readonly PrimaryElementEntry[]): string => {
  if (entries.length === 0) return ''
  const items = entries.map((entry) => `<li><a href="#${entry.anchor}">${entry.text}</a></li>`).join('')
  return `<section class="primary-elements__group"><div class="primary-elements__title">${title}</div><ul>${items}</ul></section>`
}

/** 主要要素が無い節では空文字を返し、空の案内を表示しない。 */
export const renderPrimaryElementsLead = (entries: readonly PrimaryElementEntry[]): string => {
  const definitions = entries.filter((entry) => entry.kind === 'definition')
  const assertions = entries.filter((entry) => entry.kind === 'theorem' || entry.kind === 'claim')
  if (definitions.length === 0 && assertions.length === 0) return ''
  return (
    `<nav class="primary-elements" aria-label="この節の主要要素">` +
    renderGroup('この節の主な定義', definitions) +
    renderGroup('この節の主定理・主張', assertions) +
    `</nav>`
  )
}

export const PRIMARY_ELEMENTS_CSS = String.raw`
.primary-elements { margin:18px 0 26px; padding:14px 18px; border:1px solid var(--line);
  border-radius:8px; background:var(--panel); }
.primary-elements__group + .primary-elements__group { margin-top:12px; }
.primary-elements__title { font-size:.78rem; font-weight:700; letter-spacing:.1em;
  color:var(--muted); margin-bottom:6px; }
.primary-elements ul { margin:0; padding-left:1.2em; }
.primary-elements li { margin:.2em 0; line-height:1.6; }
`
