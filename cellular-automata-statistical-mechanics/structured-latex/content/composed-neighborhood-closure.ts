/**
 * 章「合成近傍による大域写像の合成表現」。
 * 二つの有限舞台上の大域写像を合成するとき、前段が読む各セルの後段近傍を有限合併した
 * 合成近傍を使えば、合成を一つの局所規則族として書けることを示す。
 * 有限集合、写像、有限真理値表だけを使う。R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "composed_neighborhood_closure_definition_composed_neighborhood",
    kind: "definition",
    title: { text: "二つの近傍割り当ての合成近傍" },
    labels: ["def_composed_neighborhood"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と二つの近傍割り当て ",
        math(String.raw`N,M:V\to\{V\text{ の部分集合}\}`), " を取る（",
        ref("def_finite_neighborhood_system"), "）。各 ", math(String.raw`v\in V`), " に対し、",
      ]),
      displayMath(String.raw`(N\star M)(v):=\bigcup_{u\in N(v)}M(u)\subseteq V`),
      paragraph([
        "と定め、", math(String.raw`N\star M`), " を合成近傍と呼ぶ。",
        math(String.raw`N(v)`), " は有限集合であり各 ", math(String.raw`M(u)`),
        " も有限集合なので、", math(String.raw`(N\star M)(v)`), " は有限集合である。特に ",
        math(String.raw`u\in N(v)`), " ならば ", math(String.raw`M(u)\subseteq(N\star M)(v)`),
        " である。",
      ]),
    ],
  },

  {
    id: "composed_neighborhood_closure_definition_composed_local_rule",
    kind: "definition",
    title: { text: "二つの局所規則族から作る合成局所規則族" },
    labels: ["def_composed_local_rule_family"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限舞台 ", math(String.raw`(V,N)`), " 上の局所規則族 ",
        math(String.raw`f_v:A^{N(v)}\to A`), " と、有限舞台 ", math(String.raw`(V,M)`),
        " 上の局所規則族 ", math(String.raw`g_v:A^{M(v)}\to A`), " を取る（",
        ref("def_finite_ca"), "）。各 ", math(String.raw`v\in V`), " と ",
        math(String.raw`z\in A^{(N\star M)(v)}`), " に対し、写像 ",
        math(String.raw`h_v:A^{(N\star M)(v)}\to A`), " を",
      ]),
      displayMath(String.raw`h_v(z):=f_v\!\left(u\mapsto g_u\!\left(\rho^{(N\star M)(v)}_{M(u)}z\right)\right)`),
      paragraph([
        "で定める。ここで ", math(String.raw`u\in N(v)`), " なら ",
        math(String.raw`M(u)\subseteq(N\star M)(v)`), "（", ref("def_composed_neighborhood"),
        "）なので、制限写像 ", math(String.raw`\rho^{(N\star M)(v)}_{M(u)}`), "（",
        ref("def_restriction_map"), "）は定義されている。したがって ",
        math(String.raw`u\mapsto g_u(\rho^{(N\star M)(v)}_{M(u)}z)`), " は ",
        math(String.raw`A^{N(v)}`), " の元であり、", math(String.raw`h_v`),
        " は有限の真理値表である。",
      ]),
    ],
  },

  {
    id: "composed_neighborhood_closure_claim_global_composition_representable",
    kind: "claim",
    title: { text: "大域写像の合成は合成近傍上の局所規則族で表せる" },
    labels: ["claim_global_map_composition_representable_on_composed_neighborhood"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_composed_local_rule_family"), " の ", math(String.raw`f_v`), "・",
        math(String.raw`g_v`), "・", math(String.raw`h_v`), " が定める大域写像をそれぞれ ",
        math(String.raw`F`), "・", math(String.raw`G`), "・", math(String.raw`H:A^V\to A^V`),
        " とする（", ref("def_global_map"), "）。このとき次が成り立つ。",
      ]),
      displayMath(String.raw`F\circ G=H`),
    ],
    proof: [
      paragraph([
        "任意の ", math(String.raw`x\in A^V`), "、", math(String.raw`v\in V`),
        "、", math(String.raw`u\in N(v)`), " を取る。各 ", math(String.raw`w\in M(u)`),
        " について、", math(String.raw`w\in(N\star M)(v)`), "（",
        ref("def_composed_neighborhood"), "）なので",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\rho^{(N\star M)(v)}_{M(u)}\left(\rho^V_{(N\star M)(v)}x\right)\right)(w)
&=\left(\rho^V_{(N\star M)(v)}x\right)(w)\qquad(\because\ \blkref{def_restriction_map})\\
&=x(w)\qquad(\because\ \blkref{def_restriction_map})\\
&=\left(\rho^V_{M(u)}x\right)(w)\qquad(\because\ \blkref{def_restriction_map})
\end{aligned}`),
      paragraph([
        "である。写像の外延性より ",
        math(String.raw`\rho^{(N\star M)(v)}_{M(u)}(\rho^V_{(N\star M)(v)}x)=\rho^V_{M(u)}x`),
        " である。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
((F\circ G)x)(v)
&=(F(Gx))(v)\qquad(\because\ \text{写像の合成の定義})\\
&=f_v\left(\rho^V_{N(v)}(Gx)\right)\qquad(\because\ \blkref{def_global_map})\\
&=f_v\left(u\mapsto(Gx)(u)\right)\qquad(\because\ \blkref{def_restriction_map})\\
&=f_v\left(u\mapsto g_u\left(\rho^V_{M(u)}x\right)\right)\qquad(\because\ \blkref{def_global_map})\\
&=f_v\left(u\mapsto g_u\left(\rho^{(N\star M)(v)}_{M(u)}\left(\rho^V_{(N\star M)(v)}x\right)\right)\right)
\qquad(\because\ \rho^{(N\star M)(v)}_{M(u)}(\rho^V_{(N\star M)(v)}x)=\rho^V_{M(u)}x)\\
&=h_v\left(\rho^V_{(N\star M)(v)}x\right)\qquad(\because\ \blkref{def_composed_local_rule_family})\\
&=(Hx)(v)\qquad(\because\ \blkref{def_global_map})
\end{aligned}`),
      paragraph([
        "が成り立つ。", math(String.raw`x`), " と ", math(String.raw`v`),
        " は任意なので、写像の外延性より ", math(String.raw`F\circ G=H`), " である。",
      ]),
    ],
  },
]);
