// 宣言した一般論の一覧（<プロジェクト>/lean/declared-general-theory.txt）の各行の人手のラベルが、
// 本文（<プロジェクト>/structured-latex/content/*.ts）に在り、そのブロックの主張が「定義せずに用いる」と
// 明示していることを確かめる。check.sh から呼ばれる。
//
// 使い方: node check-declared.ts <宣言の一覧> <本文の content ディレクトリ> <接頭辞の一覧>
import { readFileSync, readdirSync } from "node:fs";
import { join, resolve } from "node:path";

const [declaredPath, contentDir, prefixesPath] = process.argv.slice(2);
const phrase = "定義せずに用いる";

const prefixes = new Set(
  readFileSync(prefixesPath, "utf8").split("\n").map((l) => l.trim()).filter((l) => l && !l.startsWith("#")),
);

function text(node: unknown): string {
  if (node == null) return "";
  if (typeof node === "string") return node;
  if (Array.isArray(node)) return node.map(text).join("");
  if (typeof node === "object") return Object.values(node as Record<string, unknown>).map(text).join("");
  return "";
}

const blocks = new Map<string, unknown>();
for (const f of readdirSync(contentDir).filter((f) => f.endsWith(".ts")).sort()) {
  const mod = await import(resolve(join(contentDir, f)));
  for (const v of Object.values(mod)) {
    if (!Array.isArray(v)) continue;
    for (const b of v as Array<{ labels?: string[]; statement?: unknown }>) {
      for (const l of b?.labels ?? []) blocks.set(l, b.statement);
    }
  }
}

let ng = 0;
for (const line of readFileSync(declaredPath, "utf8").split("\n")) {
  const t = line.trim();
  if (!t || t.startsWith("#")) continue;
  const [prefix, label] = t.split("\t");
  if (!prefix || !label) {
    console.error(`NG: 「接頭辞<TAB>ラベル」の形でない行: ${t}`);
    ng++;
    continue;
  }
  if (!prefixes.has(prefix)) {
    console.error(`NG: 一般論の接頭辞の一覧に無い接頭辞: ${prefix}`);
    ng++;
  }
  if (!blocks.has(label)) {
    console.error(`NG: 本文に無いラベル: ${label}（${prefix}）`);
    ng++;
    continue;
  }
  if (!text(blocks.get(label)).includes(phrase)) {
    console.error(`NG: ラベル ${label} の主張が「${phrase}」と明示していない（${prefix}）`);
    ng++;
  }
}
process.exit(ng === 0 ? 0 : 1);
