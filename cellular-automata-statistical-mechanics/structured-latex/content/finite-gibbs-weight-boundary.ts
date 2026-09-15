/**
 * 有限舞台の有理遷移重みを実数へ送る比較写像と、有限実数値エネルギーから作る
 * Gibbs 遷移重みを分離し、零を含む有理遷移重みが後者では表せない有限反例を示す。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_gibbs_weight_boundary_definition_rational_real_comparison",
    kind: "definition",
    title: { text: "有理遷移重みの標準実数比較" },
    labels: ["def_rational_transition_real_comparison"],
    habitat: "R",
    realEscape:
      "有限配位間の有理遷移重みを、有理数から実数への標準単射で実数値へ送る箇所で実数体へ脱出する。",
    statement: [
      paragraph([
        ref("def_probabilistic_global_transition_weight"),
        " の有限配位集合 ",
        math(String.raw`X=A^V`),
        " と有理遷移重み ",
        math(String.raw`K_\kappa:X\times X\to\mathbb Q_{\mathrm{prob}}`),
        " を取る。有理数から実数への標準単射を ",
        math(String.raw`\iota_{\mathbb Q,\mathbb R}:\mathbb Q\to\mathbb R`),
        " と書く。実数比較重み ",
        math(String.raw`\widehat K_\kappa:X\times X\to\{r\in\mathbb R\mid 0\le r\le1\}`),
        " を",
      ]),
      displayMath(String.raw`\widehat K_\kappa(x,y):=\iota_{\mathbb Q,\mathbb R}\!\left(K_\kappa(x,y)\right)
\qquad(x,y\in X)`),
      paragraph([
        "で定める。これは値域だけを実数へ送る比較写像であり、指数関数と追加の実数値入力を導入しない。",
      ]),
    ],
  },
  {
    id: "finite_gibbs_weight_boundary_definition_row_partition_sum",
    kind: "definition",
    title: { text: "有限実数値エネルギーの行分配和" },
    labels: ["def_finite_real_row_partition_sum"],
    habitat: "R",
    realEscape:
      "有限配位対に実数値エネルギーを置き、実指数関数を各有限項へ適用する箇所で実数体へ脱出する。",
    statement: [
      paragraph([
        "有限配位集合 ",
        math(String.raw`X=A^V`),
        "、有限実数値エネルギー ",
        math(String.raw`E:X\times X\to\mathbb R`),
        "、正の実数値逆温度 ",
        math(String.raw`\beta\in\mathbb R_{>0}`),
        " を取る。各 ",
        math(String.raw`x\in X`),
        " の行分配和を",
      ]),
      displayMath(String.raw`Z_{\beta,E}(x):=\sum_{z\in X}\exp_{\mathbb R}\!\left(-\beta E(x,z)\right)
\in\mathbb R_{>0}`),
      paragraph([
        "で定める。集合 ",
        math(String.raw`X`),
        " は空でない有限集合であり、各実指数値は正なので、この有限和は正である。従って後続の除算の分母は零にならない。有限舞台であっても、実指数関数を使うこの定義は可算側では閉じない。",
      ]),
    ],
  },
  {
    id: "finite_gibbs_weight_boundary_definition_transition_weight",
    kind: "definition",
    title: { text: "有限 Gibbs 遷移重み" },
    labels: ["def_finite_gibbs_transition_weight"],
    habitat: "R",
    realEscape:
      "有限個の実指数値の和で規格化した実数値重みを定義するため、実数体の指数関数と除算を使う。",
    statement: [
      paragraph([
        ref("def_finite_real_row_partition_sum"),
        " の入力に対し、有限 Gibbs 遷移重み ",
        math(String.raw`G_{\beta,E}:X\times X\to\mathbb R`),
        " を",
      ]),
      displayMath(String.raw`G_{\beta,E}(x,y):=
\frac{
  \exp_{\mathbb R}\!\left(-\beta E(x,y)\right)
}{
  Z_{\beta,E}(x)
}
\qquad(x,y\in X)`),
      paragraph([
        "で定める。分母は正なので除算は定義される。この定義は無限舞台、極限、完備化を使わないが、値域と演算は実数体に属する。",
      ]),
    ],
  },
  {
    id: "finite_gibbs_weight_boundary_claim_strict_positivity",
    kind: "claim",
    title: { text: "有限 Gibbs 遷移重みは全て正である" },
    labels: ["claim_finite_gibbs_transition_weight_strictly_positive"],
    habitat: "R",
    realEscape:
      "実指数関数で作った有限 Gibbs 遷移重みの正値性を実数の順序で述べるため実数体を使う。",
    statement: [
      paragraph([
        ref("def_finite_gibbs_transition_weight"),
        " の全ての ",
        math(String.raw`x,y\in X`),
        " について",
      ]),
      displayMath(String.raw`G_{\beta,E}(x,y)>0`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\exp_{\mathbb R}\!\left(-\beta E(x,y)\right)
&>0
  \quad(\because\ \text{実指数関数の正値性})\\
Z_{\beta,E}(x)
&>0
  \quad(\because\ \blkref{def_finite_real_row_partition_sum})\\
G_{\beta,E}(x,y)
&>0
  \quad(\because\ \blkref{def_finite_gibbs_transition_weight}\text{ と正数同士の除算}).
\end{aligned}`),
    ],
  },
  {
    id: "finite_gibbs_weight_boundary_claim_row_normalization",
    kind: "claim",
    title: { text: "有限 Gibbs 遷移重みは各行で規格化される" },
    labels: ["claim_finite_gibbs_transition_weight_normalized"],
    habitat: "R",
    realEscape:
      "実指数関数で作った有限和と、その正の実数値による除算を使って規格化等式を述べるため実数体を使う。",
    statement: [
      paragraph([
        ref("def_finite_gibbs_transition_weight"),
        " の全ての ",
        math(String.raw`x\in X`),
        " について",
      ]),
      displayMath(String.raw`\sum_{y\in X}G_{\beta,E}(x,y)=1`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\sum_{y\in X}G_{\beta,E}(x,y)
&=
\sum_{y\in X}
\frac{
  \exp_{\mathbb R}\!\left(-\beta E(x,y)\right)
}{
  Z_{\beta,E}(x)
}
  \quad(\because\ \blkref{def_finite_gibbs_transition_weight})\\
&=
\frac{
  \sum_{y\in X}\exp_{\mathbb R}\!\left(-\beta E(x,y)\right)
}{
  Z_{\beta,E}(x)
}
  \quad(\because\ \text{有限和に対する実数の分配律})\\
&=
\frac{
  Z_{\beta,E}(x)
}{
  Z_{\beta,E}(x)
}
  \quad(\because\ \blkref{def_finite_real_row_partition_sum})\\
&=1
  \quad(\because\ Z_{\beta,E}(x)>0).
\end{aligned}`),
    ],
  },
  {
    id: "finite_gibbs_weight_boundary_definition_single_cell_identity",
    kind: "definition",
    title: { text: "一セル恒等規則の零一遷移重み" },
    labels: ["def_single_cell_identity_rational_transition_weight"],
    habitat: "Q",
    statement: [
      paragraph([
        "一セル舞台 ",
        math(String.raw`V=\{v\}`),
        "、自己近傍 ",
        math(String.raw`N(v)=\{v\}`),
        "、二元状態集合 ",
        math(String.raw`A=\{0,1\}`),
        " を取る。局所規則を ",
        math(String.raw`f_v(z):=z(v)`),
        " とし、",
        ref("def_deterministic_rule_zero_one_embedding"),
        " で得る有理重みの規則族を ",
        math(String.raw`\kappa^{\mathrm{id}}`),
        " と書く。二つの配位を ",
        math(String.raw`x_0(v):=0`),
        "、",
        math(String.raw`x_1(v):=1`),
        " と定める。",
      ]),
      displayMath(String.raw`X=A^V=\{x_0,x_1\},\qquad
K_{\kappa^{\mathrm{id}}}(x_a,x_b):=
\begin{cases}
  1,&a=b,\\
  0,&a\ne b
\end{cases}
\quad(a,b\in A).`),
      paragraph([
        ref("claim_deterministic_transfer_matrix_entry"),
        " により、この表は一セル恒等規則の大域遷移重みである。全ての値は ",
        math(String.raw`\mathbb Q_{\mathrm{prob}}`),
        " に属する。",
      ]),
    ],
  },
  {
    id: "finite_gibbs_weight_boundary_claim_zero_weight_counterexample",
    kind: "claim",
    title: { text: "零を含む有限有理遷移重みは有限 Gibbs 重みとは限らない" },
    labels: ["claim_rational_transition_weight_not_always_finite_gibbs"],
    habitat: "mixed",
    realEscape:
      "有理零一遷移重みの標準実数像を、実指数関数で作った有限 Gibbs 遷移重みと比較する箇所で実数体へ脱出する。",
    statement: [
      paragraph([
        ref("def_single_cell_identity_rational_transition_weight"),
        " の ",
        math(String.raw`K_{\kappa^{\mathrm{id}}}`),
        " に対し、任意の有限実数値エネルギー ",
        math(String.raw`E:X\times X\to\mathbb R`),
        " と任意の ",
        math(String.raw`\beta\in\mathbb R_{>0}`),
        " について",
      ]),
      displayMath(String.raw`\widehat K_{\kappa^{\mathrm{id}}}(x_0,x_1)
=0
\ne
G_{\beta,E}(x_0,x_1).`),
      paragraph([
        "従って、有限舞台上の有理遷移重みを標準単射で実数へ送っても、それが有限実数値エネルギーと正の実数値逆温度から作る有限 Gibbs 遷移重みになるとは限らない。非対応は極限ではなく、二配位だけの有限段階ですでに生じる。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\widehat K_{\kappa^{\mathrm{id}}}(x_0,x_1)
&=\iota_{\mathbb Q,\mathbb R}\!\left(K_{\kappa^{\mathrm{id}}}(x_0,x_1)\right)
  \quad(\because\ \blkref{def_rational_transition_real_comparison})\\
&=\iota_{\mathbb Q,\mathbb R}(0)
  \quad(\because\ \blkref{def_single_cell_identity_rational_transition_weight})\\
&=0
  \quad(\because\ \iota_{\mathbb Q,\mathbb R}\text{ は零を保つ})\\
&\ne G_{\beta,E}(x_0,x_1)
  \quad(\because\ \blkref{claim_finite_gibbs_transition_weight_strictly_positive}).
\end{aligned}`),
    ],
  },
]);
