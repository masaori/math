/**
 * 型の契約テスト（実行はしない。`tsc --noEmit` で検査される）。
 *
 * `@ts-expect-error` は「この行は型エラーになるはず」の宣言なので、
 * **型が緩くなってエラーが出なくなったら型検査そのものが落ちる**。
 * すなわちこのファイルは「誤った書き方がコンパイル時に検出され続けること」の回帰テストである。
 *
 * ここで使う実在ラベルは content/ に存在するもの（labels.generated.ts のユニオン）。
 */

// 生成した集約モジュールを**型として引き込む**。tsconfig の include から
// document.generated.ts が落ちても、この import 経由で検査対象に残る。
import type { _UniqueBlockIds } from "../document.generated.ts";
import { defineBlocks, defineNotes, math, paragraph, ref } from "../schema.ts";

export type _AggregatedDocumentIsChecked = _UniqueBlockIds;
import type { ConvertedBlock, Note } from "../schema.ts";

// --- ref -------------------------------------------------------------------

// 実在ラベルは通る。
const okRef = ref("scaffold_def_placeholder");
void okRef;

// @ts-expect-error 存在しないラベルへの参照はコンパイル時に落ちる。
void ref("scaffold_def_placeholder_typo");

// @ts-expect-error 空文字も当然ラベルではない。
void ref("");

// ラベルは文字列型一般では代用できない（型の緩みを防ぐ）。
declare const someString: string;
// @ts-expect-error string は Label へ代入できない。
void ref(someString);

// --- ブロックの labels -------------------------------------------------------

const okBlock: ConvertedBlock = {
  id: "type_test_block",
  kind: "claim",
  sourcePath: "type-tests/label-typing.test-d.ts",
  sourceOrdinal: 1,
  labels: ["scaffold_def_placeholder"],
  habitat: "Lambda",
  statement: [paragraph(["ラベルは生成済みユニオンの値のみ。", math("x")])],
};
void okBlock;

const blockWithUnknownLabel: ConvertedBlock = {
  id: "type_test_block_unknown_label",
  kind: "claim",
  sourcePath: "type-tests/label-typing.test-d.ts",
  sourceOrdinal: 2,
  // @ts-expect-error 生成済みユニオンに無いラベルは書けない（＝再生成漏れを検出する）。
  labels: ["not_a_real_label"],
  habitat: "Lambda",
  statement: [],
};
void blockWithUnknownLabel;

// --- kind ごとに許されるフィールド ------------------------------------------

// @ts-expect-error 見出しは本文（statement）を持たない。
const headingWithBody: ConvertedBlock = {
  id: "type_test_heading",
  kind: "heading",
  level: 2,
  sourcePath: "type-tests/label-typing.test-d.ts",
  sourceOrdinal: 3,
  title: { text: "見出し" },
  labels: [],
  statement: [paragraph(["本文"])],
};
void headingWithBody;

const blockWithNotes: ConvertedBlock = {
  id: "type_test_notes",
  kind: "remark",
  sourcePath: "type-tests/label-typing.test-d.ts",
  sourceOrdinal: 4,
  labels: [],
  habitat: "none",
  statement: [],
  // @ts-expect-error 本文ブロックは注記欄を持てない（注記は notes/ へ）。
  notes: [paragraph(["注記"])],
};
void blockWithNotes;

// フィールド名の打ち間違いは余剰プロパティ検査で落ちる。
// （ここが素通りすると `proof` が捨てられ、証明が正本から黙って消える。）
void defineBlocks([
  {
    id: "type_test_typo_field",
    kind: "claim",
    sourcePath: "type-tests/label-typing.test-d.ts",
    sourceOrdinal: 5,
    labels: [],
    habitat: "Lambda",
    statement: [],
    // @ts-expect-error `proof` の打ち間違い。
    proofs: [paragraph(["証明のつもり"])],
  },
]);

// --- 本プロジェクト固有: 可算／非可算の分別と ℝ 脱出の明示 --------------------

// 可算側（Λ）を宣言したブロックは realEscape を書けない。
// @ts-expect-error 可算 habitat に realEscape は書けない。
const countableWithEscape: ConvertedBlock = {
  id: "type_test_countable_escape",
  kind: "claim",
  sourcePath: "type-tests/label-typing.test-d.ts",
  sourceOrdinal: 11,
  labels: [],
  habitat: "Z",
  realEscape: "ここで ℝ を使った",
  statement: [],
};
void countableWithEscape;

// 非可算側を宣言したら realEscape が必須。
// @ts-expect-error 非可算 habitat には realEscape が要る。
const escapingWithoutReason: ConvertedBlock = {
  id: "type_test_escaping_without_reason",
  kind: "claim",
  sourcePath: "type-tests/label-typing.test-d.ts",
  sourceOrdinal: 12,
  labels: [],
  habitat: "R",
  statement: [],
};
void escapingWithoutReason;

// 正しい書き方（対照）: 脱出を宣言し、その理由を書く。
const escapingOk: ConvertedBlock = {
  id: "type_test_escaping_ok",
  kind: "claim",
  sourcePath: "type-tests/label-typing.test-d.ts",
  sourceOrdinal: 13,
  labels: [],
  habitat: "mixed",
  realEscape: "指数評価の一点でのみ実数の順序完備性を使う",
  verification: ["sagemath/check/cycle15_T3_tau_d3"],
  lean: ["IntegrableLattice.Scaffold.example"],
  statement: [],
};
void escapingOk;

// habitat は必須（本文ブロックが住処を宣言しないことは許さない）。
// @ts-expect-error habitat が無い。
const blockWithoutHabitat: ConvertedBlock = {
  id: "type_test_no_habitat",
  kind: "claim",
  sourcePath: "type-tests/label-typing.test-d.ts",
  sourceOrdinal: 14,
  labels: [],
  statement: [],
};
void blockWithoutHabitat;

const blockWithUnknownHabitat: ConvertedBlock = {
  id: "type_test_unknown_habitat",
  kind: "claim",
  sourcePath: "type-tests/label-typing.test-d.ts",
  sourceOrdinal: 15,
  labels: [],
  // @ts-expect-error 住処の綴り違いは型で落ちる。
  habitat: "Lamda",
  statement: [],
};
void blockWithUnknownHabitat;

// 見出しは量を扱わないので habitat を持てない。
const headingWithHabitat: ConvertedBlock = {
  id: "type_test_heading_habitat",
  kind: "heading",
  level: 2,
  sourcePath: "type-tests/label-typing.test-d.ts",
  sourceOrdinal: 16,
  title: { text: "見出し" },
  labels: [],
  // @ts-expect-error 見出しに habitat は書けない。
  habitat: "Lambda",
};
void headingWithHabitat;

const blockWithBadVerification: ConvertedBlock = {
  id: "type_test_verification",
  kind: "claim",
  sourcePath: "type-tests/label-typing.test-d.ts",
  sourceOrdinal: 17,
  labels: [],
  habitat: "Qbar",
  // @ts-expect-error verification は文字列の配列（単一の文字列ではない）。
  verification: "sagemath/check/cycle15_T3_tau_d3",
  statement: [],
};
void blockWithBadVerification;

// --- ノートの targets --------------------------------------------------------

const okNote: Note = {
  id: "note_type_test_ok",
  targets: ["scaffold_def_placeholder"],
  body: [paragraph(["参照用ノート。"])],
};
void okNote;

const noteWithUnknownTarget: Note = {
  id: "note_type_test_unknown",
  // @ts-expect-error 存在しないラベルには紐づけられない。
  targets: ["scaffold_def_placeholder_typo"],
  body: [],
};
void noteWithUnknownTarget;

void defineNotes([
  {
    id: "note_type_test_typo",
    targets: ["scaffold_def_placeholder"],
    // @ts-expect-error `body` の打ち間違い。
    bodyy: [paragraph(["本文のつもり"])],
    body: [],
  },
]);

const noteWithEmptyTargets: Note = {
  id: "note_type_test_empty",
  // @ts-expect-error ノートは必ず 1 件以上のラベルに紐づく（空配列は型で落ちる）。
  targets: [],
  body: [],
};
void noteWithEmptyTargets;

// --- 一意性・値域 ------------------------------------------------------------

// 同一ファイル内での id 重複は型で落ちる（ファイル跨ぎは document.generated.ts が見る）。
// @ts-expect-error id が重複している。
void defineBlocks([
  {
    id: "type_test_dup",
    kind: "claim",
    sourcePath: "type-tests/label-typing.test-d.ts",
    sourceOrdinal: 6,
    labels: [],
    habitat: "Lambda",
    statement: [],
  },
  {
    id: "type_test_dup",
    kind: "claim",
    sourcePath: "type-tests/label-typing.test-d.ts",
    sourceOrdinal: 7,
    labels: [],
    habitat: "Lambda",
    statement: [],
  },
]);

const headingWithBadLevel: ConvertedBlock = {
  id: "type_test_level_range",
  kind: "heading",
  // @ts-expect-error level は 1〜6 のみ。
  level: 7,
  sourcePath: "type-tests/label-typing.test-d.ts",
  sourceOrdinal: 8,
  title: { text: "見出し" },
  labels: [],
};
void headingWithBadLevel;

const blockWithEmptyTitle: ConvertedBlock = {
  id: "type_test_empty_title",
  kind: "claim",
  sourcePath: "type-tests/label-typing.test-d.ts",
  sourceOrdinal: 9,
  // @ts-expect-error タイトルは text か tex の少なくとも一方が必要。
  title: {},
  labels: [],
  habitat: "Lambda",
  statement: [],
};
void blockWithEmptyTitle;

const blockWithBadStatus: ConvertedBlock = {
  id: "type_test_status",
  kind: "claim",
  sourcePath: "type-tests/label-typing.test-d.ts",
  sourceOrdinal: 10,
  labels: [],
  habitat: "Lambda",
  statement: [],
  // @ts-expect-error status は converted か added のみ。
  conversion: { status: "convertd" },
};
void blockWithBadStatus;

// --- 定義ヘルパの受け口 ------------------------------------------------------

void defineBlocks([okBlock]);
void defineNotes([okNote]);

// @ts-expect-error defineBlocks は配列以外を受け付けない。
void defineBlocks(okBlock);
