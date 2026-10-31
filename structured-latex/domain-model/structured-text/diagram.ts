/**
 * L1（入力言語）: 図式ノードの**中身の整合性**の検査。
 *
 * 形（フィールドと型）は実行時スキーマ（`validate.ts`）が見る。ここが見るのは、
 * 図式 1 つの中で閉じる参照と一意性である。型でも枠・箱への参照は束縛している
 * （`node.ts` の `diagram`）が、型を経由しない値（外部の JSON など）のためにここでも確かめる。
 *
 * 純関数。throw しない。
 */

import type { DiagramNode } from './node.ts'

export type DiagramIssue = {
  /** 図式の中の位置（`boxes.3.group` など）。 */
  path: readonly (string | number)[]
  message: string
}

const duplicatesOf = (values: readonly string[]): Set<string> => {
  const seen = new Set<string>()
  const duplicated = new Set<string>()
  for (const value of values) {
    if (seen.has(value)) duplicated.add(value)
    seen.add(value)
  }
  return duplicated
}

/**
 * 図式の整合性の違反を全件集めて返す（1 件目で止めない）。
 *
 * 検査すること:
 *   - 枠の id・箱の id がそれぞれ一意であること
 *   - 箱の所属先の枠が宣言されていること、どの枠にも 1 つ以上の箱があること
 *   - 同じ格子位置（列・行）に 2 つの箱を置かないこと
 *   - 矢印の両端が宣言された箱であること、自分自身へ向かわないこと、同じ矢印を 2 度書かないこと
 *   - 矢印が上の行から下の行へ向かうこと（行は矢印の向きに沿った順位である）
 */
export const diagramIssuesOf = (diagram: DiagramNode): DiagramIssue[] => {
  const issues: DiagramIssue[] = []

  const duplicatedGroupIds = duplicatesOf(diagram.groups.map((group) => group.id))
  diagram.groups.forEach((group, index) => {
    if (duplicatedGroupIds.has(group.id)) {
      issues.push({ path: ['groups', index, 'id'], message: `枠の id が重複している: ${group.id}` })
    }
  })

  const duplicatedBoxIds = duplicatesOf(diagram.boxes.map((box) => box.id))
  const groupIds = new Set(diagram.groups.map((group) => group.id))
  const occupied = new Map<string, string>()
  diagram.boxes.forEach((box, index) => {
    if (duplicatedBoxIds.has(box.id)) {
      issues.push({ path: ['boxes', index, 'id'], message: `箱の id が重複している: ${box.id}` })
    }
    if (box.group !== undefined && !groupIds.has(box.group)) {
      issues.push({
        path: ['boxes', index, 'group'],
        message: `箱 ${box.id} の所属先の枠が宣言されていない: ${box.group}`,
      })
    }
    const position = `${box.column},${box.row}`
    const owner = occupied.get(position)
    if (owner !== undefined) {
      issues.push({
        path: ['boxes', index],
        message: `箱 ${owner} と箱 ${box.id} が同じ位置（列 ${box.column}、行 ${box.row}）にある`,
      })
    } else {
      occupied.set(position, box.id)
    }
  })

  diagram.groups.forEach((group, index) => {
    if (!diagram.boxes.some((box) => box.group === group.id)) {
      issues.push({ path: ['groups', index], message: `枠 ${group.id} に箱が 1 つも無い` })
    }
  })

  const boxById = new Map(diagram.boxes.map((box) => [box.id, box]))
  const seenEdges = new Set<string>()
  diagram.edges.forEach((edge, index) => {
    const from = boxById.get(edge.from)
    const to = boxById.get(edge.to)
    if (from === undefined) {
      issues.push({ path: ['edges', index, 'from'], message: `矢印の元の箱が宣言されていない: ${edge.from}` })
    }
    if (to === undefined) {
      issues.push({ path: ['edges', index, 'to'], message: `矢印の先の箱が宣言されていない: ${edge.to}` })
    }
    if (edge.from === edge.to) {
      issues.push({ path: ['edges', index], message: `矢印が自分自身へ向かっている: ${edge.from}` })
    }
    const key = `${edge.from}\u0000${edge.to}`
    if (seenEdges.has(key)) {
      issues.push({ path: ['edges', index], message: `同じ矢印が 2 度ある: ${edge.from} → ${edge.to}` })
    }
    seenEdges.add(key)
    if (from !== undefined && to !== undefined && from.row >= to.row) {
      issues.push({
        path: ['edges', index],
        message:
          `矢印は上の行から下の行へ向かわなければならない: ${edge.from}（行 ${from.row}）→ ` +
          `${edge.to}（行 ${to.row}）`,
      })
    }
  })

  return issues
}
