/** 定理型ブロック（証明環境）の kind。 */
export type TheoremLikeKind = "theorem" | "definition" | "claim" | "remark" | "note";

/** ブロックの kind。定理型ブロックに加えて章見出しを持つ。 */
export type BlockKind = TheoremLikeKind | "heading";

export type TitleContent = {
  text?: string;
  tex?: string;
};

export type Title = TitleContent | null;

export type Node =
  | { type: "text"; value: string }
  | { type: "math"; tex: string }
  | { type: "displayMath"; tex: string }
  | { type: "paragraph"; children: Node[] }
  | { type: "list"; items: Node[][] }
  | { type: "ref"; target: string; label?: string }
  | { type: "todo"; value: string };

export type Conversion = {
  status: string;
  notes?: string[];
};

/** 定理型ブロック（本文を持つ）。 */
export type TheoremLikeBlock = {
  id: string;
  kind: TheoremLikeKind;
  sourcePath: string;
  /**
   * ソース内での通し番号（parts/ のファイル名連番に対応）。
   * 文書順ではない（文書順は配列の並びで表す）。
   */
  sourceOrdinal: number;
  title?: Title;
  labels: string[];
  statement: Node[];
  proof?: Node[];
  /** 注記欄は持てない。参照用ノートは Note（notes/）として分離する。 */
  conversion?: Conversion;
};

/**
 * 章見出しブロック（文書構造のみを持ち、本文を持たない）。
 * `level` は 1 が最上位（Typst の `=` が 1、`==` が 2）。
 */
export type HeadingBlock = {
  id: string;
  kind: "heading";
  level: number;
  sourcePath: string;
  /** 見出しの、`sourcePath` 内での 1 始まり通し番号。 */
  sourceOrdinal: number;
  title: TitleContent;
  labels: string[];
  conversion?: Conversion;
};

/** 文書を構成するブロック。配列の並びが文書順の正準表現。 */
export type ConvertedBlock = TheoremLikeBlock | HeadingBlock;

/**
 * 参照用ノート（`notes/*.mjs`）。**文書本体ではない**。
 * 最終成果物（論文・書籍）の生成は `content/` だけを読むため、ここに置いたものは
 * 出版物に混入しない。出版の本文で述べる必要がある事柄は statement に書く
 * （「正しさに必要ならそれは注記ではない」）。
 */
export type Note = {
  id: string;
  /** 紐づける定理・主張の**ラベル**（1件以上必須。パス非依存）。 */
  targets: string[];
  title?: Title;
  /** 由来となった原文のパス（任意）。 */
  sourcePath?: string;
  body: Node[];
};

export function defineBlocks(blocks: ConvertedBlock[]): ConvertedBlock[];
export function defineNotes(notes: Note[]): Note[];
export function text(value: string): Node;
export function math(tex: string): Node;
export function displayMath(tex: string): Node;
export function paragraph(children: Array<string | Node>): Node;
export function list(items: Array<Array<string | Node>>): Node;
export function ref(target: string, label?: string): Node;
export function todo(value: string): Node;
export function validateBlock(block: ConvertedBlock): void;
