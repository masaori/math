import assert from 'node:assert/strict'
import { test } from 'node:test'

import { diagram, math, type DiagramNode } from '../../domain-model/structured-text/node.ts'
import { layoutDiagram, type DiagramLayout, type Point, type Rect } from './layout.ts'

/** 章の依存関係の図と同じ形（枠が縦に 4 つ、1 本だけ列 1 を下りる矢印がある）。 */
const chapters = diagram({
  groups: [
    { id: 'partition', title: ['分配関数'] },
    { id: 'eigen', title: ['固有値問題'] },
    { id: 'limits', title: ['熱力学極限'] },
    { id: 'critical', title: ['臨界点'] },
  ],
  boxes: [
    { id: 'trace', title: ['転送行列による表示'], group: 'partition', column: 0, row: 0 },
    { id: 'projection', title: ['射影'], group: 'partition', column: 0, row: 1 },
    { id: 'fourier', title: ['帰着 ', math(String.raw`A(\tilde\theta_\mu)`)], group: 'eigen', column: 0, row: 2 },
    { id: 'diagonal', title: ['対角化'], group: 'eigen', column: 0, row: 3 },
    { id: 'eigenvalues', title: ['固有値'], group: 'eigen', column: 0, row: 4 },
    { id: 'eigenvector', title: ['固有ベクトル'], group: 'eigen', column: 0, row: 5 },
    { id: 'rowLimit', title: ['N の極限'], group: 'limits', column: 1, row: 6 },
    { id: 'columnLimit', title: ['M の極限'], group: 'limits', column: 0, row: 7 },
    { id: 'criticalPoint', title: ['臨界点'], group: 'critical', column: 0, row: 8 },
  ],
  edges: [
    { from: 'trace', to: 'projection' },
    { from: 'projection', to: 'fourier' },
    { from: 'fourier', to: 'diagonal' },
    { from: 'diagonal', to: 'eigenvalues' },
    { from: 'eigenvalues', to: 'eigenvector' },
    { from: 'eigenvector', to: 'columnLimit' },
    { from: 'projection', to: 'rowLimit' },
    { from: 'rowLimit', to: 'columnLimit' },
    { from: 'columnLimit', to: 'criticalPoint' },
  ],
})

const laidOut = (node: DiagramNode): DiagramLayout => {
  const result = layoutDiagram(node)
  if (!result.success) assert.fail(JSON.stringify(result.error))
  return result.data
}

const segmentsOf = (layout: DiagramLayout) =>
  layout.edges.flatMap((edge) =>
    edge.points.slice(1).map((b, index) => ({ edge, a: edge.points[index] as Point, b })),
  )

const inside = (rect: Rect, point: Point): boolean =>
  point.x >= rect.x && point.x <= rect.x + rect.width && point.y >= rect.y && point.y <= rect.y + rect.height

test('矢印は直交折れ線で、元の箱の下辺から出て先の箱の上辺へ入る', () => {
  const layout = laidOut(chapters)
  const rectOf = new Map(layout.boxes.map((box) => [box.id, box.rect]))
  for (const edge of layout.edges) {
    const first = edge.points[0] as Point
    const last = edge.points.at(-1) as Point
    const from = rectOf.get(edge.from) as Rect
    const to = rectOf.get(edge.to) as Rect
    assert.equal(first.y, from.y + from.height, `${edge.from} の下辺から出る`)
    assert.equal(last.y, to.y, `${edge.to} の上辺へ入る`)
    edge.points.slice(1).forEach((point, index) => {
      const previous = edge.points[index] as Point
      assert.ok(point.x === previous.x || point.y === previous.y, '各線分は水平か垂直')
    })
    // 最後の線分は下向き（矢じりが上から箱へ刺さる）。
    assert.equal((edge.points.at(-2) as Point).x, last.x)
  }
})

test('出口・入口を共有する矢印を除いて、矢印どうしは交差しない（ねじれが無い）', () => {
  const layout = laidOut(chapters)
  const segments = segmentsOf(layout)
  let crossings = 0
  for (const left of segments) {
    for (const right of segments) {
      if (left.edge === right.edge) continue
      if (left.edge.from === right.edge.from || left.edge.to === right.edge.to) continue
      const vertical = left.a.x === left.b.x ? left : right
      const horizontal = left.a.x === left.b.x ? right : left
      if (vertical.a.x !== vertical.b.x || horizontal.a.y !== horizontal.b.y) continue
      const x = vertical.a.x
      const y = horizontal.a.y
      const strictlyBetween = (value: number, p: number, q: number): boolean =>
        value > Math.min(p, q) && value < Math.max(p, q)
      if (strictlyBetween(x, horizontal.a.x, horizontal.b.x) && strictlyBetween(y, vertical.a.y, vertical.b.y)) {
        crossings += 1
      }
    }
  }
  assert.equal(crossings, 0)
})

test('別の列の箱へ向かう矢印は、元の箱の真下の通り道で曲がり、途中の箱を避けて下りる', () => {
  const layout = laidOut(chapters)
  const edge = layout.edges.find((candidate) => candidate.from === 'projection' && candidate.to === 'rowLimit')
  assert.ok(edge !== undefined)
  assert.equal(edge.points.length, 4)
  const projection = layout.boxes.find((box) => box.id === 'projection')?.rect as Rect
  const fourier = layout.boxes.find((box) => box.id === 'fourier')?.rect as Rect
  const turnY = (edge.points[1] as Point).y
  assert.ok(turnY > projection.y + projection.height && turnY < fourier.y, '射影と帰着の間で曲がる')
  const descentX = (edge.points[2] as Point).x
  for (const box of layout.boxes.filter((candidate) => ['fourier', 'diagonal', 'eigenvalues', 'eigenvector'].includes(candidate.id))) {
    assert.ok(descentX > box.rect.x + box.rect.width, `${box.id} の右を下りる`)
  }
})

test('矢印は箱の内部にも枠の題にも入らない', () => {
  const layout = laidOut(chapters)
  for (const { a, b } of segmentsOf(layout)) {
    const middle = { x: (a.x + b.x) / 2, y: (a.y + b.y) / 2 }
    for (const box of layout.boxes) {
      const interior = { x: box.rect.x + 0.5, y: box.rect.y + 0.5, width: box.rect.width - 1, height: box.rect.height - 1 }
      assert.ok(!inside(interior, middle))
    }
    for (const group of layout.groups) assert.ok(!inside(group.titleRect, middle))
  }
})

test('枠の題は、題の帯を通る矢印の手前で幅を切られる', () => {
  const layout = laidOut(chapters)
  const eigen = layout.groups.find((group) => group.id === 'eigen')
  const partition = layout.groups.find((group) => group.id === 'partition')
  assert.ok(eigen !== undefined && partition !== undefined)
  const fourier = layout.boxes.find((box) => box.id === 'fourier')?.rect as Rect
  // 射影 → 帰着の矢印が箱の中央を通るので、題はその手前で終わる。
  assert.ok(eigen.titleRect.x + eigen.titleRect.width < fourier.x + fourier.width / 2)
  // 最初の枠の題の帯には矢印が通らないので、枠の幅いっぱいまで使える。
  assert.ok(partition.titleRect.width > eigen.titleRect.width)
})

test('枠は所属する箱だけを囲み、枠どうしは重ならない', () => {
  const layout = laidOut(chapters)
  const limits = layout.groups.find((group) => group.id === 'limits')?.frame as Rect
  for (const id of ['rowLimit', 'columnLimit']) {
    const rect = layout.boxes.find((box) => box.id === id)?.rect as Rect
    assert.ok(inside(limits, { x: rect.x, y: rect.y }) && inside(limits, { x: rect.x + rect.width, y: rect.y + rect.height }))
  }
})

test('途中の箱に当たらずに引けない矢印は誤りにする（黙って箱を突き抜けない）', () => {
  const result = layoutDiagram(
    diagram({
      groups: [],
      boxes: [
        { id: 'a', title: ['a'], column: 0, row: 0 },
        { id: 'b', title: ['b'], column: 0, row: 1 },
        { id: 'c', title: ['c'], column: 1, row: 1 },
        { id: 'd', title: ['d'], column: 1, row: 2 },
      ],
      edges: [{ from: 'a', to: 'd' }],
    }),
  )
  assert.equal(result.success, false)
  assert.equal(result.success === false && result.error.code, 'unroutable_edge')
})

test('所属しない枠の中に入る箱は誤りにする', () => {
  const result = layoutDiagram(
    diagram({
      groups: [{ id: 'g', title: ['枠'] }],
      boxes: [
        { id: 'a', title: ['a'], group: 'g', column: 0, row: 0 },
        { id: 'b', title: ['b'], column: 0, row: 1 },
        { id: 'c', title: ['c'], group: 'g', column: 0, row: 2 },
      ],
      edges: [],
    }),
  )
  assert.equal(result.success === false && result.error.code, 'box_inside_foreign_group')
})

test('整合しない図式（未宣言の箱への矢印）は、座標を計算せずに誤りにする', () => {
  const broken: DiagramNode = {
    type: 'diagram',
    groups: [],
    boxes: [{ id: 'a', title: [{ type: 'text', value: 'a' }], column: 0, row: 0 }],
    edges: [{ from: 'a', to: 'missing' }],
  }
  const result = layoutDiagram(broken)
  assert.equal(result.success === false && result.error.code, 'invalid_diagram')
})

test('同じ行の間で横線が重なる 2 本の矢印は、別々の通り道に分ける', () => {
  const layout = laidOut(
    diagram({
      groups: [],
      boxes: [
        { id: 'a', title: ['a'], column: 0, row: 0 },
        { id: 'b', title: ['b'], column: 1, row: 0 },
        { id: 'c', title: ['c'], column: 2, row: 1 },
        { id: 'd', title: ['d'], column: 3, row: 1 },
      ],
      edges: [
        { from: 'a', to: 'c' },
        { from: 'b', to: 'd' },
      ],
    }),
  )
  const [first, second] = layout.edges
  assert.ok(first !== undefined && second !== undefined)
  assert.notEqual((first.points[1] as Point).y, (second.points[1] as Point).y)
  // b → d を上の通り道にすると交差が無くなる（a → c を上にすると 2 回交差する）。
  assert.ok((second.points[1] as Point).y < (first.points[1] as Point).y)
})
