// 自動生成ファイル — 直接編集しない。
// 生成元: content/ の全ブロックの labels（tools/generate-index.ts）
// 再生成: node tools/generate-index.ts
//
// このユニオン型が「実在するラベル」の全体であり、ref() / notes の targets は
// これ以外を受け付けない。存在しないラベルへの参照はコンパイル時に落ちる。

export const ALL_LABELS = [
  "scaffold_claim_placeholder",
  "scaffold_def_placeholder",
] as const;

/** content/ に実在するラベル。相互参照はこの型の値しか指せない。 */
export type Label = (typeof ALL_LABELS)[number];
