/**
 * L1（入力言語）: 文書要素をまとめる第一級の構造。
 *
 * 著者は節と要素グループの木を書く。`compileDocumentStructure` が、部分アップロード契約で
 * 既に確定している平坦なブロック列へ正規化すると同時に、所属関係を失わない索引を作る。
 * throw せず、構造上の不備は Result で返す。
 */

import { err, ok, type Result } from '../result.ts'
import type {
  Block,
  FigureBlock,
  HeadingBlock,
  StandingBearingBlock,
  TheoremLikeBlock,
  TitleContent,
} from './block.ts'

export type DefinitionBlock<L extends string = string, M = unknown> = TheoremLikeBlock<L, M> & {
  kind: 'definition'
  standing?: never
}
export type AssertionBlock<L extends string = string, M = unknown> = StandingBearingBlock<L, M>
export type RemarkBlock<L extends string = string, M = unknown> = TheoremLikeBlock<L, M> & {
  kind: 'remark' | 'note'
  standing?: never
}

/** グループの中心になれる要素。主定理・主な主張・主な定義を同じ仕組みで表す。 */
export type FocalBlock<L extends string = string, M = unknown> =
  | AssertionBlock<L, M>
  | DefinitionBlock<L, M>

export type ExpositoryBlock<L extends string = string, M = unknown> =
  | RemarkBlock<L, M>
  | FigureBlock<L>

export type GroupSupportRole =
  | 'prerequisiteDefinition'
  | 'supportingClaim'
  | 'subgroup'
  | 'explanation'
  | 'figure'

export type GroupMember<L extends string = string, M = unknown> =
  | { role: 'prerequisiteDefinition'; element: DefinitionBlock<L, M> }
  | { role: 'supportingClaim'; element: AssertionBlock<L, M> }
  | { role: 'subgroup'; element: ElementGroup<L, M> }
  | { role: 'explanation'; element: RemarkBlock<L, M> }
  | { role: 'figure'; element: FigureBlock<L> }

/**
 * 一つの中心要素と、それを支える要素群。
 * `beforeFocus` / `afterFocus` に分けることで、中心が一つであることと文書順を同時に型で表す。
 */
export type ElementGroup<L extends string = string, M = unknown> = {
  kind: 'elementGroup'
  id: string
  title?: TitleContent
  beforeFocus?: readonly GroupMember<L, M>[]
  focus: FocalBlock<L, M>
  afterFocus?: readonly GroupMember<L, M>[]
}

export type SectionGroupRole = 'primary' | 'supporting'

export type SectionMember<L extends string = string, M = unknown> =
  | { role: 'subsection'; element: Section<L, M> }
  | { role: 'primary'; element: ElementGroup<L, M> }
  | { role: 'supporting'; element: ElementGroup<L, M> }
  | { role: 'exposition'; element: ExpositoryBlock<L, M> }

/** 章・節・項を同じ再帰型で表す。章名への写像は出力器が深さから決める。 */
export type Section<L extends string = string, M = unknown> = {
  kind: 'section'
  id: string
  labels: readonly L[]
  title: TitleContent
  children: readonly SectionMember<L, M>[]
}

export type DocumentStructure<L extends string = string, M = unknown> = {
  kind: 'documentStructure'
  sections: readonly Section<L, M>[]
}

export type CompiledSection = {
  sectionId: string
  parentSectionId: string | null
  depth: number
  memberIds: readonly string[]
  primaryGroupIds: readonly string[]
}

export type CompiledElementGroup = {
  groupId: string
  sectionId: string
  parentGroupId: string | null
  sectionRole: SectionGroupRole | null
  focusBlockId: string
  memberIds: readonly string[]
}

export type CompiledDocumentStructure<L extends string = string, M = unknown> = {
  /** 既存のセグメント・採番・参照解決へ渡せる正規形。 */
  blocks: readonly Block<L, M>[]
  /** 出力器が所属を推論し直さないための、明示された構造索引。 */
  sections: readonly CompiledSection[]
  groups: readonly CompiledElementGroup[]
}

export type DocumentStructureError =
  | { code: 'section_depth_exceeded'; sectionId: string; depth: number }
  | { code: 'duplicate_structure_id'; id: string }
  | { code: 'duplicate_block_membership'; blockId: string }

/** 末尾再帰（uniqueness.ts の要点と同じ。素朴なスプレッド連結は数百要素で TS2589 になる）。 */
type BlocksOfGroupMembers<
  T extends readonly GroupMember[],
  Acc extends readonly unknown[] = [],
> = T extends readonly [infer Head, ...infer Tail]
  ? Head extends GroupMember
    ? Tail extends readonly GroupMember[]
      ? BlocksOfGroupMembers<Tail, [...Acc, ...BlocksOfGroupMember<Head>]>
      : Acc
    : Acc
  : Acc

type BlocksOfGroupMember<T extends GroupMember> =
  T extends { role: 'subgroup'; element: infer Group extends ElementGroup }
    ? BlocksOfElementGroup<Group>
    : T extends { element: infer Element extends Block }
      ? [Element]
      : []

/** 要素グループを平坦化したときのブロックタプル。生成物の大域型検査で使う。 */
export type BlocksOfElementGroup<T extends ElementGroup> = [
  ...(T extends { beforeFocus: infer Before extends readonly GroupMember[] }
    ? BlocksOfGroupMembers<Before>
    : []),
  T['focus'],
  ...(T extends { afterFocus: infer After extends readonly GroupMember[] }
    ? BlocksOfGroupMembers<After>
    : []),
]

type HeadingOfSection<T extends Section> = {
  kind: 'heading'
  id: T['id']
  labels: T['labels']
  level: HeadingBlock['level']
  title: T['title']
}

type BlocksOfSectionMember<T extends SectionMember> =
  T extends { role: 'subsection'; element: infer Child extends Section }
    ? BlocksOfSection<Child>
    : T extends { role: 'primary' | 'supporting'; element: infer Group extends ElementGroup }
      ? BlocksOfElementGroup<Group>
      : T extends { role: 'exposition'; element: infer Element extends Block }
        ? [Element]
        : []

/** 末尾再帰（uniqueness.ts の要点と同じ。素朴なスプレッド連結は数百要素で TS2589 になる）。 */
type BlocksOfSectionMembers<
  T extends readonly SectionMember[],
  Acc extends readonly unknown[] = [],
> = T extends readonly [infer Head, ...infer Tail]
  ? Head extends SectionMember
    ? Tail extends readonly SectionMember[]
      ? BlocksOfSectionMembers<Tail, [...Acc, ...BlocksOfSectionMember<Head>]>
      : Acc
    : Acc
  : Acc

/** 1章を平坦化したときのブロックタプル。章単位なら巨大文書でも TypeScript の予算を超えない。 */
export type BlocksOfSection<T extends Section> = [
  HeadingOfSection<T>,
  ...BlocksOfSectionMembers<T['children']>,
]

/** 章ごとに `defineSection` したタプルを、生成物側で文書全体へ連結する（末尾再帰）。 */
export type BlocksOfSections<
  T extends readonly Section[],
  Acc extends readonly unknown[] = [],
> = T extends readonly [infer Head, ...infer Tail]
  ? Head extends Section
    ? Tail extends readonly Section[]
      ? BlocksOfSections<Tail, [...Acc, ...BlocksOfSection<Head>]>
      : Acc
    : Acc
  : Acc

export type BlocksOfDocumentStructure<T extends DocumentStructure> = BlocksOfSections<T['sections']>

export const compileDocumentStructure = <L extends string, M>(
  document: DocumentStructure<L, M>,
): Result<CompiledDocumentStructure<L, M>, readonly DocumentStructureError[]> => {
  const blocks: Block<L, M>[] = []
  const sections: CompiledSection[] = []
  const groups: CompiledElementGroup[] = []
  const errors: DocumentStructureError[] = []
  const structureIds = new Set<string>()
  const blockIds = new Set<string>()

  const claimStructureId = (id: string): void => {
    if (structureIds.has(id)) errors.push({ code: 'duplicate_structure_id', id })
    structureIds.add(id)
  }
  const appendBlock = (block: Block<L, M>): void => {
    if (blockIds.has(block.id)) errors.push({ code: 'duplicate_block_membership', blockId: block.id })
    blockIds.add(block.id)
    blocks.push(block)
  }

  const appendGroupMember = (
    member: GroupMember<L, M>,
    sectionId: string,
    parentGroupId: string,
  ): void => {
    if (member.role === 'subgroup') {
      appendGroup(member.element, sectionId, parentGroupId, null)
      return
    }
    appendBlock(member.element)
  }

  const appendGroup = (
    group: ElementGroup<L, M>,
    sectionId: string,
    parentGroupId: string | null,
    sectionRole: SectionGroupRole | null,
  ): void => {
    claimStructureId(group.id)
    const beforeFocus = group.beforeFocus ?? []
    const afterFocus = group.afterFocus ?? []
    const memberIds = [
      ...beforeFocus.map((member) => member.element.id),
      group.focus.id,
      ...afterFocus.map((member) => member.element.id),
    ]
    groups.push({
      groupId: group.id,
      sectionId,
      parentGroupId,
      sectionRole,
      focusBlockId: group.focus.id,
      memberIds,
    })
    for (const member of beforeFocus) {
      appendGroupMember(member, sectionId, group.id)
    }
    appendBlock(group.focus)
    for (const member of afterFocus) {
      appendGroupMember(member, sectionId, group.id)
    }
  }

  const appendSection = (section: Section<L, M>, parentSectionId: string | null, depth: number): void => {
    claimStructureId(section.id)
    if (depth > 6) errors.push({ code: 'section_depth_exceeded', sectionId: section.id, depth })
    const heading: HeadingBlock<L> = {
      kind: 'heading',
      id: section.id,
      labels: section.labels,
      level: Math.min(depth, 6) as HeadingBlock<L>['level'],
      title: section.title,
    }
    appendBlock(heading)

    const memberIds = section.children.map((member) => member.element.id)
    const primaryGroupIds = section.children
      .filter((member): member is Extract<SectionMember<L, M>, { role: 'primary' }> => member.role === 'primary')
      .map((member) => member.element.id)
    sections.push({ sectionId: section.id, parentSectionId, depth, memberIds, primaryGroupIds })
    for (const member of section.children) {
      if (member.role === 'subsection') {
        appendSection(member.element, section.id, depth + 1)
      } else if (member.role === 'primary' || member.role === 'supporting') {
        appendGroup(member.element, section.id, null, member.role)
      } else {
        appendBlock(member.element)
      }
    }
  }

  for (const section of document.sections) appendSection(section, null, 1)

  return errors.length > 0 ? err(errors) : ok({ blocks, sections, groups })
}
