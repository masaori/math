#!/usr/bin/env node
import { readFileSync, readdirSync, statSync } from "node:fs";
import { basename, join } from "node:path";

import { loadContentFiles, structuredLatexDir } from "./content-modules.ts";

const leanRoot = join(structuredLatexDir, "..", "lean", "Ising2DLambda");
const ledgerPath = join(structuredLatexDir, "..", "lean", "concrete-necsuf-delegations.txt");

function leanFiles(dir: string): string[] {
  return readdirSync(dir).flatMap((entry) => {
    const path = join(dir, entry);
    return statSync(path).isDirectory() ? leanFiles(path) : entry.endsWith(".lean") ? [path] : [];
  });
}

// Preserve offsets and line breaks while removing nested block comments, line comments, and strings.
function sourceWithoutComments(source: string): string {
  let out = "";
  let depth = 0;
  let line = false;
  let quoted = false;
  for (let i = 0; i < source.length; i++) {
    const pair = source.slice(i, i + 2);
    const c = source[i];
    if (line) {
      if (c === "\n") line = false;
      out += c === "\n" ? c : " ";
    } else if (depth > 0) {
      if (pair === "/-") { depth++; out += "  "; i++; }
      else if (pair === "-/") { depth--; out += "  "; i++; }
      else out += c === "\n" ? c : " ";
    } else if (quoted) {
      if (c === "\\") { out += "  "; i++; }
      else if (c === '"') { quoted = false; out += " "; }
      else out += c === "\n" ? c : " ";
    } else if (pair === "--") { line = true; out += "  "; i++; }
    else if (pair === "/-") { depth = 1; out += "  "; i++; }
    else if (c === '"') { quoted = true; out += " "; }
    else out += c;
  }
  return out;
}

type Declaration = { name: string; body: string; file: string };
function declarations(file: string): Declaration[] {
  const source = sourceWithoutComments(readFileSync(file, "utf8"));
  const commands = [...source.matchAll(/^\s*(?:namespace\s+([\w.]+)|end\s+([\w.]+)|(?:private\s+|protected\s+|noncomputable\s+|scoped\s+)*(?:theorem|lemma|def|abbrev|structure|instance|inductive)\s+([\w.'₀-₉]+))/gm)];
  const namespaces: string[] = [];
  const result: Declaration[] = [];
  for (let i = 0; i < commands.length; i++) {
    const match = commands[i];
    if (!match) continue;
    if (match[1]) { namespaces.push(match[1]); continue; }
    if (match[2]) { namespaces.pop(); continue; }
    const name = match[3];
    if (!name) continue;
    result.push({
      name: [...namespaces, name].join("."),
      body: source.slice(match.index, commands[i + 1]?.index ?? source.length),
      file,
    });
  }
  return result;
}

async function main(): Promise<void> {
  const registered = new Set<string>();
  for (const { blocks } of await loadContentFiles()) {
    for (const block of blocks) {
      if ("lean" in block && Array.isArray(block.lean)) {
        for (const name of block.lean) if (typeof name === "string") registered.add(name);
      }
    }
  }
  const found = new Set<string>();
  const problems: string[] = [];
  for (const file of leanFiles(leanRoot)) {
    if (file.includes("/NecSuf/") || basename(file).endsWith("FromNecSuf.lean")) continue;
    for (const declaration of declarations(file)) {
      const { name, body } = declaration;
      if (!registered.has(name) || name.includes("from_necSuf") || name.includes("_eq_necSuf")) continue;
      if (/\bNecSuf\./.test(body)) found.add(name);
    }
  }
  const ledger = new Set(readFileSync(ledgerPath, "utf8").split(/\r?\n/)
    .map((line) => line.trim()).filter((line) => line !== "" && !line.startsWith("#")));
  for (const name of found) if (!ledger.has(name)) problems.push(`台帳にない委譲: ${name}`);
  for (const name of ledger) if (!found.has(name)) problems.push(`委譲が消えたか登録が外れた台帳項目: ${name}`);
  if (problems.length) {
    for (const problem of problems.sort()) console.error(problem);
    process.exitCode = 1;
  } else {
    console.log(`登録された Lean 具体版から必要十分版への参照 ${found.size} 件は台帳と一致します。`);
  }
}

await main();
