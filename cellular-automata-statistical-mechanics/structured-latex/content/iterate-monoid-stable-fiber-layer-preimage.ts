/**
 * 章「安定ファイバーの層別完全逆像」。
 * 安定ファイバー全体の完全逆像と最小前周期の一段減少を組み合わせ、
 * 一段発展が各深さの層を逆像としてどう分けるかを導く。R / C は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_stable_fiber_layer_preimage_heading",
    kind: "heading",
    level: 1,
    title: { text: "安定ファイバーの層別完全逆像" },
    labels: [],
  },
  {
    id: "iterate_monoid_stable_fiber_zero_layer_forward_claim",
    kind: "claim",
    title: { text: "一段発展は最小前周期が零の層を零の層へ写す" },
    labels: ["claim_iterate_monoid_zero_depth_maps_to_zero_depth"],
    habitat: "N",
    statement: [
      paragraph([
        "各 ", math(String.raw`y\in X`), " について ", math(String.raw`\mu(y)=0`), " なら",
      ]),
      displayMath(String.raw`\mu(F(y))=0`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`p:=\pi(y)\ge1`), " と置く。", ref("def_min_period"), " より ",
        math(String.raw`(0,p)\in P(y)`), " である。任意の ", math(String.raw`n\in\mathbb N`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
F^{n+p}(F(y))
&=F^{n+p+1}(y)\quad(\because\ \blkref{def_global_map_iterate})\\
&=F^{n+1}(y)\quad(\because\ (0,p)\in P(y))\\
&=F^n(F(y))\quad(\because\ \blkref{def_global_map_iterate}).
\end{aligned}`),
      paragraph([
        "よって ", math(String.raw`(0,p)\in P(F(y))`), " である。",
        ref("def_min_preperiod"), " の最小性と ", math(String.raw`\mu(F(y))\in\mathbb N`),
        " から ", math(String.raw`\mu(F(y))=0`), " を得る。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_positive_layer_exact_preimage_claim",
    kind: "claim",
    title: { text: "正の層の完全逆像は一つ上の層である" },
    labels: ["claim_iterate_monoid_positive_depth_layer_exact_preimage"],
    habitat: "finite",
    statement: [
      paragraph([
        "各 ", math(String.raw`q\in Q_F`), " と ", math(String.raw`k\in\mathbb N_{>0}`), " に対して",
      ]),
      displayMath(String.raw`F^{-1}\!\left(L_F(\sigma_F(q),k)\right)=L_F(q,k+1)`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`F(y)\in L_F(\sigma_F(q),k)`), " とする。",
        ref("def_iterate_monoid_stable_fiber_depth_layer"), " と ",
        ref("claim_iterate_monoid_stable_fiber_exact_preimage"), " より ",
        math(String.raw`y\in B_F(q)`), " である。もし ", math(String.raw`\mu(y)=0`), " なら ",
        ref("claim_iterate_monoid_zero_depth_maps_to_zero_depth"), " より ",
        math(String.raw`k=\mu(F(y))=0`), " となり ", math(String.raw`k>0`), " に反する。よって ",
        math(String.raw`\mu(y)>0`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
k
&=\mu(F(y))\quad(\because\ F(y)\in L_F(\sigma_F(q),k))\\
&=\mu(y)-1\quad(\because\ \blkref{claim_iterate_monoid_min_preperiod_decrements}).
\end{aligned}`),
      paragraph([
        math(String.raw`\mu(y)>0`), " と ", math(String.raw`k=\mu(y)-1`), " から ",
        math(String.raw`\mu(y)=k+1`), "。したがって ",
        ref("def_iterate_monoid_stable_fiber_depth_layer"), " より ",
        math(String.raw`y\in L_F(q,k+1)`), " である。",
      ]),
      paragraph([
        "逆に ", math(String.raw`y\in L_F(q,k+1)`), " とする。",
        ref("claim_iterate_monoid_stable_fiber_exact_preimage"), " より ",
        math(String.raw`F(y)\in B_F(\sigma_F(q))`), " である。また ", math(String.raw`k+1>0`), " なので",
      ]),
      displayMath(String.raw`\begin{aligned}
\mu(F(y))
&=\mu(y)-1\quad(\because\ \blkref{claim_iterate_monoid_min_preperiod_decrements})\\
&=(k+1)-1\quad(\because\ y\in L_F(q,k+1))\\
&=k\quad(\because\ \mathbb N\ \text{の加法と減法}).
\end{aligned}`),
      paragraph([
        "よって ", ref("def_iterate_monoid_stable_fiber_depth_layer"), " より ",
        math(String.raw`F(y)\in L_F(\sigma_F(q),k)`), " であり、両包含から結論を得る。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_zero_layer_exact_preimage_claim",
    kind: "claim",
    title: { text: "零層の完全逆像では零層と一層が合流する" },
    labels: ["claim_iterate_monoid_zero_depth_layer_exact_preimage"],
    habitat: "finite",
    statement: [
      paragraph(["各 ", math(String.raw`q\in Q_F`), " に対して"]),
      displayMath(String.raw`F^{-1}\!\left(L_F(\sigma_F(q),0)\right)=L_F(q,0)\cup L_F(q,1)`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`F(y)\in L_F(\sigma_F(q),0)`), " とする。",
        ref("claim_iterate_monoid_stable_fiber_exact_preimage"), " より ",
        math(String.raw`y\in B_F(q)`), "。", math(String.raw`\mu(y)=0`), " なら ",
        math(String.raw`y\in L_F(q,0)`), " である。", math(String.raw`\mu(y)>0`), " なら",
      ]),
      displayMath(String.raw`0=\mu(F(y))=\mu(y)-1
\quad(\because\ \blkref{claim_iterate_monoid_min_preperiod_decrements})`),
      paragraph([
        "より ", math(String.raw`\mu(y)=1`), "、したがって ", math(String.raw`y\in L_F(q,1)`), " である。",
      ]),
      paragraph([
        "逆に ", math(String.raw`y\in L_F(q,0)`), " なら ",
        ref("claim_iterate_monoid_zero_depth_maps_to_zero_depth"), " より ",
        math(String.raw`\mu(F(y))=0`), "。", math(String.raw`y\in L_F(q,1)`), " なら ",
        ref("claim_iterate_monoid_min_preperiod_decrements"), " より ",
        math(String.raw`\mu(F(y))=0`), "。どちらの場合も ",
        ref("claim_iterate_monoid_stable_fiber_exact_preimage"), " より ",
        math(String.raw`F(y)\in B_F(\sigma_F(q))`), " なので、",
        math(String.raw`F(y)\in L_F(\sigma_F(q),0)`), " である。両包含から結論を得る。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_layer_preimage_finite_decidability_claim",
    kind: "claim",
    title: { text: "層別完全逆像は有限決定できる" },
    labels: ["claim_iterate_monoid_depth_layer_preimage_finite_decidability"],
    habitat: "N",
    statement: [
      paragraph([
        "有限集合上の自己写像の有限表から、全ての安定ファイバーの層と、その一段発展による完全逆像を",
        "有限回の元の等号検査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_stable_fiber_depth_finite_decidability"), " により全ての ",
        math(String.raw`L_F(q,k)`), " を有限決定できる。", ref("claim_iterate_monoid_stable_fiber_dynamics_finite_decidability"),
        " により ", math(String.raw`\sigma_F`), " の表を有限決定できる。有限集合 ",
        math(String.raw`X`), " の各元へ ", math(String.raw`F`), " を適用し、各層への所属を検査すれば、",
        "全ての完全逆像を有限決定できる。実数、複素数、極限、完備化は使わない。",
      ]),
    ],
  },
]);
