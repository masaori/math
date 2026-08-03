/**
 * **検査 O（定義の登場順序）**。本論文が定義する語・記号が、定義より前に現れていないこと、
 * および定義そのものが依存関係のトポロジカル順序に並んでいることを確かめる。
 *
 * 何をなぜ見るかは `definition-order-model.ts` の doc を正本とする。要点だけ:
 * **ある語が初めて現れる時点で、それが依存する語はすべて定義済みでなければならない。**
 * 見出しは本文より先に読まれるので、見出しも対象にする。
 */

import type { TranslatedNode } from "../schema.ts";
import { DEFINITION_ORDER_TERMS } from "./definition-order-terms.ts";
import { type OrderedBlock, violationsIn } from "./definition-order-model.ts";
import { knownLocales, loadContentFilesForLocale } from "./content-modules.ts";

const flatten = (nodes: readonly TranslatedNode[]): string => {
  let out = "";
  for (const node of nodes) {
    switch (node.type) {
      case "text":
      case "todo":
        out += ` ${node.value}`;
        break;
      case "math":
      case "displayMath":
        out += ` ${node.tex}`;
        break;
      case "paragraph":
        out += flatten(node.children);
        break;
      case "list":
        for (const item of node.items) out += flatten(item);
        break;
      default:
        break;
    }
  }
  return out;
};

let failed = 0;

console.log("");
console.log("定義の登場順序の検査（検査 O）");

for (const locale of knownLocales) {
  const terms = DEFINITION_ORDER_TERMS[locale] ?? [];
  const blocks: OrderedBlock[] = [];
  for (const { blocks: loaded } of await loadContentFilesForLocale(locale)) {
    for (const block of loaded) {
      const title = (block.kind === "figure" ? "" : (block.title?.text ?? "")) +
        " " + (block.kind === "figure" ? "" : (block.title?.tex ?? ""));
      const body = block.kind === "heading" || block.kind === "figure"
        ? ""
        : flatten(block.statement) + (block.proof === undefined ? "" : flatten(block.proof));
      blocks.push({
        index: blocks.length,
        id: block.id,
        kind: block.kind,
        labels: [...(block.labels ?? [])],
        title,
        text: `${title} ${body}`,
      });
    }
  }

  const violations = violationsIn(terms, blocks);
  console.log(
    `  ${locale}: ブロック ${blocks.length} 件 / 追跡する語 ${terms.length} 件 / 違反 ${violations.length} 件`,
  );
  if (violations.length === 0) continue;
  failed += violations.length;
  for (const violation of violations) {
    if (violation.kind === "定義より前に使われている") {
      console.log(
        `    [${violation.kind}] ${JSON.stringify(violation.token)}` +
          ` — ${violation.usedIn === "title" ? "見出し・題" : "本文"} #${violation.usedAt.index} ${violation.usedAt.id}` +
          ` で使われているが、定義は #${violation.definedAt.index} ${violation.definedAt.id}`,
      );
      continue;
    }
    if (violation.kind === "依存する語より前に定義されている") {
      console.log(
        `    [${violation.kind}] ${JSON.stringify(violation.token)} の定義 #${violation.definedAt.index}` +
          ` が、依存する ${JSON.stringify(violation.dependency)} の定義 #${violation.dependencyDefinedAt.index} より前にある`,
      );
      continue;
    }
    console.log(`    [${violation.kind}] ${JSON.stringify(violation.token)}`);
  }
}

if (failed > 0) {
  console.log("");
  console.log("  直し方: 定義を前へ移すか、章の構成を組み替えるか、初出の時点で定義を与える。");
  console.log("  「後で定義する」と断って先に使う形は認めない。");
  console.log("  その語を使わずに書ける箇所なら、使わない言い方へ書き直すのでもよい。");
  console.log("");
  console.log(`違反 ${failed} 件。`);
  process.exit(1);
}

console.log("");
console.log(
  "  限界: 追跡するのは台帳に載せた語だけで、本論文が定義しない標準的な語彙" +
    "（素点・Newton 多角形・Lehmer 問題等）は対象外。**台帳の網羅性がこの検査の強さの上限**である。",
);
console.log("");
console.log("違反 0 件。");
