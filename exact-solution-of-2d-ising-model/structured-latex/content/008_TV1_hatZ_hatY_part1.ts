import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

// 章「T_{V_1}(hat Z) と hat Z, hat Y の関係」の前半（文書順）。
// 収録範囲は parts/008 の 000〜017, 036, 018, 019（文書順はソースのファイル名連番と
// 一致しないため、ファイル名に連番範囲は入れない）。並びが文書順の正準表現。
export default defineBlocks([
  {
    id: "heading_TV1_hatZ_hatY",
    kind: "heading",
    level: 2,
    origin: { path: "_old/typst/main.typ", ordinal: 10 },
    title: { tex: String.raw`T_{V_1}(\hat{Z})\text{と}\hat{Z},\hat{Y}\text{の関係}` },
    labels: [],
  },
  {
    id: "TV1_hatZ_hatY_001_claim_commutator_H_Z_Y",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/000_claim_H1_H2とhatZ_hatYの交換関係.typ",
      ordinal: 1,
    },
    title: { tex: String.raw`H_1^{(\pm)}, H_2 \text{ と } \hat{Z}_\mu^{(\pm)}, \hat{Y}_\mu \text{ の交換関係}` },
    labels: ["commutator_of_H_and_Z_Y"],
    statement: [
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(
        String.raw`\begin{aligned}
[H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]
&= 2 e^{-i 2\pi\mu/M} \hat{Y}_\mu \\
[H_1^{(\pm)}, \hat{Z}_\mu^{(\mp)}]
&= 2 e^{-i 2\pi\mu/M} \hat{Y}_\mu \\
[H_1^{(\pm)}, \hat{Y}_\mu]
&= -2 e^{i 2\pi\mu/M} \hat{Z}_\mu^{(\pm)} \\
[H_2, \hat{Z}_\mu^{(-)}]
&= -2 \hat{Y}_\mu \\
[H_2, \hat{Z}_\mu^{(+)}]
&= -2 \hat{Y}_\mu + \frac{4}{M}\sum_{j\in\{1,\dots,M\}}
   e^{-i \frac{2\pi}{M}(-j+\mu)}\,\hat{Y}_j \\
[H_2, \hat{Y}_\mu]
&= 2 \hat{Z}_\mu^{(-)}
\end{aligned}`,
      ),
    ],
    proof: [
      paragraph([
        "以下の各変形では ",
        ref("H1_H2_via_hatZ_hatY"),
        " の表式と ",
        ref("anticommutator_of_hat_Z_and_hat_Y"),
        " の反交換関係を用いる。",
      ]),
      paragraph([
        "(1) ",
        math(String.raw`[H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]`),
        " について、",
        math(String.raw`\mu \in \mathcal{M}`),
        " を任意に取る。準備として次の 3 つを先に用意する。",
      ]),
      paragraph([
        "準備 1（",
        math(String.raw`\hat{Y}`),
        " の ",
        math(String.raw`M`),
        " ずれ）。",
        math(String.raw`\nu \in \mathbb{Z}`),
        " について、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\hat{Y}_{\nu+M}
&= \sum_{j=1}^{M} Y_j \exp\!\left(-i\frac{2\pi j(\nu+M)}{M}\right)
&&(\because\ \text{$\hat{Z}, \hat{Y}$ の定義})\\
&= \sum_{j=1}^{M} Y_j \exp\!\left(-i\frac{2\pi j\nu}{M}\right)\exp\!\left(-i 2\pi j\right)
&&(\because\ \text{指数法則})\\
&= \sum_{j=1}^{M} Y_j \exp\!\left(-i\frac{2\pi j\nu}{M}\right)\cdot 1
&&(\because\ j \in \mathbb{Z}\ \text{でのオイラーの公式}\ \text{（$\hat{Z}_M^{(-)}=\hat{Z}_{-M}^{(-)},\ \hat{Y}_M=\hat{Y}_{-M}$ と同じ計算）})\\
&= \hat{Y}_{\nu}
&&(\because\ \text{$\hat{Z}, \hat{Y}$ の定義})
\end{aligned}`,
      ),
      paragraph([
        "準備 2（指数の ",
        math(String.raw`M`),
        " ずれ）。",
        math(String.raw`\nu \in \mathbb{Z}`),
        " について、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp\!\left(-i\frac{2\pi(\nu+M)}{M}\right)
&= \exp\!\left(-i\frac{2\pi\nu}{M}\right)\exp\!\left(-i 2\pi\right)
&&(\because\ \text{指数法則})\\
&= \exp\!\left(-i\frac{2\pi\nu}{M}\right)\cdot 1
&&(\because\ \text{オイラーの公式})\\
&= \exp\!\left(-i\frac{2\pi\nu}{M}\right)
&&(\because\ \text{複素数の四則})
\end{aligned}`,
      ),
      paragraph([
        "準備 3（和に残る ",
        math(String.raw`j`),
        " の決定）。",
        math(String.raw`j \in \{1,\dots,M\}`),
        " かつ ",
        math(String.raw`-j+\mu \equiv 0 \pmod{M}`),
        " を満たす ",
        math(String.raw`j`),
        " はちょうど 1 つであり、",
      ]),
      displayMath(
        String.raw`j = \begin{cases}
M & (\mu = -M) \\
M+\mu & (-M+1 \leq \mu \leq -1) \\
\mu & (1 \leq \mu \leq M)
\end{cases}
\qquad (\because\ 1 \leq j \leq M\ \text{と合同式の条件})`,
      ),
      paragraph([
        "また、",
        math(String.raw`\hat{Z}_\mu^{(\pm)}\hat{Y}_j = -\hat{Y}_j\hat{Z}_\mu^{(\pm)}`),
        " である（",
        ref("anticommutator_of_hat_Z_and_hat_Y"),
        " の ",
        math(String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Y}_\nu]_+ = 0`),
        " を移項したもの）。以上のもとで、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]
&= \left(\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}e^{-i\frac{2\pi j}{M}}\right)\hat{Z}_\mu^{(\pm)}
   - \hat{Z}_\mu^{(\pm)}\left(\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}e^{-i\frac{2\pi j}{M}}\right)
&&(\because\ \text{$H_1^{(\pm)}, H_2$ を $\hat{Z}, \hat{Y}$ で表す、と交換子の定義})\\
&= \frac{1}{M}\left(\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\pm)}
   - \sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Z}_\mu^{(\pm)}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \text{有限和と行列の積の分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(e^{-i\frac{2\pi j}{M}}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\pm)}
   - e^{-i\frac{2\pi j}{M}}\hat{Z}_\mu^{(\pm)}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \text{有限和どうしの差は項ごとの差の和})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\left(\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\pm)}
   - \hat{Z}_\mu^{(\pm)}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \text{分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\left(\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\pm)}
   + \hat{Y}_j\hat{Z}_\mu^{(\pm)}\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \hat{Z}_\mu^{(\pm)}\hat{Y}_j = -\hat{Y}_j\hat{Z}_\mu^{(\pm)}\ \text{すなわち $\hat{Z}$ と $\hat{Y}$ の反交換関係})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\left(\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\pm)}
   + \hat{Z}_\mu^{(\pm)}\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \text{分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\,[\hat{Z}_{-j}^{(\pm)},\hat{Z}_\mu^{(\pm)}]_+
&&(\because\ \text{反交換子の定義})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\left(2M\,\delta^M_{-j+\mu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
&&(\because\ \text{$\hat{Z}$ と $\hat{Y}$ の反交換関係の}\ [\hat{Z},\hat{Z}]_+\ \text{の値})\\
&= 2\sum_{j\in\{1,\dots,M\}} \delta^M_{-j+\mu,0}\, e^{-i\frac{2\pi j}{M}}\hat{Y}_j
&&(\because\ \text{単位行列との積とスカラーの整理})\\
&= 2\sum_{\substack{j\in\{1,\dots,M\}\\ -j+\mu\equiv 0 \pmod{M}}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j
&&(\because\ \text{$\delta^M$ の定義})\\
&= 2\begin{cases}
e^{-i\frac{2\pi M}{M}}\hat{Y}_M & (\mu = -M) \\
e^{-i\frac{2\pi(M+\mu)}{M}}\hat{Y}_{M+\mu} & (-M+1 \leq \mu \leq -1) \\
e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu & (1 \leq \mu \leq M)
\end{cases}
&&(\because\ \text{準備 3})\\
&= 2\, e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu
&&(\because\ \text{準備 1 と準備 2}\ (\nu = \mu\ \text{または}\ \nu = -M))
\end{aligned}`,
      ),
      paragraph([
        "引いたブロックは ",
        ref("def_hatZ_hatY"),
        "、",
        ref("hatZ_hatY_M_periodicity"),
        "、",
        ref("H1_H2_via_hatZ_hatY"),
        "、",
        ref("anticommutator_of_hat_Z_and_hat_Y"),
        "、",
        ref("def_delta_M"),
        " である。",
      ]),
      paragraph([
        "(2) ",
        math(String.raw`[H_1^{(\pm)}, \hat{Z}_\mu^{(\mp)}]`),
        " について、",
        math(String.raw`\mu \in \mathcal{M}`),
        " を任意に取る。準備 1 と準備 2 に加えて、次の 3 つを先に用意する。",
      ]),
      paragraph([
        "準備 4（",
        math(String.raw`H_1^{(\pm)}`),
        " の表式）。",
      ]),
      displayMath(
        String.raw`H_1^{(\pm)}
= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(\hat{Y}_j\,\hat{Z}_{-j}^{(\pm)}\,e^{-i\frac{2\pi j}{M}}\right)
\qquad (\because\ \text{$H_1^{(\pm)}, H_2$ を $\hat{Z}, \hat{Y}$ で表す})`,
      ),
      paragraph([
        "準備 5（反交換関係の移項）。",
        math(String.raw`j \in \{1,\dots,M\}`),
        " について ",
        math(String.raw`\hat{Z}_\mu^{(\mp)}\hat{Y}_j = -\hat{Y}_j\hat{Z}_\mu^{(\mp)}`),
        " である（",
        ref("anticommutator_of_hat_Z_and_hat_Y"),
        " の ",
        math(String.raw`[\hat{Z}_\mu^{(\mp)}, \hat{Y}_j]_+ = 0`),
        " を移項したもの）。",
      ]),
      paragraph([
        "準備 6（第 1 項の和に残る ",
        math(String.raw`j`),
        " の決定）。",
        math(String.raw`j \in \{1,\dots,M\}`),
        " かつ ",
        math(String.raw`-j+\mu \equiv 0 \pmod{M}`),
        " を満たす ",
        math(String.raw`j`),
        " はちょうど 1 つであり、",
      ]),
      displayMath(
        String.raw`j = \begin{cases}
2M+\mu & (\mu = -M) \\
M+\mu & (-M+1 \leq \mu \leq -1) \\
\mu & (1 \leq \mu \leq M)
\end{cases}
\qquad (\because\ 1 \leq j \leq M\ \text{と合同式の条件})`,
      ),
      paragraph(["以上のもとで、"]),
      displayMath(
        String.raw`\begin{aligned}
[H_1^{(\pm)}, \hat{Z}_\mu^{(\mp)}]
&= \left[\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(\hat{Y}_j\,\hat{Z}_{-j}^{(\pm)}\,e^{-i\frac{2\pi j}{M}}\right),\ \hat{Z}_\mu^{(\mp)}\right]
&&(\because\ \text{準備 4})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left[\hat{Y}_j\hat{Z}_{-j}^{(\pm)}e^{-i\frac{2\pi j}{M}},\ \hat{Z}_\mu^{(\mp)}\right]
&&(\because\ \text{交換子の定義と、有限和・スカラー倍についての分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\left[\hat{Y}_j\hat{Z}_{-j}^{(\pm)},\ \hat{Z}_\mu^{(\mp)}\right]
&&(\because\ \text{スカラー倍を交換子の外へ出した})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\left(\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\mp)}
   - \hat{Z}_\mu^{(\mp)}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \text{交換子の定義})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\left(\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\mp)}
   + \hat{Y}_j\hat{Z}_\mu^{(\mp)}\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \text{準備 5})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\left(\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\mp)}
   + \hat{Z}_\mu^{(\mp)}\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \text{分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\,[\hat{Z}_{-j}^{(\pm)},\hat{Z}_\mu^{(\mp)}]_+
&&(\because\ \text{反交換子の定義})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\left(
   2M\,\delta^M_{-j+\mu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
   + \left(-2\,e^{-i\frac{2\pi}{M}(-j+\mu)}\cdot 2\,I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)\right)
&&(\because\ \text{$\hat{Z}$ と $\hat{Y}$ の反交換関係の}\ [\hat{Z}^{(\pm)},\hat{Z}^{(\mp)}]_+\ \text{の値})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\left(2M\,\delta^M_{-j+\mu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
   + \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\left(-2\,e^{-i\frac{2\pi}{M}(-j+\mu)}\cdot 2\,I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
&&(\because\ \text{分配則と、有限和の項ごとの分割})\\
&= 2\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\,\delta^M_{-j+\mu,0}
   - \frac{4}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}-i\frac{2\pi}{M}(-j+\mu)}\hat{Y}_j
&&(\because\ \text{単位行列との積とスカラーの整理、および指数法則})\\
&= 2\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\,\delta^M_{-j+\mu,0}
   - \frac{4}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi\mu}{M}}\hat{Y}_j
&&(\because\ \text{指数の中の}\ j\ \text{が打ち消し合う})\\
&= 2\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\,\delta^M_{-j+\mu,0}
   - \frac{4}{M} e^{-i\frac{2\pi\mu}{M}}\sum_{j\in\{1,\dots,M\}} \hat{Y}_j
&&(\because\ j\ \text{によらない因子を有限和の外へ出した})\\
&= 2\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\,\delta^M_{-j+\mu,0}
   - \frac{4}{M} e^{-i\frac{2\pi\mu}{M}}\sum_{j\in\{1,\dots,M\}}\sum_{k=1}^{M} Y_k\, e^{-i k\frac{2\pi j}{M}}
&&(\because\ \text{$\hat{Z}, \hat{Y}$ の定義})\\
&= 2\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\,\delta^M_{-j+\mu,0}
   - \frac{4}{M} e^{-i\frac{2\pi\mu}{M}}\sum_{k=1}^{M} Y_k\sum_{j\in\{1,\dots,M\}} e^{-i k\frac{2\pi j}{M}}
&&(\because\ \text{有限和の順序の入れ替えと、$k$ によらない因子を内側の和の外へ出した})\\
&= 2\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\,\delta^M_{-j+\mu,0}
   - \frac{4}{M} e^{-i\frac{2\pi\mu}{M}}\sum_{k=1}^{M} Y_k\, M\,\delta^M_{(k,0)}
&&(\because\ \text{指数和の公式})\\
&= 2\begin{cases}
e^{-i\frac{2\pi(2M+\mu)}{M}}\hat{Y}_{2M+\mu} & (\mu = -M) \\
e^{-i\frac{2\pi(M+\mu)}{M}}\hat{Y}_{M+\mu} & (-M+1 \leq \mu \leq -1) \\
e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu & (1 \leq \mu \leq M)
\end{cases} - 0
&&\left(\because\ \begin{aligned}
&\text{第 1 項は準備 6}\\
&\text{第 2 項は原文が}\ 0\ \text{とおいている}
\end{aligned}\right)\\
&= 2\, e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu
&&(\because\ \text{準備 1 と準備 2}\ (\nu = \mu\ \text{または}\ \nu = M+\mu))
\end{aligned}`,
      ),
      paragraph([
        "指数和の公式は ",
        ref("exp_sum"),
        " による。第 2 項を ",
        math(String.raw`0`),
        " とおく段は、原文の扱いをそのまま写したものであり、本文では確かめていない。",
      ]),
      paragraph([
        "引いたブロックは ",
        ref("def_hatZ_hatY"),
        "、",
        ref("hatZ_hatY_M_periodicity"),
        "、",
        ref("H1_H2_via_hatZ_hatY"),
        "、",
        ref("anticommutator_of_hat_Z_and_hat_Y"),
        "、",
        ref("def_delta_M"),
        "、",
        ref("exp_sum"),
        " である。",
      ]),
      paragraph([
        "(3) ",
        math(String.raw`[H_1^{(\pm)}, \hat{Y}_\mu]`),
        " について、",
        math(String.raw`\mu \in \mathcal{M}`),
        " を任意に取る。準備として次の 3 つを先に用意する。",
      ]),
      paragraph([
        "準備 1（",
        math(String.raw`\hat{Z}^{(\pm)}`),
        " の ",
        math(String.raw`M`),
        " ずれ）。",
        math(String.raw`\nu \in \mathbb{Z}`),
        " について、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\hat{Z}_{\nu+M}^{(\pm)}
&= \sum_{j=1}^{M} Z_j^{(\pm)} \exp\!\left(-i\frac{2\pi j(\nu+M)}{M}\right)
&&(\because\ \text{$\hat{Z}, \hat{Y}$ の定義})\\
&= \sum_{j=1}^{M} Z_j^{(\pm)} \exp\!\left(-i\frac{2\pi j\nu}{M}\right)\exp\!\left(-i 2\pi j\right)
&&(\because\ \text{指数法則})\\
&= \sum_{j=1}^{M} Z_j^{(\pm)} \exp\!\left(-i\frac{2\pi j\nu}{M}\right)\cdot 1
&&(\because\ j \in \mathbb{Z}\ \text{でのオイラーの公式}\ \text{（$\hat{Z}_M^{(-)}=\hat{Z}_{-M}^{(-)}$ と同じ計算）})\\
&= \hat{Z}_{\nu}^{(\pm)}
&&(\because\ \text{$\hat{Z}, \hat{Y}$ の定義})
\end{aligned}`,
      ),
      paragraph([
        "準備 2（指数の ",
        math(String.raw`M`),
        " ずれ）。(1) の準備 2 をそのまま使う。すなわち ",
        math(String.raw`\nu \in \mathbb{Z}`),
        " について ",
        math(String.raw`\exp\!\left(-i\frac{2\pi(\nu+M)}{M}\right) = \exp\!\left(-i\frac{2\pi\nu}{M}\right)`),
        " である。",
      ]),
      paragraph([
        "準備 3（和に残る ",
        math(String.raw`j`),
        " の決定）。",
        math(String.raw`j \in \{1,\dots,M\}`),
        " かつ ",
        math(String.raw`j+\mu \equiv 0 \pmod{M}`),
        " を満たす ",
        math(String.raw`j`),
        " はちょうど 1 つであり、",
      ]),
      displayMath(
        String.raw`j = \begin{cases}
-\mu & (\mu \leq -1) \\
M-\mu & (1 \leq \mu \leq M-1) \\
M & (\mu = M)
\end{cases}
\qquad (\because\ 1 \leq j \leq M\ \text{と合同式の条件})`,
      ),
      paragraph([
        "また、",
        math(String.raw`\hat{Z}_{-j}^{(\pm)}\hat{Y}_\mu = -\hat{Y}_\mu\hat{Z}_{-j}^{(\pm)}`),
        " である（",
        ref("anticommutator_of_hat_Z_and_hat_Y"),
        " の ",
        math(String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Y}_\nu]_+ = 0`),
        " を移項したもの）。以上のもとで、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[H_1^{(\pm)}, \hat{Y}_\mu]
&= \left(\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}e^{-i\frac{2\pi j}{M}}\right)\hat{Y}_\mu
   - \hat{Y}_\mu\left(\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}e^{-i\frac{2\pi j}{M}}\right)
&&(\because\ \text{$H_1^{(\pm)}, H_2$ を $\hat{Z}, \hat{Y}$ で表す、と交換子の定義})\\
&= \frac{1}{M}\left(\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Y}_\mu
   - \sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_\mu\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \text{有限和と行列の積の分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(e^{-i\frac{2\pi j}{M}}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Y}_\mu
   - e^{-i\frac{2\pi j}{M}}\hat{Y}_\mu\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \text{有限和どうしの差は項ごとの差の和})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\left(\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Y}_\mu
   - \hat{Y}_\mu\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \text{分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\left(-\hat{Y}_j\hat{Y}_\mu\hat{Z}_{-j}^{(\pm)}
   - \hat{Y}_\mu\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \hat{Z}_{-j}^{(\pm)}\hat{Y}_\mu = -\hat{Y}_\mu\hat{Z}_{-j}^{(\pm)}\ \text{すなわち $\hat{Z}$ と $\hat{Y}$ の反交換関係})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\left(-\hat{Y}_j\hat{Y}_\mu
   - \hat{Y}_\mu\hat{Y}_j\right)\hat{Z}_{-j}^{(\pm)}
&&(\because\ \text{分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\left(-[\hat{Y}_j,\hat{Y}_\mu]_+\right)\hat{Z}_{-j}^{(\pm)}
&&(\because\ \text{反交換子の定義})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\left(-2M\,\delta^M_{j+\mu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)\hat{Z}_{-j}^{(\pm)}
&&(\because\ \text{$\hat{Z}$ と $\hat{Y}$ の反交換関係の}\ [\hat{Y},\hat{Y}]_+\ \text{の値})\\
&= -2\sum_{j\in\{1,\dots,M\}} \delta^M_{j+\mu,0}\, e^{-i\frac{2\pi j}{M}}\hat{Z}_{-j}^{(\pm)}
&&(\because\ \text{単位行列との積とスカラーの整理})\\
&= -2\sum_{\substack{j\in\{1,\dots,M\}\\ j+\mu\equiv 0 \pmod{M}}} e^{-i\frac{2\pi j}{M}}\hat{Z}_{-j}^{(\pm)}
&&(\because\ \text{$\delta^M$ の定義})\\
&= -2\begin{cases}
e^{-i\frac{2\pi(-\mu)}{M}}\hat{Z}_{-(-\mu)}^{(\pm)} & (\mu \leq -1) \\
e^{-i\frac{2\pi(M-\mu)}{M}}\hat{Z}_{-(M-\mu)}^{(\pm)} & (1 \leq \mu \leq M-1) \\
e^{-i\frac{2\pi M}{M}}\hat{Z}_{-M}^{(\pm)} & (\mu = M)
\end{cases}
&&(\because\ \text{準備 3})\\
&= -2\, e^{-i\frac{2\pi(-\mu)}{M}}\hat{Z}_{\mu}^{(\pm)}
&&(\because\ \text{準備 1 と準備 2}\ \text{（$1 \leq \mu \leq M-1$ では $\nu = -\mu$ として 1 度、$\mu = M$ では $\nu = -M, 0$ として 2 度当てる）})\\
&= -2\, e^{i\frac{2\pi\mu}{M}}\hat{Z}_{\mu}^{(\pm)}
&&(\because\ \text{指数の符号の整理})
\end{aligned}`,
      ),
      paragraph([
        "引いたブロックは ",
        ref("def_hatZ_hatY"),
        "、",
        ref("hatZ_hatY_M_periodicity"),
        "、",
        ref("H1_H2_via_hatZ_hatY"),
        "、",
        ref("anticommutator_of_hat_Z_and_hat_Y"),
        "、",
        ref("def_delta_M"),
        " である。",
      ]),
      paragraph([
        "(4) ",
        math(String.raw`[H_2, \hat{Z}_\mu^{(\pm)}]`),
        " について、",
        math(String.raw`\mu \in \mathcal{M}`),
        " を任意に取る。準備として次の 3 つを先に用意する。",
      ]),
      paragraph([
        "準備 1（",
        math(String.raw`\hat{Z}`),
        " と ",
        math(String.raw`\hat{Y}`),
        " の入れ替え）。",
        math(String.raw`\hat{Z}_\mu^{(\pm)}\hat{Y}_j = -\hat{Y}_j\hat{Z}_\mu^{(\pm)}`),
        " である（",
        ref("anticommutator_of_hat_Z_and_hat_Y"),
        " の ",
        math(String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Y}_\nu]_+ = 0`),
        " を移項したもの）。",
      ]),
      paragraph([
        "準備 2（和に残る ",
        math(String.raw`j`),
        " の決定）。",
        math(String.raw`j \in \{1,\dots,M\}`),
        " かつ ",
        math(String.raw`-j+\mu \equiv 0 \pmod{M}`),
        " を満たす ",
        math(String.raw`j`),
        " はちょうど 1 つであり、",
      ]),
      displayMath(
        String.raw`j = \begin{cases}
M & (\mu = -M) \\
M+\mu & (-M+1 \leq \mu \leq -1) \\
\mu & (1 \leq \mu \leq M)
\end{cases}
\qquad (\because\ 1 \leq j \leq M\ \text{と合同式の条件})`,
      ),
      paragraph([
        "準備 3（",
        math(String.raw`\hat{Y}`),
        " の ",
        math(String.raw`M`),
        " 周期性）。",
        math(String.raw`\nu \in \mathbb{Z}`),
        " について ",
        math(String.raw`\hat{Y}_{\nu+M} = \hat{Y}_\nu`),
        " である（",
        ref("hatZ_hatY_M_periodicity"),
        "）。以上のもとで、まず ",
        math(String.raw`\hat{Z}`),
        " の符号によらず次まで進む。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[H_2, \hat{Z}_\mu^{(\pm)}]
&= \left(\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)\hat{Z}_\mu^{(\pm)}
   - \hat{Z}_\mu^{(\pm)}\left(\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)
&&(\because\ \text{$H_1^{(\pm)}, H_2$ を $\hat{Z}, \hat{Y}$ で表す、と交換子の定義})\\
&= \frac{1}{M}\left(\left(\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)\hat{Z}_\mu^{(\pm)}
   - \hat{Z}_\mu^{(\pm)}\left(\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)\right)
&&(\because\ \text{スカラー倍は行列の積と可換に動かせる})\\
&= \frac{1}{M}\left(\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\hat{Z}_\mu^{(\pm)}
   - \sum_{j\in\{1,\dots,M\}}\hat{Z}_\mu^{(\pm)}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)
&&(\because\ \text{有限和と行列の積の分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(\hat{Z}_{-j}^{(-)}\hat{Y}_j\hat{Z}_\mu^{(\pm)}
   - \hat{Z}_\mu^{(\pm)}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)
&&(\because\ \text{有限和どうしの差は項ごとの差の和})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-\hat{Z}_{-j}^{(-)}\hat{Z}_\mu^{(\pm)}\hat{Y}_j
   - \hat{Z}_\mu^{(\pm)}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)
&&(\because\ \text{準備 1})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-\hat{Z}_{-j}^{(-)}\hat{Z}_\mu^{(\pm)}
   - \hat{Z}_\mu^{(\pm)}\hat{Z}_{-j}^{(-)}\right)\hat{Y}_j
&&(\because\ \text{分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-[\hat{Z}_{-j}^{(-)},\hat{Z}_\mu^{(\pm)}]_+\right)\hat{Y}_j
&&(\because\ \text{反交換子の定義})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-[\hat{Z}_\mu^{(\pm)},\hat{Z}_{-j}^{(-)}]_+\right)\hat{Y}_j
&&(\because\ \text{反交換子は 2 つの引数の順序を入れ替えても変わらない})
\end{aligned}`,
      ),
      paragraph([
        "以下、",
        math(String.raw`\hat{Z}`),
        " の符号で分岐する（反交換子 ",
        math(String.raw`[\hat{Z}_\mu^{(\pm)},\hat{Z}_\nu^{(\pm)}]_+`),
        " と ",
        math(String.raw`[\hat{Z}_\mu^{(\pm)},\hat{Z}_\nu^{(\mp)}]_+`),
        " の値が違うためである。",
        ref("anticommutator_of_hat_Z_and_hat_Y"),
        "）。",
      ]),
      paragraph([
        "(4.1) ",
        math(String.raw`[H_2, \hat{Z}_\mu^{(-)}]`),
        " について：",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-[\hat{Z}_\mu^{(-)},\hat{Z}_{-j}^{(-)}]_+\right)\hat{Y}_j
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-2M\,\delta^M_{-j+\mu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)\hat{Y}_j
&&(\because\ \text{$\hat{Z}$ と $\hat{Y}$ の反交換関係の}\ [\hat{Z}^{(\pm)},\hat{Z}^{(\pm)}]_+\ \text{の値})\\
&= -2\sum_{j\in\{1,\dots,M\}}\delta^M_{-j+\mu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}\,\hat{Y}_j
&&(\because\ \text{スカラーの整理})\\
&= -2\sum_{\substack{j\in\{1,\dots,M\}\\ -j+\mu\equiv 0 \pmod{M}}} \hat{Y}_j
&&(\because\ \text{$\delta^M$ の定義と単位行列との積})\\
&= -2\begin{cases}
\hat{Y}_M & (\mu = -M) \\
\hat{Y}_{M+\mu} & (-M+1 \leq \mu \leq -1) \\
\hat{Y}_\mu & (1 \leq \mu \leq M)
\end{cases}
&&(\because\ \text{準備 2})\\
&= -2\,\hat{Y}_\mu
&&(\because\ \text{準備 3}\ \text{（$\mu=-M$ では $\nu=0,-M$ として 2 度、$-M+1\leq\mu\leq-1$ では $\nu=\mu$ として 1 度当てる）})
\end{aligned}`,
      ),
      paragraph([
        "(4.2) ",
        math(String.raw`[H_2, \hat{Z}_\mu^{(+)}]`),
        " について：",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-[\hat{Z}_\mu^{(+)},\hat{Z}_{-j}^{(-)}]_+\right)\hat{Y}_j \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(
   -\left(2M\,\delta^M_{-j+\mu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
   + \left(-2\,e^{-i\frac{2\pi}{M}(-j+\mu)}\cdot 2\,I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)\right)\right)\hat{Y}_j
&&(\because\ \text{$\hat{Z}$ と $\hat{Y}$ の反交換関係の}\ [\hat{Z}^{(\pm)},\hat{Z}^{(\mp)}]_+\ \text{の値を}\ \nu=-j\ \text{で使う})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(
   -2M\,\delta^M_{-j+\mu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
   + 4\,e^{-i\frac{2\pi}{M}(-j+\mu)}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)\hat{Y}_j
&&(\because\ \text{括弧の展開（負号を両項へ配る）と複素数の四則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-2M\,\delta^M_{-j+\mu,0}\,\hat{Y}_j
   + 4\,e^{-i\frac{2\pi}{M}(-j+\mu)}\,\hat{Y}_j\right)
&&(\because\ \text{分配則と単位行列との積})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-2M\,\delta^M_{-j+\mu,0}\,\hat{Y}_j\right)
   + \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(4\,e^{-i\frac{2\pi}{M}(-j+\mu)}\,\hat{Y}_j\right)
&&(\because\ \text{項ごとの和の有限和は有限和どうしの和})\\
&= -2\sum_{\substack{j\in\{1,\dots,M\}\\ -j+\mu\equiv 0 \pmod{M}}}\hat{Y}_j
   + \frac{4}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi}{M}(-j+\mu)}\,\hat{Y}_j
&&(\because\ \text{$\delta^M$ の定義とスカラーの整理})\\
&= -2\begin{cases}
\hat{Y}_M & (\mu = -M) \\
\hat{Y}_{M+\mu} & (-M+1 \leq \mu \leq -1) \\
\hat{Y}_\mu & (1 \leq \mu \leq M)
\end{cases}
   + \frac{4}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi}{M}(-j+\mu)}\,\hat{Y}_j
&&(\because\ \text{準備 2})\\
&= -2\,\hat{Y}_\mu
   + \frac{4}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi}{M}(-j+\mu)}\,\hat{Y}_j
&&(\because\ \text{準備 3}\ \text{（$\mu=-M$ では $\nu=0,-M$ として 2 度、$-M+1\leq\mu\leq-1$ では $\nu=\mu$ として 1 度当てる）})
\end{aligned}`,
      ),
      paragraph([
        "第 2 項は消えない。",
        math(String.raw`\hat{Y}_j`),
        " の定義を入れて ",
        math(String.raw`j`),
        " について和を取ると ",
        math(String.raw`4\,e^{-i\frac{2\pi\mu}{M}}\,Y_1`),
        " になる（",
        ref("why_008_applies_only_to_minus_sector"),
        " が ",
        math(String.raw`\left[H_2,\hat{Z}_\mu^{(+)}\right] = -2\hat{Y}_\mu + 4\,e^{-i\frac{2\pi\mu}{M}}\,Y_1`),
        " として使っている形である）。",
        "すなわち ",
        math(String.raw`[H_2, \hat{Z}_\mu^{(+)}] \neq -2\hat{Y}_\mu`),
        " であり、(4.1) と同じ形にはならない。",
      ]),
      paragraph([
        "(5) ",
        math(String.raw`[H_2, \hat{Y}_\mu]`),
        " について、",
        math(String.raw`\mu \in \mathcal{M}`),
        " を任意に取る。準備として次の 3 つを先に用意する",
        "（以下この (5) の中でだけ準備 1〜3 と呼ぶ）。",
      ]),
      paragraph([
        "準備 1（",
        math(String.raw`\hat{Y}`),
        " と ",
        math(String.raw`\hat{Z}`),
        " の入れ替え）。",
        math(String.raw`\hat{Y}_\mu\hat{Z}_{-j}^{(-)} = -\hat{Z}_{-j}^{(-)}\hat{Y}_\mu`),
        " である（",
        ref("anticommutator_of_hat_Z_and_hat_Y"),
        " の ",
        math(String.raw`[\hat{Z}_\nu^{(\pm)}, \hat{Y}_{\nu'}]_+ = 0`),
        " を移項したもの）。",
      ]),
      paragraph([
        "準備 2（和に残る ",
        math(String.raw`j`),
        " の決定）。",
        math(String.raw`j \in \{1,\dots,M\}`),
        " かつ ",
        math(String.raw`j+\mu \equiv 0 \pmod{M}`),
        " を満たす ",
        math(String.raw`j`),
        " はちょうど 1 つであり、",
      ]),
      displayMath(
        String.raw`j = \begin{cases}
-\mu & (-M \leq \mu \leq -1) \\
M-\mu & (1 \leq \mu \leq M-1) \\
M & (\mu = M)
\end{cases}
\qquad (\because\ 1 \leq j \leq M\ \text{と合同式の条件})`,
      ),
      paragraph([
        "準備 3（",
        math(String.raw`\hat{Z}`),
        " の ",
        math(String.raw`M`),
        " 周期性）。",
        math(String.raw`\nu \in \mathbb{Z}`),
        " について ",
        math(String.raw`\hat{Z}_{\nu+M}^{(-)} = \hat{Z}_\nu^{(-)}`),
        " である（",
        ref("hatZ_hatY_M_periodicity"),
        "）。以上のもとで、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[H_2, \hat{Y}_\mu]
&= \left(\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)\hat{Y}_\mu
   - \hat{Y}_\mu\left(\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)
&&(\because\ \text{$H_1^{(\pm)}, H_2$ を $\hat{Z}, \hat{Y}$ で表す、と交換子の定義})\\
&= \frac{1}{M}\left(\left(\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)\hat{Y}_\mu
   - \hat{Y}_\mu\left(\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)\right)
&&(\because\ \text{スカラー倍は行列の積と可換に動かせる})\\
&= \frac{1}{M}\left(\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\hat{Y}_\mu
   - \sum_{j\in\{1,\dots,M\}}\hat{Y}_\mu\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)
&&(\because\ \text{有限和と行列の積の分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(\hat{Z}_{-j}^{(-)}\hat{Y}_j\hat{Y}_\mu
   - \hat{Y}_\mu\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)
&&(\because\ \text{有限和どうしの差は項ごとの差の和})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(\hat{Z}_{-j}^{(-)}\hat{Y}_j\hat{Y}_\mu
   + \hat{Z}_{-j}^{(-)}\hat{Y}_\mu\hat{Y}_j\right)
&&(\because\ \text{準備 1})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\left(\hat{Y}_j\hat{Y}_\mu
   + \hat{Y}_\mu\hat{Y}_j\right)
&&(\because\ \text{行列の積の分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\,[\hat{Y}_j,\hat{Y}_\mu]_+
&&(\because\ \text{反交換子の定義})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}
   \left(2M\,\delta^M_{j+\mu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
&&(\because\ \text{$\hat{Z}$ と $\hat{Y}$ の反交換関係の}\ [\hat{Y},\hat{Y}]_+\ \text{の値})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} 2M\,\delta^M_{j+\mu,0}\,\hat{Z}_{-j}^{(-)}
&&(\because\ \text{単位行列との積と、スカラー倍を行列の前へ出すこと})\\
&= 2\sum_{\substack{j\in\{1,\dots,M\}\\ j+\mu\equiv 0 \pmod{M}}} \hat{Z}_{-j}^{(-)}
&&(\because\ \text{$\delta^M$ の定義とスカラーの整理})\\
&= 2\begin{cases}
\hat{Z}_\mu^{(-)} & (-M \leq \mu \leq -1) \\
\hat{Z}_{-M+\mu}^{(-)} & (1 \leq \mu \leq M-1) \\
\hat{Z}_{-M}^{(-)} & (\mu = M)
\end{cases}
&&(\because\ \text{準備 2})\\
&= 2\,\hat{Z}_\mu^{(-)}
&&(\because\ \text{準備 3}\ \text{（$-M\leq\mu\leq-1$ では使わず、$1\leq\mu\leq M-1$ では $\nu=-M+\mu$ として 1 度、$\mu=M$ では $\nu=-M,0$ として 2 度当てる）})
\end{aligned}`,
      ),
      paragraph([
        "引いたブロックは ",
        ref("hatZ_hatY_M_periodicity"),
        "、",
        ref("H1_H2_via_hatZ_hatY"),
        "、",
        ref("anticommutator_of_hat_Z_and_hat_Y"),
        "、",
        ref("def_delta_M"),
        " である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(C^2)^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、(C^2)^{⊗M} を数ベクトル空間 C^{2^M} へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文の全計算過程を各ステップ忠実に翻訳。statement に原文にある [H2, hatZ^(+)] の関係式を追加した。",
        "(1) [H1, hatZ^(±)] の式変形を一続きの鎖へ書き換えた（2026-08-11）。H_1 の表式を overbrace の地の文で示していたのをやめて行末の根拠へ移し、j の決定・Ŷ と指数の M ずれを準備として先に置き、原文が式のあとの日本語で述べていた最後の等号（場合分けから 2 e^{-i2πμ/M} Ŷ_μ へ）も同じ鎖の中に入れた。全 12 段へ根拠を付けた。段は減らしていない（増えている）。",
        "(4) [H2, hatZ^(±)] の符号によらない共通部分と (4.1)（Ẑ^(-) の場合）を一続きの鎖へ書き換えた（2026-08-11）。H_2 の表式を overbrace の地の文で示していたのをやめて行末の根拠へ移し、Ẑ と Ŷ の入れ替え・和に残る j の決定・Ŷ の M 周期性を準備として先に置き、全段（共通部分 8 段、(4.1) 5 段）に根拠を付けた。段は減らしていない（増えている）。",
        "(4.2) [H2, hatZ^(+)] は、原文の式が誤っていたので**中身を直したうえで**一続きの鎖へ書き換えた（2026-08-11）。誤りは第 2 段で、-[Ẑ_μ^(+), Ẑ_{-j}^(-)]_+ を展開するとき負号を第 2 項へ配っておらず（反交換子の値は 007 の claim「Ẑ, Ŷ の反交換関係」の第 2 式 [Ẑ^(±),Ẑ^(∓)]_+ = 2Mδ I + (-2e^{...}·2I) なので、負号を付けた値は -2Mδ I + 4e^{...} I である）、さらに次の段で係数の ·2 が落ちていた。原本（_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/000_claim_H1_H2とhatZ_hatYの交換関係.typ の 3.2 の節）にも同じ式が書かれており、移行時の誤りではなく原文側の誤りである。正しい結論は [H_2, Ẑ_μ^(+)] = -2Ŷ_μ + (4/M)Σ_{j=1}^{M} e^{-i2π(-j+μ)/M} Ŷ_j であり、statement もこの値へ直した（原文は第 2 項を -(2/M)Σ_j e^{...}Ŷ_j としており、符号と係数の両方が違っていた）。鎖は 7 段で全段に根拠を付けてある。",

        "(5) [H2, hatY] を一続きの鎖へ書き換えた（2026-08-11）。H_2 の表式を overbrace の地の文で示していたのをやめて行末の根拠へ移し、Ŷ と Ẑ の入れ替え・和に残る j の決定・Ẑ の M 周期性を準備として先に置き、鎖の途中に割り込んでいた (∵ …) も行末の根拠へ揃えた。反交換子の値を入れる段と単位行列を消す段を分け、最後の場合分けから 2 Ẑ_μ^(-) へ至る段にも根拠を付けて、全 12 段に根拠がある形にした。段は減らしていない（増えている）。場合分けの第 1 の場合の範囲は μ ≤ -1 と書かれていたのを -M ≤ μ ≤ -1 と書いた（μ ∈ 𝓜 の範囲を書き下しただけで、中身は変えていない）。",        "この修正が下流を壊さないことを確かめた（2026-08-11）。この主張を引いているのは 012_free_energy・013_even_sector_modes・014_even_sector_T_action の 6 箇所で、いずれも (C) [H_2, Ẑ_μ^(-)] = -2Ŷ_μ の側だけを使っており、誤っていた [H_2, Ẑ_μ^(+)] の値には依存していない。むしろ 013 の claim「008 章が (-) セクターにしか使えない理由」は [H_2, Ẑ_μ^(+)] = -2Ŷ_μ + 4e^{-i2πμ/M} Y_1 を独立に導いており、これは今回直した値と一致する（Ŷ_j の定義を入れて j について和を取ると (4/M)Σ_j e^{-i2π(-j+μ)/M} Ŷ_j = 4e^{-i2πμ/M} Y_1）。つまり修正前は 008 と 013 が食い違っていた。",
        "(2) [H1, hatZ^(∓)] の最終段で原文は第2項（-4/M e^{-i2πμ/M} Σ_k Y_k M δ^M_{(k,0)}）を 0 として結論しているが、この項は一般に消えず（k=M で δ=1）、原文の該当ステップの正当化は不完全。忠実性のため原文どおり `- 0` を残した。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_002_claim_nesting_commutator",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/001_claim_交換子のネスト.typ",
      ordinal: 2,
    },
    title: null,
    labels: ["nesting_of_commutator_of_H_and_Z"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`\mu \in \mathcal{M}`),
        " とする。以下に現れる ",
        math(String.raw`H_1^{(\pm)}, H_2, \hat{Z}_\mu^{(\pm)}, \hat{Y}_\mu`),
        " はすべて結合代数 ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の元であり（",
        ref("H1_H2_via_hatZ_hatY"),
        "、",
        ref("def_hatZ_hatY"),
        "）、",
        math(String.raw`K_1, K_2^* \in \mathbb{R}`),
        " はスカラー、",
        math(String.raw`[X, Y] := XY - YX`),
        " は同代数の交換子である。",
      ]),
      paragraph([
        "また、",
        math(String.raw`X \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " を固定するごとに ",
        math(String.raw`n`),
        " 重の交換子を",
      ]),
      displayMath(
        String.raw`\underbrace{[X,\dots,[X, W]\dots]}_{n}
:= \underbrace{\mathrm{ad}_X \circ \cdots \circ \mathrm{ad}_X}_{n}(W),
\qquad \mathrm{ad}_X(W) := [X, W]`,
      ),
      paragraph([
        "と定める（",
        math(String.raw`\mathrm{ad}_X : \mathrm{Mat}(2^M,\mathbb{C}) \to \mathrm{Mat}(2^M,\mathbb{C})`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " 線型写像）。とくに ",
        math(String.raw`n = 0`),
        " の場合は恒等写像であり、0 重の交換子の値は作用素そのもの ",
        math(String.raw`W`),
        " である。",
      ]),
      paragraph(["(h1.z)"]),
      displayMath(
        String.raw`\underbrace{[K_1 H_1^{(\pm)}, \dots, [K_1 H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]\dots]}_{n}
= \begin{cases}
(-1)^{(n-1)/2}(2K_1)^n e^{-i 2\pi\mu/M} \hat{Y}_\mu & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_1)^n \hat{Z}_\mu^{(\pm)} & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["（ただし ",  math(String.raw`n=0`), " のとき値は ", math(String.raw`\hat{Z}_\mu^{(\pm)}`), "）"]),
      paragraph(["(h1.y)"]),
      displayMath(
        String.raw`\underbrace{[K_1 H_1^{(\pm)}, \dots, [K_1 H_1^{(\pm)}, \hat{Y}_\mu]\dots]}_{n}
= \begin{cases}
(-1)^{(n+1)/2}(2K_1)^n e^{i 2\pi\mu/M} \hat{Z}_\mu^{(\pm)} & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_1)^n \hat{Y}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["（ただし ", math(String.raw`n=0`), " のとき値は ", math(String.raw`\hat{Y}_\mu`), "）"]),
      paragraph(["(h2.z−)"]),
      displayMath(
        String.raw`\underbrace{[K_2^* H_2, \dots, [K_2^* H_2, \hat{Z}_\mu^{(-)}]\dots]}_{n}
= \begin{cases}
(-1)^{(n+1)/2}(2K_2^*)^n \hat{Y}_\mu & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_2^*)^n \hat{Z}_\mu^{(-)} & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["（ただし ", math(String.raw`n=0`), " のとき値は ", math(String.raw`\hat{Z}_\mu^{(-)}`), "）"]),
      paragraph(["(h2.y)"]),
      displayMath(
        String.raw`\underbrace{[K_2^* H_2, \dots, [K_2^* H_2, \hat{Y}_\mu]\dots]}_{n}
= \begin{cases}
(-1)^{(n-1)/2}(2K_2^*)^n \hat{Z}_\mu^{(-)} & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_2^*)^n \hat{Y}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["（ただし ", math(String.raw`n=0`), " のとき値は ", math(String.raw`\hat{Y}_\mu`), "）"]),
    ],
    proof: [
      paragraph([
        "以下、",
        math(String.raw`\theta := \dfrac{2\pi\mu}{M} \in \mathbb{R}`),
        " と略記する。証明はすべて ",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " に関する帰納法であり、帰納段階では ",
        ref("commutator_of_H_and_Z_Y"),
        " の 1 重の交換子の公式",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\text{(A)}\quad [H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}] &= 2 e^{-i\theta}\hat{Y}_\mu, &
\text{(B)}\quad [H_1^{(\pm)}, \hat{Y}_\mu] &= -2 e^{i\theta}\hat{Z}_\mu^{(\pm)}, \\
\text{(C)}\quad [H_2, \hat{Z}_\mu^{(-)}] &= -2\,\hat{Y}_\mu, &
\text{(D)}\quad [H_2, \hat{Y}_\mu] &= 2\,\hat{Z}_\mu^{(-)}
\end{aligned}`,
      ),
      paragraph([
        "と、交換子の第 1 引数・第 2 引数についての ",
        math(String.raw`\mathbb{C}`),
        " 双線型性",
      ]),
      displayMath(
        String.raw`[\alpha X, \beta W] = \alpha\beta\,[X, W]
\qquad (\alpha, \beta \in \mathbb{C},\ X, W \in \mathrm{Mat}(2^M,\mathbb{C}))`,
      ),
      paragraph([
        "のみを用いる。後者は次の一続きの計算による（スカラー倍が積と可換なことは ",
        ref("scalar_identity_commutes"),
        " による）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[\alpha X, \beta W]
&= (\alpha X)(\beta W) - (\beta W)(\alpha X)
&&(\because\ \text{交換子の定義})\\
&= \alpha\beta\,(XW) - \beta\alpha\,(WX)
&&(\because\ \text{スカラー倍が積と可換なこと})\\
&= \alpha\beta\,(XW - WX)
&&(\because\ \mathbb{C}\ \text{の積の可換則}\ \beta\alpha=\alpha\beta\ \text{と分配則})\\
&= \alpha\beta\,[X, W]
&&(\because\ \text{交換子の定義})
\end{aligned}`,
      ),
      paragraph([
        "各主張の右辺は ",
        math(String.raw`n`),
        " の偶奇で場合分けされているので、帰納段階は「",
        math(String.raw`n`),
        " 偶数 → ",
        math(String.raw`n+1`),
        " 奇数」「",
        math(String.raw`n`),
        " 奇数 → ",
        math(String.raw`n+1`),
        " 偶数」の 2 通りを別々に示す。",
      ]),

      paragraph([
        "(h1.z) の証明。",
        math(String.raw`C_n := \underbrace{[K_1 H_1^{(\pm)},\dots,[K_1 H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]\dots]}_{n}`),
        " とおく。定義より ",
        math(String.raw`C_{n+1} = [K_1 H_1^{(\pm)},\, C_n]`),
        " が ",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について成り立つ。",
      ]),
      paragraph([
        "基底段階（",
        math(String.raw`n = 0`),
        "、偶数）。",
        math(String.raw`C_0`),
        " から主張の偶数側の右辺へ至る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
C_0
&= \hat{Z}_\mu^{(\pm)}
&&(\because\ 0\ \text{重の交換子の規約}) \\
&= 1\cdot 1\cdot\hat{Z}_\mu^{(\pm)}
&&(\because\ 1\ \text{はスカラー倍の単位元}) \\
&= (-1)^{0/2}(2K_1)^{0}\hat{Z}_\mu^{(\pm)}
&&(\because\ \alpha^{0}=1\ \text{を}\ \alpha=-1\ \text{と}\ \alpha=2K_1\ \text{へ})
\end{aligned}`,
      ),
      paragraph([
        "帰納段階 1（",
        math(String.raw`n`),
        " 偶数 → ",
        math(String.raw`n+1`),
        " 奇数）。",
        math(String.raw`n`),
        " が偶数で ",
        math(String.raw`C_n = (-1)^{n/2}(2K_1)^n\hat{Z}_\mu^{(\pm)}`),
        " と仮定する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
C_{n+1}
&= \left[K_1 H_1^{(\pm)},\ C_n\right]
&&(\because\ n\ \text{重の交換子の定義}) \\
&= \left[K_1 H_1^{(\pm)},\ (-1)^{n/2}(2K_1)^n\hat{Z}_\mu^{(\pm)}\right]
&&(\because\ \text{帰納法の仮定}) \\
&= K_1\cdot(-1)^{n/2}(2K_1)^n\left[H_1^{(\pm)},\ \hat{Z}_\mu^{(\pm)}\right]
&&(\because\ \text{交換子の双線型性}) \\
&= K_1\cdot(-1)^{n/2}(2K_1)^n\cdot 2 e^{-i\theta}\hat{Y}_\mu
&&(\because\ \text{(A)}) \\
&= (-1)^{n/2}(2K_1)^{n+1} e^{-i\theta}\hat{Y}_\mu
&&(\because\ 2K_1\cdot(2K_1)^{n}=(2K_1)^{n+1}\ \text{とスカラーの積の可換性}) \\
&= (-1)^{((n+1)-1)/2}(2K_1)^{n+1} e^{-i\theta}\hat{Y}_\mu
&&(\because\ \tfrac{(n+1)-1}{2}=\tfrac{n}{2})
\end{aligned}`,
      ),
      paragraph([
        "最後の行が、",
        math(String.raw`n+1`),
        " が奇数のときの主張の右辺である。",
      ]),
      paragraph([
        "帰納段階 2（",
        math(String.raw`n`),
        " 奇数 → ",
        math(String.raw`n+1`),
        " 偶数）。",
        math(String.raw`n`),
        " が奇数で ",
        math(String.raw`C_n = (-1)^{(n-1)/2}(2K_1)^n e^{-i\theta}\hat{Y}_\mu`),
        " と仮定する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
C_{n+1}
&= \left[K_1 H_1^{(\pm)},\ C_n\right]
&&(\because\ n\ \text{重の交換子の定義}) \\
&= \left[K_1 H_1^{(\pm)},\ (-1)^{(n-1)/2}(2K_1)^n e^{-i\theta}\hat{Y}_\mu\right]
&&(\because\ \text{帰納法の仮定}) \\
&= K_1\cdot(-1)^{(n-1)/2}(2K_1)^n e^{-i\theta}\left[H_1^{(\pm)},\ \hat{Y}_\mu\right]
&&(\because\ \text{交換子の双線型性}) \\
&= K_1\cdot(-1)^{(n-1)/2}(2K_1)^n e^{-i\theta}\cdot\left(-2 e^{i\theta}\hat{Z}_\mu^{(\pm)}\right)
&&(\because\ \text{(B)}) \\
&= (-1)\cdot(-1)^{(n-1)/2}(2K_1)^{n+1}\,e^{-i\theta}e^{i\theta}\,\hat{Z}_\mu^{(\pm)}
&&(\because\ 2K_1\cdot(2K_1)^{n}=(2K_1)^{n+1}\ \text{とスカラーの積の可換性}) \\
&= (-1)\cdot(-1)^{(n-1)/2}(2K_1)^{n+1}e^{0}\hat{Z}_\mu^{(\pm)}
&&(\because\ \text{複素指数関数の積公式と}\ -i\theta+i\theta=0) \\
&= (-1)\cdot(-1)^{(n-1)/2}(2K_1)^{n+1}\hat{Z}_\mu^{(\pm)}
&&(\because\ e^{0}=1) \\
&= (-1)^{(n-1)/2+1}(2K_1)^{n+1}\hat{Z}_\mu^{(\pm)}
&&(\because\ (-1)\cdot(-1)^{k}=(-1)^{k+1}) \\
&= (-1)^{(n+1)/2}(2K_1)^{n+1}\hat{Z}_\mu^{(\pm)}
&&(\because\ \tfrac{n-1}{2}+1=\tfrac{n+1}{2})
\end{aligned}`,
      ),
      paragraph([
        "最後の行が、",
        math(String.raw`n+1`),
        " が偶数のときの主張の右辺である。基底段階と 2 つの帰納段階により、すべての ",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について (h1.z) が成り立つ。",
      ]),

      paragraph([
        "(h1.y) の証明。",
        math(String.raw`D_n := \underbrace{[K_1 H_1^{(\pm)},\dots,[K_1 H_1^{(\pm)}, \hat{Y}_\mu]\dots]}_{n}`),
        " とおく。",
        math(String.raw`D_{n+1} = [K_1 H_1^{(\pm)},\, D_n]`),
        "。",
      ]),
      paragraph([
        "基底段階（",
        math(String.raw`n = 0`),
        "、偶数）。",
        math(String.raw`D_0`),
        " から主張の偶数側の右辺へ至る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
D_0
&= \hat{Y}_\mu
&&(\because\ 0\ \text{重の交換子の規約}) \\
&= 1\cdot 1\cdot\hat{Y}_\mu
&&(\because\ 1\ \text{はスカラー倍の単位元}) \\
&= (-1)^{0/2}(2K_1)^{0}\hat{Y}_\mu
&&(\because\ \alpha^{0}=1\ \text{を}\ \alpha=-1\ \text{と}\ \alpha=2K_1\ \text{へ})
\end{aligned}`,
      ),
      paragraph([
        "帰納段階 1（",
        math(String.raw`n`),
        " 偶数 → ",
        math(String.raw`n+1`),
        " 奇数）。",
        math(String.raw`n`),
        " が偶数で ",
        math(String.raw`D_n = (-1)^{n/2}(2K_1)^n\hat{Y}_\mu`),
        " と仮定する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
D_{n+1}
&= \left[K_1 H_1^{(\pm)},\ D_n\right]
&&(\because\ n\ \text{重の交換子の定義}) \\
&= \left[K_1 H_1^{(\pm)},\ (-1)^{n/2}(2K_1)^n\hat{Y}_\mu\right]
&&(\because\ \text{帰納法の仮定}) \\
&= K_1\cdot(-1)^{n/2}(2K_1)^n\left[H_1^{(\pm)},\ \hat{Y}_\mu\right]
&&(\because\ \text{交換子の双線型性}) \\
&= K_1\cdot(-1)^{n/2}(2K_1)^n\cdot\left(-2 e^{i\theta}\hat{Z}_\mu^{(\pm)}\right)
&&(\because\ \text{(B)}) \\
&= (-1)\cdot(-1)^{n/2}(2K_1)^{n+1} e^{i\theta}\hat{Z}_\mu^{(\pm)}
&&(\because\ 2K_1\cdot(2K_1)^{n}=(2K_1)^{n+1}\ \text{とスカラーの積の可換性}) \\
&= (-1)^{n/2+1}(2K_1)^{n+1} e^{i\theta}\hat{Z}_\mu^{(\pm)}
&&(\because\ (-1)\cdot(-1)^{k}=(-1)^{k+1}) \\
&= (-1)^{((n+1)+1)/2}(2K_1)^{n+1} e^{i\theta}\hat{Z}_\mu^{(\pm)}
&&(\because\ \tfrac{(n+1)+1}{2}=\tfrac{n}{2}+1)
\end{aligned}`,
      ),
      paragraph([
        "最後の行が、",
        math(String.raw`n+1`),
        " が奇数のときの主張の右辺である。",
      ]),
      paragraph([
        "帰納段階 2（",
        math(String.raw`n`),
        " 奇数 → ",
        math(String.raw`n+1`),
        " 偶数）。",
        math(String.raw`n`),
        " が奇数で ",
        math(String.raw`D_n = (-1)^{(n+1)/2}(2K_1)^n e^{i\theta}\hat{Z}_\mu^{(\pm)}`),
        " と仮定する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
D_{n+1}
&= \left[K_1 H_1^{(\pm)},\ D_n\right]
&&(\because\ n\ \text{重の交換子の定義}) \\
&= \left[K_1 H_1^{(\pm)},\ (-1)^{(n+1)/2}(2K_1)^n e^{i\theta}\hat{Z}_\mu^{(\pm)}\right]
&&(\because\ \text{帰納法の仮定}) \\
&= K_1\cdot(-1)^{(n+1)/2}(2K_1)^n e^{i\theta}\left[H_1^{(\pm)},\ \hat{Z}_\mu^{(\pm)}\right]
&&(\because\ \text{交換子の双線型性}) \\
&= K_1\cdot(-1)^{(n+1)/2}(2K_1)^n e^{i\theta}\cdot 2 e^{-i\theta}\hat{Y}_\mu
&&(\because\ \text{(A)}) \\
&= (-1)^{(n+1)/2}(2K_1)^{n+1}\,e^{i\theta}e^{-i\theta}\,\hat{Y}_\mu
&&(\because\ 2K_1\cdot(2K_1)^{n}=(2K_1)^{n+1}\ \text{とスカラーの積の可換性}) \\
&= (-1)^{(n+1)/2}(2K_1)^{n+1}\hat{Y}_\mu
&&(\because\ e^{i\theta}e^{-i\theta}=e^{0}=1)
\end{aligned}`,
      ),
      paragraph([
        "最後の行が、",
        math(String.raw`n+1`),
        " が偶数のときの主張の右辺である。基底段階と 2 つの帰納段階により、すべての ",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について (h1.y) が成り立つ。",
      ]),

      paragraph([
        "(h2.z−) の証明。",
        math(String.raw`E_n := \underbrace{[K_2^* H_2,\dots,[K_2^* H_2, \hat{Z}_\mu^{(-)}]\dots]}_{n}`),
        " とおく。",
        math(String.raw`E_{n+1} = [K_2^* H_2,\, E_n]`),
        "。この場合は位相因子が現れない（(C), (D) の右辺に ",
        math(String.raw`e^{\pm i\theta}`),
        " が無い）。",
      ]),
      paragraph([
        "基底段階（",
        math(String.raw`n = 0`),
        "、偶数）。",
        math(String.raw`E_0`),
        " から主張の偶数側の右辺へ至る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E_0
&= \hat{Z}_\mu^{(-)}
&&(\because\ 0\ \text{重の交換子の規約}) \\
&= 1\cdot 1\cdot\hat{Z}_\mu^{(-)}
&&(\because\ 1\ \text{はスカラー倍の単位元}) \\
&= (-1)^{0/2}(2K_2^*)^{0}\hat{Z}_\mu^{(-)}
&&(\because\ \alpha^{0}=1\ \text{を}\ \alpha=-1\ \text{と}\ \alpha=2K_2^*\ \text{へ})
\end{aligned}`,
      ),
      paragraph([
        "帰納段階 1（",
        math(String.raw`n`),
        " 偶数 → ",
        math(String.raw`n+1`),
        " 奇数）。",
        math(String.raw`n`),
        " が偶数で ",
        math(String.raw`E_n = (-1)^{n/2}(2K_2^*)^n\hat{Z}_\mu^{(-)}`),
        " と仮定する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E_{n+1}
&= \left[K_2^* H_2,\ E_n\right]
&&(\because\ n\ \text{重の交換子の定義}) \\
&= \left[K_2^* H_2,\ (-1)^{n/2}(2K_2^*)^n\hat{Z}_\mu^{(-)}\right]
&&(\because\ \text{帰納法の仮定}) \\
&= K_2^*\cdot(-1)^{n/2}(2K_2^*)^n\left[H_2,\ \hat{Z}_\mu^{(-)}\right]
&&(\because\ \text{交換子の双線型性}) \\
&= K_2^*\cdot(-1)^{n/2}(2K_2^*)^n\cdot\left(-2\,\hat{Y}_\mu\right)
&&(\because\ \text{(C)}) \\
&= (-1)\cdot(-1)^{n/2}(2K_2^*)^{n+1}\hat{Y}_\mu
&&(\because\ 2K_2^*\cdot(2K_2^*)^{n}=(2K_2^*)^{n+1}\ \text{とスカラーの積の可換性}) \\
&= (-1)^{n/2+1}(2K_2^*)^{n+1}\hat{Y}_\mu
&&(\because\ (-1)\cdot(-1)^{k}=(-1)^{k+1}) \\
&= (-1)^{((n+1)+1)/2}(2K_2^*)^{n+1}\hat{Y}_\mu
&&(\because\ \tfrac{(n+1)+1}{2}=\tfrac{n}{2}+1)
\end{aligned}`,
      ),
      paragraph([
        "最後の行が、",
        math(String.raw`n+1`),
        " が奇数のときの主張の右辺である。",
      ]),
      paragraph([
        "帰納段階 2（",
        math(String.raw`n`),
        " 奇数 → ",
        math(String.raw`n+1`),
        " 偶数）。",
        math(String.raw`n`),
        " が奇数で ",
        math(String.raw`E_n = (-1)^{(n+1)/2}(2K_2^*)^n\hat{Y}_\mu`),
        " と仮定する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E_{n+1}
&= \left[K_2^* H_2,\ E_n\right]
&&(\because\ n\ \text{重の交換子の定義}) \\
&= \left[K_2^* H_2,\ (-1)^{(n+1)/2}(2K_2^*)^n\hat{Y}_\mu\right]
&&(\because\ \text{帰納法の仮定}) \\
&= K_2^*\cdot(-1)^{(n+1)/2}(2K_2^*)^n\left[H_2,\ \hat{Y}_\mu\right]
&&(\because\ \text{交換子の双線型性}) \\
&= K_2^*\cdot(-1)^{(n+1)/2}(2K_2^*)^n\cdot 2\,\hat{Z}_\mu^{(-)}
&&(\because\ \text{(D)}) \\
&= (-1)^{(n+1)/2}(2K_2^*)^{n+1}\hat{Z}_\mu^{(-)}
&&(\because\ 2K_2^*\cdot(2K_2^*)^{n}=(2K_2^*)^{n+1}\ \text{とスカラーの積の可換性})
\end{aligned}`,
      ),
      paragraph([
        "最後の行が、",
        math(String.raw`n+1`),
        " が偶数のときの主張の右辺である。基底段階と 2 つの帰納段階により、すべての ",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について (h2.z−) が成り立つ。",
      ]),

      paragraph([
        "(h2.y) の証明。",
        math(String.raw`F_n := \underbrace{[K_2^* H_2,\dots,[K_2^* H_2, \hat{Y}_\mu]\dots]}_{n}`),
        " とおく。",
        math(String.raw`F_{n+1} = [K_2^* H_2,\, F_n]`),
        "。",
      ]),
      paragraph([
        "基底段階（",
        math(String.raw`n = 0`),
        "、偶数）。",
        math(String.raw`F_0`),
        " から主張の偶数側の右辺へ至る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
F_0
&= \hat{Y}_\mu
&&(\because\ 0\ \text{重の交換子の規約}) \\
&= 1\cdot 1\cdot\hat{Y}_\mu
&&(\because\ 1\ \text{はスカラー倍の単位元}) \\
&= (-1)^{0/2}(2K_2^*)^{0}\hat{Y}_\mu
&&(\because\ \alpha^{0}=1\ \text{を}\ \alpha=-1\ \text{と}\ \alpha=2K_2^*\ \text{へ})
\end{aligned}`,
      ),
      paragraph([
        "帰納段階 1（",
        math(String.raw`n`),
        " 偶数 → ",
        math(String.raw`n+1`),
        " 奇数）。",
        math(String.raw`n`),
        " が偶数で ",
        math(String.raw`F_n = (-1)^{n/2}(2K_2^*)^n\hat{Y}_\mu`),
        " と仮定する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
F_{n+1}
&= \left[K_2^* H_2,\ F_n\right]
&&(\because\ n\ \text{重の交換子の定義}) \\
&= \left[K_2^* H_2,\ (-1)^{n/2}(2K_2^*)^n\hat{Y}_\mu\right]
&&(\because\ \text{帰納法の仮定}) \\
&= K_2^*\cdot(-1)^{n/2}(2K_2^*)^n\left[H_2,\ \hat{Y}_\mu\right]
&&(\because\ \text{交換子の双線型性}) \\
&= K_2^*\cdot(-1)^{n/2}(2K_2^*)^n\cdot 2\,\hat{Z}_\mu^{(-)}
&&(\because\ \text{(D)}) \\
&= (-1)^{n/2}(2K_2^*)^{n+1}\hat{Z}_\mu^{(-)}
&&(\because\ 2K_2^*\cdot(2K_2^*)^{n}=(2K_2^*)^{n+1}\ \text{とスカラーの積の可換性}) \\
&= (-1)^{((n+1)-1)/2}(2K_2^*)^{n+1}\hat{Z}_\mu^{(-)}
&&(\because\ \tfrac{(n+1)-1}{2}=\tfrac{n}{2})
\end{aligned}`,
      ),
      paragraph([
        "最後の行が、",
        math(String.raw`n+1`),
        " が奇数のときの主張の右辺である。",
      ]),
      paragraph([
        "帰納段階 2（",
        math(String.raw`n`),
        " 奇数 → ",
        math(String.raw`n+1`),
        " 偶数）。",
        math(String.raw`n`),
        " が奇数で ",
        math(String.raw`F_n = (-1)^{(n-1)/2}(2K_2^*)^n\hat{Z}_\mu^{(-)}`),
        " と仮定する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
F_{n+1}
&= \left[K_2^* H_2,\ F_n\right]
&&(\because\ n\ \text{重の交換子の定義}) \\
&= \left[K_2^* H_2,\ (-1)^{(n-1)/2}(2K_2^*)^n\hat{Z}_\mu^{(-)}\right]
&&(\because\ \text{帰納法の仮定}) \\
&= K_2^*\cdot(-1)^{(n-1)/2}(2K_2^*)^n\left[H_2,\ \hat{Z}_\mu^{(-)}\right]
&&(\because\ \text{交換子の双線型性}) \\
&= K_2^*\cdot(-1)^{(n-1)/2}(2K_2^*)^n\cdot\left(-2\,\hat{Y}_\mu\right)
&&(\because\ \text{(C)}) \\
&= (-1)\cdot(-1)^{(n-1)/2}(2K_2^*)^{n+1}\hat{Y}_\mu
&&(\because\ 2K_2^*\cdot(2K_2^*)^{n}=(2K_2^*)^{n+1}\ \text{とスカラーの積の可換性}) \\
&= (-1)^{(n-1)/2+1}(2K_2^*)^{n+1}\hat{Y}_\mu
&&(\because\ (-1)\cdot(-1)^{k}=(-1)^{k+1}) \\
&= (-1)^{(n+1)/2}(2K_2^*)^{n+1}\hat{Y}_\mu
&&(\because\ \tfrac{n-1}{2}+1=\tfrac{n+1}{2})
\end{aligned}`,
      ),
      paragraph([
        "最後の行が、",
        math(String.raw`n+1`),
        " が偶数のときの主張の右辺である。基底段階と 2 つの帰納段階により、すべての ",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について (h2.y) が成り立つ。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文の proof は「TODO : note 参考にして、帰納法で行ける」というアウトラインのみで帰納法本体は未記述だった。4 式それぞれについて n に関する帰納法（基底 n=0 と、偶数 n→奇数 n+1 / 奇数 n→偶数 n+1 の 2 つの帰納段階）を人手で書き下し、todo を除去した。",
        "原文 note の n=0..4 具体例を block-level notes に忠実に翻訳。原文の (h2.z^+) は「これは使われない」というメモのみで式が無いため statement・notes とも省いた。原文 note の (h1.y) n=3 は exp の符号が n=1 と不整合（誤植）だったため、本作業で n=1 と同じ e^{-i2π(-μ)/M}（= e^{+iθ}）へ修正した。用いる 1 重公式 [H_1^{(±)}, hat(Y)_mu] = -2 e^{iθ} hat(Z)_mu^{(±)} は sagemath/check/040_claim_extract_taylor_coefficient_of_Z_Y/check_01_single_commutators.sage の (B) で数値的に確認済み。帰納法の証明は note の具体例ではなく commutator_of_H_and_Z_Y の 1 重公式から直接構成した。",
        "(h1.z) の帰納法を一続きの鎖へ書き換えた（2026-08-11）。基底段階と 2 つの帰納段階のそれぞれを 1 つの鎖にし、鎖の終点を主張の右辺の形（(-1)^{((n+1)-1)/2} 等）まで延ばして、全段に行末の根拠を付けた。段は減らしていない（増えている）。翌 tick のレビューで、基底段階の鎖が主張の右辺から始まって C_0 へ着く向きだったのを、C_0 から始めて右辺へ着く向きへ直した（証明の書き方の「式変形は主張の左辺から始める」。段と根拠は同じものを順に読み替えただけで、中身は変えていない）。",
        "(h2.z−) の帰納法を一続きの鎖へ書き換えた（2026-08-11）。基底段階を E_0 から始まる 3 段の鎖にし、2 つの帰納段階には E_{n+1} = [K_2^* H_2, E_n] の段を先頭へ足したうえで、鎖の終点を主張の右辺の形（(-1)^{((n+1)+1)/2} 等）まで延ばし、全段に行末の根拠を付けた。「n+1 は奇数で、右辺の符号は… であり一致する」という地の文は、鎖の最後の段（指数の書き換え）へ移した。段は減らしていない（増えている）。",
        "(h1.y) の帰納法を一続きの鎖へ書き換えた（2026-08-11）。基底段階を D_0 から始まる 3 段の鎖にし、2 つの帰納段階には D_{n+1} = [K_1 H_1^{(±)}, D_n] の段を先頭へ足したうえで、鎖の終点を主張の右辺の形（(-1)^{((n+1)+1)/2} 等）まで延ばし、全段に行末の根拠を付けた。overbrace の地の文（e^{iθ}e^{-iθ} = 1）も行末の根拠へ移した。段は減らしていない（増えている）。",
        "(h2.y) の帰納法を一続きの鎖へ書き換えた（2026-08-11）。基底段階を F_0 から始まる 3 段の鎖にし、2 つの帰納段階には F_{n+1} = [K_2^* H_2, F_n] の段を先頭へ足したうえで、鎖の終点を主張の右辺の形（(-1)^{((n+1)-1)/2} 等）まで延ばし、全段に行末の根拠を付けた。「n+1 は奇数で、右辺の符号は… であり一致する」「最後の等号は (n-1)/2 + 1 = (n+1)/2 による」という地の文は、鎖の最後の段（指数の書き換え）へ移した。段は減らしていない（増えている）。これで (h1.z)・(h1.y)・(h2.z−)・(h2.y) の 4 式すべてが同じ形になった。",
        "原文 statement の (h1.y) 奇数側は hat(Z)_mu^{(+)} と書かれているが、用いる 1 重公式 [H_1^{(±)}, hat(Y)_mu] = -2 e^{iθ} hat(Z)_mu^{(±)} は H_1 と同符号の hat(Z) を返すため、構造化側では hat(Z)_mu^{(±)} とした（移行時点からの表記であり、本作業で変更していない）。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_003_claim_cosh_sinh_coefficient_conversion",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/002_claim_cosh_sinhの展開係数への変換.typ",
      ordinal: 3,
    },
    title: null,
    labels: ["cosh_sinh_coefficient_conversion"],
    statement: [
      paragraph(["(h1.z)"]),
      displayMath(
        String.raw`\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\hat{Z}_\mu^{(\pm)}\right]\dots\right]}_{n}
= \begin{cases}
i K_1^n e^{-i 2\pi\mu/M} \hat{Y}_\mu & (n \text{ 奇数}) \\
K_1^n \hat{Z}_\mu^{(\pm)} & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h1.y)"]),
      displayMath(
        String.raw`\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\hat{Y}_\mu\right]\dots\right]}_{n}
= \begin{cases}
-i K_1^n e^{i 2\pi\mu/M} \hat{Z}_\mu^{(\pm)} & (n \text{ 奇数}) \\
K_1^n \hat{Y}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h2.z−)"]),
      displayMath(
        String.raw`\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\hat{Z}_\mu^{(-)}\right]\dots\right]}_{n}
= \begin{cases}
-i (2K_2^*)^n \hat{Y}_\mu & (n \text{ 奇数}) \\
(2K_2^*)^n \hat{Z}_\mu^{(-)} & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h2.y)"]),
      displayMath(
        String.raw`\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\hat{Y}_\mu\right]\dots\right]}_{n}
= \begin{cases}
i (2K_2^*)^n \hat{Z}_\mu^{(-)} & (n \text{ 奇数}) \\
(2K_2^*)^n \hat{Y}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
    ],
    proof: [
      paragraph([
        "以下、",
        math(String.raw`\theta := \dfrac{2\pi\mu}{M} \in \mathbb{R}`),
        " と略記する。まず 4 式すべてで用いる次の 2 つの補題を用意する。",
      ]),
      paragraph([
        "補題 1（生成子のスカラー倍）：",
        math(String.raw`\alpha \in \mathbb{C}`),
        "、",
        math(String.raw`X, W \in \mathrm{Mat}(2^M,\mathbb{C})`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(
        String.raw`\underbrace{[\alpha X,\dots,[\alpha X, W]\dots]}_{n}
= \alpha^{n}\,\underbrace{[X,\dots,[X, W]\dots]}_{n}`,
      ),
      paragraph([
        "が成り立つ。実際、任意の ",
        math(String.raw`W`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ad}_{\alpha X}(W)
&= [\alpha X, W]
&&(\because\ \mathrm{ad}\ \text{の定義})\\
&= \alpha[X, W]
&&(\because\ \text{交換子の第 1 引数についての}\ \mathbb{C}\ \text{線型性})\\
&= \alpha\,\mathrm{ad}_X(W)
&&(\because\ \mathrm{ad}\ \text{の定義})
\end{aligned}`),
      paragraph([
        "であるから、線型写像として ",
        math(String.raw`\mathrm{ad}_{\alpha X} = \alpha\,\mathrm{ad}_X`),
        " が成り立つ。よって、任意の ",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ad}_{\alpha X}^{\,n}
&= (\alpha\,\mathrm{ad}_X)^n
&&(\because\ \text{上で示した}\ \mathrm{ad}_{\alpha X} = \alpha\,\mathrm{ad}_X)\\
&= \alpha^{n}\,\mathrm{ad}_X^{\,n}
&&(\because\ \mathrm{ad}_X\ \text{は}\ \mathbb{C}\ \text{線型なのでスカラー倍と可換であり、合成の各段からスカラーを前へ出せる。}\ n=0\ \text{のときは両辺とも恒等写像で}\ \alpha^{0}=1)
\end{aligned}`),
      paragraph([
        "が成り立つ。",
      ]),
      paragraph([
        "補題 2（虚数単位の冪）：",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(
        String.raw`i^{n} = \begin{cases}
i\,(-1)^{(n-1)/2} & (n \text{ 奇数}) \\
(-1)^{n/2} & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph([
        "が成り立つ。実際、",
        math(String.raw`n`),
        " が偶数のとき ",
        math(String.raw`n/2 \in \mathbb{Z}_{\geq 0}`),
        "、奇数のとき ",
        math(String.raw`(n-1)/2 \in \mathbb{Z}_{\geq 0}`),
        " なので、以下の指数はいずれも整数である。",
        math(String.raw`n`),
        " が偶数なら",
      ]),
      displayMath(
        String.raw`\begin{aligned}
i^n
&= (i^2)^{n/2}
   \quad (\because \text{指数法則 } (i^2)^{n/2}=i^{2\cdot(n/2)}=i^{n}) \\
&= (-1)^{n/2}
   \quad (\because i^2=-1)
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`n`),
        " が奇数なら",
      ]),
      displayMath(
        String.raw`\begin{aligned}
i^n
&= i\cdot i^{n-1}
   \quad (\because \text{指数法則 } i^{1+(n-1)}=i\cdot i^{n-1}) \\
&= i\,(i^2)^{(n-1)/2}
   \quad (\because \text{指数法則 } (i^2)^{(n-1)/2}=i^{2\cdot((n-1)/2)}=i^{n-1}) \\
&= i\,(-1)^{(n-1)/2}
   \quad (\because i^2=-1)
\end{aligned}`,
      ),
      paragraph([
        "である。",
      ]),
      paragraph([
        "(h1.z) について、",
        ref("nesting_of_commutator_of_H_and_Z"),
        " (h1.z) の生成子を ",
        math(String.raw`K_1 H_1^{(\pm)} \to \tfrac{i}{2}K_1 H_1^{(\pm)}`),
        " に置き換えて代入する。すなわち補題 1 を ",
        math(String.raw`\alpha = \tfrac{i}{2}`),
        "、",
        math(String.raw`X = K_1 H_1^{(\pm)}`),
        "、",
        math(String.raw`W = \hat{Z}_\mu^{(\pm)}`),
        " として使い、さらに補題 2 で ",
        math(String.raw`i^n`),
        " を書き換える。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\hat{Z}_\mu^{(\pm)}\right]\dots\right]}_{n}
&= \left(\tfrac{i}{2}\right)^{n}
   \underbrace{\left[K_1 H_1^{(\pm)},\dots,\left[K_1 H_1^{(\pm)},\hat{Z}_\mu^{(\pm)}\right]\dots\right]}_{n}
&&(\because\ \text{補題 1}) \\
&= \left(\tfrac{i}{2}\right)^{n}\begin{cases}
(-1)^{(n-1)/2}(2K_1)^{n} e^{-i\theta}\hat{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(2K_1)^{n}\hat{Z}_\mu^{(\pm)} & (n\text{ 偶数})
\end{cases}
&&(\because\ \text{交換子のネスト (h1.z)}) \\
&= \begin{cases}
i^{n}\,2^{-n}\,(-1)^{(n-1)/2}\,2^{n}K_1^{n}\, e^{-i\theta}\hat{Y}_\mu & (n\text{ 奇数}) \\
i^{n}\,2^{-n}\,(-1)^{n/2}\,2^{n}K_1^{n}\,\hat{Z}_\mu^{(\pm)} & (n\text{ 偶数})
\end{cases}
&&\left(\because\ \left(\tfrac{i}{2}\right)^{n} = i^{n}2^{-n},\ (2K_1)^n = 2^n K_1^n\right) \\
&= \begin{cases}
i^{n}\,(-1)^{(n-1)/2}\,K_1^{n}\, e^{-i\theta}\hat{Y}_\mu & (n\text{ 奇数}) \\
i^{n}\,(-1)^{n/2}\,K_1^{n}\,\hat{Z}_\mu^{(\pm)} & (n\text{ 偶数})
\end{cases}
&&(\because\ 2^{-n}2^{n} = 1) \\
&= \begin{cases}
i\,(-1)^{(n-1)/2}(-1)^{(n-1)/2}\,K_1^{n}\, e^{-i\theta}\hat{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(-1)^{n/2}\,K_1^{n}\,\hat{Z}_\mu^{(\pm)} & (n\text{ 偶数})
\end{cases}
&&(\because\ \text{補題 2}) \\
&= \begin{cases}
i\,(-1)^{n-1}\,K_1^{n}\, e^{-i\theta}\hat{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n}\,K_1^{n}\,\hat{Z}_\mu^{(\pm)} & (n\text{ 偶数})
\end{cases}
&&\left(\because\ \tfrac{n-1}{2}+\tfrac{n-1}{2} = n-1,\ \tfrac{n}{2}+\tfrac{n}{2} = n\right) \\
&= \begin{cases}
i\,K_1^{n}\, e^{-i\theta}\hat{Y}_\mu & (n\text{ 奇数}) \\
K_1^{n}\,\hat{Z}_\mu^{(\pm)} & (n\text{ 偶数})
\end{cases}
&&(\because\ n\text{ 奇数なら }(-1)^{n-1} = 1,\ n\text{ 偶数なら }(-1)^{n} = 1) \\
&= \begin{cases}
i\,K_1^{n}\, e^{-i 2\pi\mu/M}\hat{Y}_\mu & (n\text{ 奇数}) \\
K_1^{n}\,\hat{Z}_\mu^{(\pm)} & (n\text{ 偶数})
\end{cases}
&&(\because\ \theta = \tfrac{2\pi\mu}{M}\ \text{の定義})
\end{aligned}`,
      ),
      paragraph([
        "最後の行が (h1.z) の主張の右辺である。",
      ]),
      paragraph([
        "(h1.y) について、同じく補題 1 を ",
        math(String.raw`\alpha = \tfrac{i}{2}`),
        "、",
        math(String.raw`X = K_1 H_1^{(\pm)}`),
        "、",
        math(String.raw`W = \hat{Y}_\mu`),
        " として使う。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\hat{Y}_\mu\right]\dots\right]}_{n}
&= \left(\tfrac{i}{2}\right)^{n}
   \underbrace{\left[K_1 H_1^{(\pm)},\dots,\left[K_1 H_1^{(\pm)},\hat{Y}_\mu\right]\dots\right]}_{n}
&&(\because\ \text{補題 1}) \\
&= \left(\tfrac{i}{2}\right)^{n}\begin{cases}
(-1)^{(n+1)/2}(2K_1)^{n} e^{i\theta}\hat{Z}_\mu^{(\pm)} & (n\text{ 奇数}) \\
(-1)^{n/2}(2K_1)^{n}\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&(\because\ \text{交換子のネスト (h1.y)}) \\
&= \begin{cases}
i^{n}\,2^{-n}\,(-1)^{(n+1)/2}\,2^{n}K_1^{n}\, e^{i\theta}\hat{Z}_\mu^{(\pm)} & (n\text{ 奇数}) \\
i^{n}\,2^{-n}\,(-1)^{n/2}\,2^{n}K_1^{n}\,\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&\left(\because\ \left(\tfrac{i}{2}\right)^{n} = i^{n}2^{-n},\ (2K_1)^n = 2^n K_1^n\right) \\
&= \begin{cases}
i^{n}\,(-1)^{(n+1)/2}\,K_1^{n}\, e^{i\theta}\hat{Z}_\mu^{(\pm)} & (n\text{ 奇数}) \\
i^{n}\,(-1)^{n/2}\,K_1^{n}\,\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&(\because\ 2^{-n}2^{n} = 1) \\
&= \begin{cases}
i\,(-1)^{(n-1)/2}(-1)^{(n+1)/2}\,K_1^{n}\, e^{i\theta}\hat{Z}_\mu^{(\pm)} & (n\text{ 奇数}) \\
(-1)^{n/2}(-1)^{n/2}\,K_1^{n}\,\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&(\because\ \text{補題 2}) \\
&= \begin{cases}
i\,(-1)^{n}\,K_1^{n}\, e^{i\theta}\hat{Z}_\mu^{(\pm)} & (n\text{ 奇数}) \\
(-1)^{n}\,K_1^{n}\,\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&\left(\because\ \tfrac{n-1}{2}+\tfrac{n+1}{2} = n,\ \tfrac{n}{2}+\tfrac{n}{2} = n\right) \\
&= \begin{cases}
-i\,K_1^{n}\, e^{i\theta}\hat{Z}_\mu^{(\pm)} & (n\text{ 奇数}) \\
K_1^{n}\,\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&(\because\ n\text{ 奇数なら }(-1)^{n} = -1,\ n\text{ 偶数なら }(-1)^{n} = 1) \\
&= \begin{cases}
-i\,K_1^{n}\, e^{i 2\pi\mu/M}\hat{Z}_\mu^{(\pm)} & (n\text{ 奇数}) \\
K_1^{n}\,\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&(\because\ \theta = \tfrac{2\pi\mu}{M}\ \text{の定義})
\end{aligned}`,
      ),
      paragraph([
        "最後の行が (h1.y) の主張の右辺である。",
      ]),
      paragraph([
        "(h2.z−) について、補題 1 を ",
        math(String.raw`\alpha = i`),
        "、",
        math(String.raw`X = K_2^* H_2`),
        "、",
        math(String.raw`W = \hat{Z}_\mu^{(-)}`),
        " として使う。今回は ",
        math(String.raw`\alpha = i`),
        " で 2 の冪が現れないので、",
        math(String.raw`(2K_2^*)^n`),
        " はそのまま残る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\hat{Z}_\mu^{(-)}\right]\dots\right]}_{n}
&= i^{n}
   \underbrace{\left[K_2^* H_2,\dots,\left[K_2^* H_2,\hat{Z}_\mu^{(-)}\right]\dots\right]}_{n}
&&(\because\ \text{補題 1}) \\
&= i^{n}\begin{cases}
(-1)^{(n+1)/2}(2K_2^*)^{n}\hat{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(2K_2^*)^{n}\hat{Z}_\mu^{(-)} & (n\text{ 偶数})
\end{cases}
&&(\because\ \text{交換子のネスト (h2.z−)}) \\
&= \begin{cases}
i\,(-1)^{(n-1)/2}(-1)^{(n+1)/2}(2K_2^*)^{n}\hat{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(-1)^{n/2}(2K_2^*)^{n}\hat{Z}_\mu^{(-)} & (n\text{ 偶数})
\end{cases}
&&(\because\ \text{補題 2}) \\
&= \begin{cases}
i\,(-1)^{n}(2K_2^*)^{n}\hat{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n}(2K_2^*)^{n}\hat{Z}_\mu^{(-)} & (n\text{ 偶数})
\end{cases}
&&\left(\because\ \tfrac{n-1}{2}+\tfrac{n+1}{2} = n,\ \tfrac{n}{2}+\tfrac{n}{2} = n\right) \\
&= \begin{cases}
-i\,(2K_2^*)^{n}\hat{Y}_\mu & (n\text{ 奇数}) \\
(2K_2^*)^{n}\hat{Z}_\mu^{(-)} & (n\text{ 偶数})
\end{cases}
&&(\because\ n\text{ 奇数なら }(-1)^{n} = -1,\ n\text{ 偶数なら }(-1)^{n} = 1)
\end{aligned}`,
      ),
      paragraph([
        "最後の行が (h2.z−) の主張の右辺である。",
      ]),
      paragraph([
        "(h2.y) について、補題 1 を ",
        math(String.raw`\alpha = i`),
        "、",
        math(String.raw`X = K_2^* H_2`),
        "、",
        math(String.raw`W = \hat{Y}_\mu`),
        " として使う。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\hat{Y}_\mu\right]\dots\right]}_{n}
&= i^{n}
   \underbrace{\left[K_2^* H_2,\dots,\left[K_2^* H_2,\hat{Y}_\mu\right]\dots\right]}_{n}
&&(\because\ \text{補題 1}) \\
&= i^{n}\begin{cases}
(-1)^{(n-1)/2}(2K_2^*)^{n}\hat{Z}_\mu^{(-)} & (n\text{ 奇数}) \\
(-1)^{n/2}(2K_2^*)^{n}\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&(\because\ \text{交換子のネスト (h2.y)}) \\
&= \begin{cases}
i\,(-1)^{(n-1)/2}(-1)^{(n-1)/2}(2K_2^*)^{n}\hat{Z}_\mu^{(-)} & (n\text{ 奇数}) \\
(-1)^{n/2}(-1)^{n/2}(2K_2^*)^{n}\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&(\because\ \text{補題 2}) \\
&= \begin{cases}
i\,(-1)^{n-1}(2K_2^*)^{n}\hat{Z}_\mu^{(-)} & (n\text{ 奇数}) \\
(-1)^{n}(2K_2^*)^{n}\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&\left(\because\ \tfrac{n-1}{2}+\tfrac{n-1}{2} = n-1,\ \tfrac{n}{2}+\tfrac{n}{2} = n\right) \\
&= \begin{cases}
i\,(2K_2^*)^{n}\hat{Z}_\mu^{(-)} & (n\text{ 奇数}) \\
(2K_2^*)^{n}\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&(\because\ n\text{ 奇数なら }n-1\text{ は偶数で }(-1)^{n-1} = 1,\ n\text{ 偶数なら }(-1)^{n} = 1)
\end{aligned}`,
      ),
      paragraph([
        "最後の行が (h2.y) の主張の右辺である。",
      ]),
      paragraph([
        "以上 4 式が、",
        ref("nesting_of_commutator_of_H_and_Z"),
        " の各式に補題 1・補題 2 を適用して得られた。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文 proof は (h1.z) の代入計算のみを扱い、(h1.y)/(h2.z−)/(h2.y) は statement で「同様」とされ本文計算が無かった。下流の extract_taylor_coefficient_of_Z_Y の proof が 4 式すべてを必要とするため、statement に (h1.y)/(h2.y) の式を明示的に書き足し、proof でも 4 式すべての代入計算を書き下した。",
        "原文の指数簡約は (-1)^{1/2} という実数の範囲で意味をなさない中間式を経由しており（(n-1)/2+n/2 を (2n+2)/2+1/2 と書く等）、最終結果は正しいものの各ステップの正当化が不能だった。生成子のスカラー倍に関する補題 1（ad_{αX}^n = α^n ad_X^n）と虚数単位の冪に関する補題 2（i^n の偶奇分解）を明示的に立て、すべての指数を整数の範囲で扱う形へ書き改めた。",
        "4 式すべての結果は sagemath/check/040_claim_extract_taylor_coefficient_of_Z_Y/check_02_scaled_nested_commutators.sage で n=0..8、M=3,4,5、複数の (K1,K2) について数値的に確認済み。",
        "(h1.z) の代入計算を一続きの鎖の書き方へ揃えた（2026-08-11）。鎖の途中に \\quad で割り込ませていた (∵ …) を行末の列（&&）へ移し、根拠の無かった 2 段（(-1)^{(n-1)/2}(-1)^{(n-1)/2} = (-1)^{n-1} の段と、(-1)^{n-1} = 1 で符号が消える段）に根拠を付け、鎖のあとの地の文（「最後の等号は…による」「e^{-iθ} = e^{-i2πμ/M} なので主張の形になる」）を鎖の最後の 2 段として取り込んで、鎖の終点を主張の右辺の形（i K_1^n e^{-i2πμ/M} Ŷ_μ）まで延ばした。補題 1 を当てるときの W = Ẑ_μ^{(±)} も冒頭で明示した。段は減らしていない（増えている）。",
        "(h1.y) の代入計算を (h1.z) と同じ形へ揃えた（2026-08-11）。\\quad で割り込ませていた (∵ …) を行末の列（&&）へ移し、(i/2)^n = i^n 2^{-n} と (2K_1)^n = 2^n K_1^n を使う段が 2^{-n}2^{n} = 1 の段と 1 行にまとまっていたのを 2 段へ割り、根拠の無かった最後の段（(-1)^{n} で符号が決まる段）へ根拠を付け、鎖のあとの地の文（「最後の等号は…による」）を鎖の中へ取り込んだうえで、θ = 2πμ/M を戻す段を足して鎖の終点を主張の右辺の形（-i K_1^n e^{i2πμ/M} Ẑ_μ^{(±)}）まで延ばした。段は減らしていない（増えている）。残りは (h2.z−) と (h2.y) の 2 式である。",
        "(h2.y) の代入計算を残りの 3 式と同じ形へ揃えた（2026-08-11）。\\quad で割り込ませていた (∵ …) を行末の列（&&）へ移し、根拠の無かった 2 段（(-1)^{(n-1)/2}(-1)^{(n-1)/2} = (-1)^{n-1} の段と、符号が決まる段）に根拠を付け、鎖の終点が主張の右辺（i (2K_2^*)^n Ẑ_μ^{(-)} / (2K_2^*)^n Ŷ_μ）と字句どおり一致することを地の文で述べた。段は減らしていない。これで代入計算の 4 式がすべて同じ形になった。",
        "(h2.z−) の代入計算を (h1.z)・(h1.y) と同じ形へ揃えた（2026-08-11）。\\quad で割り込ませていた (∵ …) を行末の列（&&）へ移し、根拠の無かった 2 段（(-1)^{(n-1)/2}(-1)^{(n+1)/2} = (-1)^{n} の段と、(-1)^{n} で符号が決まる段）に根拠を付け、鎖の終点が主張の右辺（-i (2K_2^*)^n Ŷ_μ / (2K_2^*)^n Ẑ_μ^{(-)}）と字句どおり一致することを地の文で述べた。段は減らしていない。残りは (h2.y) の 1 式である。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_004_claim_sinh_cosh_taylor",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/003_claim_sinh_coshのテイラー展開.typ",
      ordinal: 4,
    },
    title: { tex: String.raw`\sinh, \cosh \text{ のテイラー展開}` },
    labels: [],
    statement: [
      displayMath(
        String.raw`\sinh x = \sum_{\substack{n \geq 1 \\ n \text{ 奇数}}} \frac{x^n}{n!}, \qquad
\cosh x = \sum_{\substack{n \geq 0 \\ n \text{ 偶数}}} \frac{x^n}{n!}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_005_claim_extract_taylor_coefficient",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/004_claim_テイラー係数の抽出.typ",
      ordinal: 5,
    },
    title: null,
    labels: ["extract_taylor_coefficient_of_Z_Y"],
    statement: [
      paragraph(["(h1.z)"]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}
\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\hat{Z}_\mu^{(\pm)}\right]\dots\right]}_{n}
= \cosh(K_1)\hat{Z}_\mu^{(\pm)} + i e^{-i 2\pi\mu/M}\sinh(K_1)\hat{Y}_\mu`,
      ),
      paragraph(["(h1.y)"]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}
\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\hat{Y}_\mu\right]\dots\right]}_{n}
= -i e^{i 2\pi\mu/M}\sinh(K_1)\hat{Z}_\mu^{(\pm)} + \cosh(K_1)\hat{Y}_\mu`,
      ),
      paragraph(["(h2.z−)"]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}
\underbrace{[i K_2^* H_2,\dots,[i K_2^* H_2,\hat{Z}_\mu^{(-)}]\dots]}_{n}
= \cosh(2K_2^*)\hat{Z}_\mu^{(-)} - i\sinh(2K_2^*)\hat{Y}_\mu`,
      ),
      paragraph(["(h2.y)"]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}
\underbrace{[i K_2^* H_2,\dots,[i K_2^* H_2,\hat{Y}_\mu]\dots]}_{n}
= i\sinh(2K_2^*)\hat{Z}_\mu^{(-)} + \cosh(2K_2^*)\hat{Y}_\mu`,
      ),
    ],
    proof: [
      paragraph([
        "以下、各級数を ",
        ref("cosh_sinh_coefficient_conversion"),
        " により偶数項・奇数項に分け、",
        ref("nesting_of_commutator_of_H_and_Z"),
        " 直後の sinh/cosh テイラー展開を用いる。",
      ]),
      paragraph(["(h1.z) について、"]),
      displayMath(
        String.raw`\begin{aligned}
(\text{左辺})
&= \frac{1}{0!}\hat{Z}_\mu^{(\pm)}
   + \sum_{n=1}^{\infty}\frac{1}{n!}\begin{cases}
i\cdot K_1^{n}\cdot e^{-i\frac{2\pi\mu}{M}}\cdot\hat{Y}_\mu & (n\text{ 奇数}) \\
K_1^{n}\cdot\hat{Z}_\mu^{(\pm)} & (n\text{ 偶数})
\end{cases}
&&(\because\ n = 0\ \text{の項を分け、}\ n \geq 1\ \text{の各項へ「cosh, sinh の展開係数への変換」の (h1.z)}) \\
&= \sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\left(\frac{1}{n!}K_1^{n}\hat{Z}_\mu^{(\pm)}\right)
   + \sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\left(\frac{1}{n!}\,i\,K_1^{n}\,e^{-i\frac{2\pi\mu}{M}}\,\hat{Y}_\mu\right)
&&(\because\ K_1^{0}\hat{Z}_\mu^{(\pm)} = \tfrac{1}{0!}\hat{Z}_\mu^{(\pm)}\ \text{なので}\ n = 0\ \text{の項を偶数側の和へ吸収した}) \\
&= \left(\sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\frac{1}{n!}K_1^{n}\right)\hat{Z}_\mu^{(\pm)}
   + i\,e^{-i\frac{2\pi\mu}{M}}\left(\sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\frac{1}{n!}K_1^{n}\right)\hat{Y}_\mu
&&(\because\ \hat{Z}_\mu^{(\pm)},\ \hat{Y}_\mu,\ i\,e^{-i 2\pi\mu/M}\ \text{が}\ n\ \text{に依らないので和の外へ出した}) \\
&= \cosh(K_1)\hat{Z}_\mu^{(\pm)} + i\,e^{-i\frac{2\pi\mu}{M}}\sinh(K_1)\hat{Y}_\mu
&&(\because\ \text{「sinh, cosh のテイラー展開」})
\end{aligned}`,
      ),
      paragraph([
        "鎖の終点は主張の (h1.z) の右辺と字句どおり一致する。",
        "以下の 3 式でも、",
        math(String.raw`n = 0`),
        " の項を同じ理由で偶数側の和へ吸収する。",
      ]),
      paragraph(["(h1.y) について、"]),
      displayMath(
        String.raw`\begin{aligned}
(\text{左辺})
&= \frac{1}{0!}\hat{Y}_\mu
   + \sum_{n=1}^{\infty}\frac{1}{n!}\begin{cases}
-i\cdot K_1^{n}\cdot e^{i\frac{2\pi\mu}{M}}\cdot\hat{Z}_\mu^{(\pm)} & (n\text{ 奇数}) \\
K_1^{n}\cdot\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&(\because\ n = 0\ \text{の項を分け、}\ n \geq 1\ \text{の各項へ「cosh, sinh の展開係数への変換」の (h1.y)}) \\
&= \sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\left(\frac{1}{n!}K_1^{n}\hat{Y}_\mu\right)
   + \sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\left(\frac{1}{n!}\,(-i)\,K_1^{n}\,e^{i\frac{2\pi\mu}{M}}\,\hat{Z}_\mu^{(\pm)}\right)
&&(\because\ K_1^{0}\hat{Y}_\mu = \tfrac{1}{0!}\hat{Y}_\mu\ \text{なので}\ n = 0\ \text{の項を偶数側の和へ吸収した}) \\
&= \left(\sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\frac{1}{n!}K_1^{n}\right)\hat{Y}_\mu
   - i\,e^{i\frac{2\pi\mu}{M}}\left(\sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\frac{1}{n!}K_1^{n}\right)\hat{Z}_\mu^{(\pm)}
&&(\because\ \hat{Y}_\mu,\ \hat{Z}_\mu^{(\pm)},\ (-i)\,e^{i 2\pi\mu/M}\ \text{が}\ n\ \text{に依らないので和の外へ出した}) \\
&= \cosh(K_1)\hat{Y}_\mu - i\,e^{i\frac{2\pi\mu}{M}}\sinh(K_1)\hat{Z}_\mu^{(\pm)}
&&(\because\ \text{「sinh, cosh のテイラー展開」}) \\
&= -i\,e^{i\frac{2\pi\mu}{M}}\sinh(K_1)\hat{Z}_\mu^{(\pm)} + \cosh(K_1)\hat{Y}_\mu
&&(\because\ \text{行列の和の可換則により 2 つの項を並べ替えた})
\end{aligned}`,
      ),
      paragraph([
        "鎖の終点は主張の (h1.y) の右辺と字句どおり一致する。",
      ]),
      paragraph(["(h2.z−) について、"]),
      displayMath(
        String.raw`\begin{aligned}
(\text{左辺})
&= \frac{1}{0!}\hat{Z}_\mu^{(-)}
   + \sum_{n=1}^{\infty}\frac{1}{n!}\begin{cases}
-i\cdot (2K_2^*)^{n}\cdot\hat{Y}_\mu & (n\text{ 奇数}) \\
(2K_2^*)^{n}\cdot\hat{Z}_\mu^{(-)} & (n\text{ 偶数})
\end{cases}
&&(\because\ n = 0\ \text{の項を分け、}\ n \geq 1\ \text{の各項へ「cosh, sinh の展開係数への変換」の (h2.z−)}) \\
&= \sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\left(\frac{1}{n!}(2K_2^*)^{n}\hat{Z}_\mu^{(-)}\right)
   + \sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\left(\frac{1}{n!}\,(-i)\,(2K_2^*)^{n}\,\hat{Y}_\mu\right)
&&(\because\ (2K_2^*)^{0}\hat{Z}_\mu^{(-)} = \tfrac{1}{0!}\hat{Z}_\mu^{(-)}\ \text{なので}\ n = 0\ \text{の項を偶数側の和へ吸収した}) \\
&= \left(\sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\frac{1}{n!}(2K_2^*)^{n}\right)\hat{Z}_\mu^{(-)}
   - i\left(\sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\frac{1}{n!}(2K_2^*)^{n}\right)\hat{Y}_\mu
&&(\because\ \hat{Z}_\mu^{(-)},\ \hat{Y}_\mu,\ -i\ \text{が}\ n\ \text{に依らないので和の外へ出した}) \\
&= \cosh(2K_2^*)\hat{Z}_\mu^{(-)} - i\sinh(2K_2^*)\hat{Y}_\mu
&&(\because\ \text{「sinh, cosh のテイラー展開」})
\end{aligned}`,
      ),
      paragraph([
        "鎖の終点は主張の (h2.z−) の右辺と字句どおり一致する。",
      ]),
      paragraph(["(h2.y) について、"]),
      displayMath(
        String.raw`\begin{aligned}
(\text{左辺})
&= \frac{1}{0!}\hat{Y}_\mu
   + \sum_{n=1}^{\infty}\frac{1}{n!}\begin{cases}
i\cdot (2K_2^*)^{n}\cdot\hat{Z}_\mu^{(-)} & (n\text{ 奇数}) \\
(2K_2^*)^{n}\cdot\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&(\because\ n = 0\ \text{の項を分け、}\ n \geq 1\ \text{の各項へ「cosh, sinh の展開係数への変換」の (h2.y)}) \\
&= \sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\left(\frac{1}{n!}(2K_2^*)^{n}\hat{Y}_\mu\right)
   + \sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\left(\frac{1}{n!}\,i\,(2K_2^*)^{n}\,\hat{Z}_\mu^{(-)}\right)
&&(\because\ (2K_2^*)^{0}\hat{Y}_\mu = \tfrac{1}{0!}\hat{Y}_\mu\ \text{なので}\ n = 0\ \text{の項を偶数側の和へ吸収した}) \\
&= \left(\sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\frac{1}{n!}(2K_2^*)^{n}\right)\hat{Y}_\mu
   + i\left(\sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\frac{1}{n!}(2K_2^*)^{n}\right)\hat{Z}_\mu^{(-)}
&&(\because\ \hat{Y}_\mu,\ \hat{Z}_\mu^{(-)},\ i\ \text{が}\ n\ \text{に依らないので和の外へ出した}) \\
&= \cosh(2K_2^*)\hat{Y}_\mu + i\sinh(2K_2^*)\hat{Z}_\mu^{(-)}
&&(\because\ \text{「sinh, cosh のテイラー展開」}) \\
&= i\sinh(2K_2^*)\hat{Z}_\mu^{(-)} + \cosh(2K_2^*)\hat{Y}_\mu
&&(\because\ \text{和の可換性で 2 項を並べ替えた})
\end{aligned}`,
      ),
      paragraph([
        "鎖の終点は主張の (h2.y) の右辺と字句どおり一致する。以上 4 式がいずれも statement の右辺と一致するので、主張が成り立つ。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文 proof の (h1.z) は完全（cosh/sinh まで到達）。(h1.y) と (h2.z−) は原文 proof が偶奇分割の途中で終わっており、かつ cases 内の項・係数が statement と不整合だった。(h2.y) には原文 proof が無かった。本作業でこの 3 式を statement と整合する形へ直し、いずれも cosh/sinh まで書き切った。",
        "どちらが誤りかは数値検証で確定させた。sagemath/check/040_claim_extract_taylor_coefficient_of_Z_Y/check_04_original_typo_refuted.sage により、原文 proof の cases 表式 —— (h1.y) 奇数項 i K_1^n e^{iθ} hat(Y)_mu・偶数項 K_1^n hat(Z)_mu、(h2.z−) の (K_2^*)^n と偶数項に残る i —— は M=3,4,5・n=1..4 のすべてで残差が 1e-3 を大きく超えて成り立たない一方、statement と整合する修正後の cases は残差 1e-8 以下で成立することを確認した。したがって誤りは proof 側にあり、statement は正しい。",
        "4 式の最終形（cosh/sinh 表示）そのものも check_03_taylor_sums.sage で、級数を 40 次で打ち切って M=3,4,5・全 mu ∈ calM・複数の (K1,K2) について残差 1e-8 以下であることを確認済み。土台となる 1 重公式 (A)〜(D) は check_01_single_commutators.sage で確認した。",
        "原文 statement は (h1.y)/(h2.y) の左辺を「Σ (⋯)」と省略していたが、どの生成子でネストした交換子かが左辺だけで確定しないため、他の 2 式と同じ形へ明示的に書き下した。",
        "(h1.y) の鎖を (h1.z) と同じ「一続きの鎖＋行末の (∵ …)」の形へ揃えた（2026-08-11）。根拠の無かった 5 段すべてに行末の根拠を付け、鎖の終点が主張の (h1.y) の右辺と字句どおり一致することを地の文で述べた。段は減らしていない。残りは (h2.z−)・(h2.y) の 2 式である。",
        "(h2.z−) の鎖を (h1.z)・(h1.y) と同じ「一続きの鎖＋行末の (∵ …)」の形へ揃えた（2026-08-11）。根拠の無かった 4 段すべてに行末の根拠を付け、鎖の終点が主張の (h2.z−) の右辺と字句どおり一致することを地の文で述べた。段は減らしていない。残りは (h2.y) の 1 式である。",
        "(h2.y) の鎖も同じ形へ揃えた（2026-08-11）。根拠の無かった 5 段すべてに行末の根拠を付け、鎖の終点が主張の (h2.y) の右辺と字句どおり一致することを地の文で述べた。段は減らしていない。これでこの主張の 4 式がすべて同じ形になった。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_006_claim_exp_conjugation",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/005_claim_exp_X_Y_exp_minus_X.typ",
      ordinal: 6,
    },
    title: null,
    labels: ["exp_X_Y_exp_-X"],
    statement: [
      paragraph([
        math(String.raw`d\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`X, Y\in\mathrm{Mat}(d,\mathbb{C})`),
        " とする。",
        math(String.raw`\exp`),
        " は ",
        ref("def_exp"),
        "、",
        math(String.raw`\mathrm{ad}_X:\mathrm{Mat}(d,\mathbb{C})\to\mathrm{Mat}(d,\mathbb{C}),\ Z\mapsto[X,Z]=XZ-ZX`),
        " は ",
        ref("def_ad_X_matrix"),
        "、",
        math(String.raw`\mathrm{Ad}_{g}(Y):=gYg^{-1}`),
        "（",
        math(String.raw`g`),
        " は正則行列）も ",
        ref("def_ad_X_matrix"),
        " の記号とする。このとき ",
        math(String.raw`\exp(X)`),
        " は正則であり、右辺の級数は ",
        math(String.raw`\mathrm{Mat}(d,\mathbb{C})`),
        " において収束して、",
      ]),
      displayMath(
        String.raw`\exp(X)\,Y\,\exp(-X)
= \mathrm{Ad}_{\exp(X)}(Y)
= \exp(\mathrm{ad}_X)(Y)
= \sum_{n=0}^{\infty} \frac{1}{n!}
  \underbrace{[X,[X,\dots,[X,Y]\dots]]}_{n}`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`n=0`),
        " のとき括弧なしで ",
        math(String.raw`Y`),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "本主張は行列環 ",
        math(String.raw`\mathrm{Mat}(d,\mathbb{C})`),
        " 上の主張であり、Lie 群・Lie 環の理論を使わずに証明できる。",
        ref("matrix_exp_conjugation"),
        " を ",
        math(String.raw`K:=\mathbb{C}`),
        "、",
        math(String.raw`n:=d`),
        " として適用する。同ブロックは ",
        ref("ad_binomial"),
        "（純代数的な ad 展開公式）と ",
        ref("real_exp_series_converges"),
        "・",
        ref("matrix_norm_submultiplicativity"),
        "・",
        ref("matrix_exp_series_converges"),
        "（指数級数の絶対収束と行列ノルムの劣乗法性）だけから証明されており、Lie 群論には依存しない。",
      ]),
      paragraph([
        "Step 1: ",
        ref("matrix_exp_conjugation"),
        " (1) より級数 ",
        math(String.raw`\sum_{m=0}^{\infty}\frac{1}{m!}\mathrm{ad}_X^{m}(Y)`),
        " は ",
        math(String.raw`\mathrm{Mat}(d,\mathbb{C})`),
        " において収束し、(2) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(X)\,Y\,\exp(-X)
&= \sum_{m=0}^{\infty}\frac{1}{m!}\,\mathrm{ad}_X^{m}(Y)
&&\left(\because\ \text{「行列の exp による共役と交換子級数」(2)}\right) \\
&= \exp\!\left(\mathrm{ad}_X\right)(Y)
&&\left(\because\ \text{行列への線型写像 }\mathrm{ad}_X\text{ の exp の定義}\right)
\end{aligned}`,
      ),
      paragraph([
        "Step 2: ",
        ref("ad_binomial"),
        " の再帰の定義 ",
        math(String.raw`\mathrm{ad}_X^{0}(Y)=Y`),
        "、",
        math(String.raw`\mathrm{ad}_X^{m+1}(Y)=[X,\mathrm{ad}_X^{m}(Y)]`),
        " を出発点にすると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{ad}_X^{0}(Y)
&= Y
&&\left(\because\ \mathrm{ad}_X\text{ の反復の定義}\right), \\
\mathrm{ad}_X^{m+1}(Y)
&= [X,\mathrm{ad}_X^{m}(Y)]
&&\left(\because\ \mathrm{ad}_X\text{ の反復の定義}\right), \\
\mathrm{ad}_X^{m}(Y)
&= \underbrace{[X,[X,\dots,[X,Y]\dots]]}_{m}
&&\left(\because\ m\in\mathbb{Z}_{\ge 0}\text{ について上の二式を反復}\right)
\end{aligned}`,
      ),
      paragraph([
        "最後の式では ",
        math(String.raw`m=0`),
        " のとき括弧なしで ",
        math(String.raw`Y`),
        " と読む。したがって Step 1 の中辺は主張の最右辺に一致する。",
      ]),
      paragraph([
        "Step 3: ",
        ref("matrix_exp_conjugation"),
        " (3) より ",
        math(String.raw`\exp(X)`),
        " は正則で ",
        math(String.raw`\exp(X)^{-1}=\exp(-X)`),
        " であるから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{Ad}_{\exp(X)}(Y)
&= \exp(X)\,Y\,\exp(X)^{-1}
&&\left(\because\ \mathrm{Ad}_{g}(Y)=gYg^{-1}\text{ の定義}\right) \\
&= \exp(X)\,Y\,\exp(-X)
&&\left(\because\ \exp(X)^{-1}=\exp(-X)\right)
\end{aligned}`,
      ),
      paragraph([
        "以上より主張のすべての等号が成り立つ。なお、本証明で非可算集合 ",
        math(String.raw`\mathbb{R}/\mathbb{C}`),
        " の解析（極限）を使うのは ",
        ref("matrix_exp_conjugation"),
        " の内部の収束議論だけであり、その根拠は ",
        ref("matrix_completeness"),
        "（",
        math(String.raw`\mathbb{R}`),
        " の完備性）である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（Typst）の proof は「リー群・リー環の掘り下げを避けて一旦受け入れる」" +
          "という暫定記述だった。本主張は行列環上の主張なので、" +
          "labels: matrix_exp_conjugation（005 で Lie 群論に依存せず完全証明済み）から" +
          "完全な証明へ書き換えた。statement 側にも X, Y の所属集合（Mat(d,C)）と" +
          "記号の定義元を明示した。",
        "級数展開・反復交換子・共役写像の三つの計算を、一続きの式変形と行末の根拠へ揃えた（2026-08-15）。参照先と証明内容は変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_009_definition_invertible_elements",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/008_definition_環の乗法群.typ",
      ordinal: 9,
    },
    title: { tex: String.raw`\mathrm{Mat}(2^M,\mathbb{C}) \text{ の可逆元}` },
    labels: ["def_invertible_elements_of_R"],
    statement: [
      paragraph([
        math(String.raw`R := \mathrm{Mat}(2^M,\mathbb{C})`),
        " と書き、その単位元を ",
        math(String.raw`I := I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        " と書く。",
        math(String.raw`g \in R`),
        " が可逆であるとは、",
      ]),
      displayMath(String.raw`\exists h \in R,\quad g\,h = I \ \text{ かつ } \ h\,g = I`),
      paragraph([
        "が成り立つことをいう。可逆な元全体の集合を",
      ]),
      displayMath(
        String.raw`R^\times := \{\, g \in R \mid g \text{ は可逆} \,\}`,
      ),
      paragraph([
        "と書く。",
        math(String.raw`g \in R^\times`),
        " に対して上の ",
        math(String.raw`h`),
        " はただ 1 つに定まり、これを ",
        math(String.raw`g^{-1}`),
        " と書く。さらに次が成り立つ。",
      ]),
      list([
        ["(i) ", math(String.raw`I \in R^\times`), " であり ", math(String.raw`I^{-1} = I`), "。"],
        [
          "(ii) ",
          math(String.raw`g_1, g_2 \in R^\times`),
          " なら ",
          math(String.raw`g_1 g_2 \in R^\times`),
          " であり ",
          math(String.raw`(g_1g_2)^{-1} = g_2^{-1}g_1^{-1}`),
          "。",
        ],
        [
          "(iii) ",
          math(String.raw`g \in R^\times`),
          " なら ",
          math(String.raw`g^{-1} \in R^\times`),
          " であり ",
          math(String.raw`(g^{-1})^{-1} = g`),
          "。",
        ],
        [
          "(iv) ",
          math(String.raw`c \in \mathbb{C}\setminus\{0\}`),
          " なら ",
          math(String.raw`c\,I \in R^\times`),
          " であり ",
          math(String.raw`(cI)^{-1} = c^{-1}I`),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "（逆元の一意性）",
        math(String.raw`h_1, h_2 \in R`),
        " がともに ",
        math(String.raw`g h_1 = h_1 g = I`),
        "、",
        math(String.raw`g h_2 = h_2 g = I`),
        " を満たすとする。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
h_1
&= h_1 I
&&(\because\ \text{単位行列との積})\\
&= h_1 (g h_2)
&&(\because\ g h_2 = I\ \text{の代入})\\
&= (h_1 g) h_2
&&(\because\ \text{行列の積の結合律})\\
&= I h_2
&&(\because\ h_1 g = I\ \text{の代入})\\
&= h_2
&&(\because\ \text{単位行列との積})
\end{aligned}`,
      ),
      paragraph(["であるから、逆元はただ 1 つである。"]),
      paragraph([
        "(i) ",
        math(String.raw`I\,I = I`),
        " より ",
        math(String.raw`I`),
        " は可逆で ",
        math(String.raw`I^{-1} = I`),
        "。",
      ]),
      paragraph([
        "(ii) ",
        math(String.raw`h := g_2^{-1}g_1^{-1}`),
        " とおくと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(g_1g_2)h
&= g_1 g_2 g_2^{-1} g_1^{-1}
&&(\because\ h = g_2^{-1}g_1^{-1}\ \text{の代入と行列の積の結合律})\\
&= g_1 I g_1^{-1}
&&(\because\ g_2 g_2^{-1} = I)\\
&= g_1g_1^{-1}
&&(\because\ \text{単位行列との積})\\
&= I
&&(\because\ g_1 g_1^{-1} = I)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
h(g_1g_2)
&= g_2^{-1} g_1^{-1} g_1 g_2
&&(\because\ h = g_2^{-1}g_1^{-1}\ \text{の代入と行列の積の結合律})\\
&= g_2^{-1} I g_2
&&(\because\ g_1^{-1} g_1 = I)\\
&= g_2^{-1}g_2
&&(\because\ \text{単位行列との積})\\
&= I
&&(\because\ g_2^{-1} g_2 = I)
\end{aligned}`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`g_1g_2 \in R^\times`),
        " であり、逆元の一意性より ",
        math(String.raw`(g_1g_2)^{-1} = g_2^{-1}g_1^{-1}`),
        "。",
      ]),
      paragraph([
        "(iii) ",
        math(String.raw`g g^{-1} = g^{-1} g = I`),
        " は、",
        math(String.raw`g^{-1}`),
        " に対して ",
        math(String.raw`g`),
        " が逆元の条件を満たすことをそのまま述べている。よって ",
        math(String.raw`g^{-1} \in R^\times`),
        " であり、逆元の一意性より ",
        math(String.raw`(g^{-1})^{-1} = g`),
        "。",
      ]),
      paragraph(["(iv) 次の 2 つの一続きの変形による。"]),
      displayMath(
        String.raw`\begin{aligned}
(cI)(c^{-1}I)
&= (cc^{-1})I
&&(\because\ \text{スカラー倍の単位行列は積と可換（スカラー倍と単位行列の積の整理）})\\
&= I
&&(\because\ c\,c^{-1} = 1\ \text{と単位行列のスカラー }1\text{ 倍})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
(c^{-1}I)(cI)
&= (c^{-1}c)I
&&(\because\ \text{スカラー倍の単位行列は積と可換（スカラー倍と単位行列の積の整理）})\\
&= I
&&(\because\ c^{-1}c = 1\ \text{と単位行列のスカラー }1\text{ 倍})
\end{aligned}`,
      ),
      paragraph([
        "（スカラー倍と単位行列の積の整理は ",
        ref("scalar_identity_commutes"),
        " による。）であるから ",
        math(String.raw`cI \in R^\times`),
        " であり、逆元の一意性より ",
        math(String.raw`(cI)^{-1} = c^{-1}I`),
        "。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文（parts/008/008）は「環 R の乗法群 R^×」という一般の環についての定義だった。README 2 節「環・体などの一般論に持ち上げた証明は使わない」・3 節 2「脇道の一般論なら具体的な形に落として本文に書く」に従い、Mat(2,C)^{⊗M} の可逆元についての具体的な定義へ書き換え、以降の証明で実際に使う性質（逆元の一意性、単位元・積・逆元・スカラー倍についての可逆性）だけを主張として立てた。一般の環についての元の記述は notes/008_group_theory_general.ts へ移した。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_definition_pauli_group",
    kind: "definition",
    origin: { path: "structured-latex/content/008_TV1_hatZ_hatY_part1.ts", ordinal: 10 },
    title: { text: "パウリ行列群" },
    labels: ["def_pauli_group"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        math(String.raw`R := \mathrm{Mat}(2^M,\mathbb{C})`),
        " と書く。",
        ref("pauli_matrix_products"),
        " の Pauli 行列 ",
        math(String.raw`\sigma^x, \sigma^y, \sigma^z`),
        " と単位行列 ",
        math(String.raw`\sigma^0 := I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " を用い、",
        math(String.raw`\mathbb{A} := \{0, x, y, z\}`),
        " とおく。",
      ]),
      paragraph([math(String.raw`M`), " 因子のパウリ行列群を"]),
      displayMath(
        String.raw`\mathcal{P}_M := \left\{\,i^{k}\,\sigma^{a_1}\boxtimes\sigma^{a_2}\boxtimes\cdots\boxtimes\sigma^{a_M}
\ \middle|\ k \in \{0,1,2,3\},\ (a_1,\dots,a_M) \in \mathbb{A}^M \right\} \subseteq R`,
      ),
      paragraph([
        "と定める。",
        math(String.raw`\mathcal{P}_M`),
        " は行列の積について群をなす（",
        ref("pauli_matrix_products"),
        " より各 ",
        math(String.raw`\sigma^a\sigma^b`),
        " は ",
        math(String.raw`i^k\sigma^c`),
        " の形になり、クロネッカー積どうしの積は各因子ごとの ",
        math(String.raw`2`),
        " 次の行列の積になる：",
        ref("kronecker_product_rule"),
        " (1)。スカラー倍を外へ出すのは ",
        ref("kronecker_multilinear"),
        "）。",
        math(String.raw`\#\mathcal{P}_M = 4\cdot 4^M`),
        " であり、とくに有限群である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "パウリ行列群とクリフォード行列群が同じブロックに定義されていたため、1 ブロック 1 定義の規則に従って分離した。定義・ラベル・後続参照の内容は変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_010_definition_clifford_group",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/009_definition_TODO_クリフォード群.typ",
      ordinal: 10,
    },
    title: { text: "クリフォード行列群" },
    labels: ["def_clifford_group"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        math(String.raw`R := \mathrm{Mat}(2^M,\mathbb{C})`),
        " と書く。",
        ref("def_pauli_group"),
        " のパウリ行列群を ",
        math(String.raw`\mathcal{P}_M`),
        " とする。",
      ]),
      paragraph([
        "クリフォード群を、",
        math(String.raw`R`),
        " の可逆元全体（",
        ref("def_invertible_elements_of_R"),
        "）",
        math(String.raw`R^\times`),
        " の中で ",
        math(String.raw`\mathcal{P}_M`),
        " を保つ元全体、すなわち ",
        math(String.raw`\mathcal{P}_M`),
        " の ",
        math(String.raw`R^\times`),
        " における正規化群として",
      ]),
      displayMath(
        String.raw`\mathcal{C}_M := \left\{\, g \in R^\times \ \middle|\ g\,\mathcal{P}_M\,g^{-1} = \mathcal{P}_M \right\}`,
      ),
      paragraph([
        "と定める。",
        math(String.raw`\mathcal{C}_M`),
        " は ",
        math(String.raw`R^\times`),
        " の部分群である。単位元については ",
        math(String.raw`I\,\mathcal{P}_M\,I^{-1} = \mathcal{P}_M`),
        " なので ",
        math(String.raw`I \in \mathcal{C}_M`),
        "。積については、",
        math(String.raw`g_1, g_2 \in \mathcal{C}_M`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
(g_1g_2)\,\mathcal{P}_M\,(g_1g_2)^{-1}
&= g_1\left(g_2\,\mathcal{P}_M\,g_2^{-1}\right)g_1^{-1}
&&(\because\ (g_1g_2)^{-1} = g_2^{-1}g_1^{-1}\ \text{と行列の積の結合則})\\
&= g_1\,\mathcal{P}_M\,g_1^{-1}
&&(\because\ g_2 \in \mathcal{C}_M)\\
&= \mathcal{P}_M
&&(\because\ g_1 \in \mathcal{C}_M)
\end{aligned}`),
      paragraph([
        "なので ",
        math(String.raw`g_1g_2 \in \mathcal{C}_M`),
        "。逆元については、",
        math(String.raw`g\mathcal{P}_Mg^{-1} = \mathcal{P}_M`),
        " の両辺を左から ",
        math(String.raw`g^{-1}`),
        "、右から ",
        math(String.raw`g`),
        " で挟んで ",
        math(String.raw`g^{-1}\mathcal{P}_Mg = \mathcal{P}_M`),
        " なので ",
        math(String.raw`g^{-1} \in \mathcal{C}_M`),
        " である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文（parts/008/009）は definition の体裁だが中身は著者の検討メモであり、箇条書き 3 項目（クリフォード群の定義／T_g の定義をクリフォード群へ狭める／T の定数倍を除いた単射性を示す）と、3 つ目に付随する『3 つのアプローチ』が書かれていた。原文の 3 つのアプローチは次のとおり（原文の文言）: 試す1「V を具体的な行列として書く、がゴールなので T_((V)) からその表式を見つけられないか？」／試す2「T の（定数倍除いた）単射性を（Cl に触れずに）示す」／だめだったら3「Cl と行列環の同型を認め、T の（定数倍除いた）単射性も認め、計算を先に進める」。",
        "本作業でこの検討は決着した。(a) T の（定数倍を除いた）単射性は Clifford 代数と行列環の同型を経由せず、すべての元と可換な元がスカラー倍の単位行列に限ること（centralizer_is_scalar）から直接示せる（injectivity_of_T_up_to_scalar）。すなわち原文の『試す2』が成立し、『試す1』『だめだったら3』は不要である。(b) 一方『T_g を定める g をクリフォード群の元に狭める』という方針は採れない。V_2 がクリフォード群に属さないためで、これは V2_not_in_clifford_group で証明した。したがって本文では g の許容範囲を R^× のままとし（def_T_g）、各 T_g の定義域は R とする。クリフォード群は本証明では使わない。",
        "パウリ行列群の定義を独立ブロックへ分離した。イジング模型固有の V_2 を用いた導入理由は後続の V_2 ∉ C_M の主張と重複するため、この数学的道具の定義から除いた。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_010a_claim_V2_not_in_clifford_group",
    kind: "claim",
    origin: { path: "structured-latex/content/008_TV1_hatZ_hatY_part1.ts", ordinal: 10 },
    title: { tex: String.raw`V_2 \notin \mathcal{C}_M` },
    labels: ["V2_not_in_clifford_group"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`V_2 = (2s_2)^{M/2}\exp\!\left(K_2^*\sum_{k=1}^{M}\sigma_k^x\right)`),
        " は ",
        ref("def_clifford_group"),
        " のクリフォード群 ",
        math(String.raw`\mathcal{C}_M`),
        " に属さない。",
      ]),
      paragraph([
        "したがって ",
        ref("def_T_g"),
        " の ",
        math(String.raw`T_g`),
        " の定義域をクリフォード群に限定すると、本証明で必要な ",
        math(String.raw`T_{V_2}`),
        " およびその合成 ",
        math(String.raw`T_{(V)}`),
        " が定義できなくなる。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1: ",
        math(String.raw`\{\sigma^0, \sigma^x, \sigma^y, \sigma^z\}`),
        " が ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の基底であること。",
        math(String.raw`a, b, c, d \in \mathbb{C}`),
        " について",
      ]),
      displayMath(
        String.raw`a\sigma^0 + b\sigma^x + c\sigma^y + d\sigma^z
= \begin{pmatrix} a + d & b - ic \\ b + ic & a - d \end{pmatrix}`,
      ),
      paragraph([
        "が零行列なら、",
        math(String.raw`a+d = 0,\ a-d = 0`),
        " より ",
        math(String.raw`a = d = 0`),
        "、",
        math(String.raw`b - ic = 0,\ b + ic = 0`),
        " より辺々加えて ",
        math(String.raw`2b = 0`),
        " すなわち ",
        math(String.raw`b = 0`),
        "、したがって ",
        math(String.raw`c = 0`),
        "。よって 4 元は線型独立であり、",
        math(String.raw`\dim_\mathbb{C}\mathrm{Mat}(2,\mathbb{C}) = 4`),
        " なので基底である。",
        ref("tensor_basis"),
        " より ",
        math(String.raw`\{\sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_M} \mid (a_1,\dots,a_M)\in\mathbb{A}^M\}`),
        " は ",
        math(String.raw`R`),
        " の基底である。",
      ]),
      paragraph([
        "Step 2: ",
        math(String.raw`t \in \mathbb{C}`),
        " について ",
        math(String.raw`\exp(t\sigma^x) = \cosh(t)\sigma^0 + \sinh(t)\sigma^x`),
        "。",
        math(String.raw`(\sigma^x)^2 = \sigma^0`),
        "（",
        ref("pauli_matrix_products"),
        "）より ",
        math(String.raw`(\sigma^x)^n = \sigma^0`),
        "（",
        math(String.raw`n`),
        " 偶数）、",
        math(String.raw`(\sigma^x)^n = \sigma^x`),
        "（",
        math(String.raw`n`),
        " 奇数）であるから、",
        ref("def_exp"),
        " の級数を偶数項・奇数項に分けて",
      ]),
      displayMath(
        String.raw`\exp(t\sigma^x)
= \sum_{n=0}^{\infty}\frac{t^n}{n!}(\sigma^x)^n
= \left(\sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\frac{t^n}{n!}\right)\sigma^0
+ \left(\sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\frac{t^n}{n!}\right)\sigma^x
= \cosh(t)\sigma^0 + \sinh(t)\sigma^x`,
      ),
      paragraph([
        "（級数の絶対収束は ",
        ref("matrix_exp_series_converges"),
        " による。偶奇の分割と ",
        math(String.raw`\cosh, \sinh`),
        " の級数は ",
        ref("real_exp_series_converges"),
        " の実指数級数の並べ替えである。）",
      ]),
      paragraph([
        "Step 3: ",
        math(String.raw`\sigma_1^z := \sigma^z\boxtimes\sigma^0\boxtimes\cdots\boxtimes\sigma^0 \in \mathcal{P}_M`),
        " の ",
        math(String.raw`V_2`),
        " による共役を計算する。",
        math(String.raw`k \neq l`),
        " のとき ",
        math(String.raw`\sigma_k^x`),
        " と ",
        math(String.raw`\sigma_l^x`),
        " はクロネッカー積の異なるサイトにのみ ",
        math(String.raw`\sigma^x`),
        " を置き（他のサイトは ",
        math(String.raw`\sigma^0 = I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "）、",
        ref("kronecker_product_rule"),
        " (1) より積は各サイトごとの ",
        math(String.raw`2`),
        " 次の行列の積になるから可換であり、",
        ref("theorem_exp_product"),
        " より",
      ]),
      displayMath(
        String.raw`\exp\!\left(K_2^*\sum_{k=1}^{M}\sigma_k^x\right)
= \prod_{k=1}^{M}\exp\!\left(K_2^*\sigma_k^x\right)`,
      ),
      paragraph([
        "また ",
        math(String.raw`k \neq 1`),
        " のとき ",
        math(String.raw`\exp(K_2^*\sigma_k^x)`),
        " は第 1 因子に ",
        math(String.raw`\sigma^0`),
        " をもつので ",
        math(String.raw`\sigma_1^z`),
        " と可換であり、共役の中で相殺する。スカラー ",
        math(String.raw`(2s_2)^{M/2}`),
        " も ",
        ref("scalar_identity_commutes"),
        " により相殺する。よって",
      ]),
      displayMath(
        String.raw`V_2\,\sigma_1^z\,V_2^{-1}
= \exp\!\left(K_2^*\sigma_1^x\right)\sigma_1^z\exp\!\left(-K_2^*\sigma_1^x\right)
= \left(\exp\!\left(K_2^*\sigma^x\right)\sigma^z\exp\!\left(-K_2^*\sigma^x\right)\right)\boxtimes\sigma^0\boxtimes\cdots\boxtimes\sigma^0`,
      ),
      paragraph([
        "Step 4: 第 1 因子を計算する。",
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^z\sigma^x = -\sigma^x\sigma^z`),
        " を ",
        math(String.raw`n`),
        " 回使うと ",
        math(String.raw`\sigma^z(\sigma^x)^n = (-\sigma^x)^n\sigma^z`),
        "、すなわち ",
        math(String.raw`(\sigma^x)^n\sigma^z = \sigma^z(-\sigma^x)^n`),
        " なので、級数の各項ごとに",
      ]),
      displayMath(
        String.raw`\exp\!\left(K_2^*\sigma^x\right)\sigma^z
= \sum_{n=0}^{\infty}\frac{(K_2^*)^n}{n!}(\sigma^x)^n\sigma^z
= \sigma^z\sum_{n=0}^{\infty}\frac{(-K_2^*)^n}{n!}(\sigma^x)^n
= \sigma^z\exp\!\left(-K_2^*\sigma^x\right)`,
      ),
      paragraph([
        "また、",
        math(String.raw`c_2^* = \cosh 2K_2^*,\ s_2^* = \sinh 2K_2^*`),
        "（",
        ref("def_transfer_matrix_symbols"),
        "）と、成分計算（",
        ref("mat_mult"),
        "）による",
      ]),
      displayMath(
        String.raw`\sigma^z\sigma^x
= \begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix}
= \begin{pmatrix}0&1\\-1&0\end{pmatrix}
= i\begin{pmatrix}0&-i\\i&0\end{pmatrix}
= i\,\sigma^y
\quad (\because \text{行列の積の成分計算とスカラー倍の定義})`,
      ),
      paragraph([
        "を使う。すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp\!\left(K_2^*\sigma^x\right)\sigma^z\exp\!\left(-K_2^*\sigma^x\right)
&= \sigma^z\exp\!\left(-K_2^*\sigma^x\right)\exp\!\left(-K_2^*\sigma^x\right)
   \quad (\because \text{直前の式 } \exp(K_2^*\sigma^x)\sigma^z = \sigma^z\exp(-K_2^*\sigma^x)) \\
&= \sigma^z\exp\!\left(-2K_2^*\sigma^x\right)
   \quad (\because \text{可換な行列の exp 積公式}) \\
&= \sigma^z\left(\cosh(2K_2^*)\sigma^0 - \sinh(2K_2^*)\sigma^x\right)
   \quad (\because \text{Step 2},\ \cosh(-t)=\cosh t,\ \sinh(-t)=-\sinh t) \\
&= \cosh(2K_2^*)\,\sigma^z - \sinh(2K_2^*)\,\sigma^z\sigma^x
   \quad (\because \text{行列の積の分配則と}\ \sigma^z\sigma^0 = \sigma^z) \\
&= c_2^*\,\sigma^z - i\,s_2^*\,\sigma^y
   \quad (\because \text{上で計算した}\ \sigma^z\sigma^x = i\,\sigma^y\ \text{と略記}\ c_2^*,\ s_2^*)
\end{aligned}`,
      ),
      paragraph([
        "Step 5: 結論。",
        math(String.raw`K_2^* > 0`),
        " より ",
        math(String.raw`c_2^* > 0`),
        " かつ ",
        math(String.raw`s_2^* > 0`),
        "（",
        ref("def_transfer_matrix_symbols"),
        "）なので、Step 3・Step 4 より",
      ]),
      displayMath(
        String.raw`V_2\,\sigma_1^z\,V_2^{-1}
= c_2^*\left(\sigma^z\boxtimes\sigma^0\boxtimes\cdots\boxtimes\sigma^0\right)
- i\,s_2^*\left(\sigma^y\boxtimes\sigma^0\boxtimes\cdots\boxtimes\sigma^0\right)`,
      ),
      paragraph([
        "は Step 1 の基底に関して相異なる 2 つの基底元の係数がともに ",
        math(String.raw`0`),
        " でない。一方 ",
        math(String.raw`\mathcal{P}_M`),
        " の元 ",
        math(String.raw`i^k\sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_M}`),
        " は同じ基底に関して非零の係数をちょうど 1 つしかもたない。基底に関する表示の一意性より ",
        math(String.raw`V_2\sigma_1^zV_2^{-1} \notin \mathcal{P}_M`),
        "。したがって ",
        math(String.raw`V_2\mathcal{P}_MV_2^{-1} \neq \mathcal{P}_M`),
        " であり ",
        math(String.raw`V_2 \notin \mathcal{C}_M`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文の検討メモにあった『T_g の定義をクリフォード群の元に狭める』という方針が採れないことを示す主張。原文には無く、本作業で新規に追加した。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_011_definition_T_g",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/010_definition_T_g.typ",
      ordinal: 11,
    },
    title: { tex: String.raw`T_g \text{ の定義}` },
    labels: ["def_T_g"],
    statement: [
      paragraph([
        ref("def_invertible_elements_of_R"),
        " の記号を使い、",
        math(String.raw`g \in (\mathrm{Mat}(2^M,\mathbb{C}))^\times`),
        " について、",
      ]),
      displayMath(
        String.raw`T_g : \mathrm{Mat}(2^M,\mathbb{C}) \to \mathrm{Mat}(2^M,\mathbb{C}), \quad h \mapsto g \cdot h \cdot g^{-1}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_011a_claim_center_of_invertible_matrices_is_scalar",
    kind: "claim",
    origin: { path: "structured-latex/content/008_TV1_hatZ_hatY_part1.ts", ordinal: 11 },
    title: { tex: String.raw`\mathrm{Mat}(2^M,\mathbb{C})^\times \text{ の全元と可換する可逆行列}` },
    labels: [
      "center_of_multiplicative_group_is_scalar",
      "invertible_matrix_centralizer_is_nonzero_scalar_identity",
    ],
    statement: [
      paragraph([
        math(String.raw`R := \mathrm{Mat}(2^M,\mathbb{C})`),
        "、",
        math(String.raw`I := I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        " とし、",
        math(String.raw`R^\times`),
        " を ",
        ref("def_invertible_elements_of_R"),
        " の可逆行列全体とする。さらに、",
        math(String.raw`R^\times`),
        " のすべての元と可換な ",
        math(String.raw`R^\times`),
        " の元全体を",
      ]),
      displayMath(
        String.raw`C(R^\times) := \left\{\, W \in R^\times \;\middle|\; \forall h \in R^\times,\ W h = h W \,\right\}`,
      ),
      paragraph(["と書く。このとき"]),
      displayMath(
        String.raw`C(R^\times) = \{\, cI \mid c \in \mathbb{C}\setminus\{0\} \,\}`,
      ),
      paragraph([
        "である。すなわち、すべての可逆行列と可換する可逆行列は、非零複素数倍の単位行列に限る。",
      ]),
    ],
    proof: [
      paragraph([
        "まず右辺が左辺に含まれることを示す。",
        math(String.raw`c \in \mathbb{C}\setminus\{0\}`),
        " とする。",
        ref("def_invertible_elements_of_R"),
        " (iv) より ",
        math(String.raw`cI \in R^\times`),
        " であり、",
        ref("scalar_identity_commutes"),
        " より ",
        math(String.raw`cI`),
        " はすべての ",
        math(String.raw`h \in R^\times`),
        " と可換する。したがって ",
        math(String.raw`cI \in C(R^\times)`),
        " である。",
      ]),
      paragraph([
        "次に左辺が右辺に含まれることを示す。",
        math(String.raw`W \in C(R^\times)`),
        " とする。",
        ref("tensor_basis"),
        " (1) の多重添字を使い、",
        math(String.raw`P,Q \in \mathcal{I}_M`),
        " に対応する行列単位を ",
        math(String.raw`E_{P,Q}`),
        " と書く。まず、この行列単位の積を確認する。",
      ]),
      paragraph([
        math(String.raw`P=(p_1,\dots,p_M)`),
        "、",
        math(String.raw`Q=(q_1,\dots,q_M)`),
        "、",
        math(String.raw`K=(k_1,\dots,k_M)`),
        "、",
        math(String.raw`L=(l_1,\dots,l_M)`),
        " とする。また、",
        math(String.raw`q,k\in\{1,2\}`),
        " に対して ",
        math(String.raw`\delta_{qk}`),
        " を次のように定める。",
      ]),
      displayMath(String.raw`\delta_{qk}:=
\begin{cases}
  1 & (q=k),\\
  0 & (q\neq k).
\end{cases}`),
      paragraph([
        ref("kronecker_product_rule"),
        " (1) と ",
        ref("kronecker_multilinear"),
        " を使うと、",
      ]),
      displayMath(String.raw`\begin{aligned}
E_{P,Q}E_{K,L}
&= (E_{p_1q_1}E_{k_1l_1})\boxtimes\cdots\boxtimes(E_{p_Mq_M}E_{k_Ml_M})
&&\left(\because\ \text{クロネッカー積の積の規則}\right)\\
&= (\delta_{q_1k_1}E_{p_1l_1})\boxtimes\cdots\boxtimes(\delta_{q_Mk_M}E_{p_Ml_M})
&&\left(\because\ E_{pq}E_{kl}=\delta_{qk}E_{pl}\ \text{という }2\text{ 次行列の成分計算}\right)\\
&= \left(\prod_{r=1}^{M}\delta_{q_rk_r}\right)E_{P,L}
&&\left(\because\ \text{各因子についての複素スカラー倍の線型性}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`\delta_{Q,K}:=\prod_{r=1}^{M}\delta_{q_rk_r}`),
        " と書けば、",
        math(String.raw`E_{P,Q}E_{K,L}=\delta_{Q,K}E_{P,L}`),
        " である。特に ",
        math(String.raw`E:=E_{P,Q}`),
        " とおくと、",
        math(String.raw`P\neq Q`),
        " なら ",
        math(String.raw`E^2=O`),
        "、",
        math(String.raw`P=Q`),
        " なら ",
        math(String.raw`E^2=E`),
        " である。",
      ]),
      paragraph([
        math(String.raw`P\neq Q`),
        " の場合は ",
        math(String.raw`I+E`),
        " の逆行列が ",
        math(String.raw`I-E`),
        " である。実際、",
      ]),
      displayMath(String.raw`\begin{aligned}
(I+E)(I-E)
&= I-E+E-E^2&&\left(\because\ \text{行列積の分配律}\right)\\
&= I&&\left(\because\ E^2=O\right),\\
(I-E)(I+E)
&= I+E-E-E^2&&\left(\because\ \text{行列積の分配律}\right)\\
&= I&&\left(\because\ E^2=O\right).
\end{aligned}`),
      paragraph([
        math(String.raw`P=Q`),
        " の場合は ",
        math(String.raw`I-2E`),
        " が自分自身を逆行列にもつ。実際、",
      ]),
      displayMath(String.raw`\begin{aligned}
(I-2E)(I-2E)
&= I-2E-2E+4E^2&&\left(\because\ \text{行列積の分配律}\right)\\
&= I-4E+4E&&\left(\because\ E^2=E\right)\\
&= I&&\left(\because\ \text{同じ行列の差は零行列}\right).
\end{aligned}`),
      paragraph([
        "よって ",
        math(String.raw`P\neq Q`),
        " なら ",
        math(String.raw`U_{P,Q}:=I+E_{P,Q}`),
        "、",
        math(String.raw`P=Q`),
        " なら ",
        math(String.raw`U_{P,P}:=I-2E_{P,P}`),
        " とおけば、どちらも ",
        ref("def_invertible_elements_of_R"),
        " の定義により ",
        math(String.raw`R^\times`),
        " に属する。",
      ]),
      paragraph([
        math(String.raw`P\neq Q`),
        " なら、",
        math(String.raw`WU_{P,Q}=U_{P,Q}W`),
        " を分配して両辺から ",
        math(String.raw`W`),
        " を引くと",
      ]),
      displayMath(String.raw`\begin{aligned}
W+WE_{P,Q}
&= WU_{P,Q}&&\left(\because\ U_{P,Q}=I+E_{P,Q}\right)\\
&= U_{P,Q}W&&\left(\because\ W\in C(R^\times),\ U_{P,Q}\in R^\times\right)\\
&= W+E_{P,Q}W&&\left(\because\ U_{P,Q}=I+E_{P,Q}\right),
\end{aligned}`),
      paragraph([
        "したがって ",
        math(String.raw`WE_{P,Q}=E_{P,Q}W`),
        " である。",
        math(String.raw`P=Q`),
        " なら同様に ",
        math(String.raw`WU_{P,P}=U_{P,P}W`),
        " から",
      ]),
      displayMath(String.raw`\begin{aligned}
W-2WE_{P,P}
&= WU_{P,P}&&\left(\because\ U_{P,P}=I-2E_{P,P}\right)\\
&= U_{P,P}W&&\left(\because\ W\in C(R^\times),\ U_{P,P}\in R^\times\right)\\
&= W-2E_{P,P}W&&\left(\because\ U_{P,P}=I-2E_{P,P}\right),
\end{aligned}`),
      paragraph([
        "を得る。両辺から ",
        math(String.raw`W`),
        " を引き、非零複素数 ",
        math(String.raw`-2`),
        " を消去すると ",
        math(String.raw`WE_{P,P}=E_{P,P}W`),
        " である。ゆえにすべての ",
        math(String.raw`P,Q\in\mathcal I_M`),
        " について ",
        math(String.raw`WE_{P,Q}=E_{P,Q}W`),
        " が成り立つ。",
      ]),
      paragraph([
        ref("tensor_basis"),
        " (1) より、任意の ",
        math(String.raw`x\in R`),
        " は一意に ",
        math(String.raw`x=\sum_{P,Q\in\mathcal I_M}x_{P,Q}E_{P,Q}`),
        "（",
        math(String.raw`x_{P,Q}\in\mathbb C`),
        "）と書ける。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
Wx
&= \sum_{P,Q}x_{P,Q}\,WE_{P,Q}
&&\left(\because\ x\ \text{の基底展開と行列積の分配律}\right)\\
&= \sum_{P,Q}x_{P,Q}\,E_{P,Q}W
&&\left(\because\ WE_{P,Q}=E_{P,Q}W\right)\\
&= xW
&&\left(\because\ x\ \text{の基底展開と行列積の分配律}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`x\in R`),
        " は任意だったので、",
        ref("centralizer_is_scalar"),
        " より、ある ",
        math(String.raw`c\in\mathbb C`),
        " が存在して ",
        math(String.raw`W=cI`),
        " である。もし ",
        math(String.raw`c=0`),
        " なら、どの行列 ",
        math(String.raw`B`),
        " に対しても ",
        math(String.raw`WB=OB=O\neq I`),
        " となり ",
        math(String.raw`W`),
        " は可逆でない。ところが ",
        math(String.raw`W\in R^\times`),
        " なので ",
        math(String.raw`c\neq0`),
        " である。以上より ",
        math(String.raw`W\in\{cI\mid c\in\mathbb C\setminus\{0\}\}`),
        " を得た。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "もとの injectivity_of_T_up_to_scalar ブロックに (i) として同居していた主張を、1 ブロック 1 主張になるよう独立させた。既存参照を保つためラベル center_of_multiplicative_group_is_scalar はこのブロックへ移した。",
        "もとの証明が使っていた x+tI の可逆化は、本文に定義のない特性多項式・固有値と根の同値・行列式による可逆性判定に依存していた。本文全体を検索して既存の具体的補題が無いことを確認し、その経路を採用せず、クロネッカー積で作る行列単位 E_{P,Q} と明示的に逆行列を書ける I+E_{P,Q} または I-2E_{P,P} だけを使う有限行列計算へ置き換えた。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_011a_claim_injectivity_of_T",
    kind: "claim",
    origin: { path: "structured-latex/content/008_TV1_hatZ_hatY_part1.ts", ordinal: 11 },
    title: { tex: String.raw`T \text{ の（定数倍を除いた）単射性}` },
    labels: ["injectivity_of_T_up_to_scalar"],
    statement: [
      paragraph([
        math(String.raw`R := \mathrm{Mat}(2^M,\mathbb{C})`),
        "、",
        math(String.raw`I := I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        " とし、",
        math(String.raw`R^\times`),
        " を ",
        ref("def_invertible_elements_of_R"),
        " の可逆行列全体とする。これは ",
        ref("def_T_g"),
        " で共役写像を定める行列 ",
        math(String.raw`g`),
        " の許容範囲であり、各 ",
        math(String.raw`T_g`),
        " 自身の定義域は ",
        math(String.raw`R`),
        " である。このとき、",
      ]),
      paragraph([
        math(String.raw`g,g'\in R^\times`),
        " について",
      ]),
      displayMath(
        String.raw`T_g=T_{g'}\iff \exists c\in\mathbb C\setminus\{0\},\quad g'=c\,g`,
      ),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "Step 1: ",
        math(String.raw`u:=g^{-1}g'`),
        " とおくと、",
        math(String.raw`u\in R^\times`),
        " かつ ",
        math(String.raw`gu=g'`),
        " である。",
      ]),
      paragraph([
        ref("def_invertible_elements_of_R"),
        " (iii) より ",
        math(String.raw`g^{-1}\in R^\times`),
        " であり、同 (ii) より ",
        math(String.raw`u=g^{-1}g'\in R^\times`),
        " である。また、",
      ]),
      displayMath(String.raw`\begin{aligned}
gu
&=g\left(g^{-1}g'\right)
&&\left(\because\ u=g^{-1}g'\right)\\
&=\left(gg^{-1}\right)g'
&&\left(\because\ \text{行列積の結合律}\right)\\
&=Ig'
&&\left(\because\ gg^{-1}=I\right)\\
&=g'
&&\left(\because\ I\ \text{は積の単位元}\right).
\end{aligned}`),
      paragraph([
        "Step 2: 任意の ",
        math(String.raw`h\in R`),
        " について、",
        math(String.raw`T_g(h)=T_{g'}(h)`),
        " と ",
        math(String.raw`hu=uh`),
        " は同値である。",
      ]),
      paragraph([
        math(String.raw`h\in R`),
        " を固定する。",
        ref("def_T_g"),
        " と、可逆行列を左または右から掛ける操作が逆行列によって戻せることから、",
      ]),
      displayMath(String.raw`\begin{aligned}
T_g(h)=T_{g'}(h)
&\iff ghg^{-1}=g'hg'^{-1}
&&\left(\because\ T_g,T_{g'}\ \text{の定め方}\right)\\
&\iff g^{-1}\left(ghg^{-1}\right)=g^{-1}\left(g'hg'^{-1}\right)
&&\left(\because\ \text{両辺に左から可逆行列 }g^{-1}\text{ を掛ける同値変形}\right)\\
&\iff \left(g^{-1}g\right)hg^{-1}=\left(g^{-1}g'\right)hg'^{-1}
&&\left(\because\ \text{行列積の結合律}\right)\\
&\iff Ihg^{-1}=\left(g^{-1}g'\right)hg'^{-1}
&&\left(\because\ g^{-1}g=I\right)\\
&\iff hg^{-1}=\left(g^{-1}g'\right)hg'^{-1}
&&\left(\because\ I\ \text{は積の単位元}\right)\\
&\iff \left(hg^{-1}\right)g'=\left(\left(g^{-1}g'\right)hg'^{-1}\right)g'
&&\left(\because\ \text{両辺に右から可逆行列 }g'\text{ を掛ける同値変形}\right)\\
&\iff h\left(g^{-1}g'\right)=\left(g^{-1}g'\right)h\left(g'^{-1}g'\right)
&&\left(\because\ \text{行列積の結合律}\right)\\
&\iff h\left(g^{-1}g'\right)=\left(g^{-1}g'\right)hI
&&\left(\because\ g'^{-1}g'=I\right)\\
&\iff h\left(g^{-1}g'\right)=\left(g^{-1}g'\right)h
&&\left(\because\ I\ \text{は積の単位元}\right)\\
&\iff hu=uh
&&\left(\because\ u=g^{-1}g'\right).
\end{aligned}`),
      paragraph([
        "Step 3: ",
        math(String.raw`T_g=T_{g'}`),
        " ならば、ある ",
        math(String.raw`c\in\mathbb C\setminus\{0\}`),
        " が存在して ",
        math(String.raw`g'=cg`),
        " である。",
      ]),
      paragraph([
        math(String.raw`T_g=T_{g'}`),
        " とする。すべての ",
        math(String.raw`h\in R^\times`),
        " について ",
        math(String.raw`T_g(h)=T_{g'}(h)`),
        " なので、Step 2 より ",
        math(String.raw`uh=hu`),
        " である。Step 1 の ",
        math(String.raw`u\in R^\times`),
        " と合わせると、",
        ref("invertible_matrix_centralizer_is_nonzero_scalar_identity"),
        " より、ある ",
        math(String.raw`c\in\mathbb C\setminus\{0\}`),
        " が存在して ",
        math(String.raw`u=cI`),
        " である。したがって、",
      ]),
      displayMath(String.raw`\begin{aligned}
g'
&=gu
&&\left(\because\ \text{Step 1}\right)\\
&=g(cI)
&&\left(\because\ u=cI\right)\\
&=c(gI)
&&\left(\because\ \text{複素スカラー倍と行列積の結合律}\right)\\
&=cg
&&\left(\because\ gI=g\right).
\end{aligned}`),
      paragraph([
        "Step 4: ある ",
        math(String.raw`c\in\mathbb C\setminus\{0\}`),
        " について ",
        math(String.raw`g'=cg`),
        " ならば、",
        math(String.raw`T_g=T_{g'}`),
        " である。",
      ]),
      paragraph([
        math(String.raw`g'=cg`),
        " とする。すると",
      ]),
      displayMath(String.raw`\begin{aligned}
u
&=g^{-1}g'
&&\left(\because\ u=g^{-1}g'\right)\\
&=g^{-1}(cg)
&&\left(\because\ g'=cg\right)\\
&=c\left(g^{-1}g\right)
&&\left(\because\ \text{複素スカラー倍と行列積の結合律}\right)\\
&=cI
&&\left(\because\ g^{-1}g=I\right).
\end{aligned}`),
      paragraph([
        "任意の ",
        math(String.raw`h\in R`),
        " に対し、",
        ref("scalar_identity_commutes"),
        " より ",
        math(String.raw`uh=(cI)h=h(cI)=hu`),
        " である。Step 2 の逆向きにより ",
        math(String.raw`T_g(h)=T_{g'}(h)`),
        " であり、",
        math(String.raw`h\in R`),
        " は任意なので ",
        math(String.raw`T_g=T_{g'}`),
        " を得る。Step 3 と Step 4 を合わせて主張が成り立つ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、(C^2)^{⊗M} を数ベクトル空間 C^{2^M} へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文の検討メモ（parts/008/009）にあった『T の（定数倍を除いた）単射性が大事そうなので示す』を、メモの『試す2』の方針（Clifford 代数と行列環の同型に触れずに示す）で実際に証明したもの。",
        "当初は自己同型群・核・中心・完全列という一般論を経由していたが、README のゴール設定（環・体などの一般論に持ち上げない／脇道の一般論は具体的な形に落とす）に従い、一般論の語彙を使わない有限複素行列の計算へ書き直した。要点は Step 2 の同値 g h g^{-1} = g' h g'^{-1} ⟺ (g^{-1}g') h = h (g^{-1}g') である。退避した記述は notes/008_group_theory_general.ts にある。",
        "center_of_multiplicative_group_is_scalar を独立した直前の主張へ分け、このブロックは共役写像の非零スカラー倍を除く単射性だけを述べる。もとの x+tI による制限写像から全行列への延長は、未定義の特性多項式と行列式を使うため削除した。順方向は全行列上の写像の一致を可逆行列へ制限し、逆方向は u=cI が全行列と可換することを直接使うので、この延長自体が不要である。",
        "R^× は T_g の定義域ではなく、T_g を定める g の許容範囲である。各 T_g の定義域は R であることを statement に明記した。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_012_claim_TV1_TV2_actions",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/011_claim_ホロノミック量子場_p142下段.typ",
      ordinal: 12,
    },
    title: { text: "ホロノミック量子場 p142 下段" },
    labels: ["ホロノミック量子場_p142下段_1"],
    statement: [
      displayMath(
        String.raw`\begin{aligned}
T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)})
&= \cosh(K_1)\hat{Z}_\mu^{(-)} + i e^{-i 2\pi\mu/M}\sinh(K_1)\hat{Y}_\mu \\
T_{(V_1^{(\pm)})^{1/2}}(\hat{Y}_\mu)
&= -i e^{i 2\pi\mu/M}\sinh(K_1)\hat{Z}_\mu^{(-)} + \cosh(K_1)\hat{Y}_\mu \\
T_{V_2}(\hat{Z}_\mu^{(-)})
&= \cosh(2K_2^*)\hat{Z}_\mu^{(-)} - i\sinh(2K_2^*)\hat{Y}_\mu \\
T_{V_2}(\hat{Y}_\mu)
&= i\sinh(2K_2^*)\hat{Z}_\mu^{(-)} + \cosh(2K_2^*)\hat{Y}_\mu
\end{aligned}`,
      ),
    ],
    proof: [
      paragraph([
        "以下、",
        ref("extract_taylor_coefficient_of_Z_Y"),
        " の (h1.z), (h1.y) は ",
        math(String.raw`\pm`),
        " の 2 つの符号選択について成り立つが、本主張では ",
        math(String.raw`\hat{Z}_\mu^{(-)}`),
        " に作用させるので、いずれも ",
        math(String.raw`\pm = -`),
        "（すなわち ",
        math(String.raw`H_1^{(-)}`),
        " と ",
        math(String.raw`\hat{Z}_\mu^{(-)}`),
        " の組）を選んで適用する。",
      ]),
      paragraph([
        math(String.raw`T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)})`),
        " について、次の変形で ",
        ref("exp_X_Y_exp_-X"),
        " と ",
        ref("extract_taylor_coefficient_of_Z_Y"),
        " を用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)})
&= (V_1^{(\pm)})^{1/2}\cdot\hat{Z}_\mu^{(-)}\cdot(V_1^{(\pm)})^{-1/2}
   \quad (\because \text{共役写像 }T\text{ の定義}) \\
&= \left(\exp(i K_1 H_1^{(\pm)})\right)^{1/2}\cdot\hat{Z}_\mu^{(-)}\cdot\left(\exp(i K_1 H_1^{(\pm)})\right)^{-1/2}
   \quad (\because V_1^{(\pm)}\text{ の指数表示}) \\
&= \exp\!\left(\tfrac{1}{2}i K_1 H_1^{(\pm)}\right)\cdot\hat{Z}_\mu^{(-)}\cdot\exp\!\left(-\left(\tfrac{1}{2}i K_1 H_1^{(\pm)}\right)\right)
   \quad (\because \text{指数行列の平方根と逆元}) \\
&= \sum_{n=0}^{\infty}\frac{1}{n!}
   \underbrace{\left[\tfrac{1}{2}i K_1 H_1^{(\pm)},\dots,\left[\tfrac{1}{2}i K_1 H_1^{(\pm)},\hat{Z}_\mu^{(-)}\right]\dots\right]}_{n\text{ times}}
   \quad (\because \text{exp 共役の級数展開}) \\
&= \cosh(K_1)\hat{Z}_\mu^{(-)} + i\,e^{-i\frac{2\pi\mu}{M}}\sinh(K_1)\hat{Y}_\mu
   \quad (\because \text{テイラー係数の抽出}) \\
&= \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}\cosh(K_1) \\ i\,e^{-i\frac{2\pi\mu}{M}}\sinh(K_1)\end{pmatrix}
   \quad (\because \text{行ベクトルと列ベクトルの積の定義})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`T_{(V_1^{(\pm)})^{1/2}}(\hat{Y}_\mu)`),
        " について、作用させる元が ",
        math(String.raw`\hat{Z}_\mu^{(-)}`),
        " から ",
        math(String.raw`\hat{Y}_\mu`),
        " へ変わるだけで、共役の展開はまったく同じ手順である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V_1^{(\pm)})^{1/2}}(\hat{Y}_\mu)
&= (V_1^{(\pm)})^{1/2}\cdot\hat{Y}_\mu\cdot(V_1^{(\pm)})^{-1/2}
   \quad (\because \text{共役写像 }T\text{ の定義}) \\
&= \left(\exp(i K_1 H_1^{(\pm)})\right)^{1/2}\cdot\hat{Y}_\mu\cdot\left(\exp(i K_1 H_1^{(\pm)})\right)^{-1/2}
   \quad (\because V_1^{(\pm)}\text{ の指数表示}) \\
&= \exp\!\left(\tfrac{1}{2}i K_1 H_1^{(\pm)}\right)\cdot\hat{Y}_\mu\cdot\exp\!\left(-\left(\tfrac{1}{2}i K_1 H_1^{(\pm)}\right)\right)
   \quad (\because \text{指数行列の平方根と逆元}) \\
&= \sum_{n=0}^{\infty}\frac{1}{n!}
   \underbrace{\left[\tfrac{1}{2}i K_1 H_1^{(\pm)},\dots,\left[\tfrac{1}{2}i K_1 H_1^{(\pm)},\hat{Y}_\mu\right]\dots\right]}_{n\text{ times}}
   \quad (\because \text{exp 共役の級数展開}) \\
&= -i\,e^{i\frac{2\pi\mu}{M}}\sinh(K_1)\hat{Z}_\mu^{(-)} + \cosh(K_1)\hat{Y}_\mu
   \quad (\because \text{テイラー係数の抽出 (h1.y)}) \\
&= \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}-i\,e^{i\frac{2\pi\mu}{M}}\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}
   \quad (\because \text{行ベクトルと列ベクトルの積の定義})
\end{aligned}`,
      ),
      paragraph([
        "最後の等号は、行ベクトルと列ベクトルの積の定義",
        math(String.raw`\begin{pmatrix}A, & B\end{pmatrix}\begin{pmatrix}a \\ b\end{pmatrix} = aA + bB`),
        " による（",
        math(String.raw`A, B \in \mathrm{Mat}(2^M,\mathbb{C})`),
        "、",
        math(String.raw`a, b \in \mathbb{C}`),
        "）。",
      ]),
      paragraph([
        math(String.raw`T_{V_2}(\hat{Z}_\mu^{(-)})`),
        " について。準備として 2 つ置く。第一に、スカラー ",
        math(String.raw`(2s_2)^{M/2} \in \mathbb{C}^{\times}`),
        " は ",
        ref("scalar_identity_commutes"),
        " により ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の任意の元と可換である。第二に、",
        math(String.raw`(2s_2)^{M/2}\left((2s_2)^{M/2}\right)^{-1} = 1`),
        " である（",
        math(String.raw`\mathbb{C}^{\times}`),
        " の逆元の定義）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{V_2}(\hat{Z}_\mu^{(-)})
&= V_2\cdot\hat{Z}_\mu^{(-)}\cdot V_2^{-1}
   \quad (\because \text{共役写像 }T\text{ の定義}) \\
&= \left((2s_2)^{M/2}\exp(i K_2^* H_2)\right)\cdot\hat{Z}_\mu^{(-)}\cdot\left((2s_2)^{M/2}\exp(i K_2^* H_2)\right)^{-1}
   \quad (\because V_2\text{ の指数表示}) \\
&= (2s_2)^{M/2}\cdot\exp(i K_2^* H_2)\cdot\hat{Z}_\mu^{(-)}\cdot\left((2s_2)^{M/2}\right)^{-1}\cdot\exp(i K_2^* H_2)^{-1}
   \quad (\because \text{スカラー倍の行列の逆元 }(cA)^{-1}=c^{-1}A^{-1}) \\
&= (2s_2)^{M/2}\cdot\left((2s_2)^{M/2}\right)^{-1}\cdot\exp(i K_2^* H_2)\cdot\hat{Z}_\mu^{(-)}\cdot\exp(i K_2^* H_2)^{-1}
   \quad (\because \text{スカラーは任意の元と可換（準備の第一）}) \\
&= \exp(i K_2^* H_2)\cdot\hat{Z}_\mu^{(-)}\cdot\exp(i K_2^* H_2)^{-1}
   \quad (\because \text{スカラーとその逆元の積は }1\text{（準備の第二）}) \\
&= \sum_{n=0}^{\infty}\frac{1}{n!}
   \underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\hat{Z}_\mu^{(-)}\right]\dots\right]}_{n\text{ times}}
   \quad (\because \text{exp 共役の級数展開}) \\
&= \cosh(2K_2^*)\hat{Z}_\mu^{(-)} - i\sinh(2K_2^*)\hat{Y}_\mu
   \quad (\because \text{テイラー係数の抽出}) \\
&= \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}\cosh(2K_2^*) \\ -i\sinh(2K_2^*)\end{pmatrix}
   \quad (\because \text{行ベクトルと列ベクトルの積の定義})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`T_{V_2}(\hat{Y}_\mu)`),
        " についても、スカラー ",
        math(String.raw`(2s_2)^{M/2}`),
        " が共役で打ち消し合うことは同じで、作用させる元だけが ",
        math(String.raw`\hat{Y}_\mu`),
        " に変わる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{V_2}(\hat{Y}_\mu)
&= V_2\cdot\hat{Y}_\mu\cdot V_2^{-1}
   \quad (\because \text{共役写像 }T\text{ の定義}) \\
&= \left((2s_2)^{M/2}\exp(i K_2^* H_2)\right)\cdot\hat{Y}_\mu\cdot\left((2s_2)^{M/2}\exp(i K_2^* H_2)\right)^{-1}
   \quad (\because V_2\text{ の指数表示}) \\
&= (2s_2)^{M/2}\cdot\exp(i K_2^* H_2)\cdot\hat{Y}_\mu\cdot\left((2s_2)^{M/2}\right)^{-1}\cdot\exp(i K_2^* H_2)^{-1}
   \quad (\because \text{スカラー倍の行列の逆元 }(cA)^{-1}=c^{-1}A^{-1}) \\
&= (2s_2)^{M/2}\cdot\left((2s_2)^{M/2}\right)^{-1}\cdot\exp(i K_2^* H_2)\cdot\hat{Y}_\mu\cdot\exp(i K_2^* H_2)^{-1}
   \quad (\because \text{スカラーは任意の元と可換（準備の第一）}) \\
&= \exp(i K_2^* H_2)\cdot\hat{Y}_\mu\cdot\exp(i K_2^* H_2)^{-1}
   \quad (\because \text{スカラーとその逆元の積は }1\text{（準備の第二）}) \\
&= \sum_{n=0}^{\infty}\frac{1}{n!}
   \underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\hat{Y}_\mu\right]\dots\right]}_{n\text{ times}}
   \quad (\because \text{exp 共役の級数展開}) \\
&= i\sinh(2K_2^*)\hat{Z}_\mu^{(-)} + \cosh(2K_2^*)\hat{Y}_\mu
   \quad (\because \text{テイラー係数の抽出 (h2.y)}) \\
&= \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}i\sinh(2K_2^*) \\ \cosh(2K_2^*)\end{pmatrix}
   \quad (\because \text{行ベクトルと列ベクトルの積の定義})
\end{aligned}`,
      ),
      paragraph([
        "以上 4 式が statement と一致する。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文 proof を忠実に翻訳。原文の V1 分・V2 分の共役展開（exp の (1/2) スケール、(2s2)^{M/2} の相殺）と、原文 statement にある行列表示（行ベクトル×列ベクトル）を proof 内に取り込んだ。",
        "T_{(V1)^{1/2}}(hat(Y)) と T_{V2}(hat(Y)) は原文 proof が「同様」とのみ記していたため、本作業で共役の級数展開から最終形・行列表示までを両方とも書き下した。",
        "原文 statement の hat(Y) 行列表示は第 1 成分が i e^{-i2πμ/M} sinh(K1) で、同じ原文の scalar 表示 -i e^{i2πμ/M} sinh(K1) hat(Z) + cosh(K1) hat(Y) と符号・exp の両方が食い違っていた。どちらが誤りかは数値検証で確定させた。sagemath/check/041_claim_TV1_TV2_actions/check_02_hatY_column_vector.sage により、scalar 表示と整合する列ベクトル (-i e^{i2πμ/M} sinh K1, cosh K1)^T は M=3,4,5・全 mu ∈ calM・複数の (K1,K2) で残差 1e-8 以下、原文の列ベクトル (i e^{-i2πμ/M} sinh K1, cosh K1)^T は残差が 1e-3 を大きく超えることを確認した。よって誤りは行列表示側であり、これを scalar 表示に合わせて修正した。下流の calc_of_TxT_hatZxhatY（013/014）が既に修正後の形を使っているので、これで文書内が整合する。",
        "V_2 の共役で原文は V_2^{-1} を ((2s2)^{M/2} exp(-i K2^* H2))^{-1} と書いていたが、V_2 = (2s2)^{M/2} exp(i K2^* H2) の逆元なので exp の符号は正（+i）が正しい。誤植として修正した。",
        "4 つの作用そのものは check_01_T_actions.sage で、行列指数関数 exp((1/2) i K1 H1^{(-)}), exp(i K2^* H2) を明示的に構成した直接計算により確認済み（前因子 (2 s_2)^{M/2} を明示的に付けた形で相殺も確認）。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_013_definition_product_maps",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/012_definition_T_V1_T_V2の直積写像.typ",
      ordinal: 13,
    },
    title: null,
    labels: [],
    statement: [
      displayMath(
        String.raw`\left(T_{(V_1^{(\pm)})^{1/2}} \times T_{(V_1^{(\pm)})^{1/2}}\right)(X, Y) := \left(T_{(V_1^{(\pm)})^{1/2}}(X),\; T_{(V_1^{(\pm)})^{1/2}}(Y)\right)`,
      ),
      displayMath(
        String.raw`\left(T_{V_2} \times T_{V_2}\right)(X, Y) := \left(T_{V_2}(X),\; T_{V_2}(Y)\right)`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_014_claim_product_action_computation",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/013_claim_T_V1_T_V2のhatZ_hatYへの直積作用の計算.typ",
      ordinal: 14,
    },
    title: null,
    labels: ["calc_of_TxT_hatZxhatY"],
    statement: [
      displayMath(
        String.raw`\left(T_{(V_1^{(\pm)})^{1/2}} \times T_{(V_1^{(\pm)})^{1/2}}\right)(\hat{Z}_\mu^{(-)}, \hat{Y}_\mu)
= \begin{pmatrix}\hat{Z}_\mu^{(-)}, \hat{Y}_\mu\end{pmatrix}
\begin{pmatrix}
\cosh K_1 & -i e^{i\theta_\mu}\sinh K_1 \\
i e^{-i\theta_\mu}\sinh K_1 & \cosh K_1
\end{pmatrix}`,
      ),
      displayMath(
        String.raw`\left(T_{V_2} \times T_{V_2}\right)(\hat{Z}_\mu^{(-)}, \hat{Y}_\mu)
= \begin{pmatrix}\hat{Z}_\mu^{(-)}, \hat{Y}_\mu\end{pmatrix}
\begin{pmatrix}
\cosh 2K_2^* & i\sinh 2K_2^* \\
-i\sinh 2K_2^* & \cosh 2K_2^*
\end{pmatrix}`,
      ),
      paragraph(["ただし ", math(String.raw`\theta_\mu := 2\pi\mu/M`), "。"]),
    ],
    proof: [
      paragraph([
        "直積写像の定義より各成分に分解し、",
        ref("ホロノミック量子場_p142下段_1"),
        " の行列表示を代入して 2 列を並べる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(T_{(V_1^{(\pm)})^{1/2}} \times T_{(V_1^{(\pm)})^{1/2}}\right)(\hat{Z}_\mu^{(-)}, \hat{Y}_\mu)
&= \left(T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)}),\ T_{(V_1^{(\pm)})^{1/2}}(\hat{Y}_\mu)\right)
   \quad (\because \text{直積写像の定義}) \\
&= \left(
   \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}\cosh(K_1) \\ i\,e^{-i\frac{2\pi\mu}{M}}\sinh(K_1)\end{pmatrix},\ \
   \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}-i\,e^{i\frac{2\pi\mu}{M}}\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}
   \right)
   \quad (\because \text{二つの共役作用の行列表示}) \\
&= \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}
   \cosh(K_1) & -i\,e^{i\frac{2\pi\mu}{M}}\sinh(K_1) \\
   i\,e^{-i\frac{2\pi\mu}{M}}\sinh(K_1) & \cosh(K_1)
   \end{pmatrix}
   \quad (\because \text{二つの列ベクトルを一つの行列の二列として並べる})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\left(T_{V_2} \times T_{V_2}\right)(\hat{Z}_\mu^{(-)}, \hat{Y}_\mu)
&= \left(T_{V_2}(\hat{Z}_\mu^{(-)}),\ T_{V_2}(\hat{Y}_\mu)\right)
   \quad (\because \text{直積写像の定義}) \\
&= \left(
   \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}\cosh(2K_2^*) \\ -i\sinh(2K_2^*)\end{pmatrix},\ \
   \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}i\sinh(2K_2^*) \\ \cosh(2K_2^*)\end{pmatrix}
   \right)
   \quad (\because \text{二つの共役作用の行列表示}) \\
&= \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}
   \cosh(2K_2^*) & i\sinh(2K_2^*) \\
   -i\sinh(2K_2^*) & \cosh(2K_2^*)
   \end{pmatrix}
   \quad (\because \text{二つの列ベクトルを一つの行列の二列として並べる})
\end{aligned}`,
      ),
      paragraph([
        "ただし ",
        math(String.raw`\theta_\mu := 2\pi\mu/M`),
        " と書けば上記の ",
        math(String.raw`e^{\pm i\frac{2\pi\mu}{M}} = e^{\pm i\theta_\mu}`),
        " であり statement の形になる。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文には proof ブロックが無く、claim 本文が「各作用を行列表示に展開して 2 列を並べる」導出そのものになっている。その 2 段の行列計算を proof として忠実に翻訳した。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_015_claim_linearity_of_T",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/014_claim_T_Vの線型性.typ",
      ordinal: 15,
    },
    title: null,
    labels: ["linearity_of_T"],
    statement: [
      paragraph([
        math(String.raw`\forall a, b \in \mathbb{C}`),
        " について、",
      ]),
      displayMath(
        String.raw`T_{(V_1^{(\pm)})^{1/2}}(a\hat{Z}_\mu^{(-)} + b\hat{Y}_\mu)
= a\,T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)}) + b\,T_{(V_1^{(\pm)})^{1/2}}(\hat{Y}_\mu)`,
      ),
      displayMath(
        String.raw`T_{V_2}(a\hat{Z}_\mu^{(-)} + b\hat{Y}_\mu)
= a\,T_{V_2}(\hat{Z}_\mu^{(-)}) + b\,T_{V_2}(\hat{Y}_\mu)`,
      ),
    ],
    proof: [paragraph(["表式より、それぞれただの1次関数なので自明。"])],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_016_definition_T_V",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/015_definition_T_V.typ",
      ordinal: 16,
    },
    title: { tex: String.raw`T_{(V)} \text{ の定義}` },
    labels: ["def_T_V"],
    statement: [
      paragraph([
        math(String.raw`\forall X \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " について、",
      ]),
      displayMath(
        String.raw`T_{(V)}(X) := T_{(V_1^{(\pm)})^{1/2}}\!\left(T_{V_2}\!\left(T_{(V_1^{(\pm)})^{1/2}}(X)\right)\right)`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_016a_claim_duality_c2_star",
    kind: "claim",
    origin: { path: "structured-latex/content/008_TV1_hatZ_hatY_part1.ts", ordinal: 17 },
    title: { tex: String.raw`K_2 \text{ と } K_2^* \text{ の双対関係}` },
    labels: ["duality_c2_star_eq_s2_star_c2"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号（",
        math(String.raw`K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`K_2^* := -\tfrac{1}{2}\log(\tanh K_2)`),
        "、",
        math(String.raw`c_2 := \cosh 2K_2`),
        "、",
        math(String.raw`s_2 := \sinh 2K_2`),
        "、",
        math(String.raw`c_2^* := \cosh 2K_2^*`),
        "、",
        math(String.raw`s_2^* := \sinh 2K_2^*`),
        "）について、",
      ]),
      displayMath(
        String.raw`s_2^* = \frac{1}{s_2}, \qquad c_2^* = \frac{c_2}{s_2}, \qquad
\text{したがって} \quad c_2^* = s_2^*\, c_2`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`K_2 > 0`),
        " より ",
        math(String.raw`0 < \tanh K_2 < 1`),
        " であり ",
        math(String.raw`\log(\tanh K_2)`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の中で定義される。",
        math(String.raw`K_2^* = -\tfrac{1}{2}\log(\tanh K_2)`),
        " の両辺に ",
        math(String.raw`-2`),
        " を掛けて指数をとると ",
        math(String.raw`e^{-2K_2^*} = \tanh K_2`),
        "、その逆数をとって ",
        math(String.raw`e^{2K_2^*} = (\tanh K_2)^{-1}`),
        "（",
        math(String.raw`\tanh K_2 \neq 0`),
        " による）。",
        "また ",
        math(String.raw`\sinh K_2 > 0,\ \cosh K_2 > 0`),
        " であるから、以下の分母はいずれも ",
        math(String.raw`0`),
        " ではない。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
s_2^* = \sinh 2K_2^*
&= \frac{e^{2K_2^*} - e^{-2K_2^*}}{2}
   \quad (\because \sinh x = \tfrac{1}{2}(e^{x}-e^{-x})) \\
&= \frac{(\tanh K_2)^{-1} - \tanh K_2}{2}
   \quad (\because \text{準備の } e^{2K_2^*} = (\tanh K_2)^{-1},\ e^{-2K_2^*} = \tanh K_2) \\
&= \frac{1}{2}\left(\frac{\cosh K_2}{\sinh K_2} - \frac{\sinh K_2}{\cosh K_2}\right)
   \quad (\because \tanh x = \tfrac{\sinh x}{\cosh x}\ \text{とその逆数}) \\
&= \frac{\cosh^2 K_2 - \sinh^2 K_2}{2\sinh K_2\cosh K_2}
   \quad (\because \text{通分。分母 } \sinh K_2\cosh K_2 \neq 0\ \text{は準備で確認済み}) \\
&= \frac{1}{\sinh 2K_2}
   \quad (\because \cosh^2 x - \sinh^2 x = 1,\ 2\sinh x\cosh x = \sinh 2x) \\
&= \frac{1}{s_2}
   \quad (\because s_2 = \sinh 2K_2\ \text{の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
c_2^* = \cosh 2K_2^*
&= \frac{e^{2K_2^*} + e^{-2K_2^*}}{2}
   \quad (\because \cosh x = \tfrac{1}{2}(e^{x}+e^{-x})) \\
&= \frac{(\tanh K_2)^{-1} + \tanh K_2}{2}
   \quad (\because \text{準備の } e^{2K_2^*} = (\tanh K_2)^{-1},\ e^{-2K_2^*} = \tanh K_2) \\
&= \frac{1}{2}\left(\frac{\cosh K_2}{\sinh K_2} + \frac{\sinh K_2}{\cosh K_2}\right)
   \quad (\because \tanh x = \tfrac{\sinh x}{\cosh x}\ \text{とその逆数}) \\
&= \frac{\cosh^2 K_2 + \sinh^2 K_2}{2\sinh K_2\cosh K_2}
   \quad (\because \text{通分。分母 } \sinh K_2\cosh K_2 \neq 0\ \text{は準備で確認済み}) \\
&= \frac{\cosh 2K_2}{\sinh 2K_2}
   \quad (\because \cosh^2 x + \sinh^2 x = \cosh 2x,\ 2\sinh x\cosh x = \sinh 2x) \\
&= \frac{c_2}{s_2}
   \quad (\because c_2 = \cosh 2K_2\ \text{の定義})
\end{aligned}`,
      ),
      paragraph(["この 2 式より"]),
      displayMath(String.raw`\begin{aligned}
c_2^*
&= \frac{c_2}{s_2}&&(\because\ \text{上の鎖})\\
&= c_2\cdot\frac{1}{s_2}&&(\because\ \mathbb{R}\ \text{の除法は逆数との積}\ (s_2\ne0\ \text{は準備で確認済み}))\\
&= c_2\, s_2^*&&(\because\ \text{もう一方の鎖の}\ s_2^* = \tfrac{1}{s_2})\\
&= s_2^*\, c_2&&(\because\ \mathbb{R}\ \text{の乗法の可換性})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文には独立したブロックが無いが、同じ計算（e^{-2K_2^*}=tanh K_2 から s_2^*=1/s_2, c_2^*=c_2/s_2 を出す）が part2 の equation_of_a_theta_mu の証明の Step 16 内に埋め込まれていた。B_1 B_2 B_1 = A(θ) の計算（T_V_hatZ_hatY）で c_2^* = s_2^* c_2 をラベル参照する必要があるため、独立した claim として切り出した。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_017_definition_A_theta",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/016_definition_A_theta.typ",
      ordinal: 17,
    },
    title: { tex: String.raw`A(\theta) \text{ の定義}` },
    labels: ["def_A_theta"],
    statement: [
      paragraph([math(String.raw`\theta \in \mathbb{C}`), " について、"]),
      displayMath(
        String.raw`A(\theta) :=
\begin{pmatrix}
c_1 c_2^* - s_1 s_2^*\cos\theta &
i e^{i\theta} s_2^*(c_1\cos\theta - i\sin\theta - s_1 c_2) \\
-i e^{-i\theta} s_2^*(c_1\cos\theta + i\sin\theta - s_1 c_2) &
c_1 c_2^* - s_1 s_2^*\cos\theta
\end{pmatrix}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_018_claim_T_V_action",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/017_claim_T_VのhatZ_hatYへの作用.typ",
      ordinal: 18,
    },
    title: { tex: String.raw`T_{(V)} \text{ の } \hat{Z}, \hat{Y} \text{ への作用}` },
    labels: ["T_V_hatZ_hatY"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \mathcal{M}`),
        " について、",
      ]),
      displayMath(
        String.raw`\left(T_{(V)}(\hat{Z}_\mu^{(-)}),\; T_{(V)}(\hat{Y}_\mu)\right)
= \left(\hat{Z}_\mu^{(-)},\; \hat{Y}_\mu\right) A\!\left(\frac{2\pi\mu}{M}\right)`,
      ),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`\theta_\mu := 2\pi\mu/M`),
        " とし、次の 2 行列を用いる（それぞれ ",
        ref("calc_of_TxT_hatZxhatY"),
        " の ",
        math(String.raw`V_1, V_2`),
        " 分に対応）：",
      ]),
      displayMath(
        String.raw`B_1(\theta_\mu) := \begin{pmatrix}
\cosh(K_1) & -i e^{i\theta_\mu}\sinh(K_1) \\
i e^{-i\theta_\mu}\sinh(K_1) & \cosh(K_1)
\end{pmatrix}, \qquad
B_2 := \begin{pmatrix}
\cosh(2K_2^*) & i\sinh(2K_2^*) \\
-i\sinh(2K_2^*) & \cosh(2K_2^*)
\end{pmatrix}`,
      ),
      paragraph([
        "(z) ",
        math(String.raw`T_{(V)}(\hat{Z}_\mu^{(-)})`),
        " について、",
        math(String.raw`T`),
        " の線型性（",
        ref("linearity_of_T"),
        "）、",
        ref("calc_of_TxT_hatZxhatY"),
        "、",
        ref("ホロノミック量子場_p142下段_1"),
        " を用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V)}(\hat{Z}_\mu^{(-)})
&= T_{(V_1^{(\pm)})^{1/2}}\!\left(T_{V_2}\!\left(T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)})\right)\right)
   \quad (\because V=(V_1^{(\pm)})^{1/2}V_2(V_1^{(\pm)})^{1/2}\ \text{と共役作用の合成則}) \\
&= T_{(V_1^{(\pm)})^{1/2}}\!\left(T_{V_2}\!\left(\cosh(K_1)\hat{Z}_\mu^{(-)} + i e^{-i\theta_\mu}\sinh(K_1)\hat{Y}_\mu\right)\right)
   \quad (\because \text{直積作用の計算}) \\
&= T_{(V_1^{(\pm)})^{1/2}}\!\left(\left(T_{V_2}(\hat{Z}_\mu^{(-)}),\ T_{V_2}(\hat{Y}_\mu)\right)
   \begin{pmatrix}\cosh(K_1) \\ i e^{-i\theta_\mu}\sinh(K_1)\end{pmatrix}\right)
   \quad (\because T\text{ の線型性}) \\
&= T_{(V_1^{(\pm)})^{1/2}}\!\left((\hat{Z}_\mu^{(-)},\hat{Y}_\mu)\, B_2
   \begin{pmatrix}\cosh(K_1) \\ i e^{-i\theta_\mu}\sinh(K_1)\end{pmatrix}\right)
   \quad (\because \text{直積作用の計算}) \\
&= \left(T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)}),\ T_{(V_1^{(\pm)})^{1/2}}(\hat{Y}_\mu)\right) B_2
   \begin{pmatrix}\cosh(K_1) \\ i e^{-i\theta_\mu}\sinh(K_1)\end{pmatrix}
   \quad (\because T\text{ の線型性}) \\
&= (\hat{Z}_\mu^{(-)},\hat{Y}_\mu)\, B_1(\theta_\mu)\, B_2
   \begin{pmatrix}\cosh(K_1) \\ i e^{-i\theta_\mu}\sinh(K_1)\end{pmatrix}
   \quad (\because \text{直積作用の計算})
\end{aligned}`,
      ),
      paragraph([
        "(y) ",
        math(String.raw`T_{(V)}(\hat{Y}_\mu)`),
        " について、同様に、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V)}(\hat{Y}_\mu)
&= T_{(V_1^{(\pm)})^{1/2}}\!\left(T_{V_2}\!\left(T_{(V_1^{(\pm)})^{1/2}}(\hat{Y}_\mu)\right)\right)
   \quad (\because V=(V_1^{(\pm)})^{1/2}V_2(V_1^{(\pm)})^{1/2}\ \text{と共役作用の合成則}) \\
&= T_{(V_1^{(\pm)})^{1/2}}\!\left(T_{V_2}\!\left(-i e^{i\theta_\mu}\sinh(K_1)\hat{Z}_\mu^{(-)} + \cosh(K_1)\hat{Y}_\mu\right)\right)
   \quad (\because \text{直積作用の計算}) \\
&= T_{(V_1^{(\pm)})^{1/2}}\!\left(\left(T_{V_2}(\hat{Z}_\mu^{(-)}),\ T_{V_2}(\hat{Y}_\mu)\right)
   \begin{pmatrix}-i e^{i\theta_\mu}\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}\right)
   \quad (\because T\text{ の線型性}) \\
&= T_{(V_1^{(\pm)})^{1/2}}\!\left((\hat{Z}_\mu^{(-)},\hat{Y}_\mu)\, B_2
   \begin{pmatrix}-i e^{i\theta_\mu}\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}\right)
   \quad (\because \text{直積作用の計算}) \\
&= (\hat{Z}_\mu^{(-)},\hat{Y}_\mu)\, B_1(\theta_\mu)\, B_2
   \begin{pmatrix}-i e^{i\theta_\mu}\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}
   \quad (\because T\text{ の線型性と直積作用の計算})
\end{aligned}`,
      ),
      paragraph([
        "よって、上記 2 列を並べると（2 つの列ベクトルはちょうど ",
        math(String.raw`B_1(\theta_\mu)`),
        " の 2 列）、",
      ]),
      displayMath(
String.raw`\left(T_{(V)}(\hat{Z}_\mu^{(-)}),\ T_{(V)}(\hat{Y}_\mu)\right)
= (\hat{Z}_\mu^{(-)},\hat{Y}_\mu)\, B_1(\theta_\mu)\, B_2\, B_1(\theta_\mu)
\quad (\because \text{直前の二列を並べ、}B_1(\theta_\mu)\text{ の二列の定義を用いた})`,
      ),
      paragraph([
        "最後に ",
        math(String.raw`B_1(\theta_\mu)\, B_2\, B_1(\theta_\mu) = A(\theta_\mu)`),
        "（",
        ref("def_A_theta"),
        "）を具体的な行列積で確かめる。以下、記号を",
      ]),
      displayMath(
        String.raw`a := \cosh K_1 \in \mathbb{R},\quad b := \sinh K_1 \in \mathbb{R},\quad
C := \cosh 2K_2^* = c_2^* \in \mathbb{R},\quad S := \sinh 2K_2^* = s_2^* \in \mathbb{R},\quad
\theta := \theta_\mu \in \mathbb{R}`,
      ),
      paragraph([
        "と略記する（",
        math(String.raw`c_2^*, s_2^*`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " の記号）。倍角公式",
      ]),
      displayMath(
        String.raw`a^2 + b^2 = \cosh^2 K_1 + \sinh^2 K_1 = \cosh 2K_1 = c_1, \qquad
2ab = 2\sinh K_1\cosh K_1 = \sinh 2K_1 = s_1, \qquad
a^2 - b^2 = \cosh^2 K_1 - \sinh^2 K_1 = 1`,
      ),
      paragraph([
        "を後で用いる。この記号で ",
        math(String.raw`B_1(\theta) = \begin{pmatrix} a & -i e^{i\theta} b \\ i e^{-i\theta} b & a\end{pmatrix}`),
        "、",
        math(String.raw`B_2 = \begin{pmatrix} C & i S \\ -i S & C\end{pmatrix}`),
        " である。",
      ]),
      paragraph([
        "Step 1: ",
        math(String.raw`N := B_2\, B_1(\theta)`),
        " を成分ごとに計算する（行列の積は ",
        ref("mat_mult"),
        "）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
N_{11} &= C\cdot a + (iS)\cdot\left(i e^{-i\theta} b\right)
        &&(\because \text{行列積の定義}) \\
&= Ca + i^2 S b\, e^{-i\theta}
        &&(\because \text{複素数の積の結合則と可換則}) \\
&= Ca - S b\, e^{-i\theta}
        &&(\because i^2=-1) \\
N_{12} &= C\cdot\left(-i e^{i\theta} b\right) + (iS)\cdot a
        &&(\because \text{行列積の定義}) \\
&= i\left(Sa - C b\, e^{i\theta}\right)
        &&(\because \text{分配則と複素数の積の可換則}) \\
N_{21} &= (-iS)\cdot a + C\cdot\left(i e^{-i\theta} b\right)
        &&(\because \text{行列積の定義}) \\
&= i\left(C b\, e^{-i\theta} - Sa\right)
        &&(\because \text{分配則と複素数の積の可換則}) \\
N_{22} &= (-iS)\cdot\left(-i e^{i\theta} b\right) + C\cdot a
        &&(\because \text{行列積の定義}) \\
&= i^2 S b\, e^{i\theta} + Ca
        &&(\because (-i)(-i)=i^2\ \text{と複素数の積の結合則}) \\
&= Ca - S b\, e^{i\theta}
        &&(\because i^2=-1\ \text{と加法の可換則})
\end{aligned}`,
      ),
      paragraph([
        "Step 2: ",
        math(String.raw`P := B_1(\theta)\, N = B_1(\theta)\, B_2\, B_1(\theta)`),
        " の (1,1) 成分。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{11}
&= a\, N_{11} + \left(-i e^{i\theta} b\right) N_{21}
   &&(\because \text{行列積の定義}) \\
&= a\left(Ca - S b\, e^{-i\theta}\right)
   + \left(-i e^{i\theta} b\right)\cdot i\left(C b\, e^{-i\theta} - Sa\right)
   &&(\because \text{Step 1 の }N_{11},N_{21}\text{ の表示}) \\
&= Ca^2 - S ab\, e^{-i\theta}
   + e^{i\theta} b\left(C b\, e^{-i\theta} - Sa\right)
   \quad (\because -i\cdot i = 1) \\
&= Ca^2 - S ab\, e^{-i\theta} + C b^2 - S ab\, e^{i\theta}
   \quad (\because e^{i\theta}e^{-i\theta} = 1) \\
&= C\left(a^2 + b^2\right) - S ab\left(e^{i\theta} + e^{-i\theta}\right)
   &&(\because \text{分配則による括り出し}) \\
&= C\, c_1 - S\cdot\frac{s_1}{2}\cdot 2\cos\theta
   \quad (\because a^2+b^2 = c_1,\ 2ab = s_1,\ e^{i\theta}+e^{-i\theta} = 2\cos\theta) \\
&= c_1 c_2^* - s_1 s_2^*\cos\theta
   &&(\because C=c_2^*,\ S=s_2^*\ \text{の略記})
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`e^{i\theta} + e^{-i\theta} = 2\cos\theta`),
        " は ",
        ref("euler_formula_cos_sin"),
        " による。）これは ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\theta)`),
        " の (1,1) 成分 ",
        math(String.raw`c_1 c_2^* - s_1 s_2^*\cos\theta = \gamma_1(\theta)`),
        " に一致する。",
      ]),
      paragraph(["Step 3: ", math(String.raw`P`), " の (2,2) 成分。"]),
      displayMath(
        String.raw`\begin{aligned}
P_{22}
&= \left(i e^{-i\theta} b\right) N_{12} + a\, N_{22}
   &&(\because \text{行列積の定義}) \\
&= \left(i e^{-i\theta} b\right)\cdot i\left(Sa - C b\, e^{i\theta}\right)
   + a\left(Ca - S b\, e^{i\theta}\right)
   &&(\because \text{Step 1 の }N_{12},N_{22}\text{ の表示}) \\
&= -e^{-i\theta} b\left(Sa - C b\, e^{i\theta}\right) + Ca^2 - S ab\, e^{i\theta}
   \quad (\because i\cdot i = -1) \\
&= -S ab\, e^{-i\theta} + C b^2 + Ca^2 - S ab\, e^{i\theta}
   &&(\because \text{分配則と }e^{-i\theta}e^{i\theta}=1) \\
&= C\left(a^2 + b^2\right) - S ab\left(e^{i\theta} + e^{-i\theta}\right)
   &&(\because \text{加法の可換則と分配則による括り出し}) \\
&= c_1 c_2^* - s_1 s_2^*\cos\theta
   &&(\because a^2+b^2=c_1,\ 2ab=s_1,\ e^{i\theta}+e^{-i\theta}=2\cos\theta,\ C=c_2^*,\ S=s_2^*)
\end{aligned}`,
      ),
      paragraph([
        "これは ",
        math(String.raw`A(\theta)`),
        " の (2,2) 成分 ",
        math(String.raw`\gamma_1(\theta)`),
        " に一致する（(1,1) 成分と同一の式）。",
      ]),
      paragraph(["Step 4: ", math(String.raw`P`), " の (1,2) 成分。"]),
      displayMath(
        String.raw`\begin{aligned}
P_{12}
&= a\, N_{12} + \left(-i e^{i\theta} b\right) N_{22}
   &&(\because \text{行列積の定義}) \\
&= a\cdot i\left(Sa - C b\, e^{i\theta}\right)
   + \left(-i e^{i\theta} b\right)\left(Ca - S b\, e^{i\theta}\right)
   &&(\because \text{Step 1 の }N_{12},N_{22}\text{ の表示}) \\
&= i\left[S a^2 - C ab\, e^{i\theta}\right]
   + i\left[-C ab\, e^{i\theta} + S b^2 e^{2i\theta}\right]
   &&(\because \text{分配則と複素数の積の結合則}) \\
&= i\left[S\left(a^2 + b^2 e^{2i\theta}\right) - 2C ab\, e^{i\theta}\right]
   &&(\because \text{分配則による括り出し})
\end{aligned}`,
      ),
      paragraph([
        "ここで括弧内の第 1 項を ",
        math(String.raw`e^{i\theta}`),
        " でくくると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
a^2 + b^2 e^{2i\theta}
&= e^{i\theta}\left(a^2 e^{-i\theta} + b^2 e^{i\theta}\right)
   &&(\because e^{i\theta}e^{-i\theta}=1\ \text{と指数法則}) \\
&= e^{i\theta}\left(a^2(\cos\theta - i\sin\theta) + b^2(\cos\theta + i\sin\theta)\right)
   \quad (\because \text{Euler の公式}) \\
&= e^{i\theta}\left(\left(a^2 + b^2\right)\cos\theta - i\left(a^2 - b^2\right)\sin\theta\right)
   &&(\because \text{分配則による整理}) \\
&= e^{i\theta}\left(c_1\cos\theta - i\sin\theta\right)
   \quad (\because a^2+b^2 = c_1,\ a^2-b^2 = 1)
\end{aligned}`,
      ),
      paragraph(["また ", math(String.raw`2ab = s_1`), " なので、"]),
      displayMath(
        String.raw`\begin{aligned}
P_{12}
&= i\left[S\, e^{i\theta}\left(c_1\cos\theta - i\sin\theta\right) - C s_1 e^{i\theta}\right]
   &&(\because \text{直前の補助計算と }2ab=s_1) \\
&= i e^{i\theta}\left[S\left(c_1\cos\theta - i\sin\theta\right) - C s_1\right]
   &&(\because \text{分配則による }e^{i\theta}\text{ の括り出し}) \\
&= i e^{i\theta}\left[s_2^*\left(c_1\cos\theta - i\sin\theta\right) - c_2^*\, s_1\right]
   &&(\because S=s_2^*,\ C=c_2^*\ \text{の略記}) \\
&= i e^{i\theta}\left[s_2^*\left(c_1\cos\theta - i\sin\theta\right) - s_2^* c_2\, s_1\right]
   \quad (\because c_2^* = s_2^* c_2) \\
&= i e^{i\theta} s_2^*\left(c_1\cos\theta - i\sin\theta - s_1 c_2\right)
   &&(\because \text{分配則による }s_2^*\text{ の括り出し})
\end{aligned}`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`c_2^* = s_2^* c_2`),
        " は ",
        ref("duality_c2_star_eq_s2_star_c2"),
        " による（この置き換えが、",
        ref("def_A_theta"),
        " の ",
        math(String.raw`\gamma_2`),
        " で ",
        math(String.raw`c_2^*`),
        " ではなく ",
        math(String.raw`c_2`),
        " が現れる理由である）。得られた ",
        math(String.raw`P_{12}`),
        " は ",
        math(String.raw`A(\theta)`),
        " の (1,2) 成分 ",
        math(String.raw`i e^{i\theta} s_2^*(c_1\cos\theta - i\sin\theta - s_1 c_2) = \gamma_2(\theta)`),
        " に一致する。",
      ]),
      paragraph(["Step 5: ", math(String.raw`P`), " の (2,1) 成分。"]),
      displayMath(
        String.raw`\begin{aligned}
P_{21}
&= \left(i e^{-i\theta} b\right) N_{11} + a\, N_{21}
   &&(\because \text{行列積の定義}) \\
&= \left(i e^{-i\theta} b\right)\left(Ca - S b\, e^{-i\theta}\right)
   + a\cdot i\left(C b\, e^{-i\theta} - Sa\right)
   &&(\because \text{Step 1 の }N_{11},N_{21}\text{ の表示}) \\
&= i\left[C ab\, e^{-i\theta} - S b^2 e^{-2i\theta}\right]
   + i\left[C ab\, e^{-i\theta} - S a^2\right]
   &&(\because \text{分配則と複素数の積の結合則}) \\
&= -i\left[S\left(a^2 + b^2 e^{-2i\theta}\right) - 2C ab\, e^{-i\theta}\right]
   &&(\because \text{分配則による括り出し})
\end{aligned}`,
      ),
      paragraph([
        "括弧内は Step 4 の括弧内で ",
        math(String.raw`\theta`),
        " を ",
        math(String.raw`-\theta`),
        " に置き換えたものに他ならない。よって Step 4 と同じ計算（",
        math(String.raw`\cos(-\theta) = \cos\theta`),
        "、",
        math(String.raw`\sin(-\theta) = -\sin\theta`),
        " を用いる）により、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
S\left(a^2 + b^2 e^{-2i\theta}\right) - 2C ab\, e^{-i\theta}
&= e^{-i\theta} s_2^*\left(c_1\cos\theta + i\sin\theta - s_1 c_2\right)
   &&(\because \text{Step 4 の補助計算で }\theta\text{ を }-\theta\text{ に置換}) \\
P_{21}
&= -i e^{-i\theta} s_2^*\left(c_1\cos\theta + i\sin\theta - s_1 c_2\right)
   &&(\because \text{直前の等式を }P_{21}\text{ の表示へ代入}) \\
&= -\gamma_2(-\theta)
   &&(\because \gamma_2\text{ の定義と }\cos(-\theta)=\cos\theta,\ \sin(-\theta)=-\sin\theta)
\end{aligned}`,
      ),
      paragraph(["実際、"]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(-\theta)
&= i e^{-i\theta} s_2^*\left(c_1\cos(-\theta) - i\sin(-\theta) - s_1 c_2\right)
&& (\because\ \gamma_2\text{ の定義}) \\
&= i e^{-i\theta} s_2^*\left(c_1\cos\theta + i\sin\theta - s_1 c_2\right)
&& (\because\ \cos(-\theta)=\cos\theta,\ \sin(-\theta)=-\sin\theta)
\end{aligned}`),
      paragraph([
        "であるから ",
        math(String.raw`P_{21} = -\gamma_2(-\theta)`),
        " であり、これは ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\theta)`),
        " の (2,1) 成分 ",
        math(String.raw`-i e^{-i\theta} s_2^*(c_1\cos\theta + i\sin\theta - s_1 c_2)`),
        " に一致する。",
      ]),
      paragraph([
        "Step 6: Step 2〜5 により ",
        math(String.raw`P = B_1(\theta_\mu) B_2 B_1(\theta_\mu)`),
        " の 4 成分すべてが ",
        math(String.raw`A(\theta_\mu)`),
        " の対応成分に一致するので ",
        math(String.raw`B_1(\theta_\mu) B_2 B_1(\theta_\mu) = A(\theta_\mu)`),
        "。したがって statement を得る：",
      ]),
      displayMath(
String.raw`\left(T_{(V)}(\hat{Z}_\mu^{(-)}),\ T_{(V)}(\hat{Y}_\mu)\right)
= (\hat{Z}_\mu^{(-)},\hat{Y}_\mu)\, A(\theta_\mu)
\quad (\because B_1(\theta_\mu)B_2B_1(\theta_\mu)=A(\theta_\mu))`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文 proof の (z)/(y) 各行列簡約と『よって』の合流までを忠実に翻訳。原文が TODO（Mathematica で数値確認済みとして略）としていた最終の B1·B2·B1 = A(θ_μ) の明示的行列積を、4 成分すべて途中式込みで人手計算して埋め、todo を除去した。",
        "行列積の結果は statement（および def_A_theta の A(θ) の定義）と完全に一致した。ただし (1,2)/(2,1) 成分は素の計算では c_2^*（＝S）が現れ、A(θ) の γ_2 に現れる c_2 とは K_2 と K_2^* の双対関係 c_2^* = s_2^* c_2 を経由して一致する。この関係を duality_c2_star_eq_s2_star_c2 として独立した claim に切り出し、参照した。statement 側の修正は不要だった。",
        "原文の (z)/(y) 個別鎖では第1行列の (1,2)/(2,1) 成分を i e^{-iθ} 形（別表示）で書く箇所があり、原文『よって』段の B1（calc_of_TxT と整合する -i e^{iθ}, i e^{-iθ} 形）と内部で不整合。ここでは確立済みの B1（calc_of_TxT_hatZxhatY, 014）に統一して原文の最終結論を再現した。",
        "T_(V) の hat Z, hat Y への作用の証明に残っていた根拠なしの等号へ、共役作用の合成則・線型性・行列積・複素数の四則演算・Euler の公式の行末根拠を補い、一行に複数の等号があった Step 1 の四成分と Step 5 の終端を一行一等号へ開いた（2026-08-15）。主張と計算内容は変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_037_claim_factorization_A_theta",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/036_claim_A_thetaの行列分解.typ",
      ordinal: 37,
    },
    title: { tex: String.raw`A(\theta_\mu) \text{ の行列分解}` },
    labels: ["factorization_of_A_theta"],
    statement: [
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(
        String.raw`B_1(\theta_\mu)
:= \begin{pmatrix}
\cosh K_1 & -ie^{i\theta_\mu}\sinh K_1 \\
ie^{-i\theta_\mu}\sinh K_1 & \cosh K_1
\end{pmatrix},
\quad
B_2 := \begin{pmatrix}
\cosh(2K_2^*) & i\sinh(2K_2^*) \\
-i\sinh(2K_2^*) & \cosh(2K_2^*)
\end{pmatrix}`,
      ),
      paragraph(["とおくと"]),
      displayMath(String.raw`A(\theta_\mu) = B_1(\theta_\mu) \cdot B_2 \cdot B_1(\theta_\mu)`),
    ],
    proof: [
      paragraph([
        ref("calc_of_TxT_hatZxhatY"),
        " より ",
        math(String.raw`T_{(V_1^{(\pm)})^{1/2}}`),
        " は ",
        math(String.raw`(\hat{Z}_\mu^{(-)}, \hat{Y}_\mu)`),
        " に右から ",
        math(String.raw`B_1(\theta_\mu)`),
        " を掛け、",
        math(String.raw`T_{(V_2)}`),
        " は右から ",
        math(String.raw`B_2`),
        " を掛ける。",
        math(String.raw`T_{(V)} = T_{(V_1^{(\pm)})^{1/2}} \circ T_{(V_2)} \circ T_{(V_1^{(\pm)})^{1/2}}`),
        " と ",
        ref("def_A_theta"),
        " の定義から ",
        math(String.raw`A(\theta_\mu) = B_1(\theta_\mu) B_2 B_1(\theta_\mu)`),
        "。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_019_definition_theta_mu",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/018_definition_theta_mu.typ",
      ordinal: 19,
    },
    title: { tex: String.raw`\theta_\mu \text{ の定義}` },
    labels: ["def_theta_mu"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \mathcal{M}`),
        " について、",
      ]),
      displayMath(String.raw`\theta_\mu := \frac{2\pi\mu}{M}`),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_020_definition_gamma1_gamma2",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/019_definition_A_thetaの対角化の準備.typ",
      ordinal: 20,
    },
    title: { tex: String.raw`\gamma_1(\theta_\mu), \gamma_2(\theta_\mu) \text{ の定義}` },
    labels: [],
    statement: [
      displayMath(
        String.raw`\gamma_1(\theta_\mu) := c_1 c_2^* - s_1 s_2^*\cos\theta_\mu \in \mathbb{R}`,
      ),
      displayMath(
        String.raw`\gamma_2(\theta_\mu) := i e^{i\theta_\mu} s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2) \in \mathbb{C}`,
      ),
      paragraph(["とおくと、"]),
      displayMath(
        String.raw`A(\theta_\mu) = \begin{pmatrix}
\gamma_1(\theta_\mu) & \gamma_2(\theta_\mu) \\
-\gamma_2(-\theta_\mu) & \gamma_1(\theta_\mu)
\end{pmatrix}`,
      ),
    ],
    conversion: { status: "converted" },
  },
]);
