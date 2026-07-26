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
        " の反交換関係を用いる。",
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
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`\mu \in \mathcal{M}`),
        " とする。以下に現れる ",
        math(String.raw`H_1^{(\pm)}, H_2, \hat{Z}_\mu^{(\pm)}, \hat{Y}_\mu`),
        " はすべて結合代数 ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
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
        math(String.raw`X \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
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
        math(String.raw`\mathrm{ad}_X : \mathrm{Mat}(2,\mathbb{C})^{\otimes M} \to \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
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
\qquad (\alpha, \beta \in \mathbb{C},\ X, W \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M})`,
      ),
      paragraph([
        "のみを用いる（後者は ",
        math(String.raw`[\alpha X, \beta W] = (\alpha X)(\beta W) - (\beta W)(\alpha X) = \alpha\beta(XW - WX)`),
        " による。スカラー倍が積と可換なことは ",
        ref("scalar_identity_commutes"),
        " による）。",
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
        "、偶数）：0 重の交換子の規約より ",
        math(String.raw`C_0 = \hat{Z}_\mu^{(\pm)}`),
        " であり、主張の偶数側の右辺は ",
        math(String.raw`(-1)^{0/2}(2K_1)^0\hat{Z}_\mu^{(\pm)} = 1\cdot 1\cdot\hat{Z}_\mu^{(\pm)} = \hat{Z}_\mu^{(\pm)}`),
        " で一致する。",
      ]),
      paragraph([
        "帰納段階 1（",
        math(String.raw`n`),
        " 偶数 → ",
        math(String.raw`n+1`),
        " 奇数）：",
        math(String.raw`n`),
        " が偶数で ",
        math(String.raw`C_n = (-1)^{n/2}(2K_1)^n\hat{Z}_\mu^{(\pm)}`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
C_{n+1}
&= \left[K_1 H_1^{(\pm)},\ (-1)^{n/2}(2K_1)^n\hat{Z}_\mu^{(\pm)}\right] \\
&= K_1\cdot(-1)^{n/2}(2K_1)^n\left[H_1^{(\pm)},\ \hat{Z}_\mu^{(\pm)}\right]
   \quad (\because \text{交換子の双線型性}) \\
&= K_1\cdot(-1)^{n/2}(2K_1)^n\cdot 2 e^{-i\theta}\hat{Y}_\mu
   \quad (\because \text{(A)}) \\
&= (-1)^{n/2}(2K_1)^{n+1} e^{-i\theta}\hat{Y}_\mu
\end{aligned}`,
      ),
      paragraph([
        "一方、",
        math(String.raw`n+1`),
        " は奇数なので主張の奇数側の右辺は ",
        math(String.raw`(-1)^{((n+1)-1)/2}(2K_1)^{n+1}e^{-i\theta}\hat{Y}_\mu = (-1)^{n/2}(2K_1)^{n+1}e^{-i\theta}\hat{Y}_\mu`),
        " であり、係数 ",
        math(String.raw`(2K_1)^{n+1}`),
        "、符号 ",
        math(String.raw`(-1)^{n/2}`),
        "、位相因子 ",
        math(String.raw`e^{-i\theta}`),
        " のすべてが一致する。",
      ]),
      paragraph([
        "帰納段階 2（",
        math(String.raw`n`),
        " 奇数 → ",
        math(String.raw`n+1`),
        " 偶数）：",
        math(String.raw`n`),
        " が奇数で ",
        math(String.raw`C_n = (-1)^{(n-1)/2}(2K_1)^n e^{-i\theta}\hat{Y}_\mu`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
C_{n+1}
&= \left[K_1 H_1^{(\pm)},\ (-1)^{(n-1)/2}(2K_1)^n e^{-i\theta}\hat{Y}_\mu\right] \\
&= K_1\cdot(-1)^{(n-1)/2}(2K_1)^n e^{-i\theta}\left[H_1^{(\pm)},\ \hat{Y}_\mu\right]
   \quad (\because \text{交換子の双線型性}) \\
&= K_1\cdot(-1)^{(n-1)/2}(2K_1)^n e^{-i\theta}\cdot\left(-2 e^{i\theta}\hat{Z}_\mu^{(\pm)}\right)
   \quad (\because \text{(B)}) \\
&= (-1)\cdot(-1)^{(n-1)/2}(2K_1)^{n+1}\,\overbrace{e^{-i\theta}e^{i\theta}}^{=\,1}\,\hat{Z}_\mu^{(\pm)} \\
&= (-1)^{(n-1)/2+1}(2K_1)^{n+1}\hat{Z}_\mu^{(\pm)} \\
&= (-1)^{(n+1)/2}(2K_1)^{n+1}\hat{Z}_\mu^{(\pm)}
\end{aligned}`,
      ),
      paragraph([
        "最後の等号は ",
        math(String.raw`\dfrac{n-1}{2}+1 = \dfrac{n+1}{2}`),
        " による。",
        math(String.raw`n+1`),
        " は偶数なので主張の偶数側の右辺 ",
        math(String.raw`(-1)^{(n+1)/2}(2K_1)^{n+1}\hat{Z}_\mu^{(\pm)}`),
        " と一致する（位相因子は ",
        math(String.raw`e^{-i\theta}e^{i\theta}=1`),
        " により消える）。以上 2 つの帰納段階と基底段階により、すべての ",
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
        "、偶数）：",
        math(String.raw`D_0 = \hat{Y}_\mu`),
        " であり、偶数側の右辺は ",
        math(String.raw`(-1)^{0}(2K_1)^0\hat{Y}_\mu = \hat{Y}_\mu`),
        " で一致する。",
      ]),
      paragraph([
        "帰納段階 1（",
        math(String.raw`n`),
        " 偶数 → ",
        math(String.raw`n+1`),
        " 奇数）：",
        math(String.raw`D_n = (-1)^{n/2}(2K_1)^n\hat{Y}_\mu`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
D_{n+1}
&= \left[K_1 H_1^{(\pm)},\ (-1)^{n/2}(2K_1)^n\hat{Y}_\mu\right] \\
&= K_1\cdot(-1)^{n/2}(2K_1)^n\left[H_1^{(\pm)},\ \hat{Y}_\mu\right]
   \quad (\because \text{交換子の双線型性}) \\
&= K_1\cdot(-1)^{n/2}(2K_1)^n\cdot\left(-2 e^{i\theta}\hat{Z}_\mu^{(\pm)}\right)
   \quad (\because \text{(B)}) \\
&= (-1)^{n/2+1}(2K_1)^{n+1} e^{i\theta}\hat{Z}_\mu^{(\pm)}
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`n+1`),
        " は奇数で、主張の奇数側の右辺の符号は ",
        math(String.raw`(-1)^{((n+1)+1)/2} = (-1)^{n/2+1}`),
        " であり一致する。係数 ",
        math(String.raw`(2K_1)^{n+1}`),
        " と位相因子 ",
        math(String.raw`e^{i\theta}`),
        " も一致する。",
      ]),
      paragraph([
        "帰納段階 2（",
        math(String.raw`n`),
        " 奇数 → ",
        math(String.raw`n+1`),
        " 偶数）：",
        math(String.raw`D_n = (-1)^{(n+1)/2}(2K_1)^n e^{i\theta}\hat{Z}_\mu^{(\pm)}`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
D_{n+1}
&= \left[K_1 H_1^{(\pm)},\ (-1)^{(n+1)/2}(2K_1)^n e^{i\theta}\hat{Z}_\mu^{(\pm)}\right] \\
&= K_1\cdot(-1)^{(n+1)/2}(2K_1)^n e^{i\theta}\left[H_1^{(\pm)},\ \hat{Z}_\mu^{(\pm)}\right]
   \quad (\because \text{交換子の双線型性}) \\
&= K_1\cdot(-1)^{(n+1)/2}(2K_1)^n e^{i\theta}\cdot 2 e^{-i\theta}\hat{Y}_\mu
   \quad (\because \text{(A)}) \\
&= (-1)^{(n+1)/2}(2K_1)^{n+1}\,\overbrace{e^{i\theta}e^{-i\theta}}^{=\,1}\,\hat{Y}_\mu \\
&= (-1)^{(n+1)/2}(2K_1)^{n+1}\hat{Y}_\mu
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`n+1`),
        " は偶数で、主張の偶数側の右辺の符号は ",
        math(String.raw`(-1)^{(n+1)/2}`),
        " であり一致する。以上により (h1.y) がすべての ",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について成り立つ。",
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
        "、偶数）：",
        math(String.raw`E_0 = \hat{Z}_\mu^{(-)}`),
        " であり、偶数側の右辺は ",
        math(String.raw`(-1)^{0}(2K_2^*)^0\hat{Z}_\mu^{(-)} = \hat{Z}_\mu^{(-)}`),
        " で一致する。",
      ]),
      paragraph([
        "帰納段階 1（",
        math(String.raw`n`),
        " 偶数 → ",
        math(String.raw`n+1`),
        " 奇数）：",
        math(String.raw`E_n = (-1)^{n/2}(2K_2^*)^n\hat{Z}_\mu^{(-)}`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E_{n+1}
&= \left[K_2^* H_2,\ (-1)^{n/2}(2K_2^*)^n\hat{Z}_\mu^{(-)}\right] \\
&= K_2^*\cdot(-1)^{n/2}(2K_2^*)^n\left[H_2,\ \hat{Z}_\mu^{(-)}\right]
   \quad (\because \text{交換子の双線型性}) \\
&= K_2^*\cdot(-1)^{n/2}(2K_2^*)^n\cdot\left(-2\,\hat{Y}_\mu\right)
   \quad (\because \text{(C)}) \\
&= (-1)^{n/2+1}(2K_2^*)^{n+1}\hat{Y}_\mu
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`n+1`),
        " は奇数で、奇数側の右辺の符号は ",
        math(String.raw`(-1)^{((n+1)+1)/2} = (-1)^{n/2+1}`),
        " であり一致する。",
      ]),
      paragraph([
        "帰納段階 2（",
        math(String.raw`n`),
        " 奇数 → ",
        math(String.raw`n+1`),
        " 偶数）：",
        math(String.raw`E_n = (-1)^{(n+1)/2}(2K_2^*)^n\hat{Y}_\mu`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E_{n+1}
&= \left[K_2^* H_2,\ (-1)^{(n+1)/2}(2K_2^*)^n\hat{Y}_\mu\right] \\
&= K_2^*\cdot(-1)^{(n+1)/2}(2K_2^*)^n\left[H_2,\ \hat{Y}_\mu\right]
   \quad (\because \text{交換子の双線型性}) \\
&= K_2^*\cdot(-1)^{(n+1)/2}(2K_2^*)^n\cdot 2\,\hat{Z}_\mu^{(-)}
   \quad (\because \text{(D)}) \\
&= (-1)^{(n+1)/2}(2K_2^*)^{n+1}\hat{Z}_\mu^{(-)}
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`n+1`),
        " は偶数で、偶数側の右辺の符号は ",
        math(String.raw`(-1)^{(n+1)/2}`),
        " であり一致する。以上により (h2.z−) が成り立つ。",
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
        "、偶数）：",
        math(String.raw`F_0 = \hat{Y}_\mu`),
        " であり、偶数側の右辺は ",
        math(String.raw`(-1)^{0}(2K_2^*)^0\hat{Y}_\mu = \hat{Y}_\mu`),
        " で一致する。",
      ]),
      paragraph([
        "帰納段階 1（",
        math(String.raw`n`),
        " 偶数 → ",
        math(String.raw`n+1`),
        " 奇数）：",
        math(String.raw`F_n = (-1)^{n/2}(2K_2^*)^n\hat{Y}_\mu`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
F_{n+1}
&= \left[K_2^* H_2,\ (-1)^{n/2}(2K_2^*)^n\hat{Y}_\mu\right] \\
&= K_2^*\cdot(-1)^{n/2}(2K_2^*)^n\left[H_2,\ \hat{Y}_\mu\right]
   \quad (\because \text{交換子の双線型性}) \\
&= K_2^*\cdot(-1)^{n/2}(2K_2^*)^n\cdot 2\,\hat{Z}_\mu^{(-)}
   \quad (\because \text{(D)}) \\
&= (-1)^{n/2}(2K_2^*)^{n+1}\hat{Z}_\mu^{(-)}
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`n+1`),
        " は奇数で、奇数側の右辺の符号は ",
        math(String.raw`(-1)^{((n+1)-1)/2} = (-1)^{n/2}`),
        " であり一致する。",
      ]),
      paragraph([
        "帰納段階 2（",
        math(String.raw`n`),
        " 奇数 → ",
        math(String.raw`n+1`),
        " 偶数）：",
        math(String.raw`F_n = (-1)^{(n-1)/2}(2K_2^*)^n\hat{Z}_\mu^{(-)}`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
F_{n+1}
&= \left[K_2^* H_2,\ (-1)^{(n-1)/2}(2K_2^*)^n\hat{Z}_\mu^{(-)}\right] \\
&= K_2^*\cdot(-1)^{(n-1)/2}(2K_2^*)^n\left[H_2,\ \hat{Z}_\mu^{(-)}\right]
   \quad (\because \text{交換子の双線型性}) \\
&= K_2^*\cdot(-1)^{(n-1)/2}(2K_2^*)^n\cdot\left(-2\,\hat{Y}_\mu\right)
   \quad (\because \text{(C)}) \\
&= (-1)^{(n-1)/2+1}(2K_2^*)^{n+1}\hat{Y}_\mu \\
&= (-1)^{(n+1)/2}(2K_2^*)^{n+1}\hat{Y}_\mu
\end{aligned}`,
      ),
      paragraph([
        "最後の等号は ",
        math(String.raw`\dfrac{n-1}{2}+1 = \dfrac{n+1}{2}`),
        " による。",
        math(String.raw`n+1`),
        " は偶数で、偶数側の右辺の符号 ",
        math(String.raw`(-1)^{(n+1)/2}`),
        " と一致する。以上により (h2.y) が成り立つ。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文の proof は「TODO : note 参考にして、帰納法で行ける」というアウトラインのみで帰納法本体は未記述だった。4 式それぞれについて n に関する帰納法（基底 n=0 と、偶数 n→奇数 n+1 / 奇数 n→偶数 n+1 の 2 つの帰納段階）を人手で書き下し、todo を除去した。",
        "原文 note の n=0..4 具体例を block-level notes に忠実に翻訳。原文の (h2.z^+) は「これは使われない」というメモのみで式が無いため statement・notes とも省いた。原文 note の (h1.y) n=3 は exp の符号が n=1 と不整合（原文どおり再現）。帰納法の証明は note の具体例ではなく commutator_of_H_and_Z_Y の 1 重公式から直接構成した。",
        "原文 statement の (h1.y) 奇数側は hat(Z)_mu^{(+)} と書かれているが、用いる 1 重公式 [H_1^{(±)}, hat(Y)_mu] = -2 e^{iθ} hat(Z)_mu^{(±)} は H_1 と同符号の hat(Z) を返すため、構造化側では hat(Z)_mu^{(±)} とした（移行時点からの表記であり、本作業で変更していない）。",
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
        " 直後の sinh/cosh テイラー展開を用いる。",
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
        String.raw`\exp(X)\,Y\,\exp(-X)
= \sum_{m=0}^{\infty}\frac{1}{m!}\,\mathrm{ad}_X^{m}(Y)
= \exp\!\left(\mathrm{ad}_X\right)(Y)`,
      ),
      paragraph([
        "Step 2: ",
        ref("ad_binomial"),
        " の再帰の定義 ",
        math(String.raw`\mathrm{ad}_X^{0}(Y)=Y`),
        "、",
        math(String.raw`\mathrm{ad}_X^{m+1}(Y)=[X,\mathrm{ad}_X^{m}(Y)]`),
        " より、",
        math(String.raw`m\in\mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`\mathrm{ad}_X^{m}(Y)=\underbrace{[X,[X,\dots,[X,Y]\dots]]}_{m}`),
        "（",
        math(String.raw`m=0`),
        " のときは ",
        math(String.raw`Y`),
        "）であるから、Step 1 の中辺は主張の最右辺に一致する。",
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
        String.raw`\mathrm{Ad}_{\exp(X)}(Y)=\exp(X)\,Y\,\exp(X)^{-1}=\exp(X)\,Y\,\exp(-X)`,
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
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_007_definition_automorphism_groups",
    kind: "definition",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/006_definition_自己同型群_内部自己同型群_外部自己同型群.typ",
    sourceOrdinal: 7,
    title: { text: "自己同型群・内部自己同型群・外部自己同型群" },
    labels: ["def_aut_inn_out"],
    statement: [
      paragraph(["群 ", math(String.raw`G`), " について、"]),
      displayMath(
        String.raw`\mathrm{Aut}(G) := \{\varphi \mid \varphi : G \to G,\; \varphi \text{ は群同型}\}`,
      ),
      paragraph([
        "を ",
        math(String.raw`G`),
        " の自己同型群という。ここで「",
        math(String.raw`\varphi`),
        " は群同型」とは、",
        math(String.raw`\varphi`),
        " が全単射かつ ",
        math(String.raw`\forall h_1, h_2 \in G,\ \varphi(h_1 h_2) = \varphi(h_1)\varphi(h_2)`),
        " を満たすことをいう。",
        math(String.raw`\mathrm{Aut}(G)`),
        " は写像の合成 ",
        math(String.raw`\circ`),
        " について群をなす：合成は結合的、",
        math(String.raw`\mathrm{id}_G \in \mathrm{Aut}(G)`),
        " が単位元、",
        math(String.raw`\varphi \in \mathrm{Aut}(G)`),
        " の逆写像 ",
        math(String.raw`\varphi^{-1}`),
        " も全単射で ",
        math(String.raw`\varphi^{-1}(h_1 h_2) = \varphi^{-1}(h_1)\varphi^{-1}(h_2)`),
        "（",
        math(String.raw`\varphi`),
        " を両辺に施すと ",
        math(String.raw`h_1h_2 = h_1h_2`),
        " に帰着）なので ",
        math(String.raw`\varphi^{-1} \in \mathrm{Aut}(G)`),
        " が逆元、また ",
        math(String.raw`\varphi_1, \varphi_2 \in \mathrm{Aut}(G)`),
        " について ",
        math(String.raw`\varphi_1\circ\varphi_2`),
        " も全単射かつ準同型なので ",
        math(String.raw`\circ`),
        " は ",
        math(String.raw`\mathrm{Aut}(G)`),
        " 上の演算になる。",
      ]),
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
      paragraph([
        "この商が群として定義できること（",
        math(String.raw`\mathrm{Inn}(G) \trianglelefteq \mathrm{Aut}(G)`),
        "、すなわち ",
        math(String.raw`\mathrm{Inn}(G)`),
        " が ",
        math(String.raw`\mathrm{Aut}(G)`),
        " の正規部分群であること）は ",
        ref("inn_is_normal_in_aut"),
        " による。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文は Aut(G) の群構造・Inn(G) の正規性に触れていないが、Out(G) := Aut(G)/Inn(G) が群として定義できるために必要なので statement へ書き足した（正しさに必要ならそれは注記ではない）。正規性の証明は inn_is_normal_in_aut に置いた。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_007a_definition_group_hom_ker_im",
    kind: "definition",
    sourcePath: "structured-latex/content/008_TV1_hatZ_hatY_part1.mjs",
    sourceOrdinal: 7,
    title: { text: "群準同型・核・像" },
    labels: ["def_group_hom_ker_im"],
    statement: [
      paragraph([
        "群 ",
        math(String.raw`G, H`),
        " について、写像 ",
        math(String.raw`f : G \to H`),
        " が",
      ]),
      displayMath(
        String.raw`\forall g_1, g_2 \in G,\quad f(g_1 g_2) = f(g_1) f(g_2)`,
      ),
      paragraph([
        "を満たすとき ",
        math(String.raw`f`),
        " を群準同型という。このとき ",
        math(String.raw`e_G \in G`),
        "、",
        math(String.raw`e_H \in H`),
        " をそれぞれの単位元として ",
        math(String.raw`f(e_G) = e_H`),
        " および ",
        math(String.raw`\forall g \in G,\ f(g^{-1}) = f(g)^{-1}`),
        " が成り立つ（前者は ",
        math(String.raw`f(e_G) = f(e_Ge_G) = f(e_G)f(e_G)`),
        " の両辺に ",
        math(String.raw`f(e_G)^{-1}`),
        " を掛けて得られ、後者は ",
        math(String.raw`f(g)f(g^{-1}) = f(gg^{-1}) = f(e_G) = e_H`),
        " による）。",
      ]),
      paragraph([
        "群準同型 ",
        math(String.raw`f : G \to H`),
        " について、",
      ]),
      displayMath(
        String.raw`\mathrm{Ker}(f) := \{g \in G \mid f(g) = e_H\} \subseteq G,
\qquad
\mathrm{Im}(f) := \{f(g) \mid g \in G\} \subseteq H`,
      ),
      paragraph([
        "をそれぞれ ",
        math(String.raw`f`),
        " の核・像という。",
        math(String.raw`\mathrm{Ker}(f)`),
        " は ",
        math(String.raw`G`),
        " の正規部分群であり、",
        math(String.raw`\mathrm{Im}(f)`),
        " は ",
        math(String.raw`H`),
        " の部分群である。",
      ]),
      paragraph([
        "また ",
        math(String.raw`f`),
        " が単射であることと ",
        math(String.raw`\mathrm{Ker}(f) = \{e_G\}`),
        " であることは同値である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\mathrm{Ker}(f)`),
        " が部分群であること：",
        math(String.raw`f(e_G) = e_H`),
        " より ",
        math(String.raw`e_G \in \mathrm{Ker}(f)`),
        "。",
        math(String.raw`g_1, g_2 \in \mathrm{Ker}(f)`),
        " なら ",
        math(String.raw`f(g_1g_2) = f(g_1)f(g_2) = e_He_H = e_H`),
        " より ",
        math(String.raw`g_1g_2 \in \mathrm{Ker}(f)`),
        "。",
        math(String.raw`g \in \mathrm{Ker}(f)`),
        " なら ",
        math(String.raw`f(g^{-1}) = f(g)^{-1} = e_H^{-1} = e_H`),
        " より ",
        math(String.raw`g^{-1} \in \mathrm{Ker}(f)`),
        "。",
      ]),
      paragraph([
        math(String.raw`\mathrm{Ker}(f)`),
        " が正規であること：",
        math(String.raw`g \in G`),
        "、",
        math(String.raw`k \in \mathrm{Ker}(f)`),
        " について",
      ]),
      displayMath(
        String.raw`f(gkg^{-1}) = f(g)f(k)f(g^{-1}) = f(g)\,e_H\,f(g)^{-1} = f(g)f(g)^{-1} = e_H`,
      ),
      paragraph([
        "より ",
        math(String.raw`gkg^{-1} \in \mathrm{Ker}(f)`),
        "、すなわち ",
        math(String.raw`g\,\mathrm{Ker}(f)\,g^{-1} \subseteq \mathrm{Ker}(f)`),
        "。これが任意の ",
        math(String.raw`g`),
        " について成り立つので ",
        math(String.raw`g^{-1}`),
        " に適用して ",
        math(String.raw`g^{-1}\mathrm{Ker}(f)g \subseteq \mathrm{Ker}(f)`),
        " すなわち ",
        math(String.raw`\mathrm{Ker}(f) \subseteq g\,\mathrm{Ker}(f)\,g^{-1}`),
        " も得られ、",
        math(String.raw`g\,\mathrm{Ker}(f)\,g^{-1} = \mathrm{Ker}(f)`),
        "。",
      ]),
      paragraph([
        math(String.raw`\mathrm{Im}(f)`),
        " が部分群であること：",
        math(String.raw`e_H = f(e_G) \in \mathrm{Im}(f)`),
        "、",
        math(String.raw`f(g_1)f(g_2) = f(g_1g_2) \in \mathrm{Im}(f)`),
        "、",
        math(String.raw`f(g)^{-1} = f(g^{-1}) \in \mathrm{Im}(f)`),
        "。",
      ]),
      paragraph([
        "単射性との同値：",
        math(String.raw`f`),
        " が単射なら、",
        math(String.raw`g \in \mathrm{Ker}(f)`),
        " について ",
        math(String.raw`f(g) = e_H = f(e_G)`),
        " より ",
        math(String.raw`g = e_G`),
        "。逆に ",
        math(String.raw`\mathrm{Ker}(f) = \{e_G\}`),
        " のとき ",
        math(String.raw`f(g_1) = f(g_2)`),
        " なら ",
        math(String.raw`f(g_1g_2^{-1}) = f(g_1)f(g_2)^{-1} = e_H`),
        " より ",
        math(String.raw`g_1g_2^{-1} \in \mathrm{Ker}(f) = \{e_G\}`),
        "、よって ",
        math(String.raw`g_1 = g_2`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（parts/008/007）は「TODO: Ker, Im の定義」とのみ書いて定義を欠いていたため、完全列の主張に必要な定義と基本性質を新規に書き起こした。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_007b_definition_center_of_group",
    kind: "definition",
    sourcePath: "structured-latex/content/008_TV1_hatZ_hatY_part1.mjs",
    sourceOrdinal: 7,
    title: { text: "群の中心" },
    labels: ["def_center_of_group"],
    statement: [
      paragraph(["群 ", math(String.raw`G`), " について、"]),
      displayMath(
        String.raw`Z(G) := \{g \in G \mid \forall h \in G,\ gh = hg\} \subseteq G`,
      ),
      paragraph([
        "を ",
        math(String.raw`G`),
        " の中心という。",
        math(String.raw`Z(G)`),
        " は ",
        math(String.raw`G`),
        " の正規部分群である。",
      ]),
    ],
    proof: [
      paragraph([
        "部分群であること：",
        math(String.raw`e_G h = h = h e_G`),
        " より ",
        math(String.raw`e_G \in Z(G)`),
        "。",
        math(String.raw`g_1, g_2 \in Z(G)`),
        " について ",
        math(String.raw`(g_1g_2)h = g_1(g_2h) = g_1(hg_2) = (g_1h)g_2 = (hg_1)g_2 = h(g_1g_2)`),
        " より ",
        math(String.raw`g_1g_2 \in Z(G)`),
        "。",
        math(String.raw`g \in Z(G)`),
        " について ",
        math(String.raw`gh = hg`),
        " の両辺に左右から ",
        math(String.raw`g^{-1}`),
        " を掛けて ",
        math(String.raw`hg^{-1} = g^{-1}h`),
        " を得るので ",
        math(String.raw`g^{-1} \in Z(G)`),
        "。",
      ]),
      paragraph([
        "正規であること：",
        math(String.raw`g \in Z(G)`),
        "、",
        math(String.raw`h \in G`),
        " について ",
        math(String.raw`hgh^{-1} = ghh^{-1} = g \in Z(G)`),
        "。よって ",
        math(String.raw`hZ(G)h^{-1} = Z(G)`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（parts/008/007）は「TODO: Z(G) の定義」とのみ書いていたため新規に書き起こした。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_007c_claim_inn_normal_in_aut",
    kind: "claim",
    sourcePath: "structured-latex/content/008_TV1_hatZ_hatY_part1.mjs",
    sourceOrdinal: 7,
    title: { tex: String.raw`\mathrm{Inn}(G) \trianglelefteq \mathrm{Aut}(G)` },
    labels: ["inn_is_normal_in_aut"],
    statement: [
      paragraph([
        "群 ",
        math(String.raw`G`),
        " について、",
        ref("def_aut_inn_out"),
        " の ",
        math(String.raw`\varphi_g : G \to G,\ h \mapsto ghg^{-1}`),
        " と ",
        math(String.raw`\varphi : G \to \mathrm{Aut}(G),\ g \mapsto \varphi_g`),
        " について次が成り立つ。",
      ]),
      list([
        [
          "(i) 各 ",
          math(String.raw`g \in G`),
          " について ",
          math(String.raw`\varphi_g \in \mathrm{Aut}(G)`),
          "（すなわち ",
          math(String.raw`\varphi`),
          " は ",
          math(String.raw`\mathrm{Aut}(G)`),
          " へ値をとる）。",
        ],
        [
          "(ii) ",
          math(String.raw`\varphi`),
          " は群準同型である。したがって ",
          math(String.raw`\mathrm{Inn}(G) = \mathrm{Im}(\varphi)`),
          " は ",
          math(String.raw`\mathrm{Aut}(G)`),
          " の部分群である。",
        ],
        [
          "(iii) ",
          math(String.raw`\forall \psi \in \mathrm{Aut}(G),\ \forall g \in G,\quad \psi\circ\varphi_g\circ\psi^{-1} = \varphi_{\psi(g)}`),
          "。したがって ",
          math(String.raw`\mathrm{Inn}(G) \trianglelefteq \mathrm{Aut}(G)`),
          " であり、商群 ",
          math(String.raw`\mathrm{Out}(G) = \mathrm{Aut}(G)/\mathrm{Inn}(G)`),
          " が定義できる。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(i) ",
        math(String.raw`\varphi_g`),
        " が準同型であること：",
        math(String.raw`h_1, h_2 \in G`),
        " について",
      ]),
      displayMath(
        String.raw`\varphi_g(h_1 h_2) = g h_1 h_2 g^{-1}
= g h_1 \left(g^{-1} g\right) h_2 g^{-1}
= \left(g h_1 g^{-1}\right)\left(g h_2 g^{-1}\right)
= \varphi_g(h_1)\,\varphi_g(h_2)`,
      ),
      paragraph([
        "全単射であること：",
        math(String.raw`\varphi_{g^{-1}}(\varphi_g(h)) = g^{-1}(ghg^{-1})g = h`),
        " および ",
        math(String.raw`\varphi_g(\varphi_{g^{-1}}(h)) = g(g^{-1}hg)g^{-1} = h`),
        " より ",
        math(String.raw`\varphi_{g^{-1}}`),
        " が ",
        math(String.raw`\varphi_g`),
        " の逆写像であり、逆写像をもつ写像は全単射である。よって ",
        math(String.raw`\varphi_g \in \mathrm{Aut}(G)`),
        "。",
      ]),
      paragraph([
        "(ii) ",
        math(String.raw`g_1, g_2 \in G`),
        " と任意の ",
        math(String.raw`h \in G`),
        " について",
      ]),
      displayMath(
        String.raw`\varphi_{g_1 g_2}(h) = (g_1g_2)h(g_1g_2)^{-1}
= g_1 g_2 h g_2^{-1} g_1^{-1}
= g_1\left(\varphi_{g_2}(h)\right)g_1^{-1}
= \varphi_{g_1}\!\left(\varphi_{g_2}(h)\right)
= \left(\varphi_{g_1}\circ\varphi_{g_2}\right)(h)`,
      ),
      paragraph([
        "（2 番目の等号で ",
        math(String.raw`(g_1g_2)^{-1} = g_2^{-1}g_1^{-1}`),
        " を用いた。）",
        math(String.raw`h`),
        " は任意なので ",
        math(String.raw`\varphi(g_1g_2) = \varphi_{g_1g_2} = \varphi_{g_1}\circ\varphi_{g_2} = \varphi(g_1)\circ\varphi(g_2)`),
        "、すなわち ",
        math(String.raw`\varphi`),
        " は群準同型である。",
        ref("def_group_hom_ker_im"),
        " より ",
        math(String.raw`\mathrm{Im}(\varphi) = \mathrm{Inn}(G)`),
        " は ",
        math(String.raw`\mathrm{Aut}(G)`),
        " の部分群である。",
      ]),
      paragraph([
        "(iii) ",
        math(String.raw`\psi \in \mathrm{Aut}(G)`),
        "、",
        math(String.raw`g \in G`),
        "、任意の ",
        math(String.raw`h \in G`),
        " について、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\psi\circ\varphi_g\circ\psi^{-1}\right)(h)
&= \psi\!\left(\varphi_g\!\left(\psi^{-1}(h)\right)\right) \\
&= \psi\!\left(g\,\psi^{-1}(h)\,g^{-1}\right) \\
&= \psi(g)\,\psi\!\left(\psi^{-1}(h)\right)\,\psi\!\left(g^{-1}\right)
   \quad (\because \psi \text{ は準同型}) \\
&= \psi(g)\,h\,\psi(g)^{-1}
   \quad (\because \psi\circ\psi^{-1} = \mathrm{id}_G,\ \psi(g^{-1}) = \psi(g)^{-1}) \\
&= \varphi_{\psi(g)}(h)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`h`),
        " は任意なので ",
        math(String.raw`\psi\circ\varphi_g\circ\psi^{-1} = \varphi_{\psi(g)} \in \mathrm{Inn}(G)`),
        "。よって ",
        math(String.raw`\psi\,\mathrm{Inn}(G)\,\psi^{-1} \subseteq \mathrm{Inn}(G)`),
        " が任意の ",
        math(String.raw`\psi \in \mathrm{Aut}(G)`),
        " について成り立ち、",
        math(String.raw`\psi^{-1} \in \mathrm{Aut}(G)`),
        " へ適用して逆向きの包含も得られるので ",
        math(String.raw`\psi\,\mathrm{Inn}(G)\,\psi^{-1} = \mathrm{Inn}(G)`),
        "、すなわち ",
        math(String.raw`\mathrm{Inn}(G) \trianglelefteq \mathrm{Aut}(G)`),
        "。正規部分群による商集合には ",
        math(String.raw`(\psi_1\mathrm{Inn}(G))(\psi_2\mathrm{Inn}(G)) := (\psi_1\circ\psi_2)\mathrm{Inn}(G)`),
        " で well-defined な群構造が入るので ",
        math(String.raw`\mathrm{Out}(G)`),
        " は群である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文には無いが、原文の Out(G) := Aut(G)/Inn(G) が群として定義できるために必要な事実（Inn(G) の正規性）と、完全列の証明で使う φ の準同型性をまとめて新規に書き起こした。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_007d_definition_exact_sequence",
    kind: "definition",
    sourcePath: "structured-latex/content/008_TV1_hatZ_hatY_part1.mjs",
    sourceOrdinal: 7,
    title: { text: "群の完全列" },
    labels: ["def_exact_sequence"],
    statement: [
      paragraph([
        "群の列と群準同型の列",
      ]),
      displayMath(
        String.raw`G_0 \xrightarrow{f_1} G_1 \xrightarrow{f_2} G_2 \to \cdots \to G_{n-1} \xrightarrow{f_n} G_n`,
      ),
      paragraph([
        "が完全列であるとは、各中間の添字 ",
        math(String.raw`k \in \{1,\dots,n-1\}`),
        " について",
      ]),
      displayMath(String.raw`\mathrm{Im}(f_k) = \mathrm{Ker}(f_{k+1})`),
      paragraph([
        "（",
        ref("def_group_hom_ker_im"),
        " の像と核）が ",
        math(String.raw`G_k`),
        " の部分集合として成り立つことをいう。この条件が成り立つとき「",
        math(String.raw`G_k`),
        " で完全である」という。",
      ]),
      paragraph([
        "記号 ",
        math(String.raw`1`),
        " は単位元のみからなる自明群 ",
        math(String.raw`\{e\}`),
        " を表し、",
        math(String.raw`1 \to G`),
        " と ",
        math(String.raw`G \to 1`),
        " はそれぞれ一意に定まる群準同型（前者は ",
        math(String.raw`e \mapsto e_G`),
        "、後者は ",
        math(String.raw`g \mapsto e`),
        "）を表す。したがって",
      ]),
      list([
        [
          math(String.raw`1 \to G_1 \xrightarrow{f} G_2`),
          " が ",
          math(String.raw`G_1`),
          " で完全 ",
          math(String.raw`\iff \mathrm{Ker}(f) = \mathrm{Im}(1 \to G_1) = \{e_{G_1}\} \iff f`),
          " は単射（",
          ref("def_group_hom_ker_im"),
          "）",
        ],
        [
          math(String.raw`G_1 \xrightarrow{f} G_2 \to 1`),
          " が ",
          math(String.raw`G_2`),
          " で完全 ",
          math(String.raw`\iff \mathrm{Im}(f) = \mathrm{Ker}(G_2 \to 1) = G_2 \iff f`),
          " は全射",
        ],
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（parts/008/007）は「TODO: 完全列の定義」とのみ書いていたため新規に書き起こした。両端の 1 の扱い（単射性・全射性への読み替え）も明示した。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_008_definition_exact_sequence_aut",
    kind: "definition",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/007_definition_自己同型群の完全列.typ",
    sourceOrdinal: 8,
    title: { text: "自己同型群の完全列" },
    labels: ["exact_sequence_of_aut"],
    statement: [
      paragraph([
        "群 ",
        math(String.raw`G`),
        " について、",
        ref("def_center_of_group"),
        " の中心 ",
        math(String.raw`Z(G)`),
        "、",
        ref("def_aut_inn_out"),
        " の ",
        math(String.raw`\mathrm{Aut}(G), \mathrm{Inn}(G), \mathrm{Out}(G)`),
        " をとる。準同型を",
      ]),
      list([
        [
          math(String.raw`\iota : Z(G) \to G,\ g \mapsto g`),
          "（包含写像）",
        ],
        [
          math(String.raw`\varphi : G \to \mathrm{Aut}(G),\ g \mapsto \varphi_g`),
          "（",
          math(String.raw`\varphi_g(h) := ghg^{-1}`),
          "。",
          ref("inn_is_normal_in_aut"),
          " (i)(ii) によりこれは ",
          math(String.raw`\mathrm{Aut}(G)`),
          " への群準同型）",
        ],
        [
          math(String.raw`\pi : \mathrm{Aut}(G) \to \mathrm{Out}(G),\ \psi \mapsto \psi\,\mathrm{Inn}(G)`),
          "（商写像）",
        ],
      ]),
      paragraph(["と定めるとき、"]),
      displayMath(
        String.raw`1 \to Z(G) \xrightarrow{\ \iota\ } G \xrightarrow{\ \varphi\ } \mathrm{Aut}(G) \xrightarrow{\ \pi\ } \mathrm{Out}(G) \to 1`,
      ),
      paragraph([
        "は ",
        ref("def_exact_sequence"),
        " の意味で完全列をなす。すなわち ",
        math(String.raw`Z(G)`),
        "、",
        math(String.raw`G`),
        "、",
        math(String.raw`\mathrm{Aut}(G)`),
        "、",
        math(String.raw`\mathrm{Out}(G)`),
        " の 4 箇所すべてで完全である。",
      ]),
    ],
    proof: [
      paragraph([
        "まず ",
        math(String.raw`\iota`),
        " と ",
        math(String.raw`\pi`),
        " が群準同型であることを確認する。",
        math(String.raw`Z(G)`),
        " は ",
        math(String.raw`G`),
        " の部分群（",
        ref("def_center_of_group"),
        "）で ",
        math(String.raw`\iota(g_1g_2) = g_1g_2 = \iota(g_1)\iota(g_2)`),
        " だから ",
        math(String.raw`\iota`),
        " は群準同型。",
        math(String.raw`\mathrm{Inn}(G) \trianglelefteq \mathrm{Aut}(G)`),
        "（",
        ref("inn_is_normal_in_aut"),
        " (iii)）より商群 ",
        math(String.raw`\mathrm{Out}(G)`),
        " の演算は ",
        math(String.raw`(\psi_1\mathrm{Inn}(G))(\psi_2\mathrm{Inn}(G)) = (\psi_1\circ\psi_2)\mathrm{Inn}(G)`),
        " で定義されるので ",
        math(String.raw`\pi(\psi_1\circ\psi_2) = (\psi_1\circ\psi_2)\mathrm{Inn}(G) = \pi(\psi_1)\pi(\psi_2)`),
        "、すなわち ",
        math(String.raw`\pi`),
        " は群準同型。",
        math(String.raw`\varphi`),
        " が群準同型であることは ",
        ref("inn_is_normal_in_aut"),
        " (ii) による。",
      ]),

      paragraph([
        "(1) ",
        math(String.raw`Z(G)`),
        " での完全性：",
        math(String.raw`\mathrm{Im}(1 \to Z(G)) = \mathrm{Ker}(\iota)`),
        " を示す。",
      ]),
      paragraph([
        "左辺は自明群の像なので ",
        math(String.raw`\{e_G\}`),
        "（",
        math(String.raw`e_G`),
        " は ",
        math(String.raw`G`),
        " の単位元であり ",
        math(String.raw`Z(G)`),
        " の単位元でもある）。右辺は",
      ]),
      displayMath(
        String.raw`\mathrm{Ker}(\iota) = \{g \in Z(G) \mid \iota(g) = e_G\} = \{g \in Z(G) \mid g = e_G\} = \{e_G\}`,
      ),
      paragraph([
        "であり一致する。これは ",
        ref("def_exact_sequence"),
        " により ",
        math(String.raw`\iota`),
        " が単射であることと同値であり、実際 ",
        math(String.raw`\iota(g_1) = \iota(g_2) \Rightarrow g_1 = g_2`),
        " である。",
      ]),

      paragraph([
        "(2) ",
        math(String.raw`G`),
        " での完全性：",
        math(String.raw`\mathrm{Im}(\iota) = \mathrm{Ker}(\varphi)`),
        " を示す。",
      ]),
      paragraph([
        math(String.raw`\mathrm{Im}(\iota) = \{\iota(g) \mid g \in Z(G)\} = Z(G)`),
        " である。一方 ",
        math(String.raw`\mathrm{Aut}(G)`),
        " の単位元は ",
        math(String.raw`\mathrm{id}_G`),
        " なので、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{Ker}(\varphi)
&= \{g \in G \mid \varphi_g = \mathrm{id}_G\} \\
&= \{g \in G \mid \forall h \in G,\ \varphi_g(h) = h\}
   \quad (\because \text{写像の相等は各点での値の相等}) \\
&= \{g \in G \mid \forall h \in G,\ ghg^{-1} = h\} \\
&= \{g \in G \mid \forall h \in G,\ gh = hg\}
   \quad (\because ghg^{-1} = h \iff gh = hg\ (\text{両辺に右から } g)) \\
&= Z(G)
   \quad (\because \text{中心の定義})
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`\mathrm{Im}(\iota) = Z(G) = \mathrm{Ker}(\varphi)`),
        "。",
      ]),

      paragraph([
        "(3) ",
        math(String.raw`\mathrm{Aut}(G)`),
        " での完全性：",
        math(String.raw`\mathrm{Im}(\varphi) = \mathrm{Ker}(\pi)`),
        " を示す。",
      ]),
      paragraph([
        math(String.raw`\mathrm{Im}(\varphi) = \mathrm{Inn}(G)`),
        " は ",
        ref("def_aut_inn_out"),
        " の ",
        math(String.raw`\mathrm{Inn}(G)`),
        " の定義そのものである。一方 ",
        math(String.raw`\mathrm{Out}(G)`),
        " の単位元は剰余類 ",
        math(String.raw`\mathrm{Inn}(G) = \mathrm{id}_G\,\mathrm{Inn}(G)`),
        " なので、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{Ker}(\pi)
&= \{\psi \in \mathrm{Aut}(G) \mid \pi(\psi) = \mathrm{Inn}(G)\} \\
&= \{\psi \in \mathrm{Aut}(G) \mid \psi\,\mathrm{Inn}(G) = \mathrm{Inn}(G)\} \\
&= \{\psi \in \mathrm{Aut}(G) \mid \psi \in \mathrm{Inn}(G)\}
= \mathrm{Inn}(G)
\end{aligned}`,
      ),
      paragraph([
        "最後の等号は次による。",
        math(String.raw`\psi\,\mathrm{Inn}(G) = \mathrm{Inn}(G)`),
        " なら ",
        math(String.raw`\psi = \psi\circ\mathrm{id}_G \in \psi\,\mathrm{Inn}(G) = \mathrm{Inn}(G)`),
        "。逆に ",
        math(String.raw`\psi \in \mathrm{Inn}(G)`),
        " なら、",
        math(String.raw`\mathrm{Inn}(G)`),
        " が部分群であることから ",
        math(String.raw`\psi\,\mathrm{Inn}(G) \subseteq \mathrm{Inn}(G)`),
        " かつ、任意の ",
        math(String.raw`\chi \in \mathrm{Inn}(G)`),
        " について ",
        math(String.raw`\chi = \psi\circ(\psi^{-1}\circ\chi) \in \psi\,\mathrm{Inn}(G)`),
        "（",
        math(String.raw`\psi^{-1}\circ\chi \in \mathrm{Inn}(G)`),
        "）なので ",
        math(String.raw`\mathrm{Inn}(G) \subseteq \psi\,\mathrm{Inn}(G)`),
        "。よって ",
        math(String.raw`\mathrm{Ker}(\pi) = \mathrm{Inn}(G) = \mathrm{Im}(\varphi)`),
        "。",
      ]),

      paragraph([
        "(4) ",
        math(String.raw`\mathrm{Out}(G)`),
        " での完全性：",
        math(String.raw`\mathrm{Im}(\pi) = \mathrm{Ker}(\mathrm{Out}(G) \to 1)`),
        " を示す。",
      ]),
      paragraph([
        "右辺は ",
        math(String.raw`\mathrm{Out}(G)`),
        " のすべての元が自明群の単位元へ移るので ",
        math(String.raw`\mathrm{Out}(G)`),
        " 全体である。左辺は ",
        math(String.raw`\mathrm{Out}(G)`),
        " の任意の元が定義により ",
        math(String.raw`\psi\,\mathrm{Inn}(G)`),
        "（",
        math(String.raw`\psi \in \mathrm{Aut}(G)`),
        "）の形をしており ",
        math(String.raw`\psi\,\mathrm{Inn}(G) = \pi(\psi)`),
        " だから ",
        math(String.raw`\mathrm{Im}(\pi) = \mathrm{Out}(G)`),
        "（",
        math(String.raw`\pi`),
        " は全射）。よって両辺は一致する。",
      ]),
      paragraph([
        "(1)〜(4) により 4 箇所すべてで完全であり、主張の列は完全列である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（parts/008/007）は statement に「TODO: Ker, Im の定義、Z(G) の定義、完全列の定義」、proof に「TODO:」と書かれただけで中身が無かった。必要な定義を def_group_hom_ker_im / def_center_of_group / def_exact_sequence / inn_is_normal_in_aut として新規に追加し、4 箇所すべての完全性を証明して todo を除去した。",
        "原文は kind が definition だが内容は主張（完全列をなす）である。原文の構造を保つため kind は definition のままとし、proof に証明を置いた。",
        "この完全列そのものは、本文の他のブロックからは参照されていない（grep で確認：Aut / Out / Inn / 完全列 の語は本章のこの一連のブロックと、005_exp_conjugation_proof.mjs の Ad : G → Aut(G) の記述にしか現れず、後者はこの完全列を使っていない）。ただし『T の（定数倍を除いた）単射性』（injectivity_of_T_up_to_scalar）の証明でこの完全列の (2) Ker(φ) = Z(G) の部分を使うため、削除せず本文に残している。",
      ],
    },
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
    title: { text: "パウリ群・クリフォード群" },
    labels: ["def_pauli_group", "def_clifford_group"],
    statement: [
      paragraph([
        "以下 ",
        math(String.raw`R := \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " と書き、",
        ref("pauli_matrix_products"),
        " の Pauli 行列 ",
        math(String.raw`\sigma^x, \sigma^y, \sigma^z`),
        " と単位行列 ",
        math(String.raw`\sigma^0 := I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " を用いる。",
        math(String.raw`\mathbb{A} := \{0, x, y, z\}`),
        " を添字の集合とする。",
      ]),
      paragraph([
        math(String.raw`M`),
        " サイトの Pauli 群を",
      ]),
      displayMath(
        String.raw`\mathcal{P}_M := \left\{\,i^{k}\,\sigma^{a_1}\otimes\sigma^{a_2}\otimes\cdots\otimes\sigma^{a_M}
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
        " の形になり、テンソル積の積は成分ごとの積である）。",
        math(String.raw`\#\mathcal{P}_M = 4\cdot 4^M`),
        " であり、とくに有限群である。",
      ]),
      paragraph([
        "クリフォード群を、",
        math(String.raw`R`),
        " の乗法群（",
        ref("multiplicative_group_of_cc"),
        " と同様の意味での可逆元全体）",
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
        " の部分群である（",
        math(String.raw`I \in \mathcal{C}_M`),
        "、",
        math(String.raw`(g_1g_2)\mathcal{P}_M(g_1g_2)^{-1} = g_1(g_2\mathcal{P}_Mg_2^{-1})g_1^{-1} = \mathcal{P}_M`),
        "、",
        math(String.raw`g\mathcal{P}_Mg^{-1} = \mathcal{P}_M`),
        " の両辺を ",
        math(String.raw`g^{-1}\cdot g`),
        " で挟んで ",
        math(String.raw`g^{-1}\mathcal{P}_Mg = \mathcal{P}_M`),
        "）。",
      ]),
      paragraph([
        "量子情報の文献で標準的なクリフォード群は、上の ",
        math(String.raw`R^\times`),
        " をユニタリ群 ",
        math(String.raw`U(2^M) := \{U \in R \mid U^\dagger U = I\}`),
        " に取り替え、さらにスカラー ",
        math(String.raw`U(1) := \{e^{i\alpha}I \mid \alpha \in \mathbb{R}\}`),
        " で割った ",
        math(String.raw`\{U \in U(2^M) \mid U\mathcal{P}_MU^{-1} = \mathcal{P}_M\}/U(1)`),
        " である。本証明で現れる ",
        math(String.raw`V_2 = (2s_2)^{M/2}\exp\!\left(K_2^*\sum_{k=1}^{M}\sigma_k^x\right)`),
        " は ",
        math(String.raw`K_2^* \in \mathbb{R}_{>0}`),
        " のとき Hermite 行列の実係数 exp なのでユニタリではない。そのためここでは ",
        math(String.raw`R^\times`),
        " の中での正規化群として定義した。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（parts/008/009）は definition の体裁だが中身は著者の検討メモであり、箇条書き 3 項目（クリフォード群の定義／T_g の定義をクリフォード群へ狭める／T の定数倍を除いた単射性を示す）と、3 つ目に付随する『3 つのアプローチ』が書かれていた。原文の 3 つのアプローチは次のとおり（原文の文言）: 試す1「V を具体的な行列として書く、がゴールなので T_((V)) からその表式を見つけられないか？」／試す2「T の（定数倍除いた）単射性を（Cl に触れずに）示す」／だめだったら3「Cl と行列環の同型を認め、T の（定数倍除いた）単射性も認め、計算を先に進める」。",
        "本作業でこの検討は決着した。(a) T の（定数倍を除いた）単射性は Clifford 代数と行列環の同型を経由せず、中心がスカラーであること（centralizer_is_scalar）と自己同型群の完全列から直接示せる（injectivity_of_T_up_to_scalar）。すなわち原文の『試す2』が成立し、『試す1』『だめだったら3』は不要である。(b) 一方『T_g の定義をクリフォード群の元に狭める』は採れない。V_2 がクリフォード群に属さないためで、これは V2_not_in_clifford_group で証明した。したがって本文では T_g の定義域を R^× のままとし（def_T_g）、クリフォード群は本証明では使わない。",
        "クリフォード群の定義そのものは、上記 (b) の主張（V_2 ∉ C_M）を述べるために必要なので本文に残した。標準的な定義がユニタリ群上で与えられるのに対しここでは R^× 上の正規化群としたのは、V_2 がユニタリでないため（statement 内に理由を明記）。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_010a_claim_V2_not_in_clifford_group",
    kind: "claim",
    sourcePath: "structured-latex/content/008_TV1_hatZ_hatY_part1.mjs",
    sourceOrdinal: 10,
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
        math(String.raw`\{\sigma^{a_1}\otimes\cdots\otimes\sigma^{a_M} \mid (a_1,\dots,a_M)\in\mathbb{A}^M\}`),
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
        math(String.raw`\sigma_1^z := \sigma^z\otimes\sigma^0\otimes\cdots\otimes\sigma^0 \in \mathcal{P}_M`),
        " の ",
        math(String.raw`V_2`),
        " による共役を計算する。",
        math(String.raw`k \neq l`),
        " のとき ",
        math(String.raw`\sigma_k^x`),
        " と ",
        math(String.raw`\sigma_l^x`),
        " は異なるテンソル因子にのみ非自明に作用するので可換であり、",
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
= \left(\exp\!\left(K_2^*\sigma^x\right)\sigma^z\exp\!\left(-K_2^*\sigma^x\right)\right)\otimes\sigma^0\otimes\cdots\otimes\sigma^0`,
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
      displayMath(
        String.raw`\begin{aligned}
\exp\!\left(K_2^*\sigma^x\right)\sigma^z\exp\!\left(-K_2^*\sigma^x\right)
&= \sigma^z\exp\!\left(-K_2^*\sigma^x\right)\exp\!\left(-K_2^*\sigma^x\right) \\
&= \sigma^z\exp\!\left(-2K_2^*\sigma^x\right)
   \quad (\because \text{可換な行列の exp 積公式}) \\
&= \sigma^z\left(\cosh(2K_2^*)\sigma^0 - \sinh(2K_2^*)\sigma^x\right)
   \quad (\because \text{Step 2},\ \cosh(-t)=\cosh t,\ \sinh(-t)=-\sinh t) \\
&= \cosh(2K_2^*)\,\sigma^z - \sinh(2K_2^*)\,\sigma^z\sigma^x \\
&= c_2^*\,\sigma^z - i\,s_2^*\,\sigma^y
\end{aligned}`,
      ),
      paragraph([
        "最後の等号では ",
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
= i\,\sigma^y`,
      ),
      paragraph([
        "を用いた。",
      ]),
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
= c_2^*\left(\sigma^z\otimes\sigma^0\otimes\cdots\otimes\sigma^0\right)
- i\,s_2^*\left(\sigma^y\otimes\sigma^0\otimes\cdots\otimes\sigma^0\right)`,
      ),
      paragraph([
        "は Step 1 の基底に関して相異なる 2 つの基底元の係数がともに ",
        math(String.raw`0`),
        " でない。一方 ",
        math(String.raw`\mathcal{P}_M`),
        " の元 ",
        math(String.raw`i^k\sigma^{a_1}\otimes\cdots\otimes\sigma^{a_M}`),
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
        "原文の検討メモにあった『T_g の定義をクリフォード群の元に狭める』という方針が採れないことを示す主張。原文には無く、本作業で新規に追加した。",
      ],
    },
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
    id: "TV1_hatZ_hatY_011a_claim_injectivity_of_T",
    kind: "claim",
    sourcePath: "structured-latex/content/008_TV1_hatZ_hatY_part1.mjs",
    sourceOrdinal: 11,
    title: { tex: String.raw`T \text{ の（定数倍を除いた）単射性}` },
    labels: ["injectivity_of_T_up_to_scalar", "center_of_multiplicative_group_is_scalar"],
    statement: [
      paragraph([
        math(String.raw`R := \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        "、",
        math(String.raw`R^\times`),
        " をその乗法群（",
        ref("def_T_g"),
        " の ",
        math(String.raw`T_g`),
        " の定義域）とする。",
      ]),
      list([
        [
          "(i) ",
          math(String.raw`Z(R^\times) = \{c\,I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}} \mid c \in \mathbb{C}\setminus\{0\}\}`),
          "（",
          math(String.raw`Z`),
          " は ",
          ref("def_center_of_group"),
          " の中心）。",
        ],
        [
          "(ii)（",
          math(String.raw`T`),
          " の定数倍を除いた単射性）",
          math(String.raw`g, g' \in R^\times`),
          " について",
          math(String.raw`\quad T_g = T_{g'} \iff \exists c \in \mathbb{C}\setminus\{0\},\ g' = c\,g`),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`I := I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}}`),
        " と書く。",
      ]),
      paragraph([
        "(i) の証明。まず ",
        math(String.raw`\supseteq`),
        "：",
        math(String.raw`c \neq 0`),
        " なら ",
        math(String.raw`cI`),
        " は ",
        math(String.raw`c^{-1}I`),
        " を逆元にもち ",
        math(String.raw`cI \in R^\times`),
        "、また ",
        ref("scalar_identity_commutes"),
        " より ",
        math(String.raw`cI`),
        " は ",
        math(String.raw`R`),
        " のすべての元と可換なので、とくに ",
        math(String.raw`R^\times`),
        " のすべての元と可換であり ",
        math(String.raw`cI \in Z(R^\times)`),
        "。",
      ]),
      paragraph([
        "次に ",
        math(String.raw`\subseteq`),
        "：",
        math(String.raw`W \in Z(R^\times)`),
        " とする。任意の ",
        math(String.raw`x \in R`),
        " をとる。",
        math(String.raw`x`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " 上の有限次元線型空間 ",
        math(String.raw`(\mathbb{C}^2)^{\otimes M}`),
        " の自己準同型を表す行列であり、その固有値の集合 ",
        math(String.raw`\Lambda(x) \subseteq \mathbb{C}`),
        " は特性多項式（",
        math(String.raw`2^M`),
        " 次）の根全体なので高々 ",
        math(String.raw`2^M`),
        " 個の有限集合である。よって ",
        math(String.raw`t \in \mathbb{C}`),
        " で ",
        math(String.raw`-t \notin \Lambda(x)`),
        " なるものが（実際には ",
        math(String.raw`\mathbb{C}`),
        " の無限個の元が）存在し、そのような ",
        math(String.raw`t`),
        " について ",
        math(String.raw`\det(x + tI) \neq 0`),
        " すなわち ",
        math(String.raw`x + tI \in R^\times`),
        " である。",
      ]),
      paragraph([
        math(String.raw`W \in Z(R^\times)`),
        " より ",
        math(String.raw`W(x+tI) = (x+tI)W`),
        " であり、また ",
        math(String.raw`tI \in R^\times`),
        "（",
        math(String.raw`t \neq 0`),
        " のとき）あるいは ",
        ref("scalar_identity_commutes"),
        " より ",
        math(String.raw`W(tI) = (tI)W`),
        " が常に成り立つ。両者を引くと",
      ]),
      displayMath(
        String.raw`Wx = W(x + tI) - W(tI) = (x+tI)W - (tI)W = xW`,
      ),
      paragraph([
        "を得る。",
        math(String.raw`x \in R`),
        " は任意だったので ",
        math(String.raw`W`),
        " は ",
        math(String.raw`R`),
        " のすべての元と可換であり、",
        ref("centralizer_is_scalar"),
        " より ",
        math(String.raw`W = cI`),
        " なる ",
        math(String.raw`c \in \mathbb{C}`),
        " が存在する。",
        math(String.raw`W \in R^\times`),
        " より ",
        math(String.raw`W`),
        " は可逆なので ",
        math(String.raw`c \neq 0`),
        "（",
        math(String.raw`c = 0`),
        " なら ",
        math(String.raw`W = O`),
        " で非可逆）。よって ",
        math(String.raw`Z(R^\times) \subseteq \{cI \mid c \in \mathbb{C}\setminus\{0\}\}`),
        "。",
      ]),

      paragraph([
        "(ii) の証明。",
        math(String.raw`g \in R^\times`),
        " について、",
        math(String.raw`T_g`),
        " の ",
        math(String.raw`R^\times`),
        " への制限 ",
        math(String.raw`T_g|_{R^\times}`),
        " を考える。",
        math(String.raw`h \in R^\times`),
        " なら ",
        math(String.raw`T_g(h)T_g(h^{-1}) = ghg^{-1}gh^{-1}g^{-1} = I`),
        " より ",
        math(String.raw`T_g(h) \in R^\times`),
        " であり、",
        math(String.raw`T_g|_{R^\times} = \varphi_g`),
        "（",
        ref("def_aut_inn_out"),
        " の内部自己同型、",
        math(String.raw`G := R^\times`),
        " の場合）である。",
        ref("inn_is_normal_in_aut"),
        " (i)(ii) より ",
        math(String.raw`\varphi : R^\times \to \mathrm{Aut}(R^\times),\ g \mapsto T_g|_{R^\times}`),
        " は群準同型である。",
      ]),
      paragraph([
        "Step 1: ",
        math(String.raw`T_g = T_{g'}`),
        "（",
        math(String.raw`R`),
        " 上の写像として）と ",
        math(String.raw`T_g|_{R^\times} = T_{g'}|_{R^\times}`),
        " は同値である。",
      ]),
      paragraph([
        "（",
        math(String.raw`\Rightarrow`),
        "）は制限をとるだけである。（",
        math(String.raw`\Leftarrow`),
        "）は次による。",
        math(String.raw`x \in R`),
        " を任意にとり、(i) の証明と同様に ",
        math(String.raw`x + tI \in R^\times`),
        " なる ",
        math(String.raw`t \in \mathbb{C}\setminus\{0\}`),
        " をとる（除外すべき ",
        math(String.raw`t`),
        " は有限個なので ",
        math(String.raw`0`),
        " 以外に選べる）。このとき ",
        math(String.raw`tI \in R^\times`),
        " でもあり、",
        math(String.raw`T_g`),
        " は ",
        math(String.raw`R`),
        " 上加法的（",
        math(String.raw`g(x+y)g^{-1} = gxg^{-1} + gyg^{-1}`),
        "、分配法則）なので",
      ]),
      displayMath(
        String.raw`T_g(x) = T_g(x + tI) - T_g(tI) = T_{g'}(x + tI) - T_{g'}(tI) = T_{g'}(x)`,
      ),
      paragraph([
        "Step 2: ",
        math(String.raw`T_g|_{R^\times} = T_{g'}|_{R^\times} \iff \exists c \in \mathbb{C}\setminus\{0\},\ g' = cg`),
        "。",
      ]),
      paragraph([
        math(String.raw`\varphi`),
        " が群準同型であることから ",
        math(String.raw`\varphi(g)^{-1}\varphi(g') = \varphi(g^{-1}g')`),
        " であり、",
      ]),
      displayMath(
        String.raw`T_g|_{R^\times} = T_{g'}|_{R^\times}
\iff \varphi(g) = \varphi(g')
\iff \varphi(g^{-1}g') = \mathrm{id}_{R^\times}
\iff g^{-1}g' \in \mathrm{Ker}(\varphi)`,
      ),
      paragraph([
        ref("exact_sequence_of_aut"),
        " の ",
        math(String.raw`G`),
        " での完全性（証明の (2)）より ",
        math(String.raw`\mathrm{Ker}(\varphi) = Z(R^\times)`),
        " であり、(i) より ",
        math(String.raw`Z(R^\times) = \{cI \mid c \in \mathbb{C}\setminus\{0\}\}`),
        "。よって",
      ]),
      displayMath(
        String.raw`T_g|_{R^\times} = T_{g'}|_{R^\times}
\iff \exists c \in \mathbb{C}\setminus\{0\},\ g^{-1}g' = cI
\iff \exists c \in \mathbb{C}\setminus\{0\},\ g' = c\,g`,
      ),
      paragraph([
        "（最後は両辺に左から ",
        math(String.raw`g`),
        " を掛け、",
        ref("scalar_identity_commutes"),
        " により ",
        math(String.raw`g(cI) = cg`),
        " を使った。）Step 1 と Step 2 を合わせて (ii) を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文の検討メモ（parts/008/009）にあった『T の（定数倍を除いた）単射性が大事そうなので示す』を、メモの『試す2』の方針（Clifford 代数と行列環の同型に触れずに示す）で実際に証明したもの。中心がスカラーであること（centralizer_is_scalar）と自己同型群の完全列（exact_sequence_of_aut）だけを使う。",
        "R^× の中心が R 全体の中心（スカラー）と一致することは自明ではないため、x + tI が可逆になる t を選ぶ議論で明示的に示した（(i) および Step 1）。",
      ],
    },
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
    id: "TV1_hatZ_hatY_016a_claim_duality_c2_star",
    kind: "claim",
    sourcePath: "structured-latex/content/008_TV1_hatZ_hatY_part1.mjs",
    sourceOrdinal: 17,
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
&= \frac{(\tanh K_2)^{-1} - \tanh K_2}{2} \\
&= \frac{1}{2}\left(\frac{\cosh K_2}{\sinh K_2} - \frac{\sinh K_2}{\cosh K_2}\right) \\
&= \frac{\cosh^2 K_2 - \sinh^2 K_2}{2\sinh K_2\cosh K_2} \\
&= \frac{1}{\sinh 2K_2}
   \quad (\because \cosh^2 x - \sinh^2 x = 1,\ 2\sinh x\cosh x = \sinh 2x) \\
&= \frac{1}{s_2}
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
c_2^* = \cosh 2K_2^*
&= \frac{e^{2K_2^*} + e^{-2K_2^*}}{2}
   \quad (\because \cosh x = \tfrac{1}{2}(e^{x}+e^{-x})) \\
&= \frac{(\tanh K_2)^{-1} + \tanh K_2}{2} \\
&= \frac{1}{2}\left(\frac{\cosh K_2}{\sinh K_2} + \frac{\sinh K_2}{\cosh K_2}\right) \\
&= \frac{\cosh^2 K_2 + \sinh^2 K_2}{2\sinh K_2\cosh K_2} \\
&= \frac{\cosh 2K_2}{\sinh 2K_2}
   \quad (\because \cosh^2 x + \sinh^2 x = \cosh 2x,\ 2\sinh x\cosh x = \sinh 2x) \\
&= \frac{c_2}{s_2}
\end{aligned}`,
      ),
      paragraph([
        "この 2 式より ",
        math(String.raw`c_2^* = \dfrac{c_2}{s_2} = c_2\cdot\dfrac{1}{s_2} = c_2\, s_2^* = s_2^*\, c_2`),
        "（",
        math(String.raw`\mathbb{R}`),
        " の乗法の可換性による）。",
      ]),
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
        = Ca + i^2 S b\, e^{-i\theta}
        = Ca - S b\, e^{-i\theta} \\
N_{12} &= C\cdot\left(-i e^{i\theta} b\right) + (iS)\cdot a
        = i\left(Sa - C b\, e^{i\theta}\right) \\
N_{21} &= (-iS)\cdot a + C\cdot\left(i e^{-i\theta} b\right)
        = i\left(C b\, e^{-i\theta} - Sa\right) \\
N_{22} &= (-iS)\cdot\left(-i e^{i\theta} b\right) + C\cdot a
        = i^2 S b\, e^{i\theta} + Ca
        = Ca - S b\, e^{i\theta}
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
&= a\, N_{11} + \left(-i e^{i\theta} b\right) N_{21} \\
&= a\left(Ca - S b\, e^{-i\theta}\right)
   + \left(-i e^{i\theta} b\right)\cdot i\left(C b\, e^{-i\theta} - Sa\right) \\
&= Ca^2 - S ab\, e^{-i\theta}
   + e^{i\theta} b\left(C b\, e^{-i\theta} - Sa\right)
   \quad (\because -i\cdot i = 1) \\
&= Ca^2 - S ab\, e^{-i\theta} + C b^2 - S ab\, e^{i\theta}
   \quad (\because e^{i\theta}e^{-i\theta} = 1) \\
&= C\left(a^2 + b^2\right) - S ab\left(e^{i\theta} + e^{-i\theta}\right) \\
&= C\, c_1 - S\cdot\frac{s_1}{2}\cdot 2\cos\theta
   \quad (\because a^2+b^2 = c_1,\ 2ab = s_1,\ e^{i\theta}+e^{-i\theta} = 2\cos\theta) \\
&= c_1 c_2^* - s_1 s_2^*\cos\theta
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
&= \left(i e^{-i\theta} b\right) N_{12} + a\, N_{22} \\
&= \left(i e^{-i\theta} b\right)\cdot i\left(Sa - C b\, e^{i\theta}\right)
   + a\left(Ca - S b\, e^{i\theta}\right) \\
&= -e^{-i\theta} b\left(Sa - C b\, e^{i\theta}\right) + Ca^2 - S ab\, e^{i\theta}
   \quad (\because i\cdot i = -1) \\
&= -S ab\, e^{-i\theta} + C b^2 + Ca^2 - S ab\, e^{i\theta} \\
&= C\left(a^2 + b^2\right) - S ab\left(e^{i\theta} + e^{-i\theta}\right) \\
&= c_1 c_2^* - s_1 s_2^*\cos\theta
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
&= a\, N_{12} + \left(-i e^{i\theta} b\right) N_{22} \\
&= a\cdot i\left(Sa - C b\, e^{i\theta}\right)
   + \left(-i e^{i\theta} b\right)\left(Ca - S b\, e^{i\theta}\right) \\
&= i\left[S a^2 - C ab\, e^{i\theta}\right]
   + i\left[-C ab\, e^{i\theta} + S b^2 e^{2i\theta}\right] \\
&= i\left[S\left(a^2 + b^2 e^{2i\theta}\right) - 2C ab\, e^{i\theta}\right]
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
&= e^{i\theta}\left(a^2 e^{-i\theta} + b^2 e^{i\theta}\right) \\
&= e^{i\theta}\left(a^2(\cos\theta - i\sin\theta) + b^2(\cos\theta + i\sin\theta)\right)
   \quad (\because \text{Euler の公式}) \\
&= e^{i\theta}\left(\left(a^2 + b^2\right)\cos\theta - i\left(a^2 - b^2\right)\sin\theta\right) \\
&= e^{i\theta}\left(c_1\cos\theta - i\sin\theta\right)
   \quad (\because a^2+b^2 = c_1,\ a^2-b^2 = 1)
\end{aligned}`,
      ),
      paragraph(["また ", math(String.raw`2ab = s_1`), " なので、"]),
      displayMath(
        String.raw`\begin{aligned}
P_{12}
&= i\left[S\, e^{i\theta}\left(c_1\cos\theta - i\sin\theta\right) - C s_1 e^{i\theta}\right] \\
&= i e^{i\theta}\left[S\left(c_1\cos\theta - i\sin\theta\right) - C s_1\right] \\
&= i e^{i\theta}\left[s_2^*\left(c_1\cos\theta - i\sin\theta\right) - c_2^*\, s_1\right] \\
&= i e^{i\theta}\left[s_2^*\left(c_1\cos\theta - i\sin\theta\right) - s_2^* c_2\, s_1\right]
   \quad (\because c_2^* = s_2^* c_2) \\
&= i e^{i\theta} s_2^*\left(c_1\cos\theta - i\sin\theta - s_1 c_2\right)
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
&= \left(i e^{-i\theta} b\right) N_{11} + a\, N_{21} \\
&= \left(i e^{-i\theta} b\right)\left(Ca - S b\, e^{-i\theta}\right)
   + a\cdot i\left(C b\, e^{-i\theta} - Sa\right) \\
&= i\left[C ab\, e^{-i\theta} - S b^2 e^{-2i\theta}\right]
   + i\left[C ab\, e^{-i\theta} - S a^2\right] \\
&= -i\left[S\left(a^2 + b^2 e^{-2i\theta}\right) - 2C ab\, e^{-i\theta}\right]
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
&= e^{-i\theta} s_2^*\left(c_1\cos\theta + i\sin\theta - s_1 c_2\right) \\
\therefore\quad
P_{21}
&= -i e^{-i\theta} s_2^*\left(c_1\cos\theta + i\sin\theta - s_1 c_2\right)
= -\gamma_2(-\theta)
\end{aligned}`,
      ),
      paragraph([
        "実際、",
        math(String.raw`\gamma_2(-\theta) = i e^{-i\theta} s_2^*(c_1\cos(-\theta) - i\sin(-\theta) - s_1 c_2) = i e^{-i\theta} s_2^*(c_1\cos\theta + i\sin\theta - s_1 c_2)`),
        " であるから ",
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
= (\hat{Z}_\mu^{(-)},\hat{Y}_\mu)\, A(\theta_\mu)`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文 proof の (z)/(y) 各行列簡約と『よって』の合流までを忠実に翻訳。原文が TODO（Mathematica で数値確認済みとして略）としていた最終の B1·B2·B1 = A(θ_μ) の明示的行列積を、4 成分すべて途中式込みで人手計算して埋め、todo を除去した。",
        "行列積の結果は statement（および def_A_theta の A(θ) の定義）と完全に一致した。ただし (1,2)/(2,1) 成分は素の計算では c_2^*（＝S）が現れ、A(θ) の γ_2 に現れる c_2 とは K_2 と K_2^* の双対関係 c_2^* = s_2^* c_2 を経由して一致する。この関係を duality_c2_star_eq_s2_star_c2 として独立した claim に切り出し、参照した。statement 側の修正は不要だった。",
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
