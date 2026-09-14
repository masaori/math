/**
 * 規則クラスの分別として、有限舞台上の二次の局所規則族を定義する。
 *
 * 二時刻の有限入力、所属の有限決定、二時刻配位上の大域写像と明示逆写像、
 * および一般の一段規則では可逆性が強制されない境界を記す。
 * 有限集合と二元体加法だけで閉じ、対数、除算、極限、実数体、複素数体は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "second_order_rule_class_definition_local_family",
    kind: "definition",
    title: { text: "二次の局所規則族" },
    labels: ["def_second_order_local_rule_family"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限舞台 ", math(String.raw`(V,N)`), " と ", ref("def_state_set"), " の二元集合 ",
        math(String.raw`A=\{0,1\}`), " を取る。二時刻局所規則族 ",
        math(String.raw`(h_v:A^{N(v)}\times A\to A)_{v\in V}`), " が二次であるとは、全ての ",
        math(String.raw`v\in V`), "、", math(String.raw`z\in A^{N(v)}`), "、",
        math(String.raw`a\in A`), " について",
      ]),
      displayMath(String.raw`h_v(z,a)=h_v(z,0)\oplus_A a`),
      paragraph([
        "が成り立つことをいう。", math(String.raw`z`), " は現在時刻の近傍入力、",
        math(String.raw`a`), " は同じセルの一時刻前の状態である。加法 ",
        math(String.raw`\oplus_A`), " は ", ref("def_binary_state_addition"), " の有限表による。",
        "この定義は外部の解釈を加えず、二つの有限入力から次の二元状態を返す真理値表だけを用いる。",
      ]),
    ],
  },
  {
    id: "second_order_rule_class_claim_base_family_unique",
    kind: "claim",
    title: { text: "二次規則の基礎局所規則族は一意に回復する" },
    labels: ["claim_second_order_base_family_unique"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_second_order_local_rule_family"), " の二次規則族 ", math(String.raw`h`), " に対し、",
        math(String.raw`f_v:A^{N(v)}\to A`), " を ",
      ]),
      displayMath(String.raw`f_v(z):=h_v(z,0)`),
      paragraph([
        "で定めると ", math(String.raw`h_v(z,a)=f_v(z)\oplus_Aa`), " である。さらに、この形を満たす",
        "局所規則族 ", math(String.raw`f`), " は一意である。",
      ]),
    ],
    proof: [
      paragraph(["定義した ", math(String.raw`f_v`), " について、任意の ", math(String.raw`v,z,a`), " に対し"]),
      displayMath(String.raw`\begin{aligned}
h_v(z,a)
&=h_v(z,0)\oplus_Aa\qquad(\because\ \blkref{def_second_order_local_rule_family})\\
&=f_v(z)\oplus_Aa\qquad(\because\ f_v\ \text{の定義}).
\end{aligned}`),
      paragraph([
        "別の局所規則族 ", math(String.raw`g`), " が ", math(String.raw`h_v(z,a)=g_v(z)\oplus_Aa`),
        " を満たすとする。", math(String.raw`a=0`), " と置くと",
      ]),
      displayMath(String.raw`\begin{aligned}
g_v(z)
&=g_v(z)\oplus_A0\qquad(\because\ \blkref{def_binary_state_addition})\\
&=h_v(z,0)\qquad(\because\ h_v(z,a)=g_v(z)\oplus_Aa)\\
&=f_v(z)\qquad(\because\ f_v\ \text{の定義}).
\end{aligned}`),
      paragraph(["したがって写像の外延性により ", math(String.raw`g_v=f_v`), " であり、族全体も一意である。"]),
    ],
  },
  {
    id: "second_order_rule_class_claim_membership_finite_decidable",
    kind: "claim",
    title: { text: "二次規則族への所属は有限決定できる" },
    labels: ["claim_second_order_membership_finite_decidable"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限舞台と有限真理値表として与えられた二時刻局所規則族について、二次であるか否かは有限決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " の全ての ", math(String.raw`v`), " と、有限集合 ",
        math(String.raw`A^{N(v)}\times A`), " の全ての ", math(String.raw`(z,a)`), " を列挙し、",
        math(String.raw`h_v(z,a)=h_v(z,0)\oplus_Aa`), " を比較する。全比較の成立は ",
        ref("def_second_order_local_rule_family"), " の条件そのものである。したがって有限走査は必ず停止し、所属を決定する。",
      ]),
    ],
  },
  {
    id: "second_order_rule_class_definition_two_time_configuration_space",
    kind: "definition",
    title: { text: "二時刻配位空間" },
    labels: ["def_second_order_configuration_space"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限舞台 ", math(String.raw`V`), " の配位空間を ", math(String.raw`X:=A^V`), " と置き、",
        "二時刻配位空間を ", math(String.raw`X^{\langle2\rangle}:=X\times X`), " と定める。",
        math(String.raw`(p,c)\in X^{\langle2\rangle}`), " の第一成分 ", math(String.raw`p`),
        " は一時刻前、第二成分 ", math(String.raw`c`), " は現在時刻の配位を表す。",
        math(String.raw`X^{\langle2\rangle}`), " は ", math(String.raw`2^{2|V|}`), " 元の有限集合である。",
      ]),
    ],
  },
  {
    id: "second_order_rule_class_definition_recovered_global_map",
    kind: "definition",
    title: { text: "二次規則から回復する一段大域写像" },
    labels: ["def_second_order_recovered_global_map"],
    habitat: "finite",
    statement: [
      paragraph([
        "二次規則族 ", math(String.raw`h`), " に対し、写像 ", math(String.raw`F_h:X\to X`), " を",
      ]),
      displayMath(String.raw`(F_hc)(v):=h_v\bigl(\rho^V_{N(v)}c,0\bigr)
\qquad(c\in X,\ v\in V)`),
      paragraph([
        "で定める。", math(String.raw`\rho^V_{N(v)}`), " は ", ref("def_restriction_map"),
        " の制限写像である。", ref("claim_second_order_base_family_unique"),
        " により、これは二次規則から一意に回復する基礎局所規則族の大域写像である。",
      ]),
    ],
  },
  {
    id: "second_order_rule_class_definition_global_evolution",
    kind: "definition",
    title: { text: "二次規則の二時刻大域写像" },
    labels: ["def_second_order_global_evolution"],
    habitat: "finite",
    statement: [
      paragraph([
        "二次規則族 ", math(String.raw`h`), " の二時刻大域写像 ",
        math(String.raw`H_h:X^{\langle2\rangle}\to X^{\langle2\rangle}`), " を",
      ]),
      displayMath(String.raw`H_h(p,c):=\bigl(c,F_hc\oplus_Vp\bigr)
\qquad((p,c)\in X^{\langle2\rangle})`),
      paragraph([
        "で定める。", math(String.raw`\oplus_V`), " は ", ref("def_binary_configuration_pointwise_addition"),
        "、", math(String.raw`F_h`), " は ", ref("def_second_order_recovered_global_map"), " による。",
        "各セルでの次状態は ", math(String.raw`h_v(\rho^V_{N(v)}c,p(v))`),
        " に等しい（", ref("def_second_order_local_rule_family"), "）。",
      ]),
    ],
  },
  {
    id: "second_order_rule_class_definition_inverse_candidate",
    kind: "definition",
    title: { text: "二次規則の逆写像候補" },
    labels: ["def_second_order_inverse_candidate"],
    habitat: "finite",
    statement: [
      paragraph([
        "写像 ", math(String.raw`K_h:X^{\langle2\rangle}\to X^{\langle2\rangle}`), " を",
      ]),
      displayMath(String.raw`K_h(c,n):=\bigl(n\oplus_VF_hc,c\bigr)
\qquad((c,n)\in X^{\langle2\rangle})`),
      paragraph([
        "で定める。", math(String.raw`F_h`), " は ", ref("def_second_order_recovered_global_map"),
        " による。これは有限表と点ごとの二元体加法だけで定まる写像である。",
      ]),
    ],
  },
  {
    id: "second_order_rule_class_claim_binary_cancellation",
    kind: "claim",
    title: { text: "二元体加法では反復した入力が消える" },
    labels: ["claim_binary_state_addition_cancellation"],
    habitat: "finite",
    statement: [
      displayMath(String.raw`\forall\,a,b\in A:\quad
(a\oplus_Ab)\oplus_Aa=a\oplus_A(b\oplus_Aa)=b.`),
    ],
    proof: [
      paragraph([
        math(String.raw`(a,b)\in A\times A`), " の四通りを ", ref("def_binary_state_addition"),
        " の有限表へ代入すると、両方の式の値は全て ", math(String.raw`b`), " に一致する。",
      ]),
    ],
  },
  {
    id: "second_order_rule_class_claim_inverse_after_evolution",
    kind: "claim",
    title: { text: "逆写像候補を二次発展の後に施すと元へ戻る" },
    labels: ["claim_second_order_inverse_after_evolution"],
    habitat: "finite",
    statement: [
      displayMath(String.raw`\forall\,(p,c)\in X^{\langle2\rangle}:\quad
K_h\bigl(H_h(p,c)\bigr)=(p,c).`),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`(p,c)\in X^{\langle2\rangle}`), " について"]),
      displayMath(String.raw`\begin{aligned}
K_h\bigl(H_h(p,c)\bigr)
&=K_h\bigl(c,F_hc\oplus_Vp\bigr)\qquad(\because\ \blkref{def_second_order_global_evolution})\\
&=\bigl((F_hc\oplus_Vp)\oplus_VF_hc,c\bigr)\qquad(\because\ \blkref{def_second_order_inverse_candidate})\\
&=(p,c)\qquad(\because\ \blkref{claim_binary_state_addition_cancellation}\ \text{を各}\ v\in V\ \text{で適用}).
\end{aligned}`),
    ],
  },
  {
    id: "second_order_rule_class_claim_evolution_after_inverse",
    kind: "claim",
    title: { text: "二次発展を逆写像候補の後に施すと元へ戻る" },
    labels: ["claim_second_order_evolution_after_inverse"],
    habitat: "finite",
    statement: [
      displayMath(String.raw`\forall\,(c,n)\in X^{\langle2\rangle}:\quad
H_h\bigl(K_h(c,n)\bigr)=(c,n).`),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`(c,n)\in X^{\langle2\rangle}`), " について"]),
      displayMath(String.raw`\begin{aligned}
H_h\bigl(K_h(c,n)\bigr)
&=H_h\bigl(n\oplus_VF_hc,c\bigr)\qquad(\because\ \blkref{def_second_order_inverse_candidate})\\
&=\bigl(c,F_hc\oplus_V(n\oplus_VF_hc)\bigr)\qquad(\because\ \blkref{def_second_order_global_evolution})\\
&=(c,n)\qquad(\because\ \blkref{claim_binary_state_addition_cancellation}\ \text{を各}\ v\in V\ \text{で適用}).
\end{aligned}`),
    ],
  },
  {
    id: "second_order_rule_class_theorem_global_bijection",
    kind: "theorem",
    title: { text: "二次規則の二時刻大域写像は全単射である" },
    labels: ["theorem_second_order_global_evolution_bijective"],
    habitat: "finite",
    statement: [
      paragraph([
        "任意の二次規則族について、", ref("def_second_order_global_evolution"), " の ",
        math(String.raw`H_h:X^{\langle2\rangle}\to X^{\langle2\rangle}`), " は全単射であり、逆写像は ",
        ref("def_second_order_inverse_candidate"), " の ", math(String.raw`K_h`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_second_order_inverse_after_evolution"), " より ", math(String.raw`K_h\circ H_h`),
        " は恒等写像であり、", ref("claim_second_order_evolution_after_inverse"), " より ",
        math(String.raw`H_h\circ K_h`), " は恒等写像である。したがって ", math(String.raw`H_h`),
        " と ", math(String.raw`K_h`), " は互いに逆写像であり、", math(String.raw`H_h`), " は全単射である。",
      ]),
    ],
  },
  {
    id: "second_order_rule_class_claim_general_rule_not_forced_reversible",
    kind: "claim",
    title: { text: "一般の一段局所規則では可逆性は強制されない" },
    labels: ["claim_general_binary_rule_not_forced_reversible"],
    habitat: "finite",
    statement: [
      paragraph([
        "一セル舞台 ", math(String.raw`V=\{u\}`), "、", math(String.raw`N(u)=\{u\}`),
        " と定値局所規則 ", math(String.raw`f_u(0)=f_u(1)=0`), " を取る。対応する一段大域写像 ",
        math(String.raw`F:A^V\to A^V`), " は全単射ではない。",
      ]),
    ],
    proof: [
      paragraph(["二つの配位 ", math(String.raw`x_0,x_1\in A^V`), " を ", math(String.raw`x_0(u)=0`), "、", math(String.raw`x_1(u)=1`), " で定める。"]),
      displayMath(String.raw`\begin{aligned}
(Fx_0)(u)
&=f_u(0)\qquad(\because\ \blkref{def_global_map})\\
&=0\qquad(\because\ f_u\ \text{の有限表})\\
&=f_u(1)\qquad(\because\ f_u\ \text{の有限表})\\
&=(Fx_1)(u)\qquad(\because\ \blkref{def_global_map}).
\end{aligned}`),
      paragraph([
        math(String.raw`x_0\neq x_1`), " だが ", math(String.raw`Fx_0=Fx_1`), " なので ",
        math(String.raw`F`), " は単射でなく、したがって全単射でない（", ref("claim_finite_self_map_injective_iff_surjective"), "）。",
        "よって ", ref("theorem_second_order_global_evolution_bijective"),
        " の可逆性は一般の一段規則ではなく、二時刻の更新形が与える固有の主張である。",
      ]),
    ],
  },
]);
