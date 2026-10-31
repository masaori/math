import { execFileSync } from "node:child_process";
import { mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { createRequire } from "node:module";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const projectDir = join(dirname(fileURLToPath(import.meta.url)), "..", "..");
const inventory = JSON.parse(readFileSync(join(projectDir, "docs", "organization", "flat-inventory.json"), "utf8"));
const outputPath = resolve(process.argv[2] ?? join(projectDir, "structured-latex", "build", "paper-organization", "index.html"));
const require = createRequire(import.meta.url);
const katexDist = dirname(require.resolve("katex/dist/katex.min.css"));
const katex = require("katex");
const escape = (value: unknown) => String(value ?? "名称未設定")
  .replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll('"', "&quot;");
const entryById = new Map(inventory.entries.map((entry: any) => [entry.id, entry]));

const revision = (() => {
  const run = (args: string[]) => execFileSync("git", args, { cwd: projectDir, encoding: "utf8" }).trim();
  const head = run(["rev-parse", "--short", "HEAD"]);
  return run(["status", "--porcelain"]) === "" ? head : `${head}+`;
})();
const title = (entry: any) => entry.title === null ? `（題なし: ${escape(entry.labels[0] ?? entry.id)}）`
  : entry.titleFormat === "tex" ? katex.renderToString(entry.title, { throwOnError: true, strict: "error", displayMode: false, output: "html" })
  : escape(entry.title);

function katexCss(): string {
  const css = readFileSync(join(katexDist, "katex.min.css"), "utf8");
  const cache = new Map<string, string>();
  return css.replace(/url\(([^)]+)\)\s*format\("([^"]+)"\)(,)?/g, (_all, rawPath: string, format: string) => {
    if (format !== "woff2") return "";
    const file = rawPath.replace(/["']/g, "").replace(/^fonts\//, "");
    let data = cache.get(file);
    if (data === undefined) { data = readFileSync(join(katexDist, "fonts", file)).toString("base64"); cache.set(file, data); }
    return `url(data:font/woff2;base64,${data}) format("woff2")`;
  }).replace(/,\s*;/g, ";");
}

const katexTitle = (value: string, format: "tex" | "text") => format === "tex"
  ? katex.renderToString(value, { throwOnError: true, strict: "error", displayMode: false, output: "html" })
  : escape(value);
const entryList = (ids: string[]) => `<ul>${ids.map((id) => `<li>${title(entryById.get(id))}</li>`).join("")}</ul>`;
const progress = inventory.chapterPlacementProgress;
const chapterCount = inventory.parts.reduce((sum: number, part: any) => sum + part.chapters.length, 0);
const toolCount = inventory.classificationEntryCounts["数学的道具立て"];
const assignedCount = toolCount + progress.assignedChapterEntryCount;

const parts = inventory.parts.map((part: any) => {
  const chapters = part.chapters.map((chapter: any) => {
    const ordered = chapter.dependencyOrder.flatMap((unit: any) => unit.entryIds);
    const countNote = chapter.entryCount === chapter.proposalEntryCount
      ? `${chapter.entryCount}件`
      : `${chapter.entryCount}件（章立て案では${chapter.proposalEntryCount}件）`;
    return `<section><h4>${katexTitle(chapter.title, chapter.titleFormat)} <span>${countNote}</span></h4><dl><dt>ゴールの式を述べるブロック</dt><dd>${entryList(chapter.goalEntryIds)}</dd><dt>本文でこの章の見出しの下にある項目</dt><dd>${chapter.placedUnderChapterHeadingEntryIds.length}件 / ${chapter.entryCount}件</dd><dt>この章に入る項目（章の中の依存順）</dt><dd><details><summary>${chapter.entryCount}件を表示</summary>${entryList(ordered)}</details></dd></dl></section>`;
  }).join("");
  return `<h3>${escape(part.title)}</h3>${chapters}`;
}).join("");

const groups = inventory.mathematicalToolGroups.map((group: any) => {
  return `<section><h4>${escape(group.name)} <span>${group.entryIds.length}件</span></h4><dl><dt>主要な定義・定理・計算道具</dt><dd><details><summary>この分類に属する全項目を表示</summary>${entryList(group.entryIds)}</details></dd><dt>入力</dt><dd>${escape(group.input)}</dd><dt>出力</dt><dd>${escape(group.output)}</dd><dt>この論文に必要な理由</dt><dd>${escape(group.reason)}</dd></dl></section>`;
}).join("");

const html = `<!doctype html><html lang="ja"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>複素行列版2次元イジング模型 論文構成</title><style>${katexCss()}</style><style>
:root{color-scheme:light;--ink:#18202a;--sub:#64707d;--line:#d9dfe6;--accent:#7b2d26;--paper:#fbfaf6}*{box-sizing:border-box}body{margin:0;background:var(--paper);color:var(--ink);font-family:-apple-system,BlinkMacSystemFont,"Hiragino Sans","Yu Gothic",sans-serif;line-height:1.7;overflow-wrap:anywhere}main{max-width:960px;margin:auto;padding:48px 24px}h1{font-family:serif;font-size:clamp(2rem,5vw,3.4rem);line-height:1.2;margin:0 0 16px}h2{border-bottom:2px solid var(--ink);padding-bottom:8px;margin-top:52px}h3{margin:32px 0 8px}h4{color:var(--accent);margin:0}h4 span{font:normal .75rem sans-serif;color:var(--sub)}.lead{font-size:1.12rem;max-width:760px}.notice{border-left:5px solid var(--accent);padding:12px 18px;background:#fff;margin:28px 0}.stats{display:flex;gap:16px;flex-wrap:wrap}.stats div,section{background:#fff;border:1px solid var(--line)}.stats div{padding:12px 18px}.stats strong{display:block;font-size:1.7rem}section{padding:18px 22px;margin:14px 0}dl{margin:8px 0 0}dt{font-weight:700;margin-top:8px}dd{margin-left:0;color:#35404b}summary{cursor:pointer}ul{padding-left:1.4rem}.katex-display{overflow-x:auto;overflow-y:hidden}footer{margin-top:44px;color:var(--sub);font-size:.85rem}@media(max-width:600px){main{padding:28px 14px}section{padding:14px}.stats{display:grid;grid-template-columns:1fr 1fr}.stats div:first-child{grid-column:1/-1}}
</style></head><body><main><h1>複素行列版2次元イジング模型<br>論文構成</h1><p class="lead">${escape(inventory.organizingTheme)}</p><div class="notice"><strong>章の割り当て方</strong><br>${escape(inventory.chapterAssignmentRule)}</div><div class="stats"><div><strong>${inventory.entryCount}</strong>全定義・主張・定理</div><div><strong>${toolCount}</strong>数学的道具立て</div><div><strong>${progress.assignedChapterEntryCount}</strong>${chapterCount}個の章へ割り当てた項目</div><div><strong>${progress.unassignedIsingEntryCount}</strong>どの章のゴールからも辿れない項目</div></div><h2>再編の現在地</h2><p>全${inventory.entryCount}件のうち<strong>${assignedCount}件</strong>を、数学的道具立てと${chapterCount}個の章へ割り当てました。本文でその章の見出しの下に置かれている項目は${progress.placedUnderChapterHeadingEntryCount}件で、残りは章ごとの組み直しで移します。どの章のゴールからも辿れない${progress.unassignedIsingEntryCount}件は、本文のどこからも使われていなければ参照用ノートへ退避し、使われていれば使う章へ置きます。各定義・定理と証明を読む本文は、別の「論文本文」アーティファクトで公開しています。</p><h2>章立て</h2>${parts}<h2>どの章のゴールからも辿れない項目</h2><section>${entryList(inventory.unassignedIsingEntryIds)}</section><h2>後ろの章を指す案内の参照</h2><p>依存には数えない「後で使う」という案内の参照のうち、後ろの章か、どの章にも入らない項目を指すものです。本文を章ごとに組み直すときに、前方参照にならない書き方へ直します。</p><section><ul>${inventory.crossChapterNavigationReferences.map((reference: any) => `<li>${title(entryById.get(reference.fromEntryId))} → ${title(entryById.get(reference.toEntryId))}</li>`).join("")}</ul></section><h2>${escape(inventory.mathematicalToolPartTitle)}の分類</h2><p>${escape(inventory.classificationRule)}</p>${groups}<footer>機械可読棚卸しから生成（版 ${revision}）。数学的道具立て${toolCount}件は、上の分類群のいずれか一つに重複なく所属します。</footer></main></body></html>`;
mkdirSync(dirname(outputPath), { recursive: true });
writeFileSync(outputPath, html);
console.log(`wrote organization artifact to ${outputPath}`);
