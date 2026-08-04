/**
 * 検査 L（見出し代わりの断片）。文になっていない短い段落が、次の要素を導く見出しの
 * 代わりに置かれていないことを確かめる。
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
import {
  END_OF_BLOCK,
  isRunInLabel,
  MAX_LENGTH,
  RESTRICTED_NEXT_TYPES,
  type RunInLabelSite,
} from "./runin-label-model.ts";

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

/** 直後の要素の日本語名。件数を出すときに、種別名だけを並べても読めないため添える。 */
const nextElementName = (nextType: string): string =>
  ({
    paragraph: "段落",
    list: "箇条書き",
    displayMath: "別行立て数式",
    [END_OF_BLOCK]: "何も無い（ブロックの末尾）",
  })[nextType] ?? nextType;

/** 段落から見た位置の名前。「直後が段落」ではなく「段落の直前」と読ませる。 */
const positionName = (nextType: string): string =>
  nextType === END_OF_BLOCK ? "ブロックの末尾" : `${nextElementName(nextType)}の直前`;

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
          const children: readonly TranslatedNode[] = node.children;
          const afterDisplay = nodes[index + 2];
          sites.push({
            ...base,
            where,
            text: flatten([node]),
            nextType: nodes[index + 1]?.type ?? END_OF_BLOCK,
            containsMath: children.some((child) => child.type === "math"),
            containsReference: children.some(
              (child) => child.type === "ref" || child.type === "cite",
            ),
            textAfterDisplay:
              afterDisplay !== undefined && afterDisplay.type === "paragraph"
                ? flatten([afterDisplay]).trim()
                : undefined,
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
  `  判定: ${MAX_LENGTH} 文字以下で、文末が句点・コロン等でない段落` +
    `（直後が${RESTRICTED_NEXT_TYPES.map(nextElementName).join("・")}のものは、` +
    `さらに体言だけの断片の形であることも要る）`,
);

// どの形をいくつ見ているかを毎回出す。判定の対象が黙って痩せたことに気づけるようにするため
// （cycle 29 step 5 で、箇条書きの直前だけを見る形から広げた）。
const countsByNextType = new Map<string, number>();
for (const site of sites) {
  countsByNextType.set(site.nextType, (countsByNextType.get(site.nextType) ?? 0) + 1);
}
const watched = [...countsByNextType].filter(([type]) => !RESTRICTED_NEXT_TYPES.includes(type));
const restricted = [...countsByNextType].filter(([type]) => RESTRICTED_NEXT_TYPES.includes(type));
const total = (entries: readonly (readonly [string, number])[]) =>
  entries.reduce((sum, [, count]) => sum + count, 0);
console.log(
  `  長さと文末で見る: ${total(watched)} 段落（${watched
    .sort((a, b) => b[1] - a[1])
    .map(([type, count]) => `${positionName(type)} ${count}`)
    .join(" / ")}）`,
);
console.log(
  `  体言だけの断片の形に限って見る: ${total(restricted)} 段落（${restricted
    .map(([type, count]) => `${positionName(type)} ${count}`)
    .join(" / ")}）。数式へ続く言い回しが長さと文末の判定を満たすため、` +
    `数式・相互参照・句点を含まず体言で終わる断片だけを見る。`,
);
console.log(
  "  経緯: cycle 27 で強調指定を落としたとき、強調が唯一の区切りだった見出し代わりの断片が" +
    "区切りを失った（cycle 28 step 3 で日英 8 件ずつ直した）。",
);

const violations = sites.filter(isRunInLabel);

if (violations.length > 0) {
  console.log("");
  for (const site of violations) {
    console.log(
      `  [${site.locale}] ${site.blockId} (${site.where}, ${positionName(site.nextType)}): ` +
        `「${site.text}」`,
    );
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
    "捕まえるのは「見出しの代わりに置かれた短い断片」という形だけである。" +
    "別行立て数式の直前では体言だけの断片しか拾えず、助詞で終わる見出しは拾えない。" +
    "箇条書きの項目の中は見ない。",
);
console.log("");
console.log("違反 0 件。");
