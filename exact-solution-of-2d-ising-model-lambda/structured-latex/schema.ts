/**
 * このプロジェクトの構造化テキストの**入口**。
 *
 * **入力言語（ブロック・ノード・ラベル・ノートの語彙と検査）の正本は、
 * リポジトリ直下の `structured-latex/`（システム）にある。ここには複製しない。**
 * このファイルがやることは 3 つだけである。
 *
 *   1. 生成された `Label`（content に実在するラベルのユニオン型）を受け取る
 *   2. **本プロジェクト固有メタデータ**を宣言する（`habitat` / `realEscape` / `verification` / `lean`）
 *   3. ファクトリを具体化して `defineBlocks` / `defineNotes` / `ref` を得る
 *
 * 型で捕まえること（コンパイル時）:
 *   - 存在しないラベルへの `ref()` / ノートの `targets`、未登録ラベルの宣言（システム）
 *   - id・ラベル・ノート id の重複、kind ごとに許されるフィールド（システム）
 *   - **本文ブロックが `habitat`（扱う量の住処）を宣言していること**（本プロジェクト固有）
 *   - **`habitat` が非可算側（R/C/mixed）なら `realEscape` が必須、可算側なら書けない**（同上）
 *   - **見出しブロックは固有メタデータを持てない**（同上。見出しは量を扱わない）
 *
 * 実行時にしか捕まえられないこと（`tools/validate-content.ts`）:
 *   - 型を経由せず組み立てられた値の妥当性（システムの `createRuntimeSchema`。Result を返す）
 *   - `verification` が指す SageMath 検証ディレクトリの実在（型システムは fs を読めない）
 *   - 可算 habitat を宣言したブロックの数式に ℝ/ℂ が現れていないこと
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

// システムが持つ語彙をそのまま通す（同じものを 2 経路で import できる状態を作らないため、
// 利用側はこのモジュールだけを見ればよい）。
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

// --- 本プロジェクト固有: 量の住処（可算 / 非可算）----------------------------
//
// README の要求:
//   「有限系について述べることはすべて可算な対象の厳密な等式・不等式として書き、
//     ℝ/ℂ へ脱出した箇所はどこで・なぜかを宣言する」
// これを散文の約束事にせず、ブロックの必須フィールドとして型で強制する。

/**
 * 可算側の住処。ℕ ⊂ ℤ ⊂ ℚ ⊂ Λ（対数順序群）、および ℚ̄（代数的数。Λ とは別方向の可算拡大）。
 * `"none"` は「数量を扱わないブロック」（方法論的な注意・文書構造上の但し書きなど）。
 * どれも **ℝ/ℂ へ脱出していない**ことを主張する値であり、`realEscape` を書けない。
 */
export type CountableHabitat = "N" | "Z" | "Q" | "Lambda" | "Qbar" | "none";

/**
 * 非可算側の住処。`"R"` / `"C"` は主要な量そのものが ℝ / ℂ に住む場合、
 * `"mixed"` は可算な対象を扱いながら一部の議論で ℝ/ℂ へ脱出する場合。
 * いずれも `realEscape`（どこで・なぜ脱出したか）の記述が必須になる。
 */
export type EscapingHabitat = "R" | "C" | "mixed";

/** ブロックが扱う量の住処。可算側と非可算側が型で区別される。 */
export type Habitat = CountableHabitat | EscapingHabitat;

const COUNTABLE_HABITATS = [
  "N",
  "Z",
  "Q",
  "Lambda",
  "Qbar",
  "none",
] as const satisfies readonly CountableHabitat[];

const ESCAPING_HABITATS = ["R", "C", "mixed"] as const satisfies readonly EscapingHabitat[];

const ALL_HABITATS = [
  ...COUNTABLE_HABITATS,
  ...ESCAPING_HABITATS,
] as const satisfies readonly Habitat[];

/**
 * 住処の宣言。**判別共用体**なので、
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

/** 証明と外部の機械検証との紐づけ。 */
export type Linkage = {
  /**
   * 対応する SageMath 検証ディレクトリのパス
   * （プロジェクトルート `exact-solution-of-2d-ising-model-lambda/` からの相対）。
   * 実在するかは `tools/validate-content.ts` が実行時に検査する（型システムは fs を読めない）。
   */
  verification?: readonly string[];
  /** 対応する Lean の定理名。形式検証との紐づけに使う。 */
  lean?: readonly string[];
};

/**
 * システムのファクトリへ渡す**プロジェクト固有メタデータ** `M`。
 * `Habitation` が判別共用体なので、交差した結果のブロック型も判別共用体になり、
 * 「可算を宣言したら realEscape を書けない／非可算なら必須」が型で強制される。
 */
export type ProjectMeta = Habitation & Linkage;

/** 本文（定理型）ブロック。住処の宣言が必須。 */
export type TheoremLikeBlock = SystemTheoremLikeBlock<Label, ProjectMeta>;

/**
 * 見出しブロック。**固有メタデータを持てない**（見出しは量を扱わない）。
 * システムの `HeadingBlock` はプロジェクト固有メタデータを知らないため、
 * 「書けない」ことはここで `never` を交差して表明する。
 */
export type HeadingBlock = SystemHeadingBlock<Label> & {
  habitat?: never;
  realEscape?: never;
  verification?: never;
  lean?: never;
};

/** 文書を構成するブロック。配列の並びが文書順の正準表現。 */
export type ConvertedBlock = TheoremLikeBlock | HeadingBlock | FigureBlock<Label>;

/** 本文中のノード。参照の宛先は content に実在するラベルだけ。 */
export type Node = SystemNode<Label>;

/** 参照用ノート。**文書本体ではない**（最終成果物は content/ だけから生成する）。 */
export type Note = SystemNote<Label>;

const schema = createStructuredTextSchema<Label, ProjectMeta>();

/**
 * 1 ファイル分のブロック列を定義する。**配列の並びが文書順の正準表現**。
 *
 * システムの `defineBlocks` をそのまま使わず 1 枚被せてあるのは、受け口を
 * `ConvertedBlock`（＝見出しに固有メタデータを書けないことを含む本プロジェクトの制約）に
 * 絞るためだけである。一意性の検査はシステムの型ユーティリティをそのまま使う。
 */
export const defineBlocks = <const T extends readonly ConvertedBlock[]>(
  blocks: T & readonly ConvertedBlock[] & NoDuplicateBlockId<T> & NoDuplicateLabel<T>,
): T => blocks;

export const defineNotes = schema.defineNotes;

/** 相互参照。実在しないラベルはコンパイル時に落ちる。 */
export const ref = schema.ref;

// --- 実行時検証 --------------------------------------------------------------

/** 住処の値の集合（型の定義と同じ集合）。ツール側の判定に使う。 */
export const HABITAT_VALUES = {
  countable: new Set<string>(COUNTABLE_HABITATS) as ReadonlySet<string>,
  escaping: new Set<string>(ESCAPING_HABITATS) as ReadonlySet<string>,
} as const;

/**
 * 実行時スキーマ。
 * **固有メタデータのキーはここで宣言しないと `.strict()` に弾かれる**
 * （宣言していないキーを書けば「未知のフィールド」として拒否される＝打ち間違いで
 * 中身が黙って捨てられる事故を塞ぐ）。
 *
 * 見出し・図表のスキーマにはこの `blockMeta` が織り込まれないので、
 * 「見出しに habitat を書く」は実行時にも未知フィールドとして拒否される。
 */
type BlockMetaSchema = {
  habitat: z.ZodTypeAny;
  realEscape: z.ZodTypeAny;
  verification: z.ZodTypeAny;
  lean: z.ZodTypeAny;
};

const blockMeta: BlockMetaSchema = {
  habitat: z.enum(ALL_HABITATS),
  realEscape: z.string().min(1).optional(),
  verification: z.array(z.string().min(1)).optional(),
  lean: z.array(z.string().min(1)).optional(),
};

export const runtimeSchema = createRuntimeSchema<Label, ProjectMeta, BlockMetaSchema>({ blockMeta });

const isKnownHabitat = (value: string): boolean =>
  HABITAT_VALUES.countable.has(value) || HABITAT_VALUES.escaping.has(value);

/**
 * 住処と `realEscape` の**対応**の実行時検証（本プロジェクト固有）。
 *
 * 型（判別共用体 `Habitation`）と同じ規則を実行時にも掛ける。zod のオブジェクトスキーマは
 * キー単位でしか見ないので、「可算なら書けない／非可算なら必須」という**フィールド間の条件**は
 * ここでしか見られない。型を経由しない値（`as never` で作った値・動的生成）でも素通しさせない。
 *
 * throw しない（システムの誤り伝搬方針に合わせ、問題を配列で返す）。
 */
export const checkHabitation = (block: {
  id: string;
  habitat?: unknown;
  realEscape?: unknown;
}): string[] => {
  const { habitat, realEscape } = block;
  if (habitat === undefined) {
    return [
      `${block.id}.habitat が無い: 本文ブロックは扱う量の住処を宣言する` +
        `（可算: ${COUNTABLE_HABITATS.join(" / ")}、非可算: ${ESCAPING_HABITATS.join(" / ")}）。` +
        '量を扱わないブロックは "none" を書く。',
    ];
  }
  if (typeof habitat !== "string" || !isKnownHabitat(habitat)) {
    return [`${block.id}.habitat が未知の値: ${String(habitat)}`];
  }
  if (HABITAT_VALUES.escaping.has(habitat)) {
    if (realEscape === undefined) {
      return [
        `${block.id}.realEscape が無い: habitat "${habitat}" は非可算（ℝ/ℂ）へ脱出しているので、` +
          "どこで・なぜ脱出したかを必ず書く（README「量の住処を宣言する」）。",
      ];
    }
    if (typeof realEscape !== "string" || realEscape.trim() === "") {
      return [`${block.id}.realEscape が空: 脱出箇所を具体的に書く`];
    }
    return [];
  }
  if (realEscape !== undefined) {
    return [
      `${block.id}.realEscape は habitat "${habitat}"（可算側）では書けない: ` +
        'ℝ/ℂ を使ったなら habitat を "R" / "C" / "mixed" にする。使っていないなら realEscape を消す。',
    ];
  }
  return [];
};

/** ブロックが見出しか。`ConvertedBlock` の narrowing に使う。 */
export const isHeading = (block: ConvertedBlock): block is HeadingBlock => block.kind === "heading";

/** システムの `Block` として扱いたい場面（生成器・共通処理）のための別名。 */
export type AnyBlock = Block<Label, ProjectMeta>;
