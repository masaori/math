/**
 * 静的 HTML の既定 UI: 主張の**身分**（主定理 / サブ定理）の見せ方。
 *
 * 身分そのものは入力言語の意味（`domain-model/structured-text/block.ts` の `TheoremStanding`）で
 * あり、ここが決めるのは体裁だけである（docs/domain-model.md §7.1 の分離）。
 *
 *   - 節の冒頭に、その節の主定理を列挙する（読む前に到達点が分かるようにする）
 *   - 主定理のブロックは通常表示のまま
 *   - サブ定理のブロックは題名だけを見せ、既定で閉じておく
 *
 * **JavaScript に依存させない。** 折りたたみは `<details>` / `<summary>` で成立させる。
 * 生成物はオフラインで開いても、スクリプトが動かない環境でも読める（開く操作もできる）。
 */

import { STANDING_BEARING_KINDS } from '../../domain-model/structured-text/block.ts'

/** 節の冒頭に並べる主定理 1 件。`text` は既に HTML として安全な文字列であること。 */
export type MainTheoremEntry = {
  /** 飛び先の id（`#` を含まない）。 */
  anchor: string
  /** 表示文字列（「定理 3.4（分配多項式は転送行列の冪のトレースである）」など）。 */
  text: string
}

/**
 * 節の冒頭に置く主定理の一覧。**1 件も無ければ何も出さない**
 * （空の見出しだけが並ぶと、主定理を選んでいない節が「主定理が無い節」に見えてしまう）。
 */
export const renderMainTheoremLead = (entries: readonly MainTheoremEntry[]): string => {
  if (entries.length === 0) return ''
  const items = entries
    .map((entry) => `<li><a href="#${entry.anchor}">${entry.text}</a></li>`)
    .join('')
  return (
    `<nav class="main-theorem-lead" aria-label="この節の主定理">` +
    `<div class="main-theorem-lead__title">この節の主定理</div><ul>${items}</ul></nav>`
  )
}

/**
 * 身分に応じたブロックの器。
 *
 * 主定理 … 見出しと本文をそのまま並べる（従来の表示と同じ）。
 * サブ定理 … `<details>` で包み、`<summary>` に見出しだけを出して既定で閉じる。
 *
 * **折りたたむのは主張型（定理・主張）だけである。** 定義・注意・ノートは身分を持たないので
 * 常に開いたまま出す。定義が閉じていると、開いている主張を読む側が意味を取れなくなる。
 */
export const renderStandingAwareBlock = (block: {
  standing: 'mainTheorem' | 'subTheorem'
  /** ブロックの id 属性（`#` を含まない）。 */
  elementId: string
  /** ブロックの種別。クラス名になり、折りたたむかどうかの判定にも使う。 */
  kind: string
  /** 見出し行の HTML（「定理 3.4（題名）」）。 */
  headHtml: string
  /** 主張と証明の HTML。 */
  bodyHtml: string
}): string => {
  const folds =
    block.standing !== 'mainTheorem' &&
    (STANDING_BEARING_KINDS as readonly string[]).includes(block.kind)
  const modifier =
    block.standing === 'mainTheorem' ? ' block--main' : folds ? ' block--sub' : ''
  const classes = `block ${block.kind}${modifier}`
  const open = `<section class="${classes}" id="${block.elementId}">`
  if (!folds) {
    return `${open}<div class="head">${block.headHtml}</div>${block.bodyHtml}</section>`
  }
  return (
    `${open}<details class="fold"><summary class="head">${block.headHtml}</summary>` +
    `<div class="fold__body">${block.bodyHtml}</div></details></section>`
  )
}

export const THEOREM_STANDING_CSS = String.raw`
.main-theorem-lead { margin:18px 0 26px; padding:14px 18px; border:1px solid var(--line);
  border-radius:8px; background:var(--panel); }
.main-theorem-lead__title { font-size:.78rem; font-weight:700; letter-spacing:.1em;
  color:var(--muted); margin-bottom:6px; }
.main-theorem-lead ul { margin:0; padding-left:1.2em; }
.main-theorem-lead li { margin:.2em 0; line-height:1.6; }
.block--sub > .fold > summary { cursor:pointer; color:var(--muted); }
.block--sub > .fold > summary:hover { color:var(--fg); }
.block--sub > .fold[open] > summary { color:var(--fg); }
.block--sub > .fold > .fold__body { margin-top:2px; }
`
