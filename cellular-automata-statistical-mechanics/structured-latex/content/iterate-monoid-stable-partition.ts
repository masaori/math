/**
 * 章「反復モノイドの安定像による元集合の分割」。
 * 冪等反復写像 E_F の各値の逆像が元集合を分割することを、
 * 有限集合、自然数、写像の等号だけから導く。R / C は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_stable_fibers_heading",
    kind: "heading",
    level: 1,
    title: { text: "反復モノイドの安定像による元集合の分割" },
    labels: [],
  },
  {
    id: "iterate_monoid_stable_fibers_definition",
    kind: "definition",
    title: { text: "安定像の元のファイバー" },
    labels: ["def_iterate_monoid_stable_fiber"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_iterate_monoid_stable_image"), " の安定像 ",
        math(String.raw`Q_F`), " の元 ", math(String.raw`q\in Q_F`), " に対し、",
      ]),
      displayMath(String.raw`B_F(q):=\{\,y\in X\mid E_F(y)=q\,\}\subseteq X`),
      paragraph(["と定め、", math(String.raw`q`), " の安定ファイバーと呼ぶ。"]),
    ],
  },
  {
    id: "iterate_monoid_stable_fibers_claim_representative_belongs",
    kind: "claim",
    title: { text: "安定像の各元は自身のファイバーに属する" },
    labels: ["claim_iterate_monoid_stable_representative_belongs_to_fiber"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`q\in Q_F`), " なら ", math(String.raw`q\in B_F(q)`), " である。",
      ]),
    ],
    proof: [
      paragraph([ref("claim_iterate_monoid_cycle_idempotent_retracts_stable_image"), " より"]),
      displayMath(String.raw`E_F(q)=q`),
      paragraph(["なので、", ref("def_iterate_monoid_stable_fiber"), " より ", math(String.raw`q\in B_F(q)`), " である。"]),
    ],
  },
  {
    id: "iterate_monoid_stable_fibers_claim_unique_representative",
    kind: "claim",
    title: { text: "各元はただ一つの安定ファイバーに属する" },
    labels: ["claim_iterate_monoid_stable_fiber_unique_representative"],
    habitat: "finite",
    statement: [
      paragraph([
        "すべての ", math(String.raw`y\in X`), " に対し、",
        math(String.raw`y\in B_F(q)`), " を満たす ", math(String.raw`q\in Q_F`),
        " がただ一つ存在する。その元は ", math(String.raw`q=E_F(y)`), " である。",
      ]),
    ],
    proof: [
      paragraph([ref("def_iterate_monoid_stable_image"), " より"]),
      displayMath(String.raw`E_F(y)\in Q_F`),
      paragraph([ref("def_iterate_monoid_stable_fiber"), " より"]),
      displayMath(String.raw`y\in B_F(E_F(y))
\quad(\because\ E_F(y)=E_F(y))`),
      paragraph([
        "である。さらに ", math(String.raw`q,r\in Q_F`), " と ",
        math(String.raw`y\in B_F(q)\cap B_F(r)`), " を仮定すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
q
&=E_F(y)\quad(\because\ y\in B_F(q))\\
&=r\quad(\because\ y\in B_F(r)).
\end{aligned}`),
      paragraph(["よって存在する安定像の元は一意である。"]),
    ],
  },
  {
    id: "iterate_monoid_stable_fibers_claim_disjoint",
    kind: "claim",
    title: { text: "異なる安定像の元のファイバーは交わらない" },
    labels: ["claim_iterate_monoid_distinct_stable_fibers_disjoint"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`q,r\in Q_F`), " と ", math(String.raw`q\ne r`), " に対して",
      ]),
      displayMath(String.raw`B_F(q)\cap B_F(r)=\varnothing`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        "共通元 ", math(String.raw`y\in B_F(q)\cap B_F(r)`), " が存在すると仮定する。",
        ref("claim_iterate_monoid_stable_fiber_unique_representative"), " より ",
        math(String.raw`q=r`), " となり、仮定 ", math(String.raw`q\ne r`), " に反する。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_stable_fibers_claim_cardinality_decomposition",
    kind: "claim",
    title: { text: "安定ファイバーの個数の総和は全元数に等しい" },
    labels: ["claim_iterate_monoid_stable_fiber_cardinality_decomposition"],
    habitat: "N",
    statement: [
      displayMath(String.raw`\sum_{q\in Q_F}|B_F(q)|=|X|`),
    ],
    proof: [
      paragraph([
        math(String.raw`q\in Q_F`), " と ", math(String.raw`y\in X`), " に対して、",
        math(String.raw`\delta_F(q,y)\in\{0,1\}`), " を ",
        math(String.raw`y\in B_F(q)`), " なら ", math(String.raw`1`),
        "、そうでなければ ", math(String.raw`0`), " と定める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{q\in Q_F}|B_F(q)|
&=\sum_{q\in Q_F}\sum_{y\in X}\delta_F(q,y)
  \quad(\because\ B_F(q)\text{ の元を指示値で数える})\\
&=\sum_{y\in X}\sum_{q\in Q_F}\delta_F(q,y)
  \quad(\because\ \text{有限和の順序交換})\\
&=\sum_{y\in X}1
  \quad(\because\ \blkref{claim_iterate_monoid_stable_fiber_unique_representative})\\
&=|X|
  \quad(\because\ \text{有限集合の元ごとに }1\text{ を一度ずつ足す}).
\end{aligned}`),
    ],
  },
  {
    id: "iterate_monoid_stable_fibers_claim_finite_decidability",
    kind: "claim",
    title: { text: "安定ファイバー分割は有限決定できる" },
    labels: ["claim_iterate_monoid_stable_fibers_finite_decidability"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合上の自己写像の有限表から、全ての ", math(String.raw`q\in Q_F`),
        " と ", math(String.raw`B_F(q)`), "、および各 ", math(String.raw`|B_F(q)|\in\mathbb{N}_{>0}`),
        " を有限回の元の等号検査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_stable_image_finite_decidability"), " により ",
        math(String.raw`Q_F`), " と ", math(String.raw`E_F`), " の表を有限決定できる。有限集合 ",
        math(String.raw`X`), " の各元 ", math(String.raw`y`), " について ",
        math(String.raw`E_F(y)`), " を読み、その値と等しい ", math(String.raw`q\in Q_F`),
        " のファイバーへ ", math(String.raw`y`), " を一度だけ加える。",
        ref("claim_iterate_monoid_stable_fiber_unique_representative"),
        " により各元はちょうど一度加えられる。得られた各有限集合の元を数えれば個数も決まる。",
      ]),
      paragraph(["この検査は有限集合と自然数だけで閉じる。実数、複素数、極限、完備化は使わない。"]),
    ],
  },
]);
