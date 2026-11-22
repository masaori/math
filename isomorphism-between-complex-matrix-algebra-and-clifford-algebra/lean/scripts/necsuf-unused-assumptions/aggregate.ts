// Audit.lean の書き出しを本文のラベルごとにまとめ、証明で使わない仮定を持つ主張を並べる。
// 一つの主張が複数の宣言に分かれているときは、どれか一つの宣言が使えば使っているとする。
// 構造体の仮定を欄に分けずにそのまま使う宣言では、その仮定の欄は全て使っているとする。
// 代数の準同型の「線型写像が和を保つ」と「環の準同型が和を保つ」は同じ性質なので、片方を使えば両方を使っているとする。
import { readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";

const dir = join(process.argv[2] ?? ".", ".lake/necsuf-unused-assumptions");
const rows = (file: string): string[][] =>
  readFileSync(join(dir, file), "utf8").split("\n").filter((l) => l !== "").map((l) => l.split("\t"));

// 定義（def_）のラベルの定理は、定義から欄を取り出すだけの補題なので除く。
const labelOf = new Map<string, string>();
for (const [decl, label] of rows("labelled.tsv")) {
  if (!label.startsWith("def_")) labelOf.set(decl, label);
}
const whole = new Set(rows("wholesale.tsv").filter((r) => r[2] === "whole").map((r) => `${r[0]}\t${r[1]}`));

const assumed = new Map<string, Set<string>>();
const used = new Map<string, Set<string>>();
const homomorphism = new Set<string>();
const add = (m: Map<string, Set<string>>, k: string, v: string) => {
  if (!m.has(k)) m.set(k, new Set());
  m.get(k)!.add(v);
};
for (const [decl, arg, struct, leaf, status] of rows("fields.tsv")) {
  const label = labelOf.get(decl);
  if (label === undefined) continue;
  const kind = struct.endsWith("Laws") ? "K の法則" : "前提";
  const name = `${kind}\t${leaf.split(".").slice(-2).join(".")}`;
  if (struct.endsWith("IsAlgebraHomomorphism")) homomorphism.add(label);
  add(assumed, label, name);
  if (status === "used" || whole.has(`${decl}\t${arg}`)) add(used, label, name);
}

const unused = new Map<string, string[]>();
for (const [label, names] of assumed) {
  const u = used.get(label) ?? new Set<string>();
  const sameAddition = ["前提\tIsLinearMap.map_add", "前提\tIsRingHomomorphism.map_add"];
  const rest = [...names].filter((n) => {
    if (u.has(n)) return false;
    if (homomorphism.has(label) && sameAddition.includes(n)) return !sameAddition.some((s) => u.has(s));
    return true;
  });
  if (rest.length > 0) unused.set(label, rest);
}
for (const [decl, kind, , arg, status] of rows("hyps.tsv")) {
  const label = labelOf.get(decl);
  if (label === undefined || kind !== "thm" || status !== "unused") continue;
  unused.set(label, [...(unused.get(label) ?? []), `仮定ごと\t${arg}`]);
}

const lines: string[] = [];
for (const label of [...unused.keys()].sort()) {
  for (const n of unused.get(label)!) lines.push(`${label}\t${n}`);
}
writeFileSync(join(dir, "report.tsv"), lines.join("\n") + "\n");
const labels = new Set(labelOf.values());
const count = (k: string) => [...unused.values()].filter((ns) => ns.some((n) => n.startsWith(k))).length;
console.log(`本文の主張・定理: ${labels.size} 件`);
console.log(`証明で使わない仮定を持つ主張: ${unused.size} 件（K の法則 ${count("K の法則")}、前提 ${count("前提")}、仮定ごと ${count("仮定ごと")}）`);
console.log(`一覧: ${join(dir, "report.tsv")}`);
