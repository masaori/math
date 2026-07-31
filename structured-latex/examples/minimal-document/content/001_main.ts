import { image, math, paragraph, todo } from '../../../domain-model/index.ts'
import { defineBlocks, ref } from '../schema.ts'

export default defineBlocks([
  {
    id: 'main_heading',
    kind: 'heading',
    level: 1,
    labels: ['sec:main'],
    title: { text: '主結果' },
  },
  {
    id: 'main_theorem_limit',
    kind: 'theorem',
    labels: ['thm:limit'],
    title: { text: '極限の存在' },
    // 非可算側を宣言したので、脱出箇所の記述が型で必須になる。
    habitat: 'uncountable',
    realEscape: '自由エネルギーの極限を取る箇所で ℝ を使う',
    statement: [
      paragraph([
        ref('def:lattice'),
        ' の上で定義した量の極限 ',
        math(String.raw`\lim_{n \to \infty} f_n`),
        ' が存在する。',
      ]),
    ],
    proof: [paragraph([todo('証明は M3 で書く')])],
  },
  {
    id: 'main_figure_lattice',
    kind: 'figure',
    labels: ['fig:lattice'],
    content: [image('lattice.png', '2 次元格子の一部を描いた図')],
    caption: [paragraph([ref('def:lattice'), ' の一部。'])],
  },
])
