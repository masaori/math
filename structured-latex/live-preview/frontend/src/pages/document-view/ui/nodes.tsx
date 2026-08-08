import {
  type ResolvedNode,
  type ResolvedRef,
  type TitleContent,
  type UnresolvedRef,
  assertNever,
} from '@structured-latex/system/domain-model'
import * as katex from 'katex'
import type { ReactElement } from 'react'
import { BLOCK_KIND_LABELS } from './kind-labels'

const KatexMath = ({ tex, display }: { tex: string; display: boolean }): ReactElement => {
  // throwOnError: false → 不正な TeX でも例外を投げず、赤字で表示する（F-9: 画面を落とさない）。
  const html = katex.renderToString(tex, {
    displayMode: display,
    throwOnError: false,
    errorColor: '#cc0000',
    // `\blkref{<ラベル>}` は数式の中からブロックを引くための命令で、出版物では `\cref` へ
    // 展開されて番号（「定義 1.3」など）になる。KaTeX は `\cref` を知らないので、
    // プレビューではラベル名をそのまま見せる（未定義命令として赤字になるのを避ける）。
    macros: { '\\blkref': '\\text{[#1]}' },
  })
  return (
    <span
      className={display ? 'block my-2' : 'inline'}
      dangerouslySetInnerHTML={{ __html: html }}
    />
  )
}

/**
 * 解決済みの相互参照を描画する。宛先のアンカーと番号は解決の時点で確定している
 * （ここでラベルを引き直さない。解決はシステムの `resolveTolerantly` が 1 か所で行う）。
 *
 * 表示テキストは、正本が上書きしていればそれを、していなければ「種別 + 番号」を使う。
 * 番号が無い（番号を振らない見出しを指した）場合はタイトルへ落とす（省略はしない）。
 */
const RefLink = ({ node }: { node: ResolvedRef }): ReactElement => {
  const numbered =
    node.targetNumber === null
      ? null
      : `${BLOCK_KIND_LABELS[node.targetKind]} ${node.targetNumber.display}`
  const titled = node.targetTitle?.text ?? node.targetTitle?.tex ?? null
  const displayText = node.overrideText ?? numbered ?? titled ?? node.targetBlockId
  return (
    <a href={`#${node.anchor}`} className="text-sky-700 hover:underline">
      {displayText}
    </a>
  )
}

/**
 * 宛先のラベルが存在しなかった相互参照。
 * 黙って消さず、描画時に気付けるよう赤字・点線下線で明示する（F-9）。
 */
const UnresolvedRefMark = ({ node }: { node: UnresolvedRef }): ReactElement => (
  <span
    className="text-rose-600 underline decoration-dotted"
    title={`未解決の参照: ラベル "${node.target}" が定義されていません`}
  >
    {node.overrideText ?? node.target}
  </span>
)

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

/**
 * 引用ノードを描画する。
 * 宛先は文書の**外**（BibTeX のキー）で、本ビューアは `.bib` を読まない。
 * 番号へ解決できないので、黙って消さずにキーそのものを角括弧で見せる（未解決であることが分かる形）。
 */
const CiteView = ({ keys, note }: { keys: readonly string[]; note?: string }): ReactElement => (
  <span
    className="text-slate-700"
    title={`文献引用（BibTeX キー）: ${keys.join(', ')}${note === undefined ? '' : ` — ${note}`}`}
  >
    [{keys.join(', ')}
    {note === undefined ? '' : `, ${note}`}]
  </span>
)

/** 解決済みノード 1 件を描画する。 */
export const NodeView = ({ node }: { node: ResolvedNode }): ReactElement => {
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
      return <RefLink node={node} />
    case 'unresolvedRef':
      return <UnresolvedRefMark node={node} />
    case 'cite':
      return <CiteView keys={node.keys} note={node.note} />
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

/** 解決済みノード配列を順に描画する。 */
export const NodeList = ({ nodes }: { nodes: readonly ResolvedNode[] }): ReactElement => (
  <>
    {nodes.map((node, index) => (
      <NodeView key={index} node={node} />
    ))}
  </>
)
