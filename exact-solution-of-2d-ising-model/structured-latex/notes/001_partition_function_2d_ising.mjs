import { defineNotes, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

// 章「2次元ising模型の分配関数」に紐づく参照用ノート。文書本体ではない。

export default defineNotes([
  {
    id: "note_partition_function_2d_ising_002_physical_reading",
    targets: ["def_partition_function_2d_ising"],
    title: { text: "記号の物理的な読み方（状態と状態全体の集合）" },
    sourcePath: "_old/typst/parts/001_2次元ising模型の分配関数/001_definition_2次元ising模型の分配関数.typ",
    body: [
      paragraph(["", math(String.raw`s`), " は格子の状態（スピンの配置）を表している。"]),
      paragraph([math(String.raw`\mathfrak{S}`), " は全ての状態の集合である。"]),
    ],
  },
  {
    id: "note_partition_function_2d_ising_003_physical_reading",
    targets: ["def_transfer_matrix"],
    title: { text: "転送行列の物理的な読み方（行内・行間の相互作用）" },
    sourcePath: "_old/typst/parts/001_2次元ising模型の分配関数/002_definition_転送行列.typ",
    body: [
      paragraph([math(String.raw`V_1`), " は格子のある行内の横の相互作用を表している。"]),
      paragraph([math(String.raw`V_2`), " はそれを縦に積み上げた時の隣り合う行同士の相互作用を表している。"]),
      paragraph([math(String.raw`V_1`), " は対角行列になっている。"]),
    ],
  },
]);
