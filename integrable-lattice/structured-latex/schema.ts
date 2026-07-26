/**
 * 構造化テキストのスキーマ（型 + 実行時検証）の正本。
 *
 * 土台は `exact-solution-of-2d-ising-model/structured-latex/schema.ts` を複製したものだが、
 * **本プロジェクト固有の要件**（可算／非可算の分別、ℝ 脱出の明示、SageMath・Lean との紐づけ）を
 * 型と実行時の両方へ追加してある。追加分は下記 `habitat` / `realEscape` / `verification` / `lean`。
 *
 * 型で捕まえること（コンパイル時）:
 *   - `ref()` / ノートの `targets` が **存在しないラベル**を指していないか
 *     （`Label` は `labels.generated.ts` に生成された、content 側で実在するラベルのユニオン型）
 *   - ブロックの `labels` に、生成済みユニオンに無いラベルを書いていないか
 *     （＝ ラベルを増減したら `node tools/generate-index.ts` を回すまで型検査が落ちる）
 *   - kind ごとに許されるフィールド（見出しは本文を持たない、本文ブロックは `notes` を持てない）
 *   - ノートの `targets` が 1 件以上あること（空タプル不可）
 *   - **本文ブロックが `habitat`（扱う量の住処）を宣言していること**
 *   - **`habitat` が非可算側（ℝ/ℂ/mixed）なら `realEscape` が必須、可算側なら `realEscape` は書けない**
 *
 * 実行時にしか捕まえられないこと（`tools/validate-content.ts`）:
 *   - id / ラベルの重複、未変換の Typst 記法の混入、型を経由せず組み立てられた値の妥当性
 *   - `verification` が指す SageMath 検証ディレクトリの実在（型システムは fs を読めない）
 *   - 可算 habitat を宣言したブロックの数式に ℝ/ℂ が現れていないこと
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

// --- 本プロジェクト固有: 量の住処（可算 / 非可算）----------------------------
//
// README とリポジトリ直下 CLAUDE.md の要求:
//   「できる限り Λ の言葉で証明を書き、可算（ℕ/ℤ/ℚ/Λ/ℚ̄）と非可算（ℝ/ℂ）を分別しながら
//     証明する。ℝ へ脱出した箇所を必ず明示する」
// これを散文の約束事にせず、ブロックの必須フィールドとして型で強制する。

/**
 * 可算側の住処。ℕ ⊂ ℤ ⊂ ℚ ⊂ Λ（対数順序群）⊂ ℚ̄（代数的数）。
 * `"none"` は「数量を扱わないブロック」（方法論的な注意・文書構造上の但し書きなど）。
 * どれも **ℝ/ℂ へ脱出していない**ことを主張する値であり、`realEscape` を書けない。
 */
export type CountableHabitat = "N" | "Z" | "Q" | "Lambda" | "Qbar" | "none";

/**
 * 非可算側の住処。`"R"` / `"C"` は主要な量そのものが ℝ / ℂ に住む場合、
 * `"mixed"` は可算な対象を扱いながら一部の議論で ℝ/ℂ へ脱出する場合。
 * いずれも `realEscape`（どこで脱出したか）の記述が必須になる。
 */
export type EscapingHabitat = "R" | "C" | "mixed";

/** ブロックが扱う量の住処。可算側と非可算側が型で区別される。 */
export type Habitat = CountableHabitat | EscapingHabitat;

const COUNTABLE_HABITATS = new Set<string>([
  "N",
  "Z",
  "Q",
  "Lambda",
  "Qbar",
  "none",
] satisfies CountableHabitat[]);

const ESCAPING_HABITATS = new Set<string>(["R", "C", "mixed"] satisfies EscapingHabitat[]);

const HABITATS = new Set<string>([...COUNTABLE_HABITATS, ...ESCAPING_HABITATS]);

/**
 * 住処の宣言。判別共用体なので、
 *   - 可算側（`CountableHabitat`）を宣言したブロックに `realEscape` を書くとコンパイル時に落ちる
 *   - 非可算側（`EscapingHabitat`）を宣言して `realEscape` を書かないとコンパイル時に落ちる
 * 「ℝ へ脱出した箇所を必ず明示する」という要求が、散文の約束ではなく型の制約になる。
 */
export type Habitation =
  | {
      habitat: CountableHabitat;
      /** 可算側では書けない（`never` によりコンパイル時に拒否する）。 */
      realEscape?: never;
    }
  | {
      habitat: EscapingHabitat;
      /** ℝ/ℂ をどこで、なぜ使ったか。空文字は実行時に拒否する。 */
      realEscape: string;
    };

/** 定理型ブロック（本文を持つ）の、住処以外の部分。 */
type TheoremLikeBlockBase = {
  id: string;
  kind: TheoremLikeKind;
  sourcePath: string;
  /**
   * ソース内での通し番号。
   * 文書順ではない（文書順は配列の並びで表す）。
   */
  sourceOrdinal: number;
  title?: Title;
  labels: readonly Label[];
  statement: readonly Node[];
  proof?: readonly Node[];
  conversion?: Conversion;
  /**
   * 対応する SageMath 検証ディレクトリのパス（プロジェクトルート `integrable-lattice/` からの相対）。
   * 実在するかは `tools/validate-content.ts` が実行時に検査する（型システムは fs を読めない）。
   */
  verification?: readonly string[];
  /** 対応する Lean の定理名。形式検証との紐づけに使う。 */
  lean?: readonly string[];
  /**
   * 本文ブロックは注記欄を持てない（`never` により**コンパイル時**に拒否する）。
   * 参照用の注記は `notes/` へ置き、`targets` でこのブロックのラベルに紐づける。
   */
  notes?: never;
  level?: never;
};

/**
 * 定理型ブロック（本文を持つ）。
 * `habitat` は必須で、値によって `realEscape` の要否が型で決まる。
 */
export type TheoremLikeBlock = TheoremLikeBlockBase & Habitation;

/** 見出しの深さ。1 が最上位。 */
export type HeadingLevel = 1 | 2 | 3 | 4 | 5 | 6;

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

/**
 * タイトルの中身。`text`（素のテキスト）か `tex`（KaTeX で描画する LaTeX）の
 * **少なくとも一方が必須**（両方書いてもよい）。空の `{}` はコンパイル時に落ちる。
 */
export type TitleContent = { text: string; tex?: string } | { text?: string; tex: string };

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

/**
 * 変換の由来。`converted` は原本（旧 Typst 等）からの移行、
 * `added` は構造化テキスト側での新規追加。綴り違いはコンパイル時に落ちる。
 */
export type ConversionStatus = "converted" | "added";

export type Conversion = {
  status: ConversionStatus;
  notes?: string[];
};

/**
 * 章見出しブロック（文書構造のみを持ち、本文を持たない）。
 * 量を扱わないので `habitat` も持たない（書くと型で落ちる）。
 */
export type HeadingBlock = {
  id: string;
  kind: HeadingKind;
  /** 1〜6 の範囲は型で縛る（範囲外はコンパイル時に落ちる）。 */
  level: HeadingLevel;
  sourcePath: string;
  /** 見出しの、`sourcePath` 内での 1 始まり通し番号。 */
  sourceOrdinal: number;
  title: TitleContent;
  labels: readonly Label[];
  conversion?: Conversion;
  /** 見出しは本文・住処・検証紐づけを持たない（`never` によりコンパイル時に拒否する）。 */
  statement?: never;
  proof?: never;
  notes?: never;
  habitat?: never;
  realEscape?: never;
  verification?: never;
  lean?: never;
};

/** 文書を構成するブロック。配列の並びが文書順の正準表現。 */
export type ConvertedBlock = TheoremLikeBlock | HeadingBlock;

/**
 * 参照用ノート（`notes/*`）。**文書本体ではない**。
 * 最終成果物（論文）の生成は `content/` だけを読むため、ここに置いたものは
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


// --- 一意性をコンパイル時に検査するための型ユーティリティ ---------------------
//
// TypeScript は「タプル型の要素の重複」を再帰的な条件型で判定できる。ブロック配列を
// `const` 型引数でリテラルのタプルとして受け取れば、id やラベルの重複を**コンパイル時**に
// 落とせる（実行時検証を待たない）。
// `T & readonly ConvertedBlock[]` という交差にしているのは、`const` 型引数だけだと
// 余剰プロパティ検査（`proof` の打ち間違い等）が効かなくなるため。

/** タプル中で最初に重複した要素を返す（重複が無ければ never）。 */
export type FindDuplicate<T extends readonly string[], Seen = never> = T extends readonly [
  infer H extends string,
  ...infer R extends readonly string[],
]
  ? H extends Seen
    ? H
    : FindDuplicate<R, Seen | H>
  : never;

/** ブロック列の id のタプル。 */
export type BlockIdsOf<T extends readonly ConvertedBlock[]> = {
  -readonly [K in keyof T]: T[K]["id"];
};

/** ノート列の id のタプル。 */
export type NoteIdsOf<T extends readonly Note[]> = { -readonly [K in keyof T]: T[K]["id"] };

/**
 * ブロック列が宣言するラベルを平坦化したタプル。
 * 末尾再帰の形にしてある（累積引数 `Acc`）。素朴な `[...H, ...LabelsOf<R>]` の形だと
 * TypeScript の再帰上限に当たり、大きな文書で TS2589（Type instantiation is excessively deep）
 * になって検査が無効化される。
 */
export type LabelsOf<
  T extends readonly ConvertedBlock[],
  Acc extends readonly string[] = [],
> = T extends readonly [infer H extends ConvertedBlock, ...infer R extends readonly ConvertedBlock[]]
  ? LabelsOf<R, [...Acc, ...H["labels"]]>
  : Acc;

/** 重複があればエラーになる制約（`never` を要求する）。 */
export type AssertNoDuplicate<D extends never> = D;

/** 条件が満たされないとエラーになる制約（`true` を要求する）。 */
export type Assert<T extends true> = T;

/**
 * 数値リテラル型が「正の整数」か。
 * TypeScript に整数型・数値範囲型は無いが、数値リテラル型は
 * テンプレートリテラル型で文字列化して判定できる（小数点・負符号・0 を弾く）。
 */
type PositiveIntegerString<S extends string> = S extends `${string}.${string}`
  ? never
  : S extends `-${string}`
    ? never
    : S extends "0" | "NaN" | "Infinity"
      ? never
      : S;

type BadOrdinal<T extends readonly { sourceOrdinal: number }[]> = {
  [K in keyof T]: `${T[K]["sourceOrdinal"]}` extends PositiveIntegerString<
    `${T[K]["sourceOrdinal"]}`
  >
    ? never
    : { __sourceOrdinalが正の整数でない: T[K]["sourceOrdinal"] };
}[number];

type AssertOrdinals<T extends readonly ConvertedBlock[]> = [BadOrdinal<T>] extends [never]
  ? unknown
  : BadOrdinal<T>;

type DuplicateBlockId<T extends readonly ConvertedBlock[]> =
  FindDuplicate<BlockIdsOf<T>> extends never
    ? unknown
    : { __ブロックidが重複している: FindDuplicate<BlockIdsOf<T>> };

type DuplicateLabel<T extends readonly ConvertedBlock[]> =
  FindDuplicate<LabelsOf<T>> extends never
    ? unknown
    : { __ラベルが重複している: FindDuplicate<LabelsOf<T>> };

type DuplicateNoteId<T extends readonly Note[]> =
  FindDuplicate<NoteIdsOf<T>> extends never
    ? unknown
    : { __ノートidが重複している: FindDuplicate<NoteIdsOf<T>> };

/**
 * 1ファイル分のブロック列を定義する。
 * **配列の並びが文書順の正準表現**であり、文書全体の順序は
 * 「content/* をファイル名昇順に並べ、各ファイル内は配列順」で復元される。
 */
export function defineBlocks<const T extends readonly ConvertedBlock[]>(
  blocks: T & readonly ConvertedBlock[] & DuplicateBlockId<T> & DuplicateLabel<T> & AssertOrdinals<T>,
): T {
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
 * **ノートは文書本体ではない。** 最終成果物の生成は `content/` だけを読むので、
 * ここに置いたものは構造上いっさい出版物に混入しない。出版の本文で述べる必要がある事柄は
 * ノートではなくブロックの `statement` に書くこと。
 */
export function defineNotes<const T extends readonly Note[]>(
  notes: T & readonly Note[] & DuplicateNoteId<T>,
): T {
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

/**
 * ブロックが持ってよいキー。
 * 型（`ConvertedBlock`）の余剰プロパティ検査と同じ規則を実行時にも掛ける。
 * これが無いと `proof` を `proofs` と打ち間違えたときに、型でも実行時でも素通りして
 * **証明が正本から黙って消える**。
 */
const BLOCK_KEYS = new Set([
  "id",
  "kind",
  "sourcePath",
  "sourceOrdinal",
  "title",
  "labels",
  "statement",
  "proof",
  "conversion",
  "level",
  "habitat",
  "realEscape",
  "verification",
  "lean",
  // `notes` は許可キーに入れる（下で専用のエラーメッセージを出して拒否するため）。
  "notes",
]);

const NOTE_KEYS = new Set(["id", "targets", "title", "sourcePath", "body"]);

/** `conversion.status` に許される値（型の `ConversionStatus` と同じ集合）。 */
const CONVERSION_STATUSES = new Set<string>(["converted", "added"] satisfies ConversionStatus[]);

function assertNoUnknownKeys(value: object, allowed: ReadonlySet<string>, path: string): void {
  const unknown = Object.keys(value).filter((key) => !allowed.has(key));
  if (unknown.length > 0) {
    throw new TypeError(
      `${path} に未知のフィールドがある: ${unknown.join(", ")}` +
        `（許可されるのは ${[...allowed].join(", ")}。打ち間違いだと中身が黙って捨てられる）`,
    );
  }
}

export function validateBlock(block: ConvertedBlock): void {
  assertObject(block, "block");
  assertString(block.id, "block.id");
  assertNoUnknownKeys(block, BLOCK_KEYS, `block ${block.id}`);
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
    // 値域は型でも縛っているが、型を迂回した値のためにここでも見る。
    if (!CONVERSION_STATUSES.has(block.conversion.status)) {
      throw new Error(
        `${block.id}.conversion.status must be one of ${[...CONVERSION_STATUSES].join(", ")}`,
      );
    }
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
  // `level` は見出しだけのフィールド。定理型で書かれていたら kind の取り違えなので拒む
  // （型では `never` で落ちるが、型を経由しない値のために実行時でも塞ぐ）。
  const levelOnTheoremLike = (block as { level?: unknown }).level;
  if (levelOnTheoremLike !== undefined) {
    throw new TypeError(`${block.id}.level is not allowed for kind "${block.kind}"`);
  }
  validateHabitation(block);
  validateLinkage(block);
  validateNodes(block.statement ?? [], `${block.id}.statement`);
  if (block.proof !== undefined) {
    validateNodes(block.proof, `${block.id}.proof`);
  }
  // 本文ブロックは注記欄を持てない。
  // 参照用ノートは notes/ に分離し targets でラベル紐づけする（最終成果物は content のみから生成）。
  if (block.notes !== undefined) {
    throw new TypeError(
      `${block.id}.notes は使えない: 参照用の注記は structured-latex/notes/ へ置き、` +
        "targets でこのブロックのラベルに紐づけること。" +
        "出版本文で述べる必要がある事柄は statement（証明中なら proof）に書くこと。",
    );
  }
}

/**
 * 住処の実行時検証（本プロジェクト固有）。
 *
 * 型（判別共用体 `Habitation`）と同じ規則を実行時にも掛ける。型を経由しない値
 * （`as never` で作った値・動的生成）でも、可算／非可算の分別と ℝ 脱出の明示を素通しさせない。
 */
function validateHabitation(block: TheoremLikeBlock): void {
  const habitatValue: unknown = (block as { habitat?: unknown }).habitat;
  if (habitatValue === undefined) {
    throw new TypeError(
      `${block.id}.habitat が無い: 本文ブロックは扱う量の住処を宣言する` +
        `（可算: ${[...COUNTABLE_HABITATS].join(" / ")}、非可算: ${[...ESCAPING_HABITATS].join(" / ")}）。` +
        "量を扱わないブロックは \"none\" を書く。",
    );
  }
  if (typeof habitatValue !== "string") {
    throw new TypeError(`${block.id}.habitat must be a string`);
  }
  const habitat: string = habitatValue;
  if (!HABITATS.has(habitat)) {
    throw new TypeError(`${block.id}.habitat must be one of ${[...HABITATS].join(", ")}`);
  }
  const realEscape: unknown = (block as { realEscape?: unknown }).realEscape;
  if (ESCAPING_HABITATS.has(habitat)) {
    if (realEscape === undefined) {
      throw new TypeError(
        `${block.id}.realEscape が無い: habitat "${habitat}" は非可算（ℝ/ℂ）へ脱出しているので、` +
          "どこで・なぜ脱出したかを必ず書く（README「証明の書き方」）。",
      );
    }
    if (typeof realEscape !== "string") {
      throw new TypeError(`${block.id}.realEscape must be a string`);
    }
    if (realEscape.trim() === "") {
      throw new TypeError(`${block.id}.realEscape が空: 脱出箇所を具体的に書く`);
    }
    return;
  }
  if (realEscape !== undefined) {
    throw new TypeError(
      `${block.id}.realEscape は habitat "${habitat}"（可算側）では書けない: ` +
        "ℝ/ℂ を使ったなら habitat を \"R\" / \"C\" / \"mixed\" にする。使っていないなら realEscape を消す。",
    );
  }
}

/** SageMath 検証・Lean 定理への紐づけの実行時検証（実在確認は validate-content.ts）。 */
function validateLinkage(block: TheoremLikeBlock): void {
  for (const field of ["verification", "lean"] as const) {
    const value = (block as Record<string, unknown>)[field];
    if (value === undefined) continue;
    if (!Array.isArray(value)) {
      throw new TypeError(`${block.id}.${field} must be an array of strings`);
    }
    for (const item of value) {
      assertString(item, `${block.id}.${field}[]`);
      if (item.trim() === "") {
        throw new TypeError(`${block.id}.${field}[] に空文字がある`);
      }
    }
  }
}

function validateNote(note: Note): void {
  assertObject(note, "note");
  assertString(note.id, "note.id");
  assertNoUnknownKeys(note, NOTE_KEYS, `note ${note.id}`);
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
 * 見出しは「文書構造」だけを持ち、本文（statement/proof/notes）も住処も持たない。
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
  for (const field of [
    "statement",
    "proof",
    "notes",
    "habitat",
    "realEscape",
    "verification",
    "lean",
  ] as const) {
    if (block[field] !== undefined) {
      throw new TypeError(`${block.id}.${field} is not allowed for kind "${HEADING_KIND}"`);
    }
  }
}

function validateTitle(title: TitleContent, path: string): void {
  assertObject(title, path);
  const text = (title as { text?: unknown }).text;
  const tex = (title as { tex?: unknown }).tex;
  if (text !== undefined) assertString(text, `${path}.text`);
  if (tex !== undefined) assertString(tex, `${path}.tex`);
  // 「text か tex の少なくとも一方」は型でも縛っているが、見出しに限らず全ブロック・
  // ノートで成り立つべき条件なので、実行時にも同じ基準で見る。
  if (text === undefined && tex === undefined) {
    throw new TypeError(`${path} must have text or tex`);
  }
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

/** 実行時検証・ツール側から参照するための、住処の集合（型の定義と同じ集合）。 */
export const HABITAT_VALUES = {
  countable: COUNTABLE_HABITATS as ReadonlySet<string>,
  escaping: ESCAPING_HABITATS as ReadonlySet<string>,
} as const;
