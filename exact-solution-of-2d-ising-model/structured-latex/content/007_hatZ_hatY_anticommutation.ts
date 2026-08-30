import { defineBlocks, paragraph, math, displayMath, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "heading_hatZ_hatY_anticommutation",
    kind: "heading",
    level: 2,
    origin: { path: "_old/typst/main.typ", ordinal: 9 },
    title: { tex: String.raw`\hat{Z}\text{と}\hat{Y}\text{の反交換関係}` },
    labels: [],
  },
  {
    id: "hatZ_hatY_anticommutation_001_claim_anticommutation_relations",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/007_hatZとhatYの反交換関係/000_claim_hatZ同士_hatZとhatY_hatY同士の反交換関係.typ",
      ordinal: 1,
    },
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
        "はじめに記号を 1 つ置く。",
        math(String.raw`j \in \{1,\dots,M\}`),
        " について ",
        math(String.raw`\varepsilon^{(\pm)}_j := \begin{cases}\mp 1 & (j=1)\\ +1 & (j\neq 1)\end{cases} \in \{+1,-1\}`),
        " とすると、",
        ref("def_hatZ_hatY"),
        " の定義は ",
        math(String.raw`\hat{Z}_\mu^{(\pm)} = \sum_{j=1}^M \varepsilon^{(\pm)}_j Z_j\exp\!\left(-i\frac{2\pi j\mu}{M}\right)`),
        " と書ける。",
        math(String.raw`\varepsilon^{(\pm)}_j`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の元であり、行列の積と可換に動かせる。",
      ]),
      paragraph([
        math(String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\pm)}]_+`),
        " の計算:",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\pm)}]_+
&= \left[\sum_{j=1}^M \varepsilon^{(\pm)}_j Z_j\exp\!\left(-i \frac{2\pi j\mu}{M}\right),\ \sum_{k=1}^M \varepsilon^{(\pm)}_k Z_k\exp\!\left(-i \frac{2\pi k\nu}{M}\right)\right]_+
&&(\because\ \hat{Z}^{(\pm)}_\mu\ \text{の定義、および上で置いた記号}) \\
&= \left(\sum_{j=1}^M \varepsilon^{(\pm)}_j Z_j\exp\!\left(-i \frac{2\pi j\mu}{M}\right)\right)\left(\sum_{k=1}^M \varepsilon^{(\pm)}_k Z_k\exp\!\left(-i \frac{2\pi k\nu}{M}\right)\right) \\
&\quad + \left(\sum_{k=1}^M \varepsilon^{(\pm)}_k Z_k\exp\!\left(-i \frac{2\pi k\nu}{M}\right)\right)\left(\sum_{j=1}^M \varepsilon^{(\pm)}_j Z_j\exp\!\left(-i \frac{2\pi j\mu}{M}\right)\right)
&&(\because\ \text{反交換子の定義}) \\
&= \sum_{j,k=1}^M \varepsilon^{(\pm)}_j\varepsilon^{(\pm)}_k\, Z_j Z_k\exp\!\left(-i\frac{2\pi}{M}(j\mu+k\nu)\right) \\
&\quad + \sum_{j,k=1}^M \varepsilon^{(\pm)}_k\varepsilon^{(\pm)}_j\, Z_k Z_j\exp\!\left(-i\frac{2\pi}{M}(k\nu+j\mu)\right)
&&(\because\ \text{有限和どうしの積を二重和へ開いた（分配則）}) \\
&= \sum_{j,k=1}^M \varepsilon^{(\pm)}_j\varepsilon^{(\pm)}_k\exp\!\left(-i\frac{2\pi}{M}(j\mu+k\nu)\right)(Z_j Z_k + Z_k Z_j)
&&(\because\ \text{2 つの二重和をまとめ、}\ \mathbb{C}\ \text{の係数を前へ出した}) \\
&= \sum_{j,k=1}^M \varepsilon^{(\pm)}_j\varepsilon^{(\pm)}_k\exp\!\left(-i\frac{2\pi}{M}(j\mu+k\nu)\right)[Z_j, Z_k]_+
&&(\because\ \text{反交換子の定義}) \\
&= \sum_{j,k=1}^M \varepsilon^{(\pm)}_j\varepsilon^{(\pm)}_k\exp\!\left(-i\frac{2\pi}{M}(j\mu+k\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}\,\delta^M_{(j,k)}
&&(\because\ Z\ \text{と}\ Y\ \text{の反交換関係の第 1 式}) \\
&= \sum_{j=1}^M \varepsilon^{(\pm)}_j\varepsilon^{(\pm)}_j\exp\!\left(-i\frac{2\pi}{M}(j\mu+j\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because\ \text{クロネッカーのデルタの定義により}\ k\neq j\ \text{の項が消える}) \\
&= \sum_{j=1}^M \exp\!\left(-i\frac{2\pi}{M}(j\mu+j\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because\ \varepsilon^{(\pm)}_j \in \{+1,-1\}\ \text{なので}\ \varepsilon^{(\pm)}_j\varepsilon^{(\pm)}_j = 1) \\
&= \sum_{j=1}^M \exp\!\left(-i\frac{2\pi j}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because\ j\mu+j\nu = j(\mu+\nu)) \\
&= 2M\,\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because\ \text{1 の冪根の総和の公式を}\ k=-(\mu+\nu)\ \text{で使った})
\end{aligned}`,
      ),
      paragraph([
        "この鎖で引いたブロックは ",
        ref("def_hatZ_hatY"),
        "（第 1 段）、",
        ref("anticommutator_of_Z_and_Y"),
        "（第 6 段）、",
        ref("def_delta_M"),
        "（第 7 段）、",
        ref("exp_sum"),
        "（第 10 段）である",
        "（この生成器は数式の中からブロックを引く手段を持たないので、行末の ",
        math(String.raw`(\because\ \dots)`),
        " には題を書き、参照をここに置いた）。",
      ]),
      paragraph([
        math(String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\mp)}]_+`),
        " の計算に入る前に、2 つの符号の積の値を求めておく。",
        math(String.raw`j=1`),
        " のとき（複合同順）",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon^{(\pm)}_1\varepsilon^{(\mp)}_1
&= (\mp 1)(\pm 1)
&&(\because\ \varepsilon^{(\pm)}_j\ \text{の定義の}\ j=1\ \text{の場合を 2 つの符号へ当てた}) \\
&= -1
&&(\because\ \text{実数の積}\ (-1)(+1) = (+1)(-1) = -1)
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`j\neq 1`),
        " のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon^{(\pm)}_j\varepsilon^{(\mp)}_j
&= (+1)(+1)
&&(\because\ \varepsilon^{(\pm)}_j\ \text{の定義の}\ j\neq 1\ \text{の場合を 2 つの符号へ当てた}) \\
&= +1
&&(\because\ \text{実数の積}\ 1\cdot 1 = 1)
\end{aligned}`,
      ),
      paragraph([
        "である。すなわち ",
        math(String.raw`j=1`),
        " の項だけ符号が反転する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\mp)}]_+
&= \sum_{j=1}^M \varepsilon^{(\pm)}_j\varepsilon^{(\mp)}_j\exp\!\left(-i\frac{2\pi}{M}(j\mu+j\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because\ \text{第 1 式の鎖の第 1 段から第 8 段までと同じ計算。第 2 の因子の符号だけが}\ \varepsilon^{(\mp)}\ \text{である}) \\
&= \varepsilon^{(\pm)}_1\varepsilon^{(\mp)}_1\exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
 + \sum_{j=2}^M \varepsilon^{(\pm)}_j\varepsilon^{(\mp)}_j\exp\!\left(-i\frac{2\pi}{M}(j\mu+j\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because\ \text{有限和から}\ j=1\ \text{の項を分けた}) \\
&= (-1)\exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
 + \sum_{j=2}^M \exp\!\left(-i\frac{2\pi}{M}(j\mu+j\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because\ \text{上で求めた符号の積の値}) \\
&= (-1)\exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})} \\
&\quad + \left(\sum_{j=1}^M \exp\!\left(-i\frac{2\pi}{M}(j\mu+j\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
 - \exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
&&(\because\ j=1\ \text{の項を足して引いた}) \\
&= \sum_{j=1}^M \exp\!\left(-i\frac{2\pi}{M}(j\mu+j\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
 + \left(-2\exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
&&(\because\ \text{同じ項どうしをまとめた}) \\
&= \sum_{j=1}^M \exp\!\left(-i\frac{2\pi j}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
 + \left(-2\exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
&&(\because\ j\mu+j\nu = j(\mu+\nu)) \\
&= 2M\,\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
 + \left(-2\exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
&&(\because\ \text{1 の冪根の総和の公式を}\ k=-(\mu+\nu)\ \text{で使った})
\end{aligned}`,
      ),
      paragraph([
        "この鎖で引いたブロックは ",
        ref("def_delta_M"),
        "（第 7 段）、",
        ref("exp_sum"),
        "（第 7 段）である",
        "（第 1 段が引くブロックは第 1 式の鎖と同じである）。",
      ]),
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
        "原文の場合分け記法は KaTeX の cases 環境で表記した。" +
          "ただし第 1 式の鎖では、符号の場合分けに ε^{(±)}_j という名前を証明の冒頭で与え、" +
          "各行の根拠を行末の (∵ …) で書けるようにした。第 2 式の鎖も同じ名前を使い、" +
          "符号の積の値を計算の前に求めてから 7 段の鎖にした（cases の下線つき注記を廃した）。",
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
