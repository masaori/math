import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "heading_hatZ_hatY_anticommutation",
    kind: "heading",
    level: 2,
    sourcePath: "_old/typst/main.typ",
    sourceOrdinal: 9,
    title: { tex: String.raw`\hat{Z}\text{と}\hat{Y}\text{の反交換関係}` },
    labels: [],
    conversion: { status: "converted" },
  },
  {
    id: "hatZ_hatY_anticommutation_001_claim_anticommutation_relations",
    kind: "claim",
    sourcePath: "_old/typst/parts/007_hatZとhatYの反交換関係/000_claim_hatZ同士_hatZとhatY_hatY同士の反交換関係.typ",
    sourceOrdinal: 1,
    title: { tex: String.raw`\hat{Z}\text{と}\hat{Y}\text{の反交換関係}` },
    labels: ["anticommutator_of_hat_Z_and_hat_Y"],
    statement: [
      paragraph([
        math(String.raw`\hat{Z}_\mu^{(\pm)}, \hat{Y}_\mu`),
        " は ",
        math(String.raw`Z_j, Y_j`),
        " の ",
        math(String.raw`\mathbb{C}`),
        "-線型結合であり、",
        ref("def_transfer_matrix_symbols"),
        " のとおり ",
        math(String.raw`Z_j, Y_j \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " であるから、以下の等式はすべて ",
        math(String.raw`2^M`),
        " 次の複素行列の等式である。",
        math(String.raw`I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        " は ",
        math(String.raw`2^M`),
        " 次の単位行列を表す（",
        ref("def_kronecker"),
        "、",
        ref("kronecker_product_rule"),
        " (2)）。",
      ]),
      displayMath(
        String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\pm)}]_+ = 2M\,\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})} \quad (\text{複合同順})`,
      ),
      displayMath(
        String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\mp)}]_+
= 2M\,\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
+ \left(-2\exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
\quad (\text{複合同順})`,
      ),
      displayMath(
        String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Y}_\nu]_+ = 0`,
      ),
      displayMath(
        String.raw`[\hat{Y}_\mu, \hat{Y}_\nu]_+ = 2M\,\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}`,
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
&= \sum_{j,k=1}^M \begin{cases}+1 & (j\neq 1)\\ \mp 1 & (j=1)\end{cases}\begin{cases}+1 & (k\neq 1)\\ \mp 1 & (k=1)\end{cases}\exp\!\left(-i\frac{2\pi}{M}(j\mu+k\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}\,\delta^M_{(j,k)} \quad (\because Z \text{ の反交換関係}) \\
&= \sum_{j=1}^M \underbrace{\begin{cases}+1 & (j\neq 1)\\ \mp 1 & (j=1)\end{cases}\begin{cases}+1 & (j\neq 1)\\ \mp 1 & (j=1)\end{cases}}_{\text{符号が } j \text{ に関わらず一致}=1}\exp\!\left(-i\frac{2\pi}{M}(j\mu+j\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})} \\
&= \sum_{j=1}^M \exp\!\left(-i\frac{2\pi j}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})} \\
&= 2M\,\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})} \quad (\because \text{exp\_sum})
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
&= \sum_{j=1}^M \underbrace{\begin{cases}+1 & (j\neq 1)\\ \mp 1 & (j=1)\end{cases}\begin{cases}+1 & (j\neq 1)\\ \pm 1 & (j=1)\end{cases}}_{j=1 \text{ のみ } -1,\ \text{他は } +1}\exp\!\left(-i\frac{2\pi}{M}(j\mu+j\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})} \\
&= \underbrace{\left(-2\exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)}_{j=1 \text{ の項を打ち消すために 2 回引く}} + \sum_{j=1}^M \exp\!\left(-i\frac{2\pi}{M}(j\mu+j\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})} \\
&= \underbrace{2M\,\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}}_{[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\pm)}]_+} + \left(-2\exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
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
        "抽象テンソル積の記法を廃した。I_{(C^2)^{⊗M}}（抽象テンソル冪の単位元）を、" +
          "<def_kronecker> で具体的に定義された 2^M 次の単位行列 I_{Mat(2^M,C)} へ置き換えた。" +
          "また第 1 式・第 4 式の右辺は単位行列を裸の I と書いていて何次の単位行列か不定だったので、" +
          "他式と同じ I_{Mat(2^M,C)} に揃えた。等式が 2^M 次の複素行列の等式であることを" +
          "statement 冒頭に明示した（README のゴール設定 2 節に従う）。",
      ],
    },
  },
]);
