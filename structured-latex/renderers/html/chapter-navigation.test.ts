import assert from 'node:assert/strict'
import test from 'node:test'

import { buildChapterTree, renderChapterNavigation } from './chapter-navigation.ts'

test('見出しレベルから章の吊り構造を作る', () => {
  const tree = buildChapterTree([
    { level: 1, id: 'part', title: '部', number: '' },
    { level: 2, id: 'chapter', title: '章', number: '1' },
    { level: 3, id: 'section', title: '節', number: '' },
    { level: 2, id: 'next', title: '次章', number: '2' },
  ])

  assert.equal(tree.length, 1)
  assert.equal(tree[0]?.id, 'part')
  assert.deepEqual(tree[0]?.children.map((node) => node.id), ['chapter', 'next'])
  assert.equal(tree[0]?.children[0]?.children[0]?.id, 'section')
})

test('親見出しより前にある章は最上位として残す', () => {
  const tree = buildChapterTree([
    { level: 2, id: 'preface', title: '前置き', number: '1' },
    { level: 1, id: 'part', title: '本編', number: '' },
    { level: 2, id: 'chapter', title: '章', number: '2' },
  ])

  assert.deepEqual(tree.map((node) => node.id), ['preface', 'part'])
  assert.equal(tree[1]?.children[0]?.id, 'chapter')
})

test('モバイルのタブには最上位の章だけを出す', () => {
  const navigation = renderChapterNavigation([
    { level: 1, id: 'part', title: '部', number: '' },
    { level: 2, id: 'chapter', title: '章', number: '1' },
  ])

  assert.match(navigation.desktopHtml, /data-target="chapter"/)
  assert.match(navigation.mobileHtml, /data-target="part"/)
  assert.doesNotMatch(navigation.mobileHtml, /data-target="chapter"/)
})
