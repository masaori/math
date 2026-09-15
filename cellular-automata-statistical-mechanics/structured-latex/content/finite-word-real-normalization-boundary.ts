import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_word_real_normalization_definition_additive_realization",
    kind: "definition",
    title: { text: "対数順序群の加法的な実数実現" },
    labels: ["def_prime_vector_additive_real_realization"],
    habitat: "R",
    realEscape:
      "有限台整数ベクトルの値域を実数体へ送る比較写像を入力として指定する箇所で実数体へ脱出する。",
    statement: [
      paragraph([
        ref("claim_prime_vectors_abelian_group"),
        " の加法可換群に対し、写像 ",
        math(String.raw`\rho:\Lambda\to\mathbb R`),
        " が",
      ]),
      displayMath(String.raw`\rho(0_\Lambda)=0,\qquad
\rho(a+_\Lambda b)=\rho(a)+\rho(b)\quad(a,b\in\Lambda)`),
      paragraph([
        "を満たすとき、",
        math(String.raw`\rho`),
        " を加法的な実数実現と呼ぶ。ここで初めて値域として実数体を選ぶ。この定義は特定の ",
        math(String.raw`\rho`),
        " の存在・一意性・単射性・順序保存性を主張しない。",
      ]),
    ],
  },
  {
    id: "finite_word_real_normalization_claim_natural_multiple",
    kind: "claim",
    title: { text: "加法的実数実現は自然数倍を保つ" },
    labels: ["claim_prime_vector_additive_realization_natural_multiple"],
    habitat: "R",
    realEscape:
      "有限台整数ベクトルから実数体への加法的な比較写像の値を扱うため実数体へ脱出する。",
    statement: [
      paragraph([
        ref("def_prime_vector_additive_real_realization"),
        " の ",
        math(String.raw`\rho`),
        "、",
        math(String.raw`a\in\Lambda`),
        "、",
        math(String.raw`k\in\mathbb N`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`j:\mathbb N\to\mathbb Z`),
        "、自然数から実数への標準単射を ",
        math(String.raw`\iota_{\mathbb R}:\mathbb N\to\mathbb R`),
        " と書けば、",
      ]),
      displayMath(String.raw`\rho\!\left(j(k)\cdot_\Lambda a\right)
=\iota_{\mathbb R}(k)\,\rho(a).`),
    ],
    proof: [
      paragraph([math(String.raw`k`), " に関する帰納法で示す。零では"]),
      displayMath(String.raw`\begin{aligned}
\rho\!\left(j(0)\cdot_\Lambda a\right)
&=\rho(0_\Lambda)
  \quad(\because\ \blkref{def_prime_vector_additive_operations})\\
&=0
  \quad(\because\ \blkref{def_prime_vector_additive_real_realization})\\
&=\iota_{\mathbb R}(0)\,\rho(a)
  \quad(\because\ \mathbb R\text{ の零}).
\end{aligned}`),
      paragraph([
        math(String.raw`k`),
        " で主張が成り立つと仮定する。後者の自然数倍から一回の加法を分けると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\rho\!\left(j(k+1)\cdot_\Lambda a\right)
&=\rho\!\left((j(k)\cdot_\Lambda a)+_\Lambda a\right)
  \quad(\because\ \blkref{def_prime_vector_additive_operations})\\
&=\rho\!\left(j(k)\cdot_\Lambda a\right)+\rho(a)
  \quad(\because\ \blkref{def_prime_vector_additive_real_realization})\\
&=\iota_{\mathbb R}(k)\,\rho(a)+\rho(a)
  \quad(\because\ \text{帰納法の仮定})\\
&=\iota_{\mathbb R}(k+1)\,\rho(a)
  \quad(\because\ \mathbb R\text{ の分配律}).
\end{aligned}`),
      paragraph(["従って全ての自然数で主張が成り立つ。"]),
    ],
  },
  {
    id: "finite_word_real_normalization_definition_realized_density",
    kind: "definition",
    title: { text: "有限語個数の実数実現による規格化値" },
    labels: ["def_finite_word_realized_logarithmic_density"],
    habitat: "R",
    realEscape:
      "加法的実数実現の値を、正の語長を実数へ埋め込んだ非零値で除算する箇所で実数体を使う。",
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb N_{>0}`),
        " と、",
        ref("def_prime_vector_additive_real_realization"),
        " の ",
        math(String.raw`\rho`),
        " を取る。自然数の標準単射を ",
        math(String.raw`\iota_{\mathbb R}:\mathbb N\to\mathbb R`),
        " と書く。",
        ref("claim_finite_two_symbol_word_set_cardinality"),
        " により ",
        math(String.raw`|\mathcal W(n)|=2^n>0`),
        " なので、",
        ref("def_prime_logarithm"),
        " の入力に属する。そこで",
      ]),
      displayMath(String.raw`d_\rho(n):=
\frac{
  \rho\!\left(\log_\Lambda |\mathcal W(n)|\right)
}{
  \iota_{\mathbb R}(n)
}\in\mathbb R`),
      paragraph([
        "と定める。分母は ",
        math(String.raw`n>0`),
        " の実数像なので零ではなく、除算は定義される。状態数が零の対象や語長零にはこの定義を適用しない。",
      ]),
    ],
  },
  {
    id: "finite_word_real_normalization_claim_full_words_constant",
    kind: "claim",
    title: { text: "全二元語族の実数規格化値は有限段階ごとに一定である" },
    labels: ["claim_full_two_symbol_word_realized_density_constant"],
    habitat: "R",
    realEscape:
      "対数順序群の加法的実数実現と、正の語長の実数像による除算を使うため実数体へ脱出する。",
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb N_{>0}`),
        " と加法的な実数実現 ",
        math(String.raw`\rho:\Lambda\to\mathbb R`),
        " に対し、",
      ]),
      displayMath(String.raw`d_\rho(n)=\rho(\log_\Lambda 2).`),
    ],
    proof: [
      paragraph([
        ref("def_finite_word_realized_logarithmic_density"),
        " の左辺から計算する。自然数倍は ",
        math(String.raw`\Lambda`),
        " では反復加法、実数体では反復加法として取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
d_\rho(n)
&=
\frac{
  \rho\!\left(\log_\Lambda |\mathcal W(n)|\right)
}{
  \iota_{\mathbb R}(n)
}
  \quad(\because\ \blkref{def_finite_word_realized_logarithmic_density})\\
&=
\frac{
  \rho\!\left(\log_\Lambda(2^n)\right)
}{
  \iota_{\mathbb R}(n)
}
  \quad(\because\ \blkref{claim_finite_two_symbol_word_set_cardinality})\\
&=
\frac{
  \rho\!\left(j(n)\cdot_\Lambda\log_\Lambda 2\right)
}{
  \iota_{\mathbb R}(n)
}
  \quad(\because\ \blkref{claim_prime_logarithm_product}\text{ の }n\text{ 回適用})\\
&=
\frac{
  \iota_{\mathbb R}(n)\,\rho(\log_\Lambda 2)
}{
  \iota_{\mathbb R}(n)
}
  \quad(\because\ \blkref{claim_prime_vector_additive_realization_natural_multiple})\\
&=\rho(\log_\Lambda 2)
  \quad(\because\ n>0).
\end{aligned}`),
    ],
  },
  {
    id: "finite_word_real_normalization_remark_entropy_limit_separate",
    kind: "remark",
    title: { text: "実数規格化と位相的エントロピーの極限は別の段階である" },
    labels: ["remark_finite_word_real_normalization_before_entropy_limit"],
    habitat: "R",
    realEscape:
      "有限段階の比較値だけでも加法的実数実現と実数除算を使うため実数体へ脱出している。",
    statement: [
      paragraph([
        ref("claim_full_two_symbol_word_realized_density_constant"),
        " は、全二元語族では各有限段階の実数規格化値を極限なしに決める。一方、一般の語族の位相的エントロピーを述べるには、全ての正の語長にわたる語個数列、加法的実数実現の具体的な選択、実数列の収束概念、極限の存在を別に定義する必要がある。本節はその極限値の存在も、有限語個数表からの決定可能性も主張しない。",
      ]),
    ],
  },
  {
    id: "finite_word_real_normalization_definition_zero_realization",
    kind: "definition",
    title: { text: "対数順序群の零実数実現" },
    labels: ["def_prime_vector_zero_real_realization"],
    habitat: "R",
    realEscape:
      "有限台整数ベクトルを実数体の零へ送る比較写像の値域として実数体を選ぶ。",
    statement: [
      paragraph([
        ref("def_prime_vector_additive_real_realization"),
        " と同じ始域・終域を持つ写像を",
      ]),
      displayMath(String.raw`\rho_0:\Lambda\to\mathbb R,\qquad
\rho_0(a):=0\quad(a\in\Lambda)`),
      paragraph(["と定め、零実数実現と呼ぶ。"])],
  },
  {
    id: "finite_word_real_normalization_claim_zero_realization_additive",
    kind: "claim",
    title: { text: "零実数実現は加法的である" },
    labels: ["claim_prime_vector_zero_realization_additive"],
    habitat: "R",
    realEscape:
      "零実数実現の値を実数体の零と加法で比較するため実数体を使う。",
    statement: [
      paragraph([
        ref("def_prime_vector_zero_real_realization"),
        " の ",
        math(String.raw`\rho_0`),
        " は ",
        ref("def_prime_vector_additive_real_realization"),
        " の条件を満たす。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\rho_0(0_\Lambda)
=0
\quad(\because\ \blkref{def_prime_vector_zero_real_realization}).`),
      paragraph([math(String.raw`a,b\in\Lambda`), " に対し、"]),
      displayMath(String.raw`\begin{aligned}
\rho_0(a+_\Lambda b)
&=0
  \quad(\because\ \blkref{def_prime_vector_zero_real_realization})\\
&=0+0
  \quad(\because\ \mathbb R\text{ の零})\\
&=\rho_0(a)+\rho_0(b)
  \quad(\because\ \blkref{def_prime_vector_zero_real_realization}).
\end{aligned}`),
    ],
  },
  {
    id: "finite_word_real_normalization_claim_additivity_not_faithful",
    kind: "claim",
    title: { text: "加法性だけでは異なる有限個数を識別しない" },
    labels: ["claim_additive_realization_need_not_distinguish_counts"],
    habitat: "R",
    realEscape:
      "相異なる対数順序群元の像を実数体で比較するため実数体へ脱出する。",
    statement: [
      paragraph([
        ref("def_prime_vector_zero_real_realization"),
        " と ",
        ref("claim_prime_vector_zero_realization_additive"),
        " の ",
        math(String.raw`\rho_0`),
        " に対し、正の自然数から正の有理数への標準単射を ",
        math(String.raw`\iota_{\mathbb Q}:\mathbb N_{>0}\to\mathbb Q_{>0}`),
        " と書く。正の有限個数 ",
        math(String.raw`1,2\in\mathbb N_{>0}`),
        " の像は対数順序群では異なるが、その実数像は一致する。すなわち",
      ]),
      displayMath(String.raw`\log_\Lambda \iota_{\mathbb Q}(1)
\ne\log_\Lambda \iota_{\mathbb Q}(2),
\qquad
\rho_0\!\left(\log_\Lambda \iota_{\mathbb Q}(1)\right)
=\rho_0\!\left(\log_\Lambda \iota_{\mathbb Q}(2)\right)=0.`),
      paragraph([
        "従って、加法的な実数実現という条件だけでは、異なる有限語個数やその対数順序群値を実数側で識別できない。一般語族の実数規格化値を比較するには、比較写像を具体的に固定するか、識別に必要な追加条件を課す必要がある。",
      ]),
    ],
    proof: [
      paragraph([ref("claim_prime_logarithm_inverse"), " により"]),
      displayMath(String.raw`\begin{aligned}
R\!\left(\log_\Lambda \iota_{\mathbb Q}(1)\right)
&=\iota_{\mathbb Q}(1)
  \quad(\because\ \blkref{claim_prime_logarithm_inverse})\\
&\ne\iota_{\mathbb Q}(2)
  \quad(\because\ \iota_{\mathbb Q}\text{ の単射性と }1\ne2)\\
&=R\!\left(\log_\Lambda \iota_{\mathbb Q}(2)\right)
  \quad(\because\ \blkref{claim_prime_logarithm_inverse}).
\end{aligned}`),
      paragraph(["従って写像の等しい入力は等しい出力を持つことの対偶から"]),
      displayMath(String.raw`\log_\Lambda \iota_{\mathbb Q}(1)
\ne\log_\Lambda \iota_{\mathbb Q}(2).`),
      paragraph(["一方、"]),
      displayMath(String.raw`\begin{aligned}
\rho_0\!\left(\log_\Lambda \iota_{\mathbb Q}(1)\right)
&=0
  \quad(\because\ \blkref{def_prime_vector_zero_real_realization})\\
&=\rho_0\!\left(\log_\Lambda \iota_{\mathbb Q}(2)\right)
  \quad(\because\ \blkref{def_prime_vector_zero_real_realization}).
\end{aligned}`),
      paragraph(["これらを合わせて主張を得る。"]),
    ],
  },
]);
