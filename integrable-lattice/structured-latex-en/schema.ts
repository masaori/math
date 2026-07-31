/**
 * 英語版プロジェクトが使う構造化テキストスキーマの**具体化**。
 *
 * このファイルがやることは日本語版 `../structured-latex/schema.ts` と同じ 3 つだけである
 * （システム README「使う側がやること」）。
 *
 *   1. 生成された `Label`（**英語版の** content/ に実在するラベルのユニオン型）を受け取る
 *   2. プロジェクト固有メタデータ（`habitat` / `realEscape` / `verification` / `lean`）を宣言する
 *   3. `createStructuredTextSchema` / `createRuntimeSchema` を具体化して再エクスポートする
 *
 * ### 固有メタデータの定義を「複製せず、日本語版から import する」理由
 *
 * 住処（`Habitat` / `Habitation`）と外部検証の紐づけ（`Linkage`）は**言語に依存しない**。
 * これは英訳の対象ではなく、日英で同一でなければならない値である
 * （`tools/verify-ja-en-correspondence.ts` は `habitat` の**文字列一致**を検査する）。
 * ここで同じ定義を書き写すと、片方だけ住処の語彙が増えたときに対応検証が意味を失う。
 * したがって語彙は日本語版に 1 つだけ置き、こちらは import する。
 * **日本語版 `schema.ts` はこの import のために一切変更していない**（既存の export をそのまま使う）。
 *
 * ラベル束縛（`Label`）とブロック型だけが英語版固有である。
 */

import { z } from "zod";

import {
  createRuntimeSchema,
  createStructuredTextSchema,
  type Block,
  type FigureBlock,
  type HeadingBlock as SystemHeadingBlock,
  type NoDuplicateBlockId,
  type NoDuplicateLabel,
  type Node as SystemNode,
  type Note as SystemNote,
  type Origin,
  type TheoremLikeBlock as SystemTheoremLikeBlock,
} from "../../structured-latex/domain-model/index.ts";

// 住処・脱出・外部検証の語彙は日本語版が正本。ここで再定義しない（上の理由を見よ）。
import {
  HABITAT_VALUES,
  checkHabitation,
  type CountableHabitat,
  type EscapingHabitat,
  type Habitat,
  type Habitation,
  type Linkage,
  type ProjectMeta,
} from "../structured-latex/schema.ts";

import type { Label } from "./labels.generated.ts";

export type { Label, Origin };
export type { CountableHabitat, EscapingHabitat, Habitat, Habitation, Linkage, ProjectMeta };
export { HABITAT_VALUES, checkHabitation };

// システムが持つ語彙をそのまま通す（同じものを 2 経路で import できる状態を作らないため、
// 利用側はこのモジュールだけを見ればよい）。
// `cite`（文献引用）は**英語版で新たに使う**ノードである。日本語版は書誌を地の文で書くため使わない。
export {
  cite,
  displayMath,
  image,
  list,
  math,
  paragraph,
  text,
  todo,
} from "../../structured-latex/domain-model/index.ts";

export type {
  Assert,
  AssertNoDuplicate,
  BlockIdsOf,
  CiteNode,
  FindDuplicate,
  HeadingLevel,
  LabelsOf,
  NoteIdsOf,
  TheoremLikeKind,
  Title,
  TitleContent,
} from "../../structured-latex/domain-model/index.ts";

/** 本文（定理型）ブロック。住処の宣言が必須。 */
export type TheoremLikeBlock = SystemTheoremLikeBlock<Label, ProjectMeta>;

/** 見出しブロック。**固有メタデータを持てない**（見出しは量を扱わない）。 */
export type HeadingBlock = SystemHeadingBlock<Label> & {
  habitat?: never;
  realEscape?: never;
  verification?: never;
  lean?: never;
};

/** 文書を構成するブロック。配列の並びが文書順の正準表現。 */
export type ConvertedBlock = TheoremLikeBlock | HeadingBlock | FigureBlock<Label>;

export type Node = SystemNode<Label>;
export type Note = SystemNote<Label>;

const schema = createStructuredTextSchema<Label, ProjectMeta>();

/**
 * 1 ファイル分のブロック列を定義する。**配列の並びが文書順の正準表現**。
 * 受け口を `ConvertedBlock` に絞るためだけにシステムの `defineBlocks` へ 1 枚被せてある。
 */
export const defineBlocks = <const T extends readonly ConvertedBlock[]>(
  blocks: T & readonly ConvertedBlock[] & NoDuplicateBlockId<T> & NoDuplicateLabel<T>,
): T => blocks;

export const defineNotes = schema.defineNotes;

/** 相互参照。実在しないラベルはコンパイル時に落ちる。 */
export const ref = schema.ref;

// --- 実行時検証 --------------------------------------------------------------

/**
 * 住処の値の集合（日本語版が持つ集合をそのまま使う）から、zod の enum を組み立てる。
 * 値の集合を 2 か所に書かないため、リテラルの列を書き写さず `HABITAT_VALUES` から作る。
 */
const ALL_HABITATS = [...HABITAT_VALUES.countable, ...HABITAT_VALUES.escaping] as [
  string,
  ...string[],
];

/**
 * 実行時スキーマ。**固有メタデータのキーはここで宣言しないと `.strict()` に弾かれる**
 * （宣言していないキーを書けば「未知のフィールド」として拒否される＝打ち間違いで
 * 中身が黙って捨てられる事故を塞ぐ）。
 */
export const runtimeSchema = createRuntimeSchema<
  Label,
  ProjectMeta,
  {
    habitat: z.ZodTypeAny;
    realEscape: z.ZodTypeAny;
    verification: z.ZodTypeAny;
    lean: z.ZodTypeAny;
  }
>({
  blockMeta: {
    habitat: z.enum(ALL_HABITATS),
    realEscape: z.string().min(1).optional(),
    verification: z.array(z.string().min(1)).optional(),
    lean: z.array(z.string().min(1)).optional(),
  },
});

/** ブロックが見出しか。`ConvertedBlock` の narrowing に使う。 */
export const isHeading = (block: ConvertedBlock): block is HeadingBlock => block.kind === "heading";

/** システムの `Block` として扱いたい場面（生成器・共通処理）のための別名。 */
export type AnyBlock = Block<Label, ProjectMeta>;
