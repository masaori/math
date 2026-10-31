import assert from 'node:assert/strict'
import { test } from 'node:test'

import { diagram, math } from '../../domain-model/structured-text/node.ts'
import { layoutDiagram, type DiagramLayout } from '../diagram/layout.ts'
import { renderDiagramHtml } from './diagram.ts'

const layout = ((): DiagramLayout => {
  const result = layoutDiagram(
    diagram({
      groups: [{ id: 'g', title: ['部'] }],
      boxes: [
        { id: 'a', title: ['章 ', math('V^{(+)}')], group: 'g', column: 0, row: 0 },
        { id: 'b', title: ['次の章'], group: 'g', column: 0, row: 1 },
      ],
      edges: [{ from: 'a', to: 'b' }],
    }),
  )
  if (!result.success) assert.fail(JSON.stringify(result.error))
  return result.data
})()

const renderLabel = (title: Parameters<Parameters<typeof renderDiagramHtml>[1]>[0]): string =>
  title.map((part) => (part.type === 'text' ? part.value : `<span class="math" data-tex="${part.tex}"></span>`)).join('')

test('線は viewBox つきの SVG に描き、幅に合わせて縮む', () => {
  const html = renderDiagramHtml(layout, renderLabel)
  assert.match(html, new RegExp(`viewBox="0 0 ${layout.width} ${layout.height}"`))
  assert.match(html, new RegExp(`max-width:${layout.width}px`))
  assert.match(html, /aspect-ratio:/)
  // 枠 1・箱 2・矢印 1（線と矢じり）。
  assert.equal(html.match(/class="sl-diagram__frame"/g)?.length, 1)
  assert.equal(html.match(/class="sl-diagram__box"/g)?.length, 2)
  assert.equal(html.match(/<polyline class="sl-diagram__edge"/g)?.length, 1)
  assert.equal(html.match(/<polygon class="sl-diagram__arrow"/g)?.length, 1)
})

test('題は SVG の外の HTML に置き、数式は利用側の描き方で埋める（foreignObject を使わない）', () => {
  const html = renderDiagramHtml(layout, renderLabel)
  assert.doesNotMatch(html, /foreignObject/)
  assert.match(html, /<div class="sl-diagram__label sl-diagram__box-title" style="left:[0-9.]+%;top:[0-9.]+%;width:[0-9.]+%;height:[0-9.]+%">/)
  assert.match(html, /data-tex="V\^\{\(\+\)\}"/)
  assert.match(html, /sl-diagram__group-title[^>]*><span>部<\/span>/)
})

test('閲覧時のスクリプトに依存しない（座標は生成時に確定している）', () => {
  assert.doesNotMatch(renderDiagramHtml(layout, renderLabel), /<script/)
})
