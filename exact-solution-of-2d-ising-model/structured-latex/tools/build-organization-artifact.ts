import { mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const projectDir = join(dirname(fileURLToPath(import.meta.url)), "..", "..");
const inventoryPath = join(projectDir, "docs", "organization", "flat-inventory.json");
const outputPath = resolve(process.argv[2] ?? join(projectDir, "build", "paper-organization", "index.html"));
const inventory = JSON.parse(readFileSync(inventoryPath, "utf8"));
const pendingSplitCount = inventory.entries.filter((entry: any) => entry.blockSplitRequiredBeforeFinalOrdering).length;
const escape = (value: unknown) => String(value ?? "名称未設定")
  .replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll('"', "&quot;");
const entryById = new Map(inventory.entries.map((entry: any) => [entry.id, entry]));
const chapters = inventory.chapterStructures.map((chapter: any) => {
  const units = chapter.topologicalOrder.map((unit: any) => {
    const items = unit.entryIds.map((id: string) => {
      const entry: any = entryById.get(id);
      const pending = entry.blockSplitRequiredBeforeFinalOrdering ? " · ブロック分割または案内参照の判定が未確定" : "";
      return `<li><span class="kind">${escape(entry.kind)}</span> ${escape(entry.title)}<small>${escape(entry.sourceFile)} · 直接の前提 ${entry.dependsOnEntryIds.length}件${pending}</small></li>`;
    }).join("");
    const firstEntry: any = entryById.get(unit.entryIds[0]);
    return `<section><h3>${escape(firstEntry?.title)}から始まる依存単位${unit.inseparableDependencyUnit ? "（相互依存）" : ""}</h3><ul>${items}</ul></section>`;
  }).join("");
  return `<article><h2>${escape(chapter.chapter)} <span>${chapter.entryCount}件</span></h2>${units}</article>`;
}).join("");
const html = `<!doctype html><html lang="ja"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>複素行列版2次元イジング模型 論文構成</title><style>
:root{color-scheme:light;--ink:#18202a;--sub:#64707d;--line:#d9dfe6;--accent:#7b2d26;--paper:#fbfaf6}*{box-sizing:border-box}body{margin:0;background:var(--paper);color:var(--ink);font-family:-apple-system,BlinkMacSystemFont,"Hiragino Sans","Yu Gothic",sans-serif;line-height:1.7}main{max-width:1080px;margin:auto;padding:48px 24px}h1{font-family:serif;font-size:clamp(2rem,5vw,3.6rem);line-height:1.2;margin:0 0 16px}h2{border-bottom:2px solid var(--ink);padding-bottom:8px;margin-top:56px}h2 span{font:normal .55em sans-serif;color:var(--sub)}h3{font-size:1rem;margin:0;color:var(--accent)}.lead{font-size:1.15rem;max-width:780px}.notice{border-left:5px solid var(--accent);padding:12px 18px;background:#fff;margin:28px 0}.stats{display:flex;gap:16px;flex-wrap:wrap}.stats div{background:#fff;border:1px solid var(--line);padding:12px 18px}.stats strong{display:block;font-size:1.7rem}section{background:#fff;border:1px solid var(--line);padding:16px 20px;margin:12px 0}ul{margin:8px 0 0;padding-left:22px}.kind{color:var(--accent);font-size:.78rem;border:1px solid #d9aaa5;border-radius:3px;padding:1px 5px}small{display:block;color:var(--sub)}footer{margin-top:48px;color:var(--sub);font-size:.85rem}@media(max-width:600px){main{padding:28px 16px}section{padding:12px}}
</style></head><body><main><h1>複素行列版2次元イジング模型<br>論文構成</h1><p class="lead">${escape(inventory.organizingTheme)}</p><div class="notice"><strong>分類境界</strong><br>${escape(inventory.boundaryRule)}<br>解析・可算性による旧分類は撤回済みです。説明の具体化またはブロック分割を要する候補は${inventory.explanationGranularityReview.flaggedEntryIds.length}件です。</div><div class="stats"><div><strong>${inventory.entryCount}</strong>全定義・主張・定理</div><div><strong>${inventory.chapterEntryCounts["数学的道具立て"]}</strong>数学的道具立て</div><div><strong>${inventory.chapterEntryCounts["2次元イジングモデル"]}</strong>2次元イジングモデル</div></div>${chapters}<footer>機械可読棚卸し schema ${inventory.schemaVersion} から生成。表示順は意味的前提から帰結への暫定トポロジカル順であり、ブロック分割候補${pendingSplitCount}件の確定後に最終化する。</footer></main></body></html>`;
mkdirSync(dirname(outputPath), { recursive: true });
writeFileSync(outputPath, html);
console.log(`wrote organization artifact to ${outputPath}`);
