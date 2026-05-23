import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "hatZ_hatY_anticommutation_001_claim_anticommutation_relations",
    kind: "claim",
    sourcePath: "parts/007_hatZとhatYの反交換関係/000_claim_hatZ同士_hatZとhatY_hatY同士の反交換関係.typ",
    sourceOrdinal: 1,
    title: { tex: String.raw`\hat{Z}\text{と}\hat{Y}\text{の反交換関係}` },
    labels: ["anticommutator_of_hat_Z_and_hat_Y"],
    statement: [
      displayMath(
        String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\pm)}]_+ = 2M\,\delta^M_{\mu+\nu,0}\,I \quad (\text{複合同順})`,
      ),
      displayMath(
        String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\mp)}]_+
= 2M\,\delta^M_{\mu+\nu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}
+ \left(-2\exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{(\mathbb{C}^2)^{\otimes M}}\right)
\quad (\text{複合同順})`,
      ),
      displayMath(
        String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Y}_\nu]_+ = 0`,
      ),
      displayMath(
        String.raw`[\hat{Y}_\mu, \hat{Y}_\nu]_+ = 2M\,\delta^M_{\mu+\nu,0}\,I`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\pm)}]_+`),
        " の計算:",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\pm)}]_+
&= \sum_{j,k=1}^{M}
  \begin{pmatrix}\pm 1 & (j=1) \\ +1 & (j\neq 1)\end{pmatrix}
  \begin{pmatrix}\pm 1 & (k=1) \\ +1 & (k\neq 1)\end{pmatrix}
  e^{-i\frac{2\pi}{M}j\mu}\,e^{-i\frac{2\pi}{M}k\nu}
  [Z_j, Z_k]_+ \\
&= \sum_{j=1}^{M} e^{-i\frac{2\pi j}{M}(\mu+\nu)} \cdot 2I_{(\mathbb{C}^2)^{\otimes M}}
  \quad (\because [Z_j,Z_k]_+ = 2I\,\delta^M_{(j,k)},\;\text{符号積}=1) \\
&= 2M\,\delta^M_{\mu+\nu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}
  \quad (\because \text{\ref{exp_sum}})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\mp)}]_+`),
        " の計算: ",
        math(String.raw`j=1`),
        " の項の符号積が ",
        math(String.raw`-1`),
        " になるため、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\mp)}]_+
&= \left(-2e^{-i\frac{2\pi}{M}(\mu+\nu)} \cdot 2I\right)
  + \sum_{j=1}^{M} e^{-i\frac{2\pi j}{M}(\mu+\nu)} \cdot 2I \\
&= 2M\,\delta^M_{\mu+\nu,0}\,I
  + \left(-2e^{-i\frac{2\pi}{M}(\mu+\nu)} \cdot 2I\right)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Y}_\nu]_+`),
        "、",
        math(String.raw`[\hat{Y}_\mu, \hat{Y}_\nu]_+`),
        " については同様。",
      ]),
    ],
    conversion: {
      status: "partially_simplified",
      notes: [
        "原文の長大なテンソル積展開を要点のみに圧縮。",
        "cases記法 → \begin{pmatrix}...\end{pmatrix}で代替表記。",
      ],
    },
  },
]);
