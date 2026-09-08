/**
 * 規則クラスの分別として、有限舞台上で二元体線形な局所規則族を定義する。
 *
 * 状態集合へ加える演算を有限表で明示し、局所線形性、大域写像の各保存則、
 * 有限決定可能性、および一般の局所規則では零保存が破れる反例を記す。
 * 有限集合と二元体の有限演算だけで閉じ、対数、除算、極限、実数体、複素数体は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "binary_field_linear_rule_class_definition_state_addition",
    kind: "definition",
    title: { text: "状態集合上の二元体加法" },
    labels: ["def_binary_state_addition"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_state_set"), " の二元集合 ", math(String.raw`A=\{0,1\}`), " に演算 ",
        math(String.raw`\oplus_A:A\times A\to A`), " を次の有限表で定める。",
      ]),
      displayMath(String.raw`\begin{array}{c|cc}
\oplus_A&0&1\\\hline
0&0&1\\
1&1&0
\end{array}`),
      paragraph([
        "この加法と状態の等号は四つの入力対を持つ有限表の中で決定できる。",
      ]),
    ],
  },
  {
    id: "binary_field_linear_rule_class_definition_state_multiplication",
    kind: "definition",
    title: { text: "状態集合上の二元体乗法" },
    labels: ["def_binary_state_multiplication"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_state_set"), " の二元集合 ", math(String.raw`A=\{0,1\}`), " に乗法 ",
        math(String.raw`\odot_A:A\times A\to A`), " を次の有限表で定める。",
      ]),
      displayMath(String.raw`\begin{array}{c|cc}
\odot_A&0&1\\\hline
0&0&0\\
1&0&1
\end{array}`),
      paragraph([
        ref("def_binary_state_addition"), " の加法とこの乗法を備えた状態集合を ",
        math(String.raw`\mathbb F_2`), " と書く。この乗法は有限表の中で決定できる。",
      ]),
    ],
  },
  {
    id: "binary_field_linear_rule_class_definition_zero_input",
    kind: "definition",
    title: { text: "配位と局所入力の零元" },
    labels: ["def_binary_configuration_zero"],
    habitat: "finite",
    statement: [
      paragraph(["有限集合 ", math(String.raw`S`), " に対し、零入力 ", math(String.raw`0_S\in A^S`), " を"]),
      displayMath(String.raw`0_S(w):=0\qquad(w\in S)`),
      paragraph(["で定める。"])],
  },
  {
    id: "binary_field_linear_rule_class_definition_pointwise_addition",
    kind: "definition",
    title: { text: "配位と局所入力の点ごとの和" },
    labels: ["def_binary_configuration_pointwise_addition"],
    habitat: "finite",
    statement: [
      paragraph(["有限集合 ", math(String.raw`S`), " に対し、点ごとの和 ", math(String.raw`\oplus_S:A^S\times A^S\to A^S`), " を"]),
      displayMath(String.raw`(x\oplus_S y)(w):=x(w)\oplus_A y(w)\qquad(x,y\in A^S,\ w\in S)`),
      paragraph(["で定める。状態の和は ", ref("def_binary_state_addition"), " による。"])],
  },
  {
    id: "binary_field_linear_rule_class_definition_scalar_multiplication",
    kind: "definition",
    title: { text: "配位と局所入力のスカラー倍" },
    labels: ["def_binary_configuration_scalar_multiplication"],
    habitat: "finite",
    statement: [
      paragraph(["有限集合 ", math(String.raw`S`), " に対し、スカラー倍 ", math(String.raw`\odot_S:A\times A^S\to A^S`), " を"]),
      displayMath(String.raw`(a\odot_S x)(w):=a\odot_A x(w)\qquad(a\in A,\ x\in A^S,\ w\in S)`),
      paragraph([
        "で定める。状態の乗法は ", ref("def_binary_state_multiplication"), " による。",
      ]),
    ],
  },
  {
    id: "binary_field_linear_rule_class_definition_linear_family",
    kind: "definition",
    title: { text: "二元体上で線形な局所規則族" },
    labels: ["def_binary_field_linear_local_rule_family"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限舞台上の 2 値セルオートマトン ",
        math(String.raw`\bigl((V,N),(f_v)_{v\in V}\bigr)`), "（", ref("def_finite_ca"),
        "）が二元体上で線形であるとは、全ての ", math(String.raw`v\in V`), " について",
      ]),
      displayMath(String.raw`f_v(0_{N(v)})=0`),
      displayMath(String.raw`\forall\,x,y\in A^{N(v)}:\quad
f_v(x\oplus_{N(v)}y)=f_v(x)\oplus_A f_v(y)`),
      displayMath(String.raw`\forall\,a\in A\ \forall\,x\in A^{N(v)}:\quad
f_v(a\odot_{N(v)}x)=a\odot_A f_v(x)`),
      paragraph([
        "が成り立つことをいう。零入力、点ごとの和、スカラー倍はそれぞれ ",
        ref("def_binary_configuration_zero"), "、", ref("def_binary_configuration_pointwise_addition"), "、",
        ref("def_binary_configuration_scalar_multiplication"), " による。",
        "状態集合へ二元体構造を加えたことを名称に明示しており、構造を持たない 2 値セルオートマトンとは区別する。",
      ]),
    ],
  },
  {
    id: "binary_field_linear_rule_class_claim_global_zero_preservation",
    kind: "claim",
    title: { text: "局所線形性は大域写像の零保存を与える" },
    labels: ["claim_binary_field_linear_global_map_preserves_zero"],
    habitat: "finite",
    statement: [
      paragraph([
        "二元体上で線形な有限舞台上の 2 値セルオートマトンの大域写像 ",
        math(String.raw`F:A^V\to A^V`), "（", ref("def_global_map"), "）は",
      ]),
      displayMath(String.raw`F(0_V)=0_V.`),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`v\in V`), " について"]),
      displayMath(String.raw`\begin{aligned}
(F(0_V))(v)
&=f_v\bigl(\rho^V_{N(v)}0_V\bigr)\qquad(\because\ \blkref{def_global_map})\\
&=f_v(0_{N(v)})\qquad(\because\ \blkref{def_binary_configuration_zero})\\
&=0\qquad(\because\ \blkref{def_binary_field_linear_local_rule_family})\\
&=0_V(v)\qquad(\because\ \blkref{def_binary_configuration_zero}).
\end{aligned}`),
      paragraph(["したがって写像の外延性により ", math(String.raw`F(0_V)=0_V`), " である。"]),
    ],
  },
  {
    id: "binary_field_linear_rule_class_claim_global_additivity",
    kind: "claim",
    title: { text: "局所線形性は大域写像の加法保存を与える" },
    labels: ["claim_binary_field_linear_global_map_additive"],
    habitat: "finite",
    statement: [
      paragraph(["二元体上で線形な有限舞台上の 2 値セルオートマトンの大域写像 ", math(String.raw`F:A^V\to A^V`), " は"]),
      displayMath(String.raw`\forall\,p,q\in A^V:\quad F(p\oplus_V q)=F(p)\oplus_V F(q).`),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`p,q\in A^V`), " と ", math(String.raw`v\in V`), " について"]),
      displayMath(String.raw`\begin{aligned}
(F(p\oplus_Vq))(v)
&=f_v\bigl(\rho^V_{N(v)}(p\oplus_Vq)\bigr)\qquad(\because\ \blkref{def_global_map})\\
&=f_v\bigl((\rho^V_{N(v)}p)\oplus_{N(v)}(\rho^V_{N(v)}q)\bigr)\qquad(\because\ \blkref{def_binary_configuration_pointwise_addition})\\
&=f_v(\rho^V_{N(v)}p)\oplus_Af_v(\rho^V_{N(v)}q)\qquad(\because\ \blkref{def_binary_field_linear_local_rule_family})\\
&=(Fp)(v)\oplus_A(Fq)(v)\qquad(\because\ \blkref{def_global_map})\\
&=(Fp\oplus_VFq)(v)\qquad(\because\ \blkref{def_binary_configuration_pointwise_addition}).
\end{aligned}`),
      paragraph(["したがって写像の外延性により主張を得る。"]),
    ],
  },
  {
    id: "binary_field_linear_rule_class_claim_global_scalar_preservation",
    kind: "claim",
    title: { text: "局所線形性は大域写像のスカラー倍保存を与える" },
    labels: ["claim_binary_field_linear_global_map_preserves_scalar_multiplication"],
    habitat: "finite",
    statement: [
      paragraph(["二元体上で線形な有限舞台上の 2 値セルオートマトンの大域写像 ", math(String.raw`F:A^V\to A^V`), " は"]),
      displayMath(String.raw`\forall\,a\in A\ \forall\,p\in A^V:\quad F(a\odot_Vp)=a\odot_VF(p).`),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`a\in A`), "、", math(String.raw`p\in A^V`), "、", math(String.raw`v\in V`), " について"]),
      displayMath(String.raw`\begin{aligned}
(F(a\odot_Vp))(v)
&=f_v\bigl(\rho^V_{N(v)}(a\odot_Vp)\bigr)\qquad(\because\ \blkref{def_global_map})\\
&=f_v\bigl(a\odot_{N(v)}(\rho^V_{N(v)}p)\bigr)\qquad(\because\ \blkref{def_binary_configuration_scalar_multiplication})\\
&=a\odot_Af_v(\rho^V_{N(v)}p)\qquad(\because\ \blkref{def_binary_field_linear_local_rule_family})\\
&=a\odot_A(Fp)(v)\qquad(\because\ \blkref{def_global_map})\\
&=(a\odot_VF(p))(v)\qquad(\because\ \blkref{def_binary_configuration_scalar_multiplication}).
\end{aligned}`),
      paragraph(["したがって写像の外延性により主張を得る。"]),
    ],
  },
  {
    id: "binary_field_linear_rule_class_claim_finite_decidability",
    kind: "claim",
    title: { text: "二元体上の局所線形性は有限決定できる" },
    labels: ["claim_binary_field_linear_membership_finite_decidable"],
    habitat: "finite",
    statement: [
      paragraph(["有限舞台と、その上の有限真理値表として与えられた局所規則族について、二元体上で線形であるか否かは有限決定できる。"]),
    ],
    proof: [
      paragraph([
        "全ての ", math(String.raw`v\in V`), " について零入力での等号を比較し、有限集合 ",
        math(String.raw`A^{N(v)}\times A^{N(v)}`), " の全ての入力対 ", math(String.raw`(x,y)`),
        " を列挙して加法保存の等号を比較する。さらに有限集合 ", math(String.raw`A\times A^{N(v)}`),
        " の全ての組についてスカラー倍保存の等号を比較する。全比較が成立することは ",
        ref("def_binary_field_linear_local_rule_family"), " の三条件そのものである。",
        "したがって有限走査は必ず停止し、所属を決定する。",
      ]),
    ],
  },
  {
    id: "binary_field_linear_rule_class_claim_general_counterexample",
    kind: "claim",
    title: { text: "一般の局所規則は零配位を保存しない" },
    labels: ["claim_general_binary_rule_need_not_preserve_zero"],
    habitat: "finite",
    statement: [
      paragraph([
        "一セル舞台 ", math(String.raw`V=\{u\}`), "、", math(String.raw`N(u)=\{u\}`),
        " と、局所規則 ", math(String.raw`f_u(0)=1`), "、", math(String.raw`f_u(1)=0`),
        " を取る。この有限舞台上の 2 値セルオートマトンの大域写像は ",
        math(String.raw`F(0_V)\neq0_V`), " であり、二元体上で線形ではない。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(F(0_V))(u)
&=f_u\bigl(\rho^V_{N(u)}0_V\bigr)\qquad(\because\ \blkref{def_global_map})\\
&=f_u(0_{N(u)})\qquad(\because\ \blkref{def_binary_configuration_zero})\\
&=1\qquad(\because\ f_u\ \text{の有限表})\\
&\neq0_V(u)\qquad(\because\ \blkref{def_binary_configuration_zero}).
\end{aligned}`),
      paragraph([
        "よって ", math(String.raw`F(0_V)\neq0_V`), " である。また ", math(String.raw`f_u(0_{N(u)})\neq0`),
        " なので ", ref("def_binary_field_linear_local_rule_family"), " の零保存条件を満たさない。",
      ]),
    ],
  },
]);
