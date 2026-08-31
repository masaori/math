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
        "この観察により、一般の ", math(String.raw`L`), " で証明すべき候補は",
        "「行列式＝符号付き偶部分グラフ多項式の平方」という行列式レベルの恒等式である。",
        "ただし多項式全体の一致だけから、置換展開の個々の両向き項が相殺するか、平方の交差項へ",
        "どのように対応するかは決まらない。この項ごとの対応は一般の恒等式の証明で別に示す必要がある。",
        "反復分解（接触対数の整礎帰納）は、この恒等式の証明の中で各閉路の回転位相符号を",
        "確定するために使う。これは有限標本（", math(String.raw`L=2,3`),
        "）の観察であり、一般の ", math(String.raw`L`), " についてはまだ何も証明していない。",
      ]),
    ],
  },
  {
    id: "note_kac_ward_definition_cyclic_total_turning_vertex_simple_observation",
    targets: ["def_cyclic_total_turning"],
    title: { text: "頂点単純閉路の循環総回転数（観察と証明すべき候補の確定）" },
    body: [
      paragraph([
        "検証水準の計算として、一辺 ", math(String.raw`L=2,3,4`),
        " の周期正方格子で、通過の頂点が相異なる（接触対数零の）閉じた非後退辺列を",
        "全列挙し（基点と向きを区別した数え上げで全 ", math(String.raw`373{,}716`),
        " 本）、循環総回転数 ", math(String.raw`t_{\circ}(\gamma)`),
        " と切断線偶奇 ", math(String.raw`(h(\gamma)\bmod2,\ v(\gamma)\bmod2)`),
        " を突き合わせた（sagemath/check/vertex-simple-cycle-turning）。",
      ]),
      paragraph([
        "結果、次の候補（離散 Whitney の言明）が例外なく成り立った。切断線偶奇が ",
        math(String.raw`(0,0)`), " の頂点単純閉路（", math(String.raw`73{,}616`),
        " 本）は ", math(String.raw`t_{\circ}(\gamma)\in\{+4,-4\}`),
        "。切断線偶奇が ", math(String.raw`(0,0)`), " 以外の頂点単純閉路（",
        math(String.raw`300{,}100`), " 本）は ", math(String.raw`t_{\circ}(\gamma)=0`),
        "。",
      ]),
      paragraph([
        "帰結として、頂点単純閉路の回転位相は ",
        math(String.raw`\zeta_8^{\,t_{\circ}(\gamma)}=-1`),
        "（切断線偶奇 ", math(String.raw`(0,0)`), "）または ",
        math(String.raw`+1`),
        "（それ以外）であり、Kac--Ward 置換項の軌道因子の符号が切断線偶奇だけで決まる。",
        "これが平方恒等式の証明で各閉路の符号を確定する次の主張の候補である。",
        "これは有限標本（", math(String.raw`L=2,3,4`),
        "）の観察であり、一般の ", math(String.raw`L`), " についてはまだ何も証明していない。",
      ]),
    ],
  },
]);
