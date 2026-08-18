/**
 * 章「臨界指数を零点列で書く」に紐づく検算・観察ノート。
 * 検算は証明ではなく、一般化できない有限標本を本文へ混ぜない。
 */

import { defineNotes, displayMath, math, paragraph } from "../schema.ts";

export default defineNotes([
  {
    id: "note_def_finite_size_scaling_reading_exact_observation",
    targets: ["def_finite_size_scaling_reading"],
    title: { text: "先頭距離の厳密検算と現時点の計算限界" },
    body: [
      paragraph([
        "検証水準の計算として、一辺 ", math(String.raw`L=2`),
        " の周期境界分配多項式・全 Fisher 零点・臨界点 ",
        math(String.raw`x_c=\sqrt2-1`),
        " への先頭距離を SageMath の ", math(String.raw`\mathbb Z[x]`),
        "、", math(String.raw`\overline{\mathbb Q}`), "、実代数的数体の中で厳密に求めた。",
      ]),
      displayMath(String.raw`Z_2=2(x^8+6x^4+1)`),
      paragraph([
        "先頭零点は複素共役な 2 個で、その最小多項式は ",
        math(String.raw`x^8+6x^4+1`), "、次数は 8、判別式は ",
        math(String.raw`68719476736`), " である。先頭距離の二乗 ",
        math(String.raw`d_1(2)`), " の最小多項式は",
      ]),
      displayMath(String.raw`x^4-8x^3+48x^2-48x+8`),
      paragraph([
        "で、次数は 4、判別式は ", math(String.raw`-110166016`), " である。実対数へ脱出して表示した ",
        math(String.raw`a_\rho(2)`), " は約 ", math(String.raw`1.1299803986682887`), " だった。",
      ]),
      paragraph([
        "一辺 ", math(String.raw`L=3`),
        " では、全距離を直接比較する経路と、包含区間で先頭候補を分離して候補距離だけを最小多項式へ変換する経路を試したが、",
        "どちらも PARI が数体を統合する段階でスタック上限 1 GiB に達した。したがって現行の全根分離経路で完了した上限は ",
        math(String.raw`L=2`), " である。有限標本が一点だけなので、最小多項式の次数・判別式・因数分解について本文へ昇格できる一般命題はまだ得られていない。",
      ]),
      paragraph([
        "追試として、PARI スタックを 8 GiB へ拡張して同じ経路を再実行したところ、540 秒内にはスタック超過が再発しなかったが完了しなかった。",
        "この回は各段階の出力を永続化しておらず、停止箇所は未確定だった。",
      ]),
      paragraph([
        "そこで段階・根ごとの経過秒つきログを永続化して再実行した（保存先は sagemath 側の l3-stage-log-2026-08-18.txt）。",
        "分配多項式の構成（次数 12）、全 12 根の分離、距離の二乗の 256 bit 包含区間の構成、先頭候補と他の全根との分離検証まで、すべて開始から 0.1 秒以内に完了した。",
        "停止しているのは最後の 1 段階、先頭距離の二乗 ",
        math(String.raw`d_1(3)`),
        " の最小多項式計算だけであり、この段階が 480 秒内に完了しなかった（スタック超過は再発していない）。",
        "したがって観測上の律速は根の分離でも区間分離でもなく、この代数的実数の最小多項式計算である。",
        math(String.raw`L=3`),
        " を完了させるには、終結式など ",
        math(String.raw`\mathbb{Z}[x]`),
        " 上の消去計算で ",
        math(String.raw`d_1(L)`),
        " の定義多項式を直接構成する別経路が要る。",
      ]),
      paragraph([
        "終結式による直接構成では、分配多項式の原始因子を ",
        math(String.raw`p_3(u)=51u^{12}+72u^{10}+99u^8+24u^6+9u^4+1`),
        " と置き、二つの根 ", math(String.raw`u,v`), " と臨界点 ",
        math(String.raw`c`), " に対する ",
        math(String.raw`d=(u-c)(v-c)`), " から ",
        math(String.raw`v=c+d/(u-c)`), " を消去した。",
        "二段の終結式の次数は 288、既約因子の（次数、重複度）は ",
        math(String.raw`(12,2),(24,1),(24,2),(96,2)`), " である。",
        "既存の 256 bit 包含区間で零を含む評価になるのは次数 96 の因子だけなので、これを整数係数の原始多項式へ直したものが ",
        math(String.raw`d_1(3)`), " の定義多項式になる。",
        "実対数へ脱出した読みは約 1.211 である。",
        math(String.raw`L=2,3`),
        " の二点だけでは一般則や収束先を一意に定められないため、本文へ昇格する命題候補はまだ無い。",
      ]),
    ],
  },
]);
