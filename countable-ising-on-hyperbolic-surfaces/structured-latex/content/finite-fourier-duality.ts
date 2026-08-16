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
]);
