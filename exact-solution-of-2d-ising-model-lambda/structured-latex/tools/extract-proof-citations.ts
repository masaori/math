#!/usr/bin/env node
/** 本文の証明だけから引用先を読み、Lean 具体版の登録名とともに書き出す。 */
import { loadContentFiles } from "./content-modules.ts";

type ProofBlock = {
  id: string;
  kind: string;
  labels: readonly string[];
  proof?: unknown;
  lean?: readonly string[];
};

const BLKREF = /\\blkref\{([^{}]+)\}/g;

export function proofCitations(proof: unknown): string[] {
  const found = new Set<string>();
  function visit(value: unknown): void {
    if (typeof value === "string") {
      for (const match of value.matchAll(BLKREF)) found.add(match[1]!);
    } else if (Array.isArray(value)) {
      for (const item of value) visit(item);
    } else if (typeof value === "object" && value !== null) {
      const node = value as Record<string, unknown>;
      if (node.type === "ref" && typeof node.target === "string") found.add(node.target);
      if (node.type === "math" || node.type === "displayMath") visit(node.tex);
      if (node.type === "paragraph") visit(node.children);
      if (node.type === "list") visit(node.items);
    }
  }
  visit(proof);
  return [...found].sort();
}

export function concreteRegistrations(lean: readonly string[] | undefined): string[] {
  return (lean ?? []).filter((name) =>
    !name.split(".").includes("NecSuf") &&
    !name.split(".").at(-1)!.toLowerCase().includes("necsuf"),
  );
}

const files = await loadContentFiles();
const blocks = files.flatMap(({ blocks }) => blocks) as ProofBlock[];
const labels = new Map<string, ProofBlock>();
for (const block of blocks) {
  for (const label of block.labels) {
    if (labels.has(label)) throw new Error(`ラベルが重複しています: ${label}`);
    labels.set(label, block);
  }
}

const result = blocks
  .filter((block) => block.kind === "claim" || block.kind === "theorem")
  .map((block) => {
    const citations = proofCitations(block.proof);
    for (const label of citations) {
      if (!labels.has(label)) throw new Error(`${block.id} の証明が未定義の ${label} を引いています`);
    }
    return {
      id: block.id,
      labels: block.labels,
      concrete: concreteRegistrations(block.lean),
      citations,
    };
  });

process.stdout.write(`${JSON.stringify(result, null, 2)}\n`);
