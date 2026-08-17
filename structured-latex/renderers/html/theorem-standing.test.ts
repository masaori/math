import assert from 'node:assert/strict'
import { test } from 'node:test'

import { renderMainTheoremLead, renderStandingAwareBlock } from './theorem-standing.ts'

test('主定理が無い節では冒頭の一覧を出さない', () => {
  assert.equal(renderMainTheoremLead([]), '')
})

test('節の冒頭の一覧は主定理へのリンクを並べる', () => {
  const html = renderMainTheoremLead([{ anchor: 'blk-thm', text: '定理 3.4（到達点）' }])
  assert.match(html, /この節の主定理/)
  assert.match(html, /href="#blk-thm"/)
  assert.match(html, /定理 3\.4（到達点）/)
})

test('主定理のブロックは折りたたまない', () => {
  const html = renderStandingAwareBlock({
    standing: 'mainTheorem',
    elementId: 'blk-a',
    kind:'theorem',
    headHtml: '定理 3.4',
    bodyHtml: '<div class="statement">本文</div>',
  })
  assert.doesNotMatch(html, /<details/)
  assert.match(html, /class="block theorem block--main"/)
  assert.match(html, /<div class="head">定理 3\.4<\/div>/)
})

test('定義・注意は身分を持たないので折りたたまない', () => {
  const html = renderStandingAwareBlock({
    standing: 'subTheorem',
    elementId: 'blk-c',
    kind: 'definition',
    headHtml: '定義 3.6',
    bodyHtml: '<div class="statement">本文</div>',
  })
  assert.doesNotMatch(html, /<details/)
  assert.match(html, /class="block definition"/)
})

test('サブ定理のブロックは題名だけを見せ、既定で閉じる（JavaScript に依存しない）', () => {
  const html = renderStandingAwareBlock({
    standing: 'subTheorem',
    elementId: 'blk-b',
    kind:'claim',
    headHtml: '主張 3.5',
    bodyHtml: '<div class="statement">本文</div>',
  })
  assert.match(html, /<details class="fold"><summary class="head">主張 3\.5<\/summary>/)
  // `open` 属性が無いことが「既定で閉じている」ことの担保。
  assert.doesNotMatch(html, /<details[^>]*\sopen/)
  assert.match(html, /本文/)
  assert.doesNotMatch(html, /<script/)
})
