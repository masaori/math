/**
 * 図式ノードの**幾何**（箱・枠・矢印の座標）を計算する、出力器に共通の 1 か所。
 *
 * HTML（SVG）と LaTeX（TikZ）はどちらもこの結果を描くだけで、座標を自分では決めない。
 * 同じ図式が出力形式ごとに違う形になる事故を、計算を 1 つにすることで構造的に防ぐ。
 *
 * 規則:
 *   - 箱の位置は著者が格子（列・行）で与える。自動レイアウトはしない。
 *   - 矢印は直交折れ線である。箱の下辺の中央から出て、必要なら行の間の通り道で横へ曲がり、
 *     箱の上辺の中央へ入る。曲がる通り道は、矢印の元の真下か先の真上のうち、
 *     途中の行の箱に当たらない方を選ぶ。どちらでも当たるなら描けないとして誤りを返す
 *     （箱を動かすのは著者の判断である）。
 *   - 同じ箱から出る矢印は出口を共有し、同じ箱へ入る矢印は入口を共有する（木の形に見える）。
 *     それ以外の矢印どうしが同じ線の上に重なるなら誤りを返す。
 *   - 枠の題は、枠の上辺の帯の左に置き、帯を通る矢印に届かない幅に収める。
 *   - 計算の最後に「矢印が箱にも枠の題にも重ならない」ことを検査し、破れていれば誤りを返す。
 *
 * 座標の単位は抽象的な長さである（HTML では px、LaTeX では出力器が選ぶ倍率の pt）。
 * y は下向きに増える。純関数。throw しない。
 */

import { err, ok, type Result } from '../../domain-model/result.ts'
import { diagramIssuesOf, type DiagramIssue } from '../../domain-model/structured-text/diagram.ts'
import type { DiagramBox, DiagramLabelNode, DiagramNode } from '../../domain-model/structured-text/node.ts'

export type Point = { x: number; y: number }
export type Rect = { x: number; y: number; width: number; height: number }

/** 寸法。すべて同じ抽象単位。 */
export type DiagramMetrics = {
  boxWidth: number
  boxHeight: number
  /** 隣り合う列の箱どうしの水平の隙間。 */
  columnGap: number
  /** 行の間で、矢印が横へ曲がる通り道の高さ（通り道が 1 本のとき）。 */
  channelHeight: number
  /** 同じ行の間に通り道が複数要るときの、通り道どうしの間隔。 */
  laneSpacing: number
  /** 枠と、枠の中の箱との隙間。 */
  groupPadding: number
  /** 枠の題を置く帯の高さ。 */
  groupTitleHeight: number
  /** 図全体の外周の余白。 */
  margin: number
  /** 箱の題の、箱の左右の辺からの内側の余白。 */
  boxTextInset: number
  /** 矢印と、枠の題との水平の最小の隙間。 */
  clearance: number
  arrowLength: number
  arrowHalfWidth: number
  /** 箱の題の文字の大きさ。 */
  labelFontSize: number
  /** 枠の題の文字の大きさ。 */
  groupTitleFontSize: number
}

export const DEFAULT_DIAGRAM_METRICS: DiagramMetrics = {
  boxWidth: 232,
  boxHeight: 52,
  columnGap: 56,
  channelHeight: 22,
  laneSpacing: 10,
  groupPadding: 12,
  groupTitleHeight: 22,
  margin: 8,
  boxTextInset: 8,
  clearance: 8,
  arrowLength: 9,
  arrowHalfWidth: 4.5,
  labelFontSize: 14,
  groupTitleFontSize: 13,
}

export type LaidOutBox = {
  id: string
  title: readonly DiagramLabelNode[]
  /** 箱の外形。 */
  rect: Rect
  /** 題を置く領域（外形から左右の内側の余白を除いたもの）。 */
  textRect: Rect
}

export type LaidOutGroup = {
  id: string
  title: readonly DiagramLabelNode[]
  frame: Rect
  /** 題を置く領域。この領域には矢印が通らない。 */
  titleRect: Rect
}

export type LaidOutEdge = {
  from: string
  to: string
  /** 折れ線の頂点。最後の点が矢じりの先端（矢印の先の箱の上辺）。 */
  points: readonly Point[]
  /** 線として描く部分。`points` の最後の点を矢じりの付け根まで戻したもの。 */
  shaft: readonly Point[]
  /** 矢じり（塗りつぶす三角形。最後の点が先端）。 */
  head: readonly [Point, Point, Point]
}

export type DiagramLayout = {
  width: number
  height: number
  metrics: DiagramMetrics
  groups: readonly LaidOutGroup[]
  boxes: readonly LaidOutBox[]
  edges: readonly LaidOutEdge[]
}

export type DiagramLayoutError =
  | { code: 'invalid_diagram'; issues: readonly DiagramIssue[] }
  | { code: 'unroutable_edge'; from: string; to: string }
  | { code: 'overlapping_groups'; groupIds: readonly [string, string] }
  | { code: 'box_inside_foreign_group'; boxId: string; groupId: string }
  | { code: 'overlapping_edges'; edges: readonly [string, string] }
  | { code: 'edge_crosses_box'; edge: string; boxId: string }
  | { code: 'edge_crosses_group_title'; edge: string; groupId: string }
  | { code: 'no_room_for_group_title'; groupId: string }

/** 誤りを人が読める 1 行にする（生成器がそのまま例外の文面に使う）。 */
export const describeDiagramLayoutError = (error: DiagramLayoutError): string => {
  switch (error.code) {
    case 'invalid_diagram':
      return `図式が不正: ${error.issues.map((issue) => `${issue.path.join('.')}: ${issue.message}`).join(' / ')}`
    case 'unroutable_edge':
      return `矢印 ${error.from} → ${error.to} は、途中の行の箱に当たらずには引けない（箱の位置を変える）`
    case 'overlapping_groups':
      return `枠 ${error.groupIds[0]} と枠 ${error.groupIds[1]} が重なる`
    case 'box_inside_foreign_group':
      return `箱 ${error.boxId} が、所属しない枠 ${error.groupId} の中にある`
    case 'overlapping_edges':
      return `矢印 ${error.edges[0]} と矢印 ${error.edges[1]} が同じ線の上に重なる`
    case 'edge_crosses_box':
      return `矢印 ${error.edge} が箱 ${error.boxId} に重なる`
    case 'edge_crosses_group_title':
      return `矢印 ${error.edge} が枠 ${error.groupId} の題に重なる`
    case 'no_room_for_group_title':
      return `枠 ${error.groupId} の題を置く幅が無い（矢印が枠の左端の近くを通っている）`
  }
}

const EPSILON = 1e-6

const edgeName = (edge: { from: string; to: string }): string => `${edge.from} → ${edge.to}`

type Plan =
  | { kind: 'straight'; x: number }
  | { kind: 'turn'; gap: number; fromX: number; toX: number; sharedKey: string }

type Segment = { edgeIndex: number; a: Point; b: Point }

const intersectsInterior = (segment: Segment, rect: Rect): boolean => {
  const minX = Math.min(segment.a.x, segment.b.x)
  const maxX = Math.max(segment.a.x, segment.b.x)
  const minY = Math.min(segment.a.y, segment.b.y)
  const maxY = Math.max(segment.a.y, segment.b.y)
  // 線分は水平か垂直なので、外接矩形どうしの交わり（内部）で判定できる。
  // 太さ 0 の線分を扱うため、線分側は閉区間、矩形側は開区間で比べる。
  return (
    maxX > rect.x + EPSILON &&
    minX < rect.x + rect.width - EPSILON &&
    maxY > rect.y + EPSILON &&
    minY < rect.y + rect.height - EPSILON
  )
}

const rectsOverlap = (left: Rect, right: Rect): boolean =>
  left.x < right.x + right.width - EPSILON &&
  right.x < left.x + left.width - EPSILON &&
  left.y < right.y + right.height - EPSILON &&
  right.y < left.y + left.height - EPSILON

/** 著者の格子位置から座標を計算する。 */
export const layoutDiagram = (
  diagram: DiagramNode,
  metrics: DiagramMetrics = DEFAULT_DIAGRAM_METRICS,
): Result<DiagramLayout, DiagramLayoutError> => {
  const issues = diagramIssuesOf(diagram)
  if (issues.length > 0) return err({ code: 'invalid_diagram', issues })

  const boxById = new Map<string, DiagramBox>(diagram.boxes.map((box) => [box.id, box]))
  const pitch = metrics.boxWidth + metrics.columnGap
  const leftOf = (box: DiagramBox): number =>
    metrics.margin + metrics.groupPadding + box.column * pitch
  const centerXOf = (box: DiagramBox): number => leftOf(box) + metrics.boxWidth / 2

  // --- 経路の計画（x と、どの行の間で曲がるか）。y はまだ決めない -------------------
  /** 行 fromRow と toRow の**間の行**の箱に、縦線 x が当たるか。 */
  const blocked = (x: number, fromRow: number, toRow: number): boolean =>
    diagram.boxes.some(
      (box) =>
        box.row > fromRow &&
        box.row < toRow &&
        x > leftOf(box) - EPSILON &&
        x < leftOf(box) + metrics.boxWidth + EPSILON,
    )

  const plans: Plan[] = []
  for (const edge of diagram.edges) {
    // 整合性の検査を通っているので、両端の箱は必ず在る。
    const from = boxById.get(edge.from) as DiagramBox
    const to = boxById.get(edge.to) as DiagramBox
    const fromX = centerXOf(from)
    const toX = centerXOf(to)
    if (Math.abs(fromX - toX) < EPSILON && !blocked(fromX, from.row, to.row)) {
      plans.push({ kind: 'straight', x: fromX })
    } else if (!blocked(toX, from.row, to.row)) {
      plans.push({ kind: 'turn', gap: from.row, fromX, toX, sharedKey: `from:${from.id}` })
    } else if (!blocked(fromX, from.row, to.row)) {
      plans.push({ kind: 'turn', gap: to.row - 1, fromX, toX, sharedKey: `to:${to.id}` })
    } else {
      return err({ code: 'unroutable_edge', from: edge.from, to: edge.to })
    }
  }

  // --- 通り道の割り当て（同じ行の間で横線が重なるなら別の通り道へ） ------------------
  //
  // 横線が重なる 2 本は上下に並べる。どちらを上にするかで交差の数が変わる:
  // 上の横線の範囲に、下の横線へ降りてくる縦線（元の側）が入れば交差し、
  // 下の横線の範囲に、上の横線から降りていく縦線（先の側）が入れば交差する。
  // 交差の少ない方を上にする。
  type LaneEntry = { edgeIndex: number; min: number; max: number; fromX: number; toX: number; key: string }
  const laneOf = new Map<number, number>()
  const laneCountOfGap = new Map<number, number>()
  {
    const strictlyInside = (x: number, entry: LaneEntry): boolean =>
      x > entry.min + EPSILON && x < entry.max - EPSILON
    const crossingsIfAbove = (upper: LaneEntry, lower: LaneEntry): number =>
      (strictlyInside(lower.fromX, upper) ? 1 : 0) + (strictlyInside(upper.toX, lower) ? 1 : 0)
    const conflicts = (left: LaneEntry, right: LaneEntry): boolean =>
      left.key !== right.key &&
      left.min <= right.max + metrics.clearance &&
      right.min <= left.max + metrics.clearance
    const byGap = new Map<number, LaneEntry[]>()
    plans.forEach((plan, edgeIndex) => {
      if (plan.kind !== 'turn') return
      const entries = byGap.get(plan.gap) ?? []
      entries.push({
        edgeIndex,
        min: Math.min(plan.fromX, plan.toX),
        max: Math.max(plan.fromX, plan.toX),
        fromX: plan.fromX,
        toX: plan.toX,
        key: plan.sharedKey,
      })
      byGap.set(plan.gap, entries)
    })
    for (const [gap, entries] of byGap) {
      const ordered = [...entries].sort((a, b) => {
        if (conflicts(a, b)) {
          const difference = crossingsIfAbove(a, b) - crossingsIfAbove(b, a)
          if (difference !== 0) return difference
        }
        return a.min - b.min || a.max - b.max || a.edgeIndex - b.edgeIndex
      })
      // 先に並べたものほど上の通り道へ。重なる相手より必ず下へ置くので、上の順序が保たれる。
      const placed: { entry: LaneEntry; lane: number }[] = []
      for (const entry of ordered) {
        const lane = Math.max(
          -1,
          ...placed.filter((other) => conflicts(other.entry, entry)).map((other) => other.lane),
        ) + 1
        placed.push({ entry, lane })
        laneOf.set(entry.edgeIndex, lane)
      }
      laneCountOfGap.set(gap, Math.max(...placed.map((item) => item.lane)) + 1)
    }
  }

  // --- 行の y ------------------------------------------------------------------
  const rowCount = Math.max(...diagram.boxes.map((box) => box.row)) + 1
  const groupRows = diagram.groups.map((group) => {
    const rows = diagram.boxes.filter((box) => box.group === group.id).map((box) => box.row)
    return { id: group.id, minRow: Math.min(...rows), maxRow: Math.max(...rows) }
  })
  const topExtraOf = (row: number): number =>
    groupRows.some((group) => group.minRow === row) ? metrics.groupPadding + metrics.groupTitleHeight : 0
  const bottomExtraOf = (row: number): number =>
    groupRows.some((group) => group.maxRow === row) ? metrics.groupPadding : 0
  const channelOf = (gap: number): number =>
    metrics.channelHeight + Math.max(0, (laneCountOfGap.get(gap) ?? 1) - 1) * metrics.laneSpacing

  const rowTops: number[] = []
  {
    let y = metrics.margin + topExtraOf(0)
    for (let row = 0; row < rowCount; row += 1) {
      rowTops.push(y)
      y += metrics.boxHeight + bottomExtraOf(row) + channelOf(row) + topExtraOf(row + 1)
    }
  }
  const topOf = (box: DiagramBox): number => rowTops[box.row] ?? 0
  const laneY = (gap: number, lane: number): number =>
    (rowTops[gap] ?? 0) +
    metrics.boxHeight +
    bottomExtraOf(gap) +
    metrics.channelHeight / 2 +
    lane * metrics.laneSpacing

  // --- 箱 ----------------------------------------------------------------------
  const boxes: LaidOutBox[] = diagram.boxes.map((box) => {
    const rect = { x: leftOf(box), y: topOf(box), width: metrics.boxWidth, height: metrics.boxHeight }
    return {
      id: box.id,
      title: box.title,
      rect,
      textRect: {
        x: rect.x + metrics.boxTextInset,
        y: rect.y,
        width: rect.width - 2 * metrics.boxTextInset,
        height: rect.height,
      },
    }
  })
  const rectOfBox = new Map(boxes.map((box) => [box.id, box.rect]))

  // --- 矢印 --------------------------------------------------------------------
  const edges: LaidOutEdge[] = diagram.edges.map((edge, edgeIndex) => {
    const fromRect = rectOfBox.get(edge.from) as Rect
    const toRect = rectOfBox.get(edge.to) as Rect
    const plan = plans[edgeIndex] as Plan
    const start = { x: plan.kind === 'straight' ? plan.x : plan.fromX, y: fromRect.y + fromRect.height }
    const tip = { x: plan.kind === 'straight' ? plan.x : plan.toX, y: toRect.y }
    const points: Point[] =
      plan.kind === 'straight'
        ? [start, tip]
        : (() => {
            const y = laneY(plan.gap, laneOf.get(edgeIndex) ?? 0)
            return [start, { x: plan.fromX, y }, { x: plan.toX, y }, tip]
          })()
    const base = { x: tip.x, y: tip.y - metrics.arrowLength }
    return {
      from: edge.from,
      to: edge.to,
      points,
      shaft: [...points.slice(0, -1), base],
      head: [
        { x: tip.x - metrics.arrowHalfWidth, y: base.y },
        { x: tip.x + metrics.arrowHalfWidth, y: base.y },
        tip,
      ],
    }
  })

  const segments: Segment[] = edges.flatMap((edge, edgeIndex) =>
    edge.points.slice(1).map((point, index) => ({
      edgeIndex,
      a: edge.points[index] as Point,
      b: point,
    })),
  )
  const verticalSegments = segments.filter((segment) => Math.abs(segment.a.x - segment.b.x) < EPSILON)

  // --- 枠 ----------------------------------------------------------------------
  const groups: LaidOutGroup[] = []
  for (const group of diagram.groups) {
    const members = boxes.filter((box) => boxById.get(box.id)?.group === group.id)
    const left = Math.min(...members.map((box) => box.rect.x)) - metrics.groupPadding
    const right = Math.max(...members.map((box) => box.rect.x + box.rect.width)) + metrics.groupPadding
    const top =
      Math.min(...members.map((box) => box.rect.y)) - metrics.groupPadding - metrics.groupTitleHeight
    const bottom = Math.max(...members.map((box) => box.rect.y + box.rect.height)) + metrics.groupPadding
    const frame = { x: left, y: top, width: right - left, height: bottom - top }
    const titleX = left + metrics.groupPadding
    const titleY = top + metrics.groupPadding / 2
    const titleBottom = titleY + metrics.groupTitleHeight
    // 題の帯を縦に通る矢印のうち、いちばん左のものの手前で題を切る。
    const limit = Math.min(
      right - metrics.groupPadding,
      ...verticalSegments
        .filter((segment) => {
          const minY = Math.min(segment.a.y, segment.b.y)
          const maxY = Math.max(segment.a.y, segment.b.y)
          return segment.a.x > titleX - EPSILON && maxY > titleY && minY < titleBottom
        })
        .map((segment) => segment.a.x - metrics.clearance),
    )
    const titleWidth = limit - titleX
    if (titleWidth < metrics.groupTitleFontSize * 2) {
      return err({ code: 'no_room_for_group_title', groupId: group.id })
    }
    groups.push({
      id: group.id,
      title: group.title,
      frame,
      titleRect: { x: titleX, y: titleY, width: titleWidth, height: metrics.groupTitleHeight },
    })
  }

  // --- 検査（計画どおりに描けていることを、出来上がった座標で確かめる） ---------------
  for (let i = 0; i < groups.length; i += 1) {
    for (let j = i + 1; j < groups.length; j += 1) {
      const left = groups[i] as LaidOutGroup
      const right = groups[j] as LaidOutGroup
      if (rectsOverlap(left.frame, right.frame)) {
        return err({ code: 'overlapping_groups', groupIds: [left.id, right.id] })
      }
    }
  }
  for (const group of groups) {
    for (const box of boxes) {
      if (boxById.get(box.id)?.group === group.id) continue
      if (rectsOverlap(group.frame, box.rect)) {
        return err({ code: 'box_inside_foreign_group', boxId: box.id, groupId: group.id })
      }
    }
  }
  for (const segment of segments) {
    const edge = edges[segment.edgeIndex] as LaidOutEdge
    for (const box of boxes) {
      if (intersectsInterior(segment, box.rect)) {
        return err({ code: 'edge_crosses_box', edge: edgeName(edge), boxId: box.id })
      }
    }
    for (const group of groups) {
      if (intersectsInterior(segment, group.titleRect)) {
        return err({ code: 'edge_crosses_group_title', edge: edgeName(edge), groupId: group.id })
      }
    }
  }
  for (let i = 0; i < segments.length; i += 1) {
    for (let j = i + 1; j < segments.length; j += 1) {
      const left = segments[i] as Segment
      const right = segments[j] as Segment
      if (left.edgeIndex === right.edgeIndex) continue
      const leftEdge = edges[left.edgeIndex] as LaidOutEdge
      const rightEdge = edges[right.edgeIndex] as LaidOutEdge
      // 出口・入口の共有は木の幹として読める（同じ箱から出る、または同じ箱へ入る）。
      if (leftEdge.from === rightEdge.from || leftEdge.to === rightEdge.to) continue
      if (collinearOverlap(left, right)) {
        return err({ code: 'overlapping_edges', edges: [edgeName(leftEdge), edgeName(rightEdge)] })
      }
    }
  }

  const right = Math.max(
    ...boxes.map((box) => box.rect.x + box.rect.width),
    ...groups.map((group) => group.frame.x + group.frame.width),
  )
  const bottom = Math.max(
    ...boxes.map((box) => box.rect.y + box.rect.height),
    ...groups.map((group) => group.frame.y + group.frame.height),
  )
  return ok({
    width: right + metrics.margin,
    height: bottom + metrics.margin,
    metrics,
    groups,
    boxes,
    edges,
  })
}

/** 2 本の線分が同じ直線の上で正の長さだけ重なるか。 */
const collinearOverlap = (left: Segment, right: Segment): boolean => {
  const leftVertical = Math.abs(left.a.x - left.b.x) < EPSILON
  const rightVertical = Math.abs(right.a.x - right.b.x) < EPSILON
  if (leftVertical !== rightVertical) return false
  if (leftVertical) {
    if (Math.abs(left.a.x - right.a.x) > EPSILON) return false
    return overlapLength(left.a.y, left.b.y, right.a.y, right.b.y) > EPSILON
  }
  if (Math.abs(left.a.y - right.a.y) > EPSILON) return false
  return overlapLength(left.a.x, left.b.x, right.a.x, right.b.x) > EPSILON
}

const overlapLength = (a1: number, a2: number, b1: number, b2: number): number =>
  Math.min(Math.max(a1, a2), Math.max(b1, b2)) - Math.max(Math.min(a1, a2), Math.min(b1, b2))
