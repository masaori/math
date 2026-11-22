// compare.ts の欄 lean の誤りの行と、欄の無いブロックの行が、誤りを入れた入力で確かに出ること、
// および証明の依存のたどり方（欄の宣言で止まる、欄に無い具体版の定理の中へ進む、具体版でない宣言はたどらない）のテスト。check.sh が compare.ts の前に走らせる。
//
// 使い方: node negative-test.ts
// 本文の代わりに一時ディレクトリへブロックの列を書き、Lean の書き出しの代わりに lean.tsv を書いて compare.ts を走らせる。
import { execFileSync } from "node:child_process";
import { mkdtempSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const work = mkdtempSync(join(tmpdir(), "one-to-one-negative-"));
try {
  const content = join(work, "content");
  execFileSync("mkdir", [content]);
  const blocks = [
    // 二つのブロックの欄に同じ宣言 Ising2D.shared。
    { id: "a", kind: "claim", labels: ["block_a_label"], statement: [], lean: ["Ising2D.shared"] },
    { id: "b", kind: "claim", labels: ["block_b_label"], statement: [], lean: ["Ising2D.shared"] },
    // 具体版でない宣言と、環境に無い宣言。
    { id: "c", kind: "claim", labels: ["block_c_label"], statement: [], lean: ["Ising2D.NecSuf.x", "Ising2D.missing"] },
    // 欄の宣言の docstring が block_e_label を指す。docstring が block_d_label を指すのに欄に無い宣言 Ising2D.forgotten がある。
    { id: "d", kind: "claim", labels: ["block_d_label"], statement: [], lean: ["Ising2D.conflicting"] },
    { id: "e", kind: "claim", labels: ["block_e_label"], statement: [] },
    // たどり方: f は本文で g を引く。f の具体版は、本文に無いラベルを docstring が指す補題 helper を経て g と i を使い、
    // 必要十分版 NecSuf.y を経て h を使う。
    { id: "f", kind: "claim", labels: ["block_f_label"], proof: [{ type: "ref", target: "block_g_label" }], lean: ["Ising2D.fMain"] },
    { id: "g", kind: "claim", labels: ["block_g_label"], statement: [], lean: ["Ising2D.gMain"] },
    { id: "h", kind: "claim", labels: ["block_h_label"], statement: [], lean: ["Ising2D.hMain"] },
    { id: "i", kind: "claim", labels: ["block_i_label"], statement: [], lean: ["Ising2D.iMain"] },
  ];
  writeFileSync(join(content, "blocks.ts"), `export default ${JSON.stringify(blocks)};\n`);
  const tsv = [
    ["DECL", "Ising2D.shared", "Ising2D.M", "theorem", "1", ""],
    ["DECL", "Ising2D.NecSuf.x", "Ising2D.NecSuf.M", "theorem", "0", ""],
    ["DECL", "Ising2D.conflicting", "Ising2D.M", "theorem", "1", "人手 `block_e_label`"],
    ["DECL", "Ising2D.forgotten", "Ising2D.M", "theorem", "1", "人手 `block_d_label`"],
    // 欄の無いブロック block_e_label を docstring が指し、どの欄にも無い宣言。
    ["DECL", "Ising2D.forgottenNoField", "Ising2D.M", "theorem", "1", "人手 `block_e_label`"],
    ["DECL", "Ising2D.fMain", "Ising2D.M", "theorem", "1", ""],
    ["DECL", "Ising2D.gMain", "Ising2D.M", "theorem", "1", ""],
    ["DECL", "Ising2D.hMain", "Ising2D.M", "theorem", "1", ""],
    ["DECL", "Ising2D.iMain", "Ising2D.M", "theorem", "1", ""],
    ["DECL", "Ising2D.helper", "Ising2D.M", "theorem", "1", "人手 `some_unknown_label`"],
    ["DECL", "Ising2D.NecSuf.y", "Ising2D.NecSuf.M", "theorem", "0", ""],
    ["USES", "Ising2D.fMain", "Ising2D.helper"],
    ["USES", "Ising2D.fMain", "Ising2D.NecSuf.y"],
    ["USES", "Ising2D.helper", "Ising2D.gMain"],
    ["USES", "Ising2D.helper", "Ising2D.iMain"],
    ["USES", "Ising2D.NecSuf.y", "Ising2D.hMain"],
  ].map((r) => r.join("\t")).join("\n") + "\n";
  writeFileSync(join(work, "lean.tsv"), tsv);
  const out = execFileSync("node", [join(here, "compare.ts"), join(work, "lean.tsv"), content, join(work, "counts.tsv")], {
    encoding: "utf8",
  });
  const expected = [
    "LEAN_FIELD_SHARED_DECLARATION\tIsing2D.shared\tblock_a_label",
    "LEAN_FIELD_SHARED_DECLARATION\tIsing2D.shared\tblock_b_label",
    "LEAN_FIELD_NOT_CONCRETE_DECLARATION\tblock_c_label\tIsing2D.NecSuf.x",
    "LEAN_FIELD_NOT_CONCRETE_DECLARATION\tblock_c_label\tIsing2D.missing",
    "LEAN_FIELD_DOCSTRING_CONFLICT\tIsing2D.conflicting\tblock_e_label",
    "LEAN_FIELD_MISSING_DECLARATION\tblock_d_label\tIsing2D.forgotten",
    "LEAN_FIELD_MISSING_DECLARATION\tblock_e_label\tIsing2D.forgottenNoField",
    // 対応は欄だけで決まるので、docstring が指していても欄の無い e には具体版の宣言が無い。
    "NO_CONCRETE_DECLARATION\tblock_e_label",
    "UNKNOWN_LABEL_IN_DOCSTRING\tIsing2D.helper\tsome_unknown_label",
    // 本文に無いラベルを指す補題の中へ進み、その先の i の欄の宣言で止まって i を使ったと数える。
    "USED_ONLY_IN_LEAN\tblock_f_label\tblock_i_label",
  ];
  // 同じ補題を経た g は使ったと数え、必要十分版を経た h は数えない。
  const unexpected = ["CITED_ONLY_IN_TEXT\tblock_f_label\tblock_g_label", "USED_ONLY_IN_LEAN\tblock_f_label\tblock_h_label"];
  const lines = new Set(out.split("\n"));
  const missing = expected.filter((e) => !lines.has(e));
  if (missing.length > 0) {
    console.error("NG: compare.ts が誤りを入れた入力で次の行を出さなかった:");
    for (const m of missing) console.error(m);
    process.exit(1);
  }
  const extra = unexpected.filter((e) => lines.has(e));
  if (extra.length > 0) {
    console.error("NG: compare.ts がたどり方の規則に反する次の行を出した:");
    for (const m of extra) console.error(m);
    process.exit(1);
  }
  console.log(`OK: compare.ts の負のテスト ${expected.length} 件と、出てはならない行 ${unexpected.length} 件`);
} finally {
  rmSync(work, { recursive: true, force: true });
}
