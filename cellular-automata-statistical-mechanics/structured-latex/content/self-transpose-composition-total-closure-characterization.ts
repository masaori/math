/**
 * 章「自己転置な近傍割り当て全体の合成閉性の特徴づけ」。
 * 前章で得た非閉性の向きへ逆向きを加え、閉性を舞台の元数だけで特徴づける。
 * 有限集合と有限部分集合だけを使う。R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "self_transpose_composition_total_closure_characterization_heading",
    kind: "heading",
    level: 1,
    title: { text: "自己転置な近傍割り当て全体の合成閉性の特徴づけ" },
    labels: [],
  },
  {
    id: "self_transpose_composition_total_closure_definition",
    kind: "definition",
    title: { text: "自己転置な近傍割り当て全体の合成閉性" },
    labels: ["def_all_self_transpose_assignments_composition_closed"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " に対し、",
      ]),
      displayMath(String.raw`\mathsf{Closed}_{\mathrm{st}}(V)
:\Longleftrightarrow
\forall N,M\in\mathcal N(V),\quad
N^{\mathsf T}=N\ \land\ M^{\mathsf T}=M
\Longrightarrow
(N\star M)^{\mathsf T}=N\star M`),
      paragraph(["と定める。"])],
  },
  {
    id: "self_transpose_composition_total_closure_characterization_claim",
    kind: "claim",
    title: { text: "全ての自己転置な割り当てが合成で閉じる舞台の特徴づけ" },
    labels: ["claim_all_self_transpose_assignments_composition_closed_iff_subsingleton"],
    habitat: "finite",
    statement: [
      paragraph(["任意の有限集合 ", math(String.raw`V`), " について"]),
      displayMath(String.raw`\mathsf{Closed}_{\mathrm{st}}(V)
\quad\Longleftrightarrow\quad
|V|\leq 1`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "まず ", math(String.raw`\mathsf{Closed}_{\mathrm{st}}(V)`), " を仮定する。",
        math(String.raw`|V|\geq2`), " と仮定すると、相異なる ",
        math(String.raw`a,b\in V`), " が存在する。証明の中だけで使う近傍割り当て ",
        math(String.raw`N_a,M_{a,b}\in\mathcal N(V)`), " を",
      ]),
      displayMath(String.raw`N_a(v):=
\begin{cases}
\{a\},&v=a,\\
\varnothing,&v\neq a,
\end{cases}
\qquad
M_{a,b}(v):=
\begin{cases}
\{b\},&v=a,\\
\{a\},&v=b,\\
\varnothing,&v\notin\{a,b\}
\end{cases}`),
      paragraph(["で定める。任意の ", math(String.raw`v,w\in V`), " について"]),
      displayMath(String.raw`\begin{aligned}
w\in N_a(v)
&\Longleftrightarrow v=w=a
  \qquad(\because\ N_a\text{ の定義})\\
&\Longleftrightarrow v\in N_a(w)
  \qquad(\because\ \text{等号の対称性}),\\[4pt]
w\in M_{a,b}(v)
&\Longleftrightarrow (v=a\land w=b)\lor(v=b\land w=a)
  \qquad(\because\ M_{a,b}\text{ の定義})\\
&\Longleftrightarrow v\in M_{a,b}(w)
  \qquad(\because\ \text{二つの選言の交換}).
\end{aligned}`),
      paragraph([
        ref("claim_self_transpose_iff_symmetric_membership"), " より ",
        math(String.raw`N_a^{\mathsf T}=N_a`), " かつ ",
        math(String.raw`M_{a,b}^{\mathsf T}=M_{a,b}`), " である。一方、",
      ]),
      displayMath(String.raw`\begin{aligned}
(N_a\star M_{a,b})(a)
&=\bigcup_{u\in N_a(a)}M_{a,b}(u)
  \qquad(\because\ \blkref{def_composed_neighborhood})\\
&=M_{a,b}(a)
  \qquad(\because\ N_a(a)=\{a\})\\
&=\{b\}
  \qquad(\because\ M_{a,b}\text{ の定義}),\\[4pt]
(M_{a,b}\star N_a)(a)
&=\bigcup_{u\in M_{a,b}(a)}N_a(u)
  \qquad(\because\ \blkref{def_composed_neighborhood})\\
&=N_a(b)
  \qquad(\because\ M_{a,b}(a)=\{b\})\\
&=\varnothing
  \qquad(\because\ a\neq b\text{ と }N_a\text{ の定義}).
\end{aligned}`),
      paragraph([
        math(String.raw`b\in\{b\}`), " かつ ", math(String.raw`b\notin\varnothing`),
        " なので二つの合成は等しくない。",
        ref("claim_self_transpose_composition_iff_commute"), " より ",
        math(String.raw`N_a\star M_{a,b}`), " は自己転置でなく、",
        ref("def_all_self_transpose_assignments_composition_closed"), " に矛盾する。したがって ",
        math(String.raw`|V|\leq1`), " である。",
      ]),
      paragraph([
        "逆に ", math(String.raw`|V|\leq1`), " と仮定し、自己転置な ",
        math(String.raw`N,M\in\mathcal N(V)`), " を取る。任意の ",
        math(String.raw`v,w\in V`), " について、",
      ]),
      displayMath(String.raw`\begin{aligned}
w\in(N\star M)(v)
&\Longleftrightarrow \exists u\in V,\ u\in N(v)\land w\in M(u)
  \qquad(\because\ \blkref{def_composed_neighborhood})\\
&\Longleftrightarrow v\in N(v)\land w\in M(v)
  \qquad(\because\ |V|\leq1\text{ より }u=v)\\
&\Longleftrightarrow v\in N(v)\land v\in M(v)
  \qquad(\because\ |V|\leq1\text{ より }w=v)\\
&\Longleftrightarrow v\in M(v)\land v\in N(v)
  \qquad(\because\ \text{連言の交換})\\
&\Longleftrightarrow \exists u\in V,\ u\in M(v)\land w\in N(u)
  \qquad(\because\ |V|\leq1\text{ より }u=v\text{ かつ }w=v)\\
&\Longleftrightarrow w\in(M\star N)(v)
  \qquad(\because\ \blkref{def_composed_neighborhood}).
\end{aligned}`),
      paragraph([
        "二回の外延性により ", math(String.raw`N\star M=M\star N`), " である。",
        ref("claim_self_transpose_composition_iff_commute"), " の逆向きから ",
        math(String.raw`(N\star M)^{\mathsf T}=N\star M`), " が従う。",
        math(String.raw`N,M`), " は任意だったので ",
        ref("def_all_self_transpose_assignments_composition_closed"), " が成り立つ。",
      ]),
    ],
  },
]);
