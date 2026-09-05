import { readFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";
import { execFileSync } from "node:child_process";
import { evidenceFileExists } from "./evidence-fs.ts";
import { violationsOfLog } from "./supervision-log-rules.ts";
import { projects, projectNamed } from "./projects.ts";

export const root = resolve(dirname(fileURLToPath(import.meta.url)), "../..");
export const logName = "docs/tasks/supervision-log.jsonl";
export function entriesOf(raw: string): Record<string, unknown>[] {
  return raw.split("\n").filter(line => line.trim()).map(line => JSON.parse(line));
}
export async function verifyProject(name: string, logPath?: string, requireCurrent = true) {
  const project = projectNamed(name);
  const projectRoot = resolve(root, name);
  const raw = readFileSync(logPath ?? resolve(projectRoot, logName), "utf8");
  const entries = entriesOf(raw);
  const { ALL_LABELS } = await import(pathToFileURL(resolve(projectRoot, "structured-latex/labels.generated.ts")).href);
  const labels = new Set(ALL_LABELS);
  const violations = [...violationsOfLog(entries, {
    labelExists: label => labels.has(label),
    fileExists: path => evidenceFileExists(projectRoot, path),
  })];
  if (requireCurrent && entries.at(-1)?.schemaVersion !== 2) throw new Error(`${project.title}: 全研究形式の今回評価がない`);
  for (const entry of entries) {
    if (entry.schemaVersion === 2 && entry["研究"] !== name) throw new Error(`${project.title}: 別研究の評価が混入`);
  }
  if (violations.length) throw new Error(`${project.title}: ${JSON.stringify(violations)}`);
  return { raw, entries };
}

/** 成功終了に必要なのは、今回の追記・既存履歴の保存・成果包含のすべて。 */
export function assertFresh(before: string, after: string, run: string) {
  if (!after.startsWith(before)) throw new Error("既存の監督履歴を書き換えた");
  const added = entriesOf(after.slice(before.length));
  if (added.length !== 1 || added[0]?.["実行識別子"] !== run || added[0]?.schemaVersion !== 2) throw new Error("今回の監督評価が一行追記されていない");
}

export async function main(args: string[]) {
  if (args.length === 0 || (args.length === 1 && args[0] === "--all")) {
    for (const project of projects) await verifyProject(project.name);
    console.log("プログラミングによる検証: 六研究の評価記録を受理（内容の意味はLLMによる検証の対象）");
  } else if (args[0] === "--completed" && args.length === 4) {
    const [, before, run, remote] = args;
    if (!before || !run || !remote) throw new Error("開始コミット・実行識別子・remote defaultが必要");
    for (const project of projects) {
      const path = `${project.name}/${logName}`;
      const old = execFileSync("git", ["show", `${before}:${path}`], { cwd: root, encoding: "utf8" });
      const { raw } = await verifyProject(project.name);
      assertFresh(old, raw, run);
      const published = execFileSync("git", ["show", `${remote}:${path}`], { cwd: root, encoding: "utf8" });
      if (published !== raw) throw new Error(`${project.title}: 今回の評価がremote defaultと一致しない`);
    }
    execFileSync("git", ["merge-base", "--is-ancestor", "HEAD", remote], { cwd: root });
    if (execFileSync("git", ["status", "--porcelain"], { cwd: root, encoding: "utf8" }).trim()) throw new Error("未コミット成果が残っている");
    console.log("プログラミングによる検証: 今回の六研究評価・履歴保存・remote default包含を確認");
  } else throw new Error("usage: verify.ts [--all | --completed <before-commit> <run-id> <remote-default>]");
}
if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  await main(process.argv.slice(2)).catch(error => { console.error(String(error)); process.exitCode = 1; });
}
