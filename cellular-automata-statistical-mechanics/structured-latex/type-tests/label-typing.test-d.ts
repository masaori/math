/**
 * 型の契約テスト（実行はしない。`tsc --noEmit` で検査される）。
 *
 * `@ts-expect-error` は「この行は型エラーになるはず」の宣言なので、
 * 型が緩くなってエラーが出なくなったら型検査そのものが落ちる。
 * すなわちこのファイルは「参照の誤りと住処の宣言漏れがコンパイル時に検出され続けること」の
 * 回帰テストである。
 *
 * 入力言語そのものの検査（見出しに本文、level の範囲、`proof` の打ち間違い、
 * ノートの targets が空 ほか）はシステム側の `tools/negative-type-test.ts` が持つ。
 * ここに残すのは、このプロジェクトでしか確かめられない 2 つだけである:
 *
 *   1. `Label`（このプロジェクトの content から生成した実在ラベルのユニオン）への束縛
 *   2. 住処 `habitat` と脱出 `realEscape` の対応
 */

// 生成した集約モジュールを型として引き込む。tsconfig の include から
// document.generated.ts が落ちても、この import 経由で検査対象に残る。
import type { _UniqueBlockIds } from "../document.generated.ts";
import { defineBlocks, defineNotes, math, paragraph, ref } from "../schema.ts";
import type { ConvertedBlock, Note } from "../schema.ts";

export type _AggregatedDocumentIsChecked = _UniqueBlockIds;

// --- ref: 実在ラベルへの束縛 --------------------------------------------------

// 実在ラベルは通る。
const okRef = ref("def_essential_dependency");
void okRef;

// @ts-expect-error 存在しないラベルへの参照はコンパイル時に落ちる。
void ref("def_essential_dependency_typo");

// @ts-expect-error 空文字も当然ラベルではない。
void ref("");

// ラベルは文字列型一般では代用できない（型の緩みを防ぐ）。
declare const someString: string;
// @ts-expect-error string は Label へ代入できない。
void ref(someString);

// --- ブロックの labels: 生成物の再生成漏れを検出する --------------------------

const okBlock: ConvertedBlock = {
  id: "type_test_block",
  kind: "claim",
  labels: ["def_essential_dependency"],
  habitat: "Z",
  statement: [paragraph(["ラベルは生成済みユニオンの値のみ。", math("x")])],
};
void okBlock;

const blockWithUnknownLabel: ConvertedBlock = {
  id: "type_test_block_unknown_label",
  kind: "claim",
  // @ts-expect-error 生成済みユニオンに無いラベルは書けない（＝再生成漏れを検出する）。
  labels: ["not_a_real_label"],
  habitat: "N",
  statement: [],
};
void blockWithUnknownLabel;

// --- ノートの targets: 実在ラベルへの束縛 ------------------------------------

const okNote: Note = {
  id: "note_type_test_ok",
  targets: ["def_essential_dependency"],
  body: [paragraph(["参照用ノート。"])],
};
void okNote;

const noteWithUnknownTarget: Note = {
  id: "note_type_test_unknown",
  // @ts-expect-error 存在しないラベルには紐づけられない。
  targets: ["def_essential_dependency_typo"],
  body: [],
};
void noteWithUnknownTarget;

// --- 住処（habitat）と脱出（realEscape）--------------------------------------

void defineBlocks([
  {
    id: "type_test_habitat_value",
    kind: "claim",
    labels: [],
    // @ts-expect-error 住処は宣言済みの値のみ（"countable" のような自由語は書けない）。
    habitat: "countable",
    statement: [],
  },
]);

void defineBlocks([
  // @ts-expect-error 本文ブロックは住処の宣言が必須（habitat が無いと ConvertedBlock にならない）。
  {
    id: "type_test_habitat_missing",
    kind: "claim",
    labels: [],
    statement: [],
    verification: ["sagemath/check/essential-dependency-support"],
  },
]);

void defineBlocks([
  // @ts-expect-error 非可算な住処は realEscape が必須。
  {
    id: "type_test_escape_missing",
    kind: "claim",
    labels: [],
    habitat: "R",
    statement: [],
  },
]);

void defineBlocks([
  {
    id: "type_test_escape_forbidden",
    kind: "claim",
    labels: [],
    habitat: "Lambda",
    // @ts-expect-error 可算な住処に realEscape は書けない。
    realEscape: "書いてはいけない",
    statement: [],
  },
]);

// 非可算な住処に理由を添えたものは通る（対照）。
void defineBlocks([
  {
    id: "type_test_escape_ok",
    kind: "claim",
    labels: [],
    habitat: "mixed",
    realEscape: "熱力学極限 L→∞ の存在を示すために単調有界収束を使う",
    statement: [],
  },
]);

// 見出しは住処を受け取らない（見出しは量を扱わない）。
void defineBlocks([
  {
    id: "type_test_heading_meta",
    kind: "heading",
    level: 2,
    title: { text: "見出し" },
    labels: [],
    // @ts-expect-error 見出しに habitat は書けない。
    habitat: "N",
  },
]);

// --- 定義ヘルパの受け口 ------------------------------------------------------

void defineBlocks([okBlock]);
void defineNotes([okNote]);
