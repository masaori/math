import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
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
        " である。有限次元ベクトル空間の基底延長定理により、",
        math(String.raw`x`),
        " を含む ",
        math(String.raw`H`),
        " の基底を選ぶ。その基底上で ",
        math(String.raw`x`),
        " を ",
        math(String.raw`1_{\mathbb F_2}`),
        " へ送り、残りの基底元を ",
        math(String.raw`0_{\mathbb F_2}`),
        " へ送る線形写像を ",
        math(String.raw`\psi\in H^\vee`),
        " とする。このとき ",
        math(String.raw`\psi(x)=1_{\mathbb F_2}`),
        " である。写像 ",
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
    id: "finite_fourier_theorem_inverse_transform",
    kind: "theorem",
    title: { text: "有限第一ホモロジー群上の Fourier 逆変換" },
    labels: ["theorem_finite_fourier_inverse_transform"],
    habitat: "QPolynomial",
    verification: ["sagemath/check/finite-fourier-inverse-transform"],
    statement: [
      paragraph([
        ref("def_f2_linear_character_space"),
        " の有限第一ホモロジー群 ",
        math(String.raw`H`),
        " と文字空間 ",
        math(String.raw`H^\vee`),
        " に対し、独立な不定元 ",
        math(String.raw`u,v`),
        " を取る。任意の多項式族 ",
        math(String.raw`A=(A_k)_{k\in H}\in\bigl(\mathbb Z[u,v]\bigr)^H`),
        " の有限 Fourier 変換を、始域と終域を明示した写像",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathcal F_H:\bigl(\mathbb Z[u,v]\bigr)^H
&\longrightarrow
\bigl(\mathbb Z[u,v]\bigr)^{H^\vee},\\
A
&\longmapsto
\widehat A:=\mathcal F_H(A),\\
\widehat A_{\varphi}
&:=
\sum_{k\in H}
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(k)A_k
\in\mathbb Z[u,v]
\qquad(\varphi\in H^\vee)
\end{aligned}`),
      paragraph([
        "で定める。また、",
        math(String.raw`\jmath:\mathbb Z[u,v]\to\mathbb Q[u,v]`),
        " を整数係数を有理係数へ送る係数ごとの標準単射、",
        math(String.raw`\iota_{\mathbb N,\mathbb Q}:\mathbb N\to\mathbb Q`),
        " を ",
        math(String.raw`n\mapsto n/1`),
        " で与えられる標準単射とする。このとき、任意の ",
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
      ]),
      paragraph(["有限 Fourier 変換の定義より"]),
      displayMath(String.raw`\begin{aligned}
\frac{1}{n}
\sum_{\varphi\in H^\vee}
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h)
\jmath\!\left(\widehat A_{\varphi}\right)
&=
\frac{1}{n}
\sum_{\varphi\in H^\vee}
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h)
\jmath\!\left(
  \sum_{k\in H}
  \bigl(\operatorname{sgn}_H(\varphi)\bigr)(k)A_k
\right)
\quad\bigl(\because\ \widehat A_{\varphi}\text{ の定義}\bigr)\\
&=
\frac{1}{n}
\sum_{\varphi\in H^\vee}
\sum_{k\in H}
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(h)
\bigl(\operatorname{sgn}_H(\varphi)\bigr)(k)
\jmath(A_k)
\quad\bigl(\because\ \jmath\text{ は環準同型}\bigr)\\
&=
\frac{1}{n}
\sum_{k\in H}
\left(
  \sum_{\varphi\in H^\vee}
  \bigl(\operatorname{sgn}_H(\varphi)\bigr)(h)
  \bigl(\operatorname{sgn}_H(\varphi)\bigr)(k)
\right)
\jmath(A_k)
\quad\bigl(\because\ H,H^\vee\text{ 上の有限和の交換}\bigr).
\end{aligned}`),
      paragraph([ref("theorem_finite_character_orthogonality"), " より"]),
      displayMath(String.raw`\begin{aligned}
\frac{1}{n}
\sum_{k\in H}
\left(
  \sum_{\varphi\in H^\vee}
  \bigl(\operatorname{sgn}_H(\varphi)\bigr)(h)
  \bigl(\operatorname{sgn}_H(\varphi)\bigr)(k)
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
\quad\bigl(\because\ n\in\mathbb Q_{>0}\text{ と }n^{-1}n=1\bigr).
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
]);
