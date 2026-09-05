/**
 * 研究監督の記録 `docs/tasks/supervision-log.jsonl` を、`supervision-log-rules.ts` の規則で検査する。
 *
 * 入口はここだけがファイルシステムへ触れる。対象の実在判定は、段取りの検査が使っているものと
 * 同じ実装（`structured-latex/tools/roadmap-evidence-fs.ts`）を借りる。**同じ「プロジェクト内の
 * 通常ファイルであること」という契約を二度書くと、片方だけが緩んだときに気付けない。**
 *
 *   node scripts/verify-supervision-log.ts [記録のパス]
 *
 * 引数を省略すると正本 `docs/tasks/supervision-log.jsonl` を見る。
 * 空ファイル・行の構文エラー・規則違反のいずれも終了コード 1 で落とす（fail-closed）。
 */

import { readFileSync } from "node:fs";
import { dirname, join, resolve as resolvePath } from "node:path";
import { fileURLToPath } from "node:url";

import { ALL_LABELS } from "../structured-latex/labels.generated.ts";
import { evidenceFileExists } from "../structured-latex/tools/roadmap-evidence-fs.ts";
import { violationsOfLog, type TargetResolver } from "./supervision-log-rules.ts";

const projectDir = resolvePath(dirname(fileURLToPath(import.meta.url)), "..");
const logPath = process.argv[2] ?? join(projectDir, "docs/tasks/supervision-log.jsonl");

const labels = new Set<string>(ALL_LABELS);
const resolver: TargetResolver = {
  labelExists: (label) => labels.has(label),
  fileExists: (path) => evidenceFileExists(projectDir, path),
};

let raw: string;
try {
  raw = readFileSync(logPath, "utf8");
} catch (error) {
  console.error(`記録を読めない: ${logPath}`);
  console.error(String(error));
  process.exit(1);
}

const lines = raw.split("\n").filter((line) => line.trim() !== "");
const entries: unknown[] = [];
const parseErrors: string[] = [];
lines.forEach((line, index) => {
  try {
    entries.push(JSON.parse(line));
  } catch (error) {
    parseErrors.push(`${index + 1} 行目が JSON として読めない: ${String(error)}`);
  }
});

if (parseErrors.length > 0) {
  console.error(`監督の記録が壊れている: ${logPath}`);
  for (const message of parseErrors) console.error(`  - ${message}`);
  process.exit(1);
}

const violations = violationsOfLog(entries, resolver);
if (violations.length > 0) {
  console.error(`監督の記録が契約を満たしていない（${violations.length} 件）: ${logPath}`);
  for (const violation of violations) console.error(`  - ${violation.where}: ${violation.why}`);
  console.error("契約の正本は docs/tasks/supervision-runbook.md。");
  process.exit(1);
}

const iterationCount = entries.reduce(
  (total, entry) => total + (Array.isArray((entry as Record<string, unknown>)["反復"]) ? ((entry as Record<string, unknown>)["反復"] as unknown[]).length : 0),
  0,
);
console.log(`監督の記録は契約を満たしている: ${entries.length} 回、反復 ${iterationCount} 件`);
