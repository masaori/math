// compare.ts の欄 lean の誤りの行が、誤りを入れた入力で確かに出ることのテスト。check.sh が compare.ts の前に走らせる。
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
  ];
  writeFileSync(join(content, "blocks.ts"), `export default ${JSON.stringify(blocks)};\n`);
  const tsv = [
    ["DECL", "Ising2D.shared", "Ising2D.M", "theorem", "1", ""],
    ["DECL", "Ising2D.NecSuf.x", "Ising2D.NecSuf.M", "theorem", "0", ""],
    ["DECL", "Ising2D.conflicting", "Ising2D.M", "theorem", "1", "人手 `block_e_label`"],
    ["DECL", "Ising2D.forgotten", "Ising2D.M", "theorem", "1", "人手 `block_d_label`"],
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
    // e の docstring の宣言は欄で d へ移るので、e には具体版の宣言が残らない。
    "NO_CONCRETE_DECLARATION\tblock_e_label",
  ];
  const lines = new Set(out.split("\n"));
  const missing = expected.filter((e) => !lines.has(e));
  if (missing.length > 0) {
    console.error("NG: compare.ts が誤りを入れた入力で次の行を出さなかった:");
    for (const m of missing) console.error(m);
    process.exit(1);
  }
  console.log(`OK: compare.ts の欄 lean の負のテスト ${expected.length} 件`);
} finally {
  rmSync(work, { recursive: true, force: true });
}
