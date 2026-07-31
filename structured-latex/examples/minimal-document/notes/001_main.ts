import { paragraph } from '../../../domain-model/index.ts'
import { defineNotes } from '../schema.ts'

/**
 * 参照用ノートは**文書本体ではない**（I5）。出版ターゲットでは配置されない。
 * ただし id の一意性と targets の解決可能性は、出版するかどうかと無関係に検査される。
 */
export default defineNotes([
  {
    id: 'note_main_theorem_limit_background',
    targets: ['thm:limit'],
    title: { text: '背景' },
    body: [paragraph(['この定理を出版本文でどう導入するかの覚書。'])],
  },
])
