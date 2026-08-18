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
        "各段階の出力は永続化されていないため停止した計算と、その先で再び容量上限に達するかは未確定である。現行経路がこの条件で再現可能に完了しないことだけが分かった。",
        math(String.raw`L=3`),
        " の次の検算では、各段階の出力を保存したうえで停止箇所を切り分ける必要がある。",
      ]),
    ],
  },
]);
