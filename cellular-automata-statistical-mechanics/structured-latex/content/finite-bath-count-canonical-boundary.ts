/**
 * 二つの有限二値配位集合と整数値観測から、第二配位側の状態数比を有理確率分布として作る。
 * 実指数形との比較は標準埋め込みと実対数を選んだ後だけに置き、零重みの有限反例を分離する。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_bath_count_canonical_boundary_definition_two_configuration_systems",
    kind: "definition",
    title: { text: "二つの有限二値配位集合と整数値観測" },
    labels: ["def_binary_finite_two_configuration_integer_observations"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_state_set"), " の二元集合 ", math(String.raw`A=\{0,1\}`), " と、有限セル集合 ",
        math(String.raw`V_A,V_B`), " を取り、有限配位集合を ",
        math(String.raw`X_A:=A^{V_A}`), "、", math(String.raw`X_B:=A^{V_B}`), " と置く。整数値観測 ",
        math(String.raw`H_A:X_A\to\mathbb Z`), "、", math(String.raw`H_B:X_B\to\mathbb Z`),
        " を与える。局所規則、時間発展、これら以外の意味づけはこの入力へ仮定しない。",
      ]),
    ],
  },
  {
    id: "finite_bath_count_canonical_boundary_definition_second_multiplicity",
    kind: "definition",
    title: { text: "第二配位集合の整数値観測ごとの多重度" },
    labels: ["def_binary_finite_second_observation_multiplicity"],
    habitat: "N",
    statement: [
      paragraph([ref("def_binary_finite_two_configuration_integer_observations"), " の各 ", math(String.raw`k\in\mathbb Z`), " に対し"]),
      displayMath(String.raw`\Omega_B(k):=\left|\{y\in X_B:H_B(y)=k\}\right|\in\mathbb N`),
      paragraph(["と定める。これは有限集合の繊維の元数であり、対数、除算、実数体を使わない。"]),
    ],
  },
  {
    id: "finite_bath_count_canonical_boundary_definition_total_shell",
    kind: "definition",
    title: { text: "二つの整数値観測の和を固定した有限殻" },
    labels: ["def_binary_finite_total_observation_shell"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_binary_finite_two_configuration_integer_observations"), " の各 ", math(String.raw`U\in\mathbb Z`), " に対し"]),
      displayMath(String.raw`\Sigma_U:=\{(x,y)\in X_A\times X_B:H_A(x)+H_B(y)=U\}`),
      paragraph(["と定める。有限集合の直積の部分集合なので ", math(String.raw`\Sigma_U`), " は有限である。"]),
    ],
  },
  {
    id: "finite_bath_count_canonical_boundary_claim_shell_cardinality",
    kind: "claim",
    title: { text: "有限殻の元数は第二配位側の多重度の有限和である" },
    labels: ["claim_binary_finite_total_shell_cardinality"],
    habitat: "N",
    statement: [
      paragraph([ref("def_binary_finite_total_observation_shell"), " の全ての ", math(String.raw`U\in\mathbb Z`), " について"]),
      displayMath(String.raw`|\Sigma_U|=\sum_{x\in X_A}\Omega_B\!\left(U-H_A(x)\right)`),
      paragraph(["が成り立つ。右辺は有限個の自然数の和である。"]),
    ],
    proof: [
      paragraph([math(String.raw`x\in X_A`), " を固定したとき、第一成分が ", math(String.raw`x`), " である殻の繊維は"]),
      displayMath(String.raw`\begin{aligned}
\{y\in X_B:(x,y)\in\Sigma_U\}
&=\{y\in X_B:H_A(x)+H_B(y)=U\}
  \quad(\because\ \blkref{def_binary_finite_total_observation_shell})\\
&=\{y\in X_B:H_B(y)=U-H_A(x)\}
  \quad(\because\ \mathbb Z\text{ の加法群で }H_A(x)\text{ を両辺から引く}).
\end{aligned}`),
      paragraph(["この繊維の元数は ", ref("def_binary_finite_second_observation_multiplicity"), " により ",
        math(String.raw`\Omega_B(U-H_A(x))`), " である。殻を第一成分ごとの互いに素な有限繊維へ分け、その元数を足すと主張を得る。"]),
    ],
  },
  {
    id: "finite_bath_count_canonical_boundary_definition_rational_distribution",
    kind: "definition",
    title: { text: "有限殻から作る状態数比の有理分布" },
    labels: ["def_binary_finite_bath_count_canonical_distribution"],
    habitat: "Q",
    statement: [
      paragraph([ref("def_binary_finite_total_observation_shell"), " の ", math(String.raw`U\in\mathbb Z`), " が ",
        math(String.raw`|\Sigma_U|>0`), " を満たすとき、各 ", math(String.raw`x\in X_A`), " に対し"]),
      displayMath(String.raw`P_U^{\mathrm{count}}(x):=
\frac{\Omega_B(U-H_A(x))}{|\Sigma_U|}\in\mathbb Q`),
      paragraph(["と定める。分母の正値条件を明示しているので除算は定義される。分子が零の場合は重みを零とし、零の対数は取らない。"]),
    ],
  },
  {
    id: "finite_bath_count_canonical_boundary_claim_marginal",
    kind: "claim",
    title: { text: "状態数比の有理分布は有限殻上一様分布の第一周辺分布である" },
    labels: ["claim_binary_finite_bath_count_distribution_is_marginal"],
    habitat: "Q",
    statement: [
      paragraph([ref("def_binary_finite_bath_count_canonical_distribution"), " の全ての入力について、各 ", math(String.raw`x\in X_A`), " で"]),
      displayMath(String.raw`P_U^{\mathrm{count}}(x)
=\sum_{\substack{y\in X_B\\(x,y)\in\Sigma_U}}\frac1{|\Sigma_U|}`),
      paragraph(["が成り立ち、"]),
      displayMath(String.raw`\sum_{x\in X_A}P_U^{\mathrm{count}}(x)=1`),
      paragraph(["である。従って値域は ", math(String.raw`\mathbb Q\cap[0,1]_{\mathbb{Q}}`), " であり、有限整数比較と有理数演算だけで全成分を決定できる。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\sum_{\substack{y\in X_B\\(x,y)\in\Sigma_U}}\frac1{|\Sigma_U|}
&=\frac{\left|\{y\in X_B:(x,y)\in\Sigma_U\}\right|}{|\Sigma_U|}
  \quad(\because\ \text{同じ有理数の有限和})\\
&=\frac{\Omega_B(U-H_A(x))}{|\Sigma_U|}
  \quad(\because\ \blkref{claim_binary_finite_total_shell_cardinality}\text{ の証明で得た繊維の元数})\\
&=P_U^{\mathrm{count}}(x)
  \quad(\because\ \blkref{def_binary_finite_bath_count_canonical_distribution}).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sum_{x\in X_A}P_U^{\mathrm{count}}(x)
&=\frac{\sum_{x\in X_A}\Omega_B(U-H_A(x))}{|\Sigma_U|}
  \quad(\because\ \blkref{def_binary_finite_bath_count_canonical_distribution}\text{ と有限和の分配則})\\
&=\frac{|\Sigma_U|}{|\Sigma_U|}
  \quad(\because\ \blkref{claim_binary_finite_total_shell_cardinality})\\
&=1
  \quad(\because\ |\Sigma_U|>0).
\end{aligned}`),
    ],
  },
  {
    id: "finite_bath_count_canonical_boundary_definition_real_exponential_distribution",
    kind: "definition",
    title: { text: "有限実数値観測から作る指数規格化分布" },
    labels: ["def_binary_finite_real_exponential_canonical_distribution"],
    habitat: "R",
    realEscape:
      "有限二値配位に実数値観測と正の実数値係数を与え、実指数関数を各有限項へ適用する箇所で実数体へ脱出する。",
    statement: [
      paragraph([ref("def_binary_finite_two_configuration_integer_observations"), " の有限集合 ", math(String.raw`X_A`), " に対し、実数値写像 ",
        math(String.raw`E:X_A\to\mathbb R`), " と ", math(String.raw`\beta\in\mathbb R_{>0}`), " を取る。"]),
      displayMath(String.raw`Z_{\beta,E}:=\sum_{z\in X_A}\exp_{\mathbb R}(-\beta E(z))\in\mathbb R_{>0}`),
      displayMath(String.raw`P_{\beta,E}^{\exp}(x):=
\frac{\exp_{\mathbb R}(-\beta E(x))}{Z_{\beta,E}}\in\mathbb R_{>0}
\qquad(x\in X_A)`),
      paragraph(["と定める。有限和だが、実数値入力と実指数関数を選ぶため実数へ脱出する。各重みは厳密に正である。"]),
    ],
  },
  {
    id: "finite_bath_count_canonical_boundary_claim_positive_support_comparison",
    kind: "claim",
    title: { text: "正の状態数比は実対数を経由して指数規格化分布に移せる" },
    labels: ["claim_binary_finite_positive_bath_count_exponential_comparison"],
    habitat: "R",
    realEscape:
      "正の自然数値多重度を実数へ送り、その実対数から実数値観測を作って実指数関数で再評価するため実数体を使う。",
    statement: [
      paragraph([ref("def_binary_finite_bath_count_canonical_distribution"), " の入力が全ての ", math(String.raw`x\in X_A`), " で ",
        math(String.raw`\Omega_B(U-H_A(x))>0`), " を満たすとする。実数値写像を"]),
      displayMath(String.raw`E_U(x):=-\log_{\mathbb R}\!\left(
\iota_{\mathbb Q,\mathbb R}\!\left(\frac{\Omega_B(U-H_A(x))}{1}\right)
\right)`),
      paragraph(["で定めると、全ての ", math(String.raw`x\in X_A`), " について"]),
      displayMath(String.raw`\iota_{\mathbb Q,\mathbb R}\!\left(P_U^{\mathrm{count}}(x)\right)
=P_{1,E_U}^{\exp}(x)`),
      paragraph(["が成り立つ。比較は正の台でだけ定義され、実対数と実指数関数を経由する。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\exp_{\mathbb R}(-E_U(x))
&=\exp_{\mathbb R}\!\left(\log_{\mathbb R}\!\left(
  \iota_{\mathbb Q,\mathbb R}\!\left(\frac{\Omega_B(U-H_A(x))}{1}\right)
\right)\right)
  \quad(\because\ E_U\text{ の定義})\\
&=\iota_{\mathbb Q,\mathbb R}\!\left(\frac{\Omega_B(U-H_A(x))}{1}\right)
  \quad(\because\ \Omega_B(U-H_A(x))>0\text{ と実対数・実指数関数の逆写像性}).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
P_{1,E_U}^{\exp}(x)
&=\frac{\iota_{\mathbb Q,\mathbb R}(\Omega_B(U-H_A(x))/1)}
{\sum_{z\in X_A}\iota_{\mathbb Q,\mathbb R}(\Omega_B(U-H_A(z))/1)}
  \quad(\because\ \blkref{def_binary_finite_real_exponential_canonical_distribution}\text{ と上の等式})\\
&=\frac{\iota_{\mathbb Q,\mathbb R}(\Omega_B(U-H_A(x))/1)}
{\iota_{\mathbb Q,\mathbb R}(|\Sigma_U|/1)}
  \quad(\because\ \blkref{claim_binary_finite_total_shell_cardinality}\text{ と標準単射の有限和保存})\\
&=\iota_{\mathbb Q,\mathbb R}\!\left(\frac{\Omega_B(U-H_A(x))}{|\Sigma_U|}\right)
  \quad(\because\ \iota_{\mathbb Q,\mathbb R}\text{ の除算保存と }|\Sigma_U|>0)\\
&=\iota_{\mathbb Q,\mathbb R}\!\left(P_U^{\mathrm{count}}(x)\right)
  \quad(\because\ \blkref{def_binary_finite_bath_count_canonical_distribution}).
\end{aligned}`),
    ],
  },
  {
    id: "finite_bath_count_canonical_boundary_claim_zero_support_counterexample",
    kind: "claim",
    title: { text: "零を持つ有限状態数比分布は有限実数値指数形では表せない" },
    labels: ["claim_binary_finite_bath_count_not_always_exponential_canonical"],
    habitat: "R",
    realEscape:
      "有限状態数比の零成分を、有限実数値観測と実指数関数から得る厳密正値の分布と比較するため実数体を使う。",
    statement: [
      paragraph(["一セル集合 ", math(String.raw`V_A:=\{a\}`), "、", math(String.raw`V_B:=\{b\}`), " を取り、配位 ",
        math(String.raw`x_i(a):=i`), "、", math(String.raw`y_i(b):=i`), "（", math(String.raw`i\in A`), "）を置く。整数値観測を"]),
      displayMath(String.raw`H_A(x_0):=0,\quad H_A(x_1):=1,\qquad
H_B(y_0):=H_B(y_1):=0`),
      paragraph(["で定め、", math(String.raw`U:=0`), " とすると"]),
      displayMath(String.raw`P_0^{\mathrm{count}}(x_0)=1,\qquad P_0^{\mathrm{count}}(x_1)=0.`),
      paragraph(["従って有限実数値写像 ", math(String.raw`E:X_A\to\mathbb R`), " と ", math(String.raw`\beta\in\mathbb R_{>0}`), " で"]),
      displayMath(String.raw`\iota_{\mathbb Q,\mathbb R}\circ P_0^{\mathrm{count}}
=P_{\beta,E}^{\exp}`),
      paragraph(["を満たすものは存在しない。指数形へ移すには、零重みの配位を定義域から除くか、有限実数値ではない追加の入力を許す必要がある。"]),
    ],
    proof: [
      paragraph(["定義から ", math(String.raw`\Omega_B(0)=2`), "、", math(String.raw`\Omega_B(-1)=0`), " である。従って"]),
      displayMath(String.raw`\begin{aligned}
|\Sigma_0|
&=\Omega_B(0-H_A(x_0))+\Omega_B(0-H_A(x_1))
  \quad(\because\ \blkref{claim_binary_finite_total_shell_cardinality})\\
&=2+0
  \quad(\because\ H_A,H_B\text{ の上の有限表})\\
&=2.
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
P_0^{\mathrm{count}}(x_0)
&=\frac22=1
  \quad(\because\ \blkref{def_binary_finite_bath_count_canonical_distribution}),\\
P_0^{\mathrm{count}}(x_1)
&=\frac02=0
  \quad(\because\ \blkref{def_binary_finite_bath_count_canonical_distribution}).
\end{aligned}`),
      paragraph(["一方、", ref("def_binary_finite_real_exponential_canonical_distribution"), " により全ての有限実数値 ",
        math(String.raw`E`), " と正の ", math(String.raw`\beta`), " について ", math(String.raw`P_{\beta,E}^{\exp}(x_1)>0`),
        " である。これは標準実数像 ", math(String.raw`\iota_{\mathbb Q,\mathbb R}(P_0^{\mathrm{count}}(x_1))=0`), " と一致しない。"]),
    ],
  },
]);
