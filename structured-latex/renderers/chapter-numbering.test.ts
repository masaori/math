import assert from 'node:assert/strict'
import { test } from 'node:test'

import {
  DEFAULT_CHAPTER_NUMBERING,
  chapterNumberAt,
  latexChapterCounterSetup,
  type ChapterNumbering,
} from './chapter-numbering.ts'

const fromZero: ChapterNumbering = { firstChapterNumber: 0 }

test('章番号: 既定では最初の章が 1 になる', () => {
  assert.deepEqual([0, 1, 2].map((index) => chapterNumberAt(DEFAULT_CHAPTER_NUMBERING, index)), [1, 2, 3])
})

test('章番号: 振り出しを 0 にすると最初の章が 0 になる', () => {
  assert.deepEqual([0, 1, 2].map((index) => chapterNumberAt(fromZero, index)), [0, 1, 2])
})

test('章番号: LaTeX のカウンタは振り出しより 1 小さい値から始める', () => {
  assert.equal(latexChapterCounterSetup(fromZero, 'section'), '\\setcounter{section}{-1}')
  assert.equal(latexChapterCounterSetup(DEFAULT_CHAPTER_NUMBERING, 'chapter'), '\\setcounter{chapter}{0}')
})
