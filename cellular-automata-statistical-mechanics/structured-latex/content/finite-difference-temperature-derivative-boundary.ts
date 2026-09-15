/**
 * 対数順序群値エントロピーの整数刻み一の差を実数へ評価し、
 * 同じ有限端点データだけでは連続補間の微分値が決まらない境界を分離する。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_difference_temperature_derivative_boundary_definition_real_evaluation",
    kind: "definition",
    title: { text: "対数順序群の実対数評価" },
    labels: ["def_prime_vector_real_logarithmic_evaluation"],
    habitat: "R",
    realEscape:
      "有限台整数素数ベクトルを有理係数へ埋め込み、各素数の実対数との有限和を取る箇所で実数体へ脱出する。",
    statement: [
      paragraph([
        ref("def_finite_support_rational_prime_vectors"), " の埋め込み ",
        math(String.raw`j_\Lambda:\Lambda\to\Lambda_{\mathbb Q}`), " と ",
        ref("def_rational_prime_vector_logarithmic_real_evaluation"), " を用いて、",
      ]),
      displayMath(String.raw`\rho_\Lambda:\Lambda\longrightarrow\mathbb R,\qquad
\rho_\Lambda(a):=\rho_{\log}(j_\Lambda(a))`),
      paragraph([
        "と定める。和は有限台上だけで取り、無限和、極限、完備化は使わない。実数脱出は整数係数の標準実数像と素数の実対数を選ぶ箇所に限る。",
      ]),
    ],
  },
  {
    id: "finite_difference_temperature_derivative_boundary_claim_positive_rational_evaluation",
    kind: "claim",
    title: { text: "正の有理数の対数順序群値の実評価" },
    labels: ["claim_prime_vector_real_evaluation_of_prime_logarithm"],
    habitat: "R",
    realEscape:
      "正の有理数の有限素因数分解を素数の実対数の有限和として評価するため実数体を使う。",
    statement: [
      paragraph(["全ての ", math(String.raw`q\in\mathbb Q_{>0}`), " について"]),
      displayMath(String.raw`\rho_\Lambda(\log_\Lambda q)
=\log_{\mathbb R}\!\left(\iota_{\mathbb Q,\mathbb R}(q)\right)`),
      paragraph(["が成り立つ。右辺の実対数は正の実数だけに適用する。"]),
    ],
    proof: [
      paragraph([
        "標準埋め込み ", math(String.raw`\iota_{\mathbb Q}:\mathbb Z\to\mathbb Q`),
        " は単射で零を零へ送るので、", ref("def_finite_support_rational_prime_vectors"), " により ",
        math(String.raw`\operatorname{supp}(j_\Lambda(\log_\Lambda q))=\operatorname{supp}(\log_\Lambda q)`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\rho_\Lambda(\log_\Lambda q)
&=\rho_{\log}(j_\Lambda(\log_\Lambda q))
  \quad(\because\ \blkref{def_prime_vector_real_logarithmic_evaluation})\\
&=\sum_{\ell\in\operatorname{supp}(j_\Lambda(\log_\Lambda q))}
  \iota_{\mathbb Q,\mathbb R}\!\left((j_\Lambda(\log_\Lambda q))(\ell)\right)
  \log_{\mathbb R}(\ell)
  \quad(\because\ \blkref{def_rational_prime_vector_logarithmic_real_evaluation})\\
&=\sum_{\ell\in\operatorname{supp}(\log_\Lambda q)}
  \iota_{\mathbb Q,\mathbb R}\!\left(\iota_{\mathbb Q}((\log_\Lambda q)(\ell))\right)
  \log_{\mathbb R}(\ell)
  \quad(\because\ \text{上の台の一致},\ \blkref{def_finite_support_rational_prime_vectors})\\
&=\sum_{\ell\in\operatorname{supp}(\log_\Lambda q)}
  \iota_{\mathbb Q,\mathbb R}\!\left(\iota_{\mathbb Q}(v_\ell(q))\right)
  \log_{\mathbb R}(\ell)
  \quad(\because\ \blkref{def_prime_logarithm})\\
&=\log_{\mathbb R}\!\left(\iota_{\mathbb Q,\mathbb R}(q)\right)
  \quad(\because\ \text{正の有理数の有限素因数分解と実対数の積の法則}).
\end{aligned}`),
    ],
  },
  {
    id: "finite_difference_temperature_derivative_boundary_definition_real_entropy_sample",
    kind: "definition",
    title: { text: "有限繊維状態数の実対数評価" },
    labels: ["def_binary_ca_real_fiber_entropy_sample"],
    habitat: "R",
    realEscape:
      "正の有限繊維状態数を有理数から実数へ送り、実対数を適用する箇所で実数体へ脱出する。",
    statement: [
      paragraph([
        ref("def_binary_ca_positive_fiber_levels"), " の ",
        math(String.raw`n\in\mathbb N_{>0}`), "、", math(String.raw`u\in D_{F,H,n}`), " に対し、",
      ]),
      displayMath(String.raw`\widehat S_{F,H}(n,u):=
\log_{\mathbb R}\!\left(
  \iota_{\mathbb Q,\mathbb R}\!\left(\frac{\Omega_{F,H}(n,u)}1\right)
\right)\in\mathbb R`),
      paragraph([
        "と定める。", ref("def_binary_ca_fiber_multiplicity"), " と正の定義域により実対数の入力は正である。状態数が零の入力には値を与えない。",
      ]),
    ],
  },
  {
    id: "finite_difference_temperature_derivative_boundary_claim_real_difference_comparison",
    kind: "claim",
    title: { text: "対数順序群値の隣接差の実評価は有限実数差に一致する" },
    labels: ["claim_binary_ca_unit_difference_real_evaluation"],
    habitat: "R",
    realEscape:
      "対数順序群値の隣接差を素数の実対数で評価し、有限繊維状態数の実対数差と比較するため実数体を使う。",
    statement: [
      paragraph([
        ref("def_binary_ca_unit_logarithmic_difference"), " の定義域である ",
        math(String.raw`n\in\mathbb N_{>0}`), "、",
        math(String.raw`u,u+1\in D_{F,H,n}`), " において",
      ]),
      displayMath(String.raw`\rho_\Lambda\!\left(\beta_{F,H}(n,u)\right)
=\widehat S_{F,H}(n,u+1)-\widehat S_{F,H}(n,u)`),
      paragraph(["が成り立つ。これは二つの有限状態数の比較であり、連続補間も微分も使わない。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\rho_\Lambda\!\left(\beta_{F,H}(n,u)\right)
&=\rho_\Lambda\!\left(\log_\Lambda\!\left(
  \frac{\Omega_{F,H}(n,u+1)}{\Omega_{F,H}(n,u)}
\right)\right)
  \quad(\because\ \blkref{claim_binary_ca_unit_difference_ratio})\\
&=\log_{\mathbb R}\!\left(
  \iota_{\mathbb Q,\mathbb R}\!\left(
    \frac{\Omega_{F,H}(n,u+1)}{\Omega_{F,H}(n,u)}
  \right)
\right)
  \quad(\because\ \blkref{claim_prime_vector_real_evaluation_of_prime_logarithm})\\
&=\log_{\mathbb R}\!\left(
  \iota_{\mathbb Q,\mathbb R}\!\left(\frac{\Omega_{F,H}(n,u+1)}1\right)
\right)
-\log_{\mathbb R}\!\left(
  \iota_{\mathbb Q,\mathbb R}\!\left(\frac{\Omega_{F,H}(n,u)}1\right)
\right)
  \quad(\because\ \text{実対数の商の法則})\\
&=\widehat S_{F,H}(n,u+1)-\widehat S_{F,H}(n,u)
  \quad(\because\ \blkref{def_binary_ca_real_fiber_entropy_sample}).
\end{aligned}`),
    ],
  },
  {
    id: "finite_difference_temperature_derivative_boundary_definition_interpolants",
    kind: "definition",
    title: { text: "隣接する二つの実エントロピー値を結ぶ微分可能補間" },
    labels: ["def_binary_ca_real_entropy_interpolants"],
    habitat: "R",
    realEscape:
      "整数値保存写像の隣接値を実数へ埋め込み、その二点を通る実数上の微分可能関数全体を取るため実数体を使う。",
    statement: [
      paragraph([
        ref("claim_binary_ca_unit_difference_real_evaluation"), " の入力を固定し、",
        math(String.raw`a:=\iota_{\mathbb Q,\mathbb R}(\iota_{\mathbb Q}(u))`), "、",
        math(String.raw`b:=\iota_{\mathbb Q,\mathbb R}(\iota_{\mathbb Q}(u+1))=a+1`), " と書く。集合",
      ]),
      displayMath(String.raw`\mathcal I_{F,H,n,u}:=\left\{
s:\mathbb R\to\mathbb R:\
s\text{ は微分可能},\
s(a)=\widehat S_{F,H}(n,u),\
s(b)=\widehat S_{F,H}(n,u+1)
\right\}`),
      paragraph([
        "を隣接二点の微分可能補間の集合と定める。微分可能性から連続性が従う。有限データが指定するのは二つの端点値だけであり、その間と外側の値は指定しない。",
      ]),
    ],
  },
  {
    id: "finite_difference_temperature_derivative_boundary_definition_derivative_temperature",
    kind: "definition",
    title: { text: "実補間から作る一点の微分逆温度" },
    labels: ["def_binary_ca_interpolated_derivative_temperature"],
    habitat: "R",
    realEscape:
      "実数上の補間関数、非零実数による差分商、および実数の位相での極限を用いて微分を定義するため実数体へ脱出する。",
    statement: [
      paragraph([
        ref("def_binary_ca_real_entropy_interpolants"), " の ", math(String.raw`s\in\mathcal I_{F,H,n,u}`), " に対し、",
      ]),
      displayMath(String.raw`\beta^{\mathrm{der}}_s(n,u):=
\lim_{\substack{h\to0\\h\ne0}}
\frac{s(a+h)-s(a)}h
=s'(a)\in\mathbb R`),
      paragraph([
        "と定める。極限は実数の通常の位相で取る。定義には有限端点値に加えて、実数上の定義域、補間関数の選択、零へ近づく全ての非零実数刻み、および極限の存在が必要である。",
      ]),
    ],
  },
  {
    id: "finite_difference_temperature_derivative_boundary_claim_two_interpolants",
    kind: "claim",
    title: { text: "同じ有限差分は一点の微分逆温度を決めない" },
    labels: ["claim_binary_ca_finite_difference_does_not_determine_derivative"],
    habitat: "R",
    realEscape:
      "同じ二つの有限端点値を通る二つの実多項式を構成し、実数差分商の極限を比較するため実数体を使う。",
    statement: [
      paragraph([
        ref("def_binary_ca_real_entropy_interpolants"), " の固定した入力に対し、",
        math(String.raw`d:=\widehat S_{F,H}(n,u+1)-\widehat S_{F,H}(n,u)`), " と置き、実多項式",
      ]),
      displayMath(String.raw`\begin{aligned}
L(t)&:=\widehat S_{F,H}(n,u)+(t-a)d,\\
Q(t)&:=L(t)+(t-a)(t-b)
\end{aligned}
\qquad(t\in\mathbb R)`),
      paragraph(["を定めると、", math(String.raw`L,Q\in\mathcal I_{F,H,n,u}`), " である一方、"]),
      displayMath(String.raw`\beta^{\mathrm{der}}_L(n,u)=d,\qquad
\beta^{\mathrm{der}}_Q(n,u)=d-1`),
      paragraph([
        "である。従って両補間は同じ有限実数差 ", math(String.raw`d=\rho_\Lambda(\beta_{F,H}(n,u))`),
        " を持つが、一点の微分逆温度は異なる。有限差分だけでは実数微分を決められない。",
      ]),
    ],
    proof: [
      paragraph([math(String.raw`b-a=1`), " を用いると、"]),
      displayMath(String.raw`\begin{aligned}
L(a)&=\widehat S_{F,H}(n,u)
  \quad(\because\ a-a=0),\\
L(b)&=\widehat S_{F,H}(n,u)+(b-a)d
  \quad(\because\ L\text{ の定義})\\
&=\widehat S_{F,H}(n,u)+d
  \quad(\because\ b-a=1)\\
&=\widehat S_{F,H}(n,u+1)
  \quad(\because\ d\text{ の定義}),\\
Q(a)&=L(a)
  \quad(\because\ a-a=0),\\
Q(b)&=L(b)
  \quad(\because\ b-b=0).
\end{aligned}`),
      paragraph([
        "従って二つの多項式は指定した端点値を持つ。実多項式は微分可能なので ",
        ref("def_binary_ca_real_entropy_interpolants"), " により ", math(String.raw`L,Q\in\mathcal I_{F,H,n,u}`), " である。次に ",
        math(String.raw`h\in\mathbb R\setminus\{0\}`), " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\frac{L(a+h)-L(a)}h
&=\frac{hd}{h}
  \quad(\because\ L\text{ の定義})\\
&=d
  \quad(\because\ h\ne0),\\
\frac{Q(a+h)-Q(a)}h
&=\frac{L(a+h)-L(a)+h(a+h-b)}h
  \quad(\because\ Q\text{ の定義})\\
&=d+(a-b)+h
  \quad(\because\ \text{上の }L\text{ の差分商と }h\ne0).
\end{aligned}`),
      paragraph([ref("def_binary_ca_interpolated_derivative_temperature"), " の実数極限を取ると"]),
      displayMath(String.raw`\begin{aligned}
\beta^{\mathrm{der}}_L(n,u)
&=d
  \quad(\because\ \text{定数関数の極限}),\\
\beta^{\mathrm{der}}_Q(n,u)
&=d+(a-b)
  \quad(\because\ \lim_{h\to0}h=0)\\
&=d-1
  \quad(\because\ b=a+1).
\end{aligned}`),
      paragraph([
        math(String.raw`1\ne0`), " なので二つの微分値は異なる。最後に ",
        ref("claim_binary_ca_unit_difference_real_evaluation"), " により有限実数差は ",
        math(String.raw`d=\rho_\Lambda(\beta_{F,H}(n,u))`), " である。",
      ]),
    ],
  },
]);
