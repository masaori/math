/**
 * LaTeX 出力: 図式ノードを TikZ の絵にする。
 *
 * 座標は `renderers/diagram/layout.ts` が計算したものをそのまま使う（HTML の出力器と同じ座標）。
 * 抽象単位を pt へ写す倍率だけをここで決める。版面に収まるように縮めるとき、
 * 文字の大きさも同じ倍率で縮める（HTML で図と文字が一緒に縮むのと同じ見え方になる）。
 *
 * 箱の題は、折り返す行の長さを揃える（`DIAGRAM_TIKZ_PREAMBLE` の `\sldiagramlabel`）。
 * 和文はどの字の間でも折り返せるので、幅いっぱいまで詰めると最後の行に 1〜2 字だけ残ることがある。
 * HTML 側の `text-wrap: balance` と同じ見え方にするためである。
 * 行揃えは無限に伸びる余白（`\centering`・`flush left`）にする。TikZ の `center` は
 * 有限の伸びで行を均すので、和文の字間（xeCJK の伸びる空き）まで広がって字が散らばる。
 *
 * 使う側のプリアンブルに `\usepackage{tikz}` と `DIAGRAM_TIKZ_PREAMBLE` が要る。TikZ のライブラリは使わない
 * （矢じりも幾何が計算した三角形を塗るだけにして、描き方の違いを持ち込まない）。
 *
 * 題の中身（地の文・数式）を LaTeX にする方法は利用側が渡す（地の文の逃がし方はプロジェクトが持つ）。
 */

import type { DiagramLabelNode } from '../../domain-model/structured-text/node.ts'
import type { DiagramLayout, Point } from '../diagram/layout.ts'

/**
 * プリアンブルに置く定義。`\sldiagramlabel{行の幅の上限}{題}` は、題が 1 行に収まればそのまま、
 * 収まらなければ「必要な行数で割った長さ + 1 字分」を行の幅にして中央揃えで折り返す。
 */
export const DIAGRAM_TIKZ_PREAMBLE = String.raw`\newlength{\sldiagramnatural}
\newlength{\sldiagrammax}
\newlength{\sldiagramtarget}
\newcommand{\sldiagramlabel}[2]{%
  \setlength{\sldiagrammax}{#1}%
  \settowidth{\sldiagramnatural}{#2}%
  \ifdim\sldiagramnatural>\sldiagrammax
    % 行数 = 切り上げ(自然な幅 / 上限)。\numexpr の割り算は四捨五入なので (2a+b-2)/(2b) で切り上げる。
    \setlength{\sldiagramtarget}{\dimexpr\sldiagramnatural/\numexpr(2*\sldiagramnatural+\sldiagrammax-2)/(2*\sldiagrammax)\relax+1em\relax}%
    \ifdim\sldiagramtarget>\sldiagrammax\setlength{\sldiagramtarget}{\sldiagrammax}\fi
  \else
    \setlength{\sldiagramtarget}{\sldiagramnatural}%
  \fi
  \parbox{\sldiagramtarget}{\centering #2}%
}`

const format = (value: number): string => String(Math.round(value * 100) / 100)

const coordinate = (point: Point): string => `(${format(point.x)},${format(point.y)})`

/**
 * 図式を `tikzpicture` 環境の文字列にする。
 *
 * @param renderLabel 題のノード列を LaTeX にする関数。
 * @param options.maxWidthPt 絵の幅の上限（pt）。
 * @param options.maxHeightPt 絵の高さの上限（pt）。抽象単位 1 を 1pt とし、幅か高さが上限を超えるときだけ縮める。
 */
export const renderDiagramTikz = (
  layout: DiagramLayout,
  renderLabel: (title: readonly DiagramLabelNode[]) => string,
  options: { maxWidthPt: number; maxHeightPt: number },
): string => {
  const { metrics } = layout
  const unit = Math.min(1, options.maxWidthPt / layout.width, options.maxHeightPt / layout.height)
  const pt = (value: number): string => `${format(value * unit)}pt`
  const fontOf = (size: number): string =>
    `\\fontsize{${format(size * unit)}}{${format(size * unit * 1.3)}}\\selectfont`

  const lines: string[] = [
    `\\begin{tikzpicture}[x=${format(unit)}pt,y=-${format(unit)}pt,line width=0.6pt]`,
  ]
  for (const group of layout.groups) {
    const { frame, titleRect } = group
    lines.push(
      `\\filldraw[draw=black!45,fill=black!4,dashed,rounded corners=${pt(metrics.groupPadding / 2)}] ` +
        `${coordinate(frame)} rectangle ${coordinate({ x: frame.x + frame.width, y: frame.y + frame.height })};`,
      `\\node[anchor=west,inner sep=0pt,text width=${pt(titleRect.width)},align=flush left,` +
        `font=${fontOf(metrics.groupTitleFontSize)}\\bfseries,text=black!65] ` +
        `at ${coordinate({ x: titleRect.x, y: titleRect.y + titleRect.height / 2 })} {${renderLabel(group.title)}};`,
    )
  }
  for (const box of layout.boxes) {
    const { rect, textRect } = box
    lines.push(
      `\\filldraw[fill=white,rounded corners=${pt(3)}] ${coordinate(rect)} rectangle ` +
        `${coordinate({ x: rect.x + rect.width, y: rect.y + rect.height })};`,
      `\\node[anchor=center,inner sep=0pt,font=${fontOf(metrics.labelFontSize)}] ` +
        `at ${coordinate({ x: textRect.x + textRect.width / 2, y: textRect.y + textRect.height / 2 })} ` +
        `{\\sldiagramlabel{${pt(textRect.width)}}{${renderLabel(box.title)}}};`,
    )
  }
  for (const edge of layout.edges) {
    lines.push(
      `\\draw ${edge.shaft.map(coordinate).join(' -- ')};`,
      `\\fill ${edge.head.map(coordinate).join(' -- ')} -- cycle;`,
    )
  }
  lines.push('\\end{tikzpicture}')
  return lines.join('\n')
}
