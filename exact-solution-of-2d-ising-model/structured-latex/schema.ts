/**
 * このプロジェクトの構造化テキストの**入口**。
 *
 * **入力言語（ブロック・ノード・ラベル・ノートの語彙と検査）の正本は、
 * リポジトリ直下の `structured-latex/`（システム）にある。ここには複製しない。**
 * このファイルがやることは 3 つだけである（システムの docs/domain-model.md §5.4）。
 *
 *   1. 生成された `Label`（content に実在するラベルのユニオン型）を受け取る
 *   2. このプロジェクト固有のメタデータ（`conversion` = Typst 原本からの移行の由来）を宣言する
 *   3. ファクトリを具体化して `defineBlocks` / `defineNotes` / `ref` を得る
 *
 * 型で捕まえること（コンパイル時）と実行時にしか捕まえられないことの切り分けは、
 * システム側の docs/type-coverage.md が正本である。このプロジェクト固有の実行時検査
 * （未変換 Typst 記法の混入、抽象テンソル積 `\otimes` の混入）は `tools/validate-content.ts`。
 *
 * 実行方法: Node 22.18+ の型ストリップにより、この `.ts` は変換なしでそのまま import できる。
 * ビルド成果物（dist）は作らない。`tsc` は検査専用（noEmit）。
 */

import { z } from "zod";

import {
  createRuntimeSchema,
  createStructuredTextSchema,
} from "../../structured-latex/domain-model/index.ts";
import type {
  Block,
  FigureBlock as SystemFigureBlock,
  HeadingBlock as SystemHeadingBlock,
  Node as SystemNode,
  Note as SystemNote,
  TheoremLikeBlock as SystemTheoremLikeBlock,
} from "../../structured-latex/domain-model/index.ts";
import type { Label } from "./labels.generated.ts";

export type { Label };

// --- プロジェクト固有メタデータ ----------------------------------------------
//
// `conversion` は「この文書がどこから来たか」ではなく「Typst 原本からの移行なのか、
// 構造化テキスト側で新規に書いたのか」という**移行の状態**を表す。由来そのもの（原本のパスと
// 通し番号）は入力言語のコアにある `origin` が持つので、そちらとは役割が違う。
// 移行が完了して Typst を廃止したら、このメタデータごと消せる。

/** `converted` は Typst 原本からの移行、`added` は構造化テキスト側での新規追加。 */
export type ConversionStatus = "converted" | "added";

export type Conversion = {
  status: ConversionStatus;
  notes?: string[];
};

/**
 * ブロックへ足すメタデータ。
 *
 * **見出しブロックには書けない。** システムの `HeadingBlock` はメタデータの型引数 `M` を
 * 受け取らない（定理型ブロックにだけ効く）ため。移行時、見出しの `conversion` は
 * `origin.path` から一意に復元できることを確認したうえで落としてある
 * （`tools/codemod-source-to-origin.ts` がその確認を機械的に行う）。
 */
export type ConversionMeta = { conversion?: Conversion };

// --- 入力言語の具体化 --------------------------------------------------------

export const { defineBlocks, defineNotes, ref } = createStructuredTextSchema<
  Label,
  ConversionMeta
>();

/**
 * 実行時検証（型を経由せずに作られた値への関門）。**throw せず Result を返す。**
 * メタデータのキーはここで宣言しないと `.strict()` に弾かれる。
 */
export const runtimeSchema = createRuntimeSchema<
  Label,
  ConversionMeta,
  { conversion: z.ZodTypeAny }
>({
  blockMeta: {
    conversion: z
      .object({
        status: z.enum(["converted", "added"]),
        notes: z.array(z.string()).optional(),
      })
      .strict()
      .optional(),
  },
});

// --- ノードの構築子（システムから再エクスポート。ここでは定義しない） ---------

export {
  displayMath,
  image,
  list,
  math,
  paragraph,
  text,
  todo,
} from "../../structured-latex/domain-model/index.ts";

// --- 型（システムから再エクスポート。ラベル束縛だけこのプロジェクトで固定する） ---

export type {
  BlockKind,
  DisplayMathNode,
  HeadingKind,
  HeadingLevel,
  ImageNode,
  MathNode,
  NodeType,
  Origin,
  TextNode,
  TheoremLikeKind,
  Title,
  TitleContent,
  TodoNode,
} from "../../structured-latex/domain-model/index.ts";

export type {
  Assert,
  AssertNoDuplicate,
  BlockIdsOf,
  FindDuplicate,
  LabelsOf,
  NoteIdsOf,
} from "../../structured-latex/domain-model/index.ts";

export type { Result, ValidationIssue } from "../../structured-latex/domain-model/index.ts";

/** 本文中のノード。参照の宛先は content に実在するラベルだけ。 */
export type Node = SystemNode<Label>;

export type InlineInput = string | Node;
export type ParagraphNode = Extract<Node, { type: "paragraph" }>;
export type ListNode = Extract<Node, { type: "list" }>;
export type RefNode = Extract<Node, { type: "ref" }>;

/** 定理型ブロック（本文を持つ）。 */
export type TheoremLikeBlock = SystemTheoremLikeBlock<Label, ConversionMeta>;

/** 章見出しブロック（文書構造のみを持つ）。 */
export type HeadingBlock = SystemHeadingBlock<Label>;

/** 図表ブロック（このプロジェクトの content には現れないが、語彙としては存在する）。 */
export type FigureBlock = SystemFigureBlock<Label>;

/**
 * 文書を構成するブロック。配列の並びが文書順の正準表現。
 * 名前は移行前から使っているものを保つ（content / tools の import を変えないため）。
 */
export type ConvertedBlock = Block<Label, ConversionMeta>;

/** 参照用ノート。**文書本体ではない**（最終成果物は content/ だけから生成する）。 */
export type Note = SystemNote<Label>;
