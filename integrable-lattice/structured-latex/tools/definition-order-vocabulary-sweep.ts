/**
 * **散文の語の初出の全数走査を本文へ当てる部分**（検査 O の三つ目の拾い方）。
 *
 * 判定そのものは `definition-order-vocabulary-model.ts`、免除は
 * `definition-order-vocabulary-allowances.ts` が正本。ここは本文を読み込んで当て、印字する。
 *
 * 台帳（`definition-order-terms.ts`）を一切使わずに走査し、**挙がった語のうち
 * 台帳が覆っているものと覆っていないものを毎回数える**。この数が、台帳の拾い方
 * （定義の言い回しからの人手抽出）に散文の側でどれだけ漏れがあるかの実測値である。
 */

import type { TranslatedNode } from "../schema.ts";
import { knownLocales, loadContentFilesForLocale } from "./content-modules.ts";
import { DEFINITION_ORDER_TERMS } from "./definition-order-terms.ts";
import {
  type VocabularyBlock,
  type VocabularyTrace,
  coveredByLedger,
  traceVocabulary,
  usedBeforeNaming,
} from "./definition-order-vocabulary-model.ts";
import { VOCABULARY_SWEEP_ALLOWANCES } from "./definition-order-vocabulary-allowances.ts";

type Node = { kind: "text" | "math"; value: string };

const nodesIn = (nodes: readonly TranslatedNode[]): Node[] => {
  const out: Node[] = [];
  for (const node of nodes) {
    switch (node.type) {
      case "text":
      case "todo":
        out.push({ kind: "text", value: node.value });
        break;
      case "math":
      case "displayMath":
        out.push({ kind: "math", value: node.tex });
        break;
      case "paragraph":
        out.push(...nodesIn(node.children));
        break;
      case "list":
        for (const item of node.items) out.push(...nodesIn(item));
        break;
      default:
        break;
    }
  }
  return out;
};

export const vocabularyBlocksOf = async (locale: string): Promise<VocabularyBlock[]> => {
  const blocks: VocabularyBlock[] = [];
  for (const { blocks: loaded } of await loadContentFilesForLocale(locale)) {
    for (const block of loaded) {
      const title = block.kind === "figure" ? "" : (block.title?.text ?? "");
      const nodes = block.kind === "heading" || block.kind === "figure"
        ? []
        : [...nodesIn(block.statement), ...(block.proof === undefined ? [] : nodesIn(block.proof))];
      blocks.push({ index: blocks.length, id: block.id, kind: block.kind, title, nodes });
    }
  }
  return blocks;
};

const line = (trace: VocabularyTrace, tag: string): string =>
  `    [${tag}] ${JSON.stringify(trace.term)} — 初出 #${trace.firstAt.index} ${trace.firstAt.id}` +
  ` / 名づけ #${trace.definedAt.index} ${trace.definedAt.id}（${trace.via}）`;

/** 走査を回して印字し、処理が要る件数を返す。 */
export const reportVocabularySweep = async (): Promise<number> => {
  let problems = 0;

  console.log("");
  console.log("散文の語の初出の全数走査（検査 O の三つ目。台帳を使わない別の拾い方）");

  for (const locale of knownLocales) {
    const blocks = await vocabularyBlocksOf(locale);
    const traces = traceVocabulary(blocks, locale);
    const flagged = usedBeforeNaming(traces);

    const faces = (DEFINITION_ORDER_TERMS[locale] ?? []).flatMap((term) => [
      term.token,
      ...(term.aliases ?? []),
    ]);
    const allowed = VOCABULARY_SWEEP_ALLOWANCES[locale] ?? {};

    const covered = traces.filter((trace) => coveredByLedger(trace.term, faces));
    const uncovered = traces.filter((trace) => !coveredByLedger(trace.term, faces));
    const remaining = flagged.filter((trace) => allowed[trace.term] === undefined);

    console.log(
      `  ${locale}: ブロック ${blocks.length} 件 / 名づけられた語 ${traces.length} 件` +
        ` = 台帳が覆う ${covered.length} 件 ＋ 覆わない ${uncovered.length} 件`,
    );
    console.log(
      `    初出が名づけより前: ${flagged.length} 件` +
        `（理由つきで免除 ${flagged.length - remaining.length} 件 / 残り ${remaining.length} 件）`,
    );
    for (const trace of uncovered) console.log(line(trace, "台帳外"));
    for (const trace of remaining) console.log(line(trace, "要処理"));
    problems += remaining.length;

    for (const term of Object.keys(allowed)) {
      if (flagged.some((trace) => trace.term === term)) continue;
      console.log(`    [免除が古い] ${JSON.stringify(term)} は今は挙がらない。免除表から外すこと。`);
      problems += 1;
    }
  }

  if (problems > 0) {
    console.log("");
    console.log("  直し方: 名づけの位置を初出より前へ移すか、初出の側でその語を使わない書き方にする。");
    console.log("  同じ字面が別の対象を指しているなど順序の問題でないものは、免除表へ理由つきで書く。");
    return problems;
  }

  console.log("");
  console.log(
    "  限界: 名づけの位置は字面の規則（`:=` の直前・「と呼ぶ」等・定義ブロックの題）で決めるので、" +
      "それ以外の言い回しで導入される語には名づけの位置が付かない。" +
      "日本語は末尾が平仮名の語（「voltage 割り当て」）を原理的に拾えず、" +
      "左に付いた修飾は「を」「の」「と」で切るため落ちることがある。" +
      "英語は語順の都合で言い回しの直後を取るので、一般名詞の頭だけが残ることがある。",
  );
  return 0;
};
