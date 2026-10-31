/**
 * このプロジェクトの構造化テキストの入口。
 *
 * 入力言語（ブロック・ノード・ラベル・ノートの語彙と検査）の正本は、リポジトリ直下の
 * `structured-latex/`（システム）にある。ここには複製しない。このファイルは、生成された `Label` を
 * 受け取り、プロジェクト固有メタデータ（SageMath 検証と Lean 定理への紐づけ）を宣言し、
 * ファクトリを具体化するだけである。
 *
 * 係数体は全章で ℂ に固定しており、極限・完備性を使う箇所は無い。
 * 住処（可算／非可算）の宣言は、この論文では区別が生じないので持たない。
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

import type { Label } from "./labels.generated.ts";

export type { Label, Origin };

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
  FindDuplicate,
  HeadingLevel,
  LabelsOf,
  NoteIdsOf,
  Result,
  TheoremLikeKind,
  Title,
  TitleContent,
  ValidationIssue,
} from "../../structured-latex/domain-model/index.ts";

/** 証明と外部の機械検証との紐づけ。 */
export type Linkage = {
  /**
   * 対応する SageMath 検証ディレクトリのパス（プロジェクトルートからの相対）。
   * 実在は `tools/validate-content.ts` が検査する。
   */
  verification?: readonly string[];
  /** 対応する Lean の定理名。 */
  lean?: readonly string[];
};

export type ProjectMeta = Linkage;

export type TheoremLikeBlock = SystemTheoremLikeBlock<Label, ProjectMeta>;

/** 見出しブロック。固有メタデータを持てない。 */
export type HeadingBlock = SystemHeadingBlock<Label> & {
  verification?: never;
  lean?: never;
};

export type ConvertedBlock = TheoremLikeBlock | HeadingBlock | FigureBlock<Label>;

export type Node = SystemNode<Label>;

export type Note = SystemNote<Label>;

const schema = createStructuredTextSchema<Label, ProjectMeta>();

export const defineBlocks = <const T extends readonly ConvertedBlock[]>(
  blocks: T & readonly ConvertedBlock[] & NoDuplicateBlockId<T> & NoDuplicateLabel<T>,
): T => blocks;

export const defineNotes = schema.defineNotes;

export const ref = schema.ref;

type BlockMetaSchema = {
  verification: z.ZodTypeAny;
  lean: z.ZodTypeAny;
};

const blockMeta: BlockMetaSchema = {
  verification: z.array(z.string().min(1)).optional(),
  lean: z.array(z.string().min(1)).optional(),
};

export const runtimeSchema = createRuntimeSchema<Label, ProjectMeta, BlockMetaSchema>({ blockMeta });

export const isHeading = (block: ConvertedBlock): block is HeadingBlock => block.kind === "heading";

export type AnyBlock = Block<Label, ProjectMeta>;
