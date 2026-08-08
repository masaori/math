/**
 * 章「有限系の自由エントロピー」に紐づく参照用ノート。
 *
 * ノートは文書本体ではない（最終成果物は content/ だけから生成する）。
 * ここに置くのは、補足計算・具体例・物理的解釈・採用しなかった経路である。
 * 正しさに必要なことはノートではなく本文（statement / proof）に書く。
 */

import { defineNotes, math, paragraph } from "../schema.ts";

export default defineNotes([
  {
    id: "note_claim_free_entropy_at_one_physical_reading",
    targets: ["claim_free_entropy_at_one"],
    title: { text: "x=1 の物理的な読み方（本文には要らない）" },
    body: [
      paragraph([
        "物理の言葉では、",
        math(String.raw`x=e^{-2\beta J}`),
        " という対応を通して ",
        math(String.raw`x=1`),
        " は ",
        math(String.raw`\beta=0`),
        "、すなわち無限温度にあたる。そこではボルツマン重みがすべて等しくなり、",
        "分配関数は状態数そのものになる。本文の ",
        math(String.raw`\Phi_L(1)=L^2\ell_2`),
        " は、この点での自由エントロピーが「1 頂点あたり ",
        math(String.raw`\ell_2`),
        "」であることを述べており、",
        math(String.raw`\mathbb{R}`),
        " 上で書けば 1 頂点あたり ",
        math(String.raw`\log 2`),
        " という見慣れた式になる。",
      ]),
      paragraph([
        "この読み方は本文には書かない。",
        math(String.raw`x=e^{-2\beta J}`),
        " の対応を持ち込んだ時点で実数体へ出るからである（README「形式変数のまま進む」）。",
        "本文が主張しているのは、代入 ",
        math(String.raw`x\mapsto1`),
        " が有理数の代入であり、その結果が ",
        math(String.raw`\Lambda`),
        " の元として ",
        math(String.raw`L^2\ell_2`),
        " に等しいという、可算側だけで完結する事実である。",
      ]),
      paragraph([
        "同じ理由で、この主張を「無限温度のエントロピー密度は ",
        math(String.raw`\log 2`),
        "」と言い換えない。密度（1 頂点あたりの量）を取る操作は ",
        math(String.raw`L\to\infty`),
        " と組にして熱力学極限の章で扱い、そこが実数体への脱出点になる。",
        "有限の ",
        math(String.raw`L`),
        " では、",
        math(String.raw`\Phi_L(1)`),
        " を ",
        math(String.raw`L^2`),
        " で割る操作すら ",
        math(String.raw`\Lambda`),
        " の中では一般には行えない（",
        math(String.raw`\Lambda`),
        " は群であって、整数で割れる保証がない）。",
      ]),
    ],
  },
]);
