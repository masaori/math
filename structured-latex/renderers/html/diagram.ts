/**
 * 静的 HTML の既定 UI: 図式ノードの描画。
 *
 * 座標は `renderers/diagram/layout.ts` が計算したものをそのまま使い、ここでは決めない
 * （LaTeX の出力器と同じ座標になる）。生成時に組み上げるので、閲覧時の JavaScript に依存しない。
 *
 * 描き方:
 *   - 枠・箱の外形・矢印は SVG で描く。`viewBox` で幅に合わせて縮むので、スマートフォン幅でも
 *     図全体が縮小されて収まる。
 *   - 箱と枠の題は、SVG の上に重ねた HTML の要素に置く（位置は図の幅に対する割合）。
 *     文字の大きさはコンテナ幅に比例させる（`cqw`）ので、図と一緒に縮む。
 *     題を SVG の `foreignObject` に入れないのは、WebKit（iOS の Safari）が `foreignObject` の中の
 *     `position: relative` の要素を正しい位置に描かない不具合を持ち、KaTeX の組版がその性質に
 *     依存しているためである。
 *
 * 題の中身（地の文・数式）を HTML にする方法は利用側が渡す（数式の組み方は出力器ごとに違うため）。
 */

import type { DiagramLabelNode } from '../../domain-model/structured-text/node.ts'
import type { DiagramLayout, Point, Rect } from '../diagram/layout.ts'

const format = (value: number): string => String(Math.round(value * 100) / 100)

const pointsOf = (points: readonly Point[]): string =>
  points.map((point) => `${format(point.x)},${format(point.y)}`).join(' ')

const percentBox = (rect: Rect, layout: DiagramLayout): string =>
  `left:${format((rect.x / layout.width) * 100)}%;` +
  `top:${format((rect.y / layout.height) * 100)}%;` +
  `width:${format((rect.width / layout.width) * 100)}%;` +
  `height:${format((rect.height / layout.height) * 100)}%`

/**
 * 図式を HTML の断片にする。
 *
 * @param renderLabel 題のノード列を HTML にする関数。返り値は HTML として安全であること。
 */
export const renderDiagramHtml = (
  layout: DiagramLayout,
  renderLabel: (title: readonly DiagramLabelNode[]) => string,
): string => {
  const { metrics } = layout
  const labelSize = format((metrics.labelFontSize / layout.width) * 100)
  const groupTitleSize = format((metrics.groupTitleFontSize / layout.width) * 100)
  const radius = format(metrics.groupPadding / 2)

  const frames = layout.groups
    .map(
      (group) =>
        `<rect class="sl-diagram__frame" x="${format(group.frame.x)}" y="${format(group.frame.y)}" ` +
        `width="${format(group.frame.width)}" height="${format(group.frame.height)}" rx="${radius}"/>`,
    )
    .join('')
  const boxes = layout.boxes
    .map(
      (box) =>
        `<rect class="sl-diagram__box" x="${format(box.rect.x)}" y="${format(box.rect.y)}" ` +
        `width="${format(box.rect.width)}" height="${format(box.rect.height)}" rx="3"/>`,
    )
    .join('')
  const edges = layout.edges
    .map(
      (edge) =>
        `<polyline class="sl-diagram__edge" points="${pointsOf(edge.shaft)}"/>` +
        `<polygon class="sl-diagram__arrow" points="${pointsOf(edge.head)}"/>`,
    )
    .join('')
  const groupTitles = layout.groups
    .map(
      (group) =>
        `<div class="sl-diagram__label sl-diagram__group-title" style="${percentBox(group.titleRect, layout)}">` +
        `<span>${renderLabel(group.title)}</span></div>`,
    )
    .join('')
  const boxTitles = layout.boxes
    .map(
      (box) =>
        `<div class="sl-diagram__label sl-diagram__box-title" style="${percentBox(box.textRect, layout)}">` +
        `<span>${renderLabel(box.title)}</span></div>`,
    )
    .join('')

  return (
    `<div class="sl-diagram" style="max-width:${format(layout.width)}px;` +
    `aspect-ratio:${format(layout.width)} / ${format(layout.height)};` +
    `--sl-diagram-label-size:${labelSize}cqw;--sl-diagram-group-title-size:${groupTitleSize}cqw">` +
    `<svg class="sl-diagram__lines" viewBox="0 0 ${format(layout.width)} ${format(layout.height)}" ` +
    `aria-hidden="true" focusable="false">${frames}${boxes}${edges}</svg>` +
    `${groupTitles}${boxTitles}</div>`
  )
}

/** 図式の既定の見た目。配色は利用側のテーマ変数があればそれを使う。 */
export const DIAGRAM_CSS = String.raw`
.sl-diagram { position:relative; width:100%; margin:8px auto; container-type:inline-size; }
.sl-diagram__lines { position:absolute; inset:0; width:100%; height:100%; overflow:visible; }
.sl-diagram__frame { fill:var(--panel,#f7f7f7); stroke:var(--muted,#888); stroke-width:1;
  stroke-dasharray:4 3; vector-effect:non-scaling-stroke; }
.sl-diagram__box { fill:var(--bg,#fff); stroke:var(--fg,#1a1a1a); stroke-width:1.1;
  vector-effect:non-scaling-stroke; }
.sl-diagram__edge { fill:none; stroke:var(--fg,#1a1a1a); stroke-width:1.1;
  vector-effect:non-scaling-stroke; }
.sl-diagram__arrow { fill:var(--fg,#1a1a1a); stroke:none; }
.sl-diagram__label { position:absolute; display:flex; align-items:center; line-height:1.3;
  overflow-wrap:anywhere; }
.sl-diagram__box-title { justify-content:center; text-align:center; text-wrap:balance;
  font-size:var(--sl-diagram-label-size); }
.sl-diagram__group-title { justify-content:flex-start; text-align:left; font-weight:700;
  color:var(--muted,#666); font-size:var(--sl-diagram-group-title-size); white-space:nowrap; }
@supports not (font-size:1cqw) {
  .sl-diagram__box-title { font-size:13px; }
  .sl-diagram__group-title { font-size:12px; }
}
`
