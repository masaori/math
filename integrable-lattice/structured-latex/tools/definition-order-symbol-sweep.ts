/**
 * **記号の初出の全数走査を本文へ当てる部分**（検査 O の後半）。
 *
 * 判定そのものは `definition-order-symbol-model.ts`、免除は
 * `definition-order-symbol-allowances.ts` が正本。ここは本文を読み込んで当て、印字する。
 *
 * 台帳（`definition-order-terms.ts`）を一切使わずに走査し、**挙がった記号のうち
 * 台帳が覆っているものと覆っていないものを毎回数える**。この数が、台帳の拾い方
 * （定義の言い回しからの人手抽出）にどれだけ漏れがあるかの実測値である。
 */

import type { TranslatedNode } from "../schema.ts";
import { knownLocales, loadContentFilesForLocale } from "./content-modules.ts";
import { DEFINITION_ORDER_TERMS } from "./definition-order-terms.ts";
import {
  type SweptBlock,
  type SymbolTrace,
  coveredByLedger,
  isBareSymbol,
  traceSymbols,
  usedBeforeDefinition,
} from "./definition-order-symbol-model.ts";
import { SYMBOL_SWEEP_ALLOWANCES } from "./definition-order-symbol-allowances.ts";

const mathIn = (nodes: readonly TranslatedNode[]): string[] => {
  const out: string[] = [];
  for (const node of nodes) {
    switch (node.type) {
      case "math":
      case "displayMath":
        out.push(node.tex);
        break;
      case "paragraph":
        out.push(...mathIn(node.children));
        break;
      case "list":
        for (const item of node.items) out.push(...mathIn(item));
        break;
      default:
        break;
    }
  }
  return out;
};

export const sweptBlocksOf = async (locale: string): Promise<SweptBlock[]> => {
  const blocks: SweptBlock[] = [];
  for (const { blocks: loaded } of await loadContentFilesForLocale(locale)) {
    for (const block of loaded) {
      const texts: string[] = [];
      if (block.kind !== "figure" && block.title?.tex !== undefined) texts.push(block.title.tex);
      if (block.kind !== "heading" && block.kind !== "figure") {
        texts.push(...mathIn(block.statement));
        if (block.proof !== undefined) texts.push(...mathIn(block.proof));
      }
      blocks.push({ index: blocks.length, id: block.id, kind: block.kind, texts });
    }
  }
  return blocks;
};

const line = (trace: SymbolTrace, tag: string): string =>
  `    [${tag}] ${JSON.stringify(trace.atom)} — 初出 #${trace.firstAt.index} ${trace.firstAt.id}` +
  ` / 定義 #${trace.definedAt!.index} ${trace.definedAt!.id}`;

/** 走査を回して印字し、処理が要る件数を返す。 */
export const reportSymbolSweep = async (): Promise<number> => {
  let problems = 0;

  console.log("");
  console.log("記号の初出の全数走査（検査 O の後半。台帳を使わない別の拾い方）");

  for (const locale of knownLocales) {
    const blocks = await sweptBlocksOf(locale);
    const traces = traceSymbols(blocks);
    const withDefinition = traces.filter((trace) => trace.definedAt !== undefined);
    const flagged = usedBeforeDefinition(traces);

    const faces = (DEFINITION_ORDER_TERMS[locale] ?? []).flatMap((term) => [
      term.token,
      ...(term.aliases ?? []),
    ]);
    const allowed = SYMBOL_SWEEP_ALLOWANCES[locale] ?? {};

    const bare = flagged.filter((trace) => isBareSymbol(trace.atom));
    const named = flagged.filter((trace) => !isBareSymbol(trace.atom));
    const remaining = named.filter((trace) => allowed[trace.atom] === undefined);
    const covered = remaining.filter((trace) => coveredByLedger(trace.atom, faces));
    const uncovered = remaining.filter((trace) => !coveredByLedger(trace.atom, faces));

    console.log(
      `  ${locale}: ブロック ${blocks.length} 件 / 走査した記号 ${traces.length} 件` +
        ` / うち \`:=\` の左辺に立つ記号 ${withDefinition.length} 件`,
    );
    console.log(
      `    初出が定義より前: ${flagged.length} 件` +
        `（裸の 1 記号 ${bare.length} 件は局所変数の使い回しなので外す / 飾りを持つ記号 ${named.length} 件）`,
    );
    console.log(
      `    飾りを持つ ${named.length} 件: 理由つきで免除 ${named.length - remaining.length} 件` +
        ` / 残り ${remaining.length} 件 = 台帳が覆う ${covered.length} 件 ＋ 覆わない ${uncovered.length} 件`,
    );
    for (const trace of uncovered) console.log(line(trace, "台帳外"));
    for (const trace of covered) console.log(line(trace, "台帳内"));
    problems += remaining.length;

    for (const atom of Object.keys(allowed)) {
      if (flagged.some((trace) => trace.atom === atom)) continue;
      console.log(`    [免除が古い] ${JSON.stringify(atom)} は今は挙がらない。免除表から外すこと。`);
      problems += 1;
    }
  }

  if (problems > 0) {
    console.log("");
    console.log("  直し方: 定義を初出より前へ移すか、初出の側でその記号を使わない書き方にする。");
    console.log("  同じ字面が別の量を指しているなど順序の問題でないものは、免除表へ理由つきで書く。");
    return problems;
  }

  console.log("");
  console.log(
    "  限界: 見るのは数式ノードの記号だけで、散文の語の初出は見ない（そちらは台帳の担当）。" +
      "定義の位置は `:=` の左辺で決めるので、`=` や散文だけで導入される記号には定義の位置が付かない。" +
      "裸の 1 記号は局所変数として使い回されるため、初めから外している。",
  );
  return 0;
};
