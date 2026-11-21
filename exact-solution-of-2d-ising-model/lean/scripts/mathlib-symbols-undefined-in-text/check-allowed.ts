// 許可の一覧（lean/mathlib-symbols-defined-or-declared-in-text.txt）の各行「記号<TAB>ラベル」の
// ラベルが本文（structured-latex/content/*.ts）に在り、そのブロックが定義のブロック（kind が definition）であることを確かめる。
// 本文が外から持ち込むと宣言する記号も、宣言は定義のブロックに書く（例: 集合と代数構造の記号 set_and_algebra_notation）。
// check.sh から呼ばれる。
//
// 使い方: node check-allowed.ts <許可の一覧> <本文の content ディレクトリ>
import { readFileSync, readdirSync } from "node:fs";
import { join, resolve } from "node:path";

const [allowedPath, contentDir] = process.argv.slice(2);

const kinds = new Map<string, string>();
for (const f of readdirSync(contentDir).filter((f) => f.endsWith(".ts")).sort()) {
  const mod = await import(resolve(join(contentDir, f)));
  for (const v of Object.values(mod)) {
    if (!Array.isArray(v)) continue;
    for (const b of v as Array<{ labels?: string[]; kind?: string }>) {
      for (const l of b?.labels ?? []) kinds.set(l, b.kind ?? "");
    }
  }
}

let ng = 0;
const seen = new Set<string>();
for (const line of readFileSync(allowedPath, "utf8").split("\n")) {
  if (!line.trim() || line.startsWith("#")) continue;
  const t = line;
  if (t !== t.trim() || t.includes(" ")) {
    console.error(`NG: 空白を含む行（check.sh は空白を取り除かずに記号を読む）: ${JSON.stringify(t)}`);
    ng++;
    continue;
  }
  const cols = t.split("\t");
  if (cols.length !== 2 || !cols[0] || !cols[1]) {
    console.error(`NG: 「記号<TAB>ラベル」の形でない行: ${t}`);
    ng++;
    continue;
  }
  const [symbol, label] = cols;
  if (seen.has(symbol)) {
    console.error(`NG: 同じ記号の行が二つある: ${symbol}`);
    ng++;
  }
  seen.add(symbol);
  const kind = kinds.get(label);
  if (kind === undefined) {
    console.error(`NG: 本文に無いラベル: ${label}（${symbol}）`);
    ng++;
  } else if (kind !== "definition") {
    console.error(`NG: ラベル ${label} は定義のブロックでない（kind: ${kind}、${symbol}）`);
    ng++;
  }
}
process.exit(ng === 0 ? 0 : 1);
