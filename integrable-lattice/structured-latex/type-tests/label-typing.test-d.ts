/**
 * 型の契約テスト（実行はしない。`tsc --noEmit` で検査される）。
 *
 * `@ts-expect-error` は「この行は型エラーになるはず」の宣言なので、
 * **型が緩くなってエラーが出なくなったら型検査そのものが落ちる**。
 * すなわちこのファイルは「誤った書き方がコンパイル時に検出され続けること」の回帰テストである。
 *
 * 入力言語一般の型検査（ラベル解決・一意性・kind ごとのフィールド・タイトル・targets）は
 * **システム側の型テストが持つ**ので、ここには重複して置かない。ここに残すのは
 * **本プロジェクト固有メタデータの型強制**、すなわち
 *   - 本文ブロックは `habitat` を必ず宣言する
 *   - `habitat` が可算側なら `realEscape` を書けない／非可算側なら必須（判別共用体）
 *   - 見出しブロックは固有メタデータ（habitat / realEscape / verification / lean）を持てない
 *   - `verification` / `lean` は文字列の配列
 * と、**具体化が実際に効いていること**（生成済みラベルのユニオンで束縛されていること）だけである。
 */

// 生成した集約モジュールを**型として引き込む**。tsconfig の include から
// document.generated.ts が落ちても、この import 経由で検査対象に残る。
import type { _UniqueBlockIds } from "../document.generated.ts";
import { paragraph, ref } from "../schema.ts";
import type { ConvertedBlock, Note } from "../schema.ts";

export type _AggregatedDocumentIsChecked = _UniqueBlockIds;

// --- 具体化が効いていること（ラベルのユニオンで束縛されている）-----------------

// 実在ラベルは通る。
void ref("paper_def_curve");

// @ts-expect-error 存在しないラベルへの参照はコンパイル時に落ちる。
void ref("paper_def_curve_typo");

// ラベルは文字列型一般では代用できない（型の緩みを防ぐ）。
declare const someString: string;
// @ts-expect-error string は Label へ代入できない。
void ref(someString);

const noteWithUnknownTarget: Note = {
  id: "note_type_test_unknown",
  // @ts-expect-error 存在しないラベルには紐づけられない。
  targets: ["paper_def_curve_typo"],
  body: [],
};
void noteWithUnknownTarget;

// --- 本プロジェクト固有: 可算／非可算の分別と ℝ 脱出の明示 --------------------

// 正しい書き方（対照）: 可算側は住処だけを書く。
const countableOk: ConvertedBlock = {
  id: "type_test_countable_ok",
  kind: "claim",
  origin: { path: "type-tests/label-typing.test-d.ts", ordinal: 1 },
  labels: [],
  habitat: "Lambda",
  statement: [paragraph(["Λ の言葉だけで書いたブロック。"])],
};
void countableOk;

// 可算側（ℤ）を宣言したブロックは realEscape を書けない。
const countableWithEscape: ConvertedBlock = {
  id: "type_test_countable_escape",
  kind: "claim",
  origin: { path: "type-tests/label-typing.test-d.ts", ordinal: 2 },
  labels: [],
  habitat: "Z",
  // @ts-expect-error 可算 habitat に realEscape は書けない（`never` なので値を入れられない）。
  realEscape: "ここで ℝ を使った",
  statement: [],
};
void countableWithEscape;

// 非可算側を宣言したら realEscape が必須。
// @ts-expect-error 非可算 habitat には realEscape が要る。
const escapingWithoutReason: ConvertedBlock = {
  id: "type_test_escaping_without_reason",
  kind: "claim",
  origin: { path: "type-tests/label-typing.test-d.ts", ordinal: 3 },
  labels: [],
  habitat: "R",
  statement: [],
};
void escapingWithoutReason;

// 正しい書き方（対照）: 脱出を宣言し、その理由を書く。
const escapingOk: ConvertedBlock = {
  id: "type_test_escaping_ok",
  kind: "claim",
  origin: { path: "type-tests/label-typing.test-d.ts", ordinal: 4 },
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
  origin: { path: "type-tests/label-typing.test-d.ts", ordinal: 5 },
  labels: [],
  statement: [],
};
void blockWithoutHabitat;

const blockWithUnknownHabitat: ConvertedBlock = {
  id: "type_test_unknown_habitat",
  kind: "claim",
  origin: { path: "type-tests/label-typing.test-d.ts", ordinal: 6 },
  labels: [],
  // @ts-expect-error 住処の綴り違いは型で落ちる。
  habitat: "Lamda",
  statement: [],
};
void blockWithUnknownHabitat;

// 見出しは量を扱わないので固有メタデータを持てない。
const headingWithHabitat: ConvertedBlock = {
  id: "type_test_heading_habitat",
  kind: "heading",
  level: 2,
  origin: { path: "type-tests/label-typing.test-d.ts", ordinal: 7 },
  title: { text: "見出し" },
  labels: [],
  // @ts-expect-error 見出しに habitat は書けない。
  habitat: "Lambda",
};
void headingWithHabitat;

const headingWithVerification: ConvertedBlock = {
  id: "type_test_heading_verification",
  kind: "heading",
  level: 2,
  origin: { path: "type-tests/label-typing.test-d.ts", ordinal: 8 },
  title: { text: "見出し" },
  labels: [],
  // @ts-expect-error 見出しに verification は書けない。
  verification: ["sagemath/check/cycle15_T3_tau_d3"],
};
void headingWithVerification;

const blockWithBadVerification: ConvertedBlock = {
  id: "type_test_verification",
  kind: "claim",
  origin: { path: "type-tests/label-typing.test-d.ts", ordinal: 9 },
  labels: [],
  habitat: "Qbar",
  // @ts-expect-error verification は文字列の配列（単一の文字列ではない）。
  verification: "sagemath/check/cycle15_T3_tau_d3",
  statement: [],
};
void blockWithBadVerification;

const blockWithBadLean: ConvertedBlock = {
  id: "type_test_lean",
  kind: "claim",
  origin: { path: "type-tests/label-typing.test-d.ts", ordinal: 10 },
  labels: [],
  habitat: "Qbar",
  // @ts-expect-error lean は文字列の配列。
  lean: "IntegrableLattice.Scaffold.example",
  statement: [],
};
void blockWithBadLean;
