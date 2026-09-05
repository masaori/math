import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "binary_ca_positive_count_claim_bound",
    kind: "claim",
    title: { text: "有限舞台の反復不動点数は配位の総数以下である" },
    labels: ["claim_binary_ca_fixed_point_count_bound"],
    verification: ["sagemath/check/positive-fixed-point-count-domain"],
    habitat: "N",
    statement: [
      paragraph(["有限舞台上の 2 値セルオートマトン（", ref("def_finite_ca"), "）の大域写像 ",
        math(String.raw`F:A^V\to A^V`), " と各 ", math(String.raw`n\in\mathbb{N}_{>0}`), " について"]),
      displayMath(String.raw`0\le Z_n(F)\le 2^{|V|}`),
      paragraph(["が成り立つ。個数は ", ref("def_fixed_points_of_iterate"), " による。"]),
    ],
    proof: [
      paragraph([ref("claim_finite_binary_ca_specializes_to_finite_self_map"), " により ",
        math(String.raw`X:=A^V`), " 上の有限自己写像に ", ref("claim_fixed_point_count_bounded_by_cardinality"),
        " を適用できる。零以上であることも同主張による。"]),
      displayMath(String.raw`\begin{aligned}
Z_n(F)&\le |X|\quad(\because\ \blkref{claim_fixed_point_count_bounded_by_cardinality})\\
&=2^{|V|}\quad(\because\ \blkref{claim_finite_binary_ca_specializes_to_finite_self_map}).
\end{aligned}`),
    ],
  },
  {
    id: "binary_ca_positive_count_claim_nonempty_domain",
    kind: "claim",
    title: { text: "有限舞台では正の不動点数を与える回数が必ず存在する" },
    labels: ["claim_binary_ca_positive_count_domain_nonempty"],
    verification: ["sagemath/check/positive-fixed-point-count-domain"],
    habitat: "N",
    statement: [
      paragraph([ref("claim_binary_ca_fixed_point_count_bound"), " と同じ有限舞台の大域写像 ",
        math(String.raw`F:A^V\to A^V`), " に対し、", ref("def_positive_fixed_point_count_domain"), " の集合は"]),
      displayMath(String.raw`\mathsf{Pos}_F\cap[1,2^{|V|}]_{\mathbb{N}}\ne\emptyset`),
      paragraph(["を満たす。空のセル集合も含むが、全ての正の回数が定義域に入るとは主張しない。"]),
    ],
    proof: [
      paragraph([ref("claim_finite_binary_ca_specializes_to_finite_self_map"), " により ",
        math(String.raw`X:=A^V`), " は有限で ", math(String.raw`|X|=2^{|V|}\ge1`),
        " だから空でない。", ref("claim_positive_count_domain_small_witness"),
        " をこの有限自己写像に適用すると ", math(String.raw`\mathsf{Pos}_F\cap[1,|X|]_{\mathbb{N}}\ne\emptyset`),
        "。上の元数を代入して主張を得る。"]),
    ],
  },
  {
    id: "binary_ca_positive_count_definition_single_cell_flip",
    kind: "definition",
    title: { text: "一セルの入れ替え規則" },
    labels: ["def_single_cell_flip_for_positive_count"],
    verification: ["sagemath/check/positive-fixed-point-count-domain"],
    habitat: "finite",
    statement: [
      paragraph(["セル集合 ", math(String.raw`V:=\{v\}`), "、近傍 ", math(String.raw`N(v):=\{v\}`),
        "、局所規則 ", math(String.raw`f_v:A^{\{v\}}\to A`), " を ",
        math(String.raw`f_v(z):=\nu(z(v))`), " で定める。", math(String.raw`A`), " と ",
        math(String.raw`\nu`), " は ", ref("def_state_set"), "、", ref("def_negation_map"), " による。",
        "この有限舞台の大域写像を ", math(String.raw`G:A^{\{v\}}\to A^{\{v\}}`), " と書く（",
        ref("def_global_map"), "）。配位は ", math(String.raw`x_0(v):=0`), "、", math(String.raw`x_1(v):=1`),
        " で定めた二つ ", math(String.raw`x_0,x_1\in A^{\{v\}}`), " だけである。"]),
    ],
  },
  {
    id: "binary_ca_positive_count_claim_single_cell_zero_count",
    kind: "claim",
    title: { text: "一セルの入れ替え規則は奇数回で不動点数が零になる" },
    labels: ["claim_single_cell_flip_positive_count_domain"],
    verification: ["sagemath/check/positive-fixed-point-count-domain"],
    habitat: "N",
    statement: [
      paragraph([ref("def_single_cell_flip_for_positive_count"), " の ", math(String.raw`G`), " について、各 ",
        math(String.raw`k\in\mathbb{N}`), " に対し"]),
      displayMath(String.raw`Z_{2k+1}(G)=0,\qquad Z_{2k+2}(G)=2`),
      paragraph(["である。したがって ", ref("def_positive_fixed_point_count_domain"), " の集合は、",
        ref("claim_binary_ca_positive_count_domain_nonempty"), " の非空性を満たすが、"]),
      displayMath(String.raw`\mathsf{Pos}_G=\{2m:m\in\mathbb{N}_{>0}\}\ne\mathbb{N}_{>0}`),
      paragraph(["となる。零個の場合を正の対数入力から除く条件は、有限舞台でも必要である。"]),
    ],
    proof: [
      paragraph(["各 ", math(String.raw`a\in A`), " について、唯一のセルで計算すると"]),
      displayMath(String.raw`\begin{aligned}
(Gx_a)(v)&=f_v(x_a|_{\{v\}})\quad(\because\ \blkref{def_global_map})\\
&=\nu((x_a|_{\{v\}})(v))\quad(\because\ \blkref{def_single_cell_flip_for_positive_count})\\
&=\nu(x_a(v))\quad(\because\ \blkref{def_restriction_map})\\
&=\nu(a)\quad(\because\ \blkref{def_single_cell_flip_for_positive_count})\\
&=x_{\nu(a)}(v)\quad(\because\ \blkref{def_single_cell_flip_for_positive_count}).
\end{aligned}`),
      paragraph(["写像の外延性により ", math(String.raw`Gx_a=x_{\nu(a)}`), "。したがって"]),
      displayMath(String.raw`\begin{aligned}
G^2x_a&=G(Gx_a)\quad(\because\ \blkref{def_finite_self_map_iterate})\\
&=Gx_{\nu(a)}\quad(\because\ \text{上の一回反復の計算})\\
&=x_{\nu(\nu(a))}\quad(\because\ \text{同じ計算を }\nu(a)\text{ に適用})\\
&=x_a\quad(\because\ \nu(\nu(a))=a.\ \blkref{def_negation_map}\text{ の二通りの値}).
\end{aligned}`),
      paragraph([math(String.raw`G^{2k}x_a=x_a`), " を ", math(String.raw`k\in\mathbb{N}`), " の帰納法で示す。",
        math(String.raw`k=0`), " は ", ref("def_finite_self_map_iterate"), " による。帰納段階は"]),
      displayMath(String.raw`\begin{aligned}
G^{2(k+1)}x_a&=G^{2+2k}x_a\quad(\because\ \text{自然数の算術})\\
&=G^2(G^{2k}x_a)\quad(\because\ \blkref{claim_iterate_composition_addition})\\
&=G^2x_a\quad(\because\ \text{帰納法の仮定})\\
&=x_a\quad(\because\ \text{上の二回反復の計算}).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
G^{2k+1}x_a&=G(G^{2k}x_a)\quad(\because\ \blkref{def_finite_self_map_iterate})\\
&=Gx_a\quad(\because\ \text{上で示した偶数回反復})\\
&=x_{\nu(a)}\quad(\because\ \text{局所真理値表の計算})\\
&\ne x_a\quad(\because\ \nu(a)\ne a.\ \blkref{def_negation_map}).
\end{aligned}`),
      paragraph(["全配位はこの二つだけなので、奇数回の不動点集合は空、正の偶数回では全配位である。",
        ref("def_fixed_points_of_iterate"), " によりそれぞれの元数は 0 と 2。自然数を 2 で割った余りは 0 または 1 なので、",
        ref("def_positive_fixed_point_count_domain"), " により表示した定義域を得る。1 はそこに属さない。"]),
    ],
  },
]);
