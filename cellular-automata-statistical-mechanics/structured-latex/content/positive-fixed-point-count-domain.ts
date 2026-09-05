import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "positive_fixed_point_count_definition_domain",
    kind: "definition",
    title: { text: "正の不動点数を与える反復回数の集合" },
    labels: ["def_positive_fixed_point_count_domain"],
    habitat: "countable",
    statement: [
      paragraph(["有限集合上の自己写像 ", math(String.raw`F:X\to X`), "（", ref("def_finite_self_map"),
        "）について、", ref("def_fixed_points_of_iterate"), " の個数を用いて"]),
      displayMath(String.raw`\mathsf{Pos}_F:=\{n\in\mathbb{N}_{>0}:Z_n(F)>0\}\subseteq\mathbb{N}_{>0}`),
      paragraph(["と定める。", math(String.raw`\mathbb{N}_{>0}:=\{n\in\mathbb{N}:n\ge1\}`),
        " であり、", math(String.raw`\mathsf{Pos}_F`), " は高々可算である。有限集合であるとは仮定しない。"]),
    ],
  },
  {
    id: "positive_fixed_point_count_definition_period_set",
    kind: "definition",
    title: { text: "周期点で実現する最小周期の有限集合" },
    labels: ["def_realized_period_set"],
    habitat: "finite",
    statement: [
      paragraph(["有限自己写像 ", math(String.raw`F:X\to X`), " に対し、",
        ref("def_periodic_points"), " と ", ref("def_min_period"), " を用いて"]),
      displayMath(String.raw`\mathsf{Len}_F:=\{\pi(y):y\in\mathrm{Per}(F)\}\subseteq\mathbb{N}_{>0}`),
      paragraph(["と定める。有限集合 ", math(String.raw`\mathrm{Per}(F)\subseteq X`),
        " の写像による像なので有限である。"]),
    ],
  },
  {
    id: "positive_fixed_point_count_claim_bound",
    kind: "claim",
    title: { text: "反復の不動点数は零以上で台の元数以下である" },
    labels: ["claim_fixed_point_count_bounded_by_cardinality"],
    habitat: "N",
    statement: [
      paragraph(["有限自己写像 ", math(String.raw`F:X\to X`), " と各 ", math(String.raw`n\in\mathbb{N}_{>0}`), " について"]),
      displayMath(String.raw`0\le Z_n(F)\le |X|`),
      paragraph(["が成り立つ（", ref("def_fixed_points_of_iterate"), "）。"]),
    ],
    proof: [
      paragraph([math(String.raw`Z_n(F)\in\mathbb{N}`), " なので零以上である。上界は"]),
      displayMath(String.raw`\begin{aligned}
Z_n(F)&=|\mathrm{Fix}_n(F)|\quad(\because\ \blkref{def_fixed_points_of_iterate})\\
&\le |X|\quad(\because\ \mathrm{Fix}_n(F)\subseteq X\ \text{と有限集合の包含による元数の単調性}).
\end{aligned}`),
    ],
  },
  {
    id: "positive_fixed_point_count_claim_domain_divisibility",
    kind: "claim",
    title: { text: "正の不動点数の定義域は実現する最小周期の倍数全体である" },
    labels: ["claim_positive_count_domain_iff_period_divides"],
    habitat: "countable",
    statement: [
      paragraph(["有限自己写像 ", math(String.raw`F:X\to X`), " と各 ", math(String.raw`n\in\mathbb{N}_{>0}`),
        " について、", ref("def_positive_fixed_point_count_domain"), " と ", ref("def_realized_period_set"), " の集合は"]),
      displayMath(String.raw`n\in \mathsf{Pos}_F\iff\exists d\in \mathsf{Len}_F\ \exists k\in\mathbb{N}_{>0}\ (n=kd)`),
      paragraph(["を満たす。特に零個となるのは、実現する最小周期のどれの倍数でもない回数である。"]),
    ],
    proof: [
      paragraph([math(String.raw`n\in\mathbb{N}_{>0}`), " を固定する。以下で ", math(String.raw`y\in X`),
        "、", math(String.raw`d,k\in\mathbb{N}`), " とする。"]),
      displayMath(String.raw`\begin{aligned}
n\in \mathsf{Pos}_F
&\iff Z_n(F)>0\quad(\because\ \blkref{def_positive_fixed_point_count_domain})\\
&\iff |\mathrm{Fix}_n(F)|>0\quad(\because\ \blkref{def_fixed_points_of_iterate})\\
&\iff \exists y\in\mathrm{Fix}_n(F)\quad(\because\ \text{有限集合の正の元数と非空性})\\
&\iff \exists y\in X\ (\mu(y)=0\ \land\ \exists k\in\mathbb{N}\ (n=k\pi(y)))
  \quad(\because\ \blkref{claim_fixed_iff_min_period_divides})\\
&\iff \exists y\in\mathrm{Per}(F)\ \exists k\in\mathbb{N}\ (n=k\pi(y))
  \quad(\because\ \blkref{claim_periodic_iff_min_preperiod_zero})\\
&\iff \exists d\in \mathsf{Len}_F\ \exists k\in\mathbb{N}\ (n=kd)
  \quad(\because\ \blkref{def_realized_period_set})\\
&\iff \exists d\in \mathsf{Len}_F\ \exists k\in\mathbb{N}_{>0}\ (n=kd)
  \quad(\because\ n>0\ \text{より } k=0\ \text{は不可能}).
\end{aligned}`),
      paragraph(["零の場合の記述は、", math(String.raw`Z_n(F)\in\mathbb{N}`), " のもとで正でないことと零であることが同値なことによる。"]),
    ],
  },
  {
    id: "positive_fixed_point_count_claim_small_positive_exponent",
    kind: "claim",
    title: { text: "空でない有限集合では元数以下の回数で正の不動点数を得る" },
    labels: ["claim_positive_count_domain_small_witness"],
    habitat: "N",
    statement: [
      paragraph(["有限自己写像 ", math(String.raw`F:X\to X`), " について"]),
      displayMath(String.raw`X\ne\emptyset\iff \mathsf{Pos}_F\cap[1,|X|]_{\mathbb{N}}\ne\emptyset`),
      paragraph(["が成り立つ。", math(String.raw`\mathsf{Pos}_F`), " は ", ref("def_positive_fixed_point_count_domain"), " による。"]),
    ],
    proof: [
      paragraph(["順方向では ", math(String.raw`x\in X`), " を取り、", ref("claim_orbit_collision"),
        " により ", math(String.raw`i,j\in\mathbb{N}`), " で ", math(String.raw`0\le i<j\le |X|`),
        "、", math(String.raw`F^i x=F^j x`), " を満たすものを取る。",
        math(String.raw`p:=j-i\in\mathbb{N}_{>0}`), "、", math(String.raw`y:=F^i x\in X`),
        " と置く。", math(String.raw`1\le p\le |X|`), " である。"]),
      displayMath(String.raw`\begin{aligned}
F^p y&=F^p(F^i x)\quad(\because\ y=F^i x)\\
&=F^{p+i}x\quad(\because\ \blkref{claim_iterate_composition_addition})\\
&=F^j x\quad(\because\ p+i=j)\\
&=F^i x\quad(\because\ \text{選んだ衝突})\\
&=y\quad(\because\ y=F^i x).
\end{aligned}`),
      paragraph(["したがって ", math(String.raw`y\in\mathrm{Fix}_p(F)`), "（", ref("def_fixed_points_of_iterate"),
        "）であり、有限集合の元数は正であるから ", math(String.raw`p\in \mathsf{Pos}_F`), "（",
        ref("def_positive_fixed_point_count_domain"), "）。これが右辺の証人になる。"]),
      paragraph(["逆方向では右辺から ", math(String.raw`p\in \mathsf{Pos}_F`), " を取る。",
        ref("def_positive_fixed_point_count_domain"), " により ", math(String.raw`Z_p(F)>0`), " なので、",
        ref("claim_fixed_point_count_bounded_by_cardinality"), " より ", math(String.raw`|X|>0`),
        "。有限集合の正の元数と非空性により ", math(String.raw`X\ne\emptyset`), "。"]),
    ],
  },
  {
    id: "positive_fixed_point_count_claim_finite_encoding",
    kind: "claim",
    title: { text: "正の不動点数の定義域は有限な周期の表から決定できる" },
    labels: ["claim_positive_count_domain_finitely_decidable"],
    habitat: "N",
    statement: [
      paragraph(["有限自己写像 ", math(String.raw`F:X\to X`), " の表から、",
        ref("def_realized_period_set"), " の有限集合 ", math(String.raw`\mathsf{Len}_F\subseteq[1,|X|]_{\mathbb{N}}`),
        " を計算できる。入力 ", math(String.raw`n\in\mathbb{N}_{>0}`), " が ",
        ref("def_positive_fixed_point_count_domain"), " の ", math(String.raw`\mathsf{Pos}_F`),
        " に属するかは、この表の各元による剰余の零判定で決まる。"]),
    ],
    proof: [
      paragraph([ref("claim_min_preperiod_period_finite_decidability"), " により、各 ", math(String.raw`y\in X`),
        " の ", math(String.raw`\mu(y),\pi(y)`), " を有限走査で計算する。",
        ref("claim_periodic_iff_min_preperiod_zero"), " により ", math(String.raw`\mu(y)=0`),
        " の元だけを残し、その ", math(String.raw`\pi(y)`), " の重複を除けば ",
        ref("def_realized_period_set"), " の ", math(String.raw`\mathsf{Len}_F`), " を得る。",
        ref("def_min_period"), " と ", ref("claim_min_preperiod_period_bound"),
        " により、残した各周期は ", math(String.raw`[1,|X|]_{\mathbb{N}}`), " に入る。"]),
      paragraph(["各 ", math(String.raw`d\in \mathsf{Len}_F`), " は正なので、自然数の除法の原理により剰余を計算できる。",
        ref("claim_positive_count_domain_iff_period_divides"), " により少なくとも一つの剰余が零であることが判定条件になる。",
        math(String.raw`X=\emptyset`), " なら走査表も空であり、全ての入力に対して偽を返す。",
        "個数そのものが必要なら ", ref("claim_fixed_point_count_finite_decidability"), " の走査を使う。"]),
    ],
  },
  {
    id: "positive_fixed_point_count_definition_positive_rational_input",
    kind: "definition",
    title: { text: "正の不動点数を正の有理数へ渡す写像" },
    labels: ["def_positive_fixed_point_count_rational_input"],
    habitat: "Q",
    statement: [
      paragraph(["有限自己写像 ", math(String.raw`F:X\to X`), " について、",
        ref("def_positive_fixed_point_count_domain"), " の定義域から写像"]),
      displayMath(String.raw`q_F:\mathsf{Pos}_F\longrightarrow\mathbb{Q}_{>0},\qquad q_F(n):=\frac{Z_n(F)}{1}`),
      paragraph(["を定める。右辺は自然数を分子、非零の自然数 1 を分母とする有理数である。",
        math(String.raw`n\in \mathsf{Pos}_F`), " では分子が正なので値は ", math(String.raw`\mathbb{Q}_{>0}`),
        " に属する。零個となる回数はこの写像の定義域に入れない。",
        "自然数の個数と有理数の値の間はこの写像を通る。"]),
    ],
  },
]);
