/**
 * **検査 W（執筆指示の混入）**。全ロケールの本文・見出し・題に、
 * 書き手向けの指示や作業ツリー固有の語が混じっていないことを確かめる。
 *
 * 何をなぜ見るかは `authoring-leak-model.ts` の doc を正本とする。要点だけ:
 * **読者はこのリポジトリを開けない。** 作業の経緯は参照用ノートとコメントへ置き、本文から追い出す。
 */

import { relative } from "node:path";

import type { TranslatedNode } from "../schema.ts";
import {
  AUTHORING_LEAK_ALLOWANCES,
  type LeakSite,
  violationsIn,
} from "./authoring-leak-model.ts";
import {
  contentDirForLocale,
  knownLocales,
  loadContentFilesForLocale,
  structuredLatexDir,
} from "./content-modules.ts";

const collect = (
  nodes: readonly TranslatedNode[],
  base: Omit<LeakSite, "field" | "value">,
  out: LeakSite[],
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
        break;
    }
  }
};

const sites: LeakSite[] = [];
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
      if (block.kind === "figure") continue;
      const title = block.title?.text;
      // 見出し・題は本文より先に読まれるので、必ず見る。
      if (title !== undefined) sites.push({ ...base, field: "title", value: title });
      if (block.kind === "heading") continue;
      collect(block.statement, base, sites);
      if (block.proof !== undefined) collect(block.proof, base, sites);
    }
  }
  perLocale.push({ locale, blocks, sites: sites.length - before });
}

const violations = violationsIn(sites);

console.log("");
console.log("執筆指示の混入の検査（検査 W）");
console.log(
  `  走査: ロケール ${perLocale.length} 件 / ${perLocale
    .map((entry) => `${entry.locale}: ブロック ${entry.blocks}・地の文と題 ${entry.sites}`)
    .join(" / ")}`,
);
console.log(`  地の文と題 合計 ${sites.length} 件 / 台帳（読者への情報と判定したもの）${AUTHORING_LEAK_ALLOWANCES.length} 件`);
console.log("  見るもの: 作業ツリー固有の語（cycle 番号・step 番号・TODO 等）と、");
console.log("  書き手への指示の括弧（「（…明示する）」「（…述べる）」等）。**見出しと題も対象**。");

if (violations.length > 0) {
  console.log("");
  console.log(`  執筆指示が混じっている箇所 ${violations.length} 件`);
  for (const violation of violations) {
    console.log(
      `    [${violation.site.locale}] ${violation.site.blockId} (${violation.site.field}) — ${violation.kind}: ${JSON.stringify(violation.matched)}`,
    );
    console.log(`      ${violation.site.file}`);
    console.log(`      ${violation.site.value.slice(0, 100)}`);
  }
  console.log("");
  console.log("  直し方: 読者にとって意味を持たない記述を消す。作業の経緯を残したいなら");
  console.log("  参照用ノート（notes/）か TypeScript のコメントへ移す（どちらも最終成果物に載らない）。");
  console.log("  消した結果その箇所が何か分からなくなるなら、読者にとって意味のある言い方へ書き直す。");
  console.log("");
  console.log(`違反 ${violations.length} 件。`);
  process.exit(1);
}

console.log("");
console.log(
  "  限界: 落とせるのは閉じた語彙に当たる形だけで、「読者にとって意味があるか」は機械で判定できない。" +
    "語彙に無い言い回しの執筆指示は素通りする。",
);
console.log("");
console.log("違反 0 件。");
