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

test('モバイルの目次には入れ子を含む全階層の見出しを出す', () => {
  const navigation = renderChapterNavigation([
    { level: 1, id: 'part', title: '部', number: '' },
    { level: 2, id: 'chapter', title: '章', number: '1' },
    { level: 3, id: 'section', title: '節', number: '1.1' },
  ])

  assert.match(navigation.desktopHtml, /data-target="chapter"/)
  assert.match(navigation.mobileHtml, /data-target="part"/)
  assert.match(navigation.mobileHtml, /data-target="chapter"/)
  assert.match(navigation.mobileHtml, /data-target="section"/)
  // 入れ子は入れ子のまま出す（最上位の横並びへ潰さない）
  assert.match(navigation.mobileHtml, /data-target="part"[^]*<ul>[^]*data-target="chapter"/)
})

test('モバイルの目次はハンバーガーで開閉する', () => {
  const navigation = renderChapterNavigation([
    { level: 1, id: 'part', title: '部', number: '' },
    { level: 2, id: 'chapter', title: '章', number: '1' },
  ])

  const controls = /<button type="button" class="chapter-navigation__toggle" aria-expanded="false" aria-controls="([^"]+)"/
    .exec(navigation.mobileHtml)
  assert.notEqual(controls, null)
  const menuId = controls?.[1] ?? ''
  assert.notEqual(menuId, '')
  // aria-controls の指す先が実在し、既定では閉じている
  assert.match(navigation.mobileHtml, new RegExp(`<div class="chapter-navigation__menu" id="${menuId}" hidden>`))
  assert.match(navigation.mobileHtml, /aria-label="目次を開く"/)
})
