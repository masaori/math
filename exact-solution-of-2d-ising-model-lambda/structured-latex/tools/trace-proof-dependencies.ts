#!/usr/bin/env node
/** 本文に登録された具体版の定理まで、登録のない補助定理を通って依存をたどる。 */
import { readFileSync } from "node:fs";

type Entry = { id: string; labels: string[]; concrete: string[]; citations: string[] };
const [citationsPath, dependenciesPath] = process.argv.slice(2);
if (!citationsPath || !dependenciesPath) {
  throw new Error("使い方: node trace-proof-dependencies.ts <引用 JSON> <直接依存 TSV>");
}

const entries = JSON.parse(readFileSync(citationsPath, "utf8")) as Entry[];
const owners = new Map<string, Entry[]>();
for (const entry of entries) {
  for (const name of entry.concrete) {
    const registered = owners.get(name) ?? [];
    if (!registered.some((previous) => previous.id === entry.id)) registered.push(entry);
    owners.set(name, registered);
  }
}

const kinds = new Map<string, string>();
const uses = new Map<string, Set<string>>();
for (const line of readFileSync(dependenciesPath, "utf8").trimEnd().split("\n")) {
  const [name, relation, target, extra] = line.split("\t");
  if (!name || !relation || !target || extra !== undefined) throw new Error(`不正な TSV 行: ${line}`);
  if (relation === "decl") {
    if (kinds.has(name)) throw new Error(`宣言が重複しています: ${name}`);
    kinds.set(name, target);
  } else if (relation === "value") {
    const edges = uses.get(name) ?? new Set<string>();
    edges.add(target);
    uses.set(name, edges);
  } else if (relation !== "type") {
    throw new Error(`不明な依存の種類: ${relation}`);
  }
}

const result = entries.map((entry) => {
  const found = new Set<string>();
  const visited = new Set<string>();
  const pending = [...entry.concrete];
  for (const name of pending) {
    if (!kinds.has(name)) throw new Error(`登録された宣言が Lean 環境にありません: ${name}`);
  }
  while (pending.length) {
    const name = pending.pop()!;
    if (visited.has(name)) continue;
    visited.add(name);
    for (const dependency of uses.get(name) ?? []) {
      const dependencyOwners = owners.get(dependency);
      if (dependencyOwners) {
        for (const dependencyOwner of dependencyOwners) {
          if (dependencyOwner.id !== entry.id) found.add(dependencyOwner.labels[0]!);
        }
      } else if (kinds.get(dependency) === "theorem") {
        pending.push(dependency);
      }
    }
  }
  return { id: entry.id, labels: entry.labels, concrete: entry.concrete, used: [...found].sort() };
});
process.stdout.write(`${JSON.stringify(result, null, 2)}\n`);
