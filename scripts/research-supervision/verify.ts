import { readFileSync } from "node:fs";
import { dirname, posix, resolve } from "node:path";
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
type ProjectResolver = { labelExists: (label: string) => boolean; fileExists: (path: string) => boolean };
export function labelsOfGenerated(raw: string) {
  const section = raw.match(/export const ALL_LABELS = \[([\s\S]*?)\]\s+as const/)?.[1];
  if (section === undefined) throw new Error("生成済みラベル一覧を読めない");
  const labels = [...section.matchAll(/^\s*("(?:[^"\\]|\\.)*"),?\s*$/gm)].map(match => JSON.parse(match[1]!) as string);
  if (labels.length === 0) throw new Error("生成済みラベル一覧が空である");
  return new Set(labels);
}
export function revisionFileExists(repository: string, revision: string, project: string, path: string) {
  if (posix.isAbsolute(path)) return false;
  const normalized = posix.normalize(path);
  if (normalized === "." || normalized === ".." || normalized.startsWith("../")) return false;
  const fullPath = posix.join(project, normalized);
  const output = execFileSync("git", ["ls-tree", "-z", revision, "--", fullPath], { cwd: repository, encoding: "utf8" });
  if (!output.endsWith("\0")) return false;
  const [metadata, listedPath] = output.slice(0, -1).split("\t");
  if (!metadata || listedPath !== fullPath) return false;
  const [mode, type] = metadata.split(" ");
  return type === "blob" && (mode === "100644" || mode === "100755");
}
export async function verifyProjectRaw(name: string, raw: string, requireCurrent = true, resolver?: ProjectResolver) {
  const project = projectNamed(name);
  const projectRoot = resolve(root, name);
  const entries = entriesOf(raw);
  let activeResolver = resolver;
  if (!activeResolver) {
    const { ALL_LABELS } = await import(pathToFileURL(resolve(projectRoot, "structured-latex/labels.generated.ts")).href);
    const labels = new Set(ALL_LABELS);
    activeResolver = {
      labelExists: label => labels.has(label),
      fileExists: path => evidenceFileExists(projectRoot, path),
    };
  }
  const violations = [...violationsOfLog(entries, activeResolver)];
  if (requireCurrent && entries.at(-1)?.schemaVersion !== 2) throw new Error(`${project.title}: 全研究形式の今回評価がない`);
  for (const entry of entries) {
    if (entry.schemaVersion === 2 && entry["研究"] !== name) throw new Error(`${project.title}: 別研究の評価が混入`);
  }
  if (violations.length) throw new Error(`${project.title}: ${JSON.stringify(violations)}`);
  return { raw, entries };
}
export async function verifyProject(name: string, logPath?: string, requireCurrent = true) {
  const projectRoot = resolve(root, name);
  const raw = readFileSync(logPath ?? resolve(projectRoot, logName), "utf8");
  return verifyProjectRaw(name, raw, requireCurrent);
}

/** 成功終了に必要なのは、今回の追記・既存履歴の保存・成果包含のすべて。 */
export function assertFresh(before: string, after: string, run: string) {
  if (!after.startsWith(before)) throw new Error("既存の監督履歴を書き換えた");
  const added = entriesOf(after.slice(before.length));
  if (added.length !== 1 || added[0]?.["実行識別子"] !== run || added[0]?.schemaVersion !== 2) throw new Error("今回の監督評価が一行追記されていない");
}

export function assertCommittedFresh(repository: string, before: string, candidate: string, path: string, run: string) {
  const old = execFileSync("git", ["show", `${before}:${path}`], { cwd: repository, encoding: "utf8" });
  const raw = execFileSync("git", ["show", `${candidate}:${path}`], { cwd: repository, encoding: "utf8" });
  assertFresh(old, raw, run);
  return raw;
}

/** remote 反映前に、候補コミットが開始時の六研究履歴を保ち今回行だけを増やしたことを判定する。 */
export async function verifyCandidate(before: string, run: string, candidate = "HEAD") {
  const current = new Map<string, string>();
  for (const project of projects) {
    const path = `${project.name}/${logName}`;
    const raw = assertCommittedFresh(root, before, candidate, path, run);
    const labelsPath = `${project.name}/structured-latex/labels.generated.ts`;
    const labels = labelsOfGenerated(execFileSync("git", ["show", `${candidate}:${labelsPath}`], { cwd: root, encoding: "utf8" }));
    await verifyProjectRaw(project.name, raw, true, {
      labelExists: label => labels.has(label),
      fileExists: path => revisionFileExists(root, candidate, project.name, path),
    });
    current.set(project.name, raw);
  }
  return current;
}

export async function main(args: string[]) {
  if (args.length === 0 || (args.length === 1 && args[0] === "--all")) {
    for (const project of projects) await verifyProject(project.name);
    console.log("プログラミングによる検証: 六研究の評価記録を受理（内容の意味はLLMによる検証の対象）");
  } else if (args[0] === "--candidate" && args.length === 3) {
    const [, before, run] = args;
    if (!before || !run) throw new Error("開始コミット・実行識別子が必要");
    await verifyCandidate(before, run);
    console.log("プログラミングによる検証: 候補コミットが既存履歴を保ち今回の六研究評価だけを一行ずつ増やしたことを確認");
  } else if (args[0] === "--completed" && args.length === 4) {
    const [, before, run, remote] = args;
    if (!before || !run || !remote) throw new Error("開始コミット・実行識別子・remote defaultが必要");
    const current = await verifyCandidate(before, run);
    for (const project of projects) {
      const path = `${project.name}/${logName}`;
      const raw = current.get(project.name)!;
      const published = execFileSync("git", ["show", `${remote}:${path}`], { cwd: root, encoding: "utf8" });
      if (published !== raw) throw new Error(`${project.title}: 今回の評価がremote defaultと一致しない`);
    }
    execFileSync("git", ["merge-base", "--is-ancestor", "HEAD", remote], { cwd: root });
    if (execFileSync("git", ["status", "--porcelain"], { cwd: root, encoding: "utf8" }).trim()) throw new Error("未コミット成果が残っている");
    console.log("プログラミングによる検証: 今回の六研究評価・履歴保存・remote default包含を確認");
  } else throw new Error("usage: verify.ts [--all | --candidate <before-commit> <run-id> | --completed <before-commit> <run-id> <remote-default>]");
}
if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  await main(process.argv.slice(2)).catch(error => { console.error(String(error)); process.exitCode = 1; });
}
