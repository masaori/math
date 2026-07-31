/**
 * 一意性（不変条件 I1）をコンパイル時に検査するための型ユーティリティ。
 *
 * TypeScript はタプル型の要素の重複を再帰的な条件型で判定できる。ブロック列を
 * `const` 型引数でリテラルのタプルとして受け取れば、id やラベルの重複を
 * **実行時検証を待たずに**落とせる。
 *
 * ここでは `Block` / `Note` そのものではなく「id と labels を持つ」という最小の形だけを
 * 要求する。メタデータの型引数 `M` を持ち込むと `Block<string, never>` のような
 * 具体化で交差が潰れ（`X & never = never`）、制約として使えなくなるため。
 *
 * 実装上の要点（先行実装で実測されている落とし穴。docs/type-coverage.md に根拠）:
 *   - 再帰は**末尾再帰**で書く。素朴な `[...H, ...LabelsOf<R>]` は数百要素規模で
 *     TS2589 になり、診断が「重複がある」から「型の展開が深すぎる」へ化けて検査が死ぬ。
 *   - 主張は必ず**制約**の形にする。`type X = A extends B ? true : never` は条件が偽でも
 *     「never という別名が定義されるだけ」でエラーにならない。
 */

/** 一意性の判定に必要な最小の形（ブロック）。 */
export type Identified = { id: string; labels: readonly string[] }

/** 一意性の判定に必要な最小の形（ノート）。 */
export type IdentifiedNote = { id: string }

/** タプル中で最初に重複した要素を返す（重複が無ければ never）。 */
export type FindDuplicate<T extends readonly string[], Seen = never> = T extends readonly [
  infer H extends string,
  ...infer R extends readonly string[],
]
  ? H extends Seen
    ? H
    : FindDuplicate<R, Seen | H>
  : never

export type BlockIdsOf<T extends readonly Identified[]> = {
  -readonly [K in keyof T]: T[K]['id']
}

export type NoteIdsOf<T extends readonly IdentifiedNote[]> = {
  -readonly [K in keyof T]: T[K]['id']
}

/** ブロック列が宣言するラベルを平坦化したタプル（末尾再帰）。 */
export type LabelsOf<
  T extends readonly Identified[],
  Acc extends readonly string[] = [],
> = T extends readonly [infer H extends Identified, ...infer R extends readonly Identified[]]
  ? LabelsOf<R, [...Acc, ...H['labels']]>
  : Acc

/** 重複があればエラーになる制約（`never` を要求する）。 */
export type AssertNoDuplicate<D extends never> = D

/** 条件が満たされないとエラーになる制約（`true` を要求する）。 */
export type Assert<T extends true> = T

/**
 * `defineBlocks` / `defineNotes` の引数へ交差させる制約。
 * 重複が無ければ `unknown`（交差しても何も足さない）、あれば重複した値を含む
 * オブジェクト型になり、診断にその値が現れる。
 */
export type NoDuplicateBlockId<T extends readonly Identified[]> =
  FindDuplicate<BlockIdsOf<T>> extends never
    ? unknown
    : { __ブロックidが重複している: FindDuplicate<BlockIdsOf<T>> }

export type NoDuplicateLabel<T extends readonly Identified[]> =
  FindDuplicate<LabelsOf<T>> extends never
    ? unknown
    : { __ラベルが重複している: FindDuplicate<LabelsOf<T>> }

export type NoDuplicateNoteId<T extends readonly IdentifiedNote[]> =
  FindDuplicate<NoteIdsOf<T>> extends never
    ? unknown
    : { __ノートidが重複している: FindDuplicate<NoteIdsOf<T>> }
