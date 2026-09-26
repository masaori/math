import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/013_even_sector_modes.ts";

export default defineBlocks([
  {
    id: "heading_even_sector_modes",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { text: "偶セクターの半整数運動量モード" },
    labels: [],
  },

  {
    id: "evensector_000_remark_overview",
    kind: "remark",
    origin: { path: SRC, ordinal: 2 },
    title: { text: "この章の目的" },
    labels: [],
    statement: [
      paragraph([
        "偶セクターの生成子 ",
        math(String.raw`H_1^{(+)}`),
        "（",
        ref("def_H1_pm"),
        " で上の符号を取ったもの）は",
      ]),
      displayMath(
        String.raw`H_1^{(+)} = \sum_{m=1}^{M-1} Y_mZ_{m+1} - Y_MZ_1`,
      ),
      paragraph([
        "であり、サイト ",
        math(String.raw`M`),
        " とサイト ",
        math(String.raw`1`),
        " をつなぐ境界項 ",
        math(String.raw`-Y_MZ_1`),
        " だけが符号 ",
        math(String.raw`-1`),
        " を持つ（反周期的な境界条件）。この章では、この符号に合わせた Fourier モード",
      ]),
      displayMath(
        String.raw`\check{Z}_\mu := \sum_{j=1}^{M} Z_j\,e^{-i j\tilde\theta_\mu},\qquad
\check{Y}_\mu := \sum_{j=1}^{M} Y_j\,e^{-i j\tilde\theta_\mu},\qquad
\tilde\theta_\mu := \frac{2\pi\left(\mu - \tfrac{1}{2}\right)}{M}`,
      ),
      paragraph([
        "を導入する（正確な定義は ",
        ref("def_half_integer_checkZ"),
        " と ",
        ref("def_half_integer_checkY"),
        "）。",
      ]),
      paragraph([
        "働く仕組みは 1 つの等式 ",
        math(String.raw`e^{-iM\tilde\theta_\mu} = -1`),
        "（",
        ref("half_integer_phase_antiperiodicity"),
        "、**反周期性**）に集約される。",
        math(String.raw`H_1^{(+)}`),
        " と ",
        math(String.raw`Z_j`),
        " の交換子は隣のサイトの ",
        math(String.raw`Y_{j-1}`),
        " を与えるが、",
        math(String.raw`j = 1`),
        " では添字がサイト ",
        math(String.raw`M`),
        " へ回り込み、境界項の符号のために ",
        math(String.raw`-Y_M`),
        " が現れる。一方、位相 ",
        math(String.raw`e^{-ij\tilde\theta_\mu}`),
        " は添字 ",
        math(String.raw`j = 0`),
        " を ",
        math(String.raw`j = M`),
        " へ読み替えるときにちょうど ",
        math(String.raw`e^{-iM\tilde\theta_\mu} = -1`),
        " 倍になる。この 2 つの符号が打ち消し合うので、",
        math(String.raw`H_1^{(+)}`),
        " との交換関係が ",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " の中で閉じる。",
      ]),
      paragraph(["この章で示すのは次のことである。"]),
      list([
        [
          "半整数運動量の添字集合 ",
          math(String.raw`\check{\mathcal{M}} = \{1,\dots,M\}`),
          " とその共役添字 ",
          math(String.raw`M+1-\mu`),
          "（",
          ref("def_check_index_set"),
          "、",
          ref("conjugate_index_of_check_Z_Y"),
          "）。",
        ],
        [
          math(String.raw`H_1^{(+)}, H_2`),
          " と ",
          math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
          " の交換関係（",
          ref("commutator_of_H_and_check_Z_Y"),
          "）。",
        ],
        [
          math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
          " の反交換関係（",
          ref("anticommutator_of_check_Z_Y"),
          "）。",
        ],
        [
          math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
          " から ",
          math(String.raw`Z_j, Y_j`),
          " を復元する式（",
          ref("recover_Z_Y_from_check_Z_Y"),
          "）。",
        ],
        [
          math(String.raw`H_1^{(+)}, H_2`),
          " を ",
          math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
          " で表す式（",
          ref("H1_H2_via_check_Z_Y"),
          "）。",
        ],
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },

  {
    id: "evensector_002_claim_antiperiodic_exp_sum",
    kind: "claim",
    origin: { path: SRC, ordinal: 4 },
    title: { text: "半整数運動量の指数和" },
    labels: ["antiperiodic_exp_sum"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とする。自然数を整数へ送る標準包含 ",
        math(String.raw`\iota_{\mathbb N\to\mathbb Z}:\mathbb N\to\mathbb Z`),
        " と整数を実数へ送る標準包含 ",
        math(String.raw`\iota_{\mathbb Z\to\mathbb R}:\mathbb Z\to\mathbb R`),
        " は零、単位元、和、積、順序を保つものとする。また、",
        ref("inclusion_rr_to_cc"),
        " の実数から複素数への包含を用いる。",
      ]),
      displayMath(
        String.raw`n_{\mathbb Z}:=\iota_{\mathbb N\to\mathbb Z}(n)\quad(n\in\mathbb N),
\qquad a_{\mathbb R}:=\iota_{\mathbb Z\to\mathbb R}(a)\quad(a\in\mathbb Z),
\qquad n_{\mathbb R}:=(n_{\mathbb Z})_{\mathbb R},
\qquad a_{\mathbb C}:=(a_{\mathbb R})_{\mathbb C},
\qquad n_{\mathbb C}:=(n_{\mathbb R})_{\mathbb C}`,
      ),
      paragraph([
        "と書く。",
        math(String.raw`M\ge2`),
        " なので、",
        math(String.raw`(M_{\mathbb N})_{\mathbb Z}=M`),
        " を満たす一意な ",
        math(String.raw`M_{\mathbb N}\in\mathbb N_{\ge2}`),
        " がある。有限和の項数と周期デルタの法には ",
        math(String.raw`M_{\mathbb N}`),
        " を用いる。",
      ]),
      paragraph([
        "順序を保つ包含写像により ",
        math(String.raw`M_{\mathbb R}\ge2_{\mathbb R}>0_{\mathbb R}`),
        " である。したがって ",
        math(String.raw`M_{\mathbb R}\ne0_{\mathbb R}`),
        " であり、さらに実数の零因子がないことから ",
        math(String.raw`2M_{\mathbb R}\ne0_{\mathbb R}`),
        " である。以下の分数はこの二つの非零性により定まる。",
      ]),
      paragraph([
        "さらに、",
        math(String.raw`\pi\in\mathbb R`),
        " を円周率、",
        math(String.raw`i:=(0_{\mathbb R},1_{\mathbb R})\in\mathbb C`),
        " を虚数単位とする。複素数の差、零元、単位元、逆元には ",
        ref("complex_numbers_form_a_field"),
        " の体構造を用いる。とくに ",
        math(String.raw`-1_{\mathbb C}\ne0_{\mathbb C}`),
        " なので、",
        math(String.raw`l\in\mathbb Z`),
        " に対する ",
        math(String.raw`(-1_{\mathbb C})^l`),
        " は、非負の指数では積、負の指数では逆元の積として定まる整数冪である。 ",
        math(String.raw`\mu \in \mathbb{Z}`),
        " について",
      ]),
      displayMath(
        String.raw`\tilde\theta_\mu := \frac{2\pi\left(\mu_{\mathbb R}-\tfrac12\right)}{M_{\mathbb R}} \in \mathbb{R}`,
      ),
      paragraph([
        "とおく。ここで ",
        math(String.raw`\mu \in \mathbb{Z}`),
        " としているのは記号 ",
        math(String.raw`\tilde\theta_\mu`),
        " の定義域である。以下の指数和では ",
        math(String.raw`\mu`),
        " を ",
        math(String.raw`1`),
        " から ",
        math(String.raw`M_{\mathbb N}`),
        " までの自然数に限り、指数ではその整数像 ",
        math(String.raw`\mu_{\mathbb Z}`),
        " を用いる。このとき ",
        math(String.raw`k \in \mathbb{Z}`),
        " について",
      ]),
      displayMath(
        String.raw`\sum_{\mu=1}^{M_{\mathbb N}} e^{i (k_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}}
= \begin{cases}
M_{\mathbb C}\,(-1_{\mathbb C})^{l} & (k = lM,\ l \in \mathbb{Z}) \\
0_{\mathbb C} & (k \not\equiv 0 \pmod M)
\end{cases}`,
      ),
      paragraph([
        "とくに ",
        math(String.raw`|k| < M`),
        " かつ ",
        math(String.raw`k \neq 0`),
        " なら和は ",
        math(String.raw`0_{\mathbb C}`),
        "、",
        math(String.raw`k = 0`),
        " なら ",
        math(String.raw`M_{\mathbb C}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph(["最初に、自然数の項数と整数の格子幅の像を対応させる。包含写像の保存性より"]),
      displayMath(
        String.raw`\begin{aligned}
(M_{\mathbb N})_{\mathbb R}
&=M_{\mathbb R}
&&\bigl(\because\ (M_{\mathbb N})_{\mathbb Z}=M\bigr)\\
(2M_{\mathbb N})_{\mathbb R}
&=2M_{\mathbb R}
&&\bigl(\because\ \iota_{\mathbb N\to\mathbb Z},\iota_{\mathbb Z\to\mathbb R}\text{ は積を保つ}\bigr)\\
(M_{\mathbb N})_{\mathbb C}
&=M_{\mathbb C}
&&\bigl(\because\ (M_{\mathbb N})_{\mathbb R}=M_{\mathbb R}\bigr)\\
(2M_{\mathbb N})_{\mathbb C}
&=(2M)_{\mathbb C}
&&\bigl(\because\ (2M_{\mathbb N})_{\mathbb R}=2M_{\mathbb R}\bigr).
\end{aligned}`,
      ),
      paragraph([
        "上で定めた像の記号により ",
        math(String.raw`k_{\mathbb R}\tilde\theta_\mu`),
        " は実数である。",
      ]),
      paragraph([
        "実数 ",
        math(String.raw`r\in\mathbb R`),
        " の複素数への像は、",
        ref("inclusion_rr_to_cc"),
        " の略記 ",
        math(String.raw`r_{\mathbb C}:=\iota_{\mathbb R\to\mathbb C}(r)`),
        " で表す。主張の ",
        math(String.raw`(k_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}`),
        " は複素数であり、",
        math(String.raw`i(k_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}\in\mathbb C`),
        " である。まず指数の実数部分を計算する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
k_{\mathbb R}\tilde\theta_\mu
&=\frac{2\pi k_{\mathbb R}\left(\mu_{\mathbb R}-\frac12\right)}{M_{\mathbb R}}
&&\bigl(\because\ \tilde\theta_\mu=\tfrac{2\pi(\mu_{\mathbb R}-\frac12)}{M_{\mathbb R}}\bigr)\\
&=\frac{2\pi(2\mu_{\mathbb R}-1)k_{\mathbb R}}{2M_{\mathbb R}}
&&\bigl(\because\ M_{\mathbb R}\ne0_{\mathbb R},\ 2_{\mathbb R}\ne0_{\mathbb R}\text{ と }\mathbb R\text{ の分数の通分}\bigr).
\end{aligned}`,
      ),
      paragraph([
        "したがって、求める和を",
      ]),
      displayMath(
        String.raw`S_{M,k}:=\sum_{\mu=1}^{M_{\mathbb N}}
e^{i\left(\frac{2\pi(2(\mu_{\mathbb Z})_{\mathbb R}-1)k_{\mathbb R}}{2M_{\mathbb R}}\right)_{\mathbb C}}\in\mathbb C`,
      ),
      paragraph([
        "と書ける。また、正の自然数 ",
        math(String.raw`N\in\mathbb N_{\ge1}`),
        " については、順序を保つ包含写像により ",
        math(String.raw`N_{\mathbb R}\ge1_{\mathbb R}>0_{\mathbb R}`),
        " なので ",
        math(String.raw`N_{\mathbb R}\ne0_{\mathbb R}`),
        " である。したがって",
      ]),
      displayMath(
        String.raw`T_{N,k}:=\sum_{r=1}^{N}e^{i\left(\frac{2\pi(r_{\mathbb Z})_{\mathbb R}k_{\mathbb R}}{N_{\mathbb R}}\right)_{\mathbb C}}\in\mathbb C
\qquad(N\in\mathbb N_{\ge1})`,
      ),
      paragraph([
        "とおく。整数 ",
        math(String.raw`1,\ldots,2M_{\mathbb N}`),
        " は、ただ一通り ",
        math(String.raw`r=2\mu-1`),
        " または ",
        math(String.raw`r=2\mu`),
        "（",
        math(String.raw`1\le\mu\le M_{\mathbb N}`),
        "）と書ける。ゆえに有限和を奇数番目と偶数番目へ分けると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{2M_{\mathbb N},k}
&=\sum_{r=1}^{2M_{\mathbb N}}e^{i\left(\frac{2\pi(r_{\mathbb Z})_{\mathbb R}k_{\mathbb R}}{(2M_{\mathbb N})_{\mathbb R}}\right)_{\mathbb C}}
&&\bigl(\because\ T_{N,k}\text{ の定義に }N=2M_{\mathbb N}\text{ を代入}\bigr)\\
&=\sum_{r=1}^{2M_{\mathbb N}}e^{i\left(\frac{2\pi(r_{\mathbb Z})_{\mathbb R}k_{\mathbb R}}{2M_{\mathbb R}}\right)_{\mathbb C}}
&&\bigl(\because\ (2M_{\mathbb N})_{\mathbb R}=2M_{\mathbb R}\bigr)\\
&=\sum_{\mu=1}^{M_{\mathbb N}}e^{i\left(\frac{2\pi(2(\mu_{\mathbb Z})_{\mathbb R}-1)k_{\mathbb R}}{2M_{\mathbb R}}\right)_{\mathbb C}}
+\sum_{\mu=1}^{M_{\mathbb N}}e^{i\left(\frac{2\pi(2(\mu_{\mathbb Z})_{\mathbb R})k_{\mathbb R}}{2M_{\mathbb R}}\right)_{\mathbb C}}
&&\bigl(\because\ r\text{ の奇偶による有限和の分割}\bigr)\\
&=S_{M,k}+\sum_{\mu=1}^{M_{\mathbb N}}e^{i\left(\frac{2\pi(2(\mu_{\mathbb Z})_{\mathbb R})k_{\mathbb R}}{2M_{\mathbb R}}\right)_{\mathbb C}}
&&\bigl(\because\ S_{M,k}\text{ の定義}\bigr)\\
&=S_{M,k}+\sum_{\mu=1}^{M_{\mathbb N}}e^{i\left(\frac{2\pi(\mu_{\mathbb Z})_{\mathbb R}k_{\mathbb R}}{M_{\mathbb R}}\right)_{\mathbb C}}
&&\bigl(\because\ 2M_{\mathbb R}\ne0_{\mathbb R}\text{ と分数の約分}\bigr)\\
&=S_{M,k}+\sum_{\mu=1}^{M_{\mathbb N}}e^{i\left(\frac{2\pi(\mu_{\mathbb Z})_{\mathbb R}k_{\mathbb R}}{(M_{\mathbb N})_{\mathbb R}}\right)_{\mathbb C}}
&&\bigl(\because\ (M_{\mathbb N})_{\mathbb R}=M_{\mathbb R}\bigr)\\
&=S_{M,k}+T_{M_{\mathbb N},k}
&&\bigl(\because\ T_{M_{\mathbb N},k}\text{ の定義}\bigr).
\end{aligned}`,
      ),
      paragraph([
        ref("exp_sum"),
        " を正の整数 ",
        math(String.raw`2M_{\mathbb N}`),
        " と ",
        math(String.raw`M_{\mathbb N}`),
        " にそれぞれ適用し、",
        ref("def_delta_M"),
        " の記号を使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{2M_{\mathbb N},k}
&=(2M_{\mathbb N})_{\mathbb C}\,\delta^{2M_{\mathbb N}}_{(k,0)}
&&\bigl(\because\ \text{exp\_sum}\text{ を }2M_{\mathbb N}\text{ に適用}\bigr),\\
&=(2M)_{\mathbb C}\,\delta^{2M_{\mathbb N}}_{(k,0)}
&&\bigl(\because\ (2M_{\mathbb N})_{\mathbb C}=(2M)_{\mathbb C}\bigr),\\
T_{M_{\mathbb N},k}
&=(M_{\mathbb N})_{\mathbb C}\,\delta^{M_{\mathbb N}}_{(k,0)}
&&\bigl(\because\ \text{exp\_sum}\text{ を }M_{\mathbb N}\text{ に適用}\bigr),\\
&=M_{\mathbb C}\,\delta^{M_{\mathbb N}}_{(k,0)}
&&\bigl(\because\ (M_{\mathbb N})_{\mathbb C}=M_{\mathbb C}\bigr).
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
S_{M,k}
&=T_{2M_{\mathbb N},k}-T_{M_{\mathbb N},k}
&&\bigl(\because\ T_{2M_{\mathbb N},k}=S_{M,k}+T_{M_{\mathbb N},k}\bigr)\\
&=(2M)_{\mathbb C}\,\delta^{2M_{\mathbb N}}_{(k,0)}-M_{\mathbb C}\,\delta^{M_{\mathbb N}}_{(k,0)}
&&\bigl(\because\ \text{直前の二つの指数和}\bigr).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`k \not\equiv 0 \pmod M`),
        " のときは、",
        math(String.raw`2M\mid k`),
        " なら ",
        math(String.raw`M\mid k`),
        " となることの対偶から ",
        math(String.raw`2M\nmid k`),
        " でもある。したがって ",
        math(String.raw`\delta^{2M_{\mathbb N}}_{(k,0)}=0_{\mathbb C}`),
        " かつ ",
        math(String.raw`\delta^{M_{\mathbb N}}_{(k,0)} = 0_{\mathbb C}`),
        " なので和は ",
        math(String.raw`0_{\mathbb C}`),
        "。",
      ]),
      paragraph([
        math(String.raw`k = lM`),
        "（",
        math(String.raw`l \in \mathbb{Z}`),
        "）のときは ",
        math(String.raw`\delta^{M_{\mathbb N}}_{(k,0)} = 1_{\mathbb C}`),
        " である。また ",
        math(String.raw`M\ne0`),
        " なので、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
2M\mid k
&\iff 2M\mid lM
&&\bigl(\because\ k=lM\bigr)\\
&\iff 2\mid l
&&\bigl(\because\ M\ne0\text{ による整数の約分}\bigr).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`l`),
        " が偶数なら ",
        math(String.raw`\delta^{2M_{\mathbb N}}_{(k,0)}=1_{\mathbb C}`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
S_{M,k}
&=(2M)_{\mathbb C}\cdot1_{\mathbb C}-M_{\mathbb C}\cdot1_{\mathbb C}
&&\bigl(\because\ \delta^{2M_{\mathbb N}}_{(k,0)}=\delta^{M_{\mathbb N}}_{(k,0)}=1_{\mathbb C}\bigr)\\
&=(2M)_{\mathbb C}-M_{\mathbb C}\cdot1_{\mathbb C}
&&\bigl(\because\ (2M)_{\mathbb C}\cdot1_{\mathbb C}=(2M)_{\mathbb C}\bigr)\\
&=(2M)_{\mathbb C}-M_{\mathbb C}
&&\bigl(\because\ M_{\mathbb C}\cdot1_{\mathbb C}=M_{\mathbb C}\bigr)\\
&=M_{\mathbb C}
&&\bigl(\because\ (2M)_{\mathbb C}-M_{\mathbb C}=M_{\mathbb C}\bigr)\\
&=M_{\mathbb C}\cdot1_{\mathbb C}
&&\bigl(\because\ 1_{\mathbb C}\text{ は積の単位元}\bigr)\\
&=M_{\mathbb C}(-1_{\mathbb C})^l
&&\bigl(\because\ l\text{ が偶数なら }(-1_{\mathbb C})^l=1_{\mathbb C}\bigr).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`l`),
        " が奇数なら ",
        math(String.raw`\delta^{2M_{\mathbb N}}_{(k,0)}=0_{\mathbb C}`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
S_{M,k}
&=(2M)_{\mathbb C}\cdot0_{\mathbb C}-M_{\mathbb C}\cdot1_{\mathbb C}
&&\bigl(\because\ \delta^{2M_{\mathbb N}}_{(k,0)}=0_{\mathbb C},\ \delta^{M_{\mathbb N}}_{(k,0)}=1_{\mathbb C}\bigr)\\
&=0_{\mathbb C}-M_{\mathbb C}\cdot1_{\mathbb C}
&&\bigl(\because\ (2M)_{\mathbb C}\cdot0_{\mathbb C}=0_{\mathbb C}\bigr)\\
&=0_{\mathbb C}-M_{\mathbb C}
&&\bigl(\because\ M_{\mathbb C}\cdot1_{\mathbb C}=M_{\mathbb C}\bigr)\\
&=-M_{\mathbb C}
&&\bigl(\because\ 0_{\mathbb C}-M_{\mathbb C}=-M_{\mathbb C}\bigr)\\
&=M_{\mathbb C}(-1_{\mathbb C})
&&\bigl(\because\ -M_{\mathbb C}=M_{\mathbb C}(-1_{\mathbb C})\bigr)\\
&=M_{\mathbb C}(-1_{\mathbb C})^l
&&\bigl(\because\ l\text{ が奇数なら }(-1_{\mathbb C})^l=-1_{\mathbb C}\bigr).
\end{aligned}`,
      ),
      paragraph([
        "最後に「とくに」を示す。",
        math(String.raw`|k|<M`),
        " かつ ",
        math(String.raw`k\ne0`),
        " とする。もし ",
        math(String.raw`M\mid k`),
        " なら、ある ",
        math(String.raw`l\in\mathbb{Z}`),
        " が存在して ",
        math(String.raw`k=lM`),
        " である。このとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|lM|
&=|l|\,|M|
&&\bigl(\because\ \text{積の絶対値}\bigr)\\
&=|l|M
&&\bigl(\because\ M>0\text{ なので }|M|=M\bigr)\\
&= |k|
&&\bigl(\because\ k=lM\bigr) \\
&< M
&&\bigl(\because\ |k|<M\bigr),
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`M>0`),
        " なので、整数における正数倍は狭義順序を反映する。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|l|
&<1
&&\bigl(\because\ |l|M<1\cdot M,\ M>0\bigr).
\end{aligned}`,
      ),
      paragraph([
        "一方、整数 ",
        math(String.raw`l`),
        " の絶対値は非負整数なので、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|l|
&=0
&&\bigl(\because\ |l|\in\mathbb{Z}_{\ge0},\ |l|<1\bigr) \\
l
&=0
&&\bigl(\because\ |l|=0\bigr).
\end{aligned}`,
      ),
      paragraph([
        "すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
k
&=lM
&&\bigl(\because\ k=lM\bigr) \\
&=0\cdot M
&&\bigl(\because\ l=0\bigr) \\
&=0
&&\bigl(\because\ 0\cdot M=0\bigr),
\end{aligned}`,
      ),
      paragraph([
        "となり ",
        math(String.raw`0`),
        " ではないという仮定 ",
        math(String.raw`k\ne0`),
        " に矛盾する。ゆえに ",
        math(String.raw`M\nmid k`),
        " であり、上の非整除の場合から和は ",
        math(String.raw`0_{\mathbb C}`),
        " である。また ",
        math(String.raw`k=0`),
        " では ",
        math(String.raw`l=0`),
        " とした整除の場合により",
      ]),
      displayMath(
        String.raw`\begin{aligned}
M_{\mathbb C}(-1_{\mathbb C})^0
&=M_{\mathbb C}\cdot1_{\mathbb C}
&&\bigl(\because\ (-1)^0=1\bigr) \\
&=M_{\mathbb C}
&&\bigl(\because\ M_{\mathbb C}\cdot1_{\mathbb C}=M_{\mathbb C}\bigr).
\end{aligned}`,
      ),
      paragraph(["となる。"]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "evensector_003_definition_half_integer_checkZ",
    kind: "definition",
    origin: { path: SRC, ordinal: 5 },
    title: { tex: String.raw`\check{Z}_\mu \text{（半整数運動量で Fourier 変換した }Z\text{ 行列）}` },
    labels: ["def_half_integer_checkZ"],
    statement: [
      paragraph([
        ref("set_and_algebra_notation"),
        " の記号で ",
        math(String.raw`M\in\mathbb Z_{\geq2}`),
        " とする。",
        ref("antiperiodic_exp_sum"),
        " で定めた ",
        math(String.raw`M_{\mathbb N}\in\mathbb N_{\geq2}`),
        "、整数・実数への像 ",
        math(String.raw`j_{\mathbb Z},j_{\mathbb R}`),
        "、および各 ",
        math(String.raw`\mu\in\mathbb Z`),
        " に対する ",
        math(String.raw`\tilde\theta_\mu\in\mathbb R`),
        " を用いる。複素数と虚数単位は ",
        ref("definition_of_cc"),
        " の ",
        math(String.raw`\mathbb C`),
        " と ",
        math(String.raw`i=(0_{\mathbb R},1_{\mathbb R})\in\mathbb C`),
        " である。",
      ]),
      paragraph([
        math(String.raw`j\in\{1,\dots,M_{\mathbb N}\}`),
        " なら ",
        math(String.raw`j_{\mathbb Z}\in\{1,\dots,M\}`),
        " なので、",
        ref("def_jordan_wigner_Z_matrices"),
        " から ",
        math(String.raw`Z_{j_{\mathbb Z}}\in\mathrm{Mat}(2^{M_{\mathbb N}},\mathbb C)`),
        " である。複素指数の定義と所属は現行本文では未整備なので、以下では ",
        math(String.raw`e^{-i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}}\in\mathbb C`),
        " を仮定する。この複素数によるスカラー倍と同じ行列空間内の有限和を用いて",
      ]),
      displayMath(
        String.raw`\check{Z}_\mu
:=\sum_{j=1}^{M_{\mathbb N}}
e^{-i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}}Z_{j_{\mathbb Z}}
\in\mathrm{Mat}(2^{M_{\mathbb N}},\mathbb C)`,
      ),
      paragraph(["と定める。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "旧複合ブロックから、半整数運動量で Fourier 変換した Z 行列の定義だけを分離した。旧複合ラベルは性質の残余ブロックに残し、本定義には新しいラベル def_half_integer_checkZ を割り当てた。",
        "hat Z との係数の比較は意味上の前提ではないため、依存辺には含めていない。複素指数の先行定義と所属証明は現行本文に無く、その所属を仮定した条件付きの定義である。",
      ],
    },
  },

  {
    id: "evensector_003_definition_half_integer_checkY",
    kind: "definition",
    origin: { path: SRC, ordinal: 5 },
    title: { tex: String.raw`\check{Y}_\mu \text{（半整数運動量で Fourier 変換した }Y\text{ 行列）}` },
    labels: ["def_half_integer_checkY"],
    statement: [
      paragraph([
        ref("set_and_algebra_notation"),
        " の記号で ",
        math(String.raw`M\in\mathbb Z_{\geq2}`),
        " とする。",
        ref("antiperiodic_exp_sum"),
        " で定めた ",
        math(String.raw`M_{\mathbb N}\in\mathbb N_{\geq2}`),
        "、整数・実数への像 ",
        math(String.raw`j_{\mathbb Z},j_{\mathbb R}`),
        "、および各 ",
        math(String.raw`\mu\in\mathbb Z`),
        " に対する ",
        math(String.raw`\tilde\theta_\mu\in\mathbb R`),
        " を用いる。複素数と虚数単位は ",
        ref("definition_of_cc"),
        " の ",
        math(String.raw`\mathbb C`),
        " と ",
        math(String.raw`i=(0_{\mathbb R},1_{\mathbb R})\in\mathbb C`),
        " である。",
      ]),
      paragraph([
        math(String.raw`j\in\{1,\dots,M_{\mathbb N}\}`),
        " なら ",
        math(String.raw`j_{\mathbb Z}\in\{1,\dots,M\}`),
        " なので、",
        ref("def_jordan_wigner_Y_matrices"),
        " から ",
        math(String.raw`Y_{j_{\mathbb Z}}\in\mathrm{Mat}(2^{M_{\mathbb N}},\mathbb C)`),
        " である。複素指数の定義と所属は現行本文では未整備なので、以下では ",
        math(String.raw`e^{-i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}}\in\mathbb C`),
        " を仮定する。この複素数によるスカラー倍と同じ行列空間内の有限和を用いて",
      ]),
      displayMath(
        String.raw`\check{Y}_\mu
:=\sum_{j=1}^{M_{\mathbb N}}
e^{-i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}}Y_{j_{\mathbb Z}}
\in\mathrm{Mat}(2^{M_{\mathbb N}},\mathbb C)`,
      ),
      paragraph(["と定める。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "旧複合ブロックから、半整数運動量で Fourier 変換した Y 行列の定義だけを分離した。旧複合ラベルは性質の残余ブロックに残し、本定義には新しいラベル def_half_integer_checkY を割り当てた。",
        "複素指数の先行定義と所属証明は現行本文に無く、その所属を仮定した条件付きの定義である。",
      ],
    },
  },

  {
    id: "evensector_003_claim_half_integer_phase_antiperiodicity",
    kind: "claim",
    origin: { path: SRC, ordinal: 5 },
    title: { text: "半整数位相の反周期性" },
    labels: ["half_integer_phase_antiperiodicity"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb Z_{\geq2}`),
        "、",
        math(String.raw`\mu\in\mathbb Z`),
        " とする。",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu`),
        " について",
      ]),
      displayMath(String.raw`e^{-i M \tilde\theta_\mu} = -1`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "まず指数の角度を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
M\tilde\theta_\mu
&=M\cdot\frac{2\pi}{M}\left(\mu-\tfrac12\right)
&&\bigl(\because\ \tilde\theta_\mu=\tfrac{2\pi}{M}(\mu-\tfrac12)\text{ を代入}\bigr)\\
&=2\pi\left(\mu-\tfrac12\right)
&&\bigl(\because\ M\geq2\text{ より }M\neq0\text{ なので }M\text{ を約分}\bigr)\\
&=2\pi\mu-\pi
&&\bigl(\because\ \mathbb R\text{ の分配則}\bigr)
\end{aligned}`),
      paragraph([
        "この等式と ",
        ref("euler_formula_cos_sin"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
e^{-iM\tilde\theta_\mu}
&= \cos\!\left(M\tilde\theta_\mu\right)-i\sin\!\left(M\tilde\theta_\mu\right)
&&\bigl(\because \blkref{euler_formula_cos_sin}\text{ の証明冒頭で導いた }e^{-ix}=\cos x-i\sin x\bigr) \\
&= \cos(2\pi\mu-\pi)-i\sin(2\pi\mu-\pi)
&&\bigl(\because M\tilde\theta_\mu=2\pi\mu-\pi\ \text{を 2 箇所へ同時代入}\bigr) \\
&= -1-i\sin(2\pi\mu-\pi)
&&\bigl(\because \mu\in\mathbb Z\ \text{より}\ \cos(2\pi\mu-\pi)=-1\bigr) \\
&= -1-i\cdot0
&&\bigl(\because \mu\in\mathbb Z\ \text{より}\ \sin(2\pi\mu-\pi)=0\bigr) \\
&= -1-0
&&\bigl(\because i\cdot0=0\bigr) \\
&= -1
&&\bigl(\because \text{加法の単位元}\bigr)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "旧複合ラベル def_half_integer_modes の (1) から、半整数位相の反周期性だけを独立した主張へ分離した。",
        "複素指数の先行定義と所属証明は現行本文では未整備である。分離後の証明では、行列の exp 積公式をスカラーへ無標識に同一視せず、Euler 公式を一度だけ適用してから実数の三角関数値を一段ずつ評価する。",
      ],
    },
  },

  {
    id: "evensector_003_claim_half_integer_checkZ_periodicity",
    kind: "claim",
    origin: { path: SRC, ordinal: 5 },
    title: { text: "半整数運動量 Fourier Z 行列の添字周期性" },
    labels: ["half_integer_checkZ_periodicity"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb Z_{\geq2}`),
        "、",
        math(String.raw`\mu\in\mathbb Z`),
        " とする。",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu`),
        " と、",
        ref("def_half_integer_checkZ"),
        " の Fourier 行列について、",
        math(String.raw`\check{Z}_{\mu+M} = \check{Z}_\mu`),
        " が成り立つ。",
      ]),
    ],
    proof: [
      paragraph(["まず添字をずらした角度を計算する。"]),
      displayMath(String.raw`\begin{aligned}
\tilde\theta_{\mu+M}
&=\frac{2\pi\left(\mu+M-\tfrac12\right)}{M}
&&\bigl(\because\ \tilde\theta_\mu\text{ の定義に }\mu+M\text{ を代入}\bigr)\\
&=\frac{2\pi\left(\mu-\tfrac12\right)+2\pi M}{M}
&&\bigl(\because\ \mathbb R\text{ の分配則}\bigr)\\
&=\frac{2\pi\left(\mu-\tfrac12\right)}{M}+\frac{2\pi M}{M}
&&\bigl(\because\ \mathbb R\text{ の分数の加法}\bigr)\\
&=\frac{2\pi\left(\mu-\tfrac12\right)}{M}+2\pi
&&\bigl(\because\ M\geq2\text{ より }M\neq0\text{ であり、分子と分母の }M\text{ を約分}\bigr)\\
&=\tilde\theta_\mu+2\pi
&&\bigl(\because\ \tilde\theta_\mu\text{ の定義}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`j \in \mathbb{Z}`),
        " について、",
        ref("euler_formula_cos_sin"),
        " の証明冒頭で導いた負角の表示と、正弦・余弦の ",
        math(String.raw`2\pi`),
        " 周期性を用いると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
e^{-ij\tilde\theta_{\mu+M}}
&=\cos\!\left(j\tilde\theta_{\mu+M}\right)-i\sin\!\left(j\tilde\theta_{\mu+M}\right)
&&\bigl(\because \blkref{euler_formula_cos_sin}\text{ の証明冒頭で導いた }e^{-ix}=\cos x-i\sin x\bigr) \\
&=\cos\!\left(j(\tilde\theta_\mu+2\pi)\right)-i\sin\!\left(j(\tilde\theta_\mu+2\pi)\right)
&&\bigl(\because \tilde\theta_{\mu+M}=\tilde\theta_\mu+2\pi\text{ を 2 箇所へ同時代入}\bigr) \\
&=\cos\!\left(j\tilde\theta_\mu+2\pi j\right)-i\sin\!\left(j\tilde\theta_\mu+2\pi j\right)
&&\bigl(\because \mathbb R\text{ の分配則}\bigr) \\
&=\cos\!\left(j\tilde\theta_\mu\right)-i\sin\!\left(j\tilde\theta_\mu\right)
&&\bigl(\because j\in\mathbb Z\text{ と正弦・余弦の }2\pi\text{ 周期性}\bigr) \\
&=e^{-ij\tilde\theta_\mu}
&&\bigl(\because \blkref{euler_formula_cos_sin}\text{ の証明冒頭で導いた等式の対称律}\bigr)
\end{aligned}`,
      ),
      paragraph(["係数がすべて一致するので、一続きに"]),
      displayMath(
        String.raw`\begin{aligned}
\check{Z}_{\mu+M}
&=\sum_{j_{\mathbb N}=1}^{M_{\mathbb N}}e^{-ij_{\mathbb R}\tilde\theta_{\mu+M}}Z_{j_{\mathbb Z}}
&&\left(\because\ \check{Z}_{\mu+M}\text{ の定義}\right)\\
&=\sum_{j_{\mathbb N}=1}^{M_{\mathbb N}}e^{-ij_{\mathbb R}\tilde\theta_{\mu}}Z_{j_{\mathbb Z}}
&&\left(\because\ \text{上で得た }e^{-ij\tilde\theta_{\mu+M}}=e^{-ij\tilde\theta_\mu}\text{ を全項へ同時適用}\right)\\
&=\check{Z}_{\mu}
&&\left(\because\ \check{Z}_{\mu}\text{ の定義}\right)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "旧複合ラベル def_half_integer_modes の (2) から、半整数運動量 Fourier Z 行列の添字周期性だけを独立した主張へ分離した。",
      ],
    },
  },

  {
    id: "evensector_003_claim_half_integer_checkY_periodicity",
    kind: "claim",
    origin: { path: SRC, ordinal: 5 },
    title: { text: "半整数運動量 Fourier Y 行列の添字周期性" },
    labels: ["half_integer_checkY_periodicity"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb Z_{\geq2}`),
        "、",
        math(String.raw`\mu\in\mathbb Z`),
        " とする。",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu`),
        " と、",
        ref("def_half_integer_checkY"),
        " の Fourier 行列について、",
        math(String.raw`\check{Y}_{\mu+M} = \check{Y}_\mu`),
        " が成り立つ。",
      ]),
    ],
    proof: [
      paragraph(["まず添字をずらした角度を計算する。"]),
      displayMath(String.raw`\begin{aligned}
\tilde\theta_{\mu+M}
&=\frac{2\pi\left(\mu+M-\tfrac12\right)}{M}
&&\bigl(\because\ \tilde\theta_\mu\text{ の定義に }\mu+M\text{ を代入}\bigr)\\
&=\frac{2\pi\left(\mu-\tfrac12\right)+2\pi M}{M}
&&\bigl(\because\ \mathbb R\text{ の分配則}\bigr)\\
&=\frac{2\pi\left(\mu-\tfrac12\right)}{M}+\frac{2\pi M}{M}
&&\bigl(\because\ \mathbb R\text{ の分数の加法}\bigr)\\
&=\frac{2\pi\left(\mu-\tfrac12\right)}{M}+2\pi
&&\bigl(\because\ M\geq2\text{ より }M\neq0\text{ であり、分子と分母の }M\text{ を約分}\bigr)\\
&=\tilde\theta_\mu+2\pi
&&\bigl(\because\ \tilde\theta_\mu\text{ の定義}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`j \in \mathbb{Z}`),
        " について、",
        ref("euler_formula_cos_sin"),
        " の証明冒頭で導いた負角の表示と、正弦・余弦の ",
        math(String.raw`2\pi`),
        " 周期性を用いると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
e^{-ij\tilde\theta_{\mu+M}}
&=\cos\!\left(j\tilde\theta_{\mu+M}\right)-i\sin\!\left(j\tilde\theta_{\mu+M}\right)
&&\bigl(\because \blkref{euler_formula_cos_sin}\text{ の証明冒頭で導いた }e^{-ix}=\cos x-i\sin x\bigr) \\
&=\cos\!\left(j(\tilde\theta_\mu+2\pi)\right)-i\sin\!\left(j(\tilde\theta_\mu+2\pi)\right)
&&\bigl(\because \tilde\theta_{\mu+M}=\tilde\theta_\mu+2\pi\text{ を 2 箇所へ同時代入}\bigr) \\
&=\cos\!\left(j\tilde\theta_\mu+2\pi j\right)-i\sin\!\left(j\tilde\theta_\mu+2\pi j\right)
&&\bigl(\because \mathbb R\text{ の分配則}\bigr) \\
&=\cos\!\left(j\tilde\theta_\mu\right)-i\sin\!\left(j\tilde\theta_\mu\right)
&&\bigl(\because j\in\mathbb Z\text{ と正弦・余弦の }2\pi\text{ 周期性}\bigr) \\
&=e^{-ij\tilde\theta_\mu}
&&\bigl(\because \blkref{euler_formula_cos_sin}\text{ の証明冒頭で導いた等式の対称律}\bigr)
\end{aligned}`,
      ),
      paragraph(["係数がすべて一致するので、一続きに"]),
      displayMath(
        String.raw`\begin{aligned}
\check{Y}_{\mu+M}
&=\sum_{j_{\mathbb N}=1}^{M_{\mathbb N}}e^{-ij_{\mathbb R}\tilde\theta_{\mu+M}}Y_{j_{\mathbb Z}}
&&\left(\because\ \check{Y}_{\mu+M}\text{ の定義}\right)\\
&=\sum_{j_{\mathbb N}=1}^{M_{\mathbb N}}e^{-ij_{\mathbb R}\tilde\theta_{\mu}}Y_{j_{\mathbb Z}}
&&\left(\because\ \text{上で得た }e^{-ij\tilde\theta_{\mu+M}}=e^{-ij\tilde\theta_\mu}\text{ を全項へ同時適用}\right)\\
&=\check{Y}_{\mu}
&&\left(\because\ \check{Y}_{\mu}\text{ の定義}\right)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "旧複合ラベル def_half_integer_modes の (2) から、半整数運動量 Fourier Y 行列の添字周期性だけを独立した主張へ分離した。",
      ],
    },
  },

  {
    id: "evensector_003_definition_half_integer_modes",
    kind: "claim",
    origin: { path: SRC, ordinal: 5 },
    title: { text: "半整数位相の共役添字恒等式" },
    labels: ["def_half_integer_modes"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb Z_{\geq2}`),
        "、",
        math(String.raw`\mu\in\mathbb Z`),
        " とする。",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu`),
        " について、旧複合主張の番号を保った次の恒等式が成り立つ。",
      ]),
      displayMath(String.raw`\text{(3) 共役添字：}\quad \tilde\theta_{1-\mu} = -\tilde\theta_\mu`),
    ],
    proof: [
      paragraph([
        "(3) 共役添字について、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tilde\theta_{1-\mu}
&=\frac{2\pi\left(1-\mu-\frac12\right)}{M}
&&\left(\because\ \tilde\theta_{1-\mu}\text{ の定義}\right)\\
&=\frac{2\pi\left(\frac12-\mu\right)}{M}
&&\left(\because\ \mathbb{R}\text{ の四則}\right)\\
&=-\frac{2\pi\left(\mu-\frac12\right)}{M}
&&\left(\because\ \mathbb{R}\text{ の四則}\right)\\
&=-\tilde\theta_\mu
&&\left(\because\ \tilde\theta_\mu\text{ の定義}\right)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "旧複合ラベルは、後続参照の意味を保つため、共役添字恒等式だけを述べる残余主張に残した。",
        "(3) により、整数運動量の場合に -μ が果たしていた「共役添字」の役割を、半整数運動量では 1-μ が果たす。反交換関係の対が μ+ν ≡ 1 (mod M) になるのはこのためである。",
      ],
    },
  },

  {
    id: "evensector_003a_definition_check_index_set",
    kind: "definition",
    origin: { path: SRC, ordinal: 6 },
    title: { tex: String.raw`\check{\mathcal{M}} \text{（半整数運動量の添字集合）}` },
    labels: ["def_check_index_set"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu`),
        "（",
        math(String.raw`\mu \in \mathbb{Z}`),
        " について定義されている）を用いる。",
      ]),
      displayMath(
        String.raw`\check{\mathcal{M}} := \left\{1, 2, \dots, M\right\} \subset \mathbb{Z}`,
      ),
      paragraph([
        "と定め、**半整数運動量の添字集合**と呼ぶ。",
      ]),
      paragraph([
        "**以降、013 章から 017 章までのすべての主張は ",
        math(String.raw`\mu, \nu \in \check{\mathcal{M}}`),
        " について述べる。** ",
        math(String.raw`\mu \in \mathbb{Z}`),
        " 全体で述べる記号の**定義域**は、",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu`),
        "、",
        ref("def_half_integer_checkZ"),
        " の ",
        math(String.raw`\check Z_\mu`),
        "、",
        ref("def_half_integer_checkY"),
        " の ",
        math(String.raw`\check Y_\mu`),
        "、および後の ",
        ref("periodicity_of_check_fermi"),
        " で用いる ",
        math(String.raw`\check\psi_\mu`),
        " である。添字の周期性を述べる 3 つの主張は ",
        ref("half_integer_checkZ_periodicity"),
        "、",
        ref("half_integer_checkY_periodicity"),
        " と ",
        ref("periodicity_of_check_fermi"),
        " だけである。これら 3 つは、計算の途中で ",
        math(String.raw`\check{\mathcal{M}}`),
        " の外に現れた添字を ",
        math(String.raw`\check{\mathcal{M}}`),
        " の中へ引き戻すための橋渡しなので、",
        math(String.raw`\mathbb{Z}`),
        " で述べる必要がある。",
      ]),
      paragraph(["次の 5 つの性質を後で繰り返し使う。"]),
      list([
        [
          math(
            String.raw`\text{(1) 相異なる } M \text{ 個の運動量：}\quad
\mu, \nu \in \check{\mathcal{M}},\ \mu \neq \nu \implies \tilde\theta_\mu \neq \tilde\theta_\nu,
\qquad 0 < \tilde\theta_\mu < 2\pi`,
          ),
        ],
        [
          math(
            String.raw`\text{(2) 共役添字の閉性：}\quad \mu \in \check{\mathcal{M}} \implies M+1-\mu \in \check{\mathcal{M}}`,
          ),
        ],
        [
          math(
            String.raw`\text{(3) 共役添字の言い換え：}\quad \left(M+1-\mu\right) - \left(1-\mu\right) = M,
\quad \text{すなわち } 1-\mu \equiv M+1-\mu \pmod M`,
          ),
        ],
        [
          math(
            String.raw`\text{(4) 自己共役点：}\quad
\mu \in \check{\mathcal{M}},\ M+1-\mu = \mu
\iff M \text{ が奇数かつ } \mu = \tfrac{M+1}{2}`,
          ),
          "。このとき ",
          math(String.raw`\tilde\theta_\mu = \pi`),
          "。",
        ],
        [
          math(
            String.raw`\text{(5) 対の判定：}\quad
\mu, \nu \in \check{\mathcal{M}} \implies
\left(\mu+\nu \equiv 1 \pmod M \iff \nu = M+1-\mu\right)`,
          ),
          "。したがって ",
          math(String.raw`\mu,\nu \in \check{\mathcal{M}}`),
          " では ",
          math(String.raw`\delta^M_{(\mu+\nu,\,1)} = \delta_{\nu,\,M+1-\mu}`),
          " である（右辺は通常のクロネッカーのデルタ、すなわち ",
          math(String.raw`\nu = M+1-\mu`),
          " のとき ",
          math(String.raw`1`),
          "、そうでないとき ",
          math(String.raw`0`),
          "）。",
        ],
      ]),
      paragraph([
        "(5) は、",
        math(String.raw`\check{\mathcal{M}}`),
        " へ範囲を絞ったことで**合同式が消える**ことを述べている。",
        ref("anticommutator_of_check_Z_Y"),
        " 以降で対を指定するのに合同式が要らなくなるのはこのためである。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("antiperiodic_exp_sum"),
        " より ",
        math(String.raw`\tilde\theta_\mu = \dfrac{2\pi\left(\mu-\frac12\right)}{M}`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tilde\theta_\nu - \tilde\theta_\mu
&= \frac{2\pi\left(\nu-\frac12\right)}{M} - \frac{2\pi\left(\mu-\frac12\right)}{M}
&&\bigl(\because \blkref{antiperiodic_exp_sum}\text{ の } \tilde\theta \text{ の定義}\bigr) \\
&= \frac{2\pi}{M}\left(\nu - \mu\right)
&&\bigl(\because \text{通分と分配法則}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "であり ",
        math(String.raw`\frac{2\pi}{M} > 0`),
        " なので、",
        math(String.raw`\mu \neq \nu`),
        " なら ",
        math(String.raw`\tilde\theta_\mu \neq \tilde\theta_\nu`),
        "。また同じ式は ",
        math(String.raw`\mu \mapsto \tilde\theta_\mu`),
        " が狭義単調増加であることを与えるので、",
        math(String.raw`1 \leq \mu \leq M`),
        " では",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tilde\theta_1
&=\frac{2\pi\left(1-\frac12\right)}{M}
&&\left(\because\ \blkref{antiperiodic_exp_sum}\text{ の }\tilde\theta\text{ の定義}\right)\\
&=\frac{\pi}{M}
&&\left(\because\ \mathbb R\text{ の四則}\right)\\
&\leq\tilde\theta_\mu
&&\left(\because\ 1\leq\mu\text{ と }\mu\mapsto\tilde\theta_\mu\text{ の単調増加}\right)\\
&\leq\tilde\theta_M
&&\left(\because\ \mu\leq M\text{ と }\mu\mapsto\tilde\theta_\mu\text{ の単調増加}\right)\\
&=\frac{2\pi\left(M-\frac12\right)}{M}
&&\left(\because\ \blkref{antiperiodic_exp_sum}\text{ の }\tilde\theta\text{ の定義}\right)\\
&=2\pi-\frac{\pi}{M}
&&\left(\because\ \mathbb R\text{ の四則}\right)
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`M \geq 2`),
        " より ",
        math(String.raw`0 < \frac{\pi}{M}`),
        " かつ ",
        math(String.raw`2\pi - \frac{\pi}{M} < 2\pi`),
        " なので ",
        math(String.raw`0 < \tilde\theta_\mu < 2\pi`),
        "。",
      ]),
      paragraph([
        "(2) ",
        math(String.raw`1 \leq \mu \leq M`),
        " の各辺に ",
        math(String.raw`-1`),
        " を掛けると ",
        math(String.raw`-M \leq -\mu \leq -1`),
        "、さらに ",
        math(String.raw`M+1`),
        " を足すと ",
        math(String.raw`1 \leq M+1-\mu \leq M`),
        "。",
        math(String.raw`M+1-\mu \in \mathbb{Z}`),
        " なので ",
        math(String.raw`M+1-\mu \in \check{\mathcal{M}}`),
        "。",
      ]),
      paragraph([
        "(3) ",
        math(String.raw`(M+1-\mu) - (1-\mu) = M`),
        " は展開するだけである。",
        ref("def_delta_M"),
        " の合同の意味により、差が ",
        math(String.raw`M`),
        " の倍数であることが ",
        math(String.raw`1-\mu \equiv M+1-\mu \pmod M`),
        " である。",
      ]),
      paragraph([
        "(4) ",
        math(String.raw`M+1-\mu = \mu`),
        " は ",
        math(String.raw`M+1 = 2\mu`),
        " と同値であり、これは ",
        math(String.raw`\mu = \frac{M+1}{2}`),
        " と同値である。",
        math(String.raw`\mu \in \mathbb{Z}`),
        " なので ",
        math(String.raw`M+1`),
        " は偶数、すなわち ",
        math(String.raw`M`),
        " は奇数でなければならない。逆に ",
        math(String.raw`M`),
        " が奇数なら ",
        math(String.raw`\frac{M+1}{2} \in \mathbb{Z}`),
        " であり、",
        math(String.raw`M \geq 2`),
        " と併せて ",
        math(String.raw`1 \leq \frac{M+1}{2} \leq M`),
        "（右の不等式は ",
        math(String.raw`M+1 \leq 2M \iff 1 \leq M`),
        "）なので ",
        math(String.raw`\frac{M+1}{2} \in \check{\mathcal{M}}`),
        "。このとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tilde\theta_{\frac{M+1}{2}}
&= \frac{2\pi\left(\frac{M+1}{2}-\frac12\right)}{M}
&&\bigl(\because \blkref{antiperiodic_exp_sum}\text{ の } \tilde\theta \text{ の定義}\bigr) \\
&= \frac{2\pi\cdot\frac{M}{2}}{M}
&&\bigl(\because \tfrac{M+1}{2}-\tfrac12 = \tfrac{M}{2}\bigr) \\
&= \pi
&&\bigl(\because \text{約分}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "(5) ",
        math(String.raw`(\Leftarrow)`),
        " ",
        math(String.raw`\nu = M+1-\mu`),
        " なら ",
        math(String.raw`\mu+\nu = M+1`),
        " なので ",
        math(String.raw`(\mu+\nu) - 1 = M`),
        "、すなわち ",
        math(String.raw`\mu+\nu \equiv 1 \pmod M`),
        "。",
      ]),
      paragraph([
        math(String.raw`(\Rightarrow)`),
        " ",
        math(String.raw`1 \leq \mu \leq M`),
        " と ",
        math(String.raw`1 \leq \nu \leq M`),
        " を足すと ",
        math(String.raw`2 \leq \mu+\nu \leq 2M`),
        "、よって ",
        math(String.raw`1 \leq \mu+\nu-1 \leq 2M-1`),
        "。仮定 ",
        math(String.raw`\mu+\nu \equiv 1 \pmod M`),
        " は ",
        math(String.raw`\mu+\nu-1`),
        " が ",
        math(String.raw`M`),
        " の倍数であることを意味する（",
        ref("def_delta_M"),
        " の合同の意味）。",
      ]),
      paragraph([
        math(String.raw`M`),
        " の倍数 ",
        math(String.raw`lM`),
        "（",
        math(String.raw`l \in \mathbb{Z}`),
        "）が ",
        math(String.raw`1 \leq lM \leq 2M-1`),
        " を満たすのは ",
        math(String.raw`l = 1`),
        " のときに限る（",
        math(String.raw`l \leq 0`),
        " なら ",
        math(String.raw`lM \leq 0 < 1`),
        "、",
        math(String.raw`l \geq 2`),
        " なら ",
        math(String.raw`lM \geq 2M > 2M-1`),
        "）。よって ",
        math(String.raw`\mu+\nu-1 = M`),
        " すなわち ",
        math(String.raw`\nu = M+1-\mu`),
        "。",
      ]),
      paragraph([
        "デルタの等式は、",
        ref("def_delta_M"),
        " より ",
        math(String.raw`\delta^M_{(\mu+\nu,1)} = 1 \iff \mu+\nu \equiv 1 \pmod M`),
        " であり、いま示した同値によりこれが ",
        math(String.raw`\nu = M+1-\mu`),
        " と同値だからである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "𝓜̌ = {1,…,M} はこれ以上減らせない: θ~_μ (μ = 1..M) は (0,2π) 内の相異なる M 個であり ((1))、共役 μ ↦ M+1−μ について閉じている ((2))。008 章の 𝓜 = {−M,…,−1,1,…,M} が μ ↦ −μ について閉じていたのと同じ構造である。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },

  {
    id: "evensector_003b_claim_conjugate_index_of_check_Z_Y",
    kind: "claim",
    origin: { path: SRC, ordinal: 7 },
    title: { tex: String.raw`\check{\mathcal{M}} \text{ の内側で共役添字を取る}` },
    labels: ["conjugate_index_of_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      list([
        [math(String.raw`\text{(1)}\quad \tilde\theta_{M+1-\mu} = 2\pi - \tilde\theta_\mu`)],
        [
          math(
            String.raw`\text{(2)}\quad e^{-ij\tilde\theta_{M+1-\mu}} = e^{ij\tilde\theta_\mu}
\qquad (j \in \mathbb{Z})`,
          ),
        ],
        [
          math(
            String.raw`\text{(3)}\quad \check{Z}_{M+1-\mu} = \check{Z}_{1-\mu},
\qquad \check{Y}_{M+1-\mu} = \check{Y}_{1-\mu}`,
          ),
        ],
      ]),
      paragraph([
        "が成り立つ。とくに (3) により、",
        ref("def_half_integer_modes"),
        " (3) の共役添字 ",
        math(String.raw`1-\mu`),
        "（これは ",
        math(String.raw`\mu \geq 2`),
        " では ",
        math(String.raw`\check{\mathcal{M}}`),
        " の外に出る）を、つねに ",
        math(String.raw`\check{\mathcal{M}}`),
        " の元である ",
        math(String.raw`M+1-\mu`),
        " で置き換えてよい。**013 章から 017 章では以降つねにそうする。**",
      ]),
      paragraph([
        "(2) は ",
        ref("def_half_integer_modes"),
        " (3) の ",
        math(String.raw`\tilde\theta_{1-\mu} = -\tilde\theta_\mu`),
        " が果たしていた役割を、",
        math(String.raw`\check{\mathcal{M}}`),
        " の内側で果たす（位相としては ",
        math(String.raw`\tilde\theta_{M+1-\mu}`),
        " は ",
        math(String.raw`-\tilde\theta_\mu`),
        " と ",
        math(String.raw`2\pi`),
        " しか違わない）。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta`),
        " の定義より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tilde\theta_{M+1-\mu}
&= \frac{2\pi\left(M+1-\mu-\frac12\right)}{M}
   &&(\because \blkref{antiperiodic_exp_sum}\text{ の } \tilde\theta \text{ の定義}) \\
&= \frac{2\pi\left(M - \left(\mu-\frac12\right)\right)}{M}
   &&\left(\because M+1-\mu-\tfrac12 = M - \left(\mu-\tfrac12\right)\right) \\
&= 2\pi - \frac{2\pi\left(\mu-\frac12\right)}{M}
   &&(\because \mathbb C \text{ の四則}) \\
&= 2\pi - \tilde\theta_\mu
   &&(\because \blkref{antiperiodic_exp_sum}\text{ の } \tilde\theta \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "(2) ",
        math(String.raw`j \in \mathbb{Z}`),
        " について、(1) と指数法則より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
e^{-ij\tilde\theta_{M+1-\mu}}
&= e^{-ij\left(2\pi - \tilde\theta_\mu\right)}
   &&(\because \text{直前の (1)}) \\
&= e^{-2\pi i j}\,e^{ij\tilde\theta_\mu}
   &&(\because \blkref{theorem_exp_product}\ (n=1)) \\
&= \left(\cos(2\pi j) - i\sin(2\pi j)\right)e^{ij\tilde\theta_\mu}
   &&(\because \blkref{euler_formula_cos_sin}) \\
&= e^{ij\tilde\theta_\mu}
   &&(\because j \in \mathbb{Z} \text{ より } \cos(2\pi j) = 1,\ \sin(2\pi j) = 0)
\end{aligned}`,
      ),
      paragraph([
        "ここで指数法則の ", math(String.raw`n=1`), " は ",
        math(String.raw`\mathrm{Mat}(1,\mathbb{C}) = \mathbb{C}`),
        " における適用である。",
      ]),
      paragraph([
        "(3) ",
        ref("half_integer_checkZ_periodicity"),
        " と ",
        ref("half_integer_checkY_periodicity"),
        "（添字の周期性）を添字 ",
        math(String.raw`1-\mu \in \mathbb{Z}`),
        " に適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Z}_{M+1-\mu}
&=\check{Z}_{(1-\mu)+M}
&&\bigl(\because (1-\mu)+M=M+1-\mu\bigr)\\
&=\check{Z}_{1-\mu}
&&\bigl(\because \blkref{half_integer_checkZ_periodicity}\bigr),\\[2pt]
\check{Y}_{M+1-\mu}
&=\check{Y}_{(1-\mu)+M}
&&\bigl(\because (1-\mu)+M=M+1-\mu\bigr)\\
&=\check{Y}_{1-\mu}
&&\bigl(\because \blkref{half_integer_checkY_periodicity}\bigr).
\end{aligned}`,
      ),
      paragraph([
        "この適用では、添字の周期性を ", math(String.raw`\check{\mathcal{M}}`),
        " の外の添字 ", math(String.raw`1-\mu`),
        " に用いている。添字の周期性を ", math(String.raw`\mu\in\mathbb Z`),
        " で述べたことが、この橋渡しを可能にする。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-01 の式変形統一で、二本の式変形鎖の行中にあった根拠 7 行を行末の根拠列（aligned の &&）へ揃え、添字の周期性の二本の等式を同じ形へ開いた。内容・式変形・根拠・ラベル参照は不変である。",
      ],
    },
  },

  {
    id: "evensector_004_claim_commutator_H_check_Z_Y",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: SRC, ordinal: 8 },
    title: { tex: String.raw`H_1^{(+)}, H_2 \text{ と } \check{Z}, \check{Y} \text{ の交換関係}` },
    labels: ["commutator_of_H_and_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について（",
        math(String.raw`H_1^{(+)}`),
        " は ",
        ref("def_H1_pm"),
        " の ",
        math(String.raw`H_1^{(\pm)}`),
        " で上の符号を取ったもの、すなわち ",
        math(String.raw`H_1^{(+)} = \sum_{m=1}^{M-1}Y_mZ_{m+1} - Y_MZ_1`),
        "）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\text{(A)}\quad \left[H_1^{(+)},\ \check{Z}_\mu\right] &= 2\,e^{-i\tilde\theta_\mu}\,\check{Y}_\mu, &
\text{(B)}\quad \left[H_1^{(+)},\ \check{Y}_\mu\right] &= -2\,e^{i\tilde\theta_\mu}\,\check{Z}_\mu, \\
\text{(C)}\quad \left[H_2,\ \check{Z}_\mu\right] &= -2\,\check{Y}_\mu, &
\text{(D)}\quad \left[H_2,\ \check{Y}_\mu\right] &= 2\,\check{Z}_\mu
\end{aligned}`,
      ),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "Step 1（サイトごとの交換関係）。",
        math(String.raw`j \in \{1,\dots,M\}`),
        " について次を示す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_2,\ Z_j\right] &= -2Y_j, &
\left[H_2,\ Y_j\right] &= 2Z_j, \\
\left[H_1^{(+)},\ Z_j\right] &= 2\,Y_{j-1}^{\flat}, &
\left[H_1^{(+)},\ Y_j\right] &= -2\,Z_{j+1}^{\flat}
\end{aligned}`,
      ),
      paragraph([
        "ここで**反周期的な延長**",
      ]),
      displayMath(
        String.raw`Y_0^{\flat} := -Y_M,\quad Y_j^{\flat} := Y_j\ (1\leq j\leq M),\qquad
Z_{M+1}^{\flat} := -Z_1,\quad Z_j^{\flat} := Z_j\ (1\leq j\leq M)`,
      ),
      paragraph([
        "を用いた（",
        ref("def_jordan_wigner_Z_matrices"),
        " の ",
        math(String.raw`Z_{M+1} := Z_1`),
        " という**周期的**な規約とは符号が逆である点に注意）。",
      ]),
      paragraph([
        "準備として、",
        ref("anticommutator_of_Z_and_Y"),
        " から従う関係式をまとめる。",
        math(String.raw`I := I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        "、",
        math(String.raw`j, k \in \{1,\dots,M\}`),
        " とする。",
        math(String.raw`j \neq k`),
        " なら ",
        math(String.raw`1 \leq j, k \leq M`),
        " より ",
        math(String.raw`j \not\equiv k \pmod M`),
        " なので ",
        math(String.raw`\delta^M_{(j,k)} = 0`),
        "、また ",
        math(String.raw`\delta^M_{(j,j)} = 1`),
        " である。これを ",
        ref("anticommutator_of_Z_and_Y"),
        " の 3 式へ代入して移項し、",
        math(String.raw`2Z_jZ_j = 2I`),
        "、",
        math(String.raw`2Y_jY_j = 2I`),
        " の両辺を ",
        math(String.raw`2`),
        " で割ると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_jZ_k &= -Z_kZ_j,\quad Y_jY_k = -Y_kY_j && (j \neq k), \\
Z_jY_k &= -Y_kZ_j && (j, k \text{ は任意}), \\
Z_jZ_j &= I,\quad Y_jY_j = I &&
\end{aligned}`,
      ),
      paragraph([
        "を得る。以下の鎖で ",
        ref("anticommutator_of_Z_and_Y"),
        " を根拠とする行は、この 3 行のいずれかを適用している。",
      ]),
      paragraph([
        "まず、相異なる添字の項が消えることを示す。",
        math(String.raw`a, b, j \in \{1,\dots,M\}`),
        " とする。",
        math(String.raw`a \neq j`),
        " のとき、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[Z_aY_a,\ Z_j\right]
&= \left(Z_aY_a\right)Z_j - Z_j\left(Z_aY_a\right)
   &&(\because \text{交換子の定義}) \\
&= Z_a\left(Y_aZ_j\right) - Z_j\left(Z_aY_a\right)
   &&(\because \text{行列の積の結合法則}) \\
&= Z_a\left(-Z_jY_a\right) - Z_j\left(Z_aY_a\right)
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Y_aZ_j = -Z_jY_a)) \\
&= -\left(Z_aZ_j\right)Y_a - Z_j\left(Z_aY_a\right)
   &&(\because \text{結合法則とスカラー倍}) \\
&= -\left(-Z_jZ_a\right)Y_a - Z_j\left(Z_aY_a\right)
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_aZ_j = -Z_jZ_a,\ a \neq j)) \\
&= \left(Z_jZ_a\right)Y_a - Z_j\left(Z_aY_a\right)
   &&(\because -(-1) = 1 \text{ の符号の消去}) \\
&= Z_j\left(Z_aY_a\right) - Z_j\left(Z_aY_a\right)
   &&(\because \text{行列の積の結合法則}) \\
&= 0
   &&(\because \text{同じ行列の差は零行列})
\end{aligned}`,
      ),
      paragraph([
        "であり、同じく ",
        math(String.raw`a \neq j`),
        " のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[Z_aY_a,\ Y_j\right]
&= \left(Z_aY_a\right)Y_j - Y_j\left(Z_aY_a\right)
   &&(\because \text{交換子の定義}) \\
&= Z_a\left(Y_aY_j\right) - Y_j\left(Z_aY_a\right)
   &&(\because \text{行列の積の結合法則}) \\
&= Z_a\left(-Y_jY_a\right) - Y_j\left(Z_aY_a\right)
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Y_aY_j = -Y_jY_a,\ a \neq j)) \\
&= -\left(Z_aY_j\right)Y_a - Y_j\left(Z_aY_a\right)
   &&(\because \text{結合法則とスカラー倍}) \\
&= -\left(-Y_jZ_a\right)Y_a - Y_j\left(Z_aY_a\right)
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_aY_j = -Y_jZ_a)) \\
&= \left(Y_jZ_a\right)Y_a - Y_j\left(Z_aY_a\right)
   &&(\because -(-1) = 1 \text{ の符号の消去}) \\
&= Y_j\left(Z_aY_a\right) - Y_j\left(Z_aY_a\right)
   &&(\because \text{行列の積の結合法則}) \\
&= 0
   &&(\because \text{同じ行列の差は零行列})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`b \neq j`),
        " のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[Y_aZ_b,\ Z_j\right]
&= \left(Y_aZ_b\right)Z_j - Z_j\left(Y_aZ_b\right)
   &&(\because \text{交換子の定義}) \\
&= Y_a\left(Z_bZ_j\right) - Z_j\left(Y_aZ_b\right)
   &&(\because \text{行列の積の結合法則}) \\
&= Y_a\left(-Z_jZ_b\right) - Z_j\left(Y_aZ_b\right)
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_bZ_j = -Z_jZ_b,\ b \neq j)) \\
&= -\left(Y_aZ_j\right)Z_b - Z_j\left(Y_aZ_b\right)
   &&(\because \text{結合法則とスカラー倍}) \\
&= -\left(-Z_jY_a\right)Z_b - Z_j\left(Y_aZ_b\right)
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Y_aZ_j = -Z_jY_a)) \\
&= \left(Z_jY_a\right)Z_b - Z_j\left(Y_aZ_b\right)
   &&(\because -(-1) = 1 \text{ の符号の消去}) \\
&= Z_j\left(Y_aZ_b\right) - Z_j\left(Y_aZ_b\right)
   &&(\because \text{行列の積の結合法則}) \\
&= 0
   &&(\because \text{同じ行列の差は零行列})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`a \neq j`),
        " のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[Y_aZ_b,\ Y_j\right]
&= \left(Y_aZ_b\right)Y_j - Y_j\left(Y_aZ_b\right)
   &&(\because \text{交換子の定義}) \\
&= Y_a\left(Z_bY_j\right) - Y_j\left(Y_aZ_b\right)
   &&(\because \text{行列の積の結合法則}) \\
&= Y_a\left(-Y_jZ_b\right) - Y_j\left(Y_aZ_b\right)
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_bY_j = -Y_jZ_b)) \\
&= -\left(Y_aY_j\right)Z_b - Y_j\left(Y_aZ_b\right)
   &&(\because \text{結合法則とスカラー倍}) \\
&= -\left(-Y_jY_a\right)Z_b - Y_j\left(Y_aZ_b\right)
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Y_aY_j = -Y_jY_a,\ a \neq j)) \\
&= \left(Y_jY_a\right)Z_b - Y_j\left(Y_aZ_b\right)
   &&(\because -(-1) = 1 \text{ の符号の消去}) \\
&= Y_j\left(Y_aZ_b\right) - Y_j\left(Y_aZ_b\right)
   &&(\because \text{行列の積の結合法則}) \\
&= 0
   &&(\because \text{同じ行列の差は零行列})
\end{aligned}`,
      ),
      paragraph([
        "である。次に、同じ添字を含む項を計算する。",
        math(String.raw`j \in \{1,\dots,M\}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[Z_jY_j,\ Z_j\right]
&= \left(Z_jY_j\right)Z_j - Z_j\left(Z_jY_j\right)
   &&(\because \text{交換子の定義}) \\
&= Z_j\left(Y_jZ_j\right) - \left(Z_jZ_j\right)Y_j
   &&(\because \text{行列の積の結合法則}) \\
&= Z_j\left(-Z_jY_j\right) - \left(Z_jZ_j\right)Y_j
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Y_jZ_j = -Z_jY_j)) \\
&= -\left(Z_jZ_j\right)Y_j - \left(Z_jZ_j\right)Y_j
   &&(\because \text{結合法則とスカラー倍}) \\
&= -I\,Y_j - I\,Y_j
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_jZ_j = I)) \\
&= -Y_j - Y_j
   &&(\because \text{単位行列の性質 } I\,Y_j = Y_j) \\
&= -2Y_j
   &&(\because \text{同類項をまとめる})
\end{aligned}`,
      ),
      paragraph(["であり、"]),
      displayMath(
        String.raw`\begin{aligned}
\left[Z_jY_j,\ Y_j\right]
&= \left(Z_jY_j\right)Y_j - Y_j\left(Z_jY_j\right)
   &&(\because \text{交換子の定義}) \\
&= Z_j\left(Y_jY_j\right) - \left(Y_jZ_j\right)Y_j
   &&(\because \text{行列の積の結合法則}) \\
&= Z_j\,I - \left(Y_jZ_j\right)Y_j
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Y_jY_j = I)) \\
&= Z_j - \left(Y_jZ_j\right)Y_j
   &&(\because \text{単位行列の性質 } Z_j\,I = Z_j) \\
&= Z_j - \left(-Z_jY_j\right)Y_j
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Y_jZ_j = -Z_jY_j)) \\
&= Z_j + Z_j\left(Y_jY_j\right)
   &&(\because \text{結合法則とスカラー倍}) \\
&= Z_j + Z_j\,I
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Y_jY_j = I)) \\
&= Z_j + Z_j
   &&(\because \text{単位行列の性質 } Z_j\,I = Z_j) \\
&= 2Z_j
   &&(\because \text{同類項をまとめる})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`m \in \{1,\dots,M-1\}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[Y_mZ_{m+1},\ Z_{m+1}\right]
&= \left(Y_mZ_{m+1}\right)Z_{m+1} - Z_{m+1}\left(Y_mZ_{m+1}\right)
   &&(\because \text{交換子の定義}) \\
&= Y_m\left(Z_{m+1}Z_{m+1}\right) - \left(Z_{m+1}Y_m\right)Z_{m+1}
   &&(\because \text{行列の積の結合法則}) \\
&= Y_m\,I - \left(Z_{m+1}Y_m\right)Z_{m+1}
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_{m+1}Z_{m+1} = I)) \\
&= Y_m - \left(Z_{m+1}Y_m\right)Z_{m+1}
   &&(\because \text{単位行列の性質 } Y_m\,I = Y_m) \\
&= Y_m - \left(-Y_mZ_{m+1}\right)Z_{m+1}
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_{m+1}Y_m = -Y_mZ_{m+1})) \\
&= Y_m + Y_m\left(Z_{m+1}Z_{m+1}\right)
   &&(\because \text{結合法則とスカラー倍}) \\
&= Y_m + Y_m\,I
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_{m+1}Z_{m+1} = I)) \\
&= Y_m + Y_m
   &&(\because \text{単位行列の性質 } Y_m\,I = Y_m) \\
&= 2Y_m
   &&(\because \text{同類項をまとめる})
\end{aligned}`,
      ),
      paragraph(["であり、"]),
      displayMath(
        String.raw`\begin{aligned}
\left[Y_mZ_{m+1},\ Y_m\right]
&= \left(Y_mZ_{m+1}\right)Y_m - Y_m\left(Y_mZ_{m+1}\right)
   &&(\because \text{交換子の定義}) \\
&= Y_m\left(Z_{m+1}Y_m\right) - \left(Y_mY_m\right)Z_{m+1}
   &&(\because \text{行列の積の結合法則}) \\
&= Y_m\left(-Y_mZ_{m+1}\right) - \left(Y_mY_m\right)Z_{m+1}
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_{m+1}Y_m = -Y_mZ_{m+1})) \\
&= -\left(Y_mY_m\right)Z_{m+1} - \left(Y_mY_m\right)Z_{m+1}
   &&(\because \text{結合法則とスカラー倍}) \\
&= -I\,Z_{m+1} - I\,Z_{m+1}
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Y_mY_m = I)) \\
&= -Z_{m+1} - Z_{m+1}
   &&(\because \text{単位行列の性質 } I\,Z_{m+1} = Z_{m+1}) \\
&= -2Z_{m+1}
   &&(\because \text{同類項をまとめる})
\end{aligned}`,
      ),
      paragraph([
        "である。境界項については",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[-Y_MZ_1,\ Z_1\right]
&= -\left[Y_MZ_1,\ Z_1\right]
   &&(\because \text{交換子の第 1 引数についての } \mathbb{C} \text{ 線型性}) \\
&= -\left(\left(Y_MZ_1\right)Z_1 - Z_1\left(Y_MZ_1\right)\right)
   &&(\because \text{交換子の定義}) \\
&= -\left(Y_M\left(Z_1Z_1\right) - \left(Z_1Y_M\right)Z_1\right)
   &&(\because \text{行列の積の結合法則}) \\
&= -\left(Y_M\,I - \left(Z_1Y_M\right)Z_1\right)
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_1Z_1 = I)) \\
&= -\left(Y_M - \left(Z_1Y_M\right)Z_1\right)
   &&(\because \text{単位行列の性質 } Y_M\,I = Y_M) \\
&= -\left(Y_M - \left(-Y_MZ_1\right)Z_1\right)
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_1Y_M = -Y_MZ_1)) \\
&= -\left(Y_M + Y_M\left(Z_1Z_1\right)\right)
   &&(\because \text{結合法則とスカラー倍}) \\
&= -\left(Y_M + Y_M\,I\right)
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_1Z_1 = I)) \\
&= -\left(Y_M + Y_M\right)
   &&(\because \text{単位行列の性質 } Y_M\,I = Y_M) \\
&= -2Y_M
   &&(\because \text{同類項をまとめる}) \\
&= 2\left(-Y_M\right)
   &&(\because \text{スカラー倍の符号の整理 } -2Y_M = 2(-Y_M)) \\
&= 2\,Y_0^{\flat}
   &&(\because Y_0^{\flat} := -Y_M)
\end{aligned}`,
      ),
      paragraph(["と"]),
      displayMath(
        String.raw`\begin{aligned}
\left[-Y_MZ_1,\ Y_M\right]
&= -\left[Y_MZ_1,\ Y_M\right]
   &&(\because \text{交換子の第 1 引数についての } \mathbb{C} \text{ 線型性}) \\
&= -\left(\left(Y_MZ_1\right)Y_M - Y_M\left(Y_MZ_1\right)\right)
   &&(\because \text{交換子の定義}) \\
&= -\left(Y_M\left(Z_1Y_M\right) - \left(Y_MY_M\right)Z_1\right)
   &&(\because \text{行列の積の結合法則}) \\
&= -\left(Y_M\left(-Y_MZ_1\right) - \left(Y_MY_M\right)Z_1\right)
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_1Y_M = -Y_MZ_1)) \\
&= -\left(-\left(Y_MY_M\right)Z_1 - \left(Y_MY_M\right)Z_1\right)
   &&(\because \text{結合法則とスカラー倍}) \\
&= -\left(-I\,Z_1 - I\,Z_1\right)
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Y_MY_M = I)) \\
&= -\left(-Z_1 - Z_1\right)
   &&(\because \text{単位行列の性質 } I\,Z_1 = Z_1) \\
&= -\left(-2Z_1\right)
   &&(\because \text{同類項をまとめる}) \\
&= 2Z_1
   &&(\because \text{スカラー倍の符号の整理 } -(-2Z_1) = 2Z_1) \\
&= -2\left(-Z_1\right)
   &&(\because \text{スカラー倍の符号の整理 } 2Z_1 = -2(-Z_1)) \\
&= -2\,Z_{M+1}^{\flat}
   &&(\because Z_{M+1}^{\flat} := -Z_1)
\end{aligned}`,
      ),
      paragraph([
        "である。以上を和へまとめる。",
        math(String.raw`H_2`),
        " について、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_2,\ Z_j\right]
&= \left[\sum_{a=1}^{M} Z_aY_a,\ Z_j\right]
   &&(\because \blkref{def_H2}) \\
&= \sum_{a=1}^{M}\left[Z_aY_a,\ Z_j\right]
   &&(\because \text{交換子の第 1 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \left[Z_jY_j,\ Z_j\right] + \sum_{\substack{1 \leq a \leq M \\ a \neq j}}\left[Z_aY_a,\ Z_j\right]
   &&(\because a = j \text{ の項を有限和から分ける}) \\
&= \left[Z_jY_j,\ Z_j\right] + \sum_{\substack{1 \leq a \leq M \\ a \neq j}} 0
   &&(\because \text{上で示した } \left[Z_aY_a, Z_j\right] = 0\ (a \neq j) \text{ を各項へ同時適用}) \\
&= \left[Z_jY_j,\ Z_j\right]
   &&(\because \text{零行列の和は零行列}) \\
&= -2Y_j
   &&(\because \text{上で示した } \left[Z_jY_j, Z_j\right] = -2Y_j)
\end{aligned}`,
      ),
      paragraph(["であり、"]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_2,\ Y_j\right]
&= \left[\sum_{a=1}^{M} Z_aY_a,\ Y_j\right]
   &&(\because \blkref{def_H2}) \\
&= \sum_{a=1}^{M}\left[Z_aY_a,\ Y_j\right]
   &&(\because \text{交換子の第 1 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \left[Z_jY_j,\ Y_j\right] + \sum_{\substack{1 \leq a \leq M \\ a \neq j}}\left[Z_aY_a,\ Y_j\right]
   &&(\because a = j \text{ の項を有限和から分ける}) \\
&= \left[Z_jY_j,\ Y_j\right] + \sum_{\substack{1 \leq a \leq M \\ a \neq j}} 0
   &&(\because \text{上で示した } \left[Z_aY_a, Y_j\right] = 0\ (a \neq j) \text{ を各項へ同時適用}) \\
&= \left[Z_jY_j,\ Y_j\right]
   &&(\because \text{零行列の和は零行列}) \\
&= 2Z_j
   &&(\because \text{上で示した } \left[Z_jY_j, Y_j\right] = 2Z_j)
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`H_1^{(+)}`),
        " と ",
        math(String.raw`Z_j`),
        " について、",
        math(String.raw`2 \leq j \leq M`),
        " のときは一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_1^{(+)},\ Z_j\right]
&= \left[\sum_{m=1}^{M-1} Y_mZ_{m+1} - Y_MZ_1,\ Z_j\right]
   &&(\because \blkref{def_H1_pm}\text{ の上の符号}) \\
&= \sum_{m=1}^{M-1}\left[Y_mZ_{m+1},\ Z_j\right] - \left[Y_MZ_1,\ Z_j\right]
   &&(\because \text{交換子の第 1 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{m=1}^{M-1}\left[Y_mZ_{m+1},\ Z_j\right] - 0
   &&(\because \text{上で示した } \left[Y_aZ_b, Z_j\right] = 0\ (b \neq j) \text{ を } a = M,\ b = 1 \neq j \text{ に適用}) \\
&= \sum_{m=1}^{M-1}\left[Y_mZ_{m+1},\ Z_j\right]
   &&(\because \text{零行列を引いても変わらない}) \\
&= \left[Y_{j-1}Z_j,\ Z_j\right] + \sum_{\substack{1 \leq m \leq M-1 \\ m \neq j-1}}\left[Y_mZ_{m+1},\ Z_j\right]
   &&(\because 1 \leq j-1 \leq M-1 \text{ なので } m = j-1 \text{ の項を有限和から分ける}) \\
&= \left[Y_{j-1}Z_j,\ Z_j\right] + \sum_{\substack{1 \leq m \leq M-1 \\ m \neq j-1}} 0
   &&(\because \text{上で示した } \left[Y_aZ_b, Z_j\right] = 0\ (b \neq j) \text{ を } a = m,\ b = m+1 \neq j \text{ として各項へ同時適用}) \\
&= \left[Y_{j-1}Z_j,\ Z_j\right]
   &&(\because \text{零行列の和は零行列}) \\
&= 2Y_{j-1}
   &&(\because \text{上で示した } \left[Y_mZ_{m+1}, Z_{m+1}\right] = 2Y_m \text{ を } m = j-1 \text{ に適用}) \\
&= 2Y_{j-1}^{\flat}
   &&(\because 1 \leq j-1 \leq M \text{ では } Y_{j-1}^{\flat} := Y_{j-1})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`j = 1`),
        " のときは一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_1^{(+)},\ Z_1\right]
&= \left[\sum_{m=1}^{M-1} Y_mZ_{m+1} - Y_MZ_1,\ Z_1\right]
   &&(\because \blkref{def_H1_pm}\text{ の上の符号}) \\
&= \sum_{m=1}^{M-1}\left[Y_mZ_{m+1},\ Z_1\right] + \left[-Y_MZ_1,\ Z_1\right]
   &&(\because \text{交換子の第 1 引数についての加法性}) \\
&= \sum_{m=1}^{M-1} 0 + \left[-Y_MZ_1,\ Z_1\right]
   &&(\because \text{上で示した } \left[Y_aZ_b, Z_j\right] = 0\ (b \neq j) \text{ を } a = m,\ b = m+1 \geq 2,\ j = 1 \text{ として各項へ同時適用}) \\
&= \left[-Y_MZ_1,\ Z_1\right]
   &&(\because \text{零行列の和は零行列}) \\
&= 2\,Y_0^{\flat}
   &&(\because \text{上で示した境界項の等式})
\end{aligned}`,
      ),
      paragraph([
        "であるから、両方の場合が ",
        math(String.raw`[H_1^{(+)}, Z_j] = 2Y_{j-1}^{\flat}`),
        " にまとまる。",
        math(String.raw`H_1^{(+)}`),
        " と ",
        math(String.raw`Y_j`),
        " について、",
        math(String.raw`1 \leq j \leq M-1`),
        " のときは一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_1^{(+)},\ Y_j\right]
&= \left[\sum_{m=1}^{M-1} Y_mZ_{m+1} - Y_MZ_1,\ Y_j\right]
   &&(\because \blkref{def_H1_pm}\text{ の上の符号}) \\
&= \sum_{m=1}^{M-1}\left[Y_mZ_{m+1},\ Y_j\right] - \left[Y_MZ_1,\ Y_j\right]
   &&(\because \text{交換子の第 1 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{m=1}^{M-1}\left[Y_mZ_{m+1},\ Y_j\right] - 0
   &&(\because \text{上で示した } \left[Y_aZ_b, Y_j\right] = 0\ (a \neq j) \text{ を } a = M \neq j,\ b = 1 \text{ に適用}) \\
&= \sum_{m=1}^{M-1}\left[Y_mZ_{m+1},\ Y_j\right]
   &&(\because \text{零行列を引いても変わらない}) \\
&= \left[Y_jZ_{j+1},\ Y_j\right] + \sum_{\substack{1 \leq m \leq M-1 \\ m \neq j}}\left[Y_mZ_{m+1},\ Y_j\right]
   &&(\because 1 \leq j \leq M-1 \text{ なので } m = j \text{ の項を有限和から分ける}) \\
&= \left[Y_jZ_{j+1},\ Y_j\right] + \sum_{\substack{1 \leq m \leq M-1 \\ m \neq j}} 0
   &&(\because \text{上で示した } \left[Y_aZ_b, Y_j\right] = 0\ (a \neq j) \text{ を } a = m \neq j,\ b = m+1 \text{ として各項へ同時適用}) \\
&= \left[Y_jZ_{j+1},\ Y_j\right]
   &&(\because \text{零行列の和は零行列}) \\
&= -2Z_{j+1}
   &&(\because \text{上で示した } \left[Y_mZ_{m+1}, Y_m\right] = -2Z_{m+1} \text{ を } m = j \text{ に適用}) \\
&= -2Z_{j+1}^{\flat}
   &&(\because 2 \leq j+1 \leq M \text{ では } Z_{j+1}^{\flat} := Z_{j+1})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`j = M`),
        " のときは一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_1^{(+)},\ Y_M\right]
&= \left[\sum_{m=1}^{M-1} Y_mZ_{m+1} - Y_MZ_1,\ Y_M\right]
   &&(\because \blkref{def_H1_pm}\text{ の上の符号}) \\
&= \sum_{m=1}^{M-1}\left[Y_mZ_{m+1},\ Y_M\right] + \left[-Y_MZ_1,\ Y_M\right]
   &&(\because \text{交換子の第 1 引数についての加法性}) \\
&= \sum_{m=1}^{M-1} 0 + \left[-Y_MZ_1,\ Y_M\right]
   &&(\because \text{上で示した } \left[Y_aZ_b, Y_j\right] = 0\ (a \neq j) \text{ を } a = m \leq M-1,\ b = m+1,\ j = M \text{ として各項へ同時適用}) \\
&= \left[-Y_MZ_1,\ Y_M\right]
   &&(\because \text{零行列の和は零行列}) \\
&= -2\,Z_{M+1}^{\flat}
   &&(\because \text{上で示した境界項の等式})
\end{aligned}`,
      ),
      paragraph([
        "であるから、両方の場合が ",
        math(String.raw`[H_1^{(+)}, Y_j] = -2Z_{j+1}^{\flat}`),
        " にまとまる。",
      ]),
      paragraph([
        "Step 2（(C)(D)）。交換子は第 2 引数について ",
        math(String.raw`\mathbb{C}`),
        " 線型なので、Step 1 の第 1 式と ",
        ref("def_half_integer_checkZ"),
        " と ",
        ref("def_half_integer_checkY"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_2,\ \check{Z}_\mu\right]
&= \left[H_2,\ \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}Z_j\right]
   &&(\because \blkref{def_half_integer_checkZ}) \\
&= \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\left[H_2,\ Z_j\right]
   &&(\because \text{交換子の第 2 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\left(-2Y_j\right)
   &&(\because \text{Step 1 の第 1 式}) \\
&= -2\sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}Y_j
   &&(\because \text{スカラー倍を和の外へ出す}) \\
&= -2\,\check{Y}_\mu
   &&(\because \blkref{def_half_integer_checkY})
\end{aligned}`,
      ),
      paragraph([
        "（最初と最後の等号は ",
        ref("def_half_integer_checkZ"),
        " と ",
        ref("def_half_integer_checkY"),
        " の ",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " の定義による。）Step 1 の第 2 式 ",
        math(String.raw`[H_2, Y_j] = 2Z_j`),
        " からも、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_2,\ \check{Y}_\mu\right]
&= \left[H_2,\ \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}Y_j\right]
   &&(\because \blkref{def_half_integer_checkY}) \\
&= \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\left[H_2,\ Y_j\right]
   &&(\because \text{交換子の第 2 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\cdot 2Z_j
   &&(\because \text{Step 1 の第 2 式}) \\
&= 2\sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}Z_j
   &&(\because \text{スカラー倍を和の外へ出す}) \\
&= 2\,\check{Z}_\mu
   &&(\because \blkref{def_half_integer_checkZ})
\end{aligned}`,
      ),
      paragraph([
        "を得る。",
      ]),
      paragraph([
        "Step 3（(A)）。主計算に先立ち、添字を ",
        math(String.raw`l := j-1`),
        " と置き換える（",
        math(String.raw`j = 1,\dots,M`),
        " が ",
        math(String.raw`l = 0,\dots,M-1`),
        " に 1 対 1 で対応する）。また、",
        ref("half_integer_phase_antiperiodicity"),
        " の ",
        math(String.raw`e^{-iM\tilde\theta_\mu} = -1`),
        " と ",
        math(String.raw`Y_0^{\flat} = -Y_M`),
        " より、境界の二項は一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
e^{-i\cdot 0\cdot\tilde\theta_\mu}\,Y_0^{\flat}
&= 1\cdot Y_0^{\flat}
   &&(\because e^0=1) \\
&= 1\cdot\left(-Y_M\right)
   &&(\because Y_0^{\flat} := -Y_M) \\
&= \left(-1\right)Y_M
   &&(\because \mathbb{C}\text{ の四則}) \\
&= e^{-iM\tilde\theta_\mu}\,Y_M
   &&(\because \blkref{half_integer_phase_antiperiodicity}) \\
&= e^{-iM\tilde\theta_\mu}\,Y_M^{\flat}
   &&(\because Y_M^{\flat} := Y_M\ (1 \leq M \leq M))
\end{aligned}`,
      ),
      paragraph([
        "となる。この境界項の等式と Step 1 の第 3 式、交換子の線型性を使うと、主張の左辺から一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_1^{(+)},\ \check{Z}_\mu\right]
&= \left[H_1^{(+)},\ \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}Z_j\right]
   &&(\because \blkref{def_half_integer_checkZ}) \\
&= \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\left[H_1^{(+)},\ Z_j\right]
   &&(\because \text{交換子の第 2 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\cdot 2\,Y_{j-1}^{\flat}
   &&(\because \text{Step 1 の第 3 式}) \\
&= 2\sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\,Y_{j-1}^{\flat}
   &&(\because \text{スカラー倍を和の外へ出す}) \\
&= 2\sum_{l=0}^{M-1} e^{-i(l+1)\tilde\theta_\mu}\,Y_l^{\flat}
   &&(\because \text{有限和の添字の付け替え } l=j-1) \\
&= 2\sum_{l=0}^{M-1} e^{-i\tilde\theta_\mu}e^{-il\tilde\theta_\mu}\,Y_l^{\flat}
   &&(\because \blkref{theorem_exp_product}\ (n=1)) \\
&= 2\,e^{-i\tilde\theta_\mu}\sum_{l=0}^{M-1} e^{-il\tilde\theta_\mu}\,Y_l^{\flat}
   &&(\because \text{分配則}) \\
&= 2\,e^{-i\tilde\theta_\mu}\sum_{l=1}^{M} e^{-il\tilde\theta_\mu}\,Y_l^{\flat}
   &&(\because \text{直前の displayMath による } l=0 \text{ の項と } l=M \text{ の項の入れ替え}) \\
&= 2\,e^{-i\tilde\theta_\mu}\sum_{l=1}^{M} e^{-il\tilde\theta_\mu}\,Y_l
   &&(\because 1 \leq l \leq M \text{ では } Y_l^{\flat} = Y_l) \\
&= 2\,e^{-i\tilde\theta_\mu}\,\check{Y}_\mu
   &&(\because \blkref{def_half_integer_checkY})
\end{aligned}`,
      ),
      paragraph([
        "Step 4（(B)）。主計算に先立ち、添字を ",
        math(String.raw`l := j+1`),
        " と置き換える（",
        math(String.raw`j = 1,\dots,M`),
        " が ",
        math(String.raw`l = 2,\dots,M+1`),
        " に 1 対 1 で対応する）。また、",
        ref("half_integer_phase_antiperiodicity"),
        " の ",
        math(String.raw`e^{-iM\tilde\theta_\mu} = -1`),
        " と ",
        math(String.raw`Z_{M+1}^{\flat} = -Z_1`),
        " より、境界の二項は一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
e^{-i(M+1)\tilde\theta_\mu}\,Z_{M+1}^{\flat}
&= e^{-iM\tilde\theta_\mu}\,e^{-i\tilde\theta_\mu}\,Z_{M+1}^{\flat}
   &&(\because \text{theorem\_exp\_product}\ (n=1)) \\
&= e^{-iM\tilde\theta_\mu}\,e^{-i\tilde\theta_\mu}\left(-Z_1\right)
   &&(\because Z_{M+1}^{\flat} := -Z_1) \\
&= \left(-1\right)e^{-i\tilde\theta_\mu}\left(-Z_1\right)
   &&(\because \blkref{half_integer_phase_antiperiodicity}) \\
&= e^{-i\tilde\theta_\mu}\,Z_1
   &&(\because \mathbb{C}\text{ の四則}) \\
&= e^{-i\cdot 1\cdot\tilde\theta_\mu}\,Z_1^{\flat}
   &&(\because Z_1^{\flat} := Z_1)
\end{aligned}`,
      ),
      paragraph([
        "となる。この境界項の等式と Step 1 の第 4 式、交換子の線型性を使うと、主張の左辺から一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_1^{(+)},\ \check{Y}_\mu\right]
&= \left[H_1^{(+)},\ \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}Y_j\right]
   &&(\because \blkref{def_half_integer_checkY}) \\
&= \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\left[H_1^{(+)},\ Y_j\right]
   &&(\because \text{交換子の第 2 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\left(-2\,Z_{j+1}^{\flat}\right)
   &&(\because \text{Step 1 の第 4 式}) \\
&= -2\sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\,Z_{j+1}^{\flat}
   &&(\because \text{スカラー倍を和の外へ出す}) \\
&= -2\sum_{l=2}^{M+1} e^{-i(l-1)\tilde\theta_\mu}\,Z_{l}^{\flat}
   &&(\because \text{有限和の添字の付け替え } l = j+1) \\
&= -2\sum_{l=2}^{M+1} e^{i\tilde\theta_\mu}e^{-il\tilde\theta_\mu}\,Z_{l}^{\flat}
   &&(\because \blkref{theorem_exp_product}\ (n=1)) \\
&= -2\,e^{i\tilde\theta_\mu}\sum_{l=2}^{M+1} e^{-il\tilde\theta_\mu}\,Z_l^{\flat}
   &&(\because \text{分配則}) \\
&= -2\,e^{i\tilde\theta_\mu}\sum_{l=1}^{M} e^{-il\tilde\theta_\mu}\,Z_l^{\flat}
   &&(\because \text{直前の displayMath による } l=M+1 \text{ の項と } l=1 \text{ の項の入れ替え}) \\
&= -2\,e^{i\tilde\theta_\mu}\sum_{l=1}^{M} e^{-il\tilde\theta_\mu}\,Z_l
   &&(\because 1 \leq l \leq M \text{ では } Z_l^{\flat} = Z_l) \\
&= -2\,e^{i\tilde\theta_\mu}\,\check{Z}_\mu
   &&(\because \blkref{def_half_integer_checkZ})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "(A)(B) が成り立つ仕組みは反周期性 e^{-iM θ~_μ} = -1 である。整数運動量では e^{-iM θ_μ} = +1 なので、同じ計算をすると境界項の符号が合わず H_1^{(-)} 側でしか閉じない。ここが (+) と (-) を分ける唯一の点である。",
        "M=2,3,4,5 の全 μ について数値で確認済み（sagemath/check/046_claim_even_sector_modes/check_02_commutators.sage）。",
        "2026-08-15 の式変形統一で、三つの鎖の最終行（= 2Z_j・= 2Y_m・= 2(−Y_M)）に欠けていた行末根拠を補い、単位行列の消去と同類項の統合の圧縮を開いた。内容は変えていない。",
        "2026-08-19 の式変形統一で、境界項二本の鎖にあった「直前の displayMath と同じ計算」の一行を、(Y_M, Z_1) に対する交換子の定義・結合法則・anticommutator_of_Z_and_Y・単位行列・同類項の一操作ずつの行へ開いた。内容・参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },

  {
    id: "evensector_005_claim_anticommutator_check_Z_Y",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: SRC, ordinal: 9 },
    title: { tex: String.raw`\check{Z}, \check{Y} \text{ の反交換関係}` },
    labels: ["anticommutator_of_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`\mu, \nu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      displayMath(
        String.raw`\left[\check{Z}_\mu, \check{Z}_\nu\right]_+ = 2M\,\delta_{\nu,\,M+1-\mu}\,I,
\qquad
\left[\check{Z}_\mu, \check{Y}_\nu\right]_+ = 0,
\qquad
\left[\check{Y}_\mu, \check{Y}_\nu\right]_+ = 2M\,\delta_{\nu,\,M+1-\mu}\,I`,
      ),
      paragraph([
        "が成り立つ。ここで ",
        math(String.raw`I := I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        "、",
        math(String.raw`\delta_{\nu,\,M+1-\mu}`),
        " は通常のクロネッカーのデルタ（",
        math(String.raw`\nu = M+1-\mu`),
        " のとき ",
        math(String.raw`1`),
        "、そうでないとき ",
        math(String.raw`0`),
        "）である。",
      ]),
      paragraph([
        "**対になる添字に合同式が現れない**のは、添字の範囲を ",
        math(String.raw`\check{\mathcal{M}}`),
        " に絞ったからである：",
        ref("def_check_index_set"),
        " (5) により ",
        math(String.raw`\mu,\nu \in \check{\mathcal{M}}`),
        " では ",
        math(String.raw`\mu+\nu \equiv 1 \pmod M`),
        " と ",
        math(String.raw`\nu = M+1-\mu`),
        " が同値である。",
      ]),
    ],
    proof: [
      paragraph([
        "反交換子は両引数について ",
        math(String.raw`\mathbb{C}`),
        " 双線型（",
        math(String.raw`[\alpha X,\beta W]_+ = \alpha\beta[X,W]_+`),
        "）なので、",
        ref("def_half_integer_checkZ"),
        "、",
        ref("anticommutator_of_Z_and_Y"),
        "、",
        ref("theorem_exp_product"),
        "、",
        ref("exp_sum"),
        "、",
        ref("def_delta_M"),
        "、",
        ref("def_check_index_set"),
        " (5) を順に使うと、第 1 式は主張の左辺から一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{Z}_\mu, \check{Z}_\nu\right]_+
&= \left[\sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}Z_j,\ \sum_{k=1}^{M} e^{-ik\tilde\theta_\nu}Z_k\right]_+
   &&\bigl(\because \blkref{def_half_integer_checkZ}\bigr) \\
&= \sum_{j=1}^{M}\sum_{k=1}^{M} e^{-ij\tilde\theta_\mu}\,e^{-ik\tilde\theta_\nu}
   \left[Z_j, Z_k\right]_+
   &&\bigl(\because \text{反交換子の } \mathbb{C} \text{ 双線型性}\bigr) \\
&= \sum_{j=1}^{M}\sum_{k=1}^{M} e^{-ij\tilde\theta_\mu}\,e^{-ik\tilde\theta_\nu}\cdot 2I\,\delta^M_{(j,k)}
   &&\bigl(\because \text{anticommutator\_of\_Z\_and\_Y}\bigr) \\
&= 2I\sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\,e^{-ij\tilde\theta_\nu}
   &&\bigl(\because 1 \leq j,k \leq M \text{ では } \delta^M_{(j,k)} = 1 \iff j = k\bigr) \\
&= 2I\sum_{j=1}^{M} e^{-ij\left(\tilde\theta_\mu + \tilde\theta_\nu\right)}
   &&\bigl(\because \text{theorem\_exp\_product}\ (n=1)\bigr) \\
&= 2I\sum_{j=1}^{M} \exp\!\left(\frac{2\pi i j\left(-(\mu+\nu-1)\right)}{M}\right)
   &&\bigl(\because \tilde\theta_\mu + \tilde\theta_\nu = \tfrac{2\pi(\mu+\nu-1)}{M}\bigr) \\
&= 2M I\,\delta^M_{(-(\mu+\nu-1),\,0)}
   &&\bigl(\because \text{exp\_sum}\bigr) \\
&= 2M I\,\delta^M_{(\mu+\nu,\,1)}
   &&\bigl(\because \text{def\_delta\_M}\bigr) \\
&= 2M\,\delta_{\nu,\,M+1-\mu}\,I
   &&\bigl(\because \text{def\_check\_index\_set (5)}\ (\mu,\nu \in \check{\mathcal{M}})\bigr)
\end{aligned}`,
      ),
      paragraph([
        "第 2 式は、",
        ref("def_half_integer_checkZ"),
        " と ",
        ref("def_half_integer_checkY"),
        " と ",
        ref("anticommutator_of_Z_and_Y"),
        " の ",
        math(String.raw`[Z_j,Y_k]_+=0`),
        " を使うと、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{Z}_\mu,\check{Y}_\nu\right]_+
&= \left[\sum_{j=1}^{M}e^{-ij\tilde\theta_\mu}Z_j,\ \sum_{k=1}^{M}e^{-ik\tilde\theta_\nu}Y_k\right]_+
   &&\bigl(\because \blkref{def_half_integer_checkZ},\ \blkref{def_half_integer_checkY}\bigr) \\
&= \sum_{j=1}^{M}\sum_{k=1}^{M}e^{-ij\tilde\theta_\mu}e^{-ik\tilde\theta_\nu}[Z_j,Y_k]_+
   &&\bigl(\because \text{反交換子の }\mathbb{C}\text{ 双線型性}\bigr) \\
&= \sum_{j=1}^{M}\sum_{k=1}^{M}e^{-ij\tilde\theta_\mu}e^{-ik\tilde\theta_\nu}\cdot 0
   &&\bigl(\because \text{anticommutator\_of\_Z\_and\_Y}\bigr) \\
&= 0
   &&\bigl(\because \mathbb{C}\text{ の四則}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "第 3 式も、",
        ref("def_half_integer_checkY"),
        "、",
        ref("anticommutator_of_Z_and_Y"),
        " の ",
        math(String.raw`[Y_j,Y_k]_+ = 2I\,\delta^M_{(j,k)}`),
        " と、第 1 式で使った ",
        ref("theorem_exp_product"),
        "、",
        ref("exp_sum"),
        "、",
        ref("def_delta_M"),
        "、",
        ref("def_check_index_set"),
        " (5) を順に使うと、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{Y}_\mu,\check{Y}_\nu\right]_+
&= \left[\sum_{j=1}^{M}e^{-ij\tilde\theta_\mu}Y_j,\ \sum_{k=1}^{M}e^{-ik\tilde\theta_\nu}Y_k\right]_+
   &&\bigl(\because \blkref{def_half_integer_checkY}\bigr) \\
&= \sum_{j=1}^{M}\sum_{k=1}^{M}e^{-ij\tilde\theta_\mu}e^{-ik\tilde\theta_\nu}[Y_j,Y_k]_+
   &&\bigl(\because \text{反交換子の }\mathbb{C}\text{ 双線型性}\bigr) \\
&= \sum_{j=1}^{M}\sum_{k=1}^{M}e^{-ij\tilde\theta_\mu}e^{-ik\tilde\theta_\nu}\cdot 2I\,\delta^M_{(j,k)}
   &&\bigl(\because \text{anticommutator\_of\_Z\_and\_Y}\bigr) \\
&= 2I\sum_{j=1}^{M}e^{-ij\tilde\theta_\mu}e^{-ij\tilde\theta_\nu}
   &&\bigl(\because 1\le j,k\le M\text{ では }\delta^M_{(j,k)}=1\iff j=k\bigr) \\
&= 2I\sum_{j=1}^{M}e^{-ij(\tilde\theta_\mu+\tilde\theta_\nu)}
   &&\bigl(\because \text{theorem\_exp\_product}\ (n=1)\bigr) \\
&= 2I\sum_{j=1}^{M}\exp\!\left(\frac{2\pi i j\left(-(\mu+\nu-1)\right)}{M}\right)
   &&\bigl(\because \tilde\theta_\mu+\tilde\theta_\nu=\tfrac{2\pi(\mu+\nu-1)}{M}\bigr) \\
&= 2M I\,\delta^M_{(-(\mu+\nu-1),\,0)}
   &&\bigl(\because \text{exp\_sum}\bigr) \\
&= 2M I\,\delta^M_{(\mu+\nu,\,1)}
   &&\bigl(\because \text{def\_delta\_M}\bigr) \\
&= 2M\,\delta_{\nu,\,M+1-\mu}\,I
   &&\bigl(\because \text{def\_check\_index\_set (5)}\ (\mu,\nu\in\check{\mathcal M})\bigr)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },

  {
    id: "evensector_006_claim_recover_Z_Y",
    kind: "claim",
    origin: { path: SRC, ordinal: 10 },
    title: { tex: String.raw`\check{Z}, \check{Y} \text{ から } Z_j, Y_j \text{ を復元する}` },
    labels: ["recover_Z_Y_from_check_Z_Y"],
    statement: [
      paragraph([math(String.raw`j \in \{1,\dots,M\}`), " について"]),
      displayMath(
        String.raw`Z_j = \frac{1}{M}\sum_{\mu=1}^{M} \check{Z}_\mu\,e^{i j\tilde\theta_\mu},
\qquad
Y_j = \frac{1}{M}\sum_{\mu=1}^{M} \check{Y}_\mu\,e^{i j\tilde\theta_\mu}`,
      ),
      paragraph([
        "が成り立つ。とくに ",
        math(String.raw`\check{Z}_1,\dots,\check{Z}_M,\check{Y}_1,\dots,\check{Y}_M`),
        " は ",
        ref("Z_Y_generate_algebra"),
        " の ",
        math(String.raw`Z_j, Y_j`),
        " を生成するので、",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " を（単位的 ",
        math(String.raw`\mathbb{C}`),
        " 代数として）生成する。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、",
        math(String.raw`j, k \in \{1,\dots,M\}`),
        " のとき ",
        math(String.raw`|j-k| \leq M-1 < M`),
        " なので、",
        ref("antiperiodic_exp_sum"),
        " を指数の整数 ",
        math(String.raw`j-k`),
        " に適用する。まず ",
        math(String.raw`j = k`),
        " のときは",
      ]),
      displayMath(
        String.raw`\begin{aligned}
j-k
&=0
&&(\because\ j=k\text{ と }\mathbb Z\text{ の減法})\\
&=0\cdot M
&&(\because\ \mathbb Z\text{ の乗法})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`(-1)^0 = 1`),
        "、",
        math(String.raw`j \neq k`),
        " のときは ",
        math(String.raw`|j-k| < M`),
        " かつ ",
        math(String.raw`j-k \neq 0`),
        " なので ",
        math(String.raw`j-k \not\equiv 0 \pmod M`),
        " である。したがって",
      ]),
      displayMath(
        String.raw`\sum_{\mu=1}^{M} e^{i(j-k)\tilde\theta_\mu}
= \begin{cases}
M & (j = k) \\
0 & (j \neq k)
\end{cases}`,
      ),
      paragraph([
        "である。第 1 式は、",
        ref("def_half_integer_checkZ"),
        " と ",
        ref("theorem_exp_product"),
        " と準備の等式を順に使うと、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{M}\sum_{\mu=1}^{M}\check{Z}_\mu\,e^{ij\tilde\theta_\mu}
&= \frac{1}{M}\sum_{\mu=1}^{M}\left(\sum_{k=1}^{M} Z_k\,e^{-ik\tilde\theta_\mu}\right)e^{ij\tilde\theta_\mu}
&&(\because \blkref{def_half_integer_checkZ}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M}\sum_{k=1}^{M} Z_k\,e^{-ik\tilde\theta_\mu}\,e^{ij\tilde\theta_\mu}
&&(\because \text{有限和への分配}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M}\sum_{k=1}^{M} Z_k\,e^{i(j-k)\tilde\theta_\mu}
&&(\because \text{theorem\_exp\_product}\ (n=1)) \\
&= \frac{1}{M}\sum_{k=1}^{M} Z_k \sum_{\mu=1}^{M} e^{i(j-k)\tilde\theta_\mu}
&&(\because \text{有限和の順序交換}) \\
&= \frac{1}{M}\cdot Z_j\cdot M
&&(\because \text{準備の等式により } k = j \text{ の項だけが残る}) \\
&= Z_j
&&(\because M\ne 0\text{ なのでスカラー }\tfrac{1}{M}\text{ と }M\text{ が相殺する})
\end{aligned}`,
      ),
      paragraph([
        "第 2 式も、",
        ref("def_half_integer_checkY"),
        " の ",
        math(String.raw`\check{Y}_\mu`),
        " の定義から同じ根拠の並びで、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{M}\sum_{\mu=1}^{M}\check{Y}_\mu\,e^{ij\tilde\theta_\mu}
&= \frac{1}{M}\sum_{\mu=1}^{M}\left(\sum_{k=1}^{M} Y_k\,e^{-ik\tilde\theta_\mu}\right)e^{ij\tilde\theta_\mu}
&&(\because \blkref{def_half_integer_checkY}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M}\sum_{k=1}^{M} Y_k\,e^{-ik\tilde\theta_\mu}\,e^{ij\tilde\theta_\mu}
&&(\because \text{有限和への分配}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M}\sum_{k=1}^{M} Y_k\,e^{i(j-k)\tilde\theta_\mu}
&&(\because \text{theorem\_exp\_product}\ (n=1)) \\
&= \frac{1}{M}\sum_{k=1}^{M} Y_k \sum_{\mu=1}^{M} e^{i(j-k)\tilde\theta_\mu}
&&(\because \text{有限和の順序交換}) \\
&= \frac{1}{M}\cdot Y_j\cdot M
&&(\because \text{準備の等式により } k = j \text{ の項だけが残る}) \\
&= Y_j
&&(\because M\ne 0\text{ なのでスカラー }\tfrac{1}{M}\text{ と }M\text{ が相殺する})
\end{aligned}`,
      ),
      paragraph([
        "生成性については、",
        ref("Z_Y_generate_algebra"),
        " が ",
        math(String.raw`Z_j, Y_j`),
        " の生成性を主張しており、いま示した式は各 ",
        math(String.raw`Z_j, Y_j`),
        " が ",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " の ",
        math(String.raw`\mathbb{C}`),
        " 線型結合であることを与えるので、",
        math(String.raw`\check{Z}, \check{Y}`),
        " の生成する部分代数は ",
        math(String.raw`Z_j, Y_j`),
        " をすべて含み、したがって全体に一致する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-08-15 の式変形統一で、復元式の鎖の最終行へスカラー 1/M と M の相殺という行末根拠を補った。内容は変えていない。",
        "2026-08-19 の式変形統一で、二つの displayMath と間の散文に分かれていた復元式の導出を、準備の指数和等式と一続き六段の鎖へまとめ、「Y_j についても同じ計算」と畳まれていた第 2 式を同じ形の鎖へ開いた。内容・参照は変えていない。",
        "2026-08-31 の式変形統一で、準備の散文に埋まっていた j-k=0=0M を、整数の減法と乗法を一つずつ適用する二段の鎖へ開いた。内容・参照は変えていない。",
        "2026-08-31 の式変形統一で、三本の鎖に行中の \\quad(\\because …) で置かれていた根拠 14 行を、他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。内容・参照は変えていない。",
      ],
    },
  },

  {
    id: "evensector_007_claim_H1_H2_via_check_Z_Y",
    kind: "claim",
    origin: { path: SRC, ordinal: 11 },
    title: { tex: String.raw`H_1^{(+)}, H_2 \text{ を } \check{Z}, \check{Y} \text{ で表す}` },
    labels: ["H1_H2_via_check_Z_Y"],
    statement: [
      displayMath(
        String.raw`H_1^{(+)} = \frac{1}{M}\sum_{\mu=1}^{M} \check{Y}_\mu\,\check{Z}_{M+1-\mu}\,e^{-i\tilde\theta_\mu},
\qquad
H_2 = \frac{1}{M}\sum_{\mu=1}^{M} \check{Z}_{M+1-\mu}\,\check{Y}_\mu`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`H_1^{(+)}`),
        " は ",
        ref("def_H1_pm"),
        " で上の符号を取ったもの、",
        math(String.raw`H_2`),
        " は ",
        ref("def_H2"),
        " のもの）。和の添字 ",
        math(String.raw`\mu`),
        " も共役添字 ",
        math(String.raw`M+1-\mu`),
        " も ",
        ref("def_check_index_set"),
        " (2) により ",
        math(String.raw`\check{\mathcal{M}}`),
        " の中にとどまる。",
      ]),
    ],
    proof: [
      paragraph([
        "まず ",
        ref("def_half_integer_checkZ"),
        " と ",
        ref("conjugate_index_of_check_Z_Y"),
        " (2) から ",
        math(String.raw`\check{Z}_{M+1-\mu}`),
        " の表示を用意する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Z}_{M+1-\mu}
&= \sum_{k=1}^{M} Z_k\,e^{-ik\tilde\theta_{M+1-\mu}}
&& (\because \blkref{def_half_integer_checkZ}) \\
&= \sum_{k=1}^{M} Z_k\,e^{ik\tilde\theta_\mu}
&& (\because \text{conjugate\_index\_of\_check\_Z\_Y (2)})
\end{aligned}`,
      ),
      paragraph([
        "次に ",
        math(String.raw`1 \leq j,k \leq M`),
        " より ",
        math(String.raw`|k-j| < M`),
        " なので、",
        ref("antiperiodic_exp_sum"),
        " より内側の和は ",
        math(String.raw`k = j`),
        " のとき ",
        math(String.raw`M`),
        "、そうでないとき ",
        math(String.raw`0`),
        " である。これと ",
        ref("def_half_integer_checkZ"),
        " と ",
        ref("def_half_integer_checkY"),
        "、",
        ref("theorem_exp_product"),
        "、",
        ref("def_H2"),
        " を順に使うと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{M}\sum_{\mu=1}^{M}\check{Z}_{M+1-\mu}\check{Y}_\mu
&= \frac{1}{M}\sum_{\mu=1}^{M}\left(\sum_{k=1}^{M}Z_k e^{ik\tilde\theta_\mu}\right)
   \left(\sum_{j=1}^{M}Y_j e^{-ij\tilde\theta_\mu}\right)
&& (\because \text{準備した }\check Z_{M+1-\mu}\text{ の表示と }\blkref{def_half_integer_checkY}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M}\sum_{k=1}^{M}\sum_{j=1}^{M} Z_kY_j\,
   e^{ik\tilde\theta_\mu}e^{-ij\tilde\theta_\mu}
&& (\because \text{積を二重和へ分配}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M}\sum_{k=1}^{M}\sum_{j=1}^{M} Z_kY_j\,
   e^{i(k-j)\tilde\theta_\mu}
&& (\because \text{theorem\_exp\_product}\ (n=1)) \\
&= \frac{1}{M}\sum_{k=1}^{M}\sum_{j=1}^{M} Z_kY_j
   \sum_{\mu=1}^{M} e^{i(k-j)\tilde\theta_\mu}
&& (\because \text{有限和の順序交換}) \\
&= \frac{1}{M}\sum_{j=1}^{M} Z_jY_j\cdot M
&& (\because \text{antiperiodic\_exp\_sum}) \\
&= \sum_{j=1}^{M} Z_jY_j
&& (\because \text{スカラー } \tfrac{1}{M} \text{ と } M \text{ の相殺}) \\
&= H_2
&& (\because \blkref{def_H2})
\end{aligned}`,
      ),
      paragraph([
        "もう一方の式の準備として、",
        math(String.raw`1 \leq j,k \leq M`),
        " より ",
        math(String.raw`j-k+1`),
        " は ",
        math(String.raw`2-M`),
        " 以上 ",
        math(String.raw`M`),
        " 以下である。",
        ref("antiperiodic_exp_sum"),
        " より、内側の和が ",
        math(String.raw`0`),
        " でないのは ",
        math(String.raw`j-k+1 = lM`),
        " のときに限り、この範囲では ",
        math(String.raw`l = 0`),
        " と ",
        math(String.raw`l = 1`),
        " だけが可能である。",
      ]),
      list([
        [
          math(String.raw`l = 0`),
          "、すなわち ",
          math(String.raw`k = j+1`),
          "（",
          math(String.raw`k \leq M`),
          " より ",
          math(String.raw`1 \leq j \leq M-1`),
          "）。このとき内側の和は ",
          math(String.raw`M(-1)^0 = M`),
          "。",
        ],
        [
          math(String.raw`l = 1`),
          "、すなわち ",
          math(String.raw`j-k+1 = M`),
          "。",
          math(String.raw`1\leq j,k\leq M`),
          " でこれを満たすのは ",
          math(String.raw`j = M,\ k = 1`),
          " のみ。このとき内側の和は ",
          math(String.raw`M(-1)^1 = -M`),
          "。",
        ],
      ]),
      paragraph([
        "したがって、",
        ref("def_half_integer_checkZ"),
        " と ",
        ref("def_half_integer_checkY"),
        "、",
        ref("theorem_exp_product"),
        "、",
        ref("def_H1_pm"),
        " を順に使うと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{M}\sum_{\mu=1}^{M}\check{Y}_\mu\check{Z}_{M+1-\mu}e^{-i\tilde\theta_\mu}
&= \frac{1}{M}\sum_{\mu=1}^{M}\left(\sum_{j=1}^{M}Y_j e^{-ij\tilde\theta_\mu}\right)
   \left(\sum_{k=1}^{M}Z_k e^{ik\tilde\theta_\mu}\right) e^{-i\tilde\theta_\mu}
&& (\because \blkref{def_half_integer_checkY}\text{ と準備した } \check{Z}_{M+1-\mu} \text{ の表示}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M}\sum_{j=1}^{M}\sum_{k=1}^{M} Y_jZ_k\,
   e^{-ij\tilde\theta_\mu}e^{ik\tilde\theta_\mu}e^{-i\tilde\theta_\mu}
&& (\because \text{積を二重和へ分配}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M}\sum_{j=1}^{M}\sum_{k=1}^{M} Y_jZ_k\,
   e^{-i(j-k+1)\tilde\theta_\mu}
&& (\because \text{theorem\_exp\_product}\ (n=1)) \\
&= \frac{1}{M}\sum_{j=1}^{M}\sum_{k=1}^{M} Y_jZ_k
   \sum_{\mu=1}^{M} e^{-i(j-k+1)\tilde\theta_\mu}
&& (\because \text{有限和の順序交換}) \\
&= \frac{1}{M}\left(\sum_{j=1}^{M-1} Y_jZ_{j+1}\cdot M + Y_MZ_1\cdot(-M)\right)
&& (\because \text{antiperiodic\_exp\_sum と直上の 2 つの場合分け}) \\
&= \sum_{j=1}^{M-1} Y_jZ_{j+1} - Y_MZ_1
&& (\because \text{スカラー } \tfrac{1}{M} \text{ の分配と } \tfrac{1}{M}\cdot M = 1,\ \tfrac{1}{M}\cdot(-M) = -1 \text{ の相殺}) \\
&= H_1^{(+)}
&& (\because \blkref{def_H1_pm}\text{ の上の符号})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "境界項 -Y_M Z_1 の符号が、antiperiodic_exp_sum の l=1 の因子 (-1)^1 として自動的に出てくる。整数運動量版 H1_H2_via_hatZ_hatY で hat(Z)^{(±)} の第 1 項の符号が担っていた役割を、ここでは指数和の符号が担っている。",
        "2026-08-19 の式変形統一で、H_2 と H_1^{(+)} の導出を分断していた説明・重複した参照を準備へ移し、それぞれ主張の右辺から H_2・H_1^{(+)} へ至る一続きの鎖へまとめた。内容・参照は変えていない。",
        "2026-09-01 の式変形統一で、三本の鎖に行中の \\quad(\\because …) で置かれていた根拠 16 行を、他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。内容・式変形・根拠・参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
]);
