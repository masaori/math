import assert from "node:assert/strict";
import { mkdtempSync, mkdirSync, writeFileSync, symlinkSync, rmSync } from "node:fs";
import { execFileSync } from "node:child_process";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { assertCommittedFresh, assertFresh, labelsOfGenerated, revisionFileExists, verifyProject } from "./verify.ts";
import { violationsOfEntry } from "./supervision-log-rules.ts";
import { evidenceFileExists } from "./evidence-fs.ts";
import { projects, projectNamed } from "./projects.ts";
import { beginOrResume } from "./run-state.ts";

assert.equal(projects.length, 6);
assert.equal(new Set(projects.map(project => project.name)).size, 6);
assert.throws(() => projectNamed("unknown"));
const old = '{"history":true}\n';
const added = JSON.stringify({ schemaVersion: 2, 実行識別子: "今回" }) + "\n";
assertFresh(old, old + added, "今回");
const rewritten = '{"history":false}\n' + added;
for (const after of [old, added, rewritten, old + added + added, old + added.replace("今回", "過去")]) {
  assert.throws(() => assertFresh(old, after, "今回"));
}
const repository = mkdtempSync(join(tmpdir(), "supervision-candidate-"));
try {
  execFileSync("git", ["init", "-q"], { cwd: repository });
  execFileSync("git", ["config", "user.name", "supervision test"], { cwd: repository });
  execFileSync("git", ["config", "user.email", "supervision-test@example.invalid"], { cwd: repository });
  const path = "supervision-log.jsonl";
  mkdirSync(join(repository, "project"));
  writeFileSync(join(repository, "project", "proof"), "proof\n");
  symlinkSync(join(repository, "project", "proof"), join(repository, "project", "proof-link"));
  writeFileSync(join(repository, path), old);
  execFileSync("git", ["add", path, "project/proof", "project/proof-link"], { cwd: repository });
  execFileSync("git", ["commit", "-qm", "base"], { cwd: repository });
  const before = execFileSync("git", ["rev-parse", "HEAD"], { cwd: repository, encoding: "utf8" }).trim();
  writeFileSync(join(repository, path), rewritten);
  execFileSync("git", ["add", path], { cwd: repository });
  execFileSync("git", ["commit", "-qm", "broken candidate"], { cwd: repository });
  const candidate = execFileSync("git", ["rev-parse", "HEAD"], { cwd: repository, encoding: "utf8" }).trim();
  writeFileSync(join(repository, path), old + added);
  execFileSync("git", ["add", path], { cwd: repository });
  const worktreeAdded = JSON.stringify({ schemaVersion: 2, 実行識別子: "今回", 作業ツリーだけ: true }) + "\n";
  writeFileSync(join(repository, path), old + worktreeAdded);
  assert.doesNotThrow(() => assertFresh(old, old + worktreeAdded, "今回"));
  assert.throws(
    () => assertCommittedFresh(repository, before, candidate, path, "今回"),
    /既存の監督履歴を書き換えた/,
    "index と作業ツリーが修復済みでも、破損した候補コミットを拒否する",
  );
  writeFileSync(join(repository, "project", "dirty-only"), "dirty\n");
  assert.equal(revisionFileExists(repository, candidate, "project", "proof"), true);
  assert.equal(revisionFileExists(repository, candidate, "project", "proof-link"), false);
  assert.equal(revisionFileExists(repository, candidate, "project", "dirty-only"), false);
  assert.equal(revisionFileExists(repository, candidate, "project", "../supervision-log.jsonl"), false);
  assert.deepEqual(labelsOfGenerated('export const ALL_LABELS = [\n  "known_label",\n] as const\n'), new Set(["known_label"]));
} finally { rmSync(repository, { recursive: true }); }
const fixture = mkdtempSync(join(tmpdir(), "supervision-evidence-"));
try {
  const marker = join(fixture, "unfinished");
  const first = beginOrResume(marker, "a".repeat(40));
  const resumed = beginOrResume(marker, "b".repeat(40));
  assert.deepEqual(resumed, first, "未完の回はHEADが進んでも実行識別子と開始コミットを維持する");
  writeFileSync(marker, "broken");
  assert.throws(() => beginOrResume(marker, "c".repeat(40)));
  mkdirSync(join(fixture, "project"));
  writeFileSync(join(fixture, "outside"), "outside");
  writeFileSync(join(fixture, "project", "inside"), "inside");
  symlinkSync(join(fixture, "outside"), join(fixture, "project", "escape"));
  for (const path of [".", "../outside", "escape", "missing"]) assert.equal(evidenceFileExists(join(fixture, "project"), path), false);
  assert.equal(evidenceFileExists(join(fixture, "project"), "inside"), true);
} finally { rmSync(fixture, { recursive: true }); }

for (const project of projects) {
  const { entries } = await verifyProject(project.name);
  const valid = entries.at(-1)!;
  const resolver = { fileExists: () => true, labelExists: () => true };
  assert.deepEqual(violationsOfEntry(valid, resolver), []);
  for (const key of ["実行状態", "段取りの所在", "研究上の前進", "停止条件", "次の対象", "証明済み事項から得たインサイト", "LLMによる検証", "プログラミングによる検証"]) {
    const broken = { ...valid };
    delete broken[key];
    assert.ok(violationsOfEntry(broken, resolver).length > 0, `${project.title}: ${key} の欠落を拒否`);
  }
  const restart = structuredClone(valid) as any;
  restart["次の対象"]["研究再開の許可"] = true;
  assert.ok(violationsOfEntry(restart, resolver).length > 0);
  const wrong = structuredClone(valid) as any;
  wrong["実行状態"]["直近の成否"] = "研究が前進";
  assert.ok(violationsOfEntry(wrong, resolver).length > 0);
}
console.log("プログラミングによる検証: 六研究の対象・欠落・権限分離・今回追記・外部パスの拒否が成功");
