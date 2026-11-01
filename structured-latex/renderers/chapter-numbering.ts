/**
 * 章番号の振り出しを、HTML と LaTeX の出力器で同じにするための宣言と変換。
 *
 * 各論文の出力器は章を自分で数えている。振り出しの値をこの宣言 1 つから受け取ることで、
 * HTML の「節 0」と PDF の「0 章」が食い違わないようにする。
 */

import type { HeadingStartNumber } from '../domain-model/resolved/numbering.ts'

export type ChapterNumbering = {
  /** 文書で最初に現れる章の番号。0 なら第 0 章から振る。 */
  readonly firstChapterNumber: HeadingStartNumber
}

export const DEFAULT_CHAPTER_NUMBERING: ChapterNumbering = { firstChapterNumber: 1 }

/** 文書で `index` 番目（0 始まり）に現れた章の番号。 */
export const chapterNumberAt = (numbering: ChapterNumbering, index: number): number =>
  numbering.firstChapterNumber + index

/**
 * LaTeX の章のカウンタを振り出しに合わせる命令。最初の章の節コマンドより前に置く。
 * LaTeX の節コマンドはカウンタを 1 進めてから番号を組むので、振り出しより 1 小さい値を入れる。
 */
export const latexChapterCounterSetup = (numbering: ChapterNumbering, counterName: string): string =>
  `\\setcounter{${counterName}}{${numbering.firstChapterNumber - 1}}`
