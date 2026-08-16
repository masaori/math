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
]);
