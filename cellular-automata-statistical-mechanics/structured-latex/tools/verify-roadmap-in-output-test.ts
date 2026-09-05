#!/usr/bin/env node
/** 公開物の段取り照合が、矛盾する状態の併記を拒むことを回帰検査する。 */

import { mkdtempSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { spawnSync } from "node:child_process";

import { roadmapStages } from "../research-roadmap.ts";
import { structuredLatexDir } from "./content-modules.ts";
import { renderRoadmapHtml } from "./render-roadmap.ts";

const verifier = join(structuredLatexDir, "tools", "verify-roadmap-in-output.ts");
const fixtureDir = mkdtempSync(join(tmpdir(), "ca-roadmap-output-"));
let failures = 0;

const verify = (name: string, html: string, shouldPass: boolean): void => {
  const path = join(fixtureDir, `${name}.html`);
  writeFileSync(path, html);
  const run = spawnSync(process.execPath, [verifier, path, name], { encoding: "utf8" });
  const passed = run.status === 0;
  if (passed === shouldPass) {
    console.log(`✓ ${name}`);
    return;
  }
  failures += 1;
  console.error(`✗ ${name}: 終了コード ${run.status}（期待: ${shouldPass ? 0 : "非 0"}）`);
  if (run.stdout.trim() !== "") console.error(run.stdout.trim());
  if (run.stderr.trim() !== "") console.error(run.stderr.trim());
};

try {
  const valid = `<!doctype html><html><body>${renderRoadmapHtml()}</body></html>`;
  verify("正本どおりの段取り", valid, true);

  const first = roadmapStages[0];
  const expectedStatus = first.current ? `${first.status}（現在地）` : first.status;
  const statusElement = `<p class="roadmap-status">状態: ${expectedStatus}</p>`;
  const contradictoryStatus = first.status === "到達済み" ? "進行中" : "到達済み";
  const contradictory = valid.replace(
    statusElement,
    `${statusElement}<p class="roadmap-status">状態: ${contradictoryStatus}</p>`,
  );
  verify("矛盾する状態を併記した段取り", contradictory, false);
} finally {
  rmSync(fixtureDir, { recursive: true, force: true });
}

if (failures > 0) {
  console.error(`公開物の段取り照合の回帰検査が失敗した（${failures} 件）`);
  process.exit(1);
}

console.log("公開物の段取り照合の回帰検査がすべて期待どおり（2 件）");
