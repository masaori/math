#!/usr/bin/env node
/** 本文の証明中の主張引用と、具体版から到達する登録済み主張の差分を照合する。 */
import { readFileSync } from "node:fs";

type Entry = { id: string; labels: string[]; concrete: string[]; citations: string[] };
type Trace = { id: string; labels: string[]; concrete: string[]; used: string[] };

const [citationsPath, tracedPath, ledgerPath, mode] = process.argv.slice(2);
if (!citationsPath || !tracedPath || !ledgerPath || (mode !== undefined && mode !== "--print")) {
  throw new Error("使い方: node check-proof-correspondence.ts <引用 JSON> <追跡 JSON> <差分台帳 TSV> [--print]");
}

const entries = JSON.parse(readFileSync(citationsPath, "utf8")) as Entry[];
const traces = JSON.parse(readFileSync(tracedPath, "utf8")) as Trace[];
if (entries.length !== traces.length) throw new Error("引用と追跡のブロック数が違います");

const canonical = new Map<string, string>();
for (const entry of entries) {
  if (!entry.labels[0]) throw new Error(`${entry.id} に主ラベルがありません`);
  for (const label of entry.labels) {
    if (canonical.has(label)) throw new Error(`ラベルが重複しています: ${label}`);
    canonical.set(label, entry.labels[0]);
  }
}

const differences: string[] = [];
let withoutConcrete = 0;
let matched = 0;
for (let i = 0; i < entries.length; i++) {
  const entry = entries[i]!;
  const trace = traces[i]!;
  if (entry.id !== trace.id || JSON.stringify(entry.labels) !== JSON.stringify(trace.labels) ||
      JSON.stringify(entry.concrete) !== JSON.stringify(trace.concrete)) {
    throw new Error(`引用と追跡の登録が一致しません: ${entry.id} / ${trace.id}`);
  }
  if (entry.concrete.length === 0) {
    withoutConcrete++;
    continue;
  }
  const paper = new Set(entry.citations.filter((label) => canonical.has(label)).map((label) => canonical.get(label)!));
  const lean = new Set(trace.used);
  const before = differences.length;
  for (const label of lean) {
    if (!canonical.has(label)) throw new Error(`${entry.id} の Lean 依存先が登録されていません: ${label}`);
  }
  for (const label of paper) if (!lean.has(label)) differences.push(`PAPER_ONLY\t${entry.labels[0]}\t${label}`);
  for (const label of lean) if (!paper.has(label)) differences.push(`LEAN_ONLY\t${entry.labels[0]}\t${label}`);
  if (differences.length === before) matched++;
}
differences.sort();
const actual = differences.join("\n") + (differences.length ? "\n" : "");
if (mode === "--print") {
  process.stdout.write(actual);
} else {
  const expected = readFileSync(ledgerPath, "utf8");
  if (actual !== expected) {
    const actualSet = new Set(differences);
    const expectedSet = new Set(expected.trimEnd().split("\n").filter(Boolean));
    const added = differences.filter((line) => !expectedSet.has(line));
    const stale = [...expectedSet].filter((line) => !actualSet.has(line));
    throw new Error(`一対一の差分台帳が一致しません（未登録 ${added.length} 件、解消済み ${stale.length} 件）\n` +
      [...added.map((line) => `+ ${line}`), ...stale.map((line) => `- ${line}`)].join("\n"));
  }
  const paperOnly = differences.filter((line) => line.startsWith("PAPER_ONLY\t")).length;
  console.log(`一対一の差分台帳は一致しています（完全一致 ${matched} 件、論文側のみ ${paperOnly} 行、Lean 側のみ ${differences.length - paperOnly} 行、具体版未登録 ${withoutConcrete} 件）。`);
}
