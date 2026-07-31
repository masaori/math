import type { BlockKind } from '@structured-latex/system/domain-model'

/**
 * ブロック種別の表示名。**体裁の側の宣言**なので、正本（入力言語）ではなく画面が持つ。
 * `Record<BlockKind, string>` にしてあるので、システムが種別を増やすと型検査が落ちる
 * （表示名の付け忘れを黙って通さない）。
 */
export const BLOCK_KIND_LABELS: Record<BlockKind, string> = {
  theorem: 'Theorem',
  definition: 'Definition',
  claim: 'Claim',
  remark: 'Remark',
  note: 'Note',
  heading: 'Section',
  figure: 'Figure',
}
