/**
 * **検査 Λ（対数順序群の記号）**。
 *
 * 記号 $\Lambda$ を対数順序群以外の意味で使ったら落ちる。
 * 何を見て何を見ないかは `lambda-symbol-model.ts` の doc が正本。
 *
 * 実行: `npm run verify:lambda-symbol`
 */

import type { TranslatedNode } from "../schema.ts";
import { knownLocales, loadContentFilesForLocale } from "./content-modules.ts";
import {
  auditLambdaSymbol,
  type LambdaAllowance,
  type LambdaUseSite,
} from "./lambda-symbol-model.ts";

/**
 * この記号を使ってよいブロックの台帳。
 * 初期値は cycle 31 step 2 の実測（改名後に残った全用例を 1 件ずつ読んで登録した）。
 */
const LAMBDA_ALLOWANCES: readonly LambdaAllowance[] = [
  {
    block: "paper_012_definition_ladder",
    reason:
      "決定可能性の梯子を定める定義ブロック。対数順序群 $\\Lambda=\\bigoplus_p\\mathbb{Z}\\ell_p$ を" +
      "ここで導入し、$\\log q\\in\\Lambda$ を定める。**本論文でこの記号を定義してよい唯一のブロック**である。",
    defines: true,
  },
  {
    block: "paper_023_definition_massieu",
    reason: "Massieu 自由エントロピー $\\Phi_N:=\\log Z_N(q)$ がこの群に属することを述べる。",
  },
  {
    block: "paper_071_remark_asymmetry",
    reason:
      "難しさの非対称の地図。実数側に連続ギャップ（Lehmer 問題）があるのに対し、" +
      "この群の側は離散・決定可能であることを述べる。",
  },
  {
    block: "paper_072_remark_qp_free",
    reason: "この群での等号が素因数分解の一致であること（有限手続きと witness の水準）を述べる。",
  },
  {
    block: "paper_014_remark_survey_scope",
    reason:
      "英語版だけにある読者案内。梯子の記号を読者へ紹介し、この群の側の量が離散であることを述べる" +
      "（原文の日本語版にはこのブロックが無い）。",
  },
  {
    block: "paper_015_remark_reading_guide",
    reason:
      "英語版だけにある読者案内の続き。梯子 $\\mathbb{N},\\mathbb{Z},\\mathbb{Q},\\Lambda,\\overline{\\mathbb{Q}}$ を" +
      "並べて示す（原文の日本語版にはこのブロックが無い）。",
  },
  {
    block: "paper_202_remark_prior_art_countabilisation",
    reason:
      "英語版だけにある先行研究の節。実数と $p$ 進数の理論が決定可能にならないのに対し、" +
      "ここで使うこの群の側では等号が決定可能であることを述べる。",
  },
];

const collect = (
  nodes: readonly TranslatedNode[],
  base: Omit<LambdaUseSite, "tex">,
  out: LambdaUseSite[],
): void => {
  for (const node of nodes) {
    switch (node.type) {
      case "math":
      case "displayMath":
        if (node.tex.includes("\\Lambda")) out.push({ ...base, tex: node.tex });
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

const sites: LambdaUseSite[] = [];
const perLocale: { locale: string; sites: number }[] = [];

for (const locale of knownLocales) {
  const before = sites.length;
  for (const { file, blocks } of await loadContentFilesForLocale(locale)) {
    for (const block of blocks) {
      if (block.kind === "heading" || block.kind === "figure") continue;
      collect(
        [...block.statement, ...(block.proof ?? [])],
        { blockId: block.id, locale, file },
        sites,
      );
    }
  }
  perLocale.push({ locale, sites: sites.length - before });
}

const audit = auditLambdaSymbol({ sites, allowances: LAMBDA_ALLOWANCES });

console.log("");
console.log("対数順序群の記号の検査（検査 Λ）");
console.log("  方針: 記号 \\Lambda は対数順序群にのみ使う（2026-08-04 ユーザー判断）。");
console.log(
  `  走査: ロケール ${perLocale.length} 件（${perLocale
    .map((entry) => `${entry.locale}: ${entry.sites}`)
    .join(" / ")}）/ 出現 ${audit.siteCount} 件 / 使っているブロック ${audit.blockCount} 件 / ` +
    `台帳 ${LAMBDA_ALLOWANCES.length} 件`,
);
console.log(
  "  見るのは 3 つ: 飾り（\\Lambda_ / \\Lambda^ / \\Lambda( ）が付いていないこと、" +
    "定義してよいブロック以外が \\Lambda:= を書いていないこと、使っているブロックが台帳にあること。",
);

if (audit.violations.length > 0) {
  console.log("");
  for (const violation of audit.violations) console.log(`    ${violation}`);
  console.log("");
  console.log(
    "  直し方: その \\Lambda が対数順序群でないなら別の記号へ改名する" +
      "（先例: 例外直線の和は \\lambda_{\\mathrm{exc}}、\\min_j(e_j+j\\ell^r) は \\mathcal{E}(r)、" +
      "\\min_m v_\\ell(A^{[k]}_m) は \\mathcal{V}_k）。対数順序群なら台帳へ理由つきで登録する。",
  );
  console.log("");
  console.log(`違反 ${audit.violations.length} 件。`);
  process.exit(1);
}

console.log(
  "  限界: 既に台帳にあるブロックの中で、裸の \\Lambda を別の量に使うことは止められない" +
    "（「この \\Lambda は対数順序群か」は本文を読む判断である）。" +
    "止まるのは、飾りを付ける形・定義し直す形・新しいブロックで使い始める形の 3 つだけであり、" +
    "この 3 つは現に起きた 3 件から逆算した規則であって原理から出たものではない。",
);
console.log("");
console.log("違反 0 件。");
