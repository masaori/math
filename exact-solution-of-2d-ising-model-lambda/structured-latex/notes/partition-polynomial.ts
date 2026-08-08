/**
 * 章「分配多項式」に紐づく参照用ノート。
 *
 * ノートは文書本体ではない（最終成果物は content/ だけから生成する）。
 * ここに置くのは、補足計算・具体例・物理的解釈・採用しなかった経路である。
 * 正しさに必要なことはノートではなく本文（statement / proof）に書く。
 */

import { defineNotes, displayMath, math, paragraph } from "../schema.ts";

export default defineNotes([
  {
    id: "note_def_partition_polynomial_why_no_substitution",
    targets: ["def_partition_polynomial"],
    title: { text: "なぜ x に指数を代入しないのか（採用しなかった経路）" },
    body: [
      paragraph([
        "物理の教科書は分配関数を ",
        math(String.raw`Z=\sum_\sigma e^{-\beta\mathcal{E}(\sigma)}`),
        " と定義する。エネルギーを ",
        math(String.raw`\mathcal{E}(\sigma)=-J|E_L|+2J\,m(\sigma)`),
        " と書けば、全体因子を外して ",
        math(String.raw`x=e^{-2\beta J}`),
        " とおくことで ",
        math(String.raw`\sum_\sigma x^{m(\sigma)}`),
        " が得られる。",
      ]),
      paragraph([
        "この経路は本文では採用しない。",
        math(String.raw`e^{-2\beta J}`),
        " は一般に超越数であり、代入した時点で係数環が ",
        math(String.raw`\mathbb{R}`),
        " へ移る。本プロジェクトが見たいのは「どこまで可算で閉じるか」なので、",
        "脱出を入口に置くとゴールそのものが失われる。",
      ]),
      paragraph([
        "代入は捨てるのではなく、脱出を宣言したブロックで最後に行う。",
        "そこが本プロジェクトの成果（可算／非可算の境界の位置）を示す点になる。",
      ]),
    ],
  },
  {
    id: "note_claim_coefficient_sum_small_example",
    targets: ["claim_coefficient_sum"],
    title: { text: "小さい例（4 サイクル）" },
    body: [
      paragraph([
        "格子ではなく 4 頂点の閉路（4 サイクル）で同じ数え上げをすると、",
        "破れボンド数の多重度は ",
        math(String.raw`\Omega(0)=2`),
        "、",
        math(String.raw`\Omega(2)=12`),
        "、",
        math(String.raw`\Omega(4)=2`),
        " であり、分配多項式は",
      ]),
      displayMath(String.raw`Z_{C_4}(x)=2+12x^2+2x^4\in\mathbb{Z}[x]`),
      paragraph([
        "となる。係数の総和は ",
        math(String.raw`2+12+2=16=2^4`),
        " で、頂点数 4 の配位の総数と一致する。",
      ]),
      paragraph([
        "有理点 ",
        math(String.raw`x=1/2`),
        " での値は ",
        math(String.raw`Z_{C_4}(1/2)=41/8=2^{-3}\cdot41`),
        " なので、対数順序群の元としては ",
        math(String.raw`\log Z_{C_4}(1/2)=\ell_{41}-3\ell_2\in\Lambda`),
        " である。章「有限系の自由エントロピー」で使う形の最小例になっている。",
      ]),
      paragraph([
        "本文の格子で ",
        math(String.raw`L=2`),
        " とした場合は、辺の添字が 8 個あり（4 サイクルの各辺が 2 重になる）",
        math(String.raw`Z_2(x)=2+12x^4+2x^8`),
        " となる。指数が 4 サイクルのちょうど 2 倍なのはそのためである。",
        math(String.raw`L=3`),
        " では ",
        math(String.raw`Z_3(x)=2+18x^4+48x^6+198x^8+144x^{10}+102x^{12}`),
        " で、係数の総和は ",
        math(String.raw`512=2^9`),
        " である（SageMath 検証 partition-polynomial-coefficient-sum の出力）。",
      ]),
      paragraph([
        "一次情報は docs/discussion/対数順序群上の統計力学/09_2DIsing閉形式の可算的導出.md。",
      ]),
    ],
  },
]);
