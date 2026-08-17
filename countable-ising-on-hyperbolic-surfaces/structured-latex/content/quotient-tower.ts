import { defineBlocks, displayMath, math, paragraph } from "../schema.ts";

export default defineBlocks([
  {
    id: "quotient_tower_heading_input",
    kind: "heading",
    level: 1,
    title: { text: "被覆写像をもつ商の塔" },
    labels: [],
  },
  {
    id: "quotient_tower_definition_two_stage_finite_quotient_tower_input",
    kind: "definition",
    title: { text: "二段の有限商の塔の入力" },
    labels: ["def_two_stage_finite_quotient_tower_input"],
    habitat: "finite",
    verification: ["sagemath/check/two-stage-finite-quotient-tower-input"],
    statement: [
      paragraph([
        "空でない有限集合 ",
        math(String.raw`\Omega`),
        " と有限置換群 ",
        math(String.raw`A\leq\operatorname{Sym}(\Omega)`),
        " に対し、二段の有限商の塔の入力を順序付き組",
      ]),
      displayMath(String.raw`\mathcal T:=
\left(
  \Omega,
  A,
  N_{\mathrm{fine}},
  N_{\mathrm{coarse}},
  Q_{\mathrm{fine}},
  Q_{\mathrm{coarse}},
  \pi_{\mathrm{fine}},
  \pi_{\mathrm{coarse}},
  \kappa
\right)`),
      paragraph([
        "であって、",
        math(String.raw`N_{\mathrm{fine}},N_{\mathrm{coarse}}`),
        " は ",
        math(String.raw`A`),
        " の正規部分群、",
        math(String.raw`\mathtt{fine},\mathtt{coarse}`),
        " は互いに異なる形式的な段ラベルであり、次を全て満たすものと定める。",
      ]),
      displayMath(String.raw`\begin{aligned}
N_{\mathrm{fine}}
&\subseteq N_{\mathrm{coarse}}
\subseteq A,\\
Q_{\mathrm{fine}}
&:=
\{\mathtt{fine}\}\times(A/N_{\mathrm{fine}}),\\
Q_{\mathrm{coarse}}
&:=
\{\mathtt{coarse}\}\times(A/N_{\mathrm{coarse}}),\\
\pi_{\mathrm{fine}}
&:A\longrightarrow Q_{\mathrm{fine}},
&
a
&\longmapsto
\left(
  \mathtt{fine},
  aN_{\mathrm{fine}}
\right),\\
\pi_{\mathrm{coarse}}
&:A\longrightarrow Q_{\mathrm{coarse}},
&
a
&\longmapsto
\left(
  \mathtt{coarse},
  aN_{\mathrm{coarse}}
\right),\\
\kappa
&:Q_{\mathrm{fine}}\longrightarrow Q_{\mathrm{coarse}},
&
\left(
  \mathtt{fine},
  aN_{\mathrm{fine}}
\right)
&\longmapsto
\left(
  \mathtt{coarse},
  aN_{\mathrm{coarse}}
\right),\\
\kappa\circ\pi_{\mathrm{fine}}
&=\pi_{\mathrm{coarse}}.
\end{aligned}`),
      paragraph([
        "ここで ",
        math(String.raw`A/N_{\mathrm{fine}}`),
        " と ",
        math(String.raw`A/N_{\mathrm{coarse}}`),
        " は左剰余類集合であり、各商の積は ",
        math(String.raw`(aN)(bN):=(ab)N`),
        " で定める。二つの部分群が正規であるため、この積は代表元に依存せず、それぞれ有限群をなす。段ラベルにより二つの商群を同一視しない。",
      ]),
      displayMath(String.raw`\begin{aligned}
aN_{\mathrm{fine}}=bN_{\mathrm{fine}}
&\Longrightarrow b^{-1}a\in N_{\mathrm{fine}}\\
&\Longrightarrow b^{-1}a\in N_{\mathrm{coarse}}
&&\bigl(\because\ N_{\mathrm{fine}}\subseteq N_{\mathrm{coarse}}\bigr)\\
&\Longrightarrow aN_{\mathrm{coarse}}=bN_{\mathrm{coarse}}.
\end{aligned}`),
      paragraph([
        "したがって ",
        math(String.raw`\kappa`),
        " は代表元に依存しない全射群準同型である。写像 ",
        math(String.raw`\pi_{\mathrm{fine}},\pi_{\mathrm{coarse}}`),
        " はそれぞれの標準全射群準同型であり、最後の等式は二つの段を結ぶ可換条件である。有限商を二つ並べただけの列は、始域と終域をもつ ",
        math(String.raw`\kappa`),
        " とこの可換条件を欠くため、この定義の入力ではない。全ての対象と量化範囲は有限であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
]);
