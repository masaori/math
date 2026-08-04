/**
 * **検査 E（本文に強調指定を書かない）**。全ロケールの地の文に `**` が 1 つも無いことを確かめる。
 *
 * 方針と理由は `emphasis-model.ts` の doc を正本とする。要点だけ:
 * **本文では強調（太字）を使わない**（2026-08-03 ユーザーの価値判断）。
 * 意味は文の構成と語の選択で担わせ、装飾に持たせない。
 * 3 サイクルにわたり強調は事故の種であり、記録では止まらないことが実証されているので検査にする。
 */

import { relative } from "node:path";

import type { TranslatedNode } from "../schema.ts";
import {
  contentDirForLocale,
  knownLocales,
  loadContentFilesForLocale,
  structuredLatexDir,
} from "./content-modules.ts";
import { type ProseSite, violationsIn } from "./emphasis-model.ts";

const collect = (
  nodes: readonly TranslatedNode[],
  base: Omit<ProseSite, "field" | "value">,
  out: ProseSite[],
): void => {
  for (const node of nodes) {
    switch (node.type) {
      case "text":
        out.push({ ...base, field: "text", value: node.value });
        break;
      case "todo":
        out.push({ ...base, field: "todo", value: node.value });
        break;
      case "cite":
        if (node.note !== undefined) out.push({ ...base, field: "cite.note", value: node.note });
        break;
      case "paragraph":
        collect(node.children, base, out);
        break;
      case "list":
        for (const item of node.items) collect(item, base, out);
        break;
      default:
        // math / displayMath / ref / image は地の文ではない（applyBold を通らない）。
        break;
    }
  }
};

const sites: ProseSite[] = [];
const perLocale: { locale: string; blocks: number; sites: number }[] = [];

for (const locale of knownLocales) {
  const files = await loadContentFilesForLocale(locale);
  const before = sites.length;
  let blocks = 0;
  for (const { file, blocks: loaded } of files) {
    for (const block of loaded) {
      blocks += 1;
      const base = {
        locale,
        blockId: block.id,
        file: relative(structuredLatexDir, `${contentDirForLocale(locale)}/${file}`),
      };
      if (block.kind === "figure") continue; // 図版は地の文を持たない（本論文は 0 件）
      // 題は任意（付けないブロックがある）。付いていればそれも地の文である。
      const title = block.title?.text;
      if (title !== undefined) sites.push({ ...base, field: "text", value: title });
      if (block.kind === "heading") continue;
      collect(block.statement, base, sites);
      if (block.proof !== undefined) collect(block.proof, base, sites);
    }
  }
  perLocale.push({ locale, blocks, sites: sites.length - before });
}

console.log("");
console.log("本文に強調指定を書かない検査（検査 E）");
console.log(
  `  走査: ロケール ${perLocale.length} 件 / ${perLocale
    .map((entry) => `${entry.locale}: ブロック ${entry.blocks}・地の文 ${entry.sites}`)
    .join(" / ")}`,
);
console.log(`  地の文 合計 ${sites.length} 件`);
console.log("  方針: 本文では強調（太字）を使わない。地の文に `**` を書かない（ロケールに依らず違反）。");

const violations = violationsIn(sites);

if (violations.length > 0) {
  console.log("");
  console.log(`  強調指定が書かれている地の文 ${violations.length} 件`);
  for (const violation of violations) {
    console.log(
      `    [${violation.site.locale}] ${violation.site.blockId} (${violation.site.field}, ** が ${violation.markerCount} 個)`,
    );
    console.log(`      ${violation.site.file}`);
    console.log(`      ${violation.sample}`);
  }
  console.log("");
  console.log("  直し方: `**` を消す。強調で持たせていた意味は、文の構成か語の選択で担わせる");
  console.log("  （装飾に意味を持たせない）。");
  console.log("");
  console.log(`違反 ${violations.length} 件。`);
  process.exit(1);
}

console.log("");
console.log(
  "  限界: 見るのは `**` だけ。強調を外したときに意味が落ちていないかは機械で確かめられない" +
    "（人が読んで書き換える）。参照用ノートは最終成果物に載らないので対象外。",
);
console.log("");
console.log("違反 0 件。");
