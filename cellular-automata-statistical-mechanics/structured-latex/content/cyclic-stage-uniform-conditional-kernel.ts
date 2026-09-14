/**
 * 奇数位数の有限巡回舞台で、有限窓の外側を固定して窓内だけを一様に再標本化する
 * 有理遷移核を定義し、一様分布がその作用で不変であることを示す。
 * これは有限集合上の有限 DLR 型等式であり、無限舞台の Gibbs 仕様は主張しない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "cyclic_stage_uniform_conditional_kernel_definition_window_image",
    kind: "definition",
    title: { text: "有限巡回舞台内の有限窓の像" },
    labels: ["def_cyclic_stage_window_image"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_cyclic_stage_uniform_distribution_family"),
        " の ",
        math(String.raw`m,s\in\mathbb N`),
        "、",
        math(String.raw`s\le m`),
        " を固定する。有限窓の像を ",
        math(String.raw`W_{m,s}:=j_{m,s}(D_s)\subseteq V_m`),
        " と置く。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_uniform_conditional_kernel_claim_window_image_cardinality",
    kind: "claim",
    title: { text: "有限巡回舞台内の有限窓の像の元数" },
    labels: ["claim_cyclic_stage_window_image_cardinality"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_cyclic_stage_window_image"),
        " の任意の ",
        math(String.raw`m,s\in\mathbb N`),
        "、",
        math(String.raw`s\le m`),
        " について",
      ]),
      displayMath(String.raw`|W_{m,s}|=2s+1`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
|W_{m,s}|
&=|D_s|
  \quad(\because\ j_{m,s}\text{ は単射})\\
&=2s+1
  \quad(\because\ \blkref{def_integer_offset_interval}).
\end{aligned}`),
    ],
  },
  {
    id: "cyclic_stage_uniform_conditional_kernel_definition_outside_agreement",
    kind: "definition",
    title: { text: "有限窓の外側で一致する配位" },
    labels: ["def_cyclic_stage_outside_agreement"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_cyclic_stage_window_image"),
        " の配位 ",
        math(String.raw`x,y\in A^{V_m}`),
        " が窓の外側で一致することを",
      ]),
      displayMath(String.raw`x\equiv_{m,s}^{\mathrm{out}}y
\quad:\Longleftrightarrow\quad
\forall v\in V_m\setminus W_{m,s},\ x(v)=y(v)`),
      paragraph(["と定める。"]),
    ],
  },
  {
    id: "cyclic_stage_uniform_conditional_kernel_definition",
    kind: "definition",
    title: { text: "有限窓内の一様条件付き再標本化核" },
    labels: ["def_cyclic_stage_uniform_conditional_kernel"],
    habitat: "Q",
    statement: [
      paragraph([
        ref("def_cyclic_stage_outside_agreement"),
        " を用いる。任意の ",
        math(String.raw`x,y\in A^{V_m}`),
        " に対し",
      ]),
      displayMath(String.raw`K_{m,s}(x,y):=
\begin{cases}
\dfrac{1}{2^{2s+1}},&x\equiv_{m,s}^{\mathrm{out}}y,\\
0,&x\not\equiv_{m,s}^{\mathrm{out}}y
\end{cases}
\in\mathbb Q_{\ge0}`),
      paragraph([
        "と定める。",
        math(String.raw`2^{2s+1}\in\mathbb N_{>0}`),
        " なので除算は有理数内で定義される。この核は外側の値を固定し、像 ",
        math(String.raw`W_{m,s}`),
        " 上の二元状態だけを一様に選び直す。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_uniform_conditional_kernel_claim_normalized",
    kind: "claim",
    title: { text: "有限窓内の一様条件付き再標本化核は正規化される" },
    labels: ["claim_cyclic_stage_uniform_conditional_kernel_normalized"],
    habitat: "Q",
    statement: [
      paragraph([
        ref("def_cyclic_stage_uniform_conditional_kernel"),
        " の任意の ",
        math(String.raw`m,s\in\mathbb N`),
        "、",
        math(String.raw`s\le m`),
        " と任意の ",
        math(String.raw`x\in A^{V_m}`),
        " について",
      ]),
      displayMath(String.raw`\sum_{y\in A^{V_m}}K_{m,s}(x,y)=1`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        ref("claim_cyclic_stage_window_image_cardinality"),
        " により ",
        math(String.raw`|W_{m,s}|=2s+1`),
        " である。外側を ",
        math(String.raw`x`),
        " と同じ値に固定した配位は、",
        math(String.raw`W_{m,s}`),
        " の各セルへ二状態を独立に選ぶことで尽くされるので",
      ]),
      displayMath(String.raw`\begin{aligned}
\left|\{y\in A^{V_m}:x\equiv_{m,s}^{\mathrm{out}}y\}\right|
&=|A|^{|W_{m,s}|}
  \quad(\because\ \blkref{def_cyclic_stage_outside_agreement})\\
&=2^{|W_{m,s}|}
  \quad(\because\ \blkref{def_state_set})\\
&=2^{2s+1}
  \quad(\because\ \blkref{claim_cyclic_stage_window_image_cardinality}).
\end{aligned}`),
      paragraph([ref("def_cyclic_stage_uniform_conditional_kernel"), " とこの元数から"]),
      displayMath(String.raw`\begin{aligned}
\sum_{y\in A^{V_m}}K_{m,s}(x,y)
&=2^{2s+1}\frac{1}{2^{2s+1}}
  \quad(\because\ \blkref{def_cyclic_stage_uniform_conditional_kernel})\\
&=1
  \quad(\because\ 2^{2s+1}\in\mathbb N_{>0}).
\end{aligned}`),
    ],
  },
  {
    id: "cyclic_stage_uniform_conditional_kernel_theorem_invariance",
    kind: "theorem",
    title: { text: "一様有限舞台分布は条件付き再標本化核の作用で不変である" },
    labels: ["theorem_cyclic_stage_uniform_conditional_kernel_invariance"],
    habitat: "Q",
    statement: [
      paragraph([
        ref("def_cyclic_stage_uniform_distribution_family"),
        " と ",
        ref("def_cyclic_stage_uniform_conditional_kernel"),
        " の任意の ",
        math(String.raw`m,s\in\mathbb N`),
        "、",
        math(String.raw`s\le m`),
        " と任意の ",
        math(String.raw`y\in A^{V_m}`),
        " について",
      ]),
      displayMath(String.raw`\sum_{x\in A^{V_m}}\nu_m(x)K_{m,s}(x,y)=\nu_m(y)`),
      paragraph([
        "が成り立つ。これは窓外を条件として窓内を再標本化する有限核に対する固定点等式である。無限舞台の全配位、",
        "Gibbs 仕様、条件付き期待値、ほとんど至る所の等号、極限、実数体、複素数体を使わない。従って無限体積 Gibbs 測度との対応または近似は主張しない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_cyclic_stage_uniform_conditional_kernel_normalized"),
        " の証明と同じ有限個数計算を、固定した ",
        math(String.raw`y`),
        " に対して使うと",
      ]),
      displayMath(String.raw`\begin{aligned}
\left|\{x\in A^{V_m}:x\equiv_{m,s}^{\mathrm{out}}y\}\right|
&=|A|^{|W_{m,s}|}
  \quad(\because\ \blkref{def_cyclic_stage_outside_agreement})\\
&=2^{|W_{m,s}|}
  \quad(\because\ \blkref{def_state_set})\\
&=2^{2s+1}
  \quad(\because\ \blkref{claim_cyclic_stage_window_image_cardinality}).
\end{aligned}`),
      paragraph(["である。従って"]),
      displayMath(String.raw`\begin{aligned}
\sum_{x\in A^{V_m}}\nu_m(x)K_{m,s}(x,y)
&=2^{2s+1}\frac{1}{2^{2m+1}}\frac{1}{2^{2s+1}}
  \quad(\because\ \blkref{def_cyclic_stage_uniform_distribution_family},\ \blkref{def_cyclic_stage_uniform_conditional_kernel})\\
&=\frac{1}{2^{2m+1}}
  \quad(\because\ 2^{2s+1}\in\mathbb N_{>0})\\
&=\nu_m(y)
  \quad(\because\ \blkref{def_cyclic_stage_uniform_distribution_family}).
\end{aligned}`),
    ],
  },
]);
