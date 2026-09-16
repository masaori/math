/**
 * 有限舞台の大域写像に内在する可換置換群と整数値保存写像を分離し、
 * 実数加法群による一径数作用が有限配位集合上では必ず自明になる境界を示す。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_discrete_continuous_symmetry_boundary_definition_commuting_symmetries",
    kind: "definition",
    title: { text: "有限大域写像と可換する配位置換" },
    labels: ["def_binary_ca_commuting_configuration_symmetries"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_finite_ca"), " の有限舞台上の 2 値セルオートマトンの大域写像 ",
        math(String.raw`F:A^V\to A^V`), " に対し、",
      ]),
      displayMath(String.raw`\operatorname{Sym}(F):=
\left\{\sigma:A^V\to A^V\ \middle|\
  \sigma\text{ は全単射であり }\sigma\circ F=F\circ\sigma
\right\}`),
      paragraph([
        "と定める。演算は写像の合成、単位元は恒等写像、逆元は逆写像である。",
        math(String.raw`A^V`), " は有限集合なので ", math(String.raw`\operatorname{Sym}(F)`),
        " も有限集合である。舞台の群構造、配位上の加法、外在的な解釈は仮定しない。",
      ]),
    ],
  },
  {
    id: "finite_discrete_continuous_symmetry_boundary_claim_finite_group",
    kind: "claim",
    title: { text: "可換する配位置換は有限群をなす" },
    labels: ["claim_binary_ca_commuting_configuration_symmetries_finite_group"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_binary_ca_commuting_configuration_symmetries"), " の ",
        math(String.raw`\operatorname{Sym}(F)`), " は写像の合成について有限群をなす。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\sigma,\tau\in\operatorname{Sym}(F)`), " とする。可換条件から",
      ]),
      displayMath(String.raw`\begin{aligned}
(\sigma\circ\tau)\circ F
&=\sigma\circ(\tau\circ F)
  \quad(\because\ \text{写像合成の結合律})\\
&=\sigma\circ(F\circ\tau)
  \quad(\because\ \blkref{def_binary_ca_commuting_configuration_symmetries})\\
&=(\sigma\circ F)\circ\tau
  \quad(\because\ \text{写像合成の結合律})\\
&=(F\circ\sigma)\circ\tau
  \quad(\because\ \blkref{def_binary_ca_commuting_configuration_symmetries})\\
&=F\circ(\sigma\circ\tau)
  \quad(\because\ \text{写像合成の結合律}).
\end{aligned}`),
      paragraph([
        "従って合成で閉じる。恒等写像は ", math(String.raw`F`), " と可換する。さらに ",
        math(String.raw`\sigma\circ F=F\circ\sigma`), " の両辺を ",
        math(String.raw`\sigma^{-1}`), " で左から、続いて右から合成すると",
      ]),
      displayMath(String.raw`F\circ\sigma^{-1}=\sigma^{-1}\circ F`),
      paragraph([
        "を得るので逆写像でも閉じる。結合律は写像合成から従う。有限性は ",
        ref("def_binary_ca_commuting_configuration_symmetries"), " に含まれる。",
      ]),
    ],
  },
  {
    id: "finite_discrete_continuous_symmetry_boundary_definition_conserved_group",
    kind: "definition",
    title: { text: "整数値保存写像の加法群" },
    labels: ["def_binary_ca_integer_conserved_observable_group"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_binary_ca_integer_conserved_observable"), " の大域写像 ",
        math(String.raw`F:A^V\to A^V`), " に対し、",
      ]),
      displayMath(String.raw`\operatorname{Cons}_{\mathbb Z}(F):=
\left\{H:A^V\to\mathbb Z\ \middle|\ H\circ F=H\right\}`),
      paragraph([
        "と定める。演算は点ごとの整数加法、零元は定数零写像、逆元は点ごとの整数符号反転である。",
        math(String.raw`A^V`), " が有限なので、この集合は有限個の整数値で指定され、高々可算である。",
      ]),
    ],
  },
  {
    id: "finite_discrete_continuous_symmetry_boundary_claim_pullback_action",
    kind: "claim",
    title: { text: "有限対称性は保存写像へ引き戻しで作用する" },
    labels: ["claim_binary_ca_symmetry_pullback_preserves_conserved_observables"],
    habitat: "countable",
    statement: [
      paragraph([
        math(String.raw`\sigma\in\operatorname{Sym}(F)`), " と ",
        math(String.raw`H\in\operatorname{Cons}_{\mathbb Z}(F)`), " に対し、",
      ]),
      displayMath(String.raw`\sigma\mathbin{\triangleright}H:=H\circ\sigma^{-1}:A^V\to\mathbb Z`),
      paragraph([
        "と定めると、", math(String.raw`\sigma\mathbin{\triangleright}H\in\operatorname{Cons}_{\mathbb Z}(F)`),
        " である。この作用は保存写像を別の保存写像へ送るだけで、各保存写像が対称性の下で不変であるとは仮定しない。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(\sigma\mathbin{\triangleright}H)\circ F
&=(H\circ\sigma^{-1})\circ F
  \quad(\because\ \text{引き戻しの定義})\\
&=H\circ(\sigma^{-1}\circ F)
  \quad(\because\ \text{写像合成の結合律})\\
&=H\circ(F\circ\sigma^{-1})
  \quad(\because\ \blkref{claim_binary_ca_commuting_configuration_symmetries_finite_group})\\
&=(H\circ F)\circ\sigma^{-1}
  \quad(\because\ \text{写像合成の結合律})\\
&=H\circ\sigma^{-1}
  \quad(\because\ \blkref{def_binary_ca_integer_conserved_observable_group})\\
&=\sigma\mathbin{\triangleright}H
  \quad(\because\ \text{引き戻しの定義}).
\end{aligned}`),
    ],
  },
  {
    id: "finite_discrete_continuous_symmetry_boundary_claim_conserved_additive_group",
    kind: "claim",
    title: { text: "整数値保存写像は加法群をなす" },
    labels: ["claim_binary_ca_integer_conserved_observables_additive_group"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_binary_ca_integer_conserved_observable_group"), " の ",
        math(String.raw`\operatorname{Cons}_{\mathbb Z}(F)`),
        " は点ごとの整数加法について高々可算な加法群をなす。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`H,K\in\operatorname{Cons}_{\mathbb Z}(F)`), " とする。任意の ",
        math(String.raw`x\in A^V`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
((H+K)\circ F)(x)
&=H(Fx)+K(Fx)
  \quad(\because\ \text{点ごとの加法の定義})\\
&=H(x)+K(x)
  \quad(\because\ \blkref{def_binary_ca_integer_conserved_observable_group})\\
&=(H+K)(x)
  \quad(\because\ \text{点ごとの加法の定義}).
\end{aligned}`),
      paragraph([
        "従って加法で閉じる。定数零写像は保存され、", math(String.raw`H\circ F=H`),
        " の両辺を点ごとに整数符号反転すると ", math(String.raw`(-H)\circ F=-H`),
        " なので逆元でも閉じる。結合律と可換律は整数加法から従う。高々可算性は ",
        ref("def_binary_ca_integer_conserved_observable_group"), " に含まれる。",
      ]),
    ],
  },
  {
    id: "finite_discrete_continuous_symmetry_boundary_definition_real_parameter_action",
    kind: "definition",
    title: { text: "有限配位上の実数加法群作用" },
    labels: ["def_binary_ca_real_parameter_symmetry_action"],
    habitat: "R",
    realEscape:
      "有限対称群を連続個の実数パラメータで動かす比較対象を定義するため、パラメータ集合と加法に実数体を用いる。位相、極限、微分は使わない。",
    statement: [
      paragraph([
        ref("def_binary_ca_commuting_configuration_symmetries"), " の ",
        math(String.raw`\operatorname{Sym}(F)`), " に対し、写像 ",
        math(String.raw`\Theta:(\mathbb R,+)\to\operatorname{Sym}(F)`), " が",
      ]),
      displayMath(String.raw`\Theta(0)=\operatorname{id}_{A^V},\qquad
\Theta(s+t)=\Theta(s)\circ\Theta(t)\quad(s,t\in\mathbb R)`),
      paragraph([
        "を満たすとき、有限配位上の実数加法群作用と呼ぶ。ここで「実数」はパラメータの値域と加法にだけ用いる。",
        "位相的連続性は仮定せず、従って後の不可能性は連続な作用だけに限らない。",
      ]),
    ],
  },
  {
    id: "finite_discrete_continuous_symmetry_boundary_claim_real_action_trivial",
    kind: "claim",
    title: { text: "有限配位上の実数加法群作用は自明である" },
    labels: ["claim_binary_ca_real_parameter_symmetry_action_trivial"],
    habitat: "R",
    realEscape:
      "実数加法群の任意の元を正整数で割れる性質と、有限対称群の元の有限位数を比較するため実数体を用いる。位相、極限、微分は使わない。",
    statement: [
      paragraph([
        ref("def_binary_ca_real_parameter_symmetry_action"), " の任意の ",
        math(String.raw`\Theta`), " と任意の ", math(String.raw`t\in\mathbb R`), " について",
      ]),
      displayMath(String.raw`\Theta(t)=\operatorname{id}_{A^V}`),
      paragraph([
        "が成り立つ。従って有限大域写像には非自明な有限位数の離散対称性がありえても、",
        "その同じ有限配位置換群の中に非自明な実数一径数対称性は存在しない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`m:=|\operatorname{Sym}(F)|!\in\mathbb N_{>0}`), " と置く。",
        ref("claim_binary_ca_commuting_configuration_symmetries_finite_group"),
        " と有限群の元の位数に関する Lagrange の定理により、全ての ",
        math(String.raw`g\in\operatorname{Sym}(F)`), " について ", math(String.raw`g^m=\operatorname{id}_{A^V}`), " である。",
        math(String.raw`t\in\mathbb R`), " を固定し、", math(String.raw`r:=t/m\in\mathbb R`), " と置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Theta(t)
&=\Theta(mr)
  \quad(\because\ r=t/m)\\
&=\Theta(r)^m
  \quad(\because\ \blkref{def_binary_ca_real_parameter_symmetry_action})\\
&=\operatorname{id}_{A^V}
  \quad(\because\ \Theta(r)\in\operatorname{Sym}(F)\text{ と }\Theta(r)^m=\operatorname{id}_{A^V}).
\end{aligned}`),
    ],
  },
]);
