/**
 * 有限有理確率分布の Shannon 型エントロピーを有限台有理素数ベクトルで構成し、
 * 実対数による評価と、任意の有限実数値分布を覆わない境界を分離する。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_rational_entropy_boundary_definition_distribution",
    kind: "definition",
    title: { text: "有限集合上の有理確率分布と正の台" },
    labels: ["def_finite_rational_probability_distribution_support"],
    habitat: "Q",
    statement: [
      paragraph([
        "空でない有限集合 ", math(String.raw`X`), " と写像 ",
        math(String.raw`p:X\to\mathbb Q`), " を取り、全ての ",
        math(String.raw`x\in X`), " について ", math(String.raw`0\le p(x)\le1`), " かつ",
      ]),
      displayMath(String.raw`\sum_{x\in X}p(x)=1`),
      paragraph([
        "を満たすとき ", math(String.raw`p`), " を有限有理確率分布と呼ぶ。正の台を",
      ]),
      displayMath(String.raw`X_p:=\{x\in X:p(x)>0\}`),
      paragraph([
        "と定める。", math(String.raw`X_p`), " は有限である。零重みは台から外すので、後続で零の対数を定義しない。",
      ]),
    ],
  },
  {
    id: "finite_rational_entropy_boundary_definition_prime_vector_entropy",
    kind: "definition",
    title: { text: "有限有理確率分布の有限台有理素数ベクトル値エントロピー" },
    labels: ["def_finite_rational_prime_vector_entropy"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_finite_rational_probability_distribution_support"), " の ", math(String.raw`p`), " と、",
        ref("def_positive_rational_prime_valuation"), " の素数指数 ", math(String.raw`v_\ell`), " に対し、",
        ref("def_finite_support_rational_prime_vectors"), " の元 ", math(String.raw`\mathcal H_{\mathbb Q}(p)`), " を素数ごとに",
      ]),
      displayMath(String.raw`\mathcal H_{\mathbb Q}(p)(\ell):=
-\sum_{x\in X_p}p(x)\,\iota_{\mathbb Q}\!\left(v_\ell(p(x))\right)
\qquad(\ell\in\mathcal P)`),
      paragraph([
        "で定める。", math(String.raw`\iota_{\mathbb Q}:\mathbb Z\to\mathbb Q`),
        " は標準単射である。各 ", math(String.raw`p(x)>0`), " は正の有理数なので素数指数が定義される。",
        math(String.raw`X_p`), " は有限で、各指数ベクトルの台も有限だから、右辺の台は有限個の有限集合の合併に含まれる。従って値は ",
        math(String.raw`\Lambda_{\mathbb Q}`), " に属する。有限和と有理数の積だけを使い、実数体、実対数、極限を使わない。",
      ]),
    ],
  },
  {
    id: "finite_rational_entropy_boundary_definition_logarithmic_real_evaluation",
    kind: "definition",
    title: { text: "有限台有理素数ベクトルの実対数評価" },
    labels: ["def_rational_prime_vector_logarithmic_real_evaluation"],
    habitat: "R",
    realEscape:
      "有限台有理素数ベクトルの各素数係数を実数へ送り、素数の実対数との有限和を取る箇所で実数体へ脱出する。",
    statement: [
      paragraph([
        ref("def_finite_support_rational_prime_vectors"), " の ", math(String.raw`a\in\Lambda_{\mathbb Q}`), " に対し、",
      ]),
      displayMath(String.raw`\rho_{\log}(a):=
\sum_{\ell\in\operatorname{supp}(a)}
\iota_{\mathbb Q,\mathbb R}(a(\ell))\log_{\mathbb R}(\ell)\in\mathbb R`),
      paragraph([
        "と定める。台が有限なので和は有限である。脱出は無限和や極限ではなく、標準単射 ",
        math(String.raw`\iota_{\mathbb Q,\mathbb R}:\mathbb Q\to\mathbb R`), " と実対数を選ぶ箇所で起こる。",
      ]),
    ],
  },
  {
    id: "finite_rational_entropy_boundary_claim_real_comparison",
    kind: "claim",
    title: { text: "有限有理エントロピーの実対数評価は Shannon の有限和に一致する" },
    labels: ["claim_finite_rational_entropy_real_comparison"],
    habitat: "R",
    realEscape:
      "有理確率重みと有限台有理素数ベクトルを実数へ送り、正の有理数の素因数分解を実対数の和として評価するため実数体を使う。",
    statement: [
      paragraph([
        ref("def_finite_rational_prime_vector_entropy"), " の全ての有限有理確率分布 ", math(String.raw`p`), " について",
      ]),
      displayMath(String.raw`\rho_{\log}\!\left(\mathcal H_{\mathbb Q}(p)\right)
=-\sum_{x\in X_p}\iota_{\mathbb Q,\mathbb R}(p(x))
\log_{\mathbb R}\!\left(\iota_{\mathbb Q,\mathbb R}(p(x))\right)`),
      paragraph(["が成り立つ。右辺でも零重みには実対数を適用しない。"]),
    ],
    proof: [
      paragraph([
        "各 ", math(String.raw`x\in X_p`), " について、正の有理数の素因数分解と実対数の積の法則から",
      ]),
      displayMath(String.raw`\log_{\mathbb R}\!\left(\iota_{\mathbb Q,\mathbb R}(p(x))\right)
=\sum_{\ell\in\operatorname{supp}(\log_\Lambda p(x))}
\iota_{\mathbb Q,\mathbb R}\!\left(\iota_{\mathbb Q}\!\left(v_\ell(p(x))\right)\right)\log_{\mathbb R}(\ell)
\quad(\because\ \blkref{def_positive_rational_prime_valuation}).`),
      paragraph(["有限な二重和の順序を交換すると、"]),
      displayMath(String.raw`\begin{aligned}
\rho_{\log}\!\left(\mathcal H_{\mathbb Q}(p)\right)
&=\sum_{\ell\in\operatorname{supp}(\mathcal H_{\mathbb Q}(p))}
\iota_{\mathbb Q,\mathbb R}\!\left(-\sum_{x\in X_p}p(x)\iota_{\mathbb Q}(v_\ell(p(x)))\right)
\log_{\mathbb R}(\ell)
\quad(\because\ \blkref{def_rational_prime_vector_logarithmic_real_evaluation},\ \blkref{def_finite_rational_prime_vector_entropy})\\
&=\sum_{\ell\in\bigcup_{x\in X_p}\operatorname{supp}(\log_\Lambda p(x))}
\iota_{\mathbb Q,\mathbb R}\!\left(-\sum_{x\in X_p}p(x)\iota_{\mathbb Q}(v_\ell(p(x)))\right)
\log_{\mathbb R}(\ell)
\quad(\because\ \operatorname{supp}(\mathcal H_{\mathbb Q}(p))\text{ の外で係数が零})\\
&=-\sum_{x\in X_p}\iota_{\mathbb Q,\mathbb R}(p(x))
\sum_{\ell\in\operatorname{supp}(\log_\Lambda p(x))}
\iota_{\mathbb Q,\mathbb R}\!\left(\iota_{\mathbb Q}(v_\ell(p(x)))\right)\log_{\mathbb R}(\ell)
\quad(\because\ \text{有限和の交換と実数の分配則})\\
&=-\sum_{x\in X_p}\iota_{\mathbb Q,\mathbb R}(p(x))
\log_{\mathbb R}\!\left(\iota_{\mathbb Q,\mathbb R}(p(x))\right)
\quad(\because\ \text{上の素因数分解の実対数評価}).
\end{aligned}`),
    ],
  },
  {
    id: "finite_rational_entropy_boundary_claim_irrational_distribution",
    kind: "claim",
    title: { text: "有限実数値確率分布は有限有理確率分布だけでは尽くせない" },
    labels: ["claim_finite_real_distribution_not_always_rational"],
    habitat: "R",
    realEscape:
      "二元集合上で無理数の実確率重みを許す有限分布を構成し、有理数から実数への標準単射の像と比較するため実数体を使う。",
    statement: [
      paragraph(["二元集合 ", math(String.raw`B=\{b_0,b_1\}`), " 上の実数値重みを"]),
      displayMath(String.raw`r(b_0):=\frac{\sqrt2}{2},\qquad
r(b_1):=1-\frac{\sqrt2}{2}`),
      paragraph([
        "と定めると、", math(String.raw`r(b_0),r(b_1)>0`), " かつ ", math(String.raw`r(b_0)+r(b_1)=1`),
        " であるが、", ref("def_finite_rational_probability_distribution_support"), " の有限有理確率分布 ", math(String.raw`p:B\to\mathbb Q`), " で ",
        math(String.raw`\iota_{\mathbb Q,\mathbb R}\circ p=r`), " を満たすものは存在しない。",
      ]),
    ],
    proof: [
      paragraph([math(String.raw`0<\sqrt2/2<1`), " なので二成分は正であり、和は定義から一である。もしその ", math(String.raw`p`), " が存在すれば、"]),
      displayMath(String.raw`\sqrt2=2\,\iota_{\mathbb Q,\mathbb R}(p(b_0))
\quad(\because\ \iota_{\mathbb Q,\mathbb R}(p(b_0))=r(b_0)=\sqrt2/2).`),
      paragraph([
        "右辺は有理数の標準像なので ", math(String.raw`\sqrt2`), " が有理数になるが、平方が二となる有理数は存在しない。矛盾である。従って可算側の構成は全ての有限実数値分布を覆わない。",
      ]),
    ],
  },
]);
