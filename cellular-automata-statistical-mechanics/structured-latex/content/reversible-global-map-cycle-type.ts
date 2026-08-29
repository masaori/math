/**
 * 章「可逆な自己写像の巡回型」。
 * 一つの有限集合上で単射な自己写像を集め、その周期軌道の元数が最小周期に一致すること、
 * および周期軌道の元数を集めた有限多重集合（巡回型）を定義する。
 *
 * 有限集合、自然数、有限多重集合だけを使う。R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "reversible_global_map_cycle_type_heading",
    kind: "heading",
    level: 1,
    title: { text: "可逆な自己写像の巡回型" },
    labels: [],
  },

  {
    id: "reversible_global_map_cycle_type_definition_reversible_maps",
    kind: "definition",
    title: { text: "一つの有限集合上の可逆な自己写像全体" },
    labels: ["def_reversible_global_maps"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`X`), " に対し、", ref("def_conjugacy_class_all_global_maps"), " の ",
        math(String.raw`\operatorname{End}(X)`), " の部分集合",
      ]),
      displayMath(
        String.raw`\operatorname{Perm}(X):=\{\,F\in\operatorname{End}(X)\ :\ F\ \text{は単射}\,\}`,
      ),
      paragraph([
        "を定める。有限集合上では単射と全単射が同値なので、その元を可逆な自己写像と呼ぶ。",
      ]),
    ],
  },

  {
    id: "reversible_global_map_cycle_type_claim_all_periodic",
    kind: "claim",
    title: { text: "可逆な自己写像では全ての元が周期点である" },
    labels: ["claim_reversible_all_configurations_periodic"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`F\in\operatorname{Perm}(X)`), "（",
        ref("def_reversible_global_maps"), "）について ",
        math(String.raw`\mathrm{Per}(F)=X`), "（",
        ref("def_periodic_points"), "）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`F`), " は単射である（", ref("def_reversible_global_maps"),
        "）。任意の ", math(String.raw`y\in X`), " について、",
      ]),
      displayMath(String.raw`\begin{aligned}
\mu(y)&=0\qquad(\because\ \blkref{claim_global_map_injective_iff_all_periodic}\ \text{の右向きを}\ F\ \text{の単射性に適用})\\
y&\in\mathrm{Per}(F)\qquad(\because\ \blkref{claim_periodic_iff_min_preperiod_zero}\ \text{の左向きを}\ \mu(y)=0\ \text{に適用})
\end{aligned}`),
      paragraph([
        "が成り立つ。よって ", math(String.raw`X\subseteq\mathrm{Per}(F)`),
        " であり、", ref("def_periodic_points"), " により ",
        math(String.raw`\mathrm{Per}(F)\subseteq X`), " なので、集合の等号の両包含により ",
        math(String.raw`\mathrm{Per}(F)=X`), " である。",
      ]),
    ],
  },

  {
    id: "reversible_global_map_cycle_type_claim_orbit_card",
    kind: "claim",
    title: { text: "周期点の周期軌道の元数は最小周期に等しい" },
    labels: ["claim_periodic_orbit_card_eq_min_period"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`F\in\operatorname{End}(X)`), " と ",
        math(String.raw`q\in\mathrm{Per}(F)`), " について、周期軌道 ",
        math(String.raw`O_F(q)`), "（", ref("def_recursive_preimage_tree_code_periodic_orbits"),
        "）の元数は最小周期 ", math(String.raw`\pi(q)\in\mathbb{N}`), "（", ref("def_min_period"),
        "）に等しい。すなわち ", math(String.raw`|O_F(q)|=\pi(q)`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\pi:=\pi(q)\in\mathbb{N}`), " と略記する。",
        ref("def_min_period"), " により ", math(String.raw`\pi\ge 1`), " であり、",
        ref("claim_periodic_iff_min_preperiod_zero"), " の右向きを ",
        math(String.raw`q\in\mathrm{Per}(F)`), " に適用して ",
        math(String.raw`\mu(q)=0`), " である。写像",
      ]),
      displayMath(
        String.raw`\theta:\{\,r\in\mathbb{N}\ :\ r<\pi\,\}\to X,\qquad \theta(r):=F^{r}\,q`,
      ),
      paragraph([
        "を定める（", ref("def_global_map_iterate"), "）。以下、",
        math(String.raw`\theta`), " の像が ", math(String.raw`O_F(q)`),
        " であること（第一段）と ", math(String.raw`\theta`),
        " が単射であること（第二段）を示す。",
      ]),
      paragraph([
        "第一段。", math(String.raw`\mu(q)=0`), " と ", ref("def_min_period"), " により ",
        math(String.raw`(0,\pi)\in P(q)`), "（", ref("def_periodicity_pairs"),
        "）であり、その定義の全称部分に ", math(String.raw`n:=r`),
        " を代入して、すべての ", math(String.raw`r\in\mathbb{N}`), " について ",
        math(String.raw`F^{r+\pi}\,q=F^{r}\,q`), " が成り立つ。任意の ",
        math(String.raw`n\in\mathbb{N}`), " をとり、",
        math(String.raw`\mathbb{N}`), " の除法（", math(String.raw`\pi\ge 1`),
        "）により ", math(String.raw`n=k\pi+r`), "、",
        math(String.raw`k\in\mathbb{N}`), "、", math(String.raw`r\in\mathbb{N}`), "、",
        math(String.raw`r<\pi`), " と書くと、",
      ]),
      displayMath(String.raw`\begin{aligned}
F^{n}\,q
&=F^{k\pi+r}\,q\qquad(\because\ n=k\pi+r)\\
&=F^{r+k\pi}\,q\qquad(\because\ \mathbb{N}\ \text{の加法の交換則})\\
&=F^{r}\,q\qquad(\because\ \blkref{claim_period_multiples}\ \text{を}\ F^{r+\pi}q=F^{r}q\ \text{と}\ k\ \text{に適用})\\
&=\theta(r)\qquad(\because\ \theta\ \text{の定義})
\end{aligned}`),
      paragraph([
        "となる。よって ", math(String.raw`O_F(q)`), " は ", math(String.raw`\theta`),
        " の像に含まれる。逆に ",
        math(String.raw`r<\pi`), " なる ", math(String.raw`r\in\mathbb{N}`), " について ",
        math(String.raw`\theta(r)=F^{r}\,q\in O_F(q)`), " である（",
        ref("def_recursive_preimage_tree_code_periodic_orbits"),
        " の定義に ", math(String.raw`n:=r`), " を代入）。両包含により ",
        math(String.raw`\theta`), " の像は ", math(String.raw`O_F(q)`), " に等しい。",
      ]),
      paragraph([
        "第二段。", math(String.raw`i,j\in\mathbb{N}`), "、",
        math(String.raw`i<\pi`), "、", math(String.raw`j<\pi`), "、",
        math(String.raw`\theta(i)=\theta(j)`), " かつ ", math(String.raw`i\neq j`),
        " と仮定して矛盾を導く。", math(String.raw`\mathbb{N}`),
        " の大小関係の全順序性により、必要なら ", math(String.raw`i`), " と ",
        math(String.raw`j`), " を入れ替えて ", math(String.raw`i<j`),
        " としてよい。", math(String.raw`p:=j-i\in\mathbb{N}`), " と置くと ",
        math(String.raw`p\ge 1`), " かつ ", math(String.raw`i+p=j`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
F^{i+p}\,q&=F^{j}\,q\qquad(\because\ i+p=j)\\
&=\theta(j)\qquad(\because\ \theta\ \text{の定義})\\
&=\theta(i)\qquad(\because\ \text{仮定})\\
&=F^{i}\,q\qquad(\because\ \theta\ \text{の定義})
\end{aligned}`),
      paragraph([
        "が成り立つので、", ref("claim_periodicity_pair_iff_collision"), " を ",
        math(String.raw`(i,p)`), " に適用して ", math(String.raw`(i,p)\in P(q)`),
        " を得る。", ref("claim_period_descends_to_min_preperiod"), " をこの ",
        math(String.raw`(i,p)`), " に適用して ", math(String.raw`\pi\le p`),
        " を得る。一方 ", math(String.raw`p=j-i\le j<\pi`),
        " であり（", math(String.raw`\mathbb{N}`), " の減法は増やさない）、",
        math(String.raw`\mathbb{N}`), " の大小関係の推移性により ",
        math(String.raw`\pi<\pi`), " となる。これは ", math(String.raw`\mathbb{N}`),
        " の大小関係の非反射性に反する。よって ", math(String.raw`\theta`),
        " は単射である。",
      ]),
      paragraph([
        "第一段と第二段により ", math(String.raw`\theta`), " は定義域 ",
        math(String.raw`\{\,r\in\mathbb{N}:r<\pi\,\}`), " から ",
        math(String.raw`O_F(q)`), " への全単射であり、有限集合の間の全単射は元数を保つので ",
        math(String.raw`|O_F(q)|=|\{\,r\in\mathbb{N}:r<\pi\,\}|=\pi`), " である。",
      ]),
    ],
  },

  {
    id: "reversible_global_map_cycle_type_definition_cycle_type",
    kind: "definition",
    title: { text: "可逆な自己写像の巡回型" },
    labels: ["def_reversible_cycle_type"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`F\in\operatorname{Perm}(X)`), "（",
        ref("def_reversible_global_maps"), "）に対し、周期軌道の集合 ",
        math(String.raw`\mathcal O_F`), "（",
        ref("def_recursive_preimage_tree_code_periodic_orbits"),
        "）の各元にその元数を対応させて得る有限多重集合",
      ]),
      displayMath(
        String.raw`\mathrm{ct}(F):=\{\!\{\,|O|\ :\ O\in\mathcal O_F\,\}\!\}`,
      ),
      paragraph([
        "を ", math(String.raw`F`), " の巡回型と呼ぶ。",
        ref("claim_periodic_orbit_card_eq_min_period"), " により、",
        math(String.raw`\mathcal O_F`), " の各元 ", math(String.raw`O_F(q)`),
        " の元数は最小周期 ", math(String.raw`\pi(q)\in\mathbb{N}`), " であり、",
        ref("def_min_period"), " により ", math(String.raw`\pi(q)\ge 1`),
        " なので、", math(String.raw`\mathrm{ct}(F)`),
        " は正の自然数からなる有限多重集合である。",
      ]),
    ],
  },

  {
    id: "reversible_global_map_cycle_type_claim_orbits_partition_configurations",
    kind: "claim",
    title: { text: "可逆な自己写像の周期軌道は元集合を分割する" },
    labels: ["claim_reversible_orbits_partition_configurations"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`F\in\operatorname{Perm}(X)`), " について、周期軌道の集合 ",
        math(String.raw`\mathcal O_F`), " は ", math(String.raw`X`),
        " の有限分割である。すなわち、その合併は ", math(String.raw`X`),
        " であり、相異なる二つの周期軌道は交わらない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_reversible_all_configurations_periodic"), " により任意の ",
        math(String.raw`y\in X`), " は周期点であり、",
        math(String.raw`y=F^0(y)\in O_F(y)`), "（",
        ref("def_recursive_preimage_tree_code_periodic_orbits"), "）なので、",
        math(String.raw`\mathcal O_F`), " の合併は ", math(String.raw`X`), " である。",
      ]),
      paragraph([
        math(String.raw`O_F(q),O_F(q')\in\mathcal O_F`), " が点 ",
        math(String.raw`z`), " を共有するとする。ある ",
        math(String.raw`i,j\in\mathbb N`), " が存在して ",
        math(String.raw`z=F^i(q)=F^j(q')`), " である。",
        math(String.raw`q,q'`), " は周期点なので、正の自然数 ",
        math(String.raw`a,b\in\mathbb N_{>0}`), " が存在して ",
        math(String.raw`F^a(q)=q`), " かつ ", math(String.raw`F^b(q')=q'`),
        " である（", ref("def_periodic_points"), "）。",
        math(String.raw`m:=(i+1)a`), "、", math(String.raw`n:=(j+1)b`),
        " と置けば ", math(String.raw`m>i`), "、", math(String.raw`n>j`), " かつ",
      ]),
      displayMath(String.raw`\begin{aligned}
q&=F^{m}(q)\qquad(\because\ F^a(q)=q\ \text{と}\ \blkref{claim_period_multiples})\\
&=F^{m-i}(F^i(q))\qquad(\because\ \blkref{claim_iterate_composition_addition})\\
&=F^{m-i}(z)\qquad(\because\ z=F^i(q)),
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
q'&=F^{n}(q')\qquad(\because\ F^b(q')=q'\ \text{と}\ \blkref{claim_period_multiples})\\
&=F^{n-j}(F^j(q'))\qquad(\because\ \blkref{claim_iterate_composition_addition})\\
&=F^{n-j}(z)\qquad(\because\ z=F^j(q'))
\end{aligned}`),
      paragraph([
        "である。したがって ", math(String.raw`q\in O_F(z)`), " かつ ",
        math(String.raw`q'\in O_F(z)`), " である。反復の加法則（",
        ref("claim_iterate_composition_addition"), "）により、同じ軌道に属する二点から始めた周期軌道は",
        "互いに包含し、", math(String.raw`O_F(q)=O_F(z)=O_F(q')`), " となる。よって、交わる二軌道は",
        "等しく、相異なる二軌道は交わらない。",
      ]),
    ],
  },

  {
    id: "reversible_global_map_cycle_type_claim_sum",
    kind: "claim",
    title: { text: "巡回型は元数の分割である" },
    labels: ["claim_reversible_cycle_type_sum"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`F\in\operatorname{Perm}(X)`), " について、",
        math(String.raw`\mathrm{ct}(F)`), " の全要素の重複度つき和は",
      ]),
      displayMath(String.raw`\sum_{d\in\mathrm{ct}(F)}d=|X|`),
      paragraph(["である。したがって巡回型は ", math(String.raw`|X|`), " の正の自然数への分割である。"]),
    ],
    proof: [
      paragraph([
        ref("claim_reversible_orbits_partition_configurations"), " により ",
        math(String.raw`\mathcal O_F`), " は ", math(String.raw`X`),
        " の有限分割である。有限分割の各部分の元数を足すと全体の元数になるので、",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{d\in\mathrm{ct}(F)}d
&=\sum_{O\in\mathcal O_F}|O|\qquad(\because\ \blkref{def_reversible_cycle_type})\\
&=|X|\qquad(\because\ \blkref{claim_reversible_orbits_partition_configurations}).
\end{aligned}`),
    ],
  },

  {
    id: "reversible_global_map_cycle_type_claim_conjugacy_invariance",
    kind: "claim",
    title: { text: "共役全単射は巡回型を保存する" },
    labels: ["claim_reversible_cycle_type_conjugacy_invariance"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`F,G\in\operatorname{Perm}(X)`), " の間に共役全単射が存在するなら、",
        math(String.raw`\mathrm{ct}(F)=\mathrm{ct}(G)`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`h:X\to X`), " を共役全単射とする。",
        ref("claim_iterate_monoid_conjugacy_transports_iterates"), " により、各周期点 ",
        math(String.raw`q`), " について ", math(String.raw`h(O_F(q))=O_G(h(q))`),
        " である。", math(String.raw`h`), " は全単射なので、この制限も全単射であり、",
        math(String.raw`|O_F(q)|=|O_G(h(q))|`), " である。さらに ",
        math(String.raw`h`), " と ", math(String.raw`h^{-1}`),
        " は周期軌道全体を互いに逆な写像で移す。よって軌道の元数を重複を保って集めた有限多重集合は一致し、",
        ref("def_reversible_cycle_type"), " により ",
        math(String.raw`\mathrm{ct}(F)=\mathrm{ct}(G)`), " である。",
      ]),
    ],
  },

  {
    id: "reversible_global_map_cycle_type_claim_completeness",
    kind: "claim",
    title: { text: "巡回型の一致から共役全単射を構成できる" },
    labels: ["claim_reversible_cycle_type_completeness"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`F,G\in\operatorname{Perm}(X)`), " について、",
        math(String.raw`\mathrm{ct}(F)=\mathrm{ct}(G)`),
        " ならば ", math(String.raw`F`), " から ", math(String.raw`G`),
        " への共役全単射 ", math(String.raw`h:X\to X`), " が存在する。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_reversible_cycle_type"), " と有限多重集合の等号により、",
        math(String.raw`\mathcal O_F`), " の各軌道を、同じ元数を持つ ",
        math(String.raw`\mathcal O_G`), " の軌道へ重複度を保って一対一に対応させる写像 ",
        math(String.raw`\psi:\mathcal O_F\to\mathcal O_G`), " を選べる。各 ",
        math(String.raw`O\in\mathcal O_F`), " について基点 ",
        math(String.raw`q_O\in O`), " と ", math(String.raw`q'_O\in\psi(O)`),
        " を一つずつ選ぶ。", ref("claim_periodic_orbit_card_eq_min_period"),
        " により、各 ", math(String.raw`y\in O`), " はただ一つの ",
        math(String.raw`r\in\mathbb N`), "、", math(String.raw`r<|O|`),
        " を用いて ", math(String.raw`y=F^r(q_O)`), " と書ける。そこで",
      ]),
      displayMath(String.raw`h\bigl(F^r(q_O)\bigr):=G^r(q'_O)\qquad(0\le r<|O|)`),
      paragraph([
        "と定める。", math(String.raw`|O|=|\psi(O)|`), " と ",
        ref("claim_periodic_orbit_card_eq_min_period"), " により、この写像は各 ",
        math(String.raw`O`), " から ", math(String.raw`\psi(O)`),
        " への全単射である。", ref("claim_reversible_orbits_partition_configurations"),
        " により両側の周期軌道はそれぞれ ", math(String.raw`X`),
        " を分割し、", math(String.raw`\psi`), " は軌道全体の全単射なので、各軌道上の写像を接着した ",
        math(String.raw`h:X\to X`), " は全単射である。",
      ]),
      paragraph([
        math(String.raw`y=F^r(q_O)`), "、", math(String.raw`0\le r<|O|`),
        " とする。", math(String.raw`r+1<|O|`), " の場合は反復の定義により",
      ]),
      displayMath(String.raw`\begin{aligned}
h(F(y))
&=h(F^{r+1}(q_O))\qquad(\because\ \blkref{claim_iterate_composition_addition})\\
&=G^{r+1}(q'_O)\qquad(\because\ h\ \text{の定義})\\
&=G(h(y))\qquad(\because\ h\ \text{の定義と反復の定義}).
\end{aligned}`),
      paragraph([
        math(String.raw`r+1=|O|`), " の場合は ",
        ref("claim_periodic_orbit_card_eq_min_period"), " により ",
        math(String.raw`F^{|O|}(q_O)=q_O`), " かつ ",
        math(String.raw`G^{|O|}(q'_O)=q'_O`), " なので同じ等式が成り立つ。よって全ての ",
        math(String.raw`y\in X`), " について ",
        math(String.raw`h(F(y))=G(h(y))`), " であり、",
        ref("def_iterate_monoid_conjugacy_bijection"), " により ",
        math(String.raw`h`), " は共役全単射である。",
      ]),
    ],
  },

  {
    id: "reversible_global_map_cycle_type_definition_partitions",
    kind: "definition",
    title: { text: "元数の正の自然数への分割" },
    labels: ["def_configuration_count_partitions"],
    habitat: "finite",
    statement: [
      paragraph(["正の自然数からなる有限多重集合のうち、重複度つき和が ", math(String.raw`|X|`), " であるもの全体を"]),
      displayMath(String.raw`\operatorname{Part}(|X|):=\left\{\lambda:\lambda\ \text{は}\ \mathbb N_{>0}\ \text{上の有限多重集合},\ \sum_{d\in\lambda}d=|X|\right\}`),
      paragraph(["と定める。"]),
    ],
  },

  {
    id: "reversible_global_map_cycle_type_claim_partitions_finite",
    kind: "claim",
    title: { text: "元数の正の自然数への分割は有限個である" },
    labels: ["claim_configuration_count_partitions_finite"],
    habitat: "finite",
    statement: [
      paragraph([math(String.raw`\operatorname{Part}(|X|)`), " は有限集合である。"]),
    ],
    proof: [
      paragraph([
        "各分割の要素は ", math(String.raw`1`), " 以上 ", math(String.raw`|X|`),
        " 以下であり、要素数も ", math(String.raw`|X|`),
        " 以下である。したがって、長さ ", math(String.raw`|X|`),
        " 以下の有限列を有限集合 ", math(String.raw`\{1,\ldots,|X|\}`),
        " から作る有限個の候補のうち、和が ", math(String.raw`|X|`),
        " であるものを順序を忘れて集めれば全て得られる。",
      ]),
    ],
  },

  {
    id: "reversible_global_map_cycle_type_claim_partition_realization",
    kind: "claim",
    title: { text: "元数の各分割は可逆な自己写像の巡回型として実現する" },
    labels: ["claim_reversible_cycle_type_realizes_every_partition"],
    habitat: "finite",
    statement: [
      paragraph([
        "任意の ", math(String.raw`\lambda\in\operatorname{Part}(|X|)`),
        " について、", math(String.raw`\mathrm{ct}(F)=\lambda`), " を満たす ",
        math(String.raw`F\in\operatorname{Perm}(X)`), " が存在する。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_configuration_count_partitions"), " により ", math(String.raw`\lambda`),
        " の要素は全て正で、その和は ", math(String.raw`|X|`), " である。有限集合 ", math(String.raw`X`),
        " の元を一列に並べ、その列を ", math(String.raw`\lambda`),
        " の各出現の値を長さとする連続した有限列へ切り分ける。各有限列の中で各元を次の元へ、末尾を先頭へ送る写像 ",
        math(String.raw`F:X\to X`), " を定める。各有限列上で巡回置換なので ",
        math(String.raw`F`), " は単射であり、", ref("def_reversible_global_maps"),
        " により ", math(String.raw`F\in\operatorname{Perm}(X)`), " である。構成した有限列がちょうど ",
        math(String.raw`F`), " の周期軌道であり、その元数を重複を保って集めると ",
        math(String.raw`\lambda`), " になる。よって ", ref("def_reversible_cycle_type"),
        " により ", math(String.raw`\mathrm{ct}(F)=\lambda`), " である。",
      ]),
    ],
  },

  {
    id: "reversible_global_map_cycle_type_claim_binary_ca_partition_realization",
    kind: "claim",
    title: { text: "二値配位空間の各分割は全近傍セルオートマトンで実現する" },
    labels: ["claim_binary_ca_reversible_cycle_type_realizes_every_partition"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限舞台 ", math(String.raw`V`), " の二値配位空間 ", math(String.raw`X:=A^V`),
        " に対し、", math(String.raw`2^{|V|}`), " の任意の分割は、全近傍二値セルオートマトンの",
        "可逆な大域写像の巡回型として実現する。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_finite_binary_ca_specializes_to_finite_self_map"), " より ",
        math(String.raw`|X|=2^{|V|}`), " である。",
        ref("claim_reversible_cycle_type_realizes_every_partition"),
        " で得た可逆な自己写像へ ",
        ref("claim_all_self_maps_binary_ca_full_neighborhood_specialization"),
        " を適用する。",
      ]),
    ],
  },

  {
    id: "reversible_global_map_cycle_type_definition_conjugacy_classes",
    kind: "definition",
    title: { text: "可逆な自己写像の共役類" },
    labels: ["def_reversible_global_map_conjugacy_classes"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_conjugacy_class_relation"), " の関係 ", math(String.raw`\approx_X`),
        " を有限集合 ", math(String.raw`\operatorname{Perm}(X)`), " に制限し、その共役類全体を",
      ]),
      displayMath(String.raw`\mathcal C^{\times}(X):=\{\,[F]^{\times}_X\mid F\in\operatorname{Perm}(X)\,\}`),
      paragraph(["と定める。"]),
    ],
  },

  {
    id: "reversible_global_map_cycle_type_claim_quotient_bijection",
    kind: "claim",
    title: { text: "可逆な自己写像の共役類と元数の分割は全単射である" },
    labels: ["claim_reversible_conjugacy_classes_bijection_partitions"],
    habitat: "finite",
    statement: [
      paragraph([
        "写像 ", math(String.raw`\overline{\mathrm{ct}}:\mathcal C^{\times}(X)\to\operatorname{Part}(|X|)`),
        " を ", math(String.raw`\overline{\mathrm{ct}}([F]^{\times}_X):=\mathrm{ct}(F)`),
        " と定めると、これは全単射である。したがって可逆な自己写像の共役類は有限決定でき、その個数は ",
        math(String.raw`|X|`), " の正の自然数への分割の個数に等しい。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_reversible_cycle_type_sum"), " により値は ",
        math(String.raw`\operatorname{Part}(|X|)`), " に属する。",
        ref("claim_reversible_cycle_type_conjugacy_invariance"),
        " により共役な代表は同じ巡回型を持つので、", math(String.raw`\overline{\mathrm{ct}}`),
        " は代表の選び方に依存しない。",
      ]),
      paragraph([
        math(String.raw`\overline{\mathrm{ct}}([F]^{\times}_X)=\overline{\mathrm{ct}}([G]^{\times}_X)`),
        " ならば ", math(String.raw`\mathrm{ct}(F)=\mathrm{ct}(G)`), " であり、",
        ref("claim_reversible_cycle_type_completeness"), " により ",
        math(String.raw`F\approx_X G`), " なので ",
        math(String.raw`[F]^{\times}_X=[G]^{\times}_X`), " である。よって単射である。",
      ]),
      paragraph([
        "任意の ", math(String.raw`\lambda\in\operatorname{Part}(|X|)`),
        " は ", ref("claim_reversible_cycle_type_realizes_every_partition"),
        " によりある ", math(String.raw`F\in\operatorname{Perm}(X)`),
        " の巡回型である。したがって ", math(String.raw`\overline{\mathrm{ct}}`),
        " は全射であり、以上より全単射である。各対象は自己写像の有限表、有限集合、自然数の有限多重集合だけから有限列挙と等号比較で決定できる。",
      ]),
    ],
  },
]);
