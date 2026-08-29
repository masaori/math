/**
 * 章「合併作用の像は合併保存写像の全体である」。
 * 部分集合上の写像のうちどれが近傍割り当てから来るかを、写像側だけの条件
 * （空集合を保ち、二元の合併を保つ）で特徴づける。有限集合・有限部分集合・
 * 自然数だけを使い、R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "neighborhood_assignment_union_preserving_image_heading",
    kind: "heading",
    level: 1,
    title: { text: "合併作用の像は合併保存写像の全体である" },
    labels: [],
  },

  {
    id: "neighborhood_assignment_union_preserving_image_definition_union_preserving",
    kind: "definition",
    title: { text: "部分集合上の合併保存写像" },
    labels: ["def_union_preserving_subset_map"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " について、写像 ",
        math(String.raw`\Phi:\operatorname{Sub}(V)\to\operatorname{Sub}(V)`),
        "（", ref("def_finite_stage_subset_space"), " の部分集合全体の上の写像）が",
        "次の二条件をともに満たすとき、", math(String.raw`\Phi`), " は",
        "合併保存であるという。",
      ]),
      displayMath(String.raw`\Phi(\emptyset)=\emptyset`),
      displayMath(
        String.raw`\Phi(S\cup T)=\Phi(S)\cup\Phi(T)\qquad(S,T\in\operatorname{Sub}(V))`,
      ),
      paragraph([
        "合併保存な写像全体を ", math(String.raw`\operatorname{UP}(V)`),
        " と書く。この条件は写像 ", math(String.raw`\Phi`),
        " だけについて述べられており、近傍割り当てを参照していない。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_union_preserving_image_claim_empty",
    kind: "claim",
    title: { text: "合併写像は空集合を空集合へ送る" },
    labels: ["claim_subset_union_map_preserves_empty"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`N\in\mathcal N(V)`), " に対し、",
      ]),
      displayMath(String.raw`U_N(\emptyset)=\emptyset`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`w\in V`), " を取る。"]),
      displayMath(String.raw`\begin{aligned}
w\in U_N(\emptyset)
&\Longleftrightarrow \exists v\in\emptyset,\ w\in N(v)
  \qquad(\because\ \text{合併写像の定義})\\
&\Longleftrightarrow \bot
  \qquad(\because\ \text{空集合には元が無い})\\
&\Longleftrightarrow w\in\emptyset
  \qquad(\because\ \text{空集合には元が無い}).
\end{aligned}`),
      paragraph([
        math(String.raw`w`), " の任意性と部分集合の外延性から結論を得る（",
        ref("def_neighborhood_assignment_subset_union_map"), "）。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_union_preserving_image_claim_union",
    kind: "claim",
    title: { text: "合併写像は二元の合併を保つ" },
    labels: ["claim_subset_union_map_preserves_union"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`), "、",
        math(String.raw`S,T\in\operatorname{Sub}(V)`), " に対し、",
      ]),
      displayMath(String.raw`U_N(S\cup T)=U_N(S)\cup U_N(T)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`w\in V`), " を取る。"]),
      displayMath(String.raw`\begin{aligned}
w\in U_N(S\cup T)
&\Longleftrightarrow \exists v\in S\cup T,\ w\in N(v)
  \qquad(\because\ \text{合併写像の定義})\\
&\Longleftrightarrow \exists v\in V,\ (v\in S\lor v\in T)\land w\in N(v)
  \qquad(\because\ \text{合併への所属の定義})\\
&\Longleftrightarrow \exists v\in V,\ (v\in S\land w\in N(v))\lor(v\in T\land w\in N(v))
  \qquad(\because\ \text{論理和と論理積の分配})\\
&\Longleftrightarrow (\exists v\in S,\ w\in N(v))\lor(\exists v\in T,\ w\in N(v))
  \qquad(\because\ \text{存在量化と論理和の交換})\\
&\Longleftrightarrow w\in U_N(S)\lor w\in U_N(T)
  \qquad(\because\ \text{合併写像の定義})\\
&\Longleftrightarrow w\in U_N(S)\cup U_N(T)
  \qquad(\because\ \text{合併への所属の定義}).
\end{aligned}`),
      paragraph([
        math(String.raw`w`), " の任意性と部分集合の外延性から結論を得る（",
        ref("def_neighborhood_assignment_subset_union_map"), "）。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_union_preserving_image_claim_singleton_decomposition",
    kind: "claim",
    title: { text: "合併保存写像は一元部分集合での値だけで決まる" },
    labels: ["claim_union_preserving_map_determined_by_singletons"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と合併保存写像 ",
        math(String.raw`\Phi\in\operatorname{UP}(V)`), "（", ref("def_union_preserving_subset_map"),
        "）に対し、任意の ",
        math(String.raw`S\in\operatorname{Sub}(V)`), " について",
      ]),
      displayMath(String.raw`\Phi(S)=\bigcup_{v\in S}\Phi(\{v\})`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`|S|\in\mathbb N`), " についての帰納法で示す。",
      ]),
      paragraph([
        math(String.raw`|S|=0`), " の場合は ", math(String.raw`S=\emptyset`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\Phi(\emptyset)
&=\emptyset
  \qquad(\because\ \text{合併保存の第一条件})\\
&=\bigcup_{v\in\emptyset}\Phi(\{v\})
  \qquad(\because\ \text{空な添字集合上の合併は空集合}).
\end{aligned}`),
      paragraph([
        math(String.raw`n\in\mathbb N`), " について ", math(String.raw`|S|=n`),
        " の場合に主張が成り立つとする。", math(String.raw`|S|=n+1`),
        " とし、", math(String.raw`u\in S`), " を一つ取り ",
        math(String.raw`S':=S\setminus\{u\}`), " と置く。このとき ",
        math(String.raw`S=S'\cup\{u\}`), " かつ ", math(String.raw`|S'|=n`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Phi(S)
&=\Phi(S'\cup\{u\})
  \qquad(\because\ S=S'\cup\{u\})\\
&=\Phi(S')\cup\Phi(\{u\})
  \qquad(\because\ \text{合併保存の第二条件})\\
&=\Bigl(\bigcup_{v\in S'}\Phi(\{v\})\Bigr)\cup\Phi(\{u\})
  \qquad(\because\ \text{帰納法の仮定})\\
&=\bigcup_{v\in S'\cup\{u\}}\Phi(\{v\})
  \qquad(\because\ \text{添字集合の合併に沿った合併の分解})\\
&=\bigcup_{v\in S}\Phi(\{v\})
  \qquad(\because\ S=S'\cup\{u\}).
\end{aligned}`),
      paragraph([
        math(String.raw`V`), " が有限なので ", math(String.raw`|S|\in\mathbb N`),
        " であり、帰納法により全ての ", math(String.raw`S\in\operatorname{Sub}(V)`),
        " について結論を得る。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_union_preserving_image_claim_image_characterization",
    kind: "claim",
    title: { text: "合併作用の像は合併保存写像の全体に一致する" },
    labels: ["claim_subset_union_map_image_is_union_preserving_maps"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と写像 ",
        math(String.raw`\Phi:\operatorname{Sub}(V)\to\operatorname{Sub}(V)`),
        " に対し、",
      ]),
      displayMath(
        String.raw`\Phi\in\operatorname{UP}(V)
\iff \exists N\in\mathcal N(V),\ \Phi=U_N`,
      ),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "（", math(String.raw`\Longleftarrow`), "）", math(String.raw`\Phi=U_N`),
        " とする。", ref("claim_subset_union_map_preserves_empty"), " より ",
        math(String.raw`\Phi(\emptyset)=\emptyset`), " であり、",
        ref("claim_subset_union_map_preserves_union"), " より任意の ",
        math(String.raw`S,T\in\operatorname{Sub}(V)`), " について ",
        math(String.raw`\Phi(S\cup T)=\Phi(S)\cup\Phi(T)`), " である。",
        ref("def_union_preserving_subset_map"), " の二条件が満たされるので ",
        math(String.raw`\Phi\in\operatorname{UP}(V)`), " である。",
      ]),
      paragraph([
        "（", math(String.raw`\Longrightarrow`), "）",
        math(String.raw`\Phi\in\operatorname{UP}(V)`), " とする。写像 ",
        math(String.raw`N:V\to\mathcal P(V)`), " を ",
        math(String.raw`N(v):=\Phi(\{v\})`), " で定めると、",
        math(String.raw`\Phi(\{v\})\in\operatorname{Sub}(V)`), " なので ",
        math(String.raw`N\in\mathcal N(V)`), " である（",
        ref("def_finite_neighborhood_assignment_space"), "）。任意の ",
        math(String.raw`S\in\operatorname{Sub}(V)`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\Phi(S)
&=\bigcup_{v\in S}\Phi(\{v\})
  \qquad(\because\ \text{一元部分集合での値による決定})\\
&=\bigcup_{v\in S}N(v)
  \qquad(\because\ N\text{ の定義})\\
&=U_N(S)
  \qquad(\because\ \text{合併写像の定義}).
\end{aligned}`),
      paragraph([
        "第一段は ", ref("claim_union_preserving_map_determined_by_singletons"),
        "、第三段は ", ref("def_neighborhood_assignment_subset_union_map"),
        " による。", math(String.raw`S`), " の任意性と写像の外延性により ",
        math(String.raw`\Phi=U_N`), " である。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_union_preserving_image_claim_representation_unique",
    kind: "claim",
    title: { text: "合併保存写像を与える近傍割り当ては一意である" },
    labels: ["claim_union_preserving_map_representation_unique"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`\Phi\in\operatorname{UP}(V)`), " に対し、",
        math(String.raw`\Phi=U_N`), " を満たす ",
        math(String.raw`N\in\mathcal N(V)`), " はただ一つであり、",
      ]),
      displayMath(String.raw`N(v)=\Phi(\{v\})\qquad(v\in V)`),
      paragraph(["で与えられる。"]),
    ],
    proof: [
      paragraph([
        "存在は ", ref("claim_subset_union_map_image_is_union_preserving_maps"),
        " の（", math(String.raw`\Longrightarrow`), "）で示されている。",
      ]),
      paragraph([
        "一意性を示す。", math(String.raw`N,M\in\mathcal N(V)`), " が ",
        math(String.raw`U_N=\Phi=U_M`), " を満たすとする。",
        ref("claim_neighborhood_assignment_subset_union_map_injective"),
        " を等式 ", math(String.raw`U_N=U_M`), " に適用して ",
        math(String.raw`N=M`), " を得る。",
      ]),
      paragraph([
        "値の表示を示す。", math(String.raw`\Phi=U_N`), " とすると、任意の ",
        math(String.raw`v\in V`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\Phi(\{v\})
&=U_N(\{v\})
  \qquad(\because\ \Phi=U_N)\\
&=N(v)
  \qquad(\because\ \text{一元部分集合からの復元}).
\end{aligned}`),
      paragraph([
        "第二段は ", ref("claim_neighborhood_assignment_recovered_from_singletons"),
        " による。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_union_preserving_image_claim_count",
    kind: "claim",
    title: { text: "合併保存写像の個数" },
    labels: ["claim_union_preserving_map_count"],
    habitat: "N",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " について、",
      ]),
      displayMath(String.raw`|\operatorname{UP}(V)|=2^{|V|^2}\in\mathbb N`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "写像 ", math(String.raw`\mathcal N(V)\to\operatorname{UP}(V)`), " を ",
        math(String.raw`N\mapsto U_N`),
        " で定める。これは値が合併保存写像になるので定義できる（",
        ref("claim_subset_union_map_preserves_empty"), " と ",
        ref("claim_subset_union_map_preserves_union"), "）。この写像は ",
        ref("claim_neighborhood_assignment_subset_union_map_injective"),
        " より単射であり、", ref("claim_subset_union_map_image_is_union_preserving_maps"),
        " の（", math(String.raw`\Longrightarrow`), "）より全射である。",
        "したがって全単射であり、両辺の元数は等しい。",
      ]),
      displayMath(String.raw`\begin{aligned}
|\operatorname{UP}(V)|
&=|\mathcal N(V)|
  \qquad(\because\ \text{全単射の存在})\\
&=|\mathcal P(V)|^{|V|}
  \qquad(\because\ \text{写像の個数は終域の元数の始域の元数乗})\\
&=\bigl(2^{|V|}\bigr)^{|V|}
  \qquad(\because\ \text{冪集合の元数})\\
&=2^{|V|\cdot|V|}
  \qquad(\because\ \text{冪の冪の法則})\\
&=2^{|V|^2}
  \qquad(\because\ \text{積の指数表示}).
\end{aligned}`),
      paragraph([
        "各段の量は ", math(String.raw`\mathbb N`), " の元であり、",
        math(String.raw`\mathbb R`), " も ", math(String.raw`\mathbb C`),
        " も現れない。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_union_preserving_image_claim_finite_decidable",
    kind: "claim",
    title: { text: "合併保存性は有限決定できる" },
    labels: ["claim_union_preserving_map_finite_decidable"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と、写像 ",
        math(String.raw`\Phi:\operatorname{Sub}(V)\to\operatorname{Sub}(V)`),
        " の有限な値の表から、命題 ",
        math(String.raw`\Phi\in\operatorname{UP}(V)`),
        " の真偽を有限回の所属判定で決定でき、真の場合には ",
        math(String.raw`\Phi=U_N`), " を満たす ",
        math(String.raw`N\in\mathcal N(V)`), " を有限手続きで構成できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_finite_stage_subset_space"), " より ",
        math(String.raw`\operatorname{Sub}(V)`), " の元数は ",
        math(String.raw`2^{|V|}\in\mathbb N`), " である。",
      ]),
      paragraph([
        "第一条件 ", math(String.raw`\Phi(\emptyset)=\emptyset`), " は、",
        math(String.raw`|V|\in\mathbb N`), " 個の元について ",
        math(String.raw`w\in\Phi(\emptyset)`),
        " の真偽を調べれば決まる。",
      ]),
      paragraph([
        "第二条件は、", math(String.raw`(S,T)`), " の組が ",
        math(String.raw`2^{|V|}\cdot 2^{|V|}=2^{2|V|}\in\mathbb N`),
        " 個であり、各組について両辺の部分集合が表から定まるので、",
        math(String.raw`|V|`), " 個の元の所属判定で等号の真偽が決まる。",
        "よって全体で有限回の判定で第二条件の真偽が決まる。",
      ]),
      paragraph([
        "真の場合の構成は ", ref("claim_union_preserving_map_representation_unique"),
        " により ", math(String.raw`N(v):=\Phi(\{v\})`), " で与えられ、",
        math(String.raw`|V|`), " 個の一元部分集合について表を引くだけで得られる。",
      ]),
    ],
  },
]);
