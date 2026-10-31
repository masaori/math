import assert from 'node:assert/strict'
import { test } from 'node:test'

import { diagram, math } from '../../domain-model/structured-text/node.ts'
import { layoutDiagram, type DiagramLayout } from '../diagram/layout.ts'
import { DIAGRAM_TIKZ_PREAMBLE, renderDiagramTikz } from './diagram.ts'

const layout = ((): DiagramLayout => {
  const result = layoutDiagram(
    diagram({
      groups: [{ id: 'g', title: ['部'] }],
      boxes: [
        { id: 'a', title: ['章 ', math('V^{(+)}')], group: 'g', column: 0, row: 0 },
        { id: 'b', title: ['次の章'], group: 'g', column: 1, row: 1 },
      ],
      edges: [{ from: 'a', to: 'b' }],
    }),
  )
  if (!result.success) assert.fail(JSON.stringify(result.error))
  return result.data
})()

const renderLabel = (title: Parameters<Parameters<typeof renderDiagramTikz>[1]>[0]): string =>
  title.map((part) => (part.type === 'text' ? part.value : `$${part.tex}$`)).join('')

test('HTML と同じ座標を、y 軸を下向きにした TikZ の座標としてそのまま使う', () => {
  const tikz = renderDiagramTikz(layout, renderLabel, { maxWidthPt: 10_000, maxHeightPt: 10_000 })
  assert.match(tikz, /^\\begin\{tikzpicture\}\[x=1pt,y=-1pt/)
  const edge = layout.edges[0]
  assert.ok(edge !== undefined)
  const shaft = edge.shaft.map((point) => `(${point.x},${point.y})`).join(' -- ')
  assert.ok(tikz.includes(`\\draw ${shaft};`))
  assert.match(tikz, /\$V\^\{\(\+\)\}\$/)
  assert.match(tikz, /\\end\{tikzpicture\}$/)
})

test('版面より広いときは、座標と文字の大きさを同じ倍率で縮める', () => {
  const maxWidthPt = layout.width / 2
  const tikz = renderDiagramTikz(layout, renderLabel, { maxWidthPt, maxHeightPt: 10_000 })
  assert.match(tikz, /\[x=0\.5pt,y=-0\.5pt/)
  const size = layout.metrics.labelFontSize / 2
  assert.ok(tikz.includes(`\\fontsize{${size}}`))
})

test('版面より高いときも、高さに合わせて同じ倍率で縮める', () => {
  const tikz = renderDiagramTikz(layout, renderLabel, { maxWidthPt: 10_000, maxHeightPt: layout.height / 4 })
  assert.match(tikz, /\[x=0\.25pt,y=-0\.25pt/)
})

test('箱の題は行の長さを揃える定義を通し、和文の字間が散らばる行揃え（center）を使わない', () => {
  const tikz = renderDiagramTikz(layout, renderLabel, { maxWidthPt: 10_000, maxHeightPt: 10_000 })
  const box = layout.boxes[0]
  assert.ok(box !== undefined)
  assert.ok(tikz.includes(`{\\sldiagramlabel{${box.textRect.width}pt}{章 $V^{(+)}$}}`))
  assert.doesNotMatch(tikz, /align=center/)
  assert.match(DIAGRAM_TIKZ_PREAMBLE, /\\newcommand\{\\sldiagramlabel\}\[2\]/)
})

test('ライブラリに依存しない（矢じりは計算済みの三角形を塗る）', () => {
  const tikz = renderDiagramTikz(layout, renderLabel, { maxWidthPt: 400, maxHeightPt: 400 })
  assert.doesNotMatch(tikz, /->|-Stealth|-latex/)
  assert.match(tikz, /\\fill \([^)]*\) -- \([^)]*\) -- \([^)]*\) -- cycle;/)
})
