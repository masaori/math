import { type Node, type TitleContent, assertNever } from '@rwp/domain-model'
import * as katex from 'katex'
import type { ReactElement } from 'react'
import { useResolveLabel } from './ref-resolver'

const KatexMath = ({ tex, display }: { tex: string; display: boolean }): ReactElement => {
  // throwOnError: false → 不正な TeX でも例外を投げず、赤字で表示する（F-9: 画面を落とさない）。
  const html = katex.renderToString(tex, {
    displayMode: display,
    throwOnError: false,
    errorColor: '#cc0000',
  })
  return (
    <span
      className={display ? 'block my-2' : 'inline'}
      dangerouslySetInnerHTML={{ __html: html }}
    />
  )
}

/**
 * ref ノードを描画する。target（ラベル）を id アンカーへ解決してリンクにする。
 * 未解決（ラベル未定義）なら、描画時に検出できるよう赤字・点線下線で明示する。
 */
const RefLink = ({ target, label }: { target: string; label?: string }): ReactElement => {
  const resolveLabel = useResolveLabel()
  const anchorId = resolveLabel(target)
  const displayText = label ?? target
  if (anchorId === undefined) {
    return (
      <span
        className="text-rose-600 underline decoration-dotted"
        title={`未解決の参照: ラベル "${target}" が定義されていません`}
      >
        {displayText}
      </span>
    )
  }
  return (
    <a href={`#${anchorId}`} className="text-sky-700 hover:underline">
      {displayText}
    </a>
  )
}

/**
 * タイトル（ブロック見出し・章見出し）を描画する。
 * `text` は素のテキスト、`tex` は KaTeX（LaTeX ソースをそのまま出さない）。
 * 両方無い場合は何も描画しない。
 */
export const TitleView = ({ title }: { title: TitleContent }): ReactElement | null => {
  if (title.text !== undefined) return <>{title.text}</>
  if (title.tex !== undefined) return <KatexMath tex={title.tex} display={false} />
  return null
}

/**
 * 画像ノードを描画する。
 * 正本が持つのは資産の**名前**（assetKey）だけで、実体の所在は出力ターゲットごとの資産解決器が決める
 * （structured-latex/docs/domain-model.md §7.1）。本ビューアは資産解決器を持たないため、
 * 黙って消さずに「どの資産が置かれる場所か」を alt とともに明示する。
 */
const ImageView = ({ assetKey, alt }: { assetKey: string; alt: string }): ReactElement => (
  <span className="my-2 block rounded border border-dashed border-slate-300 bg-slate-50 px-3 py-2 text-sm text-slate-600">
    <span className="font-mono text-xs text-slate-400">image: {assetKey}</span>
    <span className="block">{alt}</span>
  </span>
)

/** Node 1件を描画する。 */
export const NodeView = ({ node }: { node: Node }): ReactElement => {
  switch (node.type) {
    case 'text':
      return <>{node.value}</>
    case 'math':
      return <KatexMath tex={node.tex} display={false} />
    case 'displayMath':
      return <KatexMath tex={node.tex} display={true} />
    case 'paragraph':
      return (
        <p className="my-2 leading-relaxed">
          <NodeList nodes={node.children} />
        </p>
      )
    case 'list':
      return (
        <ul className="my-2 list-disc space-y-1 pl-6">
          {node.items.map((item, index) => (
            <li key={index}>
              <NodeList nodes={item} />
            </li>
          ))}
        </ul>
      )
    case 'image':
      return <ImageView assetKey={node.assetKey} alt={node.alt} />
    case 'ref':
      return <RefLink target={node.target} label={node.label} />
    case 'todo':
      return (
        <span className="mx-0.5 rounded bg-amber-100 px-1.5 py-0.5 text-xs font-semibold text-amber-800">
          TODO: {node.value}
        </span>
      )
    default:
      return assertNever(node)
  }
}

/** Node 配列を順に描画する。 */
export const NodeList = ({ nodes }: { nodes: readonly Node[] }): ReactElement => (
  <>
    {nodes.map((node, index) => (
      <NodeView key={index} node={node} />
    ))}
  </>
)
