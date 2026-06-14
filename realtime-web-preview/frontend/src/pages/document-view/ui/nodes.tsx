import { type Node, assertNever } from '@rwp/domain-model'
import * as katex from 'katex'
import type { ReactElement } from 'react'

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
    case 'ref':
      return (
        <a href={`#${node.target}`} className="text-sky-700 hover:underline">
          {node.label ?? node.target}
        </a>
      )
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
export const NodeList = ({ nodes }: { nodes: Node[] }): ReactElement => (
  <>
    {nodes.map((node, index) => (
      <NodeView key={index} node={node} />
    ))}
  </>
)
