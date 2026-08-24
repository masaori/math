/**
 * 章「可逆な大域写像の巡回型」。
 * 一つの有限舞台上で単射な大域写像を集め、その周期軌道の元数が最小周期に一致すること、
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
    title: { text: "可逆な大域写像の巡回型" },
    labels: [],
  },

  {
    id: "reversible_global_map_cycle_type_definition_reversible_maps",
    kind: "definition",
    title: { text: "一つの有限舞台上の可逆な大域写像全体" },
    labels: ["def_reversible_global_maps"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "（", ref("def_finite_stage"),
        "）と状態集合 ", math(String.raw`A=\{0,1\}`), "（", ref("def_state_set"),
        "）に対し、", ref("def_conjugacy_class_all_global_maps"), " の ",
        math(String.raw`\mathcal M(V)`), " の部分集合",
      ]),
      displayMath(
        String.raw`\mathcal M^{\times}(V):=\{\,F\in\mathcal M(V)\ :\ F\ \text{は単射}\,\}`,
      ),
      paragraph([
        "を定める（単射性は ", ref("def_global_map_injective_surjective"), "）。",
        math(String.raw`\mathcal M(V)`), " が有限集合なので ",
        math(String.raw`\mathcal M^{\times}(V)`), " も有限集合である。",
      ]),
    ],
  },

  {
    id: "reversible_global_map_cycle_type_claim_all_periodic",
    kind: "claim",
    title: { text: "可逆な大域写像では全ての配位が周期点である" },
    labels: ["claim_reversible_all_configurations_periodic"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`F\in\mathcal M^{\times}(V)`), "（",
        ref("def_reversible_global_maps"), "）について ",
        math(String.raw`\mathrm{Per}(F)=A^{V}`), "（",
        ref("def_periodic_points"), "）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`F`), " は単射である（", ref("def_reversible_global_maps"),
        "）。任意の ", math(String.raw`y\in A^{V}`), " について、",
      ]),
      displayMath(String.raw`\begin{aligned}
\mu(y)&=0\qquad(\because\ \blkref{claim_global_map_injective_iff_all_periodic}\ \text{の右向きを}\ F\ \text{の単射性に適用})\\
y&\in\mathrm{Per}(F)\qquad(\because\ \blkref{claim_periodic_iff_min_preperiod_zero}\ \text{の左向きを}\ \mu(y)=0\ \text{に適用})
\end{aligned}`),
      paragraph([
        "が成り立つ。よって ", math(String.raw`A^{V}\subseteq\mathrm{Per}(F)`),
        " であり、", ref("def_periodic_points"), " により ",
        math(String.raw`\mathrm{Per}(F)\subseteq A^{V}`), " なので、集合の等号の両包含により ",
        math(String.raw`\mathrm{Per}(F)=A^{V}`), " である。",
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
        math(String.raw`F\in\mathcal M(V)`), " と ",
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
        String.raw`\theta:\{\,r\in\mathbb{N}\ :\ r<\pi\,\}\to A^{V},\qquad \theta(r):=F^{r}\,q`,
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
    title: { text: "可逆な大域写像の巡回型" },
    labels: ["def_reversible_cycle_type"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`F\in\mathcal M^{\times}(V)`), "（",
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
]);
