import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "cyclic_stage_logarithmic_density_definition_domain",
    kind: "definition",
    title: { text: "有限巡回段階の対数順序群値を舞台サイズで割れる定義域" },
    labels: ["def_cyclic_stage_logarithmic_density_domain"],
    verification: ["sagemath/check/cyclic-stage-logarithmic-density"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_cyclic_stage_logarithmic_count_sequence"),
        " の入力 ",
        math(String.raw`r\in\mathbb N`),
        "、",
        math(String.raw`g:A^{D_r}\to A`),
        "、",
        math(String.raw`n\in\mathbb N_{>0}`),
        " に対し、舞台サイズによる群内除算が存在する段階だけを",
      ]),
      displayMath(String.raw`\mathsf{DensityDom}_{r,g,n}:=
\left\{L\in\mathsf{StagePos}_{r,g,n}:\
\exists!\,d\in\Lambda,\ \iota(L)\cdot_\Lambda d=\mathbf\Phi_{r,g,n}(L)\right\}`),
      paragraph([
        "と定める。ここで ",
        math(String.raw`\iota:\mathbb N\to\mathbb Z`),
        " は自然数を同じ非負整数へ送る写像であり、整数倍は ",
        ref("def_prime_vector_additive_operations"),
        " による。",
        ref("claim_prime_vector_integer_division"),
        " により、この定義域への所属は ",
        math(String.raw`\mathbf\Phi_{r,g,n}(L)`),
        " の全ての非零素数係数が ",
        math(String.raw`\iota(L)`),
        " で割れることと同値である。所属しない段階へ商の既定値を置かない。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_logarithmic_density_definition_shift_family",
    kind: "definition",
    title: { text: "有限巡回舞台の一方向シフト規則族" },
    labels: ["def_cyclic_stage_shift_rule_family"],
    verification: ["sagemath/check/cyclic-stage-logarithmic-density"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_integer_offset_interval"),
        " の ",
        math(String.raw`D_1=\{-1,0,1\}`),
        " と二元状態集合 ",
        math(String.raw`A`),
        " に対し、有限真理値表を",
      ]),
      displayMath(String.raw`g_{\mathrm{sh}}:A^{D_1}\longrightarrow A,\qquad
g_{\mathrm{sh}}(y):=y(1)`),
      paragraph([
        "と定める。各 ",
        math(String.raw`L\in\mathbb N_{>0}`),
        " では ",
        ref("def_cyclic_stage_global_map_family"),
        " により有限自己写像 ",
        math(String.raw`F_{L,1,g_{\mathrm{sh}}}:A^{C_L}\to A^{C_L}`),
        " が定まり、",
      ]),
      displayMath(String.raw`\bigl(F_{L,1,g_{\mathrm{sh}}}x\bigr)(v)
=x\bigl(\pi_L(v+1)\bigr)\qquad(v\in C_L)`),
      paragraph([
        "である。これは有限巡回舞台ごとの有限真理値表と有限写像だけからなる可算な族である。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_logarithmic_density_claim_shift_obstruction",
    kind: "claim",
    title: { text: "シフト規則族の自由エントロピーは舞台サイズで常には割れない" },
    labels: ["claim_cyclic_stage_shift_logarithmic_density_obstruction"],
    verification: ["sagemath/check/cyclic-stage-logarithmic-density"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_cyclic_stage_shift_rule_family"),
        " の一回反復について、任意の ",
        math(String.raw`L\in\mathbb N_{>0}`),
        " で",
      ]),
      displayMath(String.raw`\mathbf Z_{1,g_{\mathrm{sh}},1}(L)=2,\qquad
\mathbf\Phi_{1,g_{\mathrm{sh}},1}(L)=\log_\Lambda(2/1).`),
      paragraph([
        "従って ",
        math(String.raw`L\ge2`),
        " なら ",
        math(String.raw`L\notin\mathsf{DensityDom}_{1,g_{\mathrm{sh}},1}`),
        " である。各有限段階の正の状態数と対数順序群値は定義できても、セル数による規格化が対数順序群内に存在するとは限らない。実対数または実数除算へ移れば商を作れるという事実は、この群内除算を定義しない。",
      ]),
    ],
    proof: [
      paragraph([
        "配位 ",
        math(String.raw`x\in A^{C_L}`),
        " が ",
        math(String.raw`F_{L,1,g_{\mathrm{sh}}}`),
        " の不動点なら、任意の ",
        math(String.raw`v\in C_L`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
x(v)
&=\bigl(F_{L,1,g_{\mathrm{sh}}}x\bigr)(v)
  \quad(\because\ x\text{ は不動点})\\
&=x\bigl(\pi_L(v+1)\bigr)
  \quad(\because\ \blkref{def_cyclic_stage_shift_rule_family}).
\end{aligned}`),
      paragraph([
        ref("claim_cyclic_stage_is_finite_cyclic_group"),
        " により ",
        math(String.raw`\pi_L(1)`),
        " は ",
        math(String.raw`C_L`),
        " を生成するので、この等式を有限回反復すると ",
        math(String.raw`x(v)=x(0_L)`),
        " となる。逆に定値配位は定義式から不動点である。二元状態集合の各元に一つずつ定値配位があるから、不動点はちょうど二つである。従って",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathbf Z_{1,g_{\mathrm{sh}},1}(L)
&=2
  \quad(\because\ \text{上の不動点の全数分類})\\
\mathbf\Phi_{1,g_{\mathrm{sh}},1}(L)
&=\log_\Lambda(2/1)
  \quad(\because\ \blkref{def_cyclic_stage_logarithmic_count_sequence}).
\end{aligned}`),
      paragraph([
        ref("def_positive_rational_prime_valuation"),
        " と ",
        ref("def_prime_logarithm"),
        " により ",
        math(String.raw`\bigl(\log_\Lambda(2/1)\bigr)(2)=1`),
        " である。",
        math(String.raw`L\ge2`),
        " なら整数 ",
        math(String.raw`\iota(L)`),
        " は整数 ",
        math(String.raw`1`),
        " を割らない。従って ",
        ref("claim_prime_vector_integer_division"),
        " により ",
        math(String.raw`\iota(L)\cdot_\Lambda d=\log_\Lambda(2/1)`),
        " を満たす ",
        math(String.raw`d\in\Lambda`),
        " は存在しない。",
        ref("def_cyclic_stage_logarithmic_density_domain"),
        " により主張を得る。",
      ]),
    ],
  },
  {
    id: "rational_prime_vectors_definition_finite_support",
    kind: "definition",
    title: { text: "素数上の有限台有理ベクトルと対数順序群の埋め込み" },
    labels: ["def_finite_support_rational_prime_vectors"],
    verification: ["sagemath/check/rationalized-shift-logarithmic-density"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_prime_integer_vectors"),
        " の素数集合 ",
        math(String.raw`\mathcal P`),
        " に対し、",
      ]),
      displayMath(String.raw`\Lambda_{\mathbb Q}:=
\left\{a:\mathcal P\to\mathbb Q:\operatorname{supp}(a)
\text{ は有限}\right\}`),
      paragraph([
        "と定める。ここで ",
        math(String.raw`\operatorname{supp}(a):=\{p\in\mathcal P:a(p)\ne0\}`),
        " である。有限個の素数と有理係数の表で表せるので、",
        math(String.raw`\Lambda_{\mathbb Q}`),
        " は高々可算である。埋め込みと正の整数による除算を各 ",
        math(String.raw`p\in\mathcal P`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
j_{\Lambda}(a)(p)&:=\iota_{\mathbb Q}(a(p))
  \quad(a\in\Lambda),\\
\left(\frac{b}{L}\right)(p)&:=
  \frac{b(p)}{\iota_{\mathbb Q}(\iota(L))}
  \quad(b\in\Lambda_{\mathbb Q},\ L\in\mathbb N_{>0})
\end{aligned}`),
      paragraph([
        "と定める。",
        math(String.raw`\iota_{\mathbb Q}:\mathbb Z\to\mathbb Q`),
        " は整数の標準埋め込み、",
        math(String.raw`\iota:\mathbb N\to\mathbb Z`),
        " は自然数の標準埋め込みである。第二式の分母は正なので零ではない。どちらの結果の台も元の有限台に含まれる。従って演算は ",
        math(String.raw`\Lambda_{\mathbb Q}`),
        " の中で定義される。実数体、実対数、無限和、完備化は使わない。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_logarithmic_density_definition_rationalized_shift_sequence",
    kind: "definition",
    title: { text: "一方向シフト規則族の有理係数正規化列" },
    labels: ["def_shift_rationalized_logarithmic_density_sequence"],
    verification: ["sagemath/check/rationalized-shift-logarithmic-density"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_cyclic_stage_shift_rule_family"),
        " と ",
        ref("def_finite_support_rational_prime_vectors"),
        " に対し、全ての ",
        math(String.raw`L\in\mathbb N_{>0}`),
        " で",
      ]),
      displayMath(String.raw`\mathbf D_{\mathrm{sh}}(L):=
\frac{j_{\Lambda}\!\left(\mathbf\Phi_{1,g_{\mathrm{sh}},1}(L)\right)}{L}
\in\Lambda_{\mathbb Q}`),
      paragraph([
        "と定める。",
        ref("claim_cyclic_stage_shift_logarithmic_density_obstruction"),
        " により分子は全ての正の舞台サイズで定義される。除算は ",
        math(String.raw`\Lambda`),
        " の群内除算ではなく、",
        math(String.raw`\Lambda_{\mathbb Q}`),
        " の有理係数を非零有理数 ",
        math(String.raw`\iota_{\mathbb Q}(\iota(L))`),
        " で割る演算である。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_logarithmic_density_claim_rationalized_shift_not_eventually_constant",
    kind: "claim",
    title: { text: "有理係数へ拡張したシフト正規化列も完全安定化しない" },
    labels: ["claim_shift_rationalized_logarithmic_density_not_eventually_constant"],
    verification: ["sagemath/check/rationalized-shift-logarithmic-density"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_shift_rationalized_logarithmic_density_sequence"),
        " の列について、",
      ]),
      displayMath(String.raw`\neg\exists L_0\in\mathbb N_{>0},\ \exists d\in\Lambda_{\mathbb Q},\
\forall L\in\mathbb N_{>0},\ L\ge L_0\Longrightarrow\mathbf D_{\mathrm{sh}}(L)=d.`),
      paragraph([
        "従って、有理係数への拡張は各有限段階の規格化を定義可能にするが、有限段階列の等号による最終的な完全安定化を与えない。位相、距離、完備化、実数値の収束は定義していないので、それらについては主張しない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`L_0\in\mathbb N_{>0}`),
        " を任意に取る。",
        ref("claim_cyclic_stage_shift_logarithmic_density_obstruction"),
        " と ",
        ref("def_finite_support_rational_prime_vectors"),
        "、",
        ref("def_prime_logarithm"),
        "、",
        ref("def_positive_rational_prime_valuation"),
        " より、素数 ",
        math(String.raw`2\in\mathcal P`),
        " での係数は",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathbf D_{\mathrm{sh}}(L_0)(2)
&=\frac{1}{\iota_{\mathbb Q}(\iota(L_0))}
  \quad(\because\ \blkref{claim_cyclic_stage_shift_logarithmic_density_obstruction},\
  \ \blkref{def_shift_rationalized_logarithmic_density_sequence},\
  \ \blkref{def_prime_logarithm},\ \blkref{def_positive_rational_prime_valuation}),\\
\mathbf D_{\mathrm{sh}}(2L_0)(2)
&=\frac{1}{\iota_{\mathbb Q}(\iota(2L_0))}
  \quad(\because\ \blkref{claim_cyclic_stage_shift_logarithmic_density_obstruction},\
  \ \blkref{def_shift_rationalized_logarithmic_density_sequence},\
  \ \blkref{def_prime_logarithm},\ \blkref{def_positive_rational_prime_valuation}).
\end{aligned}`),
      paragraph([
        "この二係数が等しいと仮定し、正の有理数 ",
        math(String.raw`\iota_{\mathbb Q}(\iota(2L_0))`),
        " を両辺へ掛けると",
      ]),
      displayMath(String.raw`2=1\quad(\because\ \mathbb Q\text{ の体演算と }L_0>0)`),
      paragraph([
        "となり矛盾する。従って ",
        math(String.raw`\mathbf D_{\mathrm{sh}}(L_0)\ne\mathbf D_{\mathrm{sh}}(2L_0)`),
        " である。しかも ",
        math(String.raw`2L_0\ge L_0`),
        " なので、どの開始段階以後も列は一定にならない。",
      ]),
    ],
  },
  {
    id: "positive_rational_convergence_definition_epsilon",
    kind: "definition",
    title: { text: "正有理数の許容誤差による有理数列の収束" },
    labels: ["def_positive_rational_epsilon_convergence"],
    verification: ["sagemath/check/rational-reciprocal-convergence"],
    habitat: "countable",
    statement: [
      paragraph([
        math(String.raw`u:\mathbb N_{>0}\to\mathbb Q`),
        " と ",
        math(String.raw`q\in\mathbb Q`),
        " に対し、",
      ]),
      displayMath(String.raw`u\xrightarrow{\mathbb Q}q
\quad:\Longleftrightarrow\quad
\forall\varepsilon\in\mathbb Q_{>0},\ \exists L_0\in\mathbb N_{>0},\
\forall L\in\mathbb N_{>0},\ L\ge L_0\Longrightarrow
\lvert u(L)-q\rvert_{\mathbb Q}<\varepsilon`),
      paragraph([
        "と定める。ここで ",
        math(String.raw`\lvert a\rvert_{\mathbb Q}:=\max_{\mathbb Q}\{a,-a\}`),
        " は有理数の全順序と加法逆元で定める絶対値である。量化する許容誤差も列の値も有理数に属し、",
        "実数体への埋め込み、位相空間、完備化は定義に使わない。この定義は与えた有理数列が指定した有理数へ収束するかだけを述べ、全ての有理数列が有理数内に極限を持つとは主張しない。",
      ]),
    ],
  },
  {
    id: "positive_rational_convergence_claim_positive_integer_reciprocal_sequence",
    kind: "claim",
    title: { text: "正整数の逆数列は有理数内で零へ収束する" },
    labels: ["claim_positive_integer_reciprocal_converges_rationally"],
    verification: ["sagemath/check/rational-reciprocal-convergence"],
    habitat: "countable",
    statement: [
      paragraph([
        math(String.raw`L\in\mathbb N_{>0}`),
        " に対して ",
        math(String.raw`u_{\mathrm{rec}}(L):=1/\iota_{\mathbb Q}(\iota(L))\in\mathbb Q_{>0}`),
        " と定めると、",
      ]),
      displayMath(String.raw`u_{\mathrm{rec}}\xrightarrow{\mathbb Q}0.`),
    ],
    proof: [
      paragraph([
        math(String.raw`\varepsilon\in\mathbb Q_{>0}`),
        " を任意に取る。正の有理数の分数表示により、ある ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`\varepsilon=\iota_{\mathbb Q}(\iota(a))/\iota_{\mathbb Q}(\iota(b))`),
        " と書ける。",
        math(String.raw`L_0:=b+1\in\mathbb N_{>0}`),
        " と置く。",
      ]),
      paragraph([
        math(String.raw`L\in\mathbb N_{>0}`),
        " が ",
        math(String.raw`L\ge L_0`),
        " を満たすとする。正整数の標準埋め込みを式では省略すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\lvert u_{\mathrm{rec}}(L)-0\rvert_{\mathbb Q}
&=\frac{1}{L}
  \quad(\because\ L>0\text{ なので }1/L>0)\\
&\le\frac{1}{b+1}
  \quad(\because\ b+1=L_0\le L\text{ と正有理数の逆数の順序反転})\\
&<\frac{1}{b}
  \quad(\because\ 0<b<b+1\text{ と正有理数の逆数の順序反転})\\
&\le\frac{a}{b}
  \quad(\because\ 1\le a\text{ かつ }b>0)\\
&=\varepsilon
  \quad(\because\ a,b\text{ の選び方}).
\end{aligned}`),
      paragraph([
        math(String.raw`\varepsilon`),
        " は任意だったので、",
        ref("def_positive_rational_epsilon_convergence"),
        " により主張を得る。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_logarithmic_density_claim_rationalized_shift_rational_convergence",
    kind: "claim",
    title: { text: "シフト正規化列の素数二係数は有理数内で零へ収束する" },
    labels: ["claim_shift_rationalized_logarithmic_density_converges_rationally"],
    verification: ["sagemath/check/rational-reciprocal-convergence"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_shift_rationalized_logarithmic_density_sequence"),
        " の正の段階 ",
        math(String.raw`L\in\mathbb N_{>0}`),
        " と素数 ",
        math(String.raw`2\in\mathcal P`),
        " における係数を ",
        math(String.raw`q_{\mathrm{sh}}(L):=\mathbf D_{\mathrm{sh}}(L)(2)\in\mathbb Q`),
        " と置くと、",
      ]),
      displayMath(String.raw`q_{\mathrm{sh}}\xrightarrow{\mathbb Q}0.`),
      paragraph([
        "従って、",
        ref("claim_shift_rationalized_logarithmic_density_not_eventually_constant"),
        " の完全安定化の否定は、有理数内の収束の否定を意味しない。ここで得たのは一つの素数係数の収束であり、有限台有理ベクトル列全体の収束、全配位空間、無限段階の極限、実数値の極限量については主張しない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_cyclic_stage_shift_logarithmic_density_obstruction"),
        "、",
        ref("def_shift_rationalized_logarithmic_density_sequence"),
        "、",
        ref("def_finite_support_rational_prime_vectors"),
        " により、任意の ",
        math(String.raw`L\in\mathbb N_{>0}`),
        " で",
      ]),
      displayMath(String.raw`q_{\mathrm{sh}}(L)
=\frac{1}{\iota_{\mathbb Q}(\iota(L))}
\quad(\because\ \blkref{claim_cyclic_stage_shift_logarithmic_density_obstruction},\
\ \blkref{def_shift_rationalized_logarithmic_density_sequence},\
\ \blkref{def_finite_support_rational_prime_vectors}).`),
      paragraph([
        ref("claim_positive_integer_reciprocal_converges_rationally"),
        " と ",
        ref("def_positive_rational_epsilon_convergence"),
        " により主張を得る。",
      ]),
    ],
  },
]);
