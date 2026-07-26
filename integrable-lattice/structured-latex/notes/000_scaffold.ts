/**
 * 参照用ノートの足場。**出版物には載らない**（最終成果物は content/ だけから生成する）。
 *
 * ノート機構（ラベルでの紐づけ・targets の解決検査）が動くことを示すための最小例。
 */

import { defineNotes, paragraph } from "../schema.ts";

export default defineNotes([
  {
    id: "note_scaffold_001_definition_placeholder_usage",
    targets: ["scaffold_def_placeholder"],
    title: { text: "ノート機構の足場" },
    body: [
      paragraph([
        "ノートは content 側の実在ラベルへ必ず解決できなければならない（型と実行時の両方で検査される）。",
        "補足計算・具体例・原文由来のメモ・物理的解釈など、",
        "「正しさには不要だが、動機や背景を書くときに参照したい素材」をここへ置く。",
        "正しさに必要な事柄は notes ではなく content 側の statement / proof に書く。",
      ]),
    ],
  },
]);
