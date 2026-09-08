/**
 * 有限舞台の有理遷移重みを有限行列へ送る比較写像を定義し、決定論的な零一重みでは
 * 行列冪の跡が反復不動点数に一致することを示す。
 * 有限和・有限積、有理数、自然数、対数順序群だけを使い、極限と実数体・複素数体は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_transfer_matrix_comparison_definition_matrix",
    kind: "definition",
    title: { text: "有理遷移重みから得る有限転送行列" },
    labels: ["def_rational_transition_transfer_matrix"],
    habitat: "Q",
    statement: [
      paragraph([
        ref("def_probabilistic_global_transition_weight"),
        " の有限配位集合 ",
        math(String.raw`X=A^V`),
        " と大域遷移重み ",
        math(String.raw`K_\kappa:X\times X\to\mathbb Q_{\mathrm{prob}}`),
        " を取る。包含写像 ",
        math(String.raw`\iota_{\mathrm{prob}}:\mathbb Q_{\mathrm{prob}}\to\mathbb Q`),
        " を ",
        math(String.raw`\iota_{\mathrm{prob}}(q):=q`),
        " と定める。行を現在配位、列を次配位で添字づける有限転送行列 ",
        math(String.raw`T_\kappa\in\mathbb Q^{X\times X}`),
        " を",
      ]),
      displayMath(String.raw`T_\kappa(x,y):=\iota_{\mathrm{prob}}\!\left(K_\kappa(x,y)\right)\qquad(x,y\in X)`),
      paragraph([
        "で定める。この行列化は値を変えず、有限集合上の二変数有理関数へ座標を付ける比較写像である。",
        " 行と列の向きをこの定義で固定し、転置した慣習とは同一視しない。",
      ]),
    ],
  },
  {
    id: "finite_transfer_matrix_comparison_definition_power_trace",
    kind: "definition",
    title: { text: "有限転送行列の冪と跡" },
    labels: ["def_rational_transfer_matrix_power_trace"],
    habitat: "Q",
    statement: [
      paragraph([
        ref("def_rational_transition_transfer_matrix"),
        " の ",
        math(String.raw`T_\kappa`),
        " に対し、各 ",
        math(String.raw`n\in\mathbb N`),
        " の行列冪を有限和と有限積だけで",
      ]),
      displayMath(String.raw`T_\kappa^{\langle0\rangle}(x,y):=\begin{cases}1,&x=y,\\0,&x\ne y,\end{cases}`),
      displayMath(String.raw`T_\kappa^{\langle n+1\rangle}(x,y):=\sum_{z\in X}
  T_\kappa^{\langle n\rangle}(x,z)T_\kappa(z,y)`),
      paragraph(["と再帰的に定め、その跡を"]),
      displayMath(String.raw`Z^{\mathrm{tr}}_{\kappa,n}:=\operatorname{Tr}\!\left(T_\kappa^{\langle n\rangle}\right)
  :=\sum_{x\in X}T_\kappa^{\langle n\rangle}(x,x)\in\mathbb Q_{\ge0}`),
      paragraph([
        "と定める。全ての和は有限であり、行列冪と跡には除算、対数、極限を使わない。",
        " 一般の有理重みでは ",
        math(String.raw`Z^{\mathrm{tr}}_{\kappa,n}`),
        " は有理数であり、集合の元数とはまだ主張しない。",
      ]),
    ],
  },
  {
    id: "finite_transfer_matrix_comparison_claim_power_is_finite_transition",
    kind: "claim",
    title: { text: "行列冪は有限回遷移重みと成分ごとに一致する" },
    labels: ["claim_transfer_matrix_power_equals_finite_step_weight"],
    habitat: "Q",
    statement: [
      paragraph([
        ref("def_rational_transfer_matrix_power_trace"),
        " と ",
        ref("claim_probabilistic_finite_step_rational_closure"),
        " の入力に対し、全ての ",
        math(String.raw`n\in\mathbb N`),
        " と ",
        math(String.raw`x,y\in X`),
        " について",
      ]),
      displayMath(String.raw`T_\kappa^{\langle n\rangle}(x,y)=K_\kappa^{\langle n\rangle}(x,y)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([math(String.raw`n`), " に関する帰納法を使う。零回では両辺が有限配位の等号指示値である。帰納法の仮定のもとで、"]),
      displayMath(String.raw`\begin{aligned}
T_\kappa^{\langle n+1\rangle}(x,y)
&=\sum_{z\in X}T_\kappa^{\langle n\rangle}(x,z)T_\kappa(z,y)
  \qquad(\because\ \blkref{def_rational_transfer_matrix_power_trace})\\
&=\sum_{z\in X}K_\kappa^{\langle n\rangle}(x,z)T_\kappa(z,y)
  \qquad(\because\ \text{帰納法の仮定})\\
&=\sum_{z\in X}K_\kappa^{\langle n\rangle}(x,z)K_\kappa(z,y)
  \qquad(\because\ \blkref{def_rational_transition_transfer_matrix})\\
&=K_\kappa^{\langle n+1\rangle}(x,y)
  \qquad(\because\ \blkref{claim_probabilistic_finite_step_rational_closure}).
\end{aligned}`),
    ],
  },
  {
    id: "finite_transfer_matrix_comparison_definition_deterministic_embedding",
    kind: "definition",
    title: { text: "決定論的局所規則族の零一重みへの埋め込み" },
    labels: ["def_deterministic_rule_zero_one_embedding"],
    habitat: "Q",
    statement: [
      paragraph([
        "二元状態集合 ",
        math(String.raw`A=\{0,1\}`),
        " から有理確率重みへの写像 ",
        math(String.raw`\iota_A:A\to\mathbb Q_{\mathrm{prob}}`),
        " を ",
        math(String.raw`\iota_A(0):=0`),
        "、",
        math(String.raw`\iota_A(1):=1`),
        " と定める。有限舞台上の決定論的局所規則族 ",
        math(String.raw`(f_v:A^{N(v)}\to A)_{v\in V}`),
        " を、",
      ]),
      displayMath(String.raw`\kappa^f_v:=\iota_A\circ f_v:A^{N(v)}\longrightarrow\mathbb Q_{\mathrm{prob}}`),
      paragraph([
        "で有理重みの確率的局所規則族へ送る。これは状態値と有理数を暗黙に同一視せず、二つの有限集合の間の写像を明示した零一重みへの埋め込みである。",
      ]),
    ],
  },
  {
    id: "finite_transfer_matrix_comparison_claim_deterministic_entry",
    kind: "claim",
    title: { text: "零一重みの転送行列は大域写像の遷移指示値である" },
    labels: ["claim_deterministic_transfer_matrix_entry"],
    habitat: "N",
    statement: [
      paragraph([
        ref("def_finite_ca"),
        " の有限舞台上の 2 値セルオートマトンと、その大域写像 ",
        math(String.raw`F:A^V\to A^V`),
        "（",
        ref("def_global_map"),
        "）を取る。",
        ref("def_deterministic_rule_zero_one_embedding"),
        " の ",
        math(String.raw`\kappa^f`),
        " から得る転送行列について、各 ",
        math(String.raw`x,y\in X=A^V`),
        " で",
      ]),
      displayMath(String.raw`T_{\kappa^f}(x,y)=\begin{cases}1,&y=F(x),\\0,&y\ne F(x)\end{cases}`),
      paragraph(["が成り立つ。従って全成分は ", math(String.raw`\{0,1\}\subset\mathbb N`), " に属し、各行には一がちょうど一つある。"]),
    ],
    proof: [
      paragraph([
        ref("def_probabilistic_global_transition_weight"),
        " と ",
        ref("def_deterministic_rule_zero_one_embedding"),
        " により、各セルの因子は ",
        math(String.raw`y(v)=f_v(x|_{N(v)})`),
        " のとき一、そうでなければ零である。有限積が一であることは全てのセルでこの等号が成り立つことと同値であり、",
        ref("def_global_map"),
        " により ",
        math(String.raw`y=F(x)`),
        " と同値である。一つでも等号が破れれば対応する因子が零なので有限積も零である。",
      ]),
    ],
  },
  {
    id: "finite_transfer_matrix_comparison_claim_deterministic_power",
    kind: "claim",
    title: { text: "零一重みの行列冪は反復遷移の指示値である" },
    labels: ["claim_deterministic_transfer_matrix_power_entry"],
    habitat: "N",
    statement: [
      paragraph([
        ref("claim_deterministic_transfer_matrix_entry"),
        " の入力に対し、全ての ",
        math(String.raw`n\in\mathbb N`),
        " と ",
        math(String.raw`x,y\in X`),
        " について",
      ]),
      displayMath(String.raw`T_{\kappa^f}^{\langle n\rangle}(x,y)=\begin{cases}1,&y=F^n(x),\\0,&y\ne F^n(x)\end{cases}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([math(String.raw`n`), " に関する帰納法を使う。零回は恒等写像の指示値である。帰納法の仮定のもとで、"]),
      displayMath(String.raw`T_{\kappa^f}^{\langle n+1\rangle}(x,y)
=\sum_{z\in X}T_{\kappa^f}^{\langle n\rangle}(x,z)T_{\kappa^f}(z,y)
\qquad(\because\ \blkref{def_rational_transfer_matrix_power_trace}).`),
      paragraph([
        ref("claim_deterministic_transfer_matrix_entry"),
        " と帰納法の仮定により、和の各項が一になりうるのは ",
        math(String.raw`z=F^n(x)`),
        " かつ ",
        math(String.raw`y=F(z)`),
        " の場合だけである。この ",
        math(String.raw`z`),
        " は一意なので、有限和は ",
        math(String.raw`y=F^{n+1}(x)`),
        " のとき一、そうでなければ零である（",
        ref("def_finite_self_map_iterate"),
        "）。",
      ]),
    ],
  },
  {
    id: "finite_transfer_matrix_comparison_theorem_trace_fixed_count",
    kind: "theorem",
    title: { text: "零一重みの転送行列の跡は反復不動点数に等しい" },
    labels: ["theorem_deterministic_transfer_trace_equals_fixed_point_count"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("claim_deterministic_transfer_matrix_power_entry"),
        " の入力と ",
        math(String.raw`n\in\mathbb N_{>0}`),
        " に対し、",
      ]),
      displayMath(String.raw`Z^{\mathrm{tr}}_{\kappa^f,n}=Z_n(F)\in\mathbb N`),
      paragraph([
        "が成り立つ。左辺は ",
        ref("def_rational_transfer_matrix_power_trace"),
        " の跡、右辺は ",
        ref("def_fixed_points_of_iterate"),
        " の反復不動点数である。従って ",
        math(String.raw`Z_n(F)>0`),
        " の場合に限り、",
        ref("def_binary_ca_logarithmic_free_count"),
        " の対数順序群値自由エントロピーは ",
        math(String.raw`\Phi_F(n)=\log_\Lambda(q_F(n))\in\Lambda`),
        " と書ける。零の場合には対数を定義しない。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
Z^{\mathrm{tr}}_{\kappa^f,n}
&=\sum_{x\in X}T_{\kappa^f}^{\langle n\rangle}(x,x)
  \qquad(\because\ \blkref{def_rational_transfer_matrix_power_trace})\\
&=\sum_{x\in X}\begin{cases}1,&x=F^n(x),\\0,&x\ne F^n(x)\end{cases}
  \qquad(\because\ \blkref{claim_deterministic_transfer_matrix_power_entry})\\
&=\left|\{x\in X:F^n(x)=x\}\right|
  \qquad(\because\ \text{有限集合の部分集合の指示値の有限和})\\
&=Z_n(F)
  \qquad(\because\ \blkref{def_fixed_points_of_iterate}).
\end{aligned}`),
      paragraph([
        "各項は零または一であり、全ての和は有限なので等式は自然数の中で閉じる。自由エントロピーへの接続では、正の自然数を分母一の正の有理数へ送る写像と対数順序群の対数だけを使う。規格化のための除算、実数体・複素数体、極限は使わない。",
      ]),
    ],
  },
]);
