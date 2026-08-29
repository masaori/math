/**
 * 章「根付き木の深さと最小前周期層の対応」。
 * 一周期写像 R_F = F^{lambda_F} による根への深さが、元ごとの最小前周期を
 * lambda_F 単位で切り上げた値に等しいことを示す。
 * 有限集合、自然数、写像の等号だけを使い、R / C は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_root_depth_preperiod_correspondence_heading",
    kind: "heading",
    level: 1,
    title: { text: "根付き木の深さと最小前周期層の対応" },
    labels: [],
  },
  {
    id: "iterate_monoid_root_depth_preperiod_correspondence_claim_global_period_at_point",
    kind: "claim",
    title: { text: "全写像の最小正周期は各元の最小前周期位置でも周期になる" },
    labels: ["claim_iterate_monoid_global_period_at_point_min_preperiod"],
    habitat: "N",
    statement: [
      paragraph([
        "すべての ", math(String.raw`y\in X`), " について、",
        math(String.raw`\mu(y)\le\mu_F`), " であり、",
      ]),
      displayMath(String.raw`F^{\mu(y)+\lambda_F}(y)=F^{\mu(y)}(y)`),
      paragraph(["が成り立つ。"])],
    proof: [
      paragraph([
        ref("def_iterate_monoid_minimal_positive_period"), " より ",
        math(String.raw`F^{\mu_F+\lambda_F}=F^{\mu_F}`), " である。したがって",
      ]),
      displayMath(String.raw`F^{\mu_F+\lambda_F}(y)=F^{\mu_F}(y)\quad(\because\ \text{写像の等号を }y\text{ に適用})`),
      paragraph([
        "である。", math(String.raw`\lambda_F\ge1`), " と ",
        ref("claim_periodicity_pair_iff_collision"), " により ",
        math(String.raw`(\mu_F,\lambda_F)\in P(y)`), " である。よって ",
        ref("def_min_preperiod"), " の最小性から",
      ]),
      displayMath(String.raw`\mu(y)\le\mu_F\quad(\because\ \mu_F\in I(y)\ \text{と}\ \mu(y)=\min I(y))`),
      paragraph([
        "を得る。さらに ", ref("claim_period_descends_to_min_preperiod"), " を ",
        math(String.raw`(\mu_F,\lambda_F)\in P(y)`), " に適用すると",
      ]),
      displayMath(String.raw`F^{\mu(y)+\lambda_F}(y)=F^{\mu(y)}(y)`),
      paragraph(["を得る。"]),
    ],
  },
  {
    id: "iterate_monoid_root_depth_preperiod_correspondence_definition_rounded_preperiod",
    kind: "definition",
    title: { text: "最小前周期を一周期単位で切り上げた値" },
    labels: ["def_iterate_monoid_rounded_preperiod_depth"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`y\in X`), " に対し、集合 ",
        math(String.raw`\{d\in\mathbb N\mid \mu(y)\le d\lambda_F\}`), " は、",
        ref("claim_iterate_monoid_global_period_at_point_min_preperiod"), " の ",
        math(String.raw`\mu(y)\le\mu_F`), "、",
        ref("def_iterate_monoid_root_reach_exponent"), " の ",
        math(String.raw`e_F=m_F\lambda_F`), "、および ",
        ref("def_iterate_monoid_minimal_stable_period_multiple"), " の ",
        math(String.raw`e_F\in D_F`), " と ",
        ref("def_iterate_monoid_stable_period_multiple_exponents"), " の所属条件から従う ",
        math(String.raw`\mu_F\le e_F`), " により ", math(String.raw`m_F`),
        " を含む。したがって自然数の整列性により最小元をもち、その最小元を",
      ]),
      displayMath(String.raw`r_F(y):=\min\{d\in\mathbb N\mid \mu(y)\le d\lambda_F\}\in\mathbb N`),
      paragraph(["と定める。"]),
    ],
  },
  {
    id: "iterate_monoid_root_depth_preperiod_correspondence_claim_reaches_root_at_rounded_preperiod",
    kind: "claim",
    title: { text: "切り上げた最小前周期の一周期反復で根へ到達する" },
    labels: ["claim_iterate_monoid_rounded_preperiod_reaches_root"],
    habitat: "N",
    statement: [
      paragraph([
        "すべての ", math(String.raw`q\in Q_F`), " と ",
        math(String.raw`y\in B_F(q)`), " について、",
      ]),
      displayMath(String.raw`F^{r_F(y)\lambda_F}(y)=q`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`c:=r_F(y)`), " と置く。",
        ref("def_iterate_monoid_rounded_preperiod_depth"), " より ",
        math(String.raw`\mu(y)\le c\lambda_F`), " である。同じ定義の集合は ",
        math(String.raw`m_F`), " を含むので、最小性から ",
        math(String.raw`c\le m_F`), " である。したがって、ある ",
        math(String.raw`h\in\mathbb N`), " が存在して ",
        math(String.raw`m_F=c+h`), " である。",
        ref("claim_iterate_monoid_global_period_at_point_min_preperiod"), " と ",
        ref("claim_period_multiples"), " を ",
        math(String.raw`i=\mu(y)`), "、", math(String.raw`q=\lambda_F`),
        "、", math(String.raw`k=h`), " に適用すると",
      ]),
      displayMath(String.raw`F^{\mu(y)+h\lambda_F}(y)=F^{\mu(y)}(y)`),
      paragraph([
        "を得る。", math(String.raw`c\lambda_F\ge\mu(y)`), " なので、ある ",
        math(String.raw`a\in\mathbb N`), " が存在して ",
        math(String.raw`c\lambda_F=\mu(y)+a`), " である。上の等号へ ",
        ref("claim_collision_shift"), " を ", math(String.raw`a`), " で適用すると",
      ]),
      displayMath(String.raw`F^{c\lambda_F+h\lambda_F}(y)=F^{c\lambda_F}(y)`),
      displayMath(String.raw`\begin{aligned}
F^{c\lambda_F}(y)
&=F^{c\lambda_F+h\lambda_F}(y)
  \quad(\because\ \text{上の等号})\\
&=F^{(c+h)\lambda_F}(y)
  \quad(\because\ \text{分配則})\\
&=F^{m_F\lambda_F}(y)
  \quad(\because\ m_F=c+h)\\
&=q
  \quad(\because\ \blkref{claim_iterate_monoid_one_period_map_reaches_root}).
\end{aligned}`),
    ],
  },
  {
    id: "iterate_monoid_root_depth_preperiod_correspondence_claim_earlier_multiple_not_root",
    kind: "claim",
    title: { text: "切り上げ位置より前の一周期反復は根へ到達しない" },
    labels: ["claim_iterate_monoid_before_rounded_preperiod_not_root"],
    habitat: "N",
    statement: [
      paragraph([
        "すべての ", math(String.raw`q\in Q_F`), "、",
        math(String.raw`y\in B_F(q)`), "、", math(String.raw`d\in\mathbb N`),
        " について、", math(String.raw`d<r_F(y)`), " なら",
      ]),
      displayMath(String.raw`F^{d\lambda_F}(y)\ne q`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`c:=r_F(y)`), " と置く。", math(String.raw`d<c`),
        " と ", ref("def_iterate_monoid_rounded_preperiod_depth"), " の最小性から",
      ]),
      displayMath(String.raw`d\lambda_F<\mu(y)`),
      paragraph([
        "である。また同じ定義の最小性から ", math(String.raw`c\le m_F`),
        " なので ", math(String.raw`d<m_F`), "、したがって ",
        math(String.raw`d\lambda_F<m_F\lambda_F=e_F`), " である。もし ",
        math(String.raw`F^{d\lambda_F}(y)=q`), " なら、",
        ref("claim_iterate_monoid_one_period_map_reaches_root"), " と合わせて",
      ]),
      displayMath(String.raw`F^{d\lambda_F}(y)=F^{e_F}(y)`),
      paragraph([
        "となる。", math(String.raw`p:=e_F-d\lambda_F\in\mathbb N_{>0}`),
        " と置くと ", math(String.raw`e_F=d\lambda_F+p`), " なので",
      ]),
      displayMath(String.raw`F^{d\lambda_F+p}(y)=F^{d\lambda_F}(y)`),
      paragraph([
        "である。", ref("claim_periodicity_pair_iff_collision"), " より ",
        math(String.raw`(d\lambda_F,p)\in P(y)`), "、したがって ",
        math(String.raw`d\lambda_F\in I(y)`), " である。",
        ref("def_min_preperiod"), " の最小性から ",
        math(String.raw`\mu(y)\le d\lambda_F`), " となり、",
        math(String.raw`d\lambda_F<\mu(y)`), " に矛盾する。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_root_depth_preperiod_correspondence_claim_depth_formula",
    kind: "claim",
    title: { text: "根への深さは最小前周期を一周期単位で切り上げた値である" },
    labels: ["claim_iterate_monoid_fiber_tree_depth_equals_rounded_preperiod"],
    habitat: "N",
    statement: [
      paragraph([
        "すべての ", math(String.raw`q\in Q_F`), " と ",
        math(String.raw`y\in B_F(q)`), " について、",
      ]),
      displayMath(String.raw`d_F(y)=r_F(y)=\min\{d\in\mathbb N\mid \mu(y)\le d\lambda_F\}`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_rounded_preperiod_reaches_root"), " より ",
        math(String.raw`r_F(y)`), " は ", ref("def_iterate_monoid_fiber_tree_depth"),
        " の最小化対象に属する。", ref("claim_iterate_monoid_before_rounded_preperiod_not_root"),
        " より、それより小さい自然数は同じ対象に属さない。したがって自然数の最小元の一意性から ",
        math(String.raw`d_F(y)=r_F(y)`), " である。第二の等号は ",
        ref("def_iterate_monoid_rounded_preperiod_depth"), " の定義である。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_root_depth_preperiod_correspondence_claim_finite_decidability",
    kind: "claim",
    title: { text: "深さと最小前周期層の対応は有限決定できる" },
    labels: ["claim_iterate_monoid_root_depth_preperiod_correspondence_finite_decidability"],
    habitat: "N",
    statement: [
      paragraph([
        "全ての元の ", math(String.raw`\mu(y)`), "、",
        math(String.raw`r_F(y)`), "、", math(String.raw`d_F(y)`),
        " と、各深さに属する元の有限集合は、有限集合上の自己写像の有限表から有限決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_min_preperiod_period_finite_decidability"), " により各元の ",
        math(String.raw`\mu(y)`), " を有限決定でき、",
        ref("claim_iterate_monoid_minimal_period_finite_decidability"), " により ",
        math(String.raw`\lambda_F`), " を有限決定できる。各 ",
        math(String.raw`y\in X`), " について ", math(String.raw`d=0,1,2,\ldots`),
        " の順に ", math(String.raw`\mu(y)\le d\lambda_F`),
        " を自然数の有限比較で検査し、最初の ", math(String.raw`d`),
        " を返せば ", ref("def_iterate_monoid_rounded_preperiod_depth"), " の ",
        math(String.raw`r_F(y)`), " が得られる。この走査は同定義により有限回で停止する。",
        ref("claim_iterate_monoid_fiber_tree_depth_equals_rounded_preperiod"), " により返した値は ",
        math(String.raw`d_F(y)`), " でもある。有限集合 ", math(String.raw`X`),
        " の全元を返した値ごとに分ければ、各深さの元集合も有限決定できる。",
      ]),
      paragraph(["この検査は有限集合、自然数、元の等号だけで閉じる。実数、複素数、極限、完備化は使わない。"]),
    ],
  },
]);
