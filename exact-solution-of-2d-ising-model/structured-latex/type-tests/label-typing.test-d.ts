/**
 * 型の契約テスト（実行はしない。`tsc --noEmit` で検査される）。
 *
 * `@ts-expect-error` は「この行は型エラーになるはず」の宣言なので、
 * **型が緩くなってエラーが出なくなったら型検査そのものが落ちる**。
 * すなわちこのファイルは「参照の誤りがコンパイル時に検出され続けること」の回帰テストである。
 *
 * ここで使う実在ラベルは content/ に存在するもの（labels.generated.ts のユニオン）。
 */

import { defineBlocks, defineNotes, math, paragraph, ref } from "../schema.ts";
import type { ConvertedBlock, Note } from "../schema.ts";

// --- ref -------------------------------------------------------------------

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

// --- ブロックの labels -------------------------------------------------------

const okBlock: ConvertedBlock = {
  id: "type_test_block",
  kind: "claim",
  sourcePath: "type-tests/label-typing.test-d.ts",
  sourceOrdinal: 1,
  labels: ["def_kronecker"],
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
    statement: [],
    // @ts-expect-error `proof` の打ち間違い。
    proofs: [paragraph(["証明のつもり"])],
  },
]);

// --- ノートの targets --------------------------------------------------------

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

void defineNotes([
  {
    id: "note_type_test_typo",
    targets: ["def_kronecker"],
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

// --- 定義ヘルパの受け口 ------------------------------------------------------

void defineBlocks([okBlock]);
void defineNotes([okNote]);

// @ts-expect-error defineBlocks は配列以外を受け付けない。
void defineBlocks(okBlock);
