import type { HeadingBlock } from '@rwp/domain-model'
import type { ReactElement } from 'react'
import { TitleView } from './nodes'

/**
 * level ごとの体裁。ページの `<h1>` はアプリ名が占めるため、文書の見出しは
 * level 1 → `<h2>`、level 2 以下 → `<h3>` として出力する。
 * 未知の level（3 以上）は最小体裁にフォールバックする。
 */
const levelStyles: Record<number, string> = {
  1: 'mt-10 border-b-2 border-slate-300 pb-1 text-2xl font-bold text-slate-900',
  2: 'mt-8 border-b border-slate-200 pb-1 text-xl font-bold text-slate-800',
}

const fallbackStyle = 'mt-6 text-lg font-semibold text-slate-800'

/** 章見出し1件を描画する。 */
export const HeadingView = ({ heading }: { heading: HeadingBlock }): ReactElement => {
  const className = `scroll-mt-16 first:mt-0 ${levelStyles[heading.level] ?? fallbackStyle}`
  const content = <TitleView title={heading.title} />
  return heading.level === 1 ? (
    <h2 id={heading.id} className={className}>
      {content}
    </h2>
  ) : (
    <h3 id={heading.id} className={className}>
      {content}
    </h3>
  )
}
