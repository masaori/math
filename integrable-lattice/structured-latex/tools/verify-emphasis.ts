/**
 * **検査 E（ノードをまたぐ強調）**。全ロケールの地の文について、
 * 強調 `**…**` が同じノードの中で閉じていることを確かめる。
 *
 * 何をなぜ見るかは `emphasis-model.ts` の doc を正本とする。要点だけ:
 * **生成器 `applyBold` は日本語版で何もしないので、同じ書き方が日本語で通り英語で落ちる。**
 * その非対称が 3 サイクル連続の再発を生んだ。ここでは判定をロケールに依存させない。
 */

import { relative } from "node:path";

import type { TranslatedNode } from "../schema.ts";
import {
  contentDirForLocale,
  knownLocales,
  loadContentFilesForLocale,
  structuredLatexDir,
} from "./content-modules.ts";
import { editionFor } from "./editions.ts";
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

// 落とすのは強調を変換するロケールだけ（生成器が実際に落とす条件と同じにする）。
// 変換しないロケールの分は「そのまま訳すと落ちる形」の在庫として件数だけ出す。
const converting = knownLocales.filter((locale) => editionFor(locale).bold);
const notConverting = knownLocales.filter((locale) => !editionFor(locale).bold);

const violations = violationsIn(sites.filter((site) => converting.includes(site.locale)));
const inventory = violationsIn(sites.filter((site) => notConverting.includes(site.locale)));

console.log("");
console.log("ノードをまたぐ強調の検査（検査 E）");
console.log(
  `  走査: ロケール ${perLocale.length} 件 / ${perLocale
    .map((entry) => `${entry.locale}: ブロック ${entry.blocks}・地の文 ${entry.sites}`)
    .join(" / ")}`,
);
console.log(`  地の文 合計 ${sites.length} 件`);
console.log(
  `  違反として落とすロケール: ${converting.join(", ")}（editions.ts が bold: true と宣言する版）`,
);
console.log(
  `  落とさないロケール: ${notConverting.join(", ")}（bold: false。生成器が強調を変換しないので、` +
    "ノードをまたぐ強調がそのまま通る)",
);
console.log("");
console.log(
  `  **原文側の在庫: ${inventory.length} 件**（${notConverting.join(", ")} でノードをまたいでいる地の文）`,
);
console.log(
  "    ↑ この件数は違反ではない。**そのまま訳すと変換する版で落ちる形**の在庫である。" +
    "「原文では通っている」を理由に訳し写すと、必ずこの在庫から違反が生まれる。",
);

if (violations.length > 0) {
  console.log("");
  console.log(`  **閉じていない強調 ${violations.length} 件**`);
  for (const violation of violations) {
    console.log(
      `    [${violation.site.locale}] ${violation.site.blockId} (${violation.site.field}, ** が ${violation.markerCount} 個)`,
    );
    console.log(`      ${violation.site.file}`);
    console.log(`      ${violation.sample}`);
  }
  console.log("");
  console.log("  直し方: 強調を 1 つのノードの中で閉じる。数式をまたいで強調したいときは、");
  console.log("  数式の前後それぞれの地の文で開いて閉じる（`**…**` を 2 つに分ける）。");
  console.log("");
  console.log(`違反 ${violations.length} 件。`);
  process.exit(1);
}

console.log("");
console.log(
  "  限界: 見るのは地の文ノードの中の `**` の対応だけ。強調の内容が適切かは見ない。" +
    "`applyBold` が触る地の文（text / todo / cite.note）以外は対象外。",
);
console.log(
  "  別件（本検査の担当外・未修正）: 変換しない版は `**` を素のアスタリスクとして印字する。" +
    "詳細と実測は emphasis-model.ts の doc 末尾。",
);
console.log("");
console.log("違反 0 件。");
