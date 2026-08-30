/**
 * 章「トーラス上の Kac--Ward 行列式」に紐づく検算・観察ノート。
 * 検算は証明ではなく、一般化できない有限標本を本文へ混ぜない。
 */

import { defineNotes, displayMath, math, paragraph } from "../schema.ts";

export default defineNotes([
  {
    id: "note_kac_ward_definition_determinants_even_subgraph_square_observation",
    targets: ["def_kac_ward_determinants"],
    title: { text: "行列式は符号付き偶部分グラフ多項式の平方（観察と経路の確定）" },
    body: [
      paragraph([
        "検証水準の計算として、一辺 ", math(String.raw`L=2,3`),
        " の周期正方格子で四つの Kac--Ward 行列式 ",
        math(String.raw`\det\bigl(I-x\,M^{a,b}\bigr)`),
        " を円分体 ", math(String.raw`\mathbb Q(\zeta_8)`),
        " 係数の多項式として厳密に計算し、全頂点の次数が偶数である台の辺の部分集合",
        "（偶部分グラフ）", math(String.raw`A`), " の切断線偶奇 ",
        math(String.raw`(h(A),v(A))`), " に符号 ",
        math(String.raw`(-1)^{c\,h+d\,v+e\,hv}`), "（", math(String.raw`c,d,e\in\{0,1\}`),
        " の全 8 候補）を付けた多項式の平方と比較した",
        "（sagemath/check/torus-kac-ward-even-subgraph-square）。",
      ]),
      paragraph([
        "結果、四つのスピン構造すべてで等式",
      ]),
      displayMath(String.raw`\det\bigl(I-x\,M^{a,b}\bigr)
=\Bigl(\sum_{A}(-1)^{(1+a)h(A)+(1+b)v(A)+h(A)v(A)}\,x^{|A|}\Bigr)^{2}`),
      paragraph([
        "が成り立った。スピン構造 ", math(String.raw`(0,1)`), " と ",
        math(String.raw`(1,0)`), " では二つの符号候補の平方が一致するが、これは正方トーラスの",
        "軸対称によりホモロジー類 ", math(String.raw`(1,0)`), " と ",
        math(String.raw`(0,1)`),
        " の類別和が多項式として一致するためで、等式の一意性とは矛盾しない。",
      ]),
      paragraph([
        "この観察は、台の辺を両向きに使う閉歩道（頂点単純な閉路族への反復分解の仮定から",
        "外れるもの）の扱いを確定する。行列式の置換展開の項は向き付き辺が相異なる非後退閉路の",
        "族であり、台の辺は両向きに現れうる。行列式が偶部分グラフ多項式（各台の辺を高々一度",
        "使う）の平方に一致する以上、両向きの項は相殺で消えるのではなく、平方の交差項",
        "（二つの偶部分グラフの重ね合わせで台の辺が二度使われる項）を担う。",
        "したがって両向きの閉歩道を除外する追加の分解は不要で、証明すべきは",
        "「行列式＝符号付き偶部分グラフ多項式の平方」という行列式レベルの恒等式である。",
        "反復分解（接触対数の整礎帰納）は、この恒等式の証明の中で各閉路の回転位相符号を",
        "確定するために使う。これは有限標本（", math(String.raw`L=2,3`),
        "）の観察であり、一般の ", math(String.raw`L`), " についてはまだ何も証明していない。",
      ]),
    ],
  },
]);
