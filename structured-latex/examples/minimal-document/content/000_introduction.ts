import { math, paragraph } from '../../../domain-model/index.ts'
import { defineBlocks } from '../schema.ts'

export default defineBlocks([
  {
    id: 'intro_heading',
    kind: 'heading',
    level: 1,
    labels: ['sec:introduction'],
    title: { text: 'はじめに' },
  },
  {
    id: 'intro_definition_lattice',
    kind: 'definition',
    labels: ['def:lattice'],
    title: { text: '格子' },
    habitat: 'countable',
    statement: [
      paragraph(['整数の組の集合 ', math(String.raw`\mathbb{Z}^2`), ' を格子と呼ぶ。']),
    ],
  },
])
