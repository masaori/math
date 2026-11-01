/**
 * 本文（structured-latex/content/）で証明を持つブロックのすべてに、SageMath の検算が付いているかを検査する。
 *
 * 「付いている」とは、そのブロックのラベルのどれかを、sagemath/check/<対象名>/overview.md の
 * 「**対象ラベル**: `<label>`」の行（verify-check-linkage.ts と同じ読み方）が宣言していることである。
 * 検算が通ることは run-all-checks.sh が、宣言の実在は verify-check-linkage.ts が確かめる。
 *
 * 使い方:
 *   node sagemath/tools/verify-every-proof-has-check.ts          # 未検算の数を出し、1 件でもあれば exit 1
 *   node sagemath/tools/verify-every-proof-has-check.ts --list   # 未検算のブロックを文書順に全部出す
 */
import { existsSync, readdirSync, readFileSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { loadContentFiles } from "../../structured-latex/tools/content-modules.ts";

const here = dirname(fileURLToPath(import.meta.url));
const projectRoot = resolve(here, "..", "..");
const checkRoot = join(projectRoot, "sagemath", "check");
const LABEL_RE = /^\*\*対象ラベル\*\*:\s*`([^`]+)`/m;

const checkedLabels = new Set<string>();
for (const dir of readdirSync(checkRoot, { withFileTypes: true })) {
  if (!dir.isDirectory()) continue;
  const overview = join(checkRoot, dir.name, "overview.md");
  if (!existsSync(overview)) continue;
  const label = readFileSync(overview, "utf8").match(LABEL_RE)?.[1];
  if (label !== undefined) checkedLabels.add(label);
}

type Unchecked = { file: string; id: string; label: string | undefined };
const unchecked: Unchecked[] = [];
let withProof = 0;
for (const { file, blocks } of await loadContentFiles()) {
  for (const block of blocks as readonly any[]) {
    if (!Array.isArray(block.proof) || block.proof.length === 0) continue;
    withProof += 1;
    if ((block.labels as string[]).some((label) => checkedLabels.has(label))) continue;
    unchecked.push({ file, id: block.id, label: block.labels[0] });
  }
}

if (process.argv.includes("--list")) {
  for (const u of unchecked) console.log(`${u.file}\t${u.label ?? "(ラベルなし)"}\t${u.id}`);
}
console.log(`証明を持つブロック ${withProof} 件のうち、SageMath の検算が無いもの ${unchecked.length} 件`);
process.exit(unchecked.length === 0 ? 0 : 1);
