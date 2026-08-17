import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

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
  {
    id: "quotient_tower_definition_role_generator_compatibility",
    kind: "definition",
    title: { text: "商の塔における役割生成元の整合性" },
    labels: ["def_quotient_tower_role_generator_compatibility"],
    habitat: "finite",
    verification: ["sagemath/check/two-stage-quotient-tower-role-generators"],
    statement: [
      paragraph([
        ref("def_two_stage_finite_quotient_tower_input"),
        " の二段の有限商の塔 ",
        math(String.raw`\mathcal T`),
        " と、",
        ref("def_hyperbolic_triangle_permutation_quotient_input"),
        " で用いた面・頂点・辺に対応する相異なる形式的役割ラベルの有限集合 ",
        math(String.raw`\mathcal R:=\{F,V,E\}`),
        " を取る。共通有限群の元の族 ",
        math(String.raw`s=(s_R)_{R\in\mathcal R}\in A^{\mathcal R}`),
        " が",
      ]),
      displayMath(String.raw`A=\langle s_F,s_V,s_E\rangle`),
      paragraph([
        "を満たすとする。各役割 ",
        math(String.raw`R\in\mathcal R`),
        " について、細段と粗段の役割生成元を",
      ]),
      displayMath(String.raw`\begin{aligned}
r_R^{\mathrm{fine}}
&:=
\pi_{\mathrm{fine}}(s_R)
\in Q_{\mathrm{fine}},\\
r_R^{\mathrm{coarse}}
&:=
\pi_{\mathrm{coarse}}(s_R)
\in Q_{\mathrm{coarse}}
\end{aligned}`),
      paragraph([
        "で定める。この六元を伴う塔が役割生成元について整合するとは、各 ",
        math(String.raw`R\in\mathcal R`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
\kappa\left(r_R^{\mathrm{fine}}\right)
&=
\kappa\left(\pi_{\mathrm{fine}}(s_R)\right)\\
&=
\pi_{\mathrm{coarse}}(s_R)
&&\bigl(\because\ \kappa\circ\pi_{\mathrm{fine}}=\pi_{\mathrm{coarse}}\bigr)\\
&=
r_R^{\mathrm{coarse}}
\end{aligned}`),
      paragraph([
        "が成り立つことと定める。標準射影は全射群準同型であり、",
        math(String.raw`A=\langle s_F,s_V,s_E\rangle`),
        " なので、両段ではそれぞれ",
      ]),
      displayMath(String.raw`\begin{aligned}
Q_{\mathrm{fine}}
&=
\left\langle
  r_F^{\mathrm{fine}},
  r_V^{\mathrm{fine}},
  r_E^{\mathrm{fine}}
\right\rangle,\\
Q_{\mathrm{coarse}}
&=
\left\langle
  r_F^{\mathrm{coarse}},
  r_V^{\mathrm{coarse}},
  r_E^{\mathrm{coarse}}
\right\rangle.
\end{aligned}`),
      paragraph([
        "ここでは役割名の一致を、名前の使い回しではなく始域と終域をもつ ",
        math(String.raw`\kappa`),
        " による三つの等式として固定する。商で元の位数が小さくなることは許し、各段が双曲型正則セル分割を生成することはこの定義から結論しない。全ての群、元、写像は有限であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
]);
