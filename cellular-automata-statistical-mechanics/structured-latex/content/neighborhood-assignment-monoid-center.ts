/**
 * 章「有限近傍割り当てモノイドの中心」。
 * 全ての近傍割り当てと可換する元が、空近傍と自己近傍だけであることを示す。
 * 有限集合・有限部分集合だけを使う。R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "neighborhood_assignment_monoid_center_heading",
    kind: "heading",
    level: 1,
    title: { text: "有限近傍割り当てモノイドの中心" },
    labels: [],
  },
  {
    id: "neighborhood_assignment_monoid_center_definition_center",
    kind: "definition",
    title: { text: "近傍割り当てモノイドの中心" },
    labels: ["def_neighborhood_assignment_monoid_center"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の近傍割り当て全体（",
        ref("def_finite_neighborhood_assignment_space"), "）と合成（",
        ref("def_composed_neighborhood"), "）に対し、その中心を",
      ]),
      displayMath(String.raw`Z_{\star}(V):=
\{N\in\mathcal N(V)\mid
  \forall M\in\mathcal N(V),\ N\star M=M\star N
\}`),
      paragraph(["と定める。"]),
    ],
  },
  {
    id: "neighborhood_assignment_monoid_center_definition_single_edge",
    kind: "definition",
    title: { text: "一つの向き付き辺だけを持つ近傍割り当て" },
    labels: ["def_single_edge_neighborhood_assignment"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ", math(String.raw`a,b\in V`), " に対し、",
        math(String.raw`E_{a,b}\in\mathcal N(V)`), "（",
        ref("def_finite_neighborhood_assignment_space"), "）を",
      ]),
      displayMath(String.raw`E_{a,b}(v):=
\begin{cases}
\{b\},&v=a,\\
\varnothing,&v\neq a
\end{cases}
\qquad(v\in V)`),
      paragraph(["で定める。"]),
    ],
  },
  {
    id: "neighborhood_assignment_monoid_center_claim_characterization",
    kind: "claim",
    title: { text: "中心は空近傍と自己近傍だけからなる" },
    labels: ["claim_neighborhood_assignment_monoid_center_characterization"],
    habitat: "finite",
    statement: [
      paragraph(["任意の有限集合 ", math(String.raw`V`), " について"]),
      displayMath(String.raw`Z_{\star}(V)=\{O_V,I_V\}`),
      paragraph([
        "が成り立つ。空舞台では ", math(String.raw`O_V=I_V`), " なので右辺は一元集合である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_empty_neighborhood_assignment_is_composition_absorbing"), " と ",
        ref("claim_identity_neighborhood_assignment_is_composition_identity"), " により、",
        math(String.raw`O_V,I_V\in Z_{\star}(V)`), " である。",
      ]),
      paragraph([
        "逆に ", math(String.raw`N\in Z_{\star}(V)`), " を取る。",
        math(String.raw`N=O_V`), " なら結論を得る。以下では ", math(String.raw`N\neq O_V`),
        " と仮定する。このとき ", math(String.raw`q\in N(p)`), " を満たす ",
        math(String.raw`p,q\in V`), " が存在する。まず ", math(String.raw`E_{q,q}`), " との合成を調べる。",
      ]),
      displayMath(String.raw`q\in(N\star E_{q,q})(p)
\qquad(\because\ q\in N(p)\ \text{かつ}\ q\in E_{q,q}(q))`),
      paragraph([ref("def_neighborhood_assignment_monoid_center"), " より"]),
      displayMath(String.raw`N\star E_{q,q}=E_{q,q}\star N`),
      paragraph(["である。したがって"]),
      displayMath(String.raw`q\in(E_{q,q}\star N)(p)`),
      paragraph(["を得る。もし ", math(String.raw`p\neq q`), " なら"]),
      displayMath(String.raw`\begin{aligned}
(E_{q,q}\star N)(p)
&=\bigcup_{u\in E_{q,q}(p)}N(u)
  \qquad(\because\ \blkref{def_composed_neighborhood})\\
&=\bigcup_{u\in\varnothing}N(u)
  \qquad(\because\ p\neq q\ \text{と}\ \blkref{def_single_edge_neighborhood_assignment})\\
&=\varnothing
  \qquad(\because\ \text{空集合を添字とする合併})
\end{aligned}`),
      paragraph([
        "となって矛盾する。よって ", math(String.raw`p=q`), " である。次に任意の ",
        math(String.raw`b\in V`), " を取る。",
      ]),
      displayMath(String.raw`b\in(N\star E_{p,b})(p)
\qquad(\because\ p\in N(p)\ \text{かつ}\ b\in E_{p,b}(p))`),
      paragraph([ref("def_neighborhood_assignment_monoid_center"), " より"]),
      displayMath(String.raw`\begin{aligned}
b\in(N\star E_{p,b})(p)
&\Longleftrightarrow b\in(E_{p,b}\star N)(p)
  \qquad(\because\ N\star E_{p,b}=E_{p,b}\star N)\\
&\Longleftrightarrow b\in N(b)
  \qquad(\because\ E_{p,b}(p)=\{b\}\ \text{と}\ \blkref{def_composed_neighborhood}).
\end{aligned}`),
      paragraph([
        math(String.raw`b`), " は任意なので ", math(String.raw`I_V(v)\subseteq N(v)`),
        " が全ての ", math(String.raw`v\in V`), " で成り立つ。",
      ]),
      paragraph([
        "最後に任意の ", math(String.raw`v,w\in V`), " について ", math(String.raw`w\in N(v)`),
        " と仮定する。上と同じく ", math(String.raw`E_{w,w}`), " を使うと",
      ]),
      displayMath(String.raw`w\in(N\star E_{w,w})(v)
\qquad(\because\ w\in N(v)\ \text{かつ}\ w\in E_{w,w}(w))`),
      paragraph([ref("def_neighborhood_assignment_monoid_center"), " より"]),
      displayMath(String.raw`N\star E_{w,w}=E_{w,w}\star N`),
      paragraph([
        "なので ", math(String.raw`w\in(E_{w,w}\star N)(v)`), " である。もし ",
        math(String.raw`v\neq w`), " なら ",
        ref("def_single_edge_neighborhood_assignment"), " より ", math(String.raw`E_{w,w}(v)=\varnothing`),
        " であり、右辺は空集合となって矛盾する。よって ", math(String.raw`v=w`),
        " である。したがって ", math(String.raw`N(v)\subseteq I_V(v)`), " が全ての ",
        math(String.raw`v\in V`), " で成り立つ。二つの包含と外延性から ",
        math(String.raw`N=I_V`), " を得る。",
      ]),
    ],
  },
  {
    id: "neighborhood_assignment_monoid_center_claim_finite_decidability",
    kind: "claim",
    title: { text: "中心と中心所属は有限決定できる" },
    labels: ["claim_neighborhood_assignment_monoid_center_finite_decidability"],
    habitat: "N",
    statement: [
      paragraph([
        "有限舞台 ", math(String.raw`V`), " では ", math(String.raw`Z_{\star}(V)`),
        " と、任意の ", math(String.raw`N\in\mathcal N(V)`), " に対する ",
        math(String.raw`N\in Z_{\star}(V)`), " の真偽を有限決定できる。",
      ]),
    ],
    proof: [
      paragraph([ref("claim_neighborhood_assignment_monoid_center_characterization"), " により"]),
      displayMath(String.raw`N\in Z_{\star}(V)
\Longleftrightarrow N=O_V\lor N=I_V`),
      paragraph([
        "である。二つの写像の等号は ", math(String.raw`|V|^2`),
        " 回の有限な所属判定で決定できる。したがって中心の全体と中心所属を有限決定できる。",
      ]),
    ],
  },
]);
