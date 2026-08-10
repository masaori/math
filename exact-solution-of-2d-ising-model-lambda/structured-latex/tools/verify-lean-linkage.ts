#!/usr/bin/env node
/**
 * 本文（structured-latex）が宣言した Lean の対応先が実在するかを検査する。
 *
 * 各ブロックの `lean` フィールドは、そのブロックに対応する Lean の宣言の完全名を挙げる。
 * これは四層の検証（記述 / SageMath / Lean 具体版 / Lean 必要十分版）の対応表そのものだが、
 * 型検査も `lake build` もこの名前を見ないので、**綴りを間違えても誰も落とさなかった**。
 * 実測（2026-08-09 の tick 27 のレビュー）で 6 件が実在しない名前を指していた
 * （必要十分版の名前を具体版の名前と取り違えた、リネーム前の名前が残っていた、
 * mathlib の宣言を自前の宣言のように書いていた）。この検査はその再発を防ぐためにある。
 *
 * 検査すること。
 *   1. `Ising2DLambda.` で始まる名前は、`lean/Ising2DLambda/` のどこかで宣言されていること。
 *   2. それ以外の名前は、下の MATHLIB_ALLOWLIST に挙げたものだけ（mathlib の宣言を
 *      対応先にするのは、自前で定義を置いていない場合に限る。綴りの間違いを見逃さないため
 *      黙って通さず、ここへ明示的に足させる）。
 *
 * 使い方: node structured-latex/tools/verify-lean-linkage.ts
 */

import { existsSync, readdirSync, readFileSync, statSync } from "node:fs";
import { join } from "node:path";

import { loadContentFiles, structuredLatexDir } from "./content-modules.ts";

const projectRoot = join(structuredLatexDir, "..");
const leanRoot = join(projectRoot, "lean", "Ising2DLambda");

/**
 * mathlib の宣言をそのまま対応先にしてよいもの。
 * 自前で定義を置いていない対象に限る（例: 不定元 t は `Polynomial.X` そのものであり、
 * 別名を作ると人手証明の定義と Lean の定義が 2 つになる）。
 */
const MATHLIB_ALLOWLIST = new Set(["Polynomial.X"]);

const DECL_RE =
  /^\s*(?:@\[[^\]]*\]\s*)?(?:noncomputable\s+|private\s+|protected\s+|scoped\s+)*(?:theorem|lemma|def|abbrev|structure|instance|inductive)\s+([A-Za-z0-9_.'₀-₉]+)/gm;
const NAMESPACE_RE = /^namespace\s+([A-Za-z0-9_.]+)/gm;

function leanFiles(dir: string): string[] {
  const out: string[] = [];
  for (const entry of readdirSync(dir)) {
    const path = join(dir, entry);
    if (statSync(path).isDirectory()) out.push(...leanFiles(path));
    else if (entry.endsWith(".lean")) out.push(path);
  }
  return out;
}

/** lean/Ising2DLambda/ の全宣言の完全名を集める。 */
function collectDeclarations(): Set<string> {
  const declared = new Set<string>();
  for (const file of leanFiles(leanRoot)) {
    const text = readFileSync(file, "utf8");
    const namespaces = [...text.matchAll(NAMESPACE_RE)].map((m) => m[1]);
    const prefix = namespaces.join(".");
    for (const match of text.matchAll(DECL_RE)) {
      const name = match[1];
      if (name === undefined) continue;
      declared.add(prefix ? `${prefix}.${name}` : name);
    }
  }
  return declared;
}

async function main(): Promise<void> {
  if (!existsSync(leanRoot)) {
    console.error(`Lean のソースが無い: ${leanRoot}`);
    process.exit(1);
  }
  const declared = collectDeclarations();
  const files = await loadContentFiles();

  const problems: string[] = [];
  let checked = 0;
  for (const { file, blocks } of files) {
    for (const block of blocks) {
      const leanNames: readonly string[] = "lean" in block && Array.isArray(block.lean)
        ? (block.lean as readonly string[])
        : [];
      for (const name of leanNames) {
        checked += 1;
        if (name.startsWith("Ising2DLambda.")) {
          if (!declared.has(name)) {
            problems.push(`${file}: ${block.id}: 実在しない Lean の宣言 ${name}`);
          }
        } else if (!MATHLIB_ALLOWLIST.has(name)) {
          problems.push(
            `${file}: ${block.id}: 自前でない名前 ${name}` +
              "（mathlib の宣言を対応先にするなら MATHLIB_ALLOWLIST へ足す）",
          );
        }
      }
    }
  }

  if (problems.length > 0) {
    console.error("Lean の対応先が壊れている:");
    for (const problem of problems) console.error(`  - ${problem}`);
    process.exit(1);
  }
  console.log(`Lean の対応先 ${checked} 件はすべて実在する（宣言 ${declared.size} 件から照合）。`);
}

await main();
