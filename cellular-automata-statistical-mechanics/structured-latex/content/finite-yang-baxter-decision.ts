/**
 * 有限集合上の二体写像に対する Yang--Baxter 条件を、有限写像の等号として定義し、
 * 連続スペクトルパラメータを導入する前に有限決定できる範囲を確定する。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_yang_baxter_decision_remark_conventions_and_sources",
    kind: "remark",
    title: { text: "二つの Yang–Baxter 規約と一次文献" },
    labels: ["remark_yang_baxter_conventions_and_sources"],
    habitat: "none",
    statement: [
      paragraph([
        "有限写像側の比較元には T. Gombor–B. Pozsgay, “Superintegrable cellular automata and dual unitary gates from Yang–Baxter maps,” SciPost Physics 12 (2022) 102 の式 (17) を用いる。",
        "同論文は隣接二体写像の braid 関係をスペクトルパラメータなしの Yang–Baxter 方程式として使う。",
        "複素数値族の比較先には A. P. Veselov, “Yang–Baxter maps and integrable dynamics,” Physics Letters A 314 (2003) 214–221 の式 (1), (3) を用いる。",
        "同論文は非隣接作用を含む Yang–Baxter 方程式と、その二パラメータ版を区別する。",
        "本節では両者を同一視せず、成分交換との合成を比較写像として明示する。",
      ]),
    ],
  },
  {
    id: "finite_yang_baxter_decision_definition_pair_map",
    kind: "definition",
    title: { text: "有限集合上の二体写像" },
    labels: ["def_finite_pair_map"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`X`), " を元数 ", math(String.raw`n:=|X|\in\mathbb N`),
        " の有限集合とする。写像 ", math(String.raw`R:X\times X\to X\times X`),
        " を有限二体写像と呼ぶ。有限二体写像全体は有限集合であり、その元数は",
      ]),
      displayMath(String.raw`\left|(X\times X)^{X\times X}\right|=(n^2)^{n^2}`),
      paragraph([
        "である。ここでは ", math(String.raw`X`), " に加法、積、位相、確率、外在的な解釈を仮定しない。",
      ]),
    ],
  },
  {
    id: "finite_yang_baxter_decision_definition_adjacent_lifts",
    kind: "definition",
    title: { text: "三体直積上の隣接持ち上げ" },
    labels: ["def_finite_pair_map_adjacent_lifts"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_finite_pair_map"), " の ", math(String.raw`R`), " に対し、写像 ",
        math(String.raw`R_{12},R_{23}:X^3\to X^3`), " を次で定める。",
      ]),
      displayMath(String.raw`\begin{aligned}
R(x,y)&=\bigl(R_1(x,y),R_2(x,y)\bigr),\\
R_{12}(x,y,z)&=\bigl(R_1(x,y),R_2(x,y),z\bigr),\\
R_{23}(x,y,z)&=\bigl(x,R_1(y,z),R_2(y,z)\bigr).
\end{aligned}`),
      paragraph([
        math(String.raw`R_1,R_2:X\times X\to X`),
        " はそれぞれ ", math(String.raw`R`), " の第一成分と第二成分である。直積と成分射影以外の演算は使わない。",
      ]),
    ],
  },
  {
    id: "finite_yang_baxter_decision_definition_condition",
    kind: "definition",
    title: { text: "有限 Yang–Baxter 条件" },
    labels: ["def_finite_yang_baxter_map"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_finite_pair_map_adjacent_lifts"), " の二体写像 ", math(String.raw`R`), " が",
      ]),
      displayMath(String.raw`R_{12}\circ R_{23}\circ R_{12}
=R_{23}\circ R_{12}\circ R_{23}:X^3\to X^3`),
      paragraph([
        "を満たすとき、", math(String.raw`R`), " を有限 Yang--Baxter 写像と呼ぶ。",
        "これは ", ref("remark_yang_baxter_conventions_and_sources"),
        " の有限写像側の braid 規約である。合成は右端の写像から適用する。",
        "この定義は一つの有限写像の等号であり、",
        "実数体、複素数体、行列、スペクトルパラメータを仮定しない。",
      ]),
    ],
  },
  {
    id: "finite_yang_baxter_decision_claim_decidable",
    kind: "claim",
    title: { text: "有限 Yang–Baxter 条件は三体入力の全走査で決定できる" },
    labels: ["claim_finite_yang_baxter_condition_decidable"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_finite_yang_baxter_map"), " の条件は、全ての ",
        math(String.raw`(x,y,z)\in X^3`), " について両辺の値を比較する有限手続きで決定できる。",
        "比較する入力はちょうど ", math(String.raw`|X^3|=n^3`), " 個である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`X`), " は有限集合なので ", math(String.raw`X^3`),
        " も有限集合であり、その元数は ", math(String.raw`n^3`), " である。各 ",
        math(String.raw`t\in X^3`), " について、有限表 ", math(String.raw`R`),
        " を三回引けば二つの合成写像の値をそれぞれ計算できる。",
      ]),
      paragraph(["全入力で値が等しいなら有限写像の外延性により"]),
      displayMath(String.raw`R_{12}\circ R_{23}\circ R_{12}
=R_{23}\circ R_{12}\circ R_{23}`),
      paragraph([
        "である。逆にこの写像等式が成り立つなら各入力で値が等しい。従って全 ",
        math(String.raw`n^3`), " 入力の比較と条件は同値であり、有限手続きで決定できる。",
      ]),
    ],
  },
  {
    id: "finite_yang_baxter_decision_claim_swap_example",
    kind: "claim",
    title: { text: "成分交換は有限 Yang–Baxter 写像である" },
    labels: ["claim_finite_swap_is_yang_baxter"],
    habitat: "finite",
    statement: [
      paragraph([
        "任意の有限集合 ", math(String.raw`X`), " について、",
        math(String.raw`S:X\times X\to X\times X`), " を ",
        math(String.raw`S(x,y):=(y,x)`), " と定めると、", math(String.raw`S`),
        " は有限 Yang--Baxter 写像である。",
      ]),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`(x,y,z)\in X^3`), " について"]),
      displayMath(String.raw`\begin{aligned}
(S_{12}\circ S_{23}\circ S_{12})(x,y,z)
&=(z,y,x),\\
(S_{23}\circ S_{12}\circ S_{23})(x,y,z)
&=(z,y,x).
\end{aligned}`),
      paragraph([
        "従って二つの写像は全入力で一致し、",
        ref("def_finite_yang_baxter_map"), " の条件を満たす。",
      ]),
    ],
  },
  {
    id: "finite_yang_baxter_decision_claim_two_element_counterexample",
    kind: "claim",
    title: { text: "二元集合上でも有限 Yang–Baxter 条件は自動ではない" },
    labels: ["claim_two_element_pair_map_not_always_yang_baxter"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`B:=\{0,1\}`), " とし、二体写像 ",
        math(String.raw`Q:B\times B\to B\times B`), " を",
      ]),
      displayMath(String.raw`Q(0,0)=Q(0,1)=Q(1,0)=(0,0),\qquad Q(1,1)=(0,1)`),
      paragraph([
        "と定める。このとき ", math(String.raw`Q`), " は有限 Yang--Baxter 写像ではない。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(Q_{12}\circ Q_{23}\circ Q_{12})(1,1,1)
&=(0,0,1),\\
(Q_{23}\circ Q_{12}\circ Q_{23})(1,1,1)
&=(0,0,0).
\end{aligned}`),
      paragraph([
        "一つの入力で値が異なるので、", ref("def_finite_yang_baxter_map"),
        " の有限写像等式は成り立たない。",
      ]),
    ],
  },
  {
    id: "finite_yang_baxter_decision_definition_complex_parameter_family",
    kind: "definition",
    title: { text: "複素スペクトルパラメータつき Yang–Baxter 族" },
    labels: ["def_complex_spectral_parameter_yang_baxter_family"],
    habitat: "C",
    realEscape:
      "有限二体写像と比較する連続側の対象を定義するため、複素数全体をパラメータ集合・係数体として用いる。位相、極限、微分、内積、完備性は仮定しない。",
    statement: [
      paragraph([
        math(String.raw`X`), " を有限集合とし、", math(String.raw`W_X:=\mathbb C^X`),
        " と置く。写像族",
      ]),
      displayMath(String.raw`\mathcal R:\mathbb C\times\mathbb C
\longrightarrow \operatorname{End}_{\mathbb C}(W_X\otimes W_X)`),
      paragraph([
        "が任意の ", math(String.raw`\lambda_1,\lambda_2,\lambda_3\in\mathbb C`), " について",
      ]),
      displayMath(String.raw`\mathcal R_{12}(\lambda_1,\lambda_2)
\mathcal R_{13}(\lambda_1,\lambda_3)
\mathcal R_{23}(\lambda_2,\lambda_3)
=
\mathcal R_{23}(\lambda_2,\lambda_3)
\mathcal R_{13}(\lambda_1,\lambda_3)
\mathcal R_{12}(\lambda_1,\lambda_2)`),
      paragraph([
        "を満たすとき、複素スペクトルパラメータつき Yang--Baxter 族と呼ぶ。",
        math(String.raw`\mathcal R_{ij}`),
        " は三重テンソル積の第 ", math(String.raw`i,j`),
        " 成分へ作用し、残りの成分には恒等写像として作用する。これは ",
        ref("remark_yang_baxter_conventions_and_sources"), " の Veselov の二パラメータ規約である。",
      ]),
    ],
  },
  {
    id: "finite_yang_baxter_decision_definition_finite_to_complex_comparison",
    kind: "definition",
    title: { text: "有限二体写像の複素線形化と成分交換" },
    labels: ["def_finite_pair_map_complex_linearization_comparison"],
    habitat: "C",
    realEscape:
      "有限写像を複素係数 Yang–Baxter 族と比較するため、有限集合を基底とする複素ベクトル空間と複素線形拡張を用いる。",
    statement: [
      paragraph([
        ref("def_finite_pair_map"), " の ", math(String.raw`U:X^2\to X^2`),
        " に対し、基底 ", math(String.raw`\{e_x:x\in X\}`), " を持つ ",
        math(String.raw`W_X:=\mathbb C^X`), " 上の複素線形写像 ",
        math(String.raw`\widehat U:W_X\otimes W_X\to W_X\otimes W_X`), " を",
      ]),
      displayMath(String.raw`\widehat U(e_x\otimes e_y):=e_{U_1(x,y)}\otimes e_{U_2(x,y)}`),
      paragraph([
        "で定める。さらに成分交換 ", math(String.raw`P(e_x\otimes e_y):=e_y\otimes e_x`),
        " を用いて ", math(String.raw`R_U:=P\circ\widehat U`), " と置く。",
        "有限写像 ", math(String.raw`U`), " は全ての基底元上の ", math(String.raw`\widehat U`),
        " の値から一意に復元できるので、複素線形化そのものでは有限表の情報を失わない。",
      ]),
    ],
  },
  {
    id: "finite_yang_baxter_decision_claim_constant_complex_family",
    kind: "claim",
    title: { text: "有限 braid 解は定数な複素パラメータ族を与える" },
    labels: ["claim_finite_braid_solution_gives_constant_complex_yang_baxter_family"],
    habitat: "C",
    realEscape:
      "有限 braid 解を複素スペクトルパラメータ族へ送る比較写像を述べるため、複素線形化と複素パラメータ集合を用いる。",
    statement: [
      paragraph([
        ref("def_finite_yang_baxter_map"), " を満たす有限二体写像 ", math(String.raw`U`),
        " に対し、", ref("def_finite_pair_map_complex_linearization_comparison"), " の ",
        math(String.raw`R_U`), " を用いて",
      ]),
      displayMath(String.raw`\mathcal R_U(\lambda,\mu):=R_U
\qquad(\lambda,\mu\in\mathbb C)`),
      paragraph([
        "と定めると、", math(String.raw`\mathcal R_U`), " は ",
        ref("def_complex_spectral_parameter_yang_baxter_family"), " を満たす。",
        "従って有限条件と連続パラメータ族は非対応なのではなく、有限解は定数族として複素側へ単射的に埋め込める。",
      ]),
    ],
    proof: [
      paragraph([
        "複素線形化は有限写像の合成と等号を保つ。成分交換を合成する標準変換 ",
        math(String.raw`R_U=P\circ\widehat U`), " の下で、隣接作用の braid 等式は非隣接作用を含む Yang--Baxter 等式と同値である。",
        "定数族ではパラメータに依存せず、後者の等式が任意の三パラメータで同じ等式になるため主張を得る。",
      ]),
    ],
  },
  {
    id: "finite_yang_baxter_decision_claim_spectral_dependence_not_determined",
    kind: "claim",
    title: { text: "一つの有限解はスペクトル依存性を決定しない" },
    labels: ["claim_single_finite_yang_baxter_map_does_not_determine_spectral_dependence"],
    habitat: "C",
    realEscape:
      "単一の有限写像が複素パラメータ依存性を決めないことを示すため、複素数上の二つの異なる写像族を比較する。",
    statement: [
      paragraph([
        "一元集合 ", math(String.raw`X:=\{\ast\}`), " 上の恒等二体写像を ",
        math(String.raw`U`), " とする。", math(String.raw`U`), " から得る複素線形写像を ",
        math(String.raw`R_U=\operatorname{id}_{\mathbb C}`), " と書く。このとき",
      ]),
      displayMath(String.raw`\mathcal R^{(0)}(\lambda,\mu):=R_U,
\qquad
\mathcal R^{(1)}(\lambda,\mu):=(1+\lambda)R_U`),
      paragraph([
        "はともに複素スペクトルパラメータつき Yang--Baxter 族であり、",
        "すなわち ", ref("def_complex_spectral_parameter_yang_baxter_family"), " を満たし、",
        math(String.raw`\mathcal R^{(0)}(0,0)=\mathcal R^{(1)}(0,0)=R_U`),
        " だが ", math(String.raw`\mathcal R^{(0)}(1,0)\ne\mathcal R^{(1)}(1,0)`), " である。",
        "従って一点での有限二体写像への比較は族全体を一意に復元せず、スペクトル依存性は有限写像に無い追加構造である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`W_X\otimes W_X\cong\mathbb C`),
        " なので各作用素は複素数倍である。Yang--Baxter 等式の両辺の係数はともに",
      ]),
      displayMath(String.raw`f(\lambda_1,\lambda_2)
f(\lambda_1,\lambda_3)
f(\lambda_2,\lambda_3)`),
      paragraph([
        "となり、複素数の乗法の可換性で一致する。", math(String.raw`f=1`), " と ",
        math(String.raw`f(\lambda,\mu)=1+\lambda`),
        " を代入すれば二つの族が条件を満たす。最後の一致と不一致は直接代入で得る。",
      ]),
    ],
  },
]);
