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
  notes?: Node[];
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

export function defineBlocks(blocks: ConvertedBlock[]): ConvertedBlock[];
export function text(value: string): Node;
export function math(tex: string): Node;
export function displayMath(tex: string): Node;
export function paragraph(children: Array<string | Node>): Node;
export function list(items: Array<Array<string | Node>>): Node;
export function ref(target: string, label?: string): Node;
export function todo(value: string): Node;
export function validateBlock(block: ConvertedBlock): void;
