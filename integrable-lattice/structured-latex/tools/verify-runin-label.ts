/**
 * **検査 L（見出し代わりの断片）**。箇条書きの直前に、文になっていない短い段落が
 * 置かれていないことを確かめる。
 *
 * 何をなぜ見るかは `runin-label-model.ts` の doc を正本とする。
 */

import { relative } from "node:path";

import type { TranslatedNode } from "../schema.ts";
import {
  contentDirForLocale,
  knownLocales,
  loadContentFilesForLocale,
  structuredLatexDir,
} from "./content-modules.ts";
import { isRunInLabel, MAX_LENGTH, type RunInLabelSite } from "./runin-label-model.ts";

/** 段落を平たくする。数式は 1 文字として数える（長さの判定に効かせるため）。 */
const flatten = (nodes: readonly TranslatedNode[]): string => {
  let out = "";
  for (const node of nodes) {
    switch (node.type) {
      case "text":
      case "todo":
        out += node.value;
        break;
      case "math":
      case "displayMath":
        out += "◻";
        break;
      case "paragraph":
        out += flatten(node.children);
        break;
      default:
        break;
    }
  }
  return out;
};

const sites: RunInLabelSite[] = [];
const perLocale: { locale: string; paragraphs: number }[] = [];

for (const locale of knownLocales) {
  let paragraphs = 0;
  for (const { file, blocks } of await loadContentFilesForLocale(locale)) {
    for (const block of blocks) {
      if (block.kind === "heading" || block.kind === "figure") continue;
      const base = {
        locale,
        blockId: block.id,
        file: relative(structuredLatexDir, `${contentDirForLocale(locale)}/${file}`),
      };
      for (const where of ["statement", "proof"] as const) {
        const nodes: readonly TranslatedNode[] | undefined = block[where];
        if (nodes === undefined) continue;
        nodes.forEach((node, index) => {
          if (node.type !== "paragraph") return;
          paragraphs += 1;
          sites.push({
            ...base,
            where,
            text: flatten([node]),
            nextType: nodes[index + 1]?.type ?? "(末尾)",
          });
        });
      }
    }
  }
  perLocale.push({ locale, paragraphs });
}

console.log("");
console.log("見出し代わりの断片の検査（検査 L）");
console.log(
  `  走査: ${perLocale.map((entry) => `${entry.locale}: 段落 ${entry.paragraphs}`).join(" / ")}`,
);
console.log(
  `  判定: 箇条書きの直前にあり、${MAX_LENGTH} 文字以下で、文末が句点・コロン等でない段落`,
);
console.log(
  "  経緯: cycle 27 で強調指定を落としたとき、強調が唯一の区切りだった見出し代わりの断片が" +
    "区切りを失った（cycle 28 step 3 で日英 8 件ずつ直した）。",
);

const violations = sites.filter(isRunInLabel);

if (violations.length > 0) {
  console.log("");
  for (const site of violations) {
    console.log(`  [${site.locale}] ${site.blockId} (${site.where}): 「${site.text}」`);
  }
  console.log("");
  console.log("  直し方: 述語のある文にする（「〜は次のとおりである。」等）。");
  console.log("  強調を戻して見出しに見せる形は認めない（本文では強調を使わない）。");
  console.log("");
  console.log(`違反 ${violations.length} 件。`);
  process.exit(1);
}

console.log("");
console.log(
  "  限界: 見ているのは長さと文末の字だけで、「文になっているか」を判定してはいない。" +
    "捕まえるのは「見出しの代わりに置かれた短い断片」という形だけである。",
);
console.log("");
console.log("違反 0 件。");
