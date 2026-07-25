import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "heading_hatZ_hatY_anticommutation",
    kind: "heading",
    level: 2,
    sourcePath: "main.typ",
    sourceOrdinal: 9,
    title: { tex: String.raw`\hat{Z}\text{と}\hat{Y}\text{の反交換関係}` },
    labels: [],
    conversion: { status: "converted" },
  },
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
        " の計算（以下 ",
        ref("anticommutator_of_Z_and_Y"),
        "（",
        math(String.raw`Z`),
        " の反交換関係）と ",
        ref("exp_sum"),
        " を用いる）:",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\pm)}]_+
&= \left[\sum_{j=1}^M \begin{cases}+1 & (j\neq 1)\\ \mp 1 & (j=1)\end{cases}Z_j\exp\!\left(-i j\frac{2\pi\mu}{M}\right),\ \sum_{k=1}^M \begin{cases}+1 & (k\neq 1)\\ \mp 1 & (k=1)\end{cases}Z_k\exp\!\left(-i k\frac{2\pi\nu}{M}\right)\right]_+ \\
&= \left(\sum_{j=1}^M \begin{cases}+1 & (j\neq 1)\\ \mp 1 & (j=1)\end{cases}Z_j\exp\!\left(-i j\frac{2\pi\mu}{M}\right)\right)\left(\sum_{k=1}^M \begin{cases}+1 & (k\neq 1)\\ \mp 1 & (k=1)\end{cases}Z_k\exp\!\left(-i k\frac{2\pi\nu}{M}\right)\right) \\
&\quad + \left(\sum_{k=1}^M \begin{cases}+1 & (k\neq 1)\\ \mp 1 & (k=1)\end{cases}Z_k\exp\!\left(-i k\frac{2\pi\nu}{M}\right)\right)\left(\sum_{j=1}^M \begin{cases}+1 & (j\neq 1)\\ \mp 1 & (j=1)\end{cases}Z_j\exp\!\left(-i j\frac{2\pi\mu}{M}\right)\right) \\
&= \sum_{j,k=1}^M \begin{cases}+1 & (j\neq 1)\\ \mp 1 & (j=1)\end{cases}\begin{cases}+1 & (k\neq 1)\\ \mp 1 & (k=1)\end{cases}Z_j Z_k\exp\!\left(-i\frac{2\pi}{M}(j\mu+k\nu)\right) \\
&\quad + \sum_{j,k=1}^M \begin{cases}+1 & (k\neq 1)\\ \mp 1 & (k=1)\end{cases}\begin{cases}+1 & (j\neq 1)\\ \mp 1 & (j=1)\end{cases}Z_k Z_j\exp\!\left(-i\frac{2\pi}{M}(k\nu+j\mu)\right) \\
&= \sum_{j,k=1}^M \begin{cases}+1 & (j\neq 1)\\ \mp 1 & (j=1)\end{cases}\begin{cases}+1 & (k\neq 1)\\ \mp 1 & (k=1)\end{cases}\exp\!\left(-i\frac{2\pi}{M}(j\mu+k\nu)\right)(Z_j Z_k + Z_k Z_j) \\
&= \sum_{j,k=1}^M \begin{cases}+1 & (j\neq 1)\\ \mp 1 & (j=1)\end{cases}\begin{cases}+1 & (k\neq 1)\\ \mp 1 & (k=1)\end{cases}\exp\!\left(-i\frac{2\pi}{M}(j\mu+k\nu)\right)[Z_j, Z_k]_+ \\
&= \sum_{j,k=1}^M \begin{cases}+1 & (j\neq 1)\\ \mp 1 & (j=1)\end{cases}\begin{cases}+1 & (k\neq 1)\\ \mp 1 & (k=1)\end{cases}\exp\!\left(-i\frac{2\pi}{M}(j\mu+k\nu)\right)\cdot 2I_{(\mathbb{C}^2)^{\otimes M}}\,\delta^M_{(j,k)} \quad (\because Z \text{ の反交換関係}) \\
&= \sum_{j=1}^M \underbrace{\begin{cases}+1 & (j\neq 1)\\ \mp 1 & (j=1)\end{cases}\begin{cases}+1 & (j\neq 1)\\ \mp 1 & (j=1)\end{cases}}_{\text{符号が } j \text{ に関わらず一致}=1}\exp\!\left(-i\frac{2\pi}{M}(j\mu+j\nu)\right)\cdot 2I_{(\mathbb{C}^2)^{\otimes M}} \\
&= \sum_{j=1}^M \exp\!\left(-i\frac{2\pi j}{M}(\mu+\nu)\right)\cdot 2I_{(\mathbb{C}^2)^{\otimes M}} \\
&= 2M\,\delta^M_{\mu+\nu,0}\,I_{(\mathbb{C}^2)^{\otimes M}} \quad (\because \text{exp\_sum})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\mp)}]_+`),
        " の計算: 第 2 の因子の ",
        math(String.raw`k=1`),
        " の符号が ",
        math(String.raw`\pm 1`),
        " になるため、",
        math(String.raw`j=1`),
        " の項の符号積が ",
        math(String.raw`-1`),
        "（他は ",
        math(String.raw`+1`),
        "）となる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\mp)}]_+
&= \sum_{j=1}^M \underbrace{\begin{cases}+1 & (j\neq 1)\\ \mp 1 & (j=1)\end{cases}\begin{cases}+1 & (j\neq 1)\\ \pm 1 & (j=1)\end{cases}}_{j=1 \text{ のみ } -1,\ \text{他は } +1}\exp\!\left(-i\frac{2\pi}{M}(j\mu+j\nu)\right)\cdot 2I_{(\mathbb{C}^2)^{\otimes M}} \\
&= \underbrace{\left(-2\exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{(\mathbb{C}^2)^{\otimes M}}\right)}_{j=1 \text{ の項を打ち消すために 2 回引く}} + \sum_{j=1}^M \exp\!\left(-i\frac{2\pi}{M}(j\mu+j\nu)\right)\cdot 2I_{(\mathbb{C}^2)^{\otimes M}} \\
&= \underbrace{2M\,\delta^M_{\mu+\nu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}}_{[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\pm)}]_+} + \left(-2\exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{(\mathbb{C}^2)^{\otimes M}}\right)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Y}_\nu]_+`),
        "、",
        math(String.raw`[\hat{Y}_\mu, \hat{Y}_\nu]_+`),
        " についても同様（原文もこの 2 つは「同様」として詳細を省いている）。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文の [hatZ^(±),hatZ^(±)]_+ と [hatZ^(±),hatZ^(∓)]_+ の二重和展開を全ステップ忠実に再現した。",
        "原文の場合分け記法は KaTeX の cases 環境で表記した。",
        "[hatZ^(±),hatY]_+ と [hatY,hatY]_+ は原文自体が「同様」として省略。",
      ],
    },
  },
]);
