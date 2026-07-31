/**
 * 型の契約テスト（実行はしない。`tsc --noEmit` で検査される）。
 *
 * `@ts-expect-error` は「この行は型エラーになるはず」の宣言なので、
 * **型が緩くなってエラーが出なくなったら型検査そのものが落ちる**。
 * すなわちこのファイルは「参照の誤りがコンパイル時に検出され続けること」の回帰テストである。
 *
 * **入力言語そのものの検査（見出しに本文、level の範囲、タイトルの空、`proof` の打ち間違い、
 * ノートの targets が空 ほか）はシステム側の `tools/negative-type-test.ts` が持つ。**
 * ここに残すのは、このプロジェクトでしか確かめられない 2 つだけである:
 *
 *   1. `Label`（このプロジェクトの content から生成した実在ラベルのユニオン）への束縛
 *   2. プロジェクト固有メタデータ `conversion`（Typst 原本からの移行の状態）
 */

// 生成した集約モジュールを**型として引き込む**。tsconfig の include から
// document.generated.ts が落ちても、この import 経由で検査対象に残る
// （include 漏れでファイル跨ぎの検査が無音で消えた事故があるため）。
import type { _UniqueBlockIds } from "../document.generated.ts";
import { defineBlocks, defineNotes, math, paragraph, ref } from "../schema.ts";
import type { ConvertedBlock, Note } from "../schema.ts";

export type _AggregatedDocumentIsChecked = _UniqueBlockIds;

// --- ref: 実在ラベルへの束縛 --------------------------------------------------

// 実在ラベルは通る。
const okRef = ref("def_kronecker");
void okRef;

// @ts-expect-error 存在しないラベルへの参照はコンパイル時に落ちる。
void ref("def_kronecker_typo");

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
  origin: { path: "type-tests/label-typing.test-d.ts", ordinal: 1 },
  labels: ["def_kronecker"],
  statement: [paragraph(["ラベルは生成済みユニオンの値のみ。", math("x")])],
  conversion: { status: "added" },
};
void okBlock;

const blockWithUnknownLabel: ConvertedBlock = {
  id: "type_test_block_unknown_label",
  kind: "claim",
  // @ts-expect-error 生成済みユニオンに無いラベルは書けない（＝再生成漏れを検出する）。
  labels: ["not_a_real_label"],
  statement: [],
};
void blockWithUnknownLabel;

// --- ノートの targets: 実在ラベルへの束縛 ------------------------------------

const okNote: Note = {
  id: "note_type_test_ok",
  targets: ["def_kronecker"],
  body: [paragraph(["参照用ノート。"])],
};
void okNote;

const noteWithUnknownTarget: Note = {
  id: "note_type_test_unknown",
  // @ts-expect-error 存在しないラベルには紐づけられない。
  targets: ["def_kronecker_typo"],
  body: [],
};
void noteWithUnknownTarget;

// --- プロジェクト固有メタデータ（conversion） --------------------------------

void defineBlocks([
  {
    id: "type_test_status",
    kind: "claim",
    labels: [],
    statement: [],
    // @ts-expect-error status は converted か added のみ。
    conversion: { status: "convertd" },
  },
]);

void defineBlocks([
  {
    id: "type_test_conversion_notes",
    kind: "claim",
    labels: [],
    statement: [],
    // @ts-expect-error conversion.notes は文字列の配列（文字列を直接は書けない）。
    conversion: { status: "added", notes: "一行だけのメモ" },
  },
]);

void defineBlocks([
  {
    id: "type_test_conversion_unknown_key",
    kind: "claim",
    labels: [],
    statement: [],
    // @ts-expect-error conversion の中の打ち間違い（notes → note）。
    conversion: { status: "added", note: ["メモ"] },
  },
]);

// 見出しはメタデータを受け取らない（システムの HeadingBlock は M を持たない）。
// 移行時、見出しの conversion は origin.path から復元できることを確認したうえで落としてある。
void defineBlocks([
  {
    id: "type_test_heading_meta",
    kind: "heading",
    level: 2,
    title: { text: "見出し" },
    labels: [],
    // @ts-expect-error 見出しに conversion は書けない。
    conversion: { status: "added" },
  },
]);

// --- 定義ヘルパの受け口 ------------------------------------------------------

void defineBlocks([okBlock]);
void defineNotes([okNote]);
