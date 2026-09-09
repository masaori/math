/**
 * 奇数位数の有限巡回舞台、有限整数窓からの単射、一様有理分布を具体化し、
 * 有限窓周辺分布が窓の包含に沿って整合することを示す。
 * 有限集合・自然数・有理数だけを使い、極限と実数体・複素数体は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "cyclic_stage_uniform_marginals_definition_family",
    kind: "definition",
    title: { text: "奇数位数の有限巡回舞台と一様有理分布" },
    labels: ["def_cyclic_stage_uniform_distribution_family"],
    habitat: "Q",
    statement: [
      paragraph([
        ref("def_cyclic_stage_family"),
        " と ",
        ref("def_integer_offset_interval"),
        " を用いる。各 ",
        math(String.raw`m\in\mathbb N`),
        " に対して ",
        math(String.raw`L_m:=2m+1\in\mathbb N_{>0}`),
        "、有限舞台 ",
        math(String.raw`V_m:=C_{L_m}`),
        " と置く。各 ",
        math(String.raw`s\in\mathbb N`),
        "、",
        math(String.raw`s\le m`),
        " に対し、有限窓埋め込みを",
      ]),
      displayMath(String.raw`j_{m,s}:D_s\longrightarrow V_m,\qquad
j_{m,s}(z):=\pi_{L_m}(z)`),
      paragraph([
        "と定める。",
        math(String.raw`L_m=2m+1\ge2s+1`),
        " なので ",
        ref("claim_cyclic_offset_injective_boundary"),
        " により ",
        math(String.raw`j_{m,s}`),
        " は単射である。この単射に沿う引き戻しを",
      ]),
      displayMath(String.raw`r_{m,s}:A^{V_m}\longrightarrow A^{D_s},\qquad
r_{m,s}(x):=x\circ j_{m,s}`),
      paragraph([
        "と定める。また有限配位集合 ",
        math(String.raw`A^{V_m}`),
        " 上の一様有理分布を",
      ]),
      displayMath(String.raw`\nu_m:A^{V_m}\longrightarrow\mathbb Q_{\ge0},\qquad
\nu_m(x):=\frac{1}{2^{L_m}}`),
      paragraph([
        "と定め、その有限窓周辺分布を",
      ]),
      displayMath(String.raw`\nu_{m,s}(a):=
\sum_{x\in A^{V_m}:\ r_{m,s}(x)=a}\nu_m(x)
\in\mathbb Q_{\ge0}\qquad(a\in A^{D_s})`),
      paragraph([
        "と定める。",
        math(String.raw`2^{L_m}\in\mathbb N_{>0}`),
        " なので除算は有理数内で定義される。全ての和は有限和であり、極限、対数、実数体、複素数体を使わない。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_uniform_marginals_claim_normalized",
    kind: "claim",
    title: { text: "有限巡回舞台の一様有理重みは確率分布である" },
    labels: ["claim_cyclic_stage_uniform_distribution_normalized"],
    habitat: "Q",
    statement: [
      paragraph([ref("def_cyclic_stage_uniform_distribution_family"), " の任意の ", math(String.raw`m\in\mathbb N`), " について"]),
      displayMath(String.raw`\sum_{x\in A^{V_m}}\nu_m(x)=1`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([ref("def_state_set"), " と ", ref("def_cyclic_stage_family"), " から ", math(String.raw`|A^{V_m}|=2^{L_m}`), " である。従って"]),
      displayMath(String.raw`\begin{aligned}
\sum_{x\in A^{V_m}}\nu_m(x)
&=2^{L_m}\frac{1}{2^{L_m}}
  \quad(\because\ \blkref{def_cyclic_stage_uniform_distribution_family})\\
&=1
  \quad(\because\ 2^{L_m}\in\mathbb N_{>0}).
\end{aligned}`),
    ],
  },
  {
    id: "cyclic_stage_uniform_marginals_claim_embedding_compatibility",
    kind: "claim",
    title: { text: "有限窓埋め込みは窓の包含に沿って整合する" },
    labels: ["claim_cyclic_stage_window_embeddings_compatible"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_cyclic_stage_uniform_distribution_family"),
        " の任意の ",
        math(String.raw`s,t,m\in\mathbb N`),
        "、",
        math(String.raw`s\le t\le m`),
        " について、",
      ]),
      displayMath(String.raw`j_{m,s}=j_{m,t}|_{D_s}`),
      paragraph([
        "が成り立つ。従って任意の ",
        math(String.raw`x\in A^{V_m}`),
        " について",
      ]),
      displayMath(String.raw`r_{m,s}(x)=r_{m,t}(x)|_{D_s}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`s\le t`),
        " から ",
        math(String.raw`D_s\subseteq D_t`),
        " である。任意の ",
        math(String.raw`z\in D_s`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
j_{m,t}|_{D_s}(z)
&=j_{m,t}(z)
  \quad(\because\ \text{写像の制限の定義})\\
&=\pi_{L_m}(z)
  \quad(\because\ \blkref{def_cyclic_stage_uniform_distribution_family})\\
&=j_{m,s}(z)
  \quad(\because\ \blkref{def_cyclic_stage_uniform_distribution_family}).
\end{aligned}`),
      paragraph(["写像の外延性により最初の等号が従う。さらに任意の ", math(String.raw`z\in D_s`), " について"]),
      displayMath(String.raw`\begin{aligned}
r_{m,t}(x)|_{D_s}(z)
&=x\bigl(j_{m,t}|_{D_s}(z)\bigr)
  \quad(\because\ \blkref{def_cyclic_stage_uniform_distribution_family})\\
&=x\bigl(j_{m,s}(z)\bigr)
  \quad(\because\ \blkref{claim_cyclic_stage_window_embeddings_compatible})\\
&=r_{m,s}(x)(z)
  \quad(\because\ \blkref{def_cyclic_stage_uniform_distribution_family}).
\end{aligned}`),
      paragraph(["写像の外延性により二番目の等号が従う。"]),
    ],
  },
  {
    id: "cyclic_stage_uniform_marginals_claim_formula",
    kind: "claim",
    title: { text: "一様分布の有限窓周辺確率は舞台の大きさに依らない" },
    labels: ["claim_cyclic_stage_uniform_marginal_formula"],
    habitat: "Q",
    statement: [
      paragraph([
        ref("def_cyclic_stage_uniform_distribution_family"),
        " の任意の ",
        math(String.raw`s,m\in\mathbb N`),
        "、",
        math(String.raw`s\le m`),
        " と任意の ",
        math(String.raw`a\in A^{D_s}`),
        " について",
      ]),
      displayMath(String.raw`\nu_{m,s}(a)=\frac{1}{2^{2s+1}}\in\mathbb Q_{>0}`),
      paragraph(["が成り立つ。従って各固定有限窓では有理周辺確率が最初から完全に安定する。"]),
    ],
    proof: [
      paragraph([
        ref("def_state_set"),
        " から ",
        math(String.raw`|A|=2`),
        " である。",
        ref("def_integer_offset_interval"),
        " から ",
        math(String.raw`|D_s|=2s+1`),
        " であり、",
        ref("def_cyclic_stage_family"),
        " から ",
        math(String.raw`|V_m|=L_m=2m+1`),
        " である。単射 ",
        math(String.raw`j_{m,s}`),
        " の像上で値を ",
        math(String.raw`a`),
        " に固定した配位は、補集合の各セルへ二状態を独立に選ぶことで尽くされる。従って繊維の元数は",
      ]),
      displayMath(String.raw`\begin{aligned}
\left|\{x\in A^{V_m}:r_{m,s}(x)=a\}\right|
&=2^{|V_m|-|D_s|}
  \quad(\because\ j_{m,s}\text{ は単射})\\
&=2^{(2m+1)-(2s+1)}
  \quad(\because\ |V_m|=2m+1,\ |D_s|=2s+1)\\
&=2^{2(m-s)}
  \quad(\because\ \mathbb N\text{ の減法と分配律}).
\end{aligned}`),
      paragraph([ref("def_cyclic_stage_uniform_distribution_family"), " とこの繊維の元数から"]),
      displayMath(String.raw`\begin{aligned}
\nu_{m,s}(a)
&=2^{2(m-s)}\frac{1}{2^{2m+1}}
  \quad(\because\ \blkref{def_cyclic_stage_uniform_distribution_family})\\
&=\frac{1}{2^{2s+1}}
  \quad(\because\ 2^{2m+1}=2^{2(m-s)}2^{2s+1}).
\end{aligned}`),
      paragraph([math(String.raw`2^{2s+1}\in\mathbb N_{>0}`), " なので値は正の有理数である。"]),
    ],
  },
  {
    id: "cyclic_stage_uniform_marginals_theorem_consistency",
    kind: "theorem",
    title: { text: "一様有限窓周辺分布は周辺化について整合する" },
    labels: ["theorem_cyclic_stage_uniform_marginals_consistent"],
    habitat: "Q",
    statement: [
      paragraph([
        ref("def_cyclic_stage_uniform_distribution_family"),
        " の任意の ",
        math(String.raw`s,t,m\in\mathbb N`),
        "、",
        math(String.raw`s\le t\le m`),
        " と任意の ",
        math(String.raw`a\in A^{D_s}`),
        " について",
      ]),
      displayMath(String.raw`\nu_{m,s}(a)=
\sum_{c\in A^{D_t}:\ c|_{D_s}=a}\nu_{m,t}(c)`),
      paragraph(["が成り立つ。この等号は有限集合上の有理数の有限和だけで決まり、無限舞台の全配位、極限、Gibbs 仕様、実数体、複素数体を使わない。"]),
    ],
    proof: [
      paragraph([
        "固定した ",
        math(String.raw`a\in A^{D_s}`),
        " を ",
        math(String.raw`D_t`),
        " へ延長する配位の個数は、",
        math(String.raw`D_t\setminus D_s`),
        " の各セルへ二状態を独立に選ぶ個数なので",
      ]),
      displayMath(String.raw`\begin{aligned}
\left|\{c\in A^{D_t}:c|_{D_s}=a\}\right|
&=2^{|D_t|-|D_s|}
  \quad(\because\ D_s\subseteq D_t)\\
&=2^{(2t+1)-(2s+1)}
  \quad(\because\ |D_t|=2t+1,\ |D_s|=2s+1)\\
&=2^{2(t-s)}
  \quad(\because\ \mathbb N\text{ の減法と分配律}).
\end{aligned}`),
      paragraph([ref("claim_cyclic_stage_uniform_marginal_formula"), " を各延長へ適用すると"]),
      displayMath(String.raw`\begin{aligned}
\sum_{c\in A^{D_t}:\ c|_{D_s}=a}\nu_{m,t}(c)
&=2^{2(t-s)}\frac{1}{2^{2t+1}}
  \quad(\because\ \blkref{claim_cyclic_stage_uniform_marginal_formula})\\
&=\frac{1}{2^{2s+1}}
  \quad(\because\ 2^{2t+1}=2^{2(t-s)}2^{2s+1})\\
&=\nu_{m,s}(a)
  \quad(\because\ \blkref{claim_cyclic_stage_uniform_marginal_formula}).
\end{aligned}`),
    ],
  },
]);
