/**
 * 構造化テキストのスキーマ（型 + 実行時検証）の正本。
 *
 * 型で捕まえること（コンパイル時）:
 *   - `ref()` / ノートの `targets` が **存在しないラベル**を指していないか
 *     （`Label` は `labels.generated.ts` に生成された、content 側で実在するラベルのユニオン型）
 *   - ブロックの `labels` に、生成済みユニオンに無いラベルを書いていないか
 *     （＝ ラベルを増減したら `npm run gen:labels` を回すまで型検査が落ちる）
 *   - kind ごとに許されるフィールド（見出しは本文を持たない、本文ブロックは `notes` を持てない）
 *   - ノートの `targets` が 1 件以上あること（空タプル不可）
 *
 * 実行時にしか捕まえられないこと（`tools/validate-content.ts`）:
 *   - id / ラベルの重複、未変換の Typst 記法の混入、`.mjs` 側（型検査対象外）の値の妥当性
 *
 * 実行方法: Node 22.18+ の型ストリップにより、この `.ts` は変換なしでそのまま import できる。
 * ビルド成果物（dist）は作らない。`tsc` は検査専用（noEmit）。
 */

import type { Label } from "./labels.generated.ts";

export type { Label };

/** 定理型ブロック(証明環境)の kind。 */
export type TheoremLikeKind = "theorem" | "definition" | "claim" | "remark" | "note";

/** 章見出しブロックの kind。定理型ブロックと同じ配列に、文書順のとおり並べる。 */
export type HeadingKind = "heading";

/** ブロックの kind。定理型ブロックに加えて章見出しを持つ。 */
export type BlockKind = TheoremLikeKind | HeadingKind;

const THEOREM_LIKE_KINDS = new Set<string>([
  "theorem",
  "definition",
  "claim",
  "remark",
  "note",
] satisfies TheoremLikeKind[]);

const HEADING_KIND: HeadingKind = "heading";

const KINDS = new Set<string>([...THEOREM_LIKE_KINDS, HEADING_KIND]);

/** 見出しの深さ。1 が最上位（Typst の `=`、`==` は 2）。 */
const MAX_HEADING_LEVEL = 6;

const NODE_TYPES = new Set<string>([
  "paragraph",
  "math",
  "displayMath",
  "list",
  "ref",
  "text",
  "todo",
]);

export type TitleContent = {
  text?: string;
  tex?: string;
};

export type Title = TitleContent | null;

export type TextNode = { type: "text"; value: string };
export type MathNode = { type: "math"; tex: string };
export type DisplayMathNode = { type: "displayMath"; tex: string };
export type ParagraphNode = { type: "paragraph"; children: Node[] };
export type ListNode = { type: "list"; items: Node[][] };
/** `target` は content 側で実在するラベルだけを受け付ける（未解決参照はコンパイル時に落ちる）。 */
export type RefNode = { type: "ref"; target: Label; label?: string | undefined };
export type TodoNode = { type: "todo"; value: string };

export type Node =
  | TextNode
  | MathNode
  | DisplayMathNode
  | ParagraphNode
  | ListNode
  | RefNode
  | TodoNode;

/** 段落・リストの子として、素の文字列を書けるようにするための入力型。 */
export type InlineInput = string | Node;

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
  labels: readonly Label[];
  statement: readonly Node[];
  proof?: readonly Node[];
  conversion?: Conversion;
  /**
   * 本文ブロックは注記欄を持てない（`never` により**コンパイル時**に拒否する）。
   * 参照用の注記は `notes/` へ置き、`targets` でこのブロックのラベルに紐づける。
   */
  notes?: never;
  level?: never;
};

/**
 * 章見出しブロック（文書構造のみを持ち、本文を持たない）。
 * `level` は 1 が最上位（Typst の `=` が 1、`==` が 2）。
 */
export type HeadingBlock = {
  id: string;
  kind: HeadingKind;
  level: number;
  sourcePath: string;
  /** 見出しの、`sourcePath` 内での 1 始まり通し番号。 */
  sourceOrdinal: number;
  title: TitleContent;
  labels: readonly Label[];
  conversion?: Conversion;
  /** 見出しは本文を持たない（`never` によりコンパイル時に拒否する）。 */
  statement?: never;
  proof?: never;
  notes?: never;
};

/** 文書を構成するブロック。配列の並びが文書順の正準表現。 */
export type ConvertedBlock = TheoremLikeBlock | HeadingBlock;

/**
 * 参照用ノート（`notes/*`）。**文書本体ではない**。
 * 最終成果物（論文・書籍）の生成は `content/` だけを読むため、ここに置いたものは
 * 出版物に混入しない。出版の本文で述べる必要がある事柄は statement に書く
 * （「正しさに必要ならそれは注記ではない」）。
 */
export type Note = {
  id: string;
  /** 紐づける定理・主張の**ラベル**（1件以上必須。空配列はコンパイル時に落ちる）。 */
  targets: readonly [Label, ...Label[]];
  title?: Title;
  /** 由来となった原文のパス（任意）。 */
  sourcePath?: string;
  body: readonly Node[];
};

/**
 * 1ファイル分のブロック列を定義する。
 * **配列の並びが文書順の正準表現**であり、文書全体の順序は
 * 「content/* をファイル名昇順に並べ、各ファイル内は配列順」で復元される
 * （旧 main.typ の `#include` 順がこれに一致するように content 側を並べる）。
 * `sourceOrdinal` は「ソース内での通し番号」であって文書順ではない
 * （parts/ のファイル名連番と `#include` 順は一致しないため）。
 */
export function defineBlocks<const T extends readonly ConvertedBlock[]>(blocks: T): T {
  if (!Array.isArray(blocks)) {
    throw new TypeError("defineBlocks expects an array");
  }
  for (const block of blocks) {
    validateBlock(block);
  }
  return blocks;
}

/**
 * 参照用ノートの列を定義する（`notes/*` から使う）。
 *
 * **ノートは文書本体ではない。** 最終成果物（論文・書籍）の生成は `content/` だけを読むので、
 * ここに置いたものは構造上いっさい出版物に混入しない。出版の本文で述べる必要がある事柄は
 * ノートではなくブロックの `statement` に書くこと（「正しさに必要ならそれは注記ではない」）。
 *
 * 各ノートは `targets` で関連する定理・主張を**ラベル**で参照する（パス非依存）。
 * 用途は、出版物の証明以外の部分（動機・背景・読み方の説明）を書くときの素材。
 */
export function defineNotes<const T extends readonly Note[]>(notes: T): T {
  if (!Array.isArray(notes)) {
    throw new TypeError("defineNotes expects an array");
  }
  for (const note of notes) {
    validateNote(note);
  }
  return notes;
}

export function text(value: string): TextNode {
  return { type: "text", value };
}

export function math(tex: string): MathNode {
  return { type: "math", tex };
}

export function displayMath(tex: string): DisplayMathNode {
  return { type: "displayMath", tex };
}

export function paragraph(children: readonly InlineInput[]): ParagraphNode {
  return { type: "paragraph", children: normalizeChildren(children) };
}

export function list(items: readonly (readonly InlineInput[])[]): ListNode {
  return {
    type: "list",
    items: items.map((item) => normalizeChildren(item)),
  };
}

/**
 * 相互参照。`target` は content 側で実在するラベル（`Label`）だけを受け付ける。
 * 存在しないラベルを書くと**コンパイル時**に落ちる（実行時検証を待たない）。
 */
export function ref(target: Label, label: string | undefined = undefined): RefNode {
  return { type: "ref", target, label };
}

export function todo(value: string): TodoNode {
  return { type: "todo", value };
}

function normalizeChildren(children: readonly InlineInput[]): Node[] {
  if (!Array.isArray(children)) {
    throw new TypeError("children must be an array");
  }
  return children.map((child) => {
    if (typeof child === "string") return text(child);
    return child;
  });
}

export function validateBlock(block: ConvertedBlock): void {
  assertObject(block, "block");
  assertString(block.id, "block.id");
  assertString(block.sourcePath, `${block.id}.sourcePath`);
  assertInteger(block.sourceOrdinal, `${block.id}.sourceOrdinal`);
  if (!KINDS.has(block.kind)) {
    throw new TypeError(`${block.id}.kind must be one of ${[...KINDS].join(", ")}`);
  }
  if (block.title !== null && block.title !== undefined) {
    validateTitle(block.title, `${block.id}.title`);
  }
  if (!Array.isArray(block.labels)) {
    throw new TypeError(`${block.id}.labels must be an array`);
  }
  for (const label of block.labels) {
    assertString(label, `${block.id}.labels[]`);
  }
  if (block.conversion !== undefined) {
    assertObject(block.conversion, `${block.id}.conversion`);
    assertString(block.conversion.status, `${block.id}.conversion.status`);
    // conversion.notes は文字列の配列。文字列を直接書く誤りをここで捕まえる
    // （ビューア側の Zod は弾くが、こちらが素通しすると検証が二重基準になる）。
    if (block.conversion.notes !== undefined) {
      if (!Array.isArray(block.conversion.notes)) {
        throw new TypeError(`${block.id}.conversion.notes must be an array of strings`);
      }
      for (const note of block.conversion.notes) {
        assertString(note, `${block.id}.conversion.notes[]`);
      }
    }
  }
  if (block.kind === HEADING_KIND) {
    validateHeadingBlock(block);
    return;
  }
  validateNodes(block.statement ?? [], `${block.id}.statement`);
  if (block.proof !== undefined) {
    validateNodes(block.proof, `${block.id}.proof`);
  }
  // 本文ブロックは注記欄を持てない。
  // 参照用ノートは notes/ に分離し targets でラベル紐づけする（最終成果物は content のみから生成）。
  // ここを許すと注記が出版物へ混入する経路になるため、明示的に拒否する。
  if (block.notes !== undefined) {
    throw new TypeError(
      `${block.id}.notes は使えない: 参照用の注記は structured-latex/notes/ へ置き、` +
        "targets でこのブロックのラベルに紐づけること。" +
        "出版本文で述べる必要がある事柄は statement（証明中なら proof）に書くこと。",
    );
  }
}

function validateNote(note: Note): void {
  assertObject(note, "note");
  assertString(note.id, "note.id");
  if (!Array.isArray(note.targets)) {
    throw new TypeError(`${note.id}.targets must be an array of labels`);
  }
  if (note.targets.length === 0) {
    throw new TypeError(
      `${note.id}.targets must reference at least one label ` +
        "（ノートは必ず関連する定理・主張に紐づける）",
    );
  }
  for (const target of note.targets) {
    assertString(target, `${note.id}.targets[]`);
  }
  if (note.title !== null && note.title !== undefined) {
    validateTitle(note.title, `${note.id}.title`);
  }
  if (note.sourcePath !== undefined) {
    assertString(note.sourcePath, `${note.id}.sourcePath`);
  }
  validateNodes(note.body ?? [], `${note.id}.body`);
}

/**
 * 見出しブロックの検証。
 * 見出しは「文書構造」だけを持ち、本文（statement/proof/notes）を持たない。
 */
function validateHeadingBlock(block: HeadingBlock): void {
  assertInteger(block.level, `${block.id}.level`);
  if (block.level < 1 || block.level > MAX_HEADING_LEVEL) {
    throw new TypeError(`${block.id}.level must be between 1 and ${MAX_HEADING_LEVEL}`);
  }
  if (block.title === null || block.title === undefined) {
    throw new TypeError(`${block.id}.title is required for kind "${HEADING_KIND}"`);
  }
  if (block.title.text === undefined && block.title.tex === undefined) {
    throw new TypeError(`${block.id}.title must have text or tex`);
  }
  for (const field of ["statement", "proof", "notes"] as const) {
    if (block[field] !== undefined) {
      throw new TypeError(`${block.id}.${field} is not allowed for kind "${HEADING_KIND}"`);
    }
  }
}

function validateTitle(title: TitleContent, path: string): void {
  assertObject(title, path);
  if (title.text !== undefined) assertString(title.text, `${path}.text`);
  if (title.tex !== undefined) assertString(title.tex, `${path}.tex`);
}

export function validateNodes(nodes: readonly Node[], path: string): void {
  if (!Array.isArray(nodes)) {
    throw new TypeError(`${path} must be an array`);
  }
  nodes.forEach((node, index) => validateNode(node, `${path}[${index}]`));
}

function validateNode(node: Node, path: string): void {
  assertObject(node, path);
  if (!NODE_TYPES.has(node.type)) {
    throw new TypeError(`${path}.type is invalid: ${node.type}`);
  }
  switch (node.type) {
    case "paragraph":
      validateNodes(node.children, `${path}.children`);
      break;
    case "math":
    case "displayMath":
      assertString(node.tex, `${path}.tex`);
      break;
    case "list":
      if (!Array.isArray(node.items)) throw new TypeError(`${path}.items must be an array`);
      node.items.forEach((item, index) => validateNodes(item, `${path}.items[${index}]`));
      break;
    case "ref":
      assertString(node.target, `${path}.target`);
      if (node.label !== undefined) assertString(node.label, `${path}.label`);
      break;
    case "text":
    case "todo":
      assertString(node.value, `${path}.value`);
      break;
  }
}

function assertObject(value: unknown, path: string): void {
  if (value === null || typeof value !== "object" || Array.isArray(value)) {
    throw new TypeError(`${path} must be an object`);
  }
}

function assertString(value: unknown, path: string): void {
  if (typeof value !== "string") {
    throw new TypeError(`${path} must be a string`);
  }
}

function assertInteger(value: unknown, path: string): void {
  if (!Number.isInteger(value)) {
    throw new TypeError(`${path} must be an integer`);
  }
}
