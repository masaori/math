import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_fourier_duality_heading",
    kind: "heading",
    level: 1,
    title: { text: "有限 Fourier 双対と主・双対セル対応" },
    labels: [],
  },
  {
    id: "finite_fourier_definition_f2_linear_character_space",
    kind: "definition",
    title: { text: "有限第一ホモロジー群の F_2 値文字空間" },
    labels: ["def_f2_linear_character_space"],
    habitat: "F2",
    verification: ["sagemath/check/f2-linear-character-space"],
    statement: [
      paragraph([
        ref("def_first_homology_group_over_f2"),
        " の有限 ",
        math(String.raw`\mathbb F_2`),
        " ベクトル空間を ",
        math(String.raw`H:=H_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)`),
        " と書く。有限集合 ",
        math(String.raw`H`),
        " から ",
        math(String.raw`\mathbb F_2`),
        " への写像全体を ",
        math(String.raw`\mathbb F_2^H`),
        " と書く。有限第一ホモロジー群の ",
        math(String.raw`\mathbb F_2`),
        " 値文字空間を",
      ]),
      displayMath(String.raw`\begin{aligned}
H^\vee
&:=
\operatorname{Hom}_{\mathbb F_2}(H,\mathbb F_2)\\
&:=
\left\{
  \varphi\in\mathbb F_2^H
  \ \middle|\
  \begin{array}{l}
    \varphi(ah+bk)=a\varphi(h)+b\varphi(k)\\
    \text{for all }a,b\in\mathbb F_2\text{ and }h,k\in H
  \end{array}
\right\}
\end{aligned}`),
      paragraph([
        "で定める。各 ",
        math(String.raw`\varphi\in H^\vee`),
        " は始域を ",
        math(String.raw`H`),
        "、終域を ",
        math(String.raw`\mathbb F_2`),
        " とする線形写像であり、写像空間 ",
        math(String.raw`\mathbb F_2^H`),
        " の成分ごとの加法とスカラー倍を受け継ぐ。したがって ",
        math(String.raw`H^\vee`),
        " は有限な ",
        math(String.raw`\mathbb F_2`),
        " ベクトル空間である。この段階では ",
        math(String.raw`\mathbb F_2`),
        " 値文字を整数値の符号文字と同一視しない。全ての対象は有限集合または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_fourier_definition_integer_sign_character_realization",
    kind: "definition",
    title: { text: "F_2 値文字の整数符号実現" },
    labels: ["def_integer_sign_character_realization"],
    habitat: "Z",
    verification: ["sagemath/check/integer-sign-character-realization"],
    statement: [
      paragraph([
        ref("def_f2_linear_character_space"),
        " の有限集合 ",
        math(String.raw`H`),
        " から整数集合 ",
        math(String.raw`\{-1,+1\}\subset\mathbb Z`),
        " への写像全体を ",
        math(String.raw`\{-1,+1\}^H`),
        " と書く。",
        math(String.raw`\mathbb F_2`),
        " 値文字を整数値の符号文字へ送る写像を",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{sgn}_H:H^\vee
&\longrightarrow \{-1,+1\}^H,\\
\varphi
&\longmapsto \operatorname{sgn}_H(\varphi),\\
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h)
&:=
\begin{cases}
  +1,&\varphi(h)=0_{\mathbb F_2},\\
  -1,&\varphi(h)=1_{\mathbb F_2}
\end{cases}
\qquad(\varphi\in H^\vee,\ h\in H)
\end{aligned}`),
      paragraph([
        "で定める。値 ",
        math(String.raw`0_{\mathbb F_2}`),
        " と ",
        math(String.raw`1_{\mathbb F_2}`),
        " は有限体 ",
        math(String.raw`\mathbb F_2`),
        " の相異なる全ての元であり、右辺の ",
        math(String.raw`-1,+1`),
        " は整数である。したがって二つの値集合を同一視せず、始域と終域を明示した写像だけを通して移す。全ての対象は有限集合、",
        math(String.raw`\mathbb F_2`),
        "、または ",
        math(String.raw`\mathbb Z`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_fourier_claim_integer_sign_character_multiplicativity",
    kind: "claim",
    title: { text: "整数符号実現の乗法性" },
    labels: ["claim_integer_sign_character_multiplicativity"],
    habitat: "Z",
    verification: ["sagemath/check/integer-sign-character-multiplicativity"],
    statement: [
      paragraph([
        ref("def_f2_linear_character_space"),
        " と ",
        ref("def_integer_sign_character_realization"),
        " に対して、任意の ",
        math(String.raw`\varphi\in H^\vee`),
        " と任意の ",
        math(String.raw`h,k\in H`),
        " に対して、",
      ]),
      displayMath(String.raw`\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h+k)
=
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h)
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(k)
\in\mathbb Z.`),
    ],
    proof: [
      paragraph([
        math(String.raw`a:=\varphi(h)\in\mathbb F_2`),
        "、",
        math(String.raw`b:=\varphi(k)\in\mathbb F_2`),
        " と置く。",
        math(String.raw`\mathbb F_2=\{0_{\mathbb F_2},1_{\mathbb F_2}\}`),
        " なので、",
        math(String.raw`(a,b)`),
        " には四つの場合しかない。",
      ]),
      paragraph([
        ref("def_f2_linear_character_space"),
        " と ",
        ref("def_integer_sign_character_realization"),
        " より、",
        math(String.raw`a=0_{\mathbb F_2}`),
        " かつ ",
        math(String.raw`b=0_{\mathbb F_2}`),
        " の場合は",
      ]),
      displayMath(String.raw`\begin{aligned}
\varphi(h+k)
&=\varphi(h)+\varphi(k)
\quad\bigl(\because\ \varphi\text{ の }\mathbb F_2\text{-線形性}\bigr)\\
&=a+b
\quad\bigl(\because\ a=\varphi(h),\ b=\varphi(k)\bigr)\\
&=0_{\mathbb F_2}
\quad\bigl(\because\ a=b=0_{\mathbb F_2}\bigr).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h+k)
&=+1
\quad\bigl(\because\ \varphi(h+k)=0_{\mathbb F_2}\text{ と整数符号実現の定義}\bigr)\\
&=(+1)(+1)
\quad\bigl(\because\ \mathbb Z\text{ の乗法単位元}\bigr)\\
&=
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h)
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(k)
\quad\bigl(\because\ a=b=0_{\mathbb F_2}\bigr).
\end{aligned}`),
      paragraph([
        ref("def_f2_linear_character_space"),
        " と ",
        ref("def_integer_sign_character_realization"),
        " より、",
        math(String.raw`a=0_{\mathbb F_2}`),
        " かつ ",
        math(String.raw`b=1_{\mathbb F_2}`),
        " の場合は",
      ]),
      displayMath(String.raw`\begin{aligned}
\varphi(h+k)
&=\varphi(h)+\varphi(k)
\quad\bigl(\because\ \varphi\text{ の }\mathbb F_2\text{-線形性}\bigr)\\
&=a+b
\quad\bigl(\because\ a=\varphi(h),\ b=\varphi(k)\bigr)\\
&=1_{\mathbb F_2}
\quad\bigl(\because\ a=0_{\mathbb F_2},\ b=1_{\mathbb F_2}\bigr).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h+k)
&=-1
\quad\bigl(\because\ \varphi(h+k)=1_{\mathbb F_2}\text{ と整数符号実現の定義}\bigr)\\
&=(+1)(-1)
\quad\bigl(\because\ \mathbb Z\text{ の乗法単位元}\bigr)\\
&=
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h)
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(k)
\quad\bigl(\because\ a=0_{\mathbb F_2},\ b=1_{\mathbb F_2}\bigr).
\end{aligned}`),
      paragraph([
        ref("def_f2_linear_character_space"),
        " と ",
        ref("def_integer_sign_character_realization"),
        " より、",
        math(String.raw`a=1_{\mathbb F_2}`),
        " かつ ",
        math(String.raw`b=0_{\mathbb F_2}`),
        " の場合は",
      ]),
      displayMath(String.raw`\begin{aligned}
\varphi(h+k)
&=\varphi(h)+\varphi(k)
\quad\bigl(\because\ \varphi\text{ の }\mathbb F_2\text{-線形性}\bigr)\\
&=a+b
\quad\bigl(\because\ a=\varphi(h),\ b=\varphi(k)\bigr)\\
&=1_{\mathbb F_2}
\quad\bigl(\because\ a=1_{\mathbb F_2},\ b=0_{\mathbb F_2}\bigr).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h+k)
&=-1
\quad\bigl(\because\ \varphi(h+k)=1_{\mathbb F_2}\text{ と整数符号実現の定義}\bigr)\\
&=(-1)(+1)
\quad\bigl(\because\ \mathbb Z\text{ の乗法単位元}\bigr)\\
&=
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h)
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(k)
\quad\bigl(\because\ a=1_{\mathbb F_2},\ b=0_{\mathbb F_2}\bigr).
\end{aligned}`),
      paragraph([
        ref("def_f2_linear_character_space"),
        " と ",
        ref("def_integer_sign_character_realization"),
        " より、",
        math(String.raw`a=1_{\mathbb F_2}`),
        " かつ ",
        math(String.raw`b=1_{\mathbb F_2}`),
        " の場合は",
      ]),
      displayMath(String.raw`\begin{aligned}
\varphi(h+k)
&=\varphi(h)+\varphi(k)
\quad\bigl(\because\ \varphi\text{ の }\mathbb F_2\text{-線形性}\bigr)\\
&=a+b
\quad\bigl(\because\ a=\varphi(h),\ b=\varphi(k)\bigr)\\
&=0_{\mathbb F_2}
\quad\bigl(\because\ a=b=1_{\mathbb F_2}\text{ と }1_{\mathbb F_2}+1_{\mathbb F_2}=0_{\mathbb F_2}\bigr).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h+k)
&=+1
\quad\bigl(\because\ \varphi(h+k)=0_{\mathbb F_2}\text{ と整数符号実現の定義}\bigr)\\
&=(-1)(-1)
\quad\bigl(\because\ \mathbb Z\text{ の整数積}\bigr)\\
&=
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h)
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(k)
\quad\bigl(\because\ a=b=1_{\mathbb F_2}\bigr).
\end{aligned}`),
      paragraph([
        "四つの場合で同じ整数等式を得たので、全ての ",
        math(String.raw`\varphi\in H^\vee`),
        " と ",
        math(String.raw`h,k\in H`),
        " について主張が成り立つ。全ての演算は有限集合、",
        math(String.raw`\mathbb F_2`),
        "、または ",
        math(String.raw`\mathbb Z`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_fourier_theorem_f2_character_separates_nonzero_vector",
    kind: "theorem",
    title: { text: "有限 F_2 ベクトル空間の非零元を分離する文字" },
    labels: ["theorem_f2_character_separates_nonzero_vector"],
    habitat: "F2",
    statement: [
      paragraph([ref("def_f2_linear_character_space"), " の有限 ", math(String.raw`\mathbb F_2`), " ベクトル空間 ", math("H"), " に対し、任意の ", math(String.raw`0_H\ne x\in H`), " について ", math(String.raw`\varphi(x)=1_{\mathbb F_2}`), " を満たす ", math(String.raw`\varphi\in H^\vee`), " が存在する。"]),
    ],
    proof: [
      paragraph(["一元列 ", math(String.raw`(x)`), " は線形独立である。有限集合 ", math("H"), " の元を一つずつ調べ、現在の線形包に属さない元だけを加える有限手続きにより、ある ", math(String.raw`d\in\mathbb N_{>0}`), " と ", math(String.raw`b_2,\ldots,b_d\in H`), " が存在し、", math("x"), " を含む基底 ", math(String.raw`(x,b_2,\ldots,b_d)`), " を得る。各基底表示 ", math(String.raw`a_1x+\sum_{j=2}^d a_jb_j`), " に対し ", math(String.raw`\varphi(a_1x+\sum_{j=2}^d a_jb_j):=a_1`), " と定めると、基底表示の一意性により ", math(String.raw`\varphi:H\to\mathbb F_2`), " は線形写像であり、", math(String.raw`\varphi(x)=1_{\mathbb F_2}`), " である。"]),
    ],
  },
  {
    id: "finite_fourier_theorem_character_orthogonality",
    kind: "theorem",
    title: { text: "有限第一ホモロジー群上の文字直交関係" },
    labels: ["theorem_finite_character_orthogonality"],
    habitat: "Z",
    verification: ["sagemath/check/finite-character-orthogonality"],
    statement: [
      paragraph([
        ref("def_f2_linear_character_space"),
        " と ",
        ref("def_integer_sign_character_realization"),
        " に対して、任意の ",
        math(String.raw`h,k\in H`),
        " について、有限な文字空間 ",
        math(String.raw`H^\vee`),
        " 上の整数和は",
      ]),
      displayMath(String.raw`\sum_{\varphi\in H^\vee}
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h)
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(k)
=
\begin{cases}
  |H^\vee|,&h=k,\\
  0,&h\ne k
\end{cases}
\in\mathbb Z.`),
    ],
    proof: [
      paragraph([
        ref("claim_integer_sign_character_multiplicativity"),
        " より、任意の ",
        math(String.raw`\varphi\in H^\vee`),
        " について、",
      ]),
      displayMath(String.raw`\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h)
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(k)
=
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h+k)
\quad\bigl(\because\ \text{整数符号実現の乗法性}\bigr).`),
      paragraph([
        math(String.raw`h=k`),
        " の場合、",
        math(String.raw`\mathbb F_2`),
        " ベクトル空間の加法により ",
        math(String.raw`h+k=0_H`),
        " である。",
        ref("def_f2_linear_character_space"),
        " の線形性と ",
        ref("def_integer_sign_character_realization"),
        " の二場合より、任意の ",
        math(String.raw`\varphi\in H^\vee`),
        " について、",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h+k)
&=
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(0_H)
\quad\bigl(\because\ h+k=0_H\bigr)\\
&=+1
\quad\bigl(\because\ \varphi(0_H)=0_{\mathbb F_2}\text{ と整数符号実現の定義}\bigr).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sum_{\varphi\in H^\vee}
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h)
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(k)
&=
\sum_{\varphi\in H^\vee}
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h+k)
\quad\bigl(\because\ \text{整数符号実現の乗法性}\bigr)\\
&=
\sum_{\varphi\in H^\vee}1
\quad\bigl(\because\ h=k\text{ の場合の上の等式}\bigr)\\
&=|H^\vee|
\quad\bigl(\because\ H^\vee\text{ は有限集合}\bigr).
\end{aligned}`),
      paragraph([
        math(String.raw`h\ne k`),
        " の場合、",
        math(String.raw`x:=h+k\in H`),
        " と置くと ",
        math(String.raw`x\ne0_H`),
        " である。", ref("theorem_f2_character_separates_nonzero_vector"), " により ",
        math(String.raw`\psi\in H^\vee`),
        " であって ", math(String.raw`\psi(x)=1_{\mathbb F_2}`), " を満たすものを取る。写像 ",
        math(String.raw`\tau_\psi:H^\vee\to H^\vee`),
        " を ",
        math(String.raw`\tau_\psi(\varphi):=\varphi+\psi`),
        " で定める。",
        math(String.raw`\psi+\psi=0_{H^\vee}`),
        " なので ",
        math(String.raw`\tau_\psi\circ\tau_\psi=\operatorname{id}_{H^\vee}`),
        " であり、",
        math(String.raw`\tau_\psi`),
        " は全単射である。",
      ]),
      paragraph([
        ref("def_integer_sign_character_realization"),
        " の二場合を ",
        math(String.raw`\varphi(x)\in\mathbb F_2`),
        " に適用すると、任意の ",
        math(String.raw`\varphi\in H^\vee`),
        " について、",
      ]),
      displayMath(String.raw`\bigl(\operatorname{sgn}_H(\tau_\psi(\varphi))\bigr)(x)
=
-\bigl(\operatorname{sgn}_H(\varphi)\bigr)(x)
\quad\bigl(\because\ (\varphi+\psi)(x)=\varphi(x)+1_{\mathbb F_2}\bigr).`),
      paragraph([
        math(String.raw`S_x:=\sum_{\varphi\in H^\vee}(\operatorname{sgn}_H(\varphi))(x)\in\mathbb Z`),
        " と置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
S_x
&=
\sum_{\varphi\in H^\vee}
\bigl(\operatorname{sgn}_H(\tau_\psi(\varphi))\bigr)(x)
\quad\bigl(\because\ \tau_\psi\text{ は }H^\vee\text{ の全単射}\bigr)\\
&=
\sum_{\varphi\in H^\vee}
-\bigl(\operatorname{sgn}_H(\varphi)\bigr)(x)
\quad\bigl(\because\ \tau_\psi\text{ による整数符号の反転}\bigr)\\
&=-S_x
\quad\bigl(\because\ \mathbb Z\text{ の有限和の分配律}\bigr).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
2S_x
&=0
\quad\bigl(\because\ S_x=-S_x\bigr)\\
S_x
&=0
\quad\bigl(\because\ \mathbb Z\text{ は零因子を持たず }2\ne0\bigr).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sum_{\varphi\in H^\vee}
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h)
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(k)
&=
\sum_{\varphi\in H^\vee}
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h+k)
\quad\bigl(\because\ \text{整数符号実現の乗法性}\bigr)\\
&=S_x
\quad\bigl(\because\ x=h+k\bigr)\\
&=0
\quad\bigl(\because\ h\ne k\text{ の場合の上の等式}\bigr).
\end{aligned}`),
      paragraph([
        "二つの場合で主張を得た。全ての演算は有限集合、",
        math(String.raw`\mathbb F_2`),
        "、または ",
        math(String.raw`\mathbb Z`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_fourier_definition_transform",
    kind: "definition",
    title: { text: "有限第一ホモロジー群上の Fourier 変換" },
    labels: ["def_finite_fourier_transform"],
    habitat: "ZPolynomial",
    statement: [
      paragraph([ref("def_f2_linear_character_space"), " の有限群 ", math("H"), " と文字空間 ", math(String.raw`H^\vee`), "、および ", ref("def_integer_sign_character_realization"), " の整数符号文字に対し、多項式族の有限 Fourier 変換を"]),
      displayMath(String.raw`\mathcal F_H:(\mathbb Z[u,v])^H\to(\mathbb Z[u,v])^{H^\vee},\qquad (\mathcal F_H(A))_\varphi:=\sum_{k\in H}(\operatorname{sgn}_H(\varphi))(k)A_k`),
      paragraph(["で定める。全ての和は有限和である。"]),
    ],
  },
  {
    id: "finite_fourier_definition_integer_polynomial_rational_embedding",
    kind: "definition",
    title: { text: "整数係数多項式の有理係数への標準単射" },
    labels: ["def_integer_polynomial_rational_embedding"],
    habitat: "QPolynomial",
    statement: [paragraph([math(String.raw`\jmath:\mathbb Z[u,v]\to\mathbb Q[u,v]`), " を各整数係数を同じ有理数係数へ送る標準単射と定める。"])],
  },
  {
    id: "finite_fourier_definition_natural_rational_embedding",
    kind: "definition",
    title: { text: "自然数の有理数への標準単射" },
    labels: ["def_natural_rational_embedding"],
    habitat: "Q",
    statement: [paragraph([ref("def_natural_numbers"), " の自然数に対し、", math(String.raw`\iota_{\mathbb N,\mathbb Q}:\mathbb N\to\mathbb Q`), " を ", math(String.raw`n\mapsto n/1`), " で定める。"])],
  },
  {
    id: "finite_fourier_theorem_inverse_transform",
    kind: "theorem",
    standing: "mainTheorem",
    title: { text: "有限第一ホモロジー群上の Fourier 逆変換" },
    labels: ["theorem_finite_fourier_inverse_transform"],
    habitat: "QPolynomial",
    verification: ["sagemath/check/finite-fourier-inverse-transform"],
    statement: [
      paragraph([
        ref("def_finite_fourier_transform"),
        " の Fourier 変換を取る。有限第一ホモロジー群 ",
        math(String.raw`H`),
        " と文字空間 ",
        math(String.raw`H^\vee`),
        " に対し、任意の多項式族 ",
        math(String.raw`A=(A_k)_{k\in H}\in\bigl(\mathbb Z[u,v]\bigr)^H`),
        " とその変換 ", math(String.raw`\widehat A:=\mathcal F_H(A)`), " を取る。", ref("def_integer_polynomial_rational_embedding"), " と ", ref("def_natural_rational_embedding"), " の標準単射を用いる。このとき、任意の ",
        math(String.raw`h\in H`),
        " について",
      ]),
      displayMath(String.raw`\jmath(A_h)
=
\frac{1}{\iota_{\mathbb N,\mathbb Q}(|H^\vee|)}
\sum_{\varphi\in H^\vee}
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h)
\jmath\!\left(\widehat A_{\varphi}\right)
\in\mathbb Q[u,v].`),
    ],
    proof: [
      paragraph([
        "零写像 ",
        math(String.raw`0_{H^\vee}:H\to\mathbb F_2`),
        " は ",
        math(String.raw`H^\vee`),
        " の元なので、",
        math(String.raw`|H^\vee|\in\mathbb N_{>0}`),
        " である。したがって ",
        math(String.raw`n:=\iota_{\mathbb N,\mathbb Q}(|H^\vee|)\in\mathbb Q_{>0}`),
        " と置けば、",
        math(String.raw`n^{-1}\in\mathbb Q`),
        " が定まる。任意の ",
        math(String.raw`h\in H`),
        " を固定する。",
        ref("def_integer_sign_character_realization"),
        " の整数符号を短く ",
        math(String.raw`\varepsilon_\varphi(k):=\bigl(\operatorname{sgn}_H(\varphi)\bigr)(k)\in\{-1,+1\}`),
        " と書く。",
      ]),
      paragraph(["有限 Fourier 変換の定義より"]),
      displayMath(String.raw`\begin{aligned}
\frac{1}{n}
\sum_{\varphi\in H^\vee}
\varepsilon_\varphi(h)
\jmath\!\left(\widehat A_{\varphi}\right)
&=
\frac{1}{n}
\sum_{\varphi\in H^\vee}
\varepsilon_\varphi(h)
\jmath\!\left(
  \sum_{k\in H}
  \varepsilon_\varphi(k)A_k
\right)
\quad\bigl(\because\ \widehat A_{\varphi}\text{ の定義}\bigr)\\
&=
\frac{1}{n}
\sum_{\varphi\in H^\vee}
\sum_{k\in H}
\varepsilon_\varphi(h)
\varepsilon_\varphi(k)
\jmath(A_k)
\quad\bigl(\because\ \jmath\text{ は環準同型}\bigr)\\
&=
\frac{1}{n}
\sum_{k\in H}
\left(
  \sum_{\varphi\in H^\vee}
  \varepsilon_\varphi(h)
  \varepsilon_\varphi(k)
\right)
\jmath(A_k)
\quad\bigl(\because\ \text{有限和の交換}\bigr).
\end{aligned}`),
      paragraph([ref("theorem_finite_character_orthogonality"), " より"]),
      displayMath(String.raw`\begin{aligned}
\frac{1}{n}
\sum_{k\in H}
\left(
  \sum_{\varphi\in H^\vee}
  \varepsilon_\varphi(h)
  \varepsilon_\varphi(k)
\right)
\jmath(A_k)
&=
\frac{1}{n}
\left(
  n\jmath(A_h)
  +
  \sum_{\substack{k\in H\\k\ne h}}
  0\jmath(A_k)
\right)
\quad\bigl(\because\ \text{文字直交関係}\bigr)\\
&=
\frac{1}{n}n\jmath(A_h)
\quad\bigl(\because\ \mathbb Q[u,v]\text{ の零元と有限和}\bigr)\\
&=
\jmath(A_h)
\quad\bigl(\because\ n^{-1}n=1\bigr).
\end{aligned}`),
      paragraph([
        "これで任意の ",
        math(String.raw`h\in H`),
        " に対する逆変換を得た。分母を取る最後の操作だけが整数係数多項式環 ",
        math(String.raw`\mathbb Z[u,v]`),
        " から有理係数多項式環 ",
        math(String.raw`\mathbb Q[u,v]`),
        " への標準単射 ",
        math(String.raw`\jmath`),
        " を必要とする。全ての和は有限であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_fourier_definition_primal_dual_cell_correspondence",
    kind: "definition",
    title: { text: "主セルと双対セルの対応データ" },
    labels: ["def_primal_dual_cell_correspondence"],
    habitat: "finite",
    verification: ["sagemath/check/primal-dual-cell-correspondence"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_cell_sets"),
        " のセル集合入力 ",
        math(String.raw`\mathcal C_{\mathrm{cell}}=(V_{\mathrm{cell}},E_{\mathrm{cell}},F_{\mathrm{cell}})`),
        " が ",
        ref("def_oriented_closed_surface_cellulation"),
        " の向き付けられた閉曲面セル分割述語を満たすとする。主セルのラベルとは異なる新しいラベルからなる、互いに素な三つの空でない有限集合 ",
        math(String.raw`V_{\mathrm{cell}}^\ast`),
        "、",
        math(String.raw`E_{\mathrm{cell}}^\ast`),
        "、",
        math(String.raw`F_{\mathrm{cell}}^\ast`),
        " と、三つの全単射",
      ]),
      displayMath(String.raw`\begin{aligned}
d_0:F_{\mathrm{cell}}
&\longrightarrow V_{\mathrm{cell}}^\ast,\\
d_1:E_{\mathrm{cell}}
&\longrightarrow E_{\mathrm{cell}}^\ast,\\
d_2:V_{\mathrm{cell}}
&\longrightarrow F_{\mathrm{cell}}^\ast
\end{aligned}`),
      paragraph([
        "の組を、",
        math(String.raw`\mathcal C_{\mathrm{cell}}`),
        " の主セルと双対セルの対応データと呼ぶ。双対頂点、双対辺、双対面の有限集合を",
      ]),
      displayMath(String.raw`\mathcal C_{\mathrm{cell}}^\ast
:=
\bigl(V_{\mathrm{cell}}^\ast,E_{\mathrm{cell}}^\ast,F_{\mathrm{cell}}^\ast\bigr)`),
      paragraph([
        "と書く。面 ",
        math(String.raw`f\in F_{\mathrm{cell}}`),
        " に対応する双対頂点は ",
        math(String.raw`d_0(f)\in V_{\mathrm{cell}}^\ast`),
        "、辺 ",
        math(String.raw`e\in E_{\mathrm{cell}}`),
        " に対応する双対辺は ",
        math(String.raw`d_1(e)\in E_{\mathrm{cell}}^\ast`),
        "、頂点 ",
        math(String.raw`v\in V_{\mathrm{cell}}`),
        " に対応する双対面は ",
        math(String.raw`d_2(v)\in F_{\mathrm{cell}}^\ast`),
        " である。主セルと双対セルを同一視せず、両者の移行には三つの全単射だけを用いる。この定義はセルラベルの対応だけを定め、双対辺の端点写像と双対面の境界語は後続の別ブロックで定める。全ての対象は有限集合であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_fourier_definition_dual_edge_endpoint_map",
    kind: "definition",
    title: { text: "双対辺の端点写像" },
    labels: ["def_dual_edge_endpoint_map"],
    habitat: "finite",
    verification: ["sagemath/check/dual-edge-endpoint-map"],
    statement: [
      paragraph([
        ref("def_primal_dual_cell_correspondence"),
        " の主セルと双対セルの対応データを固定する。各主辺 ",
        math(String.raw`e\in E_{\mathrm{cell}}`),
        " と各向きラベル ",
        math(String.raw`\omega\in\mathsf{Ori}`),
        " に対し、",
      ]),
      displayMath(String.raw`\mathcal O_e^\omega
:=
\left\{
  (f,i)
  \ \middle|\
  \begin{array}{l}
    f\in F_{\mathrm{cell}},\quad i\in P_f,\\
    e_{f,i}=e,\quad \omega_{f,i}=\omega
  \end{array}
\right\}`),
      paragraph([
        "と置く。",
        ref("def_finite_cellulation_opposite_edge_occurrences"),
        " と ",
        ref("def_finite_cellulation_orientation_reversal"),
        " より、有限集合 ",
        math(String.raw`\mathcal O_e^{\mathsf{forward}}`),
        " と ",
        math(String.raw`\mathcal O_e^{\mathsf{reverse}}`),
        " はそれぞれちょうど一つの元をもつ。その元を",
      ]),
      displayMath(String.raw`(f_e^{\mathsf{forward}},i_e^{\mathsf{forward}})
\in\mathcal O_e^{\mathsf{forward}},
\qquad
(f_e^{\mathsf{reverse}},i_e^{\mathsf{reverse}})
\in\mathcal O_e^{\mathsf{reverse}}`),
      paragraph([
        "と書く。双対辺の端点写像を、",
        ref("def_edge_endpoint_label_set"),
        " の辺端ラベルを用いて",
      ]),
      displayMath(String.raw`\partial_G^\ast:
E_{\mathrm{cell}}^\ast\times\mathsf{End}
\longrightarrow V_{\mathrm{cell}}^\ast`),
      paragraph(["および、任意の ", math(String.raw`e\in E_{\mathrm{cell}}`), " に対する二つの値"]),
      displayMath(String.raw`\begin{aligned}
\partial_G^\ast\bigl(d_1(e),\mathsf{source}\bigr)
&:=d_0\bigl(f_e^{\mathsf{forward}}\bigr),\\
\partial_G^\ast\bigl(d_1(e),\mathsf{target}\bigr)
&:=d_0\bigl(f_e^{\mathsf{reverse}}\bigr)
\end{aligned}`),
      paragraph([
        "で定める。",
        math(String.raw`d_1:E_{\mathrm{cell}}\to E_{\mathrm{cell}}^\ast`),
        " は全単射なので、上の二つの値は全ての双対辺に対して端点写像を一意に定める。二つの主辺出現が同じ主面に属する場合には ",
        math(String.raw`f_e^{\mathsf{forward}}=f_e^{\mathsf{reverse}}`),
        " となり、二つの双対端点も一致する。この定義だけから端点の相異なりは主張せず、双対辺集合を ",
        ref("def_finite_graph_input"),
        " の有限グラフ入力とするための条件は後続の別ブロックで扱う。全ての対象は有限集合であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_fourier_definition_dual_face_boundary_word",
    kind: "definition",
    title: { text: "双対面の向き付き境界語" },
    labels: ["def_dual_face_boundary_word"],
    habitat: "finite",
    verification: ["sagemath/check/dual-face-boundary-word"],
    statement: [
      paragraph([
        ref("def_dual_edge_endpoint_map"),
        " の双対辺端点写像を固定する。各主頂点 ",
        math(String.raw`v\in V_{\mathrm{cell}}`),
        " に対し、",
        ref("def_finite_cellulation_vertex_links_are_cycles"),
        " の角位置集合 ",
        math(String.raw`C_v`),
        " を、対応する双対面 ",
        math(String.raw`d_2(v)\in F_{\mathrm{cell}}^\ast`),
        " の境界位置集合として用いる。角位置 ",
        math(String.raw`c=(f,i)\in C_v`),
        " の出発側の辺端を",
      ]),
      displayMath(String.raw`h_c^{\mathsf{departing}}
:=
h_{f,i}(\mathsf{departing})
=
\bigl(e_{f,s_f(i)},\iota(\omega_{f,s_f(i)})\bigr)
\in E_{\mathrm{cell}}\times\mathsf{End}`),
      paragraph([
        "と書く。頂点リンク単巡回述語の辺端二回出現条件と辺の逆向き二回出現条件により、",
        math(String.raw`h_c^{\mathsf{departing}}`),
        " を到着側としてもつ角位置 ",
        math(String.raw`c'=(g,j)\in C_v`),
        " がただ一つ存在する。この角位置を ",
        math(String.raw`s_v^\ast(c):=c'`),
        " と定める。すなわち、",
      ]),
      displayMath(String.raw`h_{g,j}(\mathsf{arriving})
=
h_{f,i}(\mathsf{departing})
\qquad
\bigl(s_v^\ast(f,i)=(g,j)\bigr)`),
      paragraph([
        "である。各辺端には到着側と出発側が一つずつ現れるので、",
        math(String.raw`s_v^\ast:C_v\to C_v`),
        " は全単射である。さらに頂点リンク単巡回述語の連結条件により、任意の ",
        math(String.raw`c,c'\in C_v`),
        " に対して、ある ",
        math(String.raw`r\in\mathbb N`),
        " が存在して ",
        math(String.raw`(s_v^\ast)^{\circ r}(c)=c'`),
        " となる。したがって ",
        math(String.raw`\mathcal P_{d_2(v)}^\ast:=(C_v,s_v^\ast)`),
        " は有限な巡回位置系である。双対面 ",
        math(String.raw`d_2(v)`),
        " の向き付き境界語を、",
      ]),
      displayMath(String.raw`\begin{aligned}
\partial_{\mathrm{word}}^\ast d_2(v):C_v
&\longrightarrow E_{\mathrm{cell}}^\ast\times\mathsf{Ori},\\
(f,i)
&\longmapsto
\bigl(
  d_1(e_{f,s_f(i)}),
  \omega_{f,s_f(i)}
\bigr)
\end{aligned}`),
      paragraph([
        "で定める。",
        math(String.raw`s_v^\ast(f,i)=(g,j)`),
        " なら、同じ主辺の二つの面境界出現は逆向きであり、",
        ref("def_dual_edge_endpoint_map"),
        " の端点定義から双対境界の接続条件",
      ]),
      displayMath(String.raw`\partial_G^\ast\!\left(
  d_1(e_{f,s_f(i)}),
  \tau(\omega_{f,s_f(i)})
\right)
=
\partial_G^\ast\!\left(
  d_1(e_{g,s_g(j)}),
  \iota(\omega_{g,s_g(j)})
\right)`),
      paragraph([
        "が成り立つ。主頂点、角位置、主辺、双対辺、主面、双対頂点を同一視せず、移行には ",
        math(String.raw`h_{f,i}`),
        "、",
        math(String.raw`s_v^\ast`),
        "、",
        math(String.raw`d_0,d_1,d_2`),
        "、",
        math(String.raw`\iota,\tau`),
        " だけを用いる。全ての対象は有限集合であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_fourier_definition_primal_to_dual_edge_coefficient_transport",
    kind: "definition",
    title: { text: "主辺係数から双対辺係数への移送写像" },
    labels: ["def_primal_to_dual_edge_coefficient_transport"],
    habitat: "F2",
    verification: ["sagemath/check/primal-to-dual-edge-coefficient-transport"],
    statement: [
      paragraph([
        ref("def_primal_dual_cell_correspondence"),
        " の主辺から双対辺への全単射 ",
        math(String.raw`d_1:E_{\mathrm{cell}}\to E_{\mathrm{cell}}^\ast`),
        " を固定する。主辺係数から双対辺係数への移送写像を、始域、終域、作用を明示して",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathsf D_1:
\mathbb F_2^{E_{\mathrm{cell}}}
&\longrightarrow
\mathbb F_2^{E_{\mathrm{cell}}^\ast},\\
c
&\longmapsto
\mathsf D_1(c),\\
\mathsf D_1(c)(e^\ast)
&:=
c\!\left(d_1^{-1}(e^\ast)\right)
\qquad
\left(e^\ast\in E_{\mathrm{cell}}^\ast\right)
\end{aligned}`),
      paragraph([
        "で定める。ここで ",
        math(String.raw`c:E_{\mathrm{cell}}\to\mathbb F_2`),
        " は主辺ラベルごとの係数写像であり、",
        math(String.raw`\mathsf D_1(c):E_{\mathrm{cell}}^\ast\to\mathbb F_2`),
        " は双対辺ラベルごとの係数写像である。",
        math(String.raw`d_1`),
        " は全単射なので、任意の ",
        math(String.raw`e^\ast\in E_{\mathrm{cell}}^\ast`),
        " に対する ",
        math(String.raw`d_1^{-1}(e^\ast)\in E_{\mathrm{cell}}`),
        " は一意に定まる。主辺係数空間と双対辺係数空間を同一視せず、両者の移行には ",
        math(String.raw`\mathsf D_1`),
        " だけを用いる。この定義は係数の移送だけを定め、一次サイクル空間への制限と第一ホモロジー類への作用は後続の別ブロックで扱う。全ての対象は有限集合または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_fourier_definition_primal_first_cocycle_space",
    kind: "definition",
    title: { text: "主セルの F_2 上の一次コサイクル空間" },
    labels: ["def_primal_first_cocycle_space_over_f2"],
    habitat: "F2",
    verification: ["sagemath/check/primal-first-cocycle-space-over-f2"],
    statement: [
      paragraph([
        ref("def_second_boundary_matrix_over_f2"),
        " の二次境界行列 ",
        math(String.raw`\partial_2\in\operatorname{Mat}_{E_{\mathrm{cell}}\times F_{\mathrm{cell}}}(\mathbb F_2)`),
        " に対し、主セルの一次コサイクル空間を",
      ]),
      displayMath(String.raw`\operatorname{Cocycle}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)
:=
\left\{
  c\in\mathbb F_2^{E_{\mathrm{cell}}}
  \ \middle|\
  \ \sum_{e\in E_{\mathrm{cell}}}
  (\partial_2)_{e,f}c(e)
  =0_{\mathbb F_2}
  \text{ for every }f\in F_{\mathrm{cell}}
\right\}
\subseteq
\mathbb F_2^{E_{\mathrm{cell}}}`),
      paragraph([
        "と定める。ここで ",
        math(String.raw`c:E_{\mathrm{cell}}\to\mathbb F_2`),
        " は主辺ラベルごとの係数写像であり、各 ",
        math(String.raw`f\in F_{\mathrm{cell}}`),
        " に対する有限和は、面 ",
        math(String.raw`f`),
        " の二次境界の係数と ",
        math(String.raw`c`),
        " の対応する主辺係数との積を全主辺にわたって加えた値である。この条件は有限行列 ",
        math(String.raw`\partial_2`),
        " の転置が定める線形写像 ",
        math(String.raw`\mathbb F_2^{E_{\mathrm{cell}}}\to\mathbb F_2^{F_{\mathrm{cell}}}`),
        " で零へ写ることを成分ごとに書いたものである。したがって ",
        math(String.raw`\operatorname{Cocycle}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)`),
        " は有限な ",
        math(String.raw`\mathbb F_2`),
        " ベクトル空間である。一次サイクル空間とは同一視せず、",
        ref("def_primal_to_dual_edge_coefficient_transport"),
        " による双対一次サイクル空間への移送は後続の別ブロックで扱う。全ての対象は有限集合または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_fourier_definition_dual_first_boundary_matrix",
    kind: "definition",
    title: { text: "双対一次境界行列" },
    labels: ["def_dual_first_boundary_matrix"],
    habitat: "F2",
    statement: [
      paragraph([ref("def_dual_edge_endpoint_map"), " の双対辺端点写像に対し、双対一次境界行列を"]),
      displayMath(String.raw`\partial_1^\ast:=\left[\sum_{\substack{a\in\mathsf{End}\\\partial_G^\ast(e^\ast,a)=v^\ast}}1_{\mathbb F_2}\right]_{v^\ast\in V_{\mathrm{cell}}^\ast,\ e^\ast\in E_{\mathrm{cell}}^\ast}`),
      paragraph(["と定める。同じ双対頂点を二端にもつ双対辺では、その列の当該成分は二元体で零になる。"]),
    ],
  },
  {
    id: "finite_fourier_definition_dual_first_cycle_space",
    kind: "definition",
    title: { text: "双対一次サイクル空間" },
    labels: ["def_dual_first_cycle_space"],
    habitat: "F2",
    statement: [
      paragraph([ref("def_dual_first_boundary_matrix"), " の核を双対一次サイクル空間と呼び、"]),
      displayMath(String.raw`\operatorname{Cycle}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2):=\ker(\partial_1^\ast)`),
      paragraph(["と定める。"]),
    ],
  },
  {
    id: "finite_fourier_theorem_primal_cocycle_transport_is_dual_cycle",
    kind: "theorem",
    title: { text: "主一次コサイクルの係数移送は双対一次サイクルである" },
    labels: ["theorem_primal_cocycle_transport_is_dual_cycle"],
    habitat: "F2",
    verification: ["sagemath/check/primal-cocycle-transport-is-dual-cycle"],
    statement: [
      paragraph([
        ref("def_dual_first_cycle_space"),
        " の双対一次サイクル空間と ", ref("def_primal_first_cocycle_space_over_f2"), " の主一次コサイクル空間を取る。このとき、",
      ]),
      displayMath(String.raw`\mathsf D_1\!\left(
  \operatorname{Cocycle}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)
\right)
\subseteq
\operatorname{Cycle}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2).`),
    ],
    proof: [
      paragraph([
        "任意の ",
        math(String.raw`c\in\operatorname{Cocycle}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)`),
        " と ",
        math(String.raw`f\in F_{\mathrm{cell}}`),
        " を固定する。",
        ref("def_dual_edge_endpoint_map"),
        " の双対辺端点写像、",
        ref("def_finite_cellulation_opposite_edge_occurrences"),
        " と ",
        ref("def_finite_cellulation_orientation_reversal"),
        " による各主辺の正向き出現と逆向き出現の一意性、および ",
        ref("def_primal_dual_cell_correspondence"),
        " の全単射 ",
        math(String.raw`d_0:F_{\mathrm{cell}}\to V_{\mathrm{cell}}^\ast`),
        " の単射性から、任意の ",
        math(String.raw`e\in E_{\mathrm{cell}}`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
(\partial_1^\ast)_{d_0(f),d_1(e)}
&=
\sum_{\substack{
  a\in\mathsf{End}\\
  \partial_G^\ast(d_1(e),a)=d_0(f)
}}1_{\mathbb F_2}
\quad\bigl(\because\ \partial_1^\ast\text{ の定義}\bigr)\\
&=
\sum_{\substack{
  i\in P_f\\
  e_{f,i}=e
}}1_{\mathbb F_2}
\quad\bigl(\because\ \text{二つの向き別出現と双対辺端点の対応}\bigr)
\end{aligned}`),
      paragraph([ref("def_second_boundary_matrix_over_f2"), " より"]),
      displayMath(String.raw`(\partial_1^\ast)_{d_0(f),d_1(e)}
=
(\partial_2)_{e,f}.`),
      paragraph([
        ref("def_primal_to_dual_edge_coefficient_transport"),
        " と、",
        ref("def_primal_dual_cell_correspondence"),
        " の全単射 ",
        math(String.raw`d_1:E_{\mathrm{cell}}\to E_{\mathrm{cell}}^\ast`),
        " による有限和の添字の付け替えから",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\partial_1^\ast\mathsf D_1(c)\bigr)(d_0(f))
&=
\sum_{e^\ast\in E_{\mathrm{cell}}^\ast}
(\partial_1^\ast)_{d_0(f),e^\ast}\mathsf D_1(c)(e^\ast)
\quad\bigl(\because\ \text{有限行列と係数写像の積}\bigr)\\
&=
\sum_{e\in E_{\mathrm{cell}}}
(\partial_1^\ast)_{d_0(f),d_1(e)}\mathsf D_1(c)(d_1(e))
\quad\bigl(\because\ d_1\text{ は全単射}\bigr)\\
&=
\sum_{e\in E_{\mathrm{cell}}}
(\partial_1^\ast)_{d_0(f),d_1(e)}c(e)
\quad\bigl(\because\ \mathsf D_1(c)(d_1(e))=c(e)\bigr).
\end{aligned}`),
      paragraph([ref("def_second_boundary_matrix_over_f2"), " と上で得た成分ごとの等式より"]),
      displayMath(String.raw`\begin{aligned}
\sum_{e\in E_{\mathrm{cell}}}
(\partial_1^\ast)_{d_0(f),d_1(e)}c(e)
&=
\sum_{e\in E_{\mathrm{cell}}}
(\partial_2)_{e,f}c(e)
\quad\bigl(\because\ (\partial_1^\ast)_{d_0(f),d_1(e)}=(\partial_2)_{e,f}\bigr).
\end{aligned}`),
      paragraph([ref("def_primal_first_cocycle_space_over_f2"), " より"]),
      displayMath(String.raw`\sum_{e\in E_{\mathrm{cell}}}
(\partial_2)_{e,f}c(e)
=
0_{\mathbb F_2}.`),
      paragraph([
        "全単射 ",
        math(String.raw`d_0:F_{\mathrm{cell}}\to V_{\mathrm{cell}}^\ast`),
        " により、全ての ",
        math(String.raw`v^\ast\in V_{\mathrm{cell}}^\ast`),
        " で ",
        math(String.raw`(\partial_1^\ast\mathsf D_1(c))(v^\ast)=0_{\mathbb F_2}`),
        " である。したがって ",
        math(String.raw`\mathsf D_1(c)\in\ker(\partial_1^\ast)`),
        " であり、主張を得る。全ての対象は有限集合または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_fourier_definition_primal_cocycle_to_dual_cycle_transport",
    kind: "definition",
    title: { text: "主一次コサイクルから双対一次サイクルへの係数移送写像" },
    labels: ["def_primal_cocycle_to_dual_cycle_transport"],
    habitat: "F2",
    verification: ["sagemath/check/primal-cocycle-to-dual-cycle-transport"],
    statement: [
      paragraph([
        ref("def_primal_first_cocycle_space_over_f2"),
        " の主一次コサイクル空間と、",
        ref("theorem_primal_cocycle_transport_is_dual_cycle"),
        " の双対一次サイクル空間を用いる。",
        ref("def_primal_to_dual_edge_coefficient_transport"),
        " の係数移送写像の始域を主一次コサイクル空間へ制限した写像を、始域、終域、作用を明示して",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathsf D_1^{\mathrm{coc}}:
\operatorname{Cocycle}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)
&\longrightarrow
\operatorname{Cycle}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2),\\
c
&\longmapsto
\mathsf D_1(c)
\end{aligned}`),
      paragraph([
        "で定める。任意の ",
        math(String.raw`c\in\operatorname{Cocycle}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)`),
        " に対して ",
        ref("theorem_primal_cocycle_transport_is_dual_cycle"),
        " より ",
        math(String.raw`\mathsf D_1(c)\in\operatorname{Cycle}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2)`),
        " なので、この終域をもつ写像は well-defined である。主一次コサイクル空間と双対一次サイクル空間を同一視せず、両者の移行には ",
        math(String.raw`\mathsf D_1^{\mathrm{coc}}`),
        " だけを用いる。この定義は第一ホモロジー類への作用をまだ定めない。全ての対象は有限集合または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_fourier_definition_primal_first_coboundary_space",
    kind: "definition",
    title: { text: "主一次余境界空間" },
    labels: ["def_primal_first_coboundary_space"],
    habitat: "F2",
    statement: [
      paragraph([ref("def_first_boundary_matrix_over_f2"), " の主一次境界行列と ", ref("def_primal_first_cocycle_space_over_f2"), " の主一次コサイクル空間に対し、主一次余境界空間を"]),
      displayMath(String.raw`\operatorname{Coboundary}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2):=\operatorname{im}(\partial_1^{\mathsf T})=\left\{\partial_1^{\mathsf T}a\ \middle|\ a\in\mathbb F_2^{V_{\mathrm{cell}}}\right\}`),
      paragraph(["と定める。", ref("theorem_boundary_of_boundary_is_zero_over_f2"), " の転置により、これは主一次コサイクル空間の部分空間である。"]),
    ],
  },
  {
    id: "finite_fourier_definition_dual_second_boundary_matrix",
    kind: "definition",
    title: { text: "双対二次境界行列" },
    labels: ["def_dual_second_boundary_matrix"],
    habitat: "F2",
    statement: [
      paragraph([ref("def_dual_face_boundary_word"), " の双対面境界語に対し、双対二次境界行列を"]),
      displayMath(String.raw`\partial_2^\ast:=\left[\sum_{\substack{c\in C_v\\\partial_{\mathrm{word}}^\ast d_2(v)(c)=(e^\ast,\omega)\text{ for some }\omega\in\mathsf{Ori}}}1_{\mathbb F_2}\right]_{e^\ast\in E_{\mathrm{cell}}^\ast,\ v\in V_{\mathrm{cell}}}`),
      paragraph(["と定める。行は双対辺 ", math(String.raw`e^\ast`), "、列は全単射 ", math(String.raw`d_2`), " で主頂点 ", math(String.raw`v\in V_{\mathrm{cell}}`), " に対応する双対面 ", math(String.raw`d_2(v)`), " で添字付けられる。"]),
    ],
  },
  {
    id: "finite_fourier_definition_dual_first_boundary_space",
    kind: "definition",
    title: { text: "双対一次境界空間" },
    labels: ["def_dual_first_boundary_space"],
    habitat: "F2",
    statement: [
      paragraph([ref("def_dual_second_boundary_matrix"), " の像を双対一次境界空間と呼び、"]),
      displayMath(String.raw`\operatorname{Boundary}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2):=\operatorname{im}(\partial_2^\ast)`),
      paragraph(["と定める。"]),
    ],
  },
  {
    id: "finite_fourier_theorem_primal_coboundary_transport_is_dual_boundary",
    kind: "theorem",
    title: { text: "主一次余境界の係数移送は双対面境界空間である" },
    labels: ["theorem_primal_coboundary_transport_is_dual_boundary"],
    habitat: "F2",
    verification: ["sagemath/check/primal-coboundary-transport-is-dual-boundary"],
    statement: [
      paragraph([
        ref("def_primal_first_coboundary_space"), " の主一次余境界空間、", ref("def_dual_first_boundary_space"), " の双対一次境界空間、および ", ref("def_primal_to_dual_edge_coefficient_transport"), " の係数移送を取る。このとき、",
      ]),
      displayMath(String.raw`\mathsf D_1\!\left(
  \operatorname{Coboundary}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)
\right)
=
\operatorname{Boundary}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2).`),
    ],
    proof: [
      paragraph([
        "任意の ",
        math(String.raw`a\in\mathbb F_2^{V_{\mathrm{cell}}}`),
        " に対して、",
        ref("theorem_boundary_of_boundary_is_zero_over_f2"),
        " より",
      ]),
      displayMath(String.raw`\begin{aligned}
\partial_2^{\mathsf T}\!\left(\partial_1^{\mathsf T}a\right)
&=
(\partial_1\partial_2)^{\mathsf T}a
\quad\bigl(\because\ \text{有限行列の積の転置}\bigr)\\
&=
0_{\mathbb F_2^{F_{\mathrm{cell}}}}
\quad\bigl(\because\ \partial_1\partial_2\text{ は零行列}\bigr).
\end{aligned}`),
      paragraph([
        ref("def_primal_first_cocycle_space_over_f2"),
        " より、主一次余境界空間は主一次コサイクル空間に含まれる。次に、",
        ref("def_primal_dual_cell_correspondence"),
        " の全単射 ",
        math(String.raw`d_2:V_{\mathrm{cell}}\to F_{\mathrm{cell}}^\ast`),
        " に沿う係数移送を、",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathsf D_2^\vee:
\mathbb F_2^{V_{\mathrm{cell}}}
&\longrightarrow
\mathbb F_2^{F_{\mathrm{cell}}^\ast},\\
a
&\longmapsto
\mathsf D_2^\vee(a),\\
\mathsf D_2^\vee(a)(f^\ast)
&:=
a\!\left(d_2^{-1}(f^\ast)\right)
\end{aligned}`),
      paragraph([
        "と書く。",
        ref("def_dual_face_boundary_word"),
        "、",
        ref("def_finite_cellulation_opposite_edge_occurrences"),
        "、",
        ref("def_finite_cellulation_vertex_links_are_cycles"),
        "、",
        ref("def_first_boundary_matrix_over_f2"),
        " により、任意の ",
        math(String.raw`v\in V_{\mathrm{cell}}`),
        " と ",
        math(String.raw`e\in E_{\mathrm{cell}}`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
(\partial_2^\ast)_{d_1(e),d_2(v)}
&=
\sum_{\substack{
  c\in C_v\\
  \partial_{\mathrm{word}}^\ast d_2(v)(c)
  =(d_1(e),\omega)\text{ for some }\omega\in\mathsf{Ori}
}}1_{\mathbb F_2}
\quad\bigl(\because\ \partial_2^\ast\text{ の定義}\bigr)\\
&=
\sum_{\substack{
  a_0\in\mathsf{End}\\
  \partial_G(e,a_0)=v
}}1_{\mathbb F_2}
\quad\bigl(\because\ \text{角の出発辺端と双対面境界語の対応}\bigr)\\
&=
(\partial_1)_{v,e}
\quad\bigl(\because\ \partial_1\text{ の定義}\bigr).
\end{aligned}`),
      paragraph([
        ref("def_primal_to_dual_edge_coefficient_transport"),
        " と全単射 ",
        math(String.raw`d_2`),
        " による有限和の添字の付け替えから、任意の ",
        math(String.raw`e\in E_{\mathrm{cell}}`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathsf D_1\!\left(\partial_1^{\mathsf T}a\right)(d_1(e))
&=
(\partial_1^{\mathsf T}a)(e)
\quad\bigl(\because\ \mathsf D_1\text{ の定義}\bigr)\\
&=
\sum_{v\in V_{\mathrm{cell}}}(\partial_1)_{v,e}a(v)
\quad\bigl(\because\ \text{転置行列と係数写像の積}\bigr)\\
&=
\sum_{v\in V_{\mathrm{cell}}}
(\partial_2^\ast)_{d_1(e),d_2(v)}
\mathsf D_2^\vee(a)(d_2(v))
\quad\bigl(\because\ (\partial_2^\ast)_{d_1(e),d_2(v)}=(\partial_1)_{v,e}\bigr)\\
&=
\sum_{f^\ast\in F_{\mathrm{cell}}^\ast}
(\partial_2^\ast)_{d_1(e),f^\ast}
\mathsf D_2^\vee(a)(f^\ast)
\quad\bigl(\because\ d_2\text{ は全単射}\bigr)\\
&=
\left(\partial_2^\ast\mathsf D_2^\vee(a)\right)(d_1(e))
\quad\bigl(\because\ \text{有限行列と係数写像の積}\bigr).
\end{aligned}`),
      paragraph([
        "全単射 ",
        math(String.raw`d_1:E_{\mathrm{cell}}\to E_{\mathrm{cell}}^\ast`),
        " により、",
        math(String.raw`\mathsf D_1(\partial_1^{\mathsf T}a)=\partial_2^\ast\mathsf D_2^\vee(a)`),
        " である。したがって",
      ]),
      displayMath(String.raw`\mathsf D_1\!\left(
  \operatorname{Coboundary}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)
\right)
\subseteq
\operatorname{Boundary}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2)
\quad\bigl(\because\ \text{像の定義}\bigr).`),
      paragraph([
        "逆に、任意の ",
        math(String.raw`b^\ast\in\mathbb F_2^{F_{\mathrm{cell}}^\ast}`),
        " に対し ",
        math(String.raw`a(v):=b^\ast(d_2(v))`),
        " と定める。任意の ",
        math(String.raw`f^\ast\in F_{\mathrm{cell}}^\ast`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathsf D_2^\vee(a)(f^\ast)
&=
a\!\left(d_2^{-1}(f^\ast)\right)
\quad\bigl(\because\ \mathsf D_2^\vee\text{ の定義}\bigr)\\
&=
b^\ast\!\left(d_2(d_2^{-1}(f^\ast))\right)
\quad\bigl(\because\ a(v)=b^\ast(d_2(v))\bigr)\\
&=
b^\ast(f^\ast)
\quad\bigl(\because\ d_2\text{ は全単射}\bigr).
\end{aligned}`),
      paragraph(["したがって"]),
      displayMath(String.raw`\begin{aligned}
\partial_2^\ast b^\ast
&=
\partial_2^\ast\mathsf D_2^\vee(a)
\quad\bigl(\because\ \mathsf D_2^\vee(a)=b^\ast\bigr)\\
&=
\mathsf D_1\!\left(\partial_1^{\mathsf T}a\right)
\quad\bigl(\because\ \text{上で得た係数移送の等式}\bigr).
\end{aligned}`),
      paragraph([
        "ゆえに双対面境界空間は移送後の主一次余境界空間に含まれる。二つの包含から主張の等式を得る。主頂点係数、主辺係数、双対面係数、双対辺係数を同一視せず、移行には ",
        math(String.raw`\partial_1^{\mathsf T}`),
        "、",
        math(String.raw`\mathsf D_2^\vee`),
        "、",
        math(String.raw`\mathsf D_1`),
        "、",
        math(String.raw`\partial_2^\ast`),
        " だけを用いる。全ての対象は有限集合または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_fourier_definition_primal_first_cohomology",
    kind: "definition",
    title: { text: "主第一コホモロジー" },
    labels: ["def_primal_first_cohomology"],
    habitat: "F2",
    statement: [
      paragraph([ref("def_primal_first_cocycle_space_over_f2"), " の主一次コサイクル空間を ", ref("def_primal_first_coboundary_space"), " の主一次余境界空間で割った有限剰余集合を"]),
      displayMath(String.raw`H^1(\mathcal C_{\mathrm{cell}};\mathbb F_2):=\left\{\left\{c+a\ \middle|\ a\in\operatorname{Coboundary}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)\right\}\ \middle|\ c\in\operatorname{Cocycle}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)\right\}`),
      paragraph(["と定める。"]),
    ],
  },
  {
    id: "finite_fourier_definition_dual_first_homology",
    kind: "definition",
    title: { text: "双対第一ホモロジー" },
    labels: ["def_dual_first_homology"],
    habitat: "F2",
    statement: [
      paragraph([ref("theorem_primal_cocycle_transport_is_dual_cycle"), " の双対一次サイクル空間と ", ref("def_dual_first_boundary_space"), " の双対一次境界空間を取る。", ref("theorem_primal_coboundary_transport_is_dual_boundary"), " により後者は前者に含まれる。その剰余集合を"]),
      displayMath(String.raw`H_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2):=\left\{\left\{z^\ast+b^\ast\ \middle|\ b^\ast\in\operatorname{Boundary}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2)\right\}\ \middle|\ z^\ast\in\operatorname{Cycle}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2)\right\}`),
      paragraph(["と定める。"]),
    ],
  },
  {
    id: "finite_fourier_definition_primal_cohomology_to_dual_homology_transport",
    kind: "definition",
    title: { text: "主第一コホモロジーから双対第一ホモロジーへの誘導写像" },
    labels: ["def_primal_cohomology_to_dual_homology_transport"],
    habitat: "F2",
    verification: ["sagemath/check/primal-cohomology-to-dual-homology-transport"],
    statement: [
      paragraph([
        ref("def_primal_first_cohomology"), " の主第一コホモロジーと ", ref("def_dual_first_homology"), " の双対第一ホモロジーを取る。",
        ref("theorem_primal_coboundary_transport_is_dual_boundary"),
        " と ",
        ref("theorem_primal_cocycle_transport_is_dual_cycle"),
        " により、双対面境界空間は双対一次サイクル空間に含まれる。",
        ref("def_primal_cocycle_to_dual_cycle_transport"),
        " の係数移送から誘導される写像を、始域、終域、作用を明示して",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline{\mathsf D}_1:
H^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)
&\longrightarrow
H_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2),\\
\left\{
  c+a
  \ \middle|\
  \ a\in\operatorname{Coboundary}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)
\right\}
&\longmapsto
\left\{
  \mathsf D_1(c)+b^\ast
  \ \middle|\
  \ b^\ast\in\operatorname{Boundary}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2)
\right\}
\end{aligned}`),
      paragraph([
        "で定める。ここで ",
        math(String.raw`c\in\operatorname{Cocycle}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)`),
        "、",
        math(String.raw`a\in\operatorname{Coboundary}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)`),
        "、",
        math(String.raw`z^\ast\in\operatorname{Cycle}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2)`),
        "、",
        math(String.raw`b^\ast\in\operatorname{Boundary}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2)`),
        " であり、加法はそれぞれの有限 ",
        math(String.raw`\mathbb F_2`),
        " ベクトル空間の加法である。",
      ]),
      paragraph([
        "この作用が主コサイクルの代表の選択に依存しないことを確かめる。二つの主一次コサイクル ",
        math(String.raw`c,c'\in\operatorname{Cocycle}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)`),
        " が同じ主第一コホモロジー類を表すとき、ある ",
        math(String.raw`a_0\in\operatorname{Coboundary}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)`),
        " が存在して ",
        math(String.raw`c'=c+a_0`),
        " である。任意の ",
        math(String.raw`e^\ast\in E_{\mathrm{cell}}^\ast`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathsf D_1(c')(e^\ast)
&=
\mathsf D_1(c+a_0)(e^\ast)
\quad\bigl(\because\ c'=c+a_0\bigr)\\
&=
(c+a_0)\!\left(d_1^{-1}(e^\ast)\right)
\quad\bigl(\because\ \mathsf D_1\text{ の定義}\bigr)\\
&=
c\!\left(d_1^{-1}(e^\ast)\right)
+a_0\!\left(d_1^{-1}(e^\ast)\right)
\quad\bigl(\because\ \mathbb F_2^{E_{\mathrm{cell}}}\text{ の成分ごとの加法}\bigr)\\
&=
\mathsf D_1(c)(e^\ast)+\mathsf D_1(a_0)(e^\ast)
\quad\bigl(\because\ \mathsf D_1\text{ の定義}\bigr).
\end{aligned}`),
      paragraph([
        ref("theorem_primal_coboundary_transport_is_dual_boundary"),
        " より ",
        math(String.raw`\mathsf D_1(a_0)\in\operatorname{Boundary}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2)`),
        " なので、",
      ]),
      displayMath(String.raw`\left\{
  \mathsf D_1(c')+b^\ast
  \ \middle|\
  \ b^\ast\in\operatorname{Boundary}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2)
\right\}
=
\left\{
  \mathsf D_1(c)+b^\ast
  \ \middle|\
  \ b^\ast\in\operatorname{Boundary}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2)
\right\}.`),
      paragraph([
        "したがって ",
        math(String.raw`\overline{\mathsf D}_1`),
        " は代表の選択に依存せず well-defined である。主一次コサイクル、主第一コホモロジー類、双対一次サイクル、双対第一ホモロジー類を同一視せず、移行には商集合と ",
        math(String.raw`\overline{\mathsf D}_1`),
        " だけを用いる。この定義は誘導写像が全単射であるとはまだ主張しない。全ての対象は有限集合または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_fourier_theorem_primal_cohomology_dual_homology_transport_is_bijective",
    kind: "theorem",
    standing: "mainTheorem",
    title: { text: "主第一コホモロジーから双対第一ホモロジーへの誘導写像は全単射である" },
    labels: ["theorem_primal_cohomology_dual_homology_transport_is_bijective"],
    habitat: "F2",
    verification: ["sagemath/check/primal-cohomology-dual-homology-transport-is-bijective"],
    statement: [
      paragraph([
        ref("def_primal_cohomology_to_dual_homology_transport"),
        " の誘導写像",
      ]),
      displayMath(String.raw`\overline{\mathsf D}_1:
H^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)
\longrightarrow
H_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2)`),
      paragraph(["は全単射である。"]),
    ],
    proof: [
      paragraph([
        ref("def_primal_dual_cell_correspondence"),
        " の全単射 ",
        math(String.raw`d_1:E_{\mathrm{cell}}\to E_{\mathrm{cell}}^\ast`),
        " に沿う逆向きの係数移送を、始域、終域、作用を明示して",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathsf D_1^{\leftarrow}:
\mathbb F_2^{E_{\mathrm{cell}}^\ast}
&\longrightarrow
\mathbb F_2^{E_{\mathrm{cell}}},\\
z^\ast
&\longmapsto
\mathsf D_1^{\leftarrow}(z^\ast),\\
\mathsf D_1^{\leftarrow}(z^\ast)(e)
&:=
z^\ast(d_1(e))
\qquad(e\in E_{\mathrm{cell}})
\end{aligned}`),
      paragraph([
        "と定める。任意の ",
        math(String.raw`z^\ast\in\operatorname{Cycle}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2)`),
        " と ",
        math(String.raw`f\in F_{\mathrm{cell}}`),
        " に対し、",
        ref("theorem_primal_cocycle_transport_is_dual_cycle"),
        " の証明で得た境界行列成分の等式と、全単射 ",
        math(String.raw`d_1`),
        " による有限和の添字の付け替えから",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\partial_2^{\mathsf T}\mathsf D_1^{\leftarrow}(z^\ast)\right)(f)
&=
\sum_{e\in E_{\mathrm{cell}}}
(\partial_2)_{e,f}\mathsf D_1^{\leftarrow}(z^\ast)(e)
\quad\bigl(\because\ \text{転置行列と係数写像の積}\bigr)\\
&=
\sum_{e\in E_{\mathrm{cell}}}
(\partial_2)_{e,f}z^\ast(d_1(e))
\quad\bigl(\because\ \mathsf D_1^{\leftarrow}\text{ の定義}\bigr)\\
&=
\sum_{e\in E_{\mathrm{cell}}}
(\partial_1^\ast)_{d_0(f),d_1(e)}z^\ast(d_1(e))
\quad\bigl(\because\ (\partial_2)_{e,f}=(\partial_1^\ast)_{d_0(f),d_1(e)}\bigr)\\
&=
\sum_{e^\ast\in E_{\mathrm{cell}}^\ast}
(\partial_1^\ast)_{d_0(f),e^\ast}z^\ast(e^\ast)
\quad\bigl(\because\ d_1\text{ は全単射}\bigr)\\
&=
(\partial_1^\ast z^\ast)(d_0(f))
\quad\bigl(\because\ \text{有限行列と係数写像の積}\bigr)\\
&=
0_{\mathbb F_2}
\quad\bigl(\because\ z^\ast\in\ker(\partial_1^\ast)\bigr).
\end{aligned}`),
      paragraph([
        ref("def_primal_first_cocycle_space_over_f2"),
        " より ",
        math(String.raw`\mathsf D_1^{\leftarrow}(z^\ast)\in\operatorname{Cocycle}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)`),
        " である。次に、任意の ",
        math(String.raw`b^\ast\in\operatorname{Boundary}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2)`),
        " を取る。",
        ref("theorem_primal_coboundary_transport_is_dual_boundary"),
        " より、ある ",
        math(String.raw`a\in\operatorname{Coboundary}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)`),
        " が存在して ",
        math(String.raw`b^\ast=\mathsf D_1(a)`),
        " である。任意の ",
        math(String.raw`e\in E_{\mathrm{cell}}`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathsf D_1^{\leftarrow}(b^\ast)(e)
&=
\mathsf D_1^{\leftarrow}(\mathsf D_1(a))(e)
\quad\bigl(\because\ b^\ast=\mathsf D_1(a)\bigr)\\
&=
\mathsf D_1(a)(d_1(e))
\quad\bigl(\because\ \mathsf D_1^{\leftarrow}\text{ の定義}\bigr)\\
&=
a\!\left(d_1^{-1}(d_1(e))\right)
\quad\bigl(\because\ \mathsf D_1\text{ の定義}\bigr)\\
&=
a(e)
\quad\bigl(\because\ d_1\text{ は全単射}\bigr).
\end{aligned}`),
      paragraph([
        "したがって ",
        math(String.raw`\mathsf D_1^{\leftarrow}(b^\ast)=a\in\operatorname{Coboundary}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)`),
        " である。さらに、任意の ",
        math(String.raw`z^\ast\in\operatorname{Cycle}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2)`),
        "、",
        math(String.raw`b^\ast\in\operatorname{Boundary}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2)`),
        "、",
        math(String.raw`e\in E_{\mathrm{cell}}`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathsf D_1^{\leftarrow}(z^\ast+b^\ast)(e)
&=
(z^\ast+b^\ast)(d_1(e))
\quad\bigl(\because\ \mathsf D_1^{\leftarrow}\text{ の定義}\bigr)\\
&=
z^\ast(d_1(e))+b^\ast(d_1(e))
\quad\bigl(\because\ \mathbb F_2^{E_{\mathrm{cell}}^\ast}\text{ の成分ごとの加法}\bigr)\\
&=
\mathsf D_1^{\leftarrow}(z^\ast)(e)
+\mathsf D_1^{\leftarrow}(b^\ast)(e)
\quad\bigl(\because\ \mathsf D_1^{\leftarrow}\text{ の定義}\bigr).
\end{aligned}`),
      paragraph([
        "ゆえに逆向きの係数移送は双対第一ホモロジー類の代表の変更を主第一コホモロジー類の代表の変更へ移すので、商上の写像",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline{\mathsf D}_1^{\leftarrow}:
H_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2)
&\longrightarrow
H^1(\mathcal C_{\mathrm{cell}};\mathbb F_2),\\
\left\{
  z^\ast+b^\ast
  \ \middle|\
  \ b^\ast\in\operatorname{Boundary}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2)
\right\}
&\longmapsto
\left\{
  \mathsf D_1^{\leftarrow}(z^\ast)+a
  \ \middle|\
  \ a\in\operatorname{Coboundary}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)
\right\}
\end{aligned}`),
      paragraph(["は well-defined である。任意の ", math(String.raw`c\in\operatorname{Cocycle}^1(\mathcal C_{\mathrm{cell}};\mathbb F_2)`), " と ", math(String.raw`e\in E_{\mathrm{cell}}`), " に対して"]),
      displayMath(String.raw`\begin{aligned}
\mathsf D_1^{\leftarrow}(\mathsf D_1(c))(e)
&=
\mathsf D_1(c)(d_1(e))
\quad\bigl(\because\ \mathsf D_1^{\leftarrow}\text{ の定義}\bigr)\\
&=
c\!\left(d_1^{-1}(d_1(e))\right)
\quad\bigl(\because\ \mathsf D_1\text{ の定義}\bigr)\\
&=
c(e)
\quad\bigl(\because\ d_1\text{ は全単射}\bigr).
\end{aligned}`),
      paragraph(["また、任意の ", math(String.raw`z^\ast\in\operatorname{Cycle}_1(\mathcal C_{\mathrm{cell}}^\ast;\mathbb F_2)`), " と ", math(String.raw`e^\ast\in E_{\mathrm{cell}}^\ast`), " に対して"]),
      displayMath(String.raw`\begin{aligned}
\mathsf D_1(\mathsf D_1^{\leftarrow}(z^\ast))(e^\ast)
&=
\mathsf D_1^{\leftarrow}(z^\ast)(d_1^{-1}(e^\ast))
\quad\bigl(\because\ \mathsf D_1\text{ の定義}\bigr)\\
&=
z^\ast\!\left(d_1(d_1^{-1}(e^\ast))\right)
\quad\bigl(\because\ \mathsf D_1^{\leftarrow}\text{ の定義}\bigr)\\
&=
z^\ast(e^\ast)
\quad\bigl(\because\ d_1\text{ は全単射}\bigr).
\end{aligned}`),
      paragraph([
        "したがって商上で ",
        math(String.raw`\overline{\mathsf D}_1^{\leftarrow}\circ\overline{\mathsf D}_1`),
        " と ",
        math(String.raw`\overline{\mathsf D}_1\circ\overline{\mathsf D}_1^{\leftarrow}`),
        " はそれぞれの恒等写像である。ゆえに ",
        math(String.raw`\overline{\mathsf D}_1`),
        " は全単射である。全ての対象は有限集合または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
]);
