import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

// 章「T_{V_1}(hat Z) と hat Z, hat Y の関係」の前半（文書順）。
// 収録範囲は parts/008 の 000〜017, 036, 018, 019（文書順はソースのファイル名連番と
// 一致しないため、ファイル名に連番範囲は入れない）。並びが文書順の正準表現。
export default defineBlocks([
  {
    id: "heading_TV1_hatZ_hatY",
    kind: "heading",
    level: 2,
    sourcePath: "_old/typst/main.typ",
    sourceOrdinal: 10,
    title: { tex: String.raw`T_{V_1}(\hat{Z})\text{と}\hat{Z},\hat{Y}\text{の関係}` },
    labels: [],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_001_claim_commutator_H_Z_Y",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/000_claim_H1_H2とhatZ_hatYの交換関係.typ",
    sourceOrdinal: 1,
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
&= -2 \hat{Y}_\mu + \frac{1}{M}\sum_{j\in\{1,\dots,M\}}
   \left(-2\, e^{-i \frac{2\pi}{M}(-j+\mu)}\,\hat{Y}_j\right) \\
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
        " の反交換関係（下記 notes 参照）を用いる。",
      ]),
      paragraph([
        "(1) ",
        math(String.raw`[H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]`),
        " について、",
        math(String.raw`\mu \in \mathcal{M}`),
        " について、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]
&= \left[\overbrace{\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(\hat{Y}_j\,\hat{Z}_{-j}^{(\pm)}\,e^{-i\frac{2\pi j}{M}}\right)}^{H_1^{(\pm)}},\ \hat{Z}_\mu^{(\pm)}\right] \\
&= \frac{1}{M}\left(\left(\sum_{j\in\{1,\dots,M\}}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}e^{-i\frac{2\pi j}{M}}\right)\hat{Z}_\mu^{(\pm)}
   - \hat{Z}_\mu^{(\pm)}\left(\sum_{j\in\{1,\dots,M\}}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}e^{-i\frac{2\pi j}{M}}\right)\right) \\
&= \frac{1}{M}\left(\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\pm)}
   - \sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Z}_\mu^{(\pm)}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(e^{-i\frac{2\pi j}{M}}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\pm)}
   - e^{-i\frac{2\pi j}{M}}\hat{Z}_\mu^{(\pm)}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\left(\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\pm)}
   - \hat{Z}_\mu^{(\pm)}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\left(\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\pm)}
   + \hat{Y}_j\hat{Z}_\mu^{(\pm)}\hat{Z}_{-j}^{(\pm)}\right)
   \quad (\because \hat{Z}_\mu^{(\pm)}\hat{Y}_j = -\hat{Y}_j\hat{Z}_\mu^{(\pm)}) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\left(\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\pm)}
   + \hat{Z}_\mu^{(\pm)}\hat{Z}_{-j}^{(\pm)}\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\,[\hat{Z}_{-j}^{(\pm)},\hat{Z}_\mu^{(\pm)}]_+ \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\left(2M\,\delta^M_{-j+\mu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}\right)
   \quad (\because \text{反交換子の値}) \\
&= 2\sum_{j\in\{1,\dots,M\}} \delta^M_{-j+\mu,0}\, e^{-i\frac{2\pi j}{M}}\hat{Y}_j\, I_{(\mathbb{C}^2)^{\otimes M}} \\
&= 2\sum_{\substack{j\in\{1,\dots,M\}\\ -j+\mu\equiv 0 \pmod{M}}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j
\end{aligned}`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`j\in\{1,\dots,M\}`),
        " かつ ",
        math(String.raw`-j+\mu\equiv 0 \pmod{M}`),
        " となる ",
        math(String.raw`j`),
        " は次で与えられる：",
      ]),
      displayMath(
        String.raw`j = \begin{cases}
M & (\mu = -M) \\
M+\mu & (-M+1 \leq \mu \leq -1) \\
\mu & (1 \leq \mu \leq M)
\end{cases}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
[H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]
&= 2\begin{cases}
e^{-i\frac{2\pi M}{M}}\hat{Y}_M & (\mu = -M) \\
e^{-i\frac{2\pi(M+\mu)}{M}}\hat{Y}_{M+\mu} & (-M+1 \leq \mu \leq -1) \\
e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu & (1 \leq \mu \leq M)
\end{cases} \\
&= 2\, e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\because`),
        " ",
        math(String.raw`\hat{Y}`),
        " の定義より ",
        math(String.raw`M`),
        " ズレは値が等しく ",
        math(String.raw`\hat{Y}_\mu = \hat{Y}_{M+\mu}`),
        "、および ",
        math(String.raw`e^{-i\frac{2\pi(-M)}{M}}\hat{Y}_{-M} = 1\cdot\hat{Y}_{M-2M} = e^{-i\frac{2\pi M}{M}}\hat{Y}_M`),
        "。",
      ]),
      paragraph([
        "(2) ",
        math(String.raw`[H_1^{(\pm)}, \hat{Z}_\mu^{(\mp)}]`),
        " について、",
        math(String.raw`\mu \in \mathcal{M}`),
        " について、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[H_1^{(\pm)}, \hat{Z}_\mu^{(\mp)}]
&= \left[\overbrace{\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(\hat{Y}_j\,\hat{Z}_{-j}^{(\pm)}\,e^{-i\frac{2\pi j}{M}}\right)}^{H_1^{(\pm)}},\ \hat{Z}_\mu^{(\mp)}\right] \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left[\hat{Y}_j\hat{Z}_{-j}^{(\pm)}e^{-i\frac{2\pi j}{M}},\ \hat{Z}_\mu^{(\mp)}\right] \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\left[\hat{Y}_j\hat{Z}_{-j}^{(\pm)},\ \hat{Z}_\mu^{(\mp)}\right] \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\left(\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\mp)}
   - \hat{Z}_\mu^{(\mp)}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\left(\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\mp)}
   + \hat{Y}_j\hat{Z}_\mu^{(\mp)}\hat{Z}_{-j}^{(\pm)}\right)
   \quad (\because \hat{Z}_\mu^{(\mp)}\hat{Y}_j = -\hat{Y}_j\hat{Z}_\mu^{(\mp)}) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\left(\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\mp)}
   + \hat{Z}_\mu^{(\mp)}\hat{Z}_{-j}^{(\pm)}\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\,[\hat{Z}_{-j}^{(\pm)},\hat{Z}_\mu^{(\mp)}]_+ \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\left(
   \overbrace{2M\,\delta^M_{-j+\mu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}}^{[\hat{Z}_{-j}^{(\pm)},\hat{Z}_\mu^{(\pm)}]_+}
   + \left(-2\,e^{-i\frac{2\pi}{M}(-j+\mu)}\cdot 2\,I_{(\mathbb{C}^2)^{\otimes M}}\right)\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\left(2M\,\delta^M_{-j+\mu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}\right)
   + \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\left(-2\,e^{-i\frac{2\pi}{M}(-j+\mu)}\cdot 2\,I_{(\mathbb{C}^2)^{\otimes M}}\right) \\
&= 2\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\,\delta^M_{-j+\mu,0}
   - \frac{4}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}-i\frac{2\pi}{M}(-j+\mu)}\hat{Y}_j \\
&= 2\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\,\delta^M_{-j+\mu,0}
   - \frac{4}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi\mu}{M}}\hat{Y}_j \\
&= 2\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\,\delta^M_{-j+\mu,0}
   - \frac{4}{M} e^{-i\frac{2\pi\mu}{M}}\sum_{j\in\{1,\dots,M\}} \hat{Y}_j \\
&= 2\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\,\delta^M_{-j+\mu,0}
   - \frac{4}{M} e^{-i\frac{2\pi\mu}{M}}\sum_{j\in\{1,\dots,M\}}\sum_{k=1}^{M} Y_k\, e^{-i k\frac{2\pi j}{M}} \\
&= 2\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\,\delta^M_{-j+\mu,0}
   - \frac{4}{M} e^{-i\frac{2\pi\mu}{M}}\sum_{k=1}^{M} Y_k\sum_{j\in\{1,\dots,M\}} e^{-i k\frac{2\pi j}{M}} \\
&= 2\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\,\delta^M_{-j+\mu,0}
   - \frac{4}{M} e^{-i\frac{2\pi\mu}{M}}\sum_{k=1}^{M} Y_k\, M\,\delta^M_{(k,0)}
   \quad (\because \text{指数和の公式})
\end{aligned}`,
      ),
      paragraph([
        "指数和の公式は ",
        ref("exp_sum"),
        " による。第1項の ",
        math(String.raw`\delta^M_{-j+\mu,0}`),
        " による ",
        math(String.raw`j`),
        " の決定は ",
        math(String.raw`j = 2M+\mu\ (\mu=-M),\ M+\mu\ (-M+1\leq\mu\leq-1),\ \mu\ (1\leq\mu\leq M)`),
        "。原文では第2項を ",
        math(String.raw`0`),
        " として次の結論を得ている：",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[H_1^{(\pm)}, \hat{Z}_\mu^{(\mp)}]
&= 2\begin{cases}
e^{-i\frac{2\pi(2M+\mu)}{M}}\hat{Y}_{2M+\mu} & (\mu = -M) \\
e^{-i\frac{2\pi(M+\mu)}{M}}\hat{Y}_{M+\mu} & (-M+1 \leq \mu \leq -1) \\
e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu & (1 \leq \mu \leq M)
\end{cases} - 0 \\
&= 2\, e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu
\end{aligned}`,
      ),
      paragraph([
        "(3) ",
        math(String.raw`[H_1^{(\pm)}, \hat{Y}_\mu]`),
        " について、",
        math(String.raw`\mu \in \mathcal{M}`),
        " について、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[H_1^{(\pm)}, \hat{Y}_\mu]
&= \left[\overbrace{\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(\hat{Y}_j\,\hat{Z}_{-j}^{(\pm)}\,e^{-i\frac{2\pi j}{M}}\right)}^{H_1^{(\pm)}},\ \hat{Y}_\mu\right] \\
&= \frac{1}{M}\left(\left(\sum_{j\in\{1,\dots,M\}}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}e^{-i\frac{2\pi j}{M}}\right)\hat{Y}_\mu
   - \hat{Y}_\mu\left(\sum_{j\in\{1,\dots,M\}}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}e^{-i\frac{2\pi j}{M}}\right)\right) \\
&= \frac{1}{M}\left(\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Y}_\mu
   - \sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\hat{Y}_\mu\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(e^{-i\frac{2\pi j}{M}}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Y}_\mu
   - e^{-i\frac{2\pi j}{M}}\hat{Y}_\mu\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\left(\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Y}_\mu
   - \hat{Y}_\mu\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\left(-\hat{Y}_j\hat{Y}_\mu\hat{Z}_{-j}^{(\pm)}
   - \hat{Y}_\mu\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right)
   \quad (\because \hat{Z}_{-j}^{(\pm)}\hat{Y}_\mu = -\hat{Y}_\mu\hat{Z}_{-j}^{(\pm)}) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\left(-\hat{Y}_j\hat{Y}_\mu
   - \hat{Y}_\mu\hat{Y}_j\right)\hat{Z}_{-j}^{(\pm)} \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\left(-[\hat{Y}_j,\hat{Y}_\mu]_+\right)\hat{Z}_{-j}^{(\pm)} \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} e^{-i\frac{2\pi j}{M}}\left(-2M\,\delta^M_{j+\mu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}\right)\hat{Z}_{-j}^{(\pm)} \\
&= -2\sum_{j\in\{1,\dots,M\}} \delta^M_{j+\mu,0}\, e^{-i\frac{2\pi j}{M}}\hat{Z}_{-j}^{(\pm)}
\end{aligned}`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`j+\mu\equiv 0 \pmod{M}`),
        " かつ ",
        math(String.raw`j\in\{1,\dots,M\}`),
        " となる ",
        math(String.raw`j`),
        " は ",
        math(String.raw`j = -\mu\ (\mu\leq -1),\ M-\mu\ (1\leq\mu\leq M-1),\ M\ (\mu=M)`),
        " なので、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[H_1^{(\pm)}, \hat{Y}_\mu]
&= -2\begin{cases}
e^{-i\frac{2\pi(-\mu)}{M}}\hat{Z}_{-(-\mu)}^{(\pm)} & (\mu \leq -1) \\
e^{-i\frac{2\pi(M-\mu)}{M}}\hat{Z}_{-(M-\mu)}^{(\pm)} & (1 \leq \mu \leq M-1) \\
e^{-i\frac{2\pi M}{M}}\hat{Z}_{-M}^{(\pm)} & (\mu = M)
\end{cases} \\
&= -2\, e^{-i\frac{2\pi(-\mu)}{M}}\hat{Z}_\mu^{(\pm)}
= -2\, e^{i\frac{2\pi\mu}{M}}\hat{Z}_\mu^{(\pm)}
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\because`),
        " ",
        math(String.raw`\hat{Z}`),
        " の定義より ",
        math(String.raw`M`),
        " ズレは値が等しく ",
        math(String.raw`\hat{Z}_\mu^{(\pm)} = \hat{Z}_{-M+\mu}^{(\pm)}`),
        "、および ",
        math(String.raw`e^{-i\frac{2\pi M}{M}}\hat{Z}_{-M}^{(\pm)} = 1\cdot\hat{Z}_{M-2M}^{(\pm)} = e^{-i\frac{2\pi(-M)}{M}}\hat{Z}_M^{(\pm)}`),
        "。",
      ]),
      paragraph([
        "(4) ",
        math(String.raw`[H_2, \hat{Z}_\mu^{(\pm)}]`),
        " について、",
        math(String.raw`\mu \in \mathcal{M}`),
        " について、まず符号によらず次まで進める：",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[H_2, \hat{Z}_\mu^{(\pm)}]
&= \left[\overbrace{\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j}^{H_2},\ \hat{Z}_\mu^{(\pm)}\right] \\
&= \frac{1}{M}\left(\left(\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)\hat{Z}_\mu^{(\pm)}
   - \hat{Z}_\mu^{(\pm)}\left(\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(\hat{Z}_{-j}^{(-)}\hat{Y}_j\hat{Z}_\mu^{(\pm)}
   - \hat{Z}_\mu^{(\pm)}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-\hat{Z}_{-j}^{(-)}\hat{Z}_\mu^{(\pm)}\hat{Y}_j
   - \hat{Z}_\mu^{(\pm)}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)
   \quad (\because \hat{Z}_\mu^{(\pm)}\hat{Y}_j = -\hat{Y}_j\hat{Z}_\mu^{(\pm)}) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-\hat{Z}_{-j}^{(-)}\hat{Z}_\mu^{(\pm)}
   - \hat{Z}_\mu^{(\pm)}\hat{Z}_{-j}^{(-)}\right)\hat{Y}_j \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-[\hat{Z}_{-j}^{(-)},\hat{Z}_\mu^{(\pm)}]_+\right)\hat{Y}_j \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-[\hat{Z}_\mu^{(\pm)},\hat{Z}_{-j}^{(-)}]_+\right)\hat{Y}_j
\end{aligned}`,
      ),
      paragraph([
        "以下、",
        math(String.raw`\hat{Z}`),
        " の符号で分岐する。",
      ]),
      paragraph([
        "(4.1) ",
        math(String.raw`[H_2, \hat{Z}_\mu^{(-)}]`),
        " について：",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-[\hat{Z}_\mu^{(-)},\hat{Z}_{-j}^{(-)}]_+\right)\hat{Y}_j
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-2M\,\delta^M_{-j+\mu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}\right)\hat{Y}_j \\
&= -2\sum_{j\in\{1,\dots,M\}}\delta^M_{-j+\mu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}\,\hat{Y}_j \\
&= -2\begin{cases}
\hat{Y}_M & (\mu = -M) \\
\hat{Y}_{M+\mu} & (-M+1 \leq \mu \leq -1) \\
\hat{Y}_\mu & (1 \leq \mu \leq M)
\end{cases} \\
&= -2\,\hat{Y}_\mu \quad (\because \hat{Y}\text{ の }M\text{ 周期性})
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
   -\overbrace{2M\,\delta^M_{-j+\mu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}}^{[\hat{Z}_\mu^{(\pm)},\hat{Z}_{-j}^{(\pm)}]_+}
   + \left(-2\,e^{-i\frac{2\pi}{M}(-j+\mu)}\cdot 2\,I_{(\mathbb{C}^2)^{\otimes M}}\right)\right)\hat{Y}_j \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-2M\,\delta^M_{-j+\mu,0}\,\hat{Y}_j
   + \left(-2\,e^{-i\frac{2\pi}{M}(-j+\mu)}\,\hat{Y}_j\right)\right) \\
&= -2\begin{cases}
\hat{Y}_M & (\mu = -M) \\
\hat{Y}_{M+\mu} & (-M+1 \leq \mu \leq -1) \\
\hat{Y}_\mu & (1 \leq \mu \leq M)
\end{cases}
   + \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-2\,e^{-i\frac{2\pi}{M}(-j+\mu)}\,\hat{Y}_j\right) \\
&= -2\,\hat{Y}_\mu
   + \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-2\,e^{-i\frac{2\pi}{M}(-j+\mu)}\,\hat{Y}_j\right)
\end{aligned}`,
      ),
      paragraph([
        "(5) ",
        math(String.raw`[H_2, \hat{Y}_\mu]`),
        " について、",
        math(String.raw`\mu \in \mathcal{M}`),
        " について、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[H_2, \hat{Y}_\mu]
&= \left[\overbrace{\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j}^{H_2},\ \hat{Y}_\mu\right] \\
&= \frac{1}{M}\left(\left(\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)\hat{Y}_\mu
   - \hat{Y}_\mu\left(\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)\right) \\
&= \frac{1}{M}\left(\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\hat{Y}_\mu
   - \sum_{j\in\{1,\dots,M\}}\hat{Y}_\mu\hat{Z}_{-j}^{(-)}\hat{Y}_j\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(\hat{Z}_{-j}^{(-)}\hat{Y}_j\hat{Y}_\mu
   - \hat{Y}_\mu\hat{Z}_{-j}^{(-)}\hat{Y}_j\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(\hat{Z}_{-j}^{(-)}\hat{Y}_j\hat{Y}_\mu
   + \hat{Z}_{-j}^{(-)}\hat{Y}_\mu\hat{Y}_j\right)
   \quad (\because \hat{Y}_\mu\hat{Z}_{-j}^{(-)} = -\hat{Z}_{-j}^{(-)}\hat{Y}_\mu) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\left(\hat{Y}_j\hat{Y}_\mu + \hat{Y}_\mu\hat{Y}_j\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\,[\hat{Y}_j,\hat{Y}_\mu]_+ \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} 2M\,\delta^M_{j+\mu,0}\,\hat{Z}_{-j}^{(-)} \\
&= 2\sum_{\substack{j\in\{1,\dots,M\}\\ j+\mu\equiv 0 \pmod{M}}} \hat{Z}_{-j}^{(-)} \\
&= 2\begin{cases}
\hat{Z}_\mu^{(-)} & (\mu \leq -1) \\
\hat{Z}_{-M+\mu}^{(-)} & (1 \leq \mu \leq M-1) \\
\hat{Z}_{-M}^{(-)} & (\mu = M)
\end{cases}
= 2\,\hat{Z}_\mu^{(-)}
\end{aligned}`,
      ),
    ],
    notes: [
      paragraph(["証明で用いる表式と反交換関係（原文 note）："]),
      displayMath(
        String.raw`\begin{aligned}
H_1^{(\pm)} &= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(\hat{Y}_j\hat{Z}_{-j}^{(\pm)}e^{-i\frac{2\pi j}{M}}\right) \\
H_2 &= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j \\
[\hat{Z}_\mu^{(\pm)},\hat{Z}_\nu^{(\pm)}]_+ &= 2M\,\delta^M_{\mu+\nu,0}\,I_{(\mathbb{C}^2)^{\otimes M}} \\
[\hat{Z}_\mu^{(\pm)},\hat{Z}_\nu^{(\mp)}]_+ &= \overbrace{2M\,\delta^M_{\mu+\nu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}}^{[\hat{Z}_\mu^{(\pm)},\hat{Z}_\nu^{(\pm)}]_+}
   + \left(-2\,e^{-i\frac{2\pi}{M}(\mu+\nu)}\cdot 2\,I_{(\mathbb{C}^2)^{\otimes M}}\right) \\
[\hat{Z}_\mu^{(\pm)},\hat{Y}_\nu]_+ &= 0 \\
[\hat{Y}_\mu,\hat{Y}_\nu]_+ &= 2M\,\delta^M_{\mu+\nu,0}\,I \\
\sum_{j=1}^{M} e^{k\cdot\frac{2\pi i j}{M}} &= M\,\delta^M_{(k,0)}
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文の全計算過程を各ステップ忠実に翻訳。statement に原文にある [H2, hatZ^(+)] の関係式を追加した。",
        "(2) [H1, hatZ^(∓)] の最終段で原文は第2項（-4/M e^{-i2πμ/M} Σ_k Y_k M δ^M_{(k,0)}）を 0 として結論しているが、この項は一般に消えず（k=M で δ=1）、原文の該当ステップの正当化は不完全。忠実性のため原文どおり `- 0` を残した。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_002_claim_nesting_commutator",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/001_claim_交換子のネスト.typ",
    sourceOrdinal: 2,
    title: null,
    labels: ["nesting_of_commutator_of_H_and_Z"],
    statement: [
      paragraph([math(String.raw`n \geq 0`), " とする。"]),
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
      paragraph(["(h2.z−)"]),
      displayMath(
        String.raw`\underbrace{[K_2^* H_2, \dots, [K_2^* H_2, \hat{Z}_\mu^{(-)}]\dots]}_{n}
= \begin{cases}
(-1)^{(n+1)/2}(2K_2^*)^n \hat{Y}_\mu & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_2^*)^n \hat{Z}_\mu^{(-)} & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h2.y)"]),
      displayMath(
        String.raw`\underbrace{[K_2^* H_2, \dots, [K_2^* H_2, \hat{Y}_\mu]\dots]}_{n}
= \begin{cases}
(-1)^{(n-1)/2}(2K_2^*)^n \hat{Z}_\mu^{(-)} & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_2^*)^n \hat{Y}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
    ],
    proof: [
      paragraph([
        "原文の証明は未完成（アウトラインのみ）である。原文の記述：",
      ]),
      paragraph([todo("TODO : note 参考にして、帰納法で行ける")]),
      paragraph([
        "帰納法の各ステップでは ",
        ref("commutator_of_H_and_Z_Y"),
        " を繰り返し適用する。原文 note の具体例 ",
        math(String.raw`n = 0,1,2,3,4`),
        " は下記 notes を参照。",
      ]),
    ],
    notes: [
      paragraph([
        "原文 note の具体例（",
        ref("commutator_of_H_and_Z_Y"),
        " を繰り返し適用）：",
      ]),
      paragraph(["(h1.z) ", math(String.raw`n=0`), "："]),
      displayMath(
        String.raw`\underbrace{[K_1 H_1^{(\pm)},\dots,[K_1 H_1^{(\pm)},\hat{Z}_\mu^{(\pm)}]\dots]}_{0\text{ times}}
= \hat{Z}_\mu^{(\pm)}`,
      ),
      paragraph(["(h1.z) ", math(String.raw`n=1`), "："]),
      displayMath(
        String.raw`\begin{aligned}
[K_1 H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]
&= K_1[H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}] \\
&= K_1\cdot 2\cdot\begin{cases}
\hat{Y}_M & (\mu = -M) \\
e^{-i\frac{2\pi(M+\mu)}{M}}\hat{Y}_{M+\mu} & (-M+1 \leq \mu \leq -1) \\
e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu & (1 \leq \mu \leq M-1) \\
\hat{Y}_M & (\mu = M)
\end{cases} \\
&= K_1\cdot 2\cdot\left(e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu\right)
   \quad (\because \hat{Y}\text{ の }M\text{ 周期性})
\end{aligned}`,
      ),
      paragraph(["(h1.z) ", math(String.raw`n=2`), "："]),
      displayMath(
        String.raw`\begin{aligned}
[K_1 H_1^{(\pm)}, [K_1 H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]]
&= [K_1 H_1^{(\pm)},\ K_1\cdot 2\cdot(e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu)] \\
&= K_1^2\cdot 2\cdot e^{-i\frac{2\pi\mu}{M}}[H_1^{(\pm)}, \hat{Y}_\mu] \\
&= K_1^2\cdot 2\cdot e^{-i\frac{2\pi\mu}{M}}\left(-2\cdot(e^{-i\frac{2\pi(-\mu)}{M}}\hat{Z}_\mu^{(\pm)})\right) \\
&= K_1^2\cdot 2^2\cdot(-1)^1\cdot e^{\overbrace{-i\frac{2\pi\mu}{M}-i\frac{2\pi(-\mu)}{M}}^{0}}\hat{Z}_\mu^{(\pm)} \\
&= K_1^2\cdot 2^2\cdot(-1)^1\cdot\hat{Z}_\mu^{(\pm)}
\end{aligned}`,
      ),
      paragraph(["(h1.z) ", math(String.raw`n=3`), "："]),
      displayMath(
        String.raw`\begin{aligned}
[K_1 H_1^{(\pm)}, \overbrace{[K_1 H_1^{(\pm)},[K_1 H_1^{(\pm)},\hat{Z}_\mu^{(\pm)}]]}^{n=2}]
&= [K_1 H_1^{(\pm)},\ K_1^2\cdot 2^2\cdot(-1)^1\cdot\hat{Z}_\mu^{(\pm)}] \\
&= K_1\cdot K_1^2\cdot 2^2\cdot(-1)^1\cdot[H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}] \\
&= K_1\cdot K_1^2\cdot 2^2\cdot(-1)^1\cdot\left(2\cdot(e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu)\right) \\
&= K_1^3\cdot 2^3\cdot(-1)^1\cdot e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu
\end{aligned}`,
      ),
      paragraph(["(h1.z) ", math(String.raw`n=4`), "："]),
      displayMath(
        String.raw`\begin{aligned}
[K_1 H_1^{(\pm)}, \overbrace{[K_1 H_1^{(\pm)},[K_1 H_1^{(\pm)},[K_1 H_1^{(\pm)},\hat{Z}_\mu^{(\pm)}]]]}^{n=3}]
&= [K_1 H_1^{(\pm)},\ K_1^3\cdot 2^3\cdot(-1)^1\cdot e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu] \\
&= K_1\cdot K_1^3\cdot 2^3\cdot(-1)^1\cdot e^{-i\frac{2\pi\mu}{M}}[H_1^{(\pm)}, \hat{Y}_\mu] \\
&= K_1\cdot K_1^3\cdot 2^3\cdot(-1)^1\cdot e^{-i\frac{2\pi\mu}{M}}\left(-2\cdot(e^{-i\frac{2\pi(-\mu)}{M}}\hat{Z}_\mu^{(\pm)})\right) \\
&= K_1^4\cdot 2^4\cdot(-1)^2\cdot e^{-i\frac{2\pi\mu}{M}}e^{-i\frac{2\pi(-\mu)}{M}}\hat{Z}_\mu^{(\pm)} \\
&= K_1^4\cdot 2^4\cdot(-1)^2\cdot e^{\overbrace{-i\frac{2\pi\mu}{M}-i\frac{2\pi(-\mu)}{M}}^{0}}\hat{Z}_\mu^{(\pm)} \\
&= K_1^4\cdot 2^4\cdot(-1)^2\cdot\hat{Z}_\mu^{(\pm)}
\end{aligned}`,
      ),
      paragraph(["(h1.y) ", math(String.raw`n=0`), "："]),
      displayMath(
        String.raw`\underbrace{[K_1 H_1^{(\pm)},\dots,[K_1 H_1^{(\pm)},\hat{Y}_\mu]\dots]}_{0\text{ times}}
= \hat{Y}_\mu`,
      ),
      paragraph(["(h1.y) ", math(String.raw`n=1`), "："]),
      displayMath(
        String.raw`\begin{aligned}
[K_1 H_1^{(\pm)}, \hat{Y}_\mu]
&= K_1[H_1^{(\pm)}, \hat{Y}_\mu] \\
&= K_1\left(-2\cdot(e^{-i\frac{2\pi(-\mu)}{M}}\hat{Z}_\mu^{(\pm)})\right) \\
&= K_1\cdot 2\cdot(-1)\cdot e^{-i\frac{2\pi(-\mu)}{M}}\hat{Z}_\mu^{(\pm)}
\end{aligned}`,
      ),
      paragraph(["(h1.y) ", math(String.raw`n=2`), "："]),
      displayMath(
        String.raw`\begin{aligned}
[K_1 H_1^{(\pm)}, \overbrace{[K_1 H_1^{(\pm)},\hat{Y}_\mu]}^{n=1}]
&= [K_1 H_1^{(\pm)},\ K_1\cdot 2\cdot(-1)\cdot e^{-i\frac{2\pi(-\mu)}{M}}\hat{Z}_\mu^{(\pm)}] \\
&= K_1^2\cdot 2\cdot(-1)\cdot e^{-i\frac{2\pi(-\mu)}{M}}[H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}] \\
&= K_1^2\cdot 2\cdot(-1)\cdot e^{-i\frac{2\pi(-\mu)}{M}}\left(2\cdot(e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu)\right) \\
&= K_1^2\cdot 2^2\cdot(-1)\cdot e^{-i\frac{2\pi(-\mu)}{M}}e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu \\
&= K_1^2\cdot 2^2\cdot(-1)\cdot e^{\overbrace{-i\frac{2\pi(-\mu)}{M}-i\frac{2\pi\mu}{M}}^{0}}\hat{Y}_\mu \\
&= K_1^2\cdot 2^2\cdot(-1)\cdot\hat{Y}_\mu
\end{aligned}`,
      ),
      paragraph(["(h1.y) ", math(String.raw`n=3`), "："]),
      displayMath(
        String.raw`\begin{aligned}
[K_1 H_1^{(\pm)}, \overbrace{[K_1 H_1^{(\pm)},[K_1 H_1^{(\pm)},\hat{Y}_\mu]]}^{n=2}]
&= [K_1 H_1^{(\pm)},\ K_1^2\cdot 2^2\cdot(-1)\cdot\hat{Y}_\mu] \\
&= K_1^3\cdot 2^2\cdot(-1)\cdot[H_1^{(\pm)}, \hat{Y}_\mu] \\
&= K_1^3\cdot 2^2\cdot(-1)\cdot\left(-2\cdot(e^{-i\frac{2\pi\mu}{M}}\hat{Z}_\mu^{(\pm)})\right) \\
&= K_1^3\cdot 2^3\cdot(-1)^2\cdot e^{-i\frac{2\pi\mu}{M}}\hat{Z}_\mu^{(\pm)}
\end{aligned}`,
      ),
      paragraph(["(h2.z−) ", math(String.raw`n=1`), "："]),
      displayMath(
        String.raw`\begin{aligned}
[K_2^* H_2, \hat{Z}_\mu^{(-)}]
&= K_2^*[H_2, \hat{Z}_\mu^{(-)}] \\
&= K_2^*(-2\cdot\hat{Y}_\mu) \\
&= (K_2^*)^1\cdot 2^1\cdot(-1)^1\cdot\hat{Y}_\mu
\end{aligned}`,
      ),
      paragraph(["(h2.z−) ", math(String.raw`n=2`), "："]),
      displayMath(
        String.raw`\begin{aligned}
[K_2^* H_2, \overbrace{[K_2^* H_2,\hat{Z}_\mu^{(-)}]}^{n=1}]
&= [K_2^* H_2,\ (K_2^*)^1\cdot 2^1\cdot(-1)^1\cdot\hat{Y}_\mu] \\
&= (K_2^*)^2\cdot 2^1\cdot(-1)^1\cdot[H_2, \hat{Y}_\mu] \\
&= (K_2^*)^2\cdot 2^1\cdot(-1)^1\cdot(2\cdot\hat{Z}_\mu^{(-)}) \\
&= (K_2^*)^2\cdot 2^2\cdot(-1)^1\cdot\hat{Z}_\mu^{(-)}
\end{aligned}`,
      ),
      paragraph(["(h2.z−) ", math(String.raw`n=3`), "："]),
      displayMath(
        String.raw`\begin{aligned}
[K_2^* H_2, \overbrace{[K_2^* H_2,[K_2^* H_2,\hat{Z}_\mu^{(-)}]]}^{n=2}]
&= [K_2^* H_2,\ (K_2^*)^2\cdot 2^2\cdot(-1)^1\cdot\hat{Z}_\mu^{(-)}] \\
&= (K_2^*)^3\cdot 2^2\cdot(-1)^1\cdot[H_2, \hat{Z}_\mu^{(-)}] \\
&= (K_2^*)^3\cdot 2^2\cdot(-1)^1\cdot(-2\cdot\hat{Y}_\mu) \\
&= (K_2^*)^3\cdot 2^3\cdot(-1)^2\cdot\hat{Y}_\mu
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文の proof は「TODO : note 参考にして、帰納法で行ける」というアウトラインのみで、帰納法本体は未記述。忠実性のため todo を保持し status は converted とした。",
        "原文 note の n=0..4 具体例を block-level notes に忠実に翻訳。原文の (h2.z^+) は「これは使われない」というメモのみで式が無いため statement・notes とも省いた。原文 note の (h1.y) n=3 は exp の符号が n=1 と不整合（原文どおり再現）。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_003_claim_cosh_sinh_coefficient_conversion",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/002_claim_cosh_sinhの展開係数への変換.typ",
    sourceOrdinal: 3,
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
      paragraph(["(h2.z−)"]),
      displayMath(
        String.raw`\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\hat{Z}_\mu^{(-)}\right]\dots\right]}_{n}
= \begin{cases}
-i (2K_2^*)^n \hat{Y}_\mu & (n \text{ 奇数}) \\
(2K_2^*)^n \hat{Z}_\mu^{(-)} & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["（(h1.y), (h2.y) も同様）"]),
    ],
    proof: [
      paragraph([
        "(h1.z) について、",
        ref("nesting_of_commutator_of_H_and_Z"),
        " (h1.z) の生成子を ",
        math(String.raw`K_1 H_1^{(\pm)} \to \tfrac{i}{2}K_1 H_1^{(\pm)}`),
        " に置き換えて代入する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\hat{Z}_\mu^{(\pm)}\right]\dots\right]}_{n\text{ times}}
&= \begin{cases}
(-1)^{(n-1)/2}\cdot\left(2\cdot\tfrac{i}{2}K_1\right)^{n}\cdot e^{-i\frac{2\pi\mu}{M}}\cdot\hat{Y}_\mu & (n\text{ is odd}) \\
(-1)^{n/2}\cdot\left(2\cdot\tfrac{i}{2}K_1\right)^{n}\cdot\hat{Z}_\mu^{(\pm)} & (n\text{ is even})
\end{cases} \\
&= \begin{cases}
(-1)^{(n-1)/2}\cdot(i)^{n}\cdot K_1^{n}\cdot e^{-i\frac{2\pi\mu}{M}}\cdot\hat{Y}_\mu & (n\text{ is odd}) \\
(-1)^{n/2}\cdot(i)^{n}\cdot K_1^{n}\cdot\hat{Z}_\mu^{(\pm)} & (n\text{ is even})
\end{cases} \\
&= \begin{cases}
(-1)^{(n-1)/2}\cdot(-1)^{n/2}\cdot K_1^{n}\cdot e^{-i\frac{2\pi\mu}{M}}\cdot\hat{Y}_\mu & (n\text{ is odd}) \\
(-1)^{n/2}\cdot(-1)^{n/2}\cdot K_1^{n}\cdot\hat{Z}_\mu^{(\pm)} & (n\text{ is even})
\end{cases} \\
&= \begin{cases}
(-1)^{((n-1)/2 + n/2)}\cdot K_1^{n}\cdot e^{-i\frac{2\pi\mu}{M}}\cdot\hat{Y}_\mu & (n\text{ is odd}) \\
(-1)^{(n/2 + n/2)}\cdot K_1^{n}\cdot\hat{Z}_\mu^{(\pm)} & (n\text{ is even})
\end{cases} \\
&= \begin{cases}
(-1)^{((2n+2)/2 + 1/2)}\cdot K_1^{n}\cdot e^{-i\frac{2\pi\mu}{M}}\cdot\hat{Y}_\mu & (n\text{ is odd}) \\
(-1)^{(n/2 + n/2)}\cdot K_1^{n}\cdot\hat{Z}_\mu^{(\pm)} & (n\text{ is even})
\end{cases} \\
&= \begin{cases}
(-1)^{n+1}\cdot(-1)^{1/2}\cdot K_1^{n}\cdot e^{-i\frac{2\pi\mu}{M}}\cdot\hat{Y}_\mu & (n\text{ is odd}) \\
(-1)^{n}\cdot K_1^{n}\cdot\hat{Z}_\mu^{(\pm)} & (n\text{ is even})
\end{cases} \\
&= \begin{cases}
i\cdot K_1^{n}\cdot e^{-i\frac{2\pi\mu}{M}}\cdot\hat{Y}_\mu & (n\text{ is odd}) \\
K_1^{n}\cdot\hat{Z}_\mu^{(\pm)} & (n\text{ is even})
\end{cases}
\end{aligned}`,
      ),
      paragraph([
        "(h1.y), (h2.z−), (h2.y) も同様に ",
        ref("nesting_of_commutator_of_H_and_Z"),
        " の対応する生成子へのスケール置換で得られる。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文 proof の (h1.z) 代入計算を各ステップ忠実に翻訳。原文 proof は (h1.z) のみを扱い、(h1.y)/(h2.z−)/(h2.y) は statement で「同様」とされ本文計算は無い（原文どおり）。",
        "原文の指数簡約（虚数単位の n 乗 i^n を (-1)^{n/2} と書く、(n-1)/2+n/2 を (2n+2)/2+1/2 と書く等）はやや略式だが最終結果は正しい。原文どおり再現した。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_004_claim_sinh_cosh_taylor",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/003_claim_sinh_coshのテイラー展開.typ",
    sourceOrdinal: 4,
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
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/004_claim_テイラー係数の抽出.typ",
    sourceOrdinal: 5,
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
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}(\cdots)
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
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}(\cdots)
= i\sinh(2K_2^*)\hat{Z}_\mu^{(-)} + \cosh(2K_2^*)\hat{Y}_\mu`,
      ),
    ],
    proof: [
      paragraph([
        "以下、各級数を ",
        ref("cosh_sinh_coefficient_conversion"),
        " により偶数項・奇数項に分け、",
        ref("nesting_of_commutator_of_H_and_Z"),
        " 直後の sinh/cosh テイラー展開（下記 notes）を用いる。",
      ]),
      paragraph(["(h1.z) について、"]),
      displayMath(
        String.raw`\begin{aligned}
(\text{左辺})
&= \frac{1}{0!}\hat{Z}_\mu^{(\pm)}
   + \sum_{n=1}^{\infty}\frac{1}{n!}\begin{cases}
i\cdot K_1^{n}\cdot e^{-i\frac{2\pi\mu}{M}}\cdot\hat{Y}_\mu & (n\text{ is odd}) \\
K_1^{n}\cdot\hat{Z}_\mu^{(\pm)} & (n\text{ is even})
\end{cases} \\
&= \sum_{\substack{n\geq 0\\ n\text{ is even}}}\left(\frac{1}{n!}K_1^{n}\hat{Z}_\mu^{(\pm)}\right)
   + \sum_{\substack{n\geq 1\\ n\text{ is odd}}}\left(\frac{1}{n!}\,i\,K_1^{n}\,e^{-i\frac{2\pi\mu}{M}}\,\hat{Y}_\mu\right) \\
&= \left(\sum_{\substack{n\geq 0\\ n\text{ is even}}}\frac{1}{n!}K_1^{n}\right)\hat{Z}_\mu^{(\pm)}
   + i\,e^{-i\frac{2\pi\mu}{M}}\left(\sum_{\substack{n\geq 1\\ n\text{ is odd}}}\frac{1}{n!}K_1^{n}\right)\hat{Y}_\mu \\
&= \cosh(K_1)\hat{Z}_\mu^{(\pm)} + i\,e^{-i\frac{2\pi\mu}{M}}\sinh(K_1)\hat{Y}_\mu
\end{aligned}`,
      ),
      paragraph([
        "(h1.y) について（原文の proof は途中まで。かつ cases 内の項が statement と不整合。原文どおり再現）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\text{左辺})
&= \frac{1}{0!}\hat{Y}_\mu
   + \sum_{n=1}^{\infty}\frac{1}{n!}\begin{cases}
i\cdot K_1^{n}\cdot e^{i\frac{2\pi\mu}{M}}\cdot\hat{Y}_\mu & (n\text{ is odd}) \\
K_1^{n}\cdot\hat{Z}_\mu^{(\pm)} & (n\text{ is even})
\end{cases} \\
&= \sum_{\substack{n\geq 0\\ n\text{ is even}}}\left(\frac{1}{n!}K_1^{n}\hat{Z}_\mu^{(\pm)}\right)
   + \sum_{\substack{n\geq 1\\ n\text{ is odd}}}\left(\frac{1}{n!}\,i\,K_1^{n}\,e^{i\frac{2\pi\mu}{M}}\,\hat{Y}_\mu\right)
\end{aligned}`,
      ),
      paragraph([
        "(h2.z−) について（原文の proof は途中まで。cases 内で ",
        math(String.raw`(K_2^*)^{n}`),
        " と書かれ偶数項に ",
        math(String.raw`i`),
        " が残る等 statement と不整合。原文どおり再現）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\text{左辺})
&= \frac{1}{0!}\hat{Z}_\mu^{(-)}
   + \sum_{n=1}^{\infty}\frac{1}{n!}\begin{cases}
i\cdot (K_2^*)^{n}\cdot\hat{Z}_\mu^{(-)} & (n\text{ is even}) \\
i\cdot (K_2^*)^{n}\cdot\hat{Y}_\mu & (n\text{ is odd})
\end{cases} \\
&= \sum_{\substack{n\geq 0\\ n\text{ is even}}}\left(\frac{1}{n!}(K_2^*)^{n}\hat{Z}_\mu^{(-)}\right)
   + \sum_{\substack{n\geq 1\\ n\text{ is odd}}}\left(\frac{1}{n!}\,i\,(K_2^*)^{n}\,\hat{Y}_\mu\right)
\end{aligned}`,
      ),
    ],
    notes: [
      paragraph(["sinh, cosh のテイラー展開（原文 note）："]),
      displayMath(
        String.raw`\sinh x = x + \frac{1}{3!}x^3 + \frac{1}{5!}x^5 + \frac{1}{7!}x^7 + \cdots, \qquad
\cosh x = 1 + \frac{1}{2!}x^2 + \frac{1}{4!}x^4 + \frac{1}{6!}x^6 + \cdots`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文 proof の (h1.z) は完全（cosh/coshまで到達）。(h1.y) と (h2.z−) は原文 proof が偶奇分割の途中で終わっており、かつ cases 内の項・係数が statement と不整合（誤植）である。忠実性のため原文の未完・不整合状態をそのまま再現し、fix はしていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_006_claim_exp_conjugation",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/005_claim_exp_X_Y_exp_minus_X.typ",
    sourceOrdinal: 6,
    title: null,
    labels: ["exp_X_Y_exp_-X"],
    statement: [
      displayMath(
        String.raw`\exp(X)\,Y\,\exp(-X)
= \mathrm{Ad}_{\exp(X)}(Y)
= \exp(\mathrm{ad}_X)(Y)
= \sum_{n=0}^{\infty} \frac{1}{n!}
  \underbrace{[X,[X,\dots,[X,Y]\dots]]}_{n}`,
      ),
      paragraph([
        "（",
        math(String.raw`n=0`),
        " のとき括弧なしで ",
        math(String.raw`Y`),
        "）",
      ]),
    ],
    proof: [
      paragraph([
        "（暫定）リー群・リー環の掘り下げを避けて一旦受け入れる（",
        ref("brianhall_3.35"),
        " 参照）。行列級数の直接計算でも示せると思われる。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_007_definition_automorphism_groups",
    kind: "definition",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/006_definition_自己同型群_内部自己同型群_外部自己同型群.typ",
    sourceOrdinal: 7,
    title: { text: "自己同型群・内部自己同型群・外部自己同型群" },
    labels: [],
    statement: [
      paragraph(["群 ", math(String.raw`G`), " について、"]),
      displayMath(
        String.raw`\mathrm{Aut}(G) := \{\varphi \mid \varphi : G \to G,\; \varphi \text{ は群同型}\}`,
      ),
      paragraph(["を ", math(String.raw`G`), " の自己同型群という。"]),
      paragraph([
        math(String.raw`g \in G`),
        " について ",
        math(String.raw`\varphi_g : G \to G,\; h \mapsto ghg^{-1}`),
        " と定め、",
        math(String.raw`\varphi : G \to \mathrm{Aut}(G),\; g \mapsto \varphi_g`),
        " の像 ",
        math(String.raw`\mathrm{Im}(\varphi)`),
        " を内部自己同型群 ",
        math(String.raw`\mathrm{Inn}(G)`),
        " という。",
      ]),
      displayMath(
        String.raw`\mathrm{Out}(G) := \mathrm{Aut}(G)/\mathrm{Inn}(G) \quad \text{（外部自己同型群）}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_008_definition_exact_sequence_aut",
    kind: "definition",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/007_definition_自己同型群の完全列.typ",
    sourceOrdinal: 8,
    title: { text: "自己同型群の完全列" },
    labels: [],
    statement: [
      paragraph(["群 ", math(String.raw`G`), " について、"]),
      displayMath(
        String.raw`1 \to Z(G) \to G \to \mathrm{Aut}(G) \to \mathrm{Out}(G) \to 1`,
      ),
      paragraph(["は完全列をなす。"]),
      paragraph([todo("TODO: Ker, Im の定義、Z(G) の定義、完全列の定義")]),
    ],
    proof: [paragraph([todo("TODO")])],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_009_definition_ring_multiplicative_group",
    kind: "definition",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/008_definition_環の乗法群.typ",
    sourceOrdinal: 9,
    title: { text: "環の乗法群" },
    labels: [],
    statement: [
      paragraph(["環 ", math(String.raw`\mathbf{R} = (R, +_R, \cdot_R)`), " について、"]),
      displayMath(
        String.raw`\mathbf{R}^\times := \{r \in \mathbf{R} \mid r \text{ は } \cdot_R \text{ について可逆}\}`,
      ),
      paragraph([
        math(String.raw`\mathbf{R}^\times`),
        " は ",
        math(String.raw`\cdot_R`),
        " について群をなす。これを ",
        math(String.raw`\mathbf{R}`),
        " の乗法群という。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_010_definition_clifford_group",
    kind: "definition",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/009_definition_TODO_クリフォード群.typ",
    sourceOrdinal: 10,
    title: { text: "クリフォード群（TODO）" },
    labels: [],
    statement: [
      list([
        ["クリフォード群の定義（2×2 パウリ行列のテンソル積から構成）"],
        [math(String.raw`T_g`), " の定義をクリフォード群の元に限定する"],
        [
          math(String.raw`T`),
          " の（定数倍を除いた）単射性が重要と考えられるため示す",
        ],
      ]),
      paragraph([todo("TODO: 3つのアプローチを検討中")]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_011_definition_T_g",
    kind: "definition",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/010_definition_T_g.typ",
    sourceOrdinal: 11,
    title: { tex: String.raw`T_g \text{ の定義}` },
    labels: ["def_T_g"],
    statement: [
      paragraph([
        math(String.raw`g \in (\mathrm{Mat}(2,\mathbb{C})^{\otimes M})^\times`),
        " について、",
      ]),
      displayMath(
        String.raw`T_g : \mathrm{Mat}(2,\mathbb{C})^{\otimes M} \to \mathrm{Mat}(2,\mathbb{C})^{\otimes M}, \quad h \mapsto g \cdot h \cdot g^{-1}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_012_claim_TV1_TV2_actions",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/011_claim_ホロノミック量子場_p142下段.typ",
    sourceOrdinal: 12,
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
&= (V_1^{(\pm)})^{1/2}\cdot\hat{Z}_\mu^{(-)}\cdot(V_1^{(\pm)})^{-1/2} \\
&= \left(\exp(i K_1 H_1^{(\pm)})\right)^{1/2}\cdot\hat{Z}_\mu^{(-)}\cdot\left(\exp(i K_1 H_1^{(\pm)})\right)^{-1/2} \\
&= \exp\!\left(\tfrac{1}{2}i K_1 H_1^{(\pm)}\right)\cdot\hat{Z}_\mu^{(-)}\cdot\exp\!\left(-\left(\tfrac{1}{2}i K_1 H_1^{(\pm)}\right)\right) \\
&= \sum_{n=0}^{\infty}\frac{1}{n!}
   \underbrace{\left[\tfrac{1}{2}i K_1 H_1^{(\pm)},\dots,\left[\tfrac{1}{2}i K_1 H_1^{(\pm)},\hat{Z}_\mu^{(-)}\right]\dots\right]}_{n\text{ times}}
   \quad (\because \text{exp 共役の級数展開}) \\
&= \cosh(K_1)\hat{Z}_\mu^{(-)} + i\,e^{-i\frac{2\pi\mu}{M}}\sinh(K_1)\hat{Y}_\mu
   \quad (\because \text{テイラー係数の抽出}) \\
&= \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}\cosh(K_1) \\ i\,e^{-i\frac{2\pi\mu}{M}}\sinh(K_1)\end{pmatrix}
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`T_{(V_1^{(\pm)})^{1/2}}(\hat{Y}_\mu)`),
        " について、同様（原文 proof も「同様」）。結果は",
      ]),
      displayMath(
        String.raw`T_{(V_1^{(\pm)})^{1/2}}(\hat{Y}_\mu)
= -i\,e^{i\frac{2\pi\mu}{M}}\sinh(K_1)\hat{Z}_\mu^{(-)} + \cosh(K_1)\hat{Y}_\mu
= \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
  \begin{pmatrix}i\,e^{-i\frac{2\pi\mu}{M}}\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}`,
      ),
      paragraph([
        math(String.raw`T_{V_2}(\hat{Z}_\mu^{(-)})`),
        " について、",
        math(String.raw`(2s_2)^{M/2}`),
        " のスカラーは共役で打ち消し合う。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{V_2}(\hat{Z}_\mu^{(-)})
&= V_2\cdot\hat{Z}_\mu^{(-)}\cdot V_2^{-1} \\
&= \left((2s_2)^{M/2}\exp(i K_2^* H_2)\right)\cdot\hat{Z}_\mu^{(-)}\cdot\left((2s_2)^{M/2}\exp(-i K_2^* H_2)\right)^{-1} \\
&= (2s_2)^{M/2}\cdot\left((2s_2)^{M/2}\right)^{-1}\cdot
   \sum_{n=0}^{\infty}\frac{1}{n!}
   \underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\hat{Z}_\mu^{(-)}\right]\dots\right]}_{n\text{ times}}
   \quad (\because \text{exp 共役の級数展開}) \\
&= \cosh(2K_2^*)\hat{Z}_\mu^{(-)} - i\sinh(2K_2^*)\hat{Y}_\mu
   \quad (\because \text{テイラー係数の抽出}) \\
&= \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}\cosh(2K_2^*) \\ -i\sinh(2K_2^*)\end{pmatrix}
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`T_{V_2}(\hat{Y}_\mu)`),
        " について、同様（原文 proof も「同様」）。結果は",
      ]),
      displayMath(
        String.raw`T_{V_2}(\hat{Y}_\mu)
= i\sinh(2K_2^*)\hat{Z}_\mu^{(-)} + \cosh(2K_2^*)\hat{Y}_\mu
= \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
  \begin{pmatrix}i\sinh(2K_2^*) \\ \cosh(2K_2^*)\end{pmatrix}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文 proof を忠実に翻訳。原文の V1 分・V2 分の共役展開（exp の (1/2) スケール、(2s2)^{M/2} の相殺）と、原文 statement にある行列表示（行ベクトル×列ベクトル）を proof 内に取り込んだ。",
        "T_{(V1)^{1/2}}(hat(Y)) と T_{V2}(hat(Y)) は原文 proof が「同様」とのみ記す。原文 statement の hat(Y) 行列表示は scalar 表示と exp 符号が不整合（誤植）だが、ここでは statement と整合する scalar 形を採った。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_013_definition_product_maps",
    kind: "definition",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/012_definition_T_V1_T_V2の直積写像.typ",
    sourceOrdinal: 13,
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
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/013_claim_T_V1_T_V2のhatZ_hatYへの直積作用の計算.typ",
    sourceOrdinal: 14,
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
&= \left(T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)}),\ T_{(V_1^{(\pm)})^{1/2}}(\hat{Y}_\mu)\right) \\
&= \left(
   \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}\cosh(K_1) \\ i\,e^{-i\frac{2\pi\mu}{M}}\sinh(K_1)\end{pmatrix},\ \
   \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}-i\,e^{i\frac{2\pi\mu}{M}}\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}
   \right) \\
&= \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}
   \cosh(K_1) & -i\,e^{i\frac{2\pi\mu}{M}}\sinh(K_1) \\
   i\,e^{-i\frac{2\pi\mu}{M}}\sinh(K_1) & \cosh(K_1)
   \end{pmatrix}
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\left(T_{V_2} \times T_{V_2}\right)(\hat{Z}_\mu^{(-)}, \hat{Y}_\mu)
&= \left(T_{V_2}(\hat{Z}_\mu^{(-)}),\ T_{V_2}(\hat{Y}_\mu)\right) \\
&= \left(
   \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}\cosh(2K_2^*) \\ -i\sinh(2K_2^*)\end{pmatrix},\ \
   \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}i\sinh(2K_2^*) \\ \cosh(2K_2^*)\end{pmatrix}
   \right) \\
&= \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}
   \cosh(2K_2^*) & i\sinh(2K_2^*) \\
   -i\sinh(2K_2^*) & \cosh(2K_2^*)
   \end{pmatrix}
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
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/014_claim_T_Vの線型性.typ",
    sourceOrdinal: 15,
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
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/015_definition_T_V.typ",
    sourceOrdinal: 16,
    title: { tex: String.raw`T_{(V)} \text{ の定義}` },
    labels: ["def_T_V"],
    statement: [
      paragraph([
        math(String.raw`\forall X \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " について、",
      ]),
      displayMath(
        String.raw`T_{(V)}(X) := T_{(V_1^{(\pm)})^{1/2}}\!\left(T_{V_2}\!\left(T_{(V_1^{(\pm)})^{1/2}}(X)\right)\right)`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_017_definition_A_theta",
    kind: "definition",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/016_definition_A_theta.typ",
    sourceOrdinal: 17,
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
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/017_claim_T_VのhatZ_hatYへの作用.typ",
    sourceOrdinal: 18,
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
&= T_{(V_1^{(\pm)})^{1/2}}\!\left(T_{V_2}\!\left(T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)})\right)\right) \\
&= T_{(V_1^{(\pm)})^{1/2}}\!\left(T_{V_2}\!\left(\cosh(K_1)\hat{Z}_\mu^{(-)} + i e^{-i\theta_\mu}\sinh(K_1)\hat{Y}_\mu\right)\right) \\
&= T_{(V_1^{(\pm)})^{1/2}}\!\left(\left(T_{V_2}(\hat{Z}_\mu^{(-)}),\ T_{V_2}(\hat{Y}_\mu)\right)
   \begin{pmatrix}\cosh(K_1) \\ i e^{-i\theta_\mu}\sinh(K_1)\end{pmatrix}\right)
   \quad (\because T\text{ の線型性}) \\
&= T_{(V_1^{(\pm)})^{1/2}}\!\left((\hat{Z}_\mu^{(-)},\hat{Y}_\mu)\, B_2
   \begin{pmatrix}\cosh(K_1) \\ i e^{-i\theta_\mu}\sinh(K_1)\end{pmatrix}\right)
   \quad (\because \text{直積作用の計算}) \\
&= \left(T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)}),\ T_{(V_1^{(\pm)})^{1/2}}(\hat{Y}_\mu)\right) B_2
   \begin{pmatrix}\cosh(K_1) \\ i e^{-i\theta_\mu}\sinh(K_1)\end{pmatrix} \\
&= (\hat{Z}_\mu^{(-)},\hat{Y}_\mu)\, B_1(\theta_\mu)\, B_2
   \begin{pmatrix}\cosh(K_1) \\ i e^{-i\theta_\mu}\sinh(K_1)\end{pmatrix}
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
&= T_{(V_1^{(\pm)})^{1/2}}\!\left(T_{V_2}\!\left(T_{(V_1^{(\pm)})^{1/2}}(\hat{Y}_\mu)\right)\right) \\
&= T_{(V_1^{(\pm)})^{1/2}}\!\left(T_{V_2}\!\left(-i e^{i\theta_\mu}\sinh(K_1)\hat{Z}_\mu^{(-)} + \cosh(K_1)\hat{Y}_\mu\right)\right) \\
&= T_{(V_1^{(\pm)})^{1/2}}\!\left(\left(T_{V_2}(\hat{Z}_\mu^{(-)}),\ T_{V_2}(\hat{Y}_\mu)\right)
   \begin{pmatrix}-i e^{i\theta_\mu}\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}\right)
   \quad (\because T\text{ の線型性}) \\
&= T_{(V_1^{(\pm)})^{1/2}}\!\left((\hat{Z}_\mu^{(-)},\hat{Y}_\mu)\, B_2
   \begin{pmatrix}-i e^{i\theta_\mu}\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}\right)
   \quad (\because \text{直積作用の計算}) \\
&= (\hat{Z}_\mu^{(-)},\hat{Y}_\mu)\, B_1(\theta_\mu)\, B_2
   \begin{pmatrix}-i e^{i\theta_\mu}\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}
\end{aligned}`,
      ),
      paragraph([
        "よって、上記 2 列を並べると（2 つの列ベクトルはちょうど ",
        math(String.raw`B_1(\theta_\mu)`),
        " の 2 列）、",
      ]),
      displayMath(
        String.raw`\left(T_{(V)}(\hat{Z}_\mu^{(-)}),\ T_{(V)}(\hat{Y}_\mu)\right)
= (\hat{Z}_\mu^{(-)},\hat{Y}_\mu)\, B_1(\theta_\mu)\, B_2\, B_1(\theta_\mu)`,
      ),
      paragraph([
        "最後に ",
        math(String.raw`B_1(\theta_\mu)\, B_2\, B_1(\theta_\mu) = A(\theta_\mu)`),
        "（",
        ref("def_A_theta"),
        "）を用いると statement を得る：",
      ]),
      displayMath(
        String.raw`\left(T_{(V)}(\hat{Z}_\mu^{(-)}),\ T_{(V)}(\hat{Y}_\mu)\right)
= (\hat{Z}_\mu^{(-)},\hat{Y}_\mu)\, A(\theta_\mu)`,
      ),
      paragraph([todo("TODO: mathematica に計算させたらステートメントは正しいことはわかったので、一旦具体の計算は飛ばす (0426)")]),
      paragraph([
        "すなわち ",
        math(String.raw`B_1(\theta_\mu)\, B_2\, B_1(\theta_\mu) = A(\theta_\mu)`),
        " の具体的な行列積は原文では未計算（Mathematica による数値検証のみ）である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文 proof の (z)/(y) 各行列簡約と『よって』の合流までを忠実に翻訳。最終の B1·B2·B1 = A(θ_μ) の明示的行列積は原文が TODO（Mathematica で数値確認済みとして略）としているため、その旨を todo として保持し status は converted とした。",
        "原文の (z)/(y) 個別鎖では第1行列の (1,2)/(2,1) 成分を i e^{-iθ} 形（別表示）で書く箇所があり、原文『よって』段の B1（calc_of_TxT と整合する -i e^{iθ}, i e^{-iθ} 形）と内部で不整合。ここでは確立済みの B1（calc_of_TxT_hatZxhatY, 014）に統一して原文の最終結論を再現した。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_037_claim_factorization_A_theta",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/036_claim_A_thetaの行列分解.typ",
    sourceOrdinal: 37,
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
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/018_definition_theta_mu.typ",
    sourceOrdinal: 19,
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
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/019_definition_A_thetaの対角化の準備.typ",
    sourceOrdinal: 20,
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
