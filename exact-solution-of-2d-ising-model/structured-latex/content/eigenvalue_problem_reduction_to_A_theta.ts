import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

/**
 * 部「固有値問題」の章「離散 Fourier 変換による 2×2 行列 A(θ̃_μ) への帰着」。章立て（`tools/chapter-plan.ts`）で
 * この章に割り当てた項を、章の中の依存順に並べる。章の最後は、この章のゴールの式を主張するブロックである。
 */

export default defineBlocks([
  {
    id: "heading_part_eigenvalue_problem",
    kind: "heading",
    level: 1,
    title: { text: "固有値問題" },
    labels: [],
  },
  {
    id: "heading_chapter_reduction_to_A_theta",
    kind: "heading",
    level: 2,
    title: { tex: String.raw`\text{離散 Fourier 変換による }2\times2\text{ 行列 }A(\tilde\theta_\mu)\text{ への帰着}` },
    labels: [],
  },
  {
    id: "transfer_matrix_008_definition_delta_M",
    kind: "definition",
    origin: { path: "_old/typst/parts/004_転送行列/007_definition_クロネッカーのデルタ_delta_M.typ", ordinal: 8 },
    title: { tex: String.raw`\delta^{(M_{\mathrm{col}})}_{(\mu,\nu)} \text{ の定義}` },
    labels: ["def_delta_M"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{N}_{\geq 1}`),
        " とし、",
        math(String.raw`\mu,\nu \in \mathbb{Z}`),
        " とする。",
      ]),
      displayMath(
        String.raw`\delta^{M_{\mathrm{col}}} : \mathbb{Z}\times\mathbb{Z}\longrightarrow\mathbb{C},\qquad
\delta^{(M_{\mathrm{col}})}_{(\mu,\nu)} :=
\begin{cases}
1 & (\mu \equiv \nu \pmod{M_{\mathrm{col}}}) \\
0 & (\mu \not\equiv \nu \pmod{M_{\mathrm{col}}})
\end{cases}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-09-20: M を正の自然数、μ,ν を整数として明記し、δ^M の定義域と値域を ℤ×ℤ→ℂ とした。Lean の M : ℕ, M ≠ 0 および SageMath の正の M という検査範囲に仮定を同期した。合同条件は変えていない。",
      ],
    },
  },
  {
    id: "transfer_matrix_009_claim_exp_sum",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/008_claim_指数関数の和とクロネッカーのデルタの関係.typ", ordinal: 9 },
    title: null,
    labels: ["exp_sum"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{N}_{\geq 1}`),
        " とし、",
        math(String.raw`k \in \mathbb{Z}`),
        " について、",
      ]),
      displayMath(
        String.raw`\sum_{j=1}^{M_{\mathrm{col}}} \exp\!\left(\frac{2\pi i j k}{M_{\mathrm{col}}}\right) = M_{\mathrm{col}}\,\delta^{(M_{\mathrm{col}})}_{(k,0)}`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`k \equiv 0 \pmod{M_{\mathrm{col}}}`),
        " であるか否かで場合を分ける。",
      ]),
      paragraph([
        math(String.raw`(a)\; k \equiv 0 \pmod{M_{\mathrm{col}}}`),
        " のとき。",
        math(String.raw`k = lM_{\mathrm{col}}`),
        " を満たす ",
        math(String.raw`l \in \mathbb{Z}`),
        " を 1 つ取る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{j=1}^{M_{\mathrm{col}}} \exp\!\left(\frac{2\pi i j k}{M_{\mathrm{col}}}\right)
&= \sum_{j=1}^{M_{\mathrm{col}}} \exp\!\left(\frac{2\pi i j \cdot lM_{\mathrm{col}}}{M_{\mathrm{col}}}\right)
&&(\because\ k = lM_{\mathrm{col}}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}} \exp\!\left(2\pi i\, l j\right)
&&(\because\ M_{\mathrm{col}}\geq1\ \text{より}\ M_{\mathrm{col}}\neq0\ \text{なので約分した}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}} \left(\cos 2\pi l j + i \sin 2\pi l j\right)
&&(\because\ \text{オイラーの公式}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}} \left(1 + i \cdot 0\right)
&&(\because\ lj \in \mathbb{Z}\ \text{なので}\ \cos 2\pi lj = 1,\ \sin 2\pi lj = 0) \\
&= \sum_{j=1}^{M_{\mathrm{col}}} 1
&&(\because\ 1 + i \cdot 0 = 1) \\
&= M_{\mathrm{col}}
&&(\because\ \text{項数が}\ M_{\mathrm{col}}\ \text{である}) \\
&= M_{\mathrm{col}}\,\delta^{(M_{\mathrm{col}})}_{(k,0)}
&&(\because\ k \equiv 0 \pmod{M_{\mathrm{col}}}\ \text{なので}\ \delta^{(M_{\mathrm{col}})}_{(k,0)} = 1\ \text{である})
\end{aligned}`,
      ),
      paragraph([
        "引いたのは ",
        ref("euler_formula_cos_sin"),
        " と ",
        ref("def_delta_M"),
        " である。",
      ]),
      paragraph([
        math(String.raw`(b)\; k \not\equiv 0 \pmod{M_{\mathrm{col}}}`),
        " のとき。",
        math(String.raw`r := \exp\!\left(\frac{2\pi i k}{M_{\mathrm{col}}}\right) \in \mathbb{C}`),
        " と置く。",
        math(String.raw`k \not\equiv 0 \pmod{M_{\mathrm{col}}}`),
        " なので ",
        math(String.raw`r \neq 1`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{j=1}^{M_{\mathrm{col}}} \exp\!\left(\frac{2\pi i j k}{M_{\mathrm{col}}}\right)
&= \sum_{j=1}^{M_{\mathrm{col}}} r^{\,j}
&&(\because\ r\ \text{の定義と}\ \exp(a)^{j} = \exp(ja)) \\
&= r \cdot \frac{1 - r^{M_{\mathrm{col}}}}{1 - r}
&&(\because\ \text{等比数列の和の公式（}r \neq 1\text{）}) \\
&= r \cdot \frac{1 - \exp\!\left(2\pi i k\right)}{1 - r}
&&(\because\ r^{M_{\mathrm{col}}} = \exp\!\left(2\pi i k\right)) \\
&= r \cdot \frac{1 - 1}{1 - r}
&&(\because\ k \in \mathbb{Z}\ \text{なので}\ \exp(2\pi i k) = 1) \\
&= 0
&&(\because\ 1 - 1 = 0\ \text{であり、分子が}\ 0\ \text{の分数は}\ 0\ \text{である（}1 - r \neq 0\text{）}) \\
&= M_{\mathrm{col}}\,\delta^{(M_{\mathrm{col}})}_{(k,0)}
&&(\because\ k \not\equiv 0 \pmod{M_{\mathrm{col}}}\ \text{なので}\ \delta^{(M_{\mathrm{col}})}_{(k,0)} = 0\ \text{である})
\end{aligned}`,
      ),
      paragraph([
        "引いたのは ",
        ref("def_delta_M"),
        " である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-09-20: M を正の自然数として明記し、約分に使う M≠0 の根拠を補った。Lean の M : ℕ, hM : M ≠ 0 および SageMath の M = 1,...,12 という検査範囲に仮定を同期した。主張の数学的内容は変えていない。",
      ],
    },
  },
  {
    id: "Z_Y_anticommutation_001_claim_anticommutation_relations_Z_and_Y",
    kind: "claim",
    standing: "mainTheorem",
    origin: {
      path: "_old/typst/parts/006_ZとYの反交換関係/000_claim_Z_muとZ_nuとY_muとY_nuの反交換関係.typ",
      ordinal: 1,
    },
    title: { tex: String.raw`Z\text{と}Y\text{の反交換関係}` },
    labels: ["anticommutator_of_Z_and_Y"],
    statement: [
      displayMath(
        String.raw`[Z_\mu, Z_\nu]_+ = 2I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})} \delta^{(M_{\mathrm{col}})}_{(\mu,\nu)}, \quad
[Z_\mu, Y_\nu]_+ = 0, \quad
[Y_\mu, Y_\nu]_+ = 2I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})} \delta^{(M_{\mathrm{col}})}_{(\mu,\nu)}`,
      ),
    ],
    proof: [
      paragraph([
        "記号を固定する。",
        math(String.raw`I := I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "（",
        math(String.raw`2`),
        " 次の単位行列）とし、",
        math(String.raw`I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        " を ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 次の単位行列とする。",
        ref("kronecker_product_rule"),
        " (2) より",
        math(String.raw`\ I\boxtimes\cdots\boxtimes I = I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        "（左辺は ",
        math(String.raw`M_{\mathrm{col}}`),
        " 個のクロネッカー積）である。",
        math(String.raw`\sigma^x,\sigma^y,\sigma^z \in \mathrm{Mat}(2,\mathbb{C})`),
        " は ",
        ref("pauli_matrix_products"),
        " の Pauli 行列である。",
      ]),
      paragraph([
        "添字について。",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`Z_m, Y_m`),
        " は ",
        math(String.raw`m \in \{1,\dots,M_{\mathrm{col}}\}`),
        " に対して定義され、",
        math(String.raw`Z_{M_{\mathrm{col}}+1} := Z_1`),
        "、",
        math(String.raw`Y_{M_{\mathrm{col}}+1} := Y_1`),
        " と ",
        math(String.raw`M_{\mathrm{col}}`),
        " 周期に拡張されている。よって ",
        math(String.raw`Z_\mu, Y_\nu`),
        " は添字の ",
        math(String.raw`M_{\mathrm{col}}`),
        " を法とする剰余類のみで定まり、代表元を ",
        math(String.raw`\mu,\nu \in \{1,\dots,M_{\mathrm{col}}\}`),
        " にとってよい。この範囲では ",
        math(String.raw`\mu \equiv \nu \pmod M_{\mathrm{col}} \iff \mu = \nu`),
        " であるから、",
      ]),
      displayMath(
        String.raw`\delta^{(M_{\mathrm{col}})}_{(\mu,\nu)} =
\begin{cases}
1 & (\mu = \nu) \\
0 & (\mu \neq \nu)
\end{cases}
\qquad (\mu,\nu \in \{1,\dots,M_{\mathrm{col}}\})
\qquad\bigl(\because\ \blkref{def_delta_M}\text{ の定義}\bigr)`,
      ),
      paragraph([
        "クロネッカー積による表示。",
        math(String.raw`m \in \{1,\dots,M_{\mathrm{col}}\}`),
        " に対し、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\sigma_k^a`),
        " が「第 ",
        math(String.raw`k`),
        " 因子だけが ",
        math(String.raw`\sigma^a`),
        " で他は ",
        math(String.raw`I`),
        " であるクロネッカー積」であることと、",
        ref("kronecker_product_rule"),
        " (1)（クロネッカー積どうしの積は各サイトごとの積）および ",
        math(String.raw`I\sigma^a = \sigma^a I = \sigma^a`),
        " から、",
      ]),
      displayMath(
        String.raw`\sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^a
= \overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(m-1)\text{th}}
\boxtimes\overbrace{\sigma^a}^{m\text{th}}
\boxtimes\overbrace{I}^{(m+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}
\quad (a \in \{x,y,z\})`,
      ),
      paragraph([
        "が成り立つ。特に ",
        ref("def_transfer_matrix_symbols"),
        " の定義により",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_\mu &= \overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}
&&\bigl(\because\ \blkref{def_transfer_matrix_symbols}\text{ の }Z_\mu\text{ の定義と、直前の表示を }a=z\text{ で読む}\bigr)\\
Y_\mu &= \overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}
&&\bigl(\because\ \blkref{def_transfer_matrix_symbols}\text{ の }Y_\mu\text{ の定義と、直前の表示を }a=y\text{ で読む}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\mu = 1`),
        " のときは第 1 因子の左に因子が無い）。この端の場合も次の一続きで定義と一致する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_1
&= \sigma^z\boxtimes I\boxtimes\cdots\boxtimes I
&&\bigl(\because\ \text{上のクロネッカー積表示を }\mu=1\text{ で読む}\bigr)\\
&= \sigma_1^z
&&\bigl(\because\ \blkref{def_transfer_matrix_symbols}\text{ の }\sigma_1^z\text{ の定義}\bigr)\\[2mm]
Y_1
&= \sigma^y\boxtimes I\boxtimes\cdots\boxtimes I
&&\bigl(\because\ \text{上のクロネッカー積表示を }\mu=1\text{ で読む}\bigr)\\
&= \sigma_1^y
&&\bigl(\because\ \blkref{def_transfer_matrix_symbols}\text{ の }\sigma_1^y\text{ の定義}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "また ",
        math(String.raw`\mu = M_{\mathrm{col}}`),
        " のときは第 ",
        math(String.raw`M_{\mathrm{col}}`),
        " 因子の右に因子が無い。",
      ]),

      paragraph([
        "以下、",
        math(String.raw`\mu,\nu \in \{1,\dots,M_{\mathrm{col}}\}`),
        " を固定して 3 つの式を順に示す。",
      ]),

      paragraph([
        "【第 1 式】",
        math(String.raw`[Z_\mu, Z_\nu]_+ = 2I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}\delta^{(M_{\mathrm{col}})}_{(\mu,\nu)}`),
        "。",
      ]),
      paragraph([math(String.raw`\mu = \nu`), " のとき、因子ごとの積をとると"]),
      displayMath(
        String.raw`\begin{aligned}
Z_\mu Z_\mu
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^z\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \blkref{kronecker_product_rule}\text{ の積の規則}) \\
&= \overbrace{I}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{I}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^z\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \sigma^x\sigma^x = I.\ \blkref{pauli_matrix_products}) \\
&= \overbrace{I}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{I}^{(\mu-1)\text{th}}
\boxtimes\overbrace{I}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \sigma^z\sigma^z = I.\ \blkref{pauli_matrix_products}) \\
&= I\boxtimes\cdots\boxtimes I
&&(\because\ II = I) \\
&= I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&(\because\ \blkref{kronecker_product_rule}\text{ の単位行列の規則})
\end{aligned}`,
      ),
      paragraph(["であるから"]),
      displayMath(
        String.raw`\begin{aligned}
[Z_\mu, Z_\mu]_+
&= Z_\mu Z_\mu + Z_\mu Z_\mu
&&(\because\ \text{反交換子の定義}) \\
&= I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})} + I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&(\because\ \text{上の計算を 2 箇所へ適用}) \\
&= 2 I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&(\because\ \text{同じ行列の和}) \\
&= 2 I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}\,\delta^{(M_{\mathrm{col}})}_{(\mu,\mu)}
&&(\because\ \delta^{(M_{\mathrm{col}})}_{(\mu,\mu)} = 1)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\mu < \nu`),
        " のとき、",
        math(String.raw`Z_\mu, Z_\nu`),
        " をクロネッカー積で表して各サイトごとに積をとると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_\mu Z_\nu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^x}^{\mu\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\nu\text{th}}
\boxtimes\overbrace{I}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}\right)
&&(\because\ \text{上のクロネッカー積による表示}) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{(I\sigma^x)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(I\sigma^x)}^{(\nu-1)\text{th}}
\boxtimes\overbrace{(I\sigma^z)}^{\nu\text{th}}
\boxtimes\overbrace{(II)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \blkref{kronecker_product_rule}\text{ の積の規則}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^x\sigma^x = II = I,\ I\sigma^a = \sigma^a)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
Z_\nu Z_\mu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^x}^{\mu\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\nu\text{th}}
\boxtimes\overbrace{I}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}\right)
&&(\because\ \text{上のクロネッカー積による表示}) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{(\sigma^x I)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x I)}^{(\nu-1)\text{th}}
\boxtimes\overbrace{(\sigma^z I)}^{\nu\text{th}}
\boxtimes\overbrace{(II)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \blkref{kronecker_product_rule}\text{ の積の規則}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^x\sigma^x = II = I,\ \sigma^a I = \sigma^a)
\end{aligned}`,
      ),
      paragraph([
        "2 つの結果は第 ",
        math(String.raw`\mu`),
        " 因子のみが異なり、そこでは ",
        math(String.raw`\sigma^x\sigma^z = -\,\sigma^z\sigma^x`),
        "（",
        ref("pauli_matrix_products"),
        "）である。クロネッカー積の第 ",
        math(String.raw`\mu`),
        " 因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("kronecker_multilinear"),
        "）よりスカラー ",
        math(String.raw`-1`),
        " が外へ出て、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_\nu Z_\mu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \text{上の計算}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(-\,\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^x\sigma^z = -\,\sigma^z\sigma^x.\ \blkref{pauli_matrix_products}) \\
&= -\left(I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I\right)
&&(\because\ \blkref{kronecker_multilinear}\text{ の第 }\mu\text{ 因子についての線型性}) \\
&= -\,Z_\mu Z_\nu
&&(\because\ \text{上の計算})
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
[Z_\mu, Z_\nu]_+
&= Z_\mu Z_\nu + Z_\nu Z_\mu
&&(\because\ \text{反交換子の定義}) \\
&= Z_\mu Z_\nu + (-\,Z_\mu Z_\nu)
&&(\because\ \text{直前の等式}) \\
&= 0
&&(\because\ \text{加法の逆元})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\mu > \nu`),
        " のときは、上と同じ計算で ",
        math(String.raw`\mu`),
        " と ",
        math(String.raw`\nu`),
        " の役割が入れ替わる。因子ごとの積は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_\mu Z_\nu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \blkref{kronecker_product_rule}\text{ の積の規則と}\ \sigma^x\sigma^x = II = I) \\
Z_\nu Z_\mu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \blkref{kronecker_product_rule}\text{ の積の規則と}\ \sigma^x\sigma^x = II = I)
\end{aligned}`,
      ),
      paragraph([
        "であり（第 ",
        math(String.raw`i < \nu`),
        " 因子は ",
        math(String.raw`\sigma^x\sigma^x = I`),
        "、",
        math(String.raw`\nu < i < \mu`),
        " では一方が ",
        math(String.raw`I`),
        " なので ",
        math(String.raw`\sigma^x`),
        "、第 ",
        math(String.raw`\mu`),
        " 因子は一方が ",
        math(String.raw`I`),
        " なので ",
        math(String.raw`\sigma^z`),
        "、",
        math(String.raw`i > \mu`),
        " では ",
        math(String.raw`II = I`),
        "）、食い違うのは第 ",
        math(String.raw`\nu`),
        " 因子だけで ",
        math(String.raw`\sigma^z\sigma^x = -\,\sigma^x\sigma^z`),
        "（",
        ref("pauli_matrix_products"),
        "）である。クロネッカー積の第 ",
        math(String.raw`\nu`),
        " 因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("kronecker_multilinear"),
        "）でスカラー ",
        math(String.raw`-1`),
        " を外へ出すと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_\nu Z_\mu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \text{上の計算}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(-\,\sigma^x\sigma^z)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^z\sigma^x = -\,\sigma^x\sigma^z.\ \blkref{pauli_matrix_products}) \\
&= -\left(I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I\right)
&&(\because\ \blkref{kronecker_multilinear}\text{ の第 }\nu\text{ 因子についての線型性}) \\
&= -\,Z_\mu Z_\nu
&&(\because\ \text{上の計算})
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
[Z_\mu, Z_\nu]_+
&= Z_\mu Z_\nu + Z_\nu Z_\mu
&&(\because\ \text{反交換子の定義}) \\
&= Z_\mu Z_\nu + (-\,Z_\mu Z_\nu)
&&(\because\ \text{直前の等式}) \\
&= 0
&&(\because\ \text{加法の逆元})
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`\mu \neq \nu`),
        " では ",
        math(String.raw`[Z_\mu,Z_\nu]_+ = 0 = 2I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}\delta^{(M_{\mathrm{col}})}_{(\mu,\nu)}`),
        " であり、第 1 式が示された。",
      ]),

      paragraph([
        "【第 2 式】",
        math(String.raw`[Z_\mu, Y_\nu]_+ = 0`),
        "。この式は ",
        math(String.raw`\mu = \nu`),
        " の場合も含めてすべての ",
        math(String.raw`\mu,\nu`),
        " で成り立つ（対角成分も消える）。",
        math(String.raw`\mu = \nu`),
        "、",
        math(String.raw`\mu < \nu`),
        "、",
        math(String.raw`\mu > \nu`),
        " の 3 通りに分ける。",
      ]),
      paragraph([
        math(String.raw`\mu = \nu`),
        " のとき、",
        math(String.raw`Z_\mu`),
        " と ",
        math(String.raw`Y_\mu`),
        " は第 ",
        math(String.raw`\mu`),
        " 因子以外がすべて等しいので、因子ごとの積をとると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_\mu Y_\mu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}\right)
&&(\because\ Z_\mu,\ Y_\mu\ \text{の定義}) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^z\sigma^y)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \blkref{kronecker_product_rule}\text{ の積の規則}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^y)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \sigma^x\sigma^x = I.\ \blkref{pauli_matrix_products}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^y)}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ II = I.\ \text{単位行列どうしの積})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
Y_\mu Z_\mu
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^y\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \blkref{kronecker_product_rule}\text{ の積の規則}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \sigma^x\sigma^x = I.\ \blkref{pauli_matrix_products}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^z)}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ II = I.\ \text{単位行列どうしの積})
\end{aligned}`,
      ),
      paragraph([
        "食い違うのは第 ",
        math(String.raw`\mu`),
        " 因子だけであり、",
        ref("pauli_matrix_products"),
        " より ",
        math(String.raw`\sigma^y\sigma^z = -\,\sigma^z\sigma^y`),
        "。クロネッカー積の第 ",
        math(String.raw`\mu`),
        " 因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("kronecker_multilinear"),
        "）でスカラー ",
        math(String.raw`-1`),
        " を外へ出すと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_\mu Z_\mu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^z)}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \text{上の計算}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(-\,\sigma^z\sigma^y)}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^y\sigma^z = -\,\sigma^z\sigma^y.\ \blkref{pauli_matrix_products}) \\
&= -\left(I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^y)}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I\right)
&&(\because\ \blkref{kronecker_multilinear}\text{ の第 }\mu\text{ 因子についての線型性}) \\
&= -\,Z_\mu Y_\mu
&&(\because\ \text{上の計算})
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
[Z_\mu, Y_\mu]_+
&= Z_\mu Y_\mu + Y_\mu Z_\mu
&&(\because\ \text{反交換子の定義}) \\
&= Z_\mu Y_\mu + (-\,Z_\mu Y_\mu)
&&(\because\ \text{直前の等式}) \\
&= 0
&&(\because\ \text{加法の逆元})
\end{aligned}`,
      ),
      paragraph([
        "（これは ",
        ref("tensor_anticommutation_from_single_site"),
        " を ",
        math(String.raw`j = \mu`),
        "、",
        math(String.raw`x_i, y_i`),
        " を上の各因子として適用した形でもある。）",
      ]),
      paragraph([
        math(String.raw`\mu < \nu`),
        " のとき、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_\mu Y_\nu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^x}^{\mu\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes\overbrace{I}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}\right)
&&(\because\ Z_\mu,\ Y_\nu\ \text{の定義}) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{(I\sigma^x)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(I\sigma^x)}^{(\nu-1)\text{th}}
\boxtimes\overbrace{(I\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{(II)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \blkref{kronecker_product_rule}\text{ の積の規則}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{(I\sigma^x)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(I\sigma^x)}^{(\nu-1)\text{th}}
\boxtimes\overbrace{(I\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{(II)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \sigma^x\sigma^x = I.\ \blkref{pauli_matrix_products}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes\overbrace{(II)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ I\ \text{は積の単位元}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ II = I.\ \text{単位行列どうしの積})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
Y_\nu Z_\mu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^x}^{\mu\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes\overbrace{I}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}\right)
&&(\because\ Y_\nu,\ Z_\mu\ \text{の定義}) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{(\sigma^x I)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x I)}^{(\nu-1)\text{th}}
\boxtimes\overbrace{(\sigma^y I)}^{\nu\text{th}}
\boxtimes\overbrace{(II)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \blkref{kronecker_product_rule}\text{ の積の規則}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{(\sigma^x I)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x I)}^{(\nu-1)\text{th}}
\boxtimes\overbrace{(\sigma^y I)}^{\nu\text{th}}
\boxtimes\overbrace{(II)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \sigma^x\sigma^x = I.\ \blkref{pauli_matrix_products}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes\overbrace{(II)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ I\ \text{は積の単位元}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ II = I.\ \text{単位行列どうしの積})
\end{aligned}`,
      ),
      paragraph([
        "第 ",
        math(String.raw`i`),
        " 因子を ",
        math(String.raw`i`),
        " の範囲ごとに比べると、",
        math(String.raw`i < \mu`),
        " では両者とも ",
        math(String.raw`I`),
        "、",
        math(String.raw`\mu < i < \nu`),
        " では両者とも ",
        math(String.raw`\sigma^x`),
        "、",
        math(String.raw`i = \nu`),
        " では両者とも ",
        math(String.raw`\sigma^y`),
        "、",
        math(String.raw`i > \nu`),
        " では両者とも ",
        math(String.raw`I`),
        " で一致する。食い違うのは第 ",
        math(String.raw`\mu`),
        " 因子だけで、そこは ",
        math(String.raw`\sigma^z\sigma^x`),
        " と ",
        math(String.raw`\sigma^x\sigma^z = -\,\sigma^z\sigma^x`),
        "（",
        ref("pauli_matrix_products"),
        "）である。クロネッカー積の第 ",
        math(String.raw`\mu`),
        " 因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("kronecker_multilinear"),
        "）でスカラー ",
        math(String.raw`-1`),
        " を外へ出して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_\nu Z_\mu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \text{上の計算}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(-\,\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^x\sigma^z = -\,\sigma^z\sigma^x.\ \blkref{pauli_matrix_products}) \\
&= -\left(I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I\right)
&&(\because\ \blkref{kronecker_multilinear}\text{ の第 }\mu\text{ 因子についての線型性}) \\
&= -\,Z_\mu Y_\nu
&&(\because\ \text{上の計算})
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
[Z_\mu, Y_\nu]_+
&= Z_\mu Y_\nu + Y_\nu Z_\mu
&&(\because\ \text{反交換子の定義}) \\
&= Z_\mu Y_\nu + (-\,Z_\mu Y_\nu)
&&(\because\ \text{直前の等式}) \\
&= 0
&&(\because\ \text{加法の逆元})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\mu > \nu`),
        " のとき、",
        math(String.raw`\nu < \mu`),
        " なので第 ",
        math(String.raw`\nu`),
        " 因子で ",
        math(String.raw`Z_\mu`),
        " 側が ",
        math(String.raw`\sigma^x`),
        "、",
        math(String.raw`Y_\nu`),
        " 側が ",
        math(String.raw`\sigma^y`),
        " になる。因子ごとの積をとると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_\mu Y_\nu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^x}^{\nu\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes\overbrace{I}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}\right)
&&(\because\ Z_\mu,\ Y_\nu\ \text{の定義}) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\nu-1)\text{th}}
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{(\sigma^x I)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x I)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^z I)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \blkref{kronecker_product_rule}\text{ の積の規則}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{(\sigma^x I)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x I)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^z I)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \sigma^x\sigma^x = I.\ \blkref{pauli_matrix_products}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ I\ \text{は積の単位元}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ II = I.\ \text{単位行列どうしの積})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
Y_\nu Z_\mu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes\overbrace{I}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^x}^{\nu\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}\right)
&&(\because\ Y_\nu,\ Z_\mu\ \text{の定義}) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\nu-1)\text{th}}
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\nu\text{th}}
\boxtimes\overbrace{(I\sigma^x)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(I\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(I\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \blkref{kronecker_product_rule}\text{ の積の規則}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\nu\text{th}}
\boxtimes\overbrace{(I\sigma^x)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(I\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(I\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \sigma^x\sigma^x = I.\ \blkref{pauli_matrix_products}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ I\ \text{は積の単位元}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ II = I.\ \text{単位行列どうしの積})
\end{aligned}`,
      ),
      paragraph([
        "食い違うのは第 ",
        math(String.raw`\nu`),
        " 因子だけで、そこは ",
        math(String.raw`\sigma^x\sigma^y`),
        " と ",
        math(String.raw`\sigma^y\sigma^x = -\,\sigma^x\sigma^y`),
        "（",
        ref("pauli_matrix_products"),
        "）である。よって同様に、クロネッカー積の第 ",
        math(String.raw`\nu`),
        " 因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("kronecker_multilinear"),
        "）でスカラー ",
        math(String.raw`-1`),
        " が外へ出て",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_\nu Z_\mu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \text{上の計算}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(-\,\sigma^x\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^y\sigma^x = -\,\sigma^x\sigma^y.\ \blkref{pauli_matrix_products}) \\
&= -\left(I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I\right)
&&(\because\ \blkref{kronecker_multilinear}\text{ の第 }\nu\text{ 因子についての線型性}) \\
&= -\,Z_\mu Y_\nu
&&(\because\ \text{上の計算})
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
[Z_\mu, Y_\nu]_+
&= Z_\mu Y_\nu + Y_\nu Z_\mu
&&(\because\ \text{反交換子の定義}) \\
&= Z_\mu Y_\nu + (-\,Z_\mu Y_\nu)
&&(\because\ \text{直前の等式}) \\
&= 0
&&(\because\ \text{加法の逆元})
\end{aligned}`,
      ),
      paragraph([
        "3 通りすべてで ",
        math(String.raw`[Z_\mu, Y_\nu]_+ = 0`),
        " が示されたので、第 2 式が成り立つ。",
      ]),

      paragraph([
        "【第 3 式】",
        math(String.raw`[Y_\mu, Y_\nu]_+ = 2I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}\delta^{(M_{\mathrm{col}})}_{(\mu,\nu)}`),
        "。",
      ]),
      paragraph([math(String.raw`\mu = \nu`), " のとき、因子ごとの積をとると"]),
      displayMath(
        String.raw`\begin{aligned}
Y_\mu Y_\mu
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^y\sigma^y)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \blkref{kronecker_product_rule}\text{ の積の規則}) \\
&= \overbrace{I}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{I}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^y\sigma^y)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \sigma^x\sigma^x = I.\ \blkref{pauli_matrix_products}) \\
&= \overbrace{I}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{I}^{(\mu-1)\text{th}}
\boxtimes\overbrace{I}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \sigma^y\sigma^y = I.\ \blkref{pauli_matrix_products}) \\
&= I\boxtimes\cdots\boxtimes I
&&(\because\ II = I) \\
&= I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&(\because\ \blkref{kronecker_product_rule}\text{ の単位行列の規則})
\end{aligned}`,
      ),
      paragraph(["であるから"]),
      displayMath(
        String.raw`\begin{aligned}
[Y_\mu, Y_\mu]_+
&= Y_\mu Y_\mu + Y_\mu Y_\mu
&&(\because\ \text{反交換子の定義}) \\
&= I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})} + I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&(\because\ \text{上の計算を 2 箇所へ適用}) \\
&= 2 I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&(\because\ \text{同じ行列の和}) \\
&= 2 I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}\,\delta^{(M_{\mathrm{col}})}_{(\mu,\mu)}
&&(\because\ \delta^{(M_{\mathrm{col}})}_{(\mu,\mu)} = 1)
\end{aligned}`,
      ),
      paragraph([math(String.raw`\mu < \nu`), " のとき、因子ごとの積をとると"]),
      displayMath(
        String.raw`\begin{aligned}
Y_\mu Y_\nu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^x}^{\mu\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes\overbrace{I}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}\right)
&&(\because\ \text{上のクロネッカー積による表示}) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{(I\sigma^x)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(I\sigma^x)}^{(\nu-1)\text{th}}
\boxtimes\overbrace{(I\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{(II)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \blkref{kronecker_product_rule}\text{ の積の規則}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^x\sigma^x = II = I,\ I\sigma^a = \sigma^a)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
Y_\nu Y_\mu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^x}^{\mu\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes\overbrace{I}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M_{\mathrm{col}}\text{th}}\right)
&&(\because\ \text{上のクロネッカー積による表示}) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\mu\text{th}}
\boxtimes\overbrace{(\sigma^x I)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x I)}^{(\nu-1)\text{th}}
\boxtimes\overbrace{(\sigma^y I)}^{\nu\text{th}}
\boxtimes\overbrace{(II)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M_{\mathrm{col}}\text{th}}
&&(\because\ \blkref{kronecker_product_rule}\text{ の積の規則}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^x\sigma^x = II = I,\ \sigma^a I = \sigma^a)
\end{aligned}`,
      ),
      paragraph([
        "食い違うのは第 ",
        math(String.raw`\mu`),
        " 因子だけで、そこは ",
        math(String.raw`\sigma^y\sigma^x`),
        " と ",
        math(String.raw`\sigma^x\sigma^y = -\,\sigma^y\sigma^x`),
        "（",
        ref("pauli_matrix_products"),
        "）である。クロネッカー積の第 ",
        math(String.raw`\mu`),
        " 因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("kronecker_multilinear"),
        "）でスカラー ",
        math(String.raw`-1`),
        " を外へ出すと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_\nu Y_\mu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \text{上の計算}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(-\,\sigma^y\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^x\sigma^y = -\,\sigma^y\sigma^x.\ \blkref{pauli_matrix_products}) \\
&= -\left(I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I\right)
&&(\because\ \blkref{kronecker_multilinear}\text{ の第 }\mu\text{ 因子についての線型性}) \\
&= -\,Y_\mu Y_\nu
&&(\because\ \text{上の計算})
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
[Y_\mu, Y_\nu]_+
&= Y_\mu Y_\nu + Y_\nu Y_\mu
&&(\because\ \text{反交換子の定義}) \\
&= Y_\mu Y_\nu + (-\,Y_\mu Y_\nu)
&&(\because\ \text{直前の等式}) \\
&= 0
&&(\because\ \text{加法の逆元})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\mu > \nu`),
        " のときは、上の計算で ",
        math(String.raw`\mu`),
        " と ",
        math(String.raw`\nu`),
        " の役割を入れ替えればよい。因子ごとの積は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_\mu Y_\nu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \blkref{kronecker_product_rule}\text{ の積の規則と}\ \sigma^x\sigma^x = II = I) \\
Y_\nu Y_\mu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \blkref{kronecker_product_rule}\text{ の積の規則と}\ \sigma^x\sigma^x = II = I)
\end{aligned}`,
      ),
      paragraph([
        "であり（第 ",
        math(String.raw`i < \nu`),
        " 因子は ",
        math(String.raw`\sigma^x\sigma^x = I`),
        "、",
        math(String.raw`\nu < i < \mu`),
        " では一方が ",
        math(String.raw`I`),
        " なので ",
        math(String.raw`\sigma^x`),
        "、第 ",
        math(String.raw`\mu`),
        " 因子は一方が ",
        math(String.raw`I`),
        " なので ",
        math(String.raw`\sigma^y`),
        "、",
        math(String.raw`i > \mu`),
        " では ",
        math(String.raw`II = I`),
        "）、食い違うのは第 ",
        math(String.raw`\nu`),
        " 因子だけで ",
        math(String.raw`\sigma^y\sigma^x = -\,\sigma^x\sigma^y`),
        " であるから、クロネッカー積の第 ",
        math(String.raw`\nu`),
        " 因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("kronecker_multilinear"),
        "）でスカラー ",
        math(String.raw`-1`),
        " を外へ出すと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_\nu Y_\mu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \text{上の計算}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(-\,\sigma^x\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^y\sigma^x = -\,\sigma^x\sigma^y.\ \blkref{pauli_matrix_products}) \\
&= -\left(I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I\right)
&&(\because\ \blkref{kronecker_multilinear}\text{ の第 }\nu\text{ 因子についての線型性}) \\
&= -\,Y_\mu Y_\nu
&&(\because\ \text{上の計算})
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
[Y_\mu, Y_\nu]_+
&= Y_\mu Y_\nu + Y_\nu Y_\mu
&&(\because\ \text{反交換子の定義}) \\
&= Y_\mu Y_\nu + (-\,Y_\mu Y_\nu)
&&(\because\ \text{直前の等式}) \\
&= 0
&&(\because\ \text{加法の逆元})
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`\mu \neq \nu`),
        " では ",
        math(String.raw`[Y_\mu,Y_\nu]_+ = 0 = 2I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}\delta^{(M_{\mathrm{col}})}_{(\mu,\nu)}`),
        " であり、第 3 式が示された。以上で 3 式すべてが証明された。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-08-31 の式変形統一で、Z_μ・Y_μ のクロネッカー積表示の二行の根拠（定義の適用と直前の表示の読み）を、" +
          "前置の日本語文だけに置かず、他の証明と同じ行末の根拠列（aligned の &&）へも明記した。内容・式・参照は変えていない。",
        "原文の μ<ν のテンソル積展開を全ステップ忠実に再現した（σ^x σ^z = -σ^z σ^x による相殺）。",
        "原文が TODO のまま残していた [Z_μ,Y_ν]_+ = 0 と [Y_μ,Y_ν]_+ = 2Iδ^M を、" +
          "原文と同じ「テンソル因子を並べて書く」書式で場合分けごとに証明した。" +
          "[Z_μ,Y_ν]_+ は μ=ν でも 0 になる（σ^y σ^z = -σ^z σ^y で対角も消える）ことを明示した。" +
          "設計は lean/Ising2D/Part006/Claim000_AnticommutatorZY.lean（anticomm_Z_Z, anticomm_Z_Y, " +
          "anticomm_Y_Y）を参考にしたが、人手証明は Lean に依存せず自己完結している。",
        "原文の μ<ν の計算はテンソル因子の位置に I_{(C^2)^{⊗M}}（全体の単位元）を書いていたが、" +
          "テンソル因子に入るのは 2×2 の単位行列 I_{Mat(2,C)} なので、そちらへ直した。",
        "原文は μ>ν の場合を「左右対称に同様」で済ませていたが、食い違うサイトが μ から ν へ移るので、" +
          "その場合も因子ごとに書き下した。",
        "抽象テンソル積の記法を廃した。⊗ を <def_kronecker> のクロネッカー積 ⊠ へ、" +
          "Mat(2,C)^{⊗M} を Mat(2^M,C) へ、I_{(C^2)^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ" +
          "置き換えた。根拠として挙げていた「テンソル積代数の積の定義」は " +
          "<kronecker_product_rule> (1)、「テンソル積の第 j 因子についての C-線型性」は " +
          "<kronecker_multilinear> の参照に直した。μ>ν の場合に符号 -1 を外へ出す箇所は" +
          "根拠を書いていなかったので、同じく <kronecker_multilinear> を明示した" +
          "（README のゴール設定 2 節に従う）。",
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
&&\left(\because\ \blkref{matrix_exp_conjugation}\text{ (2)}\right) \\
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
&&\left(\because\ m\in\mathbb{Z}_{\ge 0}\text{ について }\blkref{ad_binomial}\text{ の再帰を反復}\right)
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
&&\left(\because\ \blkref{matrix_exp_conjugation}\text{ (3)}\right)
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
        " から必要な指数の表示を先に作る。",
      ]),
      displayMath(String.raw`\begin{aligned}
-2K_2^*
&=\log(\tanh K_2)
&&(\because\ K_2^*=-\tfrac12\log(\tanh K_2)\text{ と }\mathbb R\text{ の四則})\\
\exp(-2K_2^*)
&=\exp(\log(\tanh K_2))
&&(\because\ \text{直前の等式の両辺の指数})\\
&=\tanh K_2
&&(\because\ 0<\tanh K_2\text{ と実対数・指数の逆写像性})\\
\exp(2K_2^*)
&=(\tanh K_2)^{-1}
&&(\because\ \text{直前の等式の逆数と }\tanh K_2\ne0).
\end{aligned}`),
      paragraph([
        math(String.raw`\sinh K_2 > 0,\ \cosh K_2 > 0`),
        " であるから、以下の分母はいずれも ",
        math(String.raw`0`),
        " ではない。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
s_2^*
&=\sinh 2K_2^*
&&(\because\ s_2^*=\sinh 2K_2^*\text{ の定義})\\
&= \frac{\exp(2K_2^*) - \exp(-2K_2^*)}{2}
&&(\because \sinh x = \tfrac{1}{2}(\exp(x)-\exp(-x))) \\
&= \frac{(\tanh K_2)^{-1} - \tanh K_2}{2}
&&(\because \text{準備の } \exp(2K_2^*) = (\tanh K_2)^{-1},\ \exp(-2K_2^*) = \tanh K_2) \\
&= \frac{1}{2}\left(\frac{\cosh K_2}{\sinh K_2} - \frac{\sinh K_2}{\cosh K_2}\right)
&&(\because \tanh x = \tfrac{\sinh x}{\cosh x}\ \text{とその逆数}) \\
&= \frac{\cosh^2 K_2 - \sinh^2 K_2}{2\sinh K_2\cosh K_2}
&&(\because \text{通分。分母 } \sinh K_2\cosh K_2 \neq 0\ \text{は準備で確認済み}) \\
&= \frac{1}{\sinh 2K_2}
&&(\because \cosh^2 x - \sinh^2 x = 1,\ 2\sinh x\cosh x = \sinh 2x) \\
&= \frac{1}{s_2}
&&(\because s_2 = \sinh 2K_2\ \text{の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
c_2^*
&=\cosh 2K_2^*
&&(\because\ c_2^*=\cosh 2K_2^*\text{ の定義})\\
&= \frac{\exp(2K_2^*) + \exp(-2K_2^*)}{2}
&&(\because \cosh x = \tfrac{1}{2}(\exp(x)+\exp(-x))) \\
&= \frac{(\tanh K_2)^{-1} + \tanh K_2}{2}
&&(\because \text{準備の } \exp(2K_2^*) = (\tanh K_2)^{-1},\ \exp(-2K_2^*) = \tanh K_2) \\
&= \frac{1}{2}\left(\frac{\cosh K_2}{\sinh K_2} + \frac{\sinh K_2}{\cosh K_2}\right)
&&(\because \tanh x = \tfrac{\sinh x}{\cosh x}\ \text{とその逆数}) \\
&= \frac{\cosh^2 K_2 + \sinh^2 K_2}{2\sinh K_2\cosh K_2}
&&(\because \text{通分。分母 } \sinh K_2\cosh K_2 \neq 0\ \text{は準備で確認済み}) \\
&= \frac{\cosh 2K_2}{\sinh 2K_2}
&&(\because \cosh^2 x + \sinh^2 x = \cosh 2x,\ 2\sinh x\cosh x = \sinh 2x) \\
&= \frac{c_2}{s_2}
&&(\because c_2 = \cosh 2K_2\ \text{の定義})
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
        "2026-09-01 の式変形統一で、指数表示の準備を行末根拠つきの鎖へ移し、s_2^* と c_2^* の各鎖の先頭に定義の等号を独立した行として置き、全根拠を行末列へ揃えた。内容・参照は変えていない。",
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
i \exp(i\theta) s_2^*(c_1\cos\theta - i\sin\theta - s_1 c_2) \\
-i \exp(-i\theta) s_2^*(c_1\cos\theta + i\sin\theta - s_1 c_2) &
c_1 c_2^* - s_1 s_2^*\cos\theta
\end{pmatrix}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "evensector_000_remark_overview",
    kind: "remark",
    origin: { path: "structured-latex/content/013_even_sector_modes.ts", ordinal: 2 },
    title: { tex: String.raw`\check{Z}_\mu, \check{Y}_\mu \text{ を導入する理由}` },
    labels: [],
    statement: [
      paragraph([
        "生成子 ",
        math(String.raw`H_1^{(+)}`),
        "（",
        ref("def_H1_plus"),
        "）は",
      ]),
      displayMath(
        String.raw`H_1^{(+)} = \sum_{m=1}^{M_{\mathrm{col}}-1} Y_mZ_{m+1} - Y_{M_{\mathrm{col}}}Z_1`,
      ),
      paragraph([
        "であり、サイト ",
        math(String.raw`M_{\mathrm{col}}`),
        " とサイト ",
        math(String.raw`1`),
        " をつなぐ境界項 ",
        math(String.raw`-Y_{M_{\mathrm{col}}}Z_1`),
        " だけが符号 ",
        math(String.raw`-1`),
        " を持つ（反周期的な境界条件）。以下では、この符号に合わせた行列",
      ]),
      displayMath(
        String.raw`\check{Z}_\mu := \sum_{j=1}^{M_{\mathrm{col}}} Z_j\,\exp(-i j\tilde\theta_\mu),\qquad
\check{Y}_\mu := \sum_{j=1}^{M_{\mathrm{col}}} Y_j\,\exp(-i j\tilde\theta_\mu),\qquad
\tilde\theta_\mu := \frac{2\pi\left(\mu - \tfrac{1}{2}\right)}{M_{\mathrm{col}}}`,
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
        math(String.raw`\exp(-iM_{\mathrm{col}}\tilde\theta_\mu) = -1`),
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
        math(String.raw`M_{\mathrm{col}}`),
        " へ回り込み、境界項の符号のために ",
        math(String.raw`-Y_{M_{\mathrm{col}}}`),
        " が現れる。一方、位相 ",
        math(String.raw`\exp(-ij\tilde\theta_\mu)`),
        " は添字 ",
        math(String.raw`j = 0`),
        " を ",
        math(String.raw`j = M_{\mathrm{col}}`),
        " へ読み替えるときにちょうど ",
        math(String.raw`\exp(-iM_{\mathrm{col}}\tilde\theta_\mu) = -1`),
        " 倍になる。この 2 つの符号が打ち消し合うので、",
        math(String.raw`H_1^{(+)}`),
        " との交換関係が ",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " の中で閉じる。",
      ]),
      paragraph(["以下で示すのは次のことである。"]),
      list([
        [
          "添字集合 ",
          math(String.raw`\check{\mathcal{M}} = \{1,\dots,M_{\mathrm{col}}\}`),
          "（",
          ref("def_check_index_set"),
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
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
        "2026-10-31: 章立ての組み直しで、013 章の案内文から離散 Fourier 変換による 2×2 行列 A(θ̃_μ) への帰着の章の中の案内文へ移した。後ろの章の主張（共役添字、反交換関係、Z_j, Y_j の復元、H_1^{(+)}, H_2 の表示）を挙げた項目を外し、「この章」を「以下」に、用語「偶セクター」「Fourier モード」を式で指す言い方に直した。",
      ],
    },
  },
  {
    id: "evensector_002_claim_antiperiodic_exp_sum",
    kind: "claim",
    origin: { path: "structured-latex/content/013_even_sector_modes.ts", ordinal: 4 },
    title: { tex: String.raw`\tilde\theta_\mu \text{ と指数和 } \sum_{\mu=1}^{M_{\mathrm{col}}}\exp(ik\tilde\theta_\mu)` },
    labels: ["antiperiodic_exp_sum"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
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
        math(String.raw`M_{\mathrm{col}}\ge2`),
        " なので、",
        math(String.raw`((M_{\mathrm{col}})_{\mathbb N})_{\mathbb Z}=M_{\mathrm{col}}`),
        " を満たす一意な ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb N}\in\mathbb N_{\ge2}`),
        " がある。有限和の項数と周期デルタの法には ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb N}`),
        " を用いる。",
      ]),
      paragraph([
        "順序を保つ包含写像により ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb R}\ge2_{\mathbb R}>0_{\mathbb R}`),
        " である。したがって ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb R}\ne0_{\mathbb R}`),
        " であり、さらに実数の零因子がないことから ",
        math(String.raw`2(M_{\mathrm{col}})_{\mathbb R}\ne0_{\mathbb R}`),
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
        String.raw`\tilde\theta_\mu := \frac{2\pi\left(\mu_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}} \in \mathbb{R}`,
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
        math(String.raw`(M_{\mathrm{col}})_{\mathbb N}`),
        " までの自然数に限り、指数ではその整数像 ",
        math(String.raw`\mu_{\mathbb Z}`),
        " を用いる。このとき ",
        math(String.raw`k \in \mathbb{Z}`),
        " について",
      ]),
      displayMath(
        String.raw`\sum_{\mu=1}^{(M_{\mathrm{col}})_{\mathbb N}} \exp(i (k_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C})
= \begin{cases}
(M_{\mathrm{col}})_{\mathbb C}\,(-1_{\mathbb C})^{l} & (k = lM_{\mathrm{col}},\ l \in \mathbb{Z}) \\
0_{\mathbb C} & (k \not\equiv 0 \pmod M_{\mathrm{col}})
\end{cases}`,
      ),
      paragraph([
        "とくに ",
        math(String.raw`|k| < M_{\mathrm{col}}`),
        " かつ ",
        math(String.raw`k \neq 0`),
        " なら和は ",
        math(String.raw`0_{\mathbb C}`),
        "、",
        math(String.raw`k = 0`),
        " なら ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb C}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph(["最初に、自然数の項数と整数の格子幅の像を対応させる。包含写像の保存性より"]),
      displayMath(
        String.raw`\begin{aligned}
((M_{\mathrm{col}})_{\mathbb N})_{\mathbb R}
&=(M_{\mathrm{col}})_{\mathbb R}
&&\bigl(\because\ ((M_{\mathrm{col}})_{\mathbb N})_{\mathbb Z}=M_{\mathrm{col}}\bigr)\\
(2(M_{\mathrm{col}})_{\mathbb N})_{\mathbb R}
&=2(M_{\mathrm{col}})_{\mathbb R}
&&\bigl(\because\ \iota_{\mathbb N\to\mathbb Z},\iota_{\mathbb Z\to\mathbb R}\text{ は積を保つ}\bigr)\\
((M_{\mathrm{col}})_{\mathbb N})_{\mathbb C}
&=(M_{\mathrm{col}})_{\mathbb C}
&&\bigl(\because\ ((M_{\mathrm{col}})_{\mathbb N})_{\mathbb R}=(M_{\mathrm{col}})_{\mathbb R}\bigr)\\
(2(M_{\mathrm{col}})_{\mathbb N})_{\mathbb C}
&=(2M_{\mathrm{col}})_{\mathbb C}
&&\bigl(\because\ (2(M_{\mathrm{col}})_{\mathbb N})_{\mathbb R}=2(M_{\mathrm{col}})_{\mathbb R}\bigr).
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
&=\frac{2\pi k_{\mathbb R}\left(\mu_{\mathbb R}-\frac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \tilde\theta_\mu=\tfrac{2\pi(\mu_{\mathbb R}-\frac12)}{(M_{\mathrm{col}})_{\mathbb R}}\bigr)\\
&=\frac{2\pi(2\mu_{\mathbb R}-1)k_{\mathbb R}}{2(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ (M_{\mathrm{col}})_{\mathbb R}\ne0_{\mathbb R},\ 2_{\mathbb R}\ne0_{\mathbb R}\text{ と }\mathbb R\text{ の分数の通分}\bigr).
\end{aligned}`,
      ),
      paragraph([
        "したがって、求める和を",
      ]),
      displayMath(
        String.raw`S_{M_{\mathrm{col}},k}:=\sum_{\mu=1}^{(M_{\mathrm{col}})_{\mathbb N}}
\exp(i\left(\frac{2\pi(2(\mu_{\mathbb Z})_{\mathbb R}-1)k_{\mathbb R}}{2(M_{\mathrm{col}})_{\mathbb R}}\right)_{\mathbb C})\in\mathbb C`,
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
        String.raw`T_{N,k}:=\sum_{r=1}^{N}\exp(i\left(\frac{2\pi(r_{\mathbb Z})_{\mathbb R}k_{\mathbb R}}{N_{\mathbb R}}\right)_{\mathbb C})\in\mathbb C
\qquad(N\in\mathbb N_{\ge1})`,
      ),
      paragraph([
        "とおく。整数 ",
        math(String.raw`1,\ldots,2(M_{\mathrm{col}})_{\mathbb N}`),
        " は、ただ一通り ",
        math(String.raw`r=2\mu-1`),
        " または ",
        math(String.raw`r=2\mu`),
        "（",
        math(String.raw`1\le\mu\le (M_{\mathrm{col}})_{\mathbb N}`),
        "）と書ける。ゆえに有限和を奇数番目と偶数番目へ分けると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{2(M_{\mathrm{col}})_{\mathbb N},k}
&=\sum_{r=1}^{2(M_{\mathrm{col}})_{\mathbb N}}\exp(i\left(\frac{2\pi(r_{\mathbb Z})_{\mathbb R}k_{\mathbb R}}{(2(M_{\mathrm{col}})_{\mathbb N})_{\mathbb R}}\right)_{\mathbb C})
&&\bigl(\because\ T_{N,k}\text{ の定義に }N=2(M_{\mathrm{col}})_{\mathbb N}\text{ を代入}\bigr)\\
&=\sum_{r=1}^{2(M_{\mathrm{col}})_{\mathbb N}}\exp(i\left(\frac{2\pi(r_{\mathbb Z})_{\mathbb R}k_{\mathbb R}}{2(M_{\mathrm{col}})_{\mathbb R}}\right)_{\mathbb C})
&&\bigl(\because\ (2(M_{\mathrm{col}})_{\mathbb N})_{\mathbb R}=2(M_{\mathrm{col}})_{\mathbb R}\bigr)\\
&=\sum_{\mu=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(i\left(\frac{2\pi(2(\mu_{\mathbb Z})_{\mathbb R}-1)k_{\mathbb R}}{2(M_{\mathrm{col}})_{\mathbb R}}\right)_{\mathbb C})
+\sum_{\mu=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(i\left(\frac{2\pi(2(\mu_{\mathbb Z})_{\mathbb R})k_{\mathbb R}}{2(M_{\mathrm{col}})_{\mathbb R}}\right)_{\mathbb C})
&&\bigl(\because\ r\text{ の奇偶による有限和の分割}\bigr)\\
&=S_{M_{\mathrm{col}},k}+\sum_{\mu=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(i\left(\frac{2\pi(2(\mu_{\mathbb Z})_{\mathbb R})k_{\mathbb R}}{2(M_{\mathrm{col}})_{\mathbb R}}\right)_{\mathbb C})
&&\bigl(\because\ S_{M_{\mathrm{col}},k}\text{ の定義}\bigr)\\
&=S_{M_{\mathrm{col}},k}+\sum_{\mu=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(i\left(\frac{2\pi(\mu_{\mathbb Z})_{\mathbb R}k_{\mathbb R}}{(M_{\mathrm{col}})_{\mathbb R}}\right)_{\mathbb C})
&&\bigl(\because\ 2(M_{\mathrm{col}})_{\mathbb R}\ne0_{\mathbb R}\text{ と分数の約分}\bigr)\\
&=S_{M_{\mathrm{col}},k}+\sum_{\mu=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(i\left(\frac{2\pi(\mu_{\mathbb Z})_{\mathbb R}k_{\mathbb R}}{((M_{\mathrm{col}})_{\mathbb N})_{\mathbb R}}\right)_{\mathbb C})
&&\bigl(\because\ ((M_{\mathrm{col}})_{\mathbb N})_{\mathbb R}=(M_{\mathrm{col}})_{\mathbb R}\bigr)\\
&=S_{M_{\mathrm{col}},k}+T_{(M_{\mathrm{col}})_{\mathbb N},k}
&&\bigl(\because\ T_{(M_{\mathrm{col}})_{\mathbb N},k}\text{ の定義}\bigr).
\end{aligned}`,
      ),
      paragraph([
        ref("exp_sum"),
        " を正の整数 ",
        math(String.raw`2(M_{\mathrm{col}})_{\mathbb N}`),
        " と ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb N}`),
        " にそれぞれ適用し、",
        ref("def_delta_M"),
        " の記号を使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{2(M_{\mathrm{col}})_{\mathbb N},k}
&=(2(M_{\mathrm{col}})_{\mathbb N})_{\mathbb C}\,\delta^{2(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}
&&\bigl(\because\ \text{exp\_sum}\text{ を }2(M_{\mathrm{col}})_{\mathbb N}\text{ に適用}\bigr),\\
&=(2M_{\mathrm{col}})_{\mathbb C}\,\delta^{2(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}
&&\bigl(\because\ (2(M_{\mathrm{col}})_{\mathbb N})_{\mathbb C}=(2M_{\mathrm{col}})_{\mathbb C}\bigr),\\
T_{(M_{\mathrm{col}})_{\mathbb N},k}
&=((M_{\mathrm{col}})_{\mathbb N})_{\mathbb C}\,\delta^{(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}
&&\bigl(\because\ \text{exp\_sum}\text{ を }(M_{\mathrm{col}})_{\mathbb N}\text{ に適用}\bigr),\\
&=(M_{\mathrm{col}})_{\mathbb C}\,\delta^{(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}
&&\bigl(\because\ ((M_{\mathrm{col}})_{\mathbb N})_{\mathbb C}=(M_{\mathrm{col}})_{\mathbb C}\bigr).
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
S_{M_{\mathrm{col}},k}
&=T_{2(M_{\mathrm{col}})_{\mathbb N},k}-T_{(M_{\mathrm{col}})_{\mathbb N},k}
&&\bigl(\because\ T_{2(M_{\mathrm{col}})_{\mathbb N},k}=S_{M_{\mathrm{col}},k}+T_{(M_{\mathrm{col}})_{\mathbb N},k}\bigr)\\
&=(2M_{\mathrm{col}})_{\mathbb C}\,\delta^{2(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}-(M_{\mathrm{col}})_{\mathbb C}\,\delta^{(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}
&&\bigl(\because\ \text{直前の二つの指数和}\bigr).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`k \not\equiv 0 \pmod M_{\mathrm{col}}`),
        " のときは、",
        math(String.raw`2M_{\mathrm{col}}\mid k`),
        " なら ",
        math(String.raw`M_{\mathrm{col}}\mid k`),
        " となることの対偶から ",
        math(String.raw`2M_{\mathrm{col}}\nmid k`),
        " でもある。したがって ",
        math(String.raw`\delta^{2(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}=0_{\mathbb C}`),
        " かつ ",
        math(String.raw`\delta^{(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)} = 0_{\mathbb C}`),
        " なので和は ",
        math(String.raw`0_{\mathbb C}`),
        "。",
      ]),
      paragraph([
        math(String.raw`k = lM_{\mathrm{col}}`),
        "（",
        math(String.raw`l \in \mathbb{Z}`),
        "）のときは ",
        math(String.raw`\delta^{(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)} = 1_{\mathbb C}`),
        " である。また ",
        math(String.raw`M_{\mathrm{col}}\ne0`),
        " なので、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
2M_{\mathrm{col}}\mid k
&\iff 2M_{\mathrm{col}}\mid lM_{\mathrm{col}}
&&\bigl(\because\ k=lM_{\mathrm{col}}\bigr)\\
&\iff 2\mid l
&&\bigl(\because\ M_{\mathrm{col}}\ne0\text{ による整数の約分}\bigr).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`l`),
        " が偶数なら ",
        math(String.raw`\delta^{2(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}=1_{\mathbb C}`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
S_{M_{\mathrm{col}},k}
&=(2M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}-(M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}
&&\bigl(\because\ \delta^{2(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}=\delta^{(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}=1_{\mathbb C}\bigr)\\
&=(2M_{\mathrm{col}})_{\mathbb C}-(M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}
&&\bigl(\because\ (2M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}=(2M_{\mathrm{col}})_{\mathbb C}\bigr)\\
&=(2M_{\mathrm{col}})_{\mathbb C}-(M_{\mathrm{col}})_{\mathbb C}
&&\bigl(\because\ (M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}=(M_{\mathrm{col}})_{\mathbb C}\bigr)\\
&=(M_{\mathrm{col}})_{\mathbb C}
&&\bigl(\because\ (2M_{\mathrm{col}})_{\mathbb C}-(M_{\mathrm{col}})_{\mathbb C}=(M_{\mathrm{col}})_{\mathbb C}\bigr)\\
&=(M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}
&&\bigl(\because\ 1_{\mathbb C}\text{ は積の単位元}\bigr)\\
&=(M_{\mathrm{col}})_{\mathbb C}(-1_{\mathbb C})^l
&&\bigl(\because\ l\text{ が偶数なら }(-1_{\mathbb C})^l=1_{\mathbb C}\bigr).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`l`),
        " が奇数なら ",
        math(String.raw`\delta^{2(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}=0_{\mathbb C}`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
S_{M_{\mathrm{col}},k}
&=(2M_{\mathrm{col}})_{\mathbb C}\cdot0_{\mathbb C}-(M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}
&&\bigl(\because\ \delta^{2(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}=0_{\mathbb C},\ \delta^{(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}=1_{\mathbb C}\bigr)\\
&=0_{\mathbb C}-(M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}
&&\bigl(\because\ (2M_{\mathrm{col}})_{\mathbb C}\cdot0_{\mathbb C}=0_{\mathbb C}\bigr)\\
&=0_{\mathbb C}-(M_{\mathrm{col}})_{\mathbb C}
&&\bigl(\because\ (M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}=(M_{\mathrm{col}})_{\mathbb C}\bigr)\\
&=-(M_{\mathrm{col}})_{\mathbb C}
&&\bigl(\because\ 0_{\mathbb C}-(M_{\mathrm{col}})_{\mathbb C}=-(M_{\mathrm{col}})_{\mathbb C}\bigr)\\
&=(M_{\mathrm{col}})_{\mathbb C}(-1_{\mathbb C})
&&\bigl(\because\ -(M_{\mathrm{col}})_{\mathbb C}=(M_{\mathrm{col}})_{\mathbb C}(-1_{\mathbb C})\bigr)\\
&=(M_{\mathrm{col}})_{\mathbb C}(-1_{\mathbb C})^l
&&\bigl(\because\ l\text{ が奇数なら }(-1_{\mathbb C})^l=-1_{\mathbb C}\bigr).
\end{aligned}`,
      ),
      paragraph([
        "最後に「とくに」を示す。",
        math(String.raw`|k|<M_{\mathrm{col}}`),
        " かつ ",
        math(String.raw`k\ne0`),
        " とする。もし ",
        math(String.raw`M_{\mathrm{col}}\mid k`),
        " なら、ある ",
        math(String.raw`l\in\mathbb{Z}`),
        " が存在して ",
        math(String.raw`k=lM_{\mathrm{col}}`),
        " である。このとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|lM_{\mathrm{col}}|
&=|l|\,|M_{\mathrm{col}}|
&&\bigl(\because\ \text{積の絶対値}\bigr)\\
&=|l|M_{\mathrm{col}}
&&\bigl(\because\ M_{\mathrm{col}}>0\text{ なので }|M_{\mathrm{col}}|=M_{\mathrm{col}}\bigr)\\
&= |k|
&&\bigl(\because\ k=lM_{\mathrm{col}}\bigr) \\
&< M_{\mathrm{col}}
&&\bigl(\because\ |k|<M_{\mathrm{col}}\bigr),
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`M_{\mathrm{col}}>0`),
        " なので、整数における正数倍は狭義順序を反映する。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|l|
&<1
&&\bigl(\because\ |l|M_{\mathrm{col}}<1\cdot M_{\mathrm{col}},\ M_{\mathrm{col}}>0\bigr).
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
&=lM_{\mathrm{col}}
&&\bigl(\because\ k=lM_{\mathrm{col}}\bigr) \\
&=0\cdot M_{\mathrm{col}}
&&\bigl(\because\ l=0\bigr) \\
&=0
&&\bigl(\because\ 0\cdot M_{\mathrm{col}}=0\bigr),
\end{aligned}`,
      ),
      paragraph([
        "となり ",
        math(String.raw`0`),
        " ではないという仮定 ",
        math(String.raw`k\ne0`),
        " に矛盾する。ゆえに ",
        math(String.raw`M_{\mathrm{col}}\nmid k`),
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
(M_{\mathrm{col}})_{\mathbb C}(-1_{\mathbb C})^0
&=(M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}
&&\bigl(\because\ (-1)^0=1\bigr) \\
&=(M_{\mathrm{col}})_{\mathbb C}
&&\bigl(\because\ (M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}=(M_{\mathrm{col}})_{\mathbb C}\bigr).
\end{aligned}`,
      ),
      paragraph(["となる。"]),
    ],
    conversion: { status: "added" },
  },
  {
    id: "evensector_003_definition_half_integer_checkZ",
    kind: "definition",
    origin: { path: "structured-latex/content/013_even_sector_modes.ts", ordinal: 5 },
    title: { tex: String.raw`\check{Z}_\mu \text{（}\tilde\theta_\mu\text{ による }Z_j\text{ の離散 Fourier 変換）}` },
    labels: ["def_half_integer_checkZ"],
    statement: [
      paragraph([
        ref("set_and_algebra_notation"),
        " の記号で ",
        math(String.raw`M_{\mathrm{col}}\in\mathbb Z_{\geq2}`),
        " とする。",
        ref("antiperiodic_exp_sum"),
        " で定めた ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb N}\in\mathbb N_{\geq2}`),
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
        math(String.raw`j\in\{1,\dots,(M_{\mathrm{col}})_{\mathbb N}\}`),
        " なら ",
        math(String.raw`j_{\mathbb Z}\in\{1,\dots,M_{\mathrm{col}}\}`),
        " なので、",
        ref("def_jordan_wigner_Z_matrices"),
        " から ",
        math(String.raw`Z_{j_{\mathbb Z}}\in\mathrm{Mat}(2^{(M_{\mathrm{col}})_{\mathbb N}},\mathbb C)`),
        " である。複素指数の定義と所属は現行本文では未整備なので、以下では ",
        math(String.raw`\exp(-i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})\in\mathbb C`),
        " を仮定する。この複素数によるスカラー倍と同じ行列空間内の有限和を用いて",
      ]),
      displayMath(
        String.raw`\check{Z}_\mu
:=\sum_{j=1}^{(M_{\mathrm{col}})_{\mathbb N}}
\exp(-i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})Z_{j_{\mathbb Z}}
\in\mathrm{Mat}(2^{(M_{\mathrm{col}})_{\mathbb N}},\mathbb C)`,
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
    origin: { path: "structured-latex/content/013_even_sector_modes.ts", ordinal: 5 },
    title: { tex: String.raw`\check{Y}_\mu \text{（}\tilde\theta_\mu\text{ による }Y_j\text{ の離散 Fourier 変換）}` },
    labels: ["def_half_integer_checkY"],
    statement: [
      paragraph([
        ref("set_and_algebra_notation"),
        " の記号で ",
        math(String.raw`M_{\mathrm{col}}\in\mathbb Z_{\geq2}`),
        " とする。",
        ref("antiperiodic_exp_sum"),
        " で定めた ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb N}\in\mathbb N_{\geq2}`),
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
        math(String.raw`j\in\{1,\dots,(M_{\mathrm{col}})_{\mathbb N}\}`),
        " なら ",
        math(String.raw`j_{\mathbb Z}\in\{1,\dots,M_{\mathrm{col}}\}`),
        " なので、",
        ref("def_jordan_wigner_Y_matrices"),
        " から ",
        math(String.raw`Y_{j_{\mathbb Z}}\in\mathrm{Mat}(2^{(M_{\mathrm{col}})_{\mathbb N}},\mathbb C)`),
        " である。複素指数の定義と所属は現行本文では未整備なので、以下では ",
        math(String.raw`\exp(-i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})\in\mathbb C`),
        " を仮定する。この複素数によるスカラー倍と同じ行列空間内の有限和を用いて",
      ]),
      displayMath(
        String.raw`\check{Y}_\mu
:=\sum_{j=1}^{(M_{\mathrm{col}})_{\mathbb N}}
\exp(-i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})Y_{j_{\mathbb Z}}
\in\mathrm{Mat}(2^{(M_{\mathrm{col}})_{\mathbb N}},\mathbb C)`,
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
    origin: { path: "structured-latex/content/013_even_sector_modes.ts", ordinal: 5 },
    title: { tex: String.raw`\tilde\theta_\mu \text{ の反周期性 } \exp(-iM_{\mathrm{col}}\tilde\theta_\mu) = -1` },
    labels: ["half_integer_phase_antiperiodicity"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb Z_{\geq2}`),
        "、",
        math(String.raw`\mu\in\mathbb Z`),
        " とする。",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu`),
        " について",
      ]),
      displayMath(String.raw`\exp(-i M_{\mathrm{col}} \tilde\theta_\mu) = -1`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "まず指数の角度を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
M_{\mathrm{col}}\tilde\theta_\mu
&=M_{\mathrm{col}}\cdot\frac{2\pi}{M_{\mathrm{col}}}\left(\mu-\tfrac12\right)
&&\bigl(\because\ \tilde\theta_\mu=\tfrac{2\pi}{M_{\mathrm{col}}}(\mu-\tfrac12)\text{ を代入}\bigr)\\
&=2\pi\left(\mu-\tfrac12\right)
&&\bigl(\because\ M_{\mathrm{col}}\geq2\text{ より }M_{\mathrm{col}}\neq0\text{ なので }M_{\mathrm{col}}\text{ を約分}\bigr)\\
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
\exp(-iM_{\mathrm{col}}\tilde\theta_\mu)
&= \cos\!\left(M_{\mathrm{col}}\tilde\theta_\mu\right)-i\sin\!\left(M_{\mathrm{col}}\tilde\theta_\mu\right)
&&\bigl(\because \blkref{euler_formula_cos_sin}\text{ の証明冒頭で導いた }\exp(-ix)=\cos x-i\sin x\bigr) \\
&= \cos(2\pi\mu-\pi)-i\sin(2\pi\mu-\pi)
&&\bigl(\because M_{\mathrm{col}}\tilde\theta_\mu=2\pi\mu-\pi\ \text{を 2 箇所へ同時代入}\bigr) \\
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
    origin: { path: "structured-latex/content/013_even_sector_modes.ts", ordinal: 5 },
    title: { tex: String.raw`\check{Z}_\mu \text{ の添字周期性 } \check{Z}_{\mu+M_{\mathrm{col}}} = \check{Z}_\mu` },
    labels: ["half_integer_checkZ_periodicity"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb Z_{\geq2}`),
        "、",
        math(String.raw`\mu\in\mathbb Z`),
        " とする。",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu`),
        " と、",
        ref("def_half_integer_checkZ"),
        " の Fourier 行列について、",
        math(String.raw`\check{Z}_{\mu+M_{\mathrm{col}}} = \check{Z}_\mu`),
        " が成り立つ。",
      ]),
    ],
    proof: [
      paragraph(["まず添字をずらした角度を計算する。"]),
      displayMath(String.raw`\begin{aligned}
\tilde\theta_{\mu+M_{\mathrm{col}}}
&=\frac{2\pi\left(\mu+M_{\mathrm{col}}-\tfrac12\right)}{M_{\mathrm{col}}}
&&\bigl(\because\ \tilde\theta_\mu\text{ の定義に }\mu+M_{\mathrm{col}}\text{ を代入}\bigr)\\
&=\frac{2\pi\left(\mu-\tfrac12\right)+2\pi M_{\mathrm{col}}}{M_{\mathrm{col}}}
&&\bigl(\because\ \mathbb R\text{ の分配則}\bigr)\\
&=\frac{2\pi\left(\mu-\tfrac12\right)}{M_{\mathrm{col}}}+\frac{2\pi M_{\mathrm{col}}}{M_{\mathrm{col}}}
&&\bigl(\because\ \mathbb R\text{ の分数の加法}\bigr)\\
&=\frac{2\pi\left(\mu-\tfrac12\right)}{M_{\mathrm{col}}}+2\pi
&&\bigl(\because\ M_{\mathrm{col}}\geq2\text{ より }M_{\mathrm{col}}\neq0\text{ であり、分子と分母の }M_{\mathrm{col}}\text{ を約分}\bigr)\\
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
\exp(-ij\tilde\theta_{\mu+M_{\mathrm{col}}})
&=\cos\!\left(j\tilde\theta_{\mu+M_{\mathrm{col}}}\right)-i\sin\!\left(j\tilde\theta_{\mu+M_{\mathrm{col}}}\right)
&&\bigl(\because \blkref{euler_formula_cos_sin}\text{ の証明冒頭で導いた }\exp(-ix)=\cos x-i\sin x\bigr) \\
&=\cos\!\left(j(\tilde\theta_\mu+2\pi)\right)-i\sin\!\left(j(\tilde\theta_\mu+2\pi)\right)
&&\bigl(\because \tilde\theta_{\mu+M_{\mathrm{col}}}=\tilde\theta_\mu+2\pi\text{ を 2 箇所へ同時代入}\bigr) \\
&=\cos\!\left(j\tilde\theta_\mu+2\pi j\right)-i\sin\!\left(j\tilde\theta_\mu+2\pi j\right)
&&\bigl(\because \mathbb R\text{ の分配則}\bigr) \\
&=\cos\!\left(j\tilde\theta_\mu\right)-i\sin\!\left(j\tilde\theta_\mu\right)
&&\bigl(\because j\in\mathbb Z\text{ と正弦・余弦の }2\pi\text{ 周期性}\bigr) \\
&=\exp(-ij\tilde\theta_\mu)
&&\bigl(\because \blkref{euler_formula_cos_sin}\text{ の証明冒頭で導いた等式の対称律}\bigr)
\end{aligned}`,
      ),
      paragraph(["係数がすべて一致するので、一続きに"]),
      displayMath(
        String.raw`\begin{aligned}
\check{Z}_{\mu+M_{\mathrm{col}}}
&=\sum_{j_{\mathbb N}=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(-ij_{\mathbb R}\tilde\theta_{\mu+M_{\mathrm{col}}})Z_{j_{\mathbb Z}}
&&\left(\because\ \check{Z}_{\mu+M_{\mathrm{col}}}\text{ の定義}\right)\\
&=\sum_{j_{\mathbb N}=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(-ij_{\mathbb R}\tilde\theta_{\mu})Z_{j_{\mathbb Z}}
&&\left(\because\ \text{上で得た }\exp(-ij\tilde\theta_{\mu+M_{\mathrm{col}}})=\exp(-ij\tilde\theta_\mu)\text{ を全項へ同時適用}\right)\\
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
    origin: { path: "structured-latex/content/013_even_sector_modes.ts", ordinal: 5 },
    title: { tex: String.raw`\check{Y}_\mu \text{ の添字周期性 } \check{Y}_{\mu+M_{\mathrm{col}}} = \check{Y}_\mu` },
    labels: ["half_integer_checkY_periodicity"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb Z_{\geq2}`),
        "、",
        math(String.raw`\mu\in\mathbb Z`),
        " とする。",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu`),
        " と、",
        ref("def_half_integer_checkY"),
        " の Fourier 行列について、",
        math(String.raw`\check{Y}_{\mu+M_{\mathrm{col}}} = \check{Y}_\mu`),
        " が成り立つ。",
      ]),
    ],
    proof: [
      paragraph(["まず添字をずらした角度を計算する。"]),
      displayMath(String.raw`\begin{aligned}
\tilde\theta_{\mu+M_{\mathrm{col}}}
&=\frac{2\pi\left(\mu+M_{\mathrm{col}}-\tfrac12\right)}{M_{\mathrm{col}}}
&&\bigl(\because\ \tilde\theta_\mu\text{ の定義に }\mu+M_{\mathrm{col}}\text{ を代入}\bigr)\\
&=\frac{2\pi\left(\mu-\tfrac12\right)+2\pi M_{\mathrm{col}}}{M_{\mathrm{col}}}
&&\bigl(\because\ \mathbb R\text{ の分配則}\bigr)\\
&=\frac{2\pi\left(\mu-\tfrac12\right)}{M_{\mathrm{col}}}+\frac{2\pi M_{\mathrm{col}}}{M_{\mathrm{col}}}
&&\bigl(\because\ \mathbb R\text{ の分数の加法}\bigr)\\
&=\frac{2\pi\left(\mu-\tfrac12\right)}{M_{\mathrm{col}}}+2\pi
&&\bigl(\because\ M_{\mathrm{col}}\geq2\text{ より }M_{\mathrm{col}}\neq0\text{ であり、分子と分母の }M_{\mathrm{col}}\text{ を約分}\bigr)\\
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
\exp(-ij\tilde\theta_{\mu+M_{\mathrm{col}}})
&=\cos\!\left(j\tilde\theta_{\mu+M_{\mathrm{col}}}\right)-i\sin\!\left(j\tilde\theta_{\mu+M_{\mathrm{col}}}\right)
&&\bigl(\because \blkref{euler_formula_cos_sin}\text{ の証明冒頭で導いた }\exp(-ix)=\cos x-i\sin x\bigr) \\
&=\cos\!\left(j(\tilde\theta_\mu+2\pi)\right)-i\sin\!\left(j(\tilde\theta_\mu+2\pi)\right)
&&\bigl(\because \tilde\theta_{\mu+M_{\mathrm{col}}}=\tilde\theta_\mu+2\pi\text{ を 2 箇所へ同時代入}\bigr) \\
&=\cos\!\left(j\tilde\theta_\mu+2\pi j\right)-i\sin\!\left(j\tilde\theta_\mu+2\pi j\right)
&&\bigl(\because \mathbb R\text{ の分配則}\bigr) \\
&=\cos\!\left(j\tilde\theta_\mu\right)-i\sin\!\left(j\tilde\theta_\mu\right)
&&\bigl(\because j\in\mathbb Z\text{ と正弦・余弦の }2\pi\text{ 周期性}\bigr) \\
&=\exp(-ij\tilde\theta_\mu)
&&\bigl(\because \blkref{euler_formula_cos_sin}\text{ の証明冒頭で導いた等式の対称律}\bigr)
\end{aligned}`,
      ),
      paragraph(["係数がすべて一致するので、一続きに"]),
      displayMath(
        String.raw`\begin{aligned}
\check{Y}_{\mu+M_{\mathrm{col}}}
&=\sum_{j_{\mathbb N}=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(-ij_{\mathbb R}\tilde\theta_{\mu+M_{\mathrm{col}}})Y_{j_{\mathbb Z}}
&&\left(\because\ \check{Y}_{\mu+M_{\mathrm{col}}}\text{ の定義}\right)\\
&=\sum_{j_{\mathbb N}=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(-ij_{\mathbb R}\tilde\theta_{\mu})Y_{j_{\mathbb Z}}
&&\left(\because\ \text{上で得た }\exp(-ij\tilde\theta_{\mu+M_{\mathrm{col}}})=\exp(-ij\tilde\theta_\mu)\text{ を全項へ同時適用}\right)\\
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
    id: "evensector_003a_definition_check_index_set",
    kind: "definition",
    origin: { path: "structured-latex/content/013_even_sector_modes.ts", ordinal: 6 },
    title: { tex: String.raw`\text{添字集合 } \check{\mathcal{M}} := \{1, \dots, M_{\mathrm{col}}\}` },
    labels: ["def_check_index_set"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu`),
        "（",
        math(String.raw`\mu \in \mathbb{Z}`),
        " について定義されている）を用いる。",
      ]),
      displayMath(
        String.raw`\check{\mathcal{M}} := \left\{1, 2, \dots, M_{\mathrm{col}}\right\} \subset \mathbb{Z}`,
      ),
      paragraph([
        "と定め、**半整数運動量の添字集合**と呼ぶ。",
      ]),
      paragraph([
        "**以降の主張は、とくに断らない限り ",
        math(String.raw`\mu, \nu \in \check{\mathcal{M}}`),
        " について述べる。** この章で ",
        math(String.raw`\mu \in \mathbb{Z}`),
        " 全体について定める記号は、",
        ref("def_delta_M"),
        " の ",
        math(String.raw`\delta^{(M_{\mathrm{col}})}_{(\mu,\nu)}`),
        "（",
        math(String.raw`\mu, \nu \in \mathbb{Z}`),
        "）、",
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
        " である。この章で添字の周期性を述べる主張は ",
        ref("half_integer_checkZ_periodicity"),
        " と ",
        ref("half_integer_checkY_periodicity"),
        " である。これらは、計算の途中で ",
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
            String.raw`\text{(1) 相異なる } M_{\mathrm{col}} \text{ 個の運動量：}\quad
\mu, \nu \in \check{\mathcal{M}},\ \mu \neq \nu \implies \tilde\theta_\mu \neq \tilde\theta_\nu,
\qquad 0 < \tilde\theta_\mu < 2\pi`,
          ),
        ],
        [
          math(
            String.raw`\text{(2) 共役添字の閉性：}\quad \mu \in \check{\mathcal{M}} \implies M_{\mathrm{col}}+1-\mu \in \check{\mathcal{M}}`,
          ),
        ],
        [
          math(
            String.raw`\text{(3) 共役添字の言い換え：}\quad \left(M_{\mathrm{col}}+1-\mu\right) - \left(1-\mu\right) = M_{\mathrm{col}},
\quad \text{すなわち } 1-\mu \equiv M_{\mathrm{col}}+1-\mu \pmod M_{\mathrm{col}}`,
          ),
        ],
        [
          math(
            String.raw`\text{(4) 自己共役点：}\quad
\mu \in \check{\mathcal{M}},\ M_{\mathrm{col}}+1-\mu = \mu
\iff M_{\mathrm{col}} \text{ が奇数かつ } \mu = \tfrac{M_{\mathrm{col}}+1}{2}`,
          ),
          "。このとき ",
          math(String.raw`\tilde\theta_\mu = \pi`),
          "。",
        ],
        [
          math(
            String.raw`\text{(5) 対の判定：}\quad
\mu, \nu \in \check{\mathcal{M}} \implies
\left(\mu+\nu \equiv 1 \pmod M_{\mathrm{col}} \iff \nu = M_{\mathrm{col}}+1-\mu\right)`,
          ),
          "。したがって ",
          math(String.raw`\mu,\nu \in \check{\mathcal{M}}`),
          " では ",
          math(String.raw`\delta^{(M_{\mathrm{col}})}_{(\mu+\nu,\,1)} = \delta_{\nu,\,M_{\mathrm{col}}+1-\mu}`),
          " である（右辺は通常のクロネッカーのデルタ、すなわち ",
          math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
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
        " へ範囲を絞ったことで**合同式が消える**ことを述べている。このため、以降の主張で対 ",
        math(String.raw`(\mu,\ M_{\mathrm{col}}+1-\mu)`),
        " を指定するのに合同式は要らない。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("antiperiodic_exp_sum"),
        " より ",
        math(String.raw`\tilde\theta_\mu = \dfrac{2\pi\left(\mu-\frac12\right)}{M_{\mathrm{col}}}`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tilde\theta_\nu - \tilde\theta_\mu
&= \frac{2\pi\left(\nu-\frac12\right)}{M_{\mathrm{col}}} - \frac{2\pi\left(\mu-\frac12\right)}{M_{\mathrm{col}}}
&&\bigl(\because \blkref{antiperiodic_exp_sum}\text{ の } \tilde\theta \text{ の定義}\bigr) \\
&= \frac{2\pi}{M_{\mathrm{col}}}\left(\nu - \mu\right)
&&\bigl(\because \text{通分と分配法則}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "であり ",
        math(String.raw`\frac{2\pi}{M_{\mathrm{col}}} > 0`),
        " なので、",
        math(String.raw`\mu \neq \nu`),
        " なら ",
        math(String.raw`\tilde\theta_\mu \neq \tilde\theta_\nu`),
        "。また同じ式は ",
        math(String.raw`\mu \mapsto \tilde\theta_\mu`),
        " が狭義単調増加であることを与えるので、",
        math(String.raw`1 \leq \mu \leq M_{\mathrm{col}}`),
        " では",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tilde\theta_1
&=\frac{2\pi\left(1-\frac12\right)}{M_{\mathrm{col}}}
&&\left(\because\ \blkref{antiperiodic_exp_sum}\text{ の }\tilde\theta\text{ の定義}\right)\\
&=\frac{\pi}{M_{\mathrm{col}}}
&&\left(\because\ \mathbb R\text{ の四則}\right)\\
&\leq\tilde\theta_\mu
&&\left(\because\ 1\leq\mu\text{ と }\mu\mapsto\tilde\theta_\mu\text{ の単調増加}\right)\\
&\leq\tilde\theta_{M_{\mathrm{col}}}
&&\left(\because\ \mu\leq M_{\mathrm{col}}\text{ と }\mu\mapsto\tilde\theta_\mu\text{ の単調増加}\right)\\
&=\frac{2\pi\left(M_{\mathrm{col}}-\frac12\right)}{M_{\mathrm{col}}}
&&\left(\because\ \blkref{antiperiodic_exp_sum}\text{ の }\tilde\theta\text{ の定義}\right)\\
&=2\pi-\frac{\pi}{M_{\mathrm{col}}}
&&\left(\because\ \mathbb R\text{ の四則}\right)
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`M_{\mathrm{col}} \geq 2`),
        " より ",
        math(String.raw`0 < \frac{\pi}{M_{\mathrm{col}}}`),
        " かつ ",
        math(String.raw`2\pi - \frac{\pi}{M_{\mathrm{col}}} < 2\pi`),
        " なので ",
        math(String.raw`0 < \tilde\theta_\mu < 2\pi`),
        "。",
      ]),
      paragraph([
        "(2) ",
        math(String.raw`1 \leq \mu \leq M_{\mathrm{col}}`),
        " の各辺に ",
        math(String.raw`-1`),
        " を掛けると ",
        math(String.raw`-M_{\mathrm{col}} \leq -\mu \leq -1`),
        "、さらに ",
        math(String.raw`M_{\mathrm{col}}+1`),
        " を足すと ",
        math(String.raw`1 \leq M_{\mathrm{col}}+1-\mu \leq M_{\mathrm{col}}`),
        "。",
        math(String.raw`M_{\mathrm{col}}+1-\mu \in \mathbb{Z}`),
        " なので ",
        math(String.raw`M_{\mathrm{col}}+1-\mu \in \check{\mathcal{M}}`),
        "。",
      ]),
      paragraph([
        "(3) ",
        math(String.raw`(M_{\mathrm{col}}+1-\mu) - (1-\mu) = M_{\mathrm{col}}`),
        " は展開するだけである。",
        ref("def_delta_M"),
        " の合同の意味により、差が ",
        math(String.raw`M_{\mathrm{col}}`),
        " の倍数であることが ",
        math(String.raw`1-\mu \equiv M_{\mathrm{col}}+1-\mu \pmod M_{\mathrm{col}}`),
        " である。",
      ]),
      paragraph([
        "(4) ",
        math(String.raw`M_{\mathrm{col}}+1-\mu = \mu`),
        " は ",
        math(String.raw`M_{\mathrm{col}}+1 = 2\mu`),
        " と同値であり、これは ",
        math(String.raw`\mu = \frac{M_{\mathrm{col}}+1}{2}`),
        " と同値である。",
        math(String.raw`\mu \in \mathbb{Z}`),
        " なので ",
        math(String.raw`M_{\mathrm{col}}+1`),
        " は偶数、すなわち ",
        math(String.raw`M_{\mathrm{col}}`),
        " は奇数でなければならない。逆に ",
        math(String.raw`M_{\mathrm{col}}`),
        " が奇数なら ",
        math(String.raw`\frac{M_{\mathrm{col}}+1}{2} \in \mathbb{Z}`),
        " であり、",
        math(String.raw`M_{\mathrm{col}} \geq 2`),
        " と併せて ",
        math(String.raw`1 \leq \frac{M_{\mathrm{col}}+1}{2} \leq M_{\mathrm{col}}`),
        "（右の不等式は ",
        math(String.raw`M_{\mathrm{col}}+1 \leq 2M_{\mathrm{col}} \iff 1 \leq M_{\mathrm{col}}`),
        "）なので ",
        math(String.raw`\frac{M_{\mathrm{col}}+1}{2} \in \check{\mathcal{M}}`),
        "。このとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tilde\theta_{\frac{M_{\mathrm{col}}+1}{2}}
&= \frac{2\pi\left(\frac{M_{\mathrm{col}}+1}{2}-\frac12\right)}{M_{\mathrm{col}}}
&&\bigl(\because \blkref{antiperiodic_exp_sum}\text{ の } \tilde\theta \text{ の定義}\bigr) \\
&= \frac{2\pi\cdot\frac{M_{\mathrm{col}}}{2}}{M_{\mathrm{col}}}
&&\bigl(\because \tfrac{M_{\mathrm{col}}+1}{2}-\tfrac12 = \tfrac{M_{\mathrm{col}}}{2}\bigr) \\
&= \pi
&&\bigl(\because \text{約分}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "(5) ",
        math(String.raw`(\Leftarrow)`),
        " ",
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
        " なら ",
        math(String.raw`\mu+\nu = M_{\mathrm{col}}+1`),
        " なので ",
        math(String.raw`(\mu+\nu) - 1 = M_{\mathrm{col}}`),
        "、すなわち ",
        math(String.raw`\mu+\nu \equiv 1 \pmod M_{\mathrm{col}}`),
        "。",
      ]),
      paragraph([
        math(String.raw`(\Rightarrow)`),
        " ",
        math(String.raw`1 \leq \mu \leq M_{\mathrm{col}}`),
        " と ",
        math(String.raw`1 \leq \nu \leq M_{\mathrm{col}}`),
        " を足すと ",
        math(String.raw`2 \leq \mu+\nu \leq 2M_{\mathrm{col}}`),
        "、よって ",
        math(String.raw`1 \leq \mu+\nu-1 \leq 2M_{\mathrm{col}}-1`),
        "。仮定 ",
        math(String.raw`\mu+\nu \equiv 1 \pmod M_{\mathrm{col}}`),
        " は ",
        math(String.raw`\mu+\nu-1`),
        " が ",
        math(String.raw`M_{\mathrm{col}}`),
        " の倍数であることを意味する（",
        ref("def_delta_M"),
        " の合同の意味）。",
      ]),
      paragraph([
        math(String.raw`M_{\mathrm{col}}`),
        " の倍数 ",
        math(String.raw`lM_{\mathrm{col}}`),
        "（",
        math(String.raw`l \in \mathbb{Z}`),
        "）が ",
        math(String.raw`1 \leq lM_{\mathrm{col}} \leq 2M_{\mathrm{col}}-1`),
        " を満たすのは ",
        math(String.raw`l = 1`),
        " のときに限る（",
        math(String.raw`l \leq 0`),
        " なら ",
        math(String.raw`lM_{\mathrm{col}} \leq 0 < 1`),
        "、",
        math(String.raw`l \geq 2`),
        " なら ",
        math(String.raw`lM_{\mathrm{col}} \geq 2M_{\mathrm{col}} > 2M_{\mathrm{col}}-1`),
        "）。よって ",
        math(String.raw`\mu+\nu-1 = M_{\mathrm{col}}`),
        " すなわち ",
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
        "。",
      ]),
      paragraph([
        "デルタの等式は、",
        ref("def_delta_M"),
        " より ",
        math(String.raw`\delta^{(M_{\mathrm{col}})}_{(\mu+\nu,1)} = 1 \iff \mu+\nu \equiv 1 \pmod M_{\mathrm{col}}`),
        " であり、いま示した同値によりこれが ",
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
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
    id: "evensector_004_claim_commutator_H_check_Z_Y",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/013_even_sector_modes.ts", ordinal: 8 },
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
        ref("def_H1_plus"),
        " の定義により ",
        math(String.raw`H_1^{(+)} = \sum_{m=1}^{M_{\mathrm{col}}-1}Y_mZ_{m+1} - Y_{M_{\mathrm{col}}}Z_1`),
        "）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\text{(A)}\quad \left[H_1^{(+)},\ \check{Z}_\mu\right] &= 2\,\exp(-i\tilde\theta_\mu)\,\check{Y}_\mu, &
\text{(B)}\quad \left[H_1^{(+)},\ \check{Y}_\mu\right] &= -2\,\exp(i\tilde\theta_\mu)\,\check{Z}_\mu, \\
\text{(C)}\quad \left[H_2,\ \check{Z}_\mu\right] &= -2\,\check{Y}_\mu, &
\text{(D)}\quad \left[H_2,\ \check{Y}_\mu\right] &= 2\,\check{Z}_\mu
\end{aligned}`,
      ),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "Step 1（サイトごとの交換関係）。",
        math(String.raw`j \in \{1,\dots,M_{\mathrm{col}}\}`),
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
        String.raw`Y_0^{\flat} := -Y_{M_{\mathrm{col}}},\quad Y_j^{\flat} := Y_j\ (1\leq j\leq M_{\mathrm{col}}),\qquad
Z_{M_{\mathrm{col}}+1}^{\flat} := -Z_1,\quad Z_j^{\flat} := Z_j\ (1\leq j\leq M_{\mathrm{col}})`,
      ),
      paragraph([
        "を用いた（",
        ref("def_jordan_wigner_Z_matrices"),
        " の ",
        math(String.raw`Z_{M_{\mathrm{col}}+1} := Z_1`),
        " という**周期的**な規約とは符号が逆である点に注意）。",
      ]),
      paragraph([
        "準備として、",
        ref("anticommutator_of_Z_and_Y"),
        " から従う関係式をまとめる。",
        math(String.raw`I := I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        "、",
        math(String.raw`j, k \in \{1,\dots,M_{\mathrm{col}}\}`),
        " とする。",
        math(String.raw`j \neq k`),
        " なら ",
        math(String.raw`1 \leq j, k \leq M_{\mathrm{col}}`),
        " より ",
        math(String.raw`j \not\equiv k \pmod M_{\mathrm{col}}`),
        " なので ",
        math(String.raw`\delta^{(M_{\mathrm{col}})}_{(j,k)} = 0`),
        "、また ",
        math(String.raw`\delta^{(M_{\mathrm{col}})}_{(j,j)} = 1`),
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
        math(String.raw`a, b, j \in \{1,\dots,M_{\mathrm{col}}\}`),
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
        math(String.raw`j \in \{1,\dots,M_{\mathrm{col}}\}`),
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
        math(String.raw`m \in \{1,\dots,M_{\mathrm{col}}-1\}`),
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
\left[-Y_{M_{\mathrm{col}}}Z_1,\ Z_1\right]
&= -\left[Y_{M_{\mathrm{col}}}Z_1,\ Z_1\right]
   &&(\because \text{交換子の第 1 引数についての } \mathbb{C} \text{ 線型性}) \\
&= -\left(\left(Y_{M_{\mathrm{col}}}Z_1\right)Z_1 - Z_1\left(Y_{M_{\mathrm{col}}}Z_1\right)\right)
   &&(\because \text{交換子の定義}) \\
&= -\left(Y_{M_{\mathrm{col}}}\left(Z_1Z_1\right) - \left(Z_1Y_{M_{\mathrm{col}}}\right)Z_1\right)
   &&(\because \text{行列の積の結合法則}) \\
&= -\left(Y_{M_{\mathrm{col}}}\,I - \left(Z_1Y_{M_{\mathrm{col}}}\right)Z_1\right)
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_1Z_1 = I)) \\
&= -\left(Y_{M_{\mathrm{col}}} - \left(Z_1Y_{M_{\mathrm{col}}}\right)Z_1\right)
   &&(\because \text{単位行列の性質 } Y_{M_{\mathrm{col}}}\,I = Y_{M_{\mathrm{col}}}) \\
&= -\left(Y_{M_{\mathrm{col}}} - \left(-Y_{M_{\mathrm{col}}}Z_1\right)Z_1\right)
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_1Y_{M_{\mathrm{col}}} = -Y_{M_{\mathrm{col}}}Z_1)) \\
&= -\left(Y_{M_{\mathrm{col}}} + Y_{M_{\mathrm{col}}}\left(Z_1Z_1\right)\right)
   &&(\because \text{結合法則とスカラー倍}) \\
&= -\left(Y_{M_{\mathrm{col}}} + Y_{M_{\mathrm{col}}}\,I\right)
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_1Z_1 = I)) \\
&= -\left(Y_{M_{\mathrm{col}}} + Y_{M_{\mathrm{col}}}\right)
   &&(\because \text{単位行列の性質 } Y_{M_{\mathrm{col}}}\,I = Y_{M_{\mathrm{col}}}) \\
&= -2Y_{M_{\mathrm{col}}}
   &&(\because \text{同類項をまとめる}) \\
&= 2\left(-Y_{M_{\mathrm{col}}}\right)
   &&(\because \text{スカラー倍の符号の整理 } -2Y_{M_{\mathrm{col}}} = 2(-Y_{M_{\mathrm{col}}})) \\
&= 2\,Y_0^{\flat}
   &&(\because Y_0^{\flat} := -Y_{M_{\mathrm{col}}})
\end{aligned}`,
      ),
      paragraph(["と"]),
      displayMath(
        String.raw`\begin{aligned}
\left[-Y_{M_{\mathrm{col}}}Z_1,\ Y_{M_{\mathrm{col}}}\right]
&= -\left[Y_{M_{\mathrm{col}}}Z_1,\ Y_{M_{\mathrm{col}}}\right]
   &&(\because \text{交換子の第 1 引数についての } \mathbb{C} \text{ 線型性}) \\
&= -\left(\left(Y_{M_{\mathrm{col}}}Z_1\right)Y_{M_{\mathrm{col}}} - Y_{M_{\mathrm{col}}}\left(Y_{M_{\mathrm{col}}}Z_1\right)\right)
   &&(\because \text{交換子の定義}) \\
&= -\left(Y_{M_{\mathrm{col}}}\left(Z_1Y_{M_{\mathrm{col}}}\right) - \left(Y_{M_{\mathrm{col}}}Y_{M_{\mathrm{col}}}\right)Z_1\right)
   &&(\because \text{行列の積の結合法則}) \\
&= -\left(Y_{M_{\mathrm{col}}}\left(-Y_{M_{\mathrm{col}}}Z_1\right) - \left(Y_{M_{\mathrm{col}}}Y_{M_{\mathrm{col}}}\right)Z_1\right)
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_1Y_{M_{\mathrm{col}}} = -Y_{M_{\mathrm{col}}}Z_1)) \\
&= -\left(-\left(Y_{M_{\mathrm{col}}}Y_{M_{\mathrm{col}}}\right)Z_1 - \left(Y_{M_{\mathrm{col}}}Y_{M_{\mathrm{col}}}\right)Z_1\right)
   &&(\because \text{結合法則とスカラー倍}) \\
&= -\left(-I\,Z_1 - I\,Z_1\right)
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Y_{M_{\mathrm{col}}}Y_{M_{\mathrm{col}}} = I)) \\
&= -\left(-Z_1 - Z_1\right)
   &&(\because \text{単位行列の性質 } I\,Z_1 = Z_1) \\
&= -\left(-2Z_1\right)
   &&(\because \text{同類項をまとめる}) \\
&= 2Z_1
   &&(\because \text{スカラー倍の符号の整理 } -(-2Z_1) = 2Z_1) \\
&= -2\left(-Z_1\right)
   &&(\because \text{スカラー倍の符号の整理 } 2Z_1 = -2(-Z_1)) \\
&= -2\,Z_{M_{\mathrm{col}}+1}^{\flat}
   &&(\because Z_{M_{\mathrm{col}}+1}^{\flat} := -Z_1)
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
&= \left[\sum_{a=1}^{M_{\mathrm{col}}} Z_aY_a,\ Z_j\right]
   &&(\because \blkref{def_H2}) \\
&= \sum_{a=1}^{M_{\mathrm{col}}}\left[Z_aY_a,\ Z_j\right]
   &&(\because \text{交換子の第 1 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \left[Z_jY_j,\ Z_j\right] + \sum_{\substack{1 \leq a \leq M_{\mathrm{col}} \\ a \neq j}}\left[Z_aY_a,\ Z_j\right]
   &&(\because a = j \text{ の項を有限和から分ける}) \\
&= \left[Z_jY_j,\ Z_j\right] + \sum_{\substack{1 \leq a \leq M_{\mathrm{col}} \\ a \neq j}} 0
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
&= \left[\sum_{a=1}^{M_{\mathrm{col}}} Z_aY_a,\ Y_j\right]
   &&(\because \blkref{def_H2}) \\
&= \sum_{a=1}^{M_{\mathrm{col}}}\left[Z_aY_a,\ Y_j\right]
   &&(\because \text{交換子の第 1 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \left[Z_jY_j,\ Y_j\right] + \sum_{\substack{1 \leq a \leq M_{\mathrm{col}} \\ a \neq j}}\left[Z_aY_a,\ Y_j\right]
   &&(\because a = j \text{ の項を有限和から分ける}) \\
&= \left[Z_jY_j,\ Y_j\right] + \sum_{\substack{1 \leq a \leq M_{\mathrm{col}} \\ a \neq j}} 0
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
        math(String.raw`2 \leq j \leq M_{\mathrm{col}}`),
        " のときは一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_1^{(+)},\ Z_j\right]
&= \left[\sum_{m=1}^{M_{\mathrm{col}}-1} Y_mZ_{m+1} - Y_{M_{\mathrm{col}}}Z_1,\ Z_j\right]
   &&(\because \blkref{def_H1_plus}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\left[Y_mZ_{m+1},\ Z_j\right] - \left[Y_{M_{\mathrm{col}}}Z_1,\ Z_j\right]
   &&(\because \text{交換子の第 1 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\left[Y_mZ_{m+1},\ Z_j\right] - 0
   &&(\because \text{上で示した } \left[Y_aZ_b, Z_j\right] = 0\ (b \neq j) \text{ を } a = M_{\mathrm{col}},\ b = 1 \neq j \text{ に適用}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\left[Y_mZ_{m+1},\ Z_j\right]
   &&(\because \text{零行列を引いても変わらない}) \\
&= \left[Y_{j-1}Z_j,\ Z_j\right] + \sum_{\substack{1 \leq m \leq M_{\mathrm{col}}-1 \\ m \neq j-1}}\left[Y_mZ_{m+1},\ Z_j\right]
   &&(\because 1 \leq j-1 \leq M_{\mathrm{col}}-1 \text{ なので } m = j-1 \text{ の項を有限和から分ける}) \\
&= \left[Y_{j-1}Z_j,\ Z_j\right] + \sum_{\substack{1 \leq m \leq M_{\mathrm{col}}-1 \\ m \neq j-1}} 0
   &&(\because \text{上で示した } \left[Y_aZ_b, Z_j\right] = 0\ (b \neq j) \text{ を } a = m,\ b = m+1 \neq j \text{ として各項へ同時適用}) \\
&= \left[Y_{j-1}Z_j,\ Z_j\right]
   &&(\because \text{零行列の和は零行列}) \\
&= 2Y_{j-1}
   &&(\because \text{上で示した } \left[Y_mZ_{m+1}, Z_{m+1}\right] = 2Y_m \text{ を } m = j-1 \text{ に適用}) \\
&= 2Y_{j-1}^{\flat}
   &&(\because 1 \leq j-1 \leq M_{\mathrm{col}} \text{ では } Y_{j-1}^{\flat} := Y_{j-1})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`j = 1`),
        " のときは一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_1^{(+)},\ Z_1\right]
&= \left[\sum_{m=1}^{M_{\mathrm{col}}-1} Y_mZ_{m+1} - Y_{M_{\mathrm{col}}}Z_1,\ Z_1\right]
   &&(\because \blkref{def_H1_plus}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\left[Y_mZ_{m+1},\ Z_1\right] + \left[-Y_{M_{\mathrm{col}}}Z_1,\ Z_1\right]
   &&(\because \text{交換子の第 1 引数についての加法性}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1} 0 + \left[-Y_{M_{\mathrm{col}}}Z_1,\ Z_1\right]
   &&(\because \text{上で示した } \left[Y_aZ_b, Z_j\right] = 0\ (b \neq j) \text{ を } a = m,\ b = m+1 \geq 2,\ j = 1 \text{ として各項へ同時適用}) \\
&= \left[-Y_{M_{\mathrm{col}}}Z_1,\ Z_1\right]
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
        math(String.raw`1 \leq j \leq M_{\mathrm{col}}-1`),
        " のときは一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_1^{(+)},\ Y_j\right]
&= \left[\sum_{m=1}^{M_{\mathrm{col}}-1} Y_mZ_{m+1} - Y_{M_{\mathrm{col}}}Z_1,\ Y_j\right]
   &&(\because \blkref{def_H1_plus}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\left[Y_mZ_{m+1},\ Y_j\right] - \left[Y_{M_{\mathrm{col}}}Z_1,\ Y_j\right]
   &&(\because \text{交換子の第 1 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\left[Y_mZ_{m+1},\ Y_j\right] - 0
   &&(\because \text{上で示した } \left[Y_aZ_b, Y_j\right] = 0\ (a \neq j) \text{ を } a = M_{\mathrm{col}} \neq j,\ b = 1 \text{ に適用}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\left[Y_mZ_{m+1},\ Y_j\right]
   &&(\because \text{零行列を引いても変わらない}) \\
&= \left[Y_jZ_{j+1},\ Y_j\right] + \sum_{\substack{1 \leq m \leq M_{\mathrm{col}}-1 \\ m \neq j}}\left[Y_mZ_{m+1},\ Y_j\right]
   &&(\because 1 \leq j \leq M_{\mathrm{col}}-1 \text{ なので } m = j \text{ の項を有限和から分ける}) \\
&= \left[Y_jZ_{j+1},\ Y_j\right] + \sum_{\substack{1 \leq m \leq M_{\mathrm{col}}-1 \\ m \neq j}} 0
   &&(\because \text{上で示した } \left[Y_aZ_b, Y_j\right] = 0\ (a \neq j) \text{ を } a = m \neq j,\ b = m+1 \text{ として各項へ同時適用}) \\
&= \left[Y_jZ_{j+1},\ Y_j\right]
   &&(\because \text{零行列の和は零行列}) \\
&= -2Z_{j+1}
   &&(\because \text{上で示した } \left[Y_mZ_{m+1}, Y_m\right] = -2Z_{m+1} \text{ を } m = j \text{ に適用}) \\
&= -2Z_{j+1}^{\flat}
   &&(\because 2 \leq j+1 \leq M_{\mathrm{col}} \text{ では } Z_{j+1}^{\flat} := Z_{j+1})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`j = M_{\mathrm{col}}`),
        " のときは一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_1^{(+)},\ Y_{M_{\mathrm{col}}}\right]
&= \left[\sum_{m=1}^{M_{\mathrm{col}}-1} Y_mZ_{m+1} - Y_{M_{\mathrm{col}}}Z_1,\ Y_{M_{\mathrm{col}}}\right]
   &&(\because \blkref{def_H1_plus}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\left[Y_mZ_{m+1},\ Y_{M_{\mathrm{col}}}\right] + \left[-Y_{M_{\mathrm{col}}}Z_1,\ Y_{M_{\mathrm{col}}}\right]
   &&(\because \text{交換子の第 1 引数についての加法性}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1} 0 + \left[-Y_{M_{\mathrm{col}}}Z_1,\ Y_{M_{\mathrm{col}}}\right]
   &&(\because \text{上で示した } \left[Y_aZ_b, Y_j\right] = 0\ (a \neq j) \text{ を } a = m \leq M_{\mathrm{col}}-1,\ b = m+1,\ j = M_{\mathrm{col}} \text{ として各項へ同時適用}) \\
&= \left[-Y_{M_{\mathrm{col}}}Z_1,\ Y_{M_{\mathrm{col}}}\right]
   &&(\because \text{零行列の和は零行列}) \\
&= -2\,Z_{M_{\mathrm{col}}+1}^{\flat}
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
&= \left[H_2,\ \sum_{j=1}^{M_{\mathrm{col}}} \exp(-ij\tilde\theta_\mu)Z_j\right]
   &&(\because \blkref{def_half_integer_checkZ}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}} \exp(-ij\tilde\theta_\mu)\left[H_2,\ Z_j\right]
   &&(\because \text{交換子の第 2 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}} \exp(-ij\tilde\theta_\mu)\left(-2Y_j\right)
   &&(\because \text{Step 1 の第 1 式}) \\
&= -2\sum_{j=1}^{M_{\mathrm{col}}} \exp(-ij\tilde\theta_\mu)Y_j
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
&= \left[H_2,\ \sum_{j=1}^{M_{\mathrm{col}}} \exp(-ij\tilde\theta_\mu)Y_j\right]
   &&(\because \blkref{def_half_integer_checkY}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}} \exp(-ij\tilde\theta_\mu)\left[H_2,\ Y_j\right]
   &&(\because \text{交換子の第 2 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}} \exp(-ij\tilde\theta_\mu)\cdot 2Z_j
   &&(\because \text{Step 1 の第 2 式}) \\
&= 2\sum_{j=1}^{M_{\mathrm{col}}} \exp(-ij\tilde\theta_\mu)Z_j
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
        math(String.raw`j = 1,\dots,M_{\mathrm{col}}`),
        " が ",
        math(String.raw`l = 0,\dots,M_{\mathrm{col}}-1`),
        " に 1 対 1 で対応する）。また、",
        ref("half_integer_phase_antiperiodicity"),
        " の ",
        math(String.raw`\exp(-iM_{\mathrm{col}}\tilde\theta_\mu) = -1`),
        " と ",
        math(String.raw`Y_0^{\flat} = -Y_{M_{\mathrm{col}}}`),
        " より、境界の二項は一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(-i\cdot 0\cdot\tilde\theta_\mu)\,Y_0^{\flat}
&= 1\cdot Y_0^{\flat}
   &&(\because \exp(0)=1) \\
&= 1\cdot\left(-Y_{M_{\mathrm{col}}}\right)
   &&(\because Y_0^{\flat} := -Y_{M_{\mathrm{col}}}) \\
&= \left(-1\right)Y_{M_{\mathrm{col}}}
   &&(\because \mathbb{C}\text{ の四則}) \\
&= \exp(-iM_{\mathrm{col}}\tilde\theta_\mu)\,Y_{M_{\mathrm{col}}}
   &&(\because \blkref{half_integer_phase_antiperiodicity}) \\
&= \exp(-iM_{\mathrm{col}}\tilde\theta_\mu)\,Y_{M_{\mathrm{col}}}^{\flat}
   &&(\because Y_{M_{\mathrm{col}}}^{\flat} := Y_{M_{\mathrm{col}}}\ (1 \leq M_{\mathrm{col}} \leq M_{\mathrm{col}}))
\end{aligned}`,
      ),
      paragraph([
        "となる。この境界項の等式と Step 1 の第 3 式、交換子の線型性を使うと、主張の左辺から一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_1^{(+)},\ \check{Z}_\mu\right]
&= \left[H_1^{(+)},\ \sum_{j=1}^{M_{\mathrm{col}}} \exp(-ij\tilde\theta_\mu)Z_j\right]
   &&(\because \blkref{def_half_integer_checkZ}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}} \exp(-ij\tilde\theta_\mu)\left[H_1^{(+)},\ Z_j\right]
   &&(\because \text{交換子の第 2 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}} \exp(-ij\tilde\theta_\mu)\cdot 2\,Y_{j-1}^{\flat}
   &&(\because \text{Step 1 の第 3 式}) \\
&= 2\sum_{j=1}^{M_{\mathrm{col}}} \exp(-ij\tilde\theta_\mu)\,Y_{j-1}^{\flat}
   &&(\because \text{スカラー倍を和の外へ出す}) \\
&= 2\sum_{l=0}^{M_{\mathrm{col}}-1} \exp(-i(l+1)\tilde\theta_\mu)\,Y_l^{\flat}
   &&(\because \text{有限和の添字の付け替え } l=j-1) \\
&= 2\sum_{l=0}^{M_{\mathrm{col}}-1} \exp(-i\tilde\theta_\mu)\exp(-il\tilde\theta_\mu)\,Y_l^{\flat}
   &&(\because \blkref{theorem_exp_product}\ (n=1)) \\
&= 2\,\exp(-i\tilde\theta_\mu)\sum_{l=0}^{M_{\mathrm{col}}-1} \exp(-il\tilde\theta_\mu)\,Y_l^{\flat}
   &&(\because \text{分配則}) \\
&= 2\,\exp(-i\tilde\theta_\mu)\sum_{l=1}^{M_{\mathrm{col}}} \exp(-il\tilde\theta_\mu)\,Y_l^{\flat}
   &&(\because \text{直前の displayMath による } l=0 \text{ の項と } l=M_{\mathrm{col}} \text{ の項の入れ替え}) \\
&= 2\,\exp(-i\tilde\theta_\mu)\sum_{l=1}^{M_{\mathrm{col}}} \exp(-il\tilde\theta_\mu)\,Y_l
   &&(\because 1 \leq l \leq M_{\mathrm{col}} \text{ では } Y_l^{\flat} = Y_l) \\
&= 2\,\exp(-i\tilde\theta_\mu)\,\check{Y}_\mu
   &&(\because \blkref{def_half_integer_checkY})
\end{aligned}`,
      ),
      paragraph([
        "Step 4（(B)）。主計算に先立ち、添字を ",
        math(String.raw`l := j+1`),
        " と置き換える（",
        math(String.raw`j = 1,\dots,M_{\mathrm{col}}`),
        " が ",
        math(String.raw`l = 2,\dots,M_{\mathrm{col}}+1`),
        " に 1 対 1 で対応する）。また、",
        ref("half_integer_phase_antiperiodicity"),
        " の ",
        math(String.raw`\exp(-iM_{\mathrm{col}}\tilde\theta_\mu) = -1`),
        " と ",
        math(String.raw`Z_{M_{\mathrm{col}}+1}^{\flat} = -Z_1`),
        " より、境界の二項は一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(-i(M_{\mathrm{col}}+1)\tilde\theta_\mu)\,Z_{M_{\mathrm{col}}+1}^{\flat}
&= \exp(-iM_{\mathrm{col}}\tilde\theta_\mu)\,\exp(-i\tilde\theta_\mu)\,Z_{M_{\mathrm{col}}+1}^{\flat}
   &&(\because \text{theorem\_exp\_product}\ (n=1)) \\
&= \exp(-iM_{\mathrm{col}}\tilde\theta_\mu)\,\exp(-i\tilde\theta_\mu)\left(-Z_1\right)
   &&(\because Z_{M_{\mathrm{col}}+1}^{\flat} := -Z_1) \\
&= \left(-1\right)\exp(-i\tilde\theta_\mu)\left(-Z_1\right)
   &&(\because \blkref{half_integer_phase_antiperiodicity}) \\
&= \exp(-i\tilde\theta_\mu)\,Z_1
   &&(\because \mathbb{C}\text{ の四則}) \\
&= \exp(-i\cdot 1\cdot\tilde\theta_\mu)\,Z_1^{\flat}
   &&(\because Z_1^{\flat} := Z_1)
\end{aligned}`,
      ),
      paragraph([
        "となる。この境界項の等式と Step 1 の第 4 式、交換子の線型性を使うと、主張の左辺から一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_1^{(+)},\ \check{Y}_\mu\right]
&= \left[H_1^{(+)},\ \sum_{j=1}^{M_{\mathrm{col}}} \exp(-ij\tilde\theta_\mu)Y_j\right]
   &&(\because \blkref{def_half_integer_checkY}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}} \exp(-ij\tilde\theta_\mu)\left[H_1^{(+)},\ Y_j\right]
   &&(\because \text{交換子の第 2 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}} \exp(-ij\tilde\theta_\mu)\left(-2\,Z_{j+1}^{\flat}\right)
   &&(\because \text{Step 1 の第 4 式}) \\
&= -2\sum_{j=1}^{M_{\mathrm{col}}} \exp(-ij\tilde\theta_\mu)\,Z_{j+1}^{\flat}
   &&(\because \text{スカラー倍を和の外へ出す}) \\
&= -2\sum_{l=2}^{M_{\mathrm{col}}+1} \exp(-i(l-1)\tilde\theta_\mu)\,Z_{l}^{\flat}
   &&(\because \text{有限和の添字の付け替え } l = j+1) \\
&= -2\sum_{l=2}^{M_{\mathrm{col}}+1} \exp(i\tilde\theta_\mu)\exp(-il\tilde\theta_\mu)\,Z_{l}^{\flat}
   &&(\because \blkref{theorem_exp_product}\ (n=1)) \\
&= -2\,\exp(i\tilde\theta_\mu)\sum_{l=2}^{M_{\mathrm{col}}+1} \exp(-il\tilde\theta_\mu)\,Z_l^{\flat}
   &&(\because \text{分配則}) \\
&= -2\,\exp(i\tilde\theta_\mu)\sum_{l=1}^{M_{\mathrm{col}}} \exp(-il\tilde\theta_\mu)\,Z_l^{\flat}
   &&(\because \text{直前の displayMath による } l=M_{\mathrm{col}}+1 \text{ の項と } l=1 \text{ の項の入れ替え}) \\
&= -2\,\exp(i\tilde\theta_\mu)\sum_{l=1}^{M_{\mathrm{col}}} \exp(-il\tilde\theta_\mu)\,Z_l
   &&(\because 1 \leq l \leq M_{\mathrm{col}} \text{ では } Z_l^{\flat} = Z_l) \\
&= -2\,\exp(i\tilde\theta_\mu)\,\check{Z}_\mu
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
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "evensectorT_000_remark_overview",
    kind: "remark",
    origin: { path: "structured-latex/content/014_even_sector_T_action.ts", ordinal: 2 },
    title: { tex: String.raw`T_{(V^{(+)})} \text{ の } \check{Z}_\mu, \check{Y}_\mu \text{ への作用を求める道筋}` },
    labels: [],
    statement: [
      paragraph([
        ref("commutator_of_H_and_check_Z_Y"),
        " で、",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " が ",
        math(String.raw`H_1^{(+)}, H_2`),
        " に対して満たす交換関係 (A)〜(D) を得た。以下では、そこから",
      ]),
      displayMath(
        String.raw`\left(T_{(V^{(+)})}(\check{Z}_\mu),\ T_{(V^{(+)})}(\check{Y}_\mu)\right)
= \left(\check{Z}_\mu,\ \check{Y}_\mu\right) A\!\left(\tilde\theta_\mu\right),
\qquad
A\!\left(\tilde\theta_\mu\right) = B_1\!\left(\tilde\theta_\mu\right) B_2 B_1\!\left(\tilde\theta_\mu\right)`,
      ),
      paragraph([
        "まで到達する。ここで ",
        math(String.raw`V^{(+)} = \left(V_1^{(+)}\right)^{1/2} V_2 \left(V_1^{(+)}\right)^{1/2}`),
        " は ",
        ref("def_V_plus"),
        " の行列（",
        math(String.raw`H_1^{(+)}`),
        " は ",
        ref("def_H1_plus"),
        "、",
        math(String.raw`\left(V_1^{(+)}\right)^{1/2}`),
        " は ",
        ref("def_V1_plus_square_root"),
        "）であり、",
        math(String.raw`A(\theta)`),
        " は ",
        ref("def_A_theta"),
        " の（",
        math(String.raw`\theta \in \mathbb{C}`),
        " について定義された）行列である。",
      ]),
      paragraph([
        "道筋は次のとおりである。(A)〜(D) を繰り返し使って ",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " の ",
        math(String.raw`n`),
        " 重交換子を求め（",
        ref("nesting_of_commutator_of_H_and_check_Z"),
        "）、指数関数の共役の級数展開（",
        ref("exp_X_Y_exp_-X"),
        "）で ",
        math(String.raw`T_{\left(V_1^{(+)}\right)^{1/2}}`),
        " と ",
        math(String.raw`T_{V_2}`),
        " の作用を得て（",
        ref("T_actions_on_check_Z_Y"),
        "）、それらを合成する（",
        ref("T_V_plus_check_Z_Y"),
        "）。用いるのは (A)〜(D)、交換子の双線型性、",
        math(String.raw`\exp(i\theta)\exp(-i\theta) = 1`),
        " と行列の計算だけである。",
      ]),
      paragraph([
        "**添字の量化について。** ",
        ref("def_half_integer_checkZ"),
        " と ",
        ref("def_half_integer_checkY"),
        " は ",
        math(String.raw`\mu \in \mathbb{Z}`),
        " について定義されているが、",
        ref("half_integer_checkZ_periodicity"),
        " の添字周期性 ",
        math(String.raw`\check{Z}_{\mu+M_{\mathrm{col}}} = \check{Z}_\mu`),
        " により本質的に相異なる添字は ",
        math(String.raw`M_{\mathrm{col}}`),
        " 個である。**以下の主張はすべて ",
        ref("def_check_index_set"),
        " の ",
        math(String.raw`\mu \in \check{\mathcal{M}} = \{1,\dots,M_{\mathrm{col}}\}`),
        " について述べる。**",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
        "2026-10-31: 章立ての組み直しで、014 章の案内文から離散 Fourier 変換による 2×2 行列 A(θ̃_μ) への帰着の章の中の案内文へ移し、交換関係の主張の直後に置いた。「この章」を「以下」に、用語「半整数運動量モード」「偶セクターの転送行列」を式で指す言い方に直した。",
      ],
    },
  },
  {
    id: "evensectorT_claim_V1_plus_half_invertible",
    kind: "claim",
    origin: { path: "structured-latex/content/014_even_sector_T_action.ts", ordinal: 3 },
    title: { tex: String.raw`\left(V_1^{(+)}\right)^{1/2} \text{ の可逆性}` },
    labels: ["V1_plus_half_invertible"],
    statement: [
      paragraph([
        ref("def_V1_plus_square_root"),
        " で定めた ",
        math(String.raw`\left(V_1^{(+)}\right)^{1/2}`),
        " は可逆である。すなわち、",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`R^\times`),
        " の元である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\tfrac{i}{2}K_1H_1^{(+)}\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb C)`),
        " である。逆行列を一続きに計算すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\left(V_1^{(+)}\right)^{1/2}\right)^{-1}
&=\exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)^{-1}
&&\bigl(\because\ \blkref{def_V1_plus_square_root}\bigr)\\
&=\exp\!\left(-\tfrac{i}{2}K_1H_1^{(+)}\right)
&&\bigl(\because\ \blkref{matrix_exp_conjugation}\text{ (3)}\bigr)
\end{aligned}`),
      paragraph([
        "したがって ", math(String.raw`\left(V_1^{(+)}\right)^{1/2}`),
        " は可逆である。",
      ]),
    ],
    conversion: { status: "added" },
  },
  {
    id: "evensectorT_claim_V2_invertible",
    kind: "claim",
    origin: { path: "structured-latex/content/014_even_sector_T_action.ts", ordinal: 3 },
    title: { tex: String.raw`V_2 \text{ の可逆性}` },
    labels: ["V2_invertible"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " で定めた ",
        math(String.raw`V_2`),
        " は可逆である。すなわち、",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`R^\times`),
        " の元である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("matrix_exp_conjugation"),
        " (3) を ",
        math(String.raw`iK_2^*H_2\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " に適用すると、",
        math(String.raw`\exp\!\left(iK_2^*H_2\right)`),
        " は可逆である。",
      ]),
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " より ",
        math(String.raw`K_2 > 0`),
        " より ",
        math(String.raw`s_2 = \sinh 2K_2 > 0`),
        " なので ",
        math(String.raw`(2s_2)^{M_{\mathrm{col}}/2} \in \mathbb{C}\setminus\{0\}`),
        " である。",
        ref("def_invertible_elements_of_R"),
        " (iv) より",
      ]),
      displayMath(String.raw`(2s_2)^{M_{\mathrm{col}}/2}I\in R^\times`),
      paragraph([
        ref("V2_exponential_representation"),
        " の指数表示により",
      ]),
      displayMath(String.raw`V_2=(2s_2)^{M_{\mathrm{col}}/2}I\cdot\exp\!\left(iK_2^*H_2\right)`),
      paragraph([
        ref("def_invertible_elements_of_R"),
        " (ii) をこの積へ適用すると、",
        math(String.raw`V_2\in R^\times`),
        " である。",
      ]),
    ],
    conversion: { status: "added" },
  },
  {
    id: "evensectorT_definition_T_V_plus",
    kind: "definition",
    origin: { path: "structured-latex/content/014_even_sector_T_action.ts", ordinal: 3 },
    title: { tex: String.raw`T_{(V^{(+)})} := T_{\left(V_1^{(+)}\right)^{1/2}} \circ T_{V_2} \circ T_{\left(V_1^{(+)}\right)^{1/2}}` },
    labels: ["def_T_V_plus"],
    statement: [
      paragraph([
        ref("def_V_plus"),
        " で ",
        math(String.raw`V^{(+)}`),
        " を作る三つの因子は、",
        ref("V1_plus_half_invertible"),
        " と ",
        ref("V2_invertible"),
        " により可逆である。そこで ",
        ref("def_T_g"),
        " の ",
        math(String.raw`T_g(X) = gXg^{-1}`),
        " を用いて",
      ]),
      displayMath(
        String.raw`T_{(V^{(+)})}(X) := T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(
T_{V_2}\!\left(T_{\left(V_1^{(+)}\right)^{1/2}}(X)\right)\right)
\qquad \left(X \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})\right)`,
      ),
    ],
    conversion: { status: "added" },
  },
  {
    id: "evensectorT_002_claim_nesting_commutator",
    kind: "claim",
    origin: { path: "structured-latex/content/014_even_sector_T_action.ts", ordinal: 4 },
    title: { tex: String.raw`\check{Z}, \check{Y} \text{ についての } n \text{ 重交換子}` },
    labels: ["nesting_of_commutator_of_H_and_check_Z"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " とする。",
        math(String.raw`H_1^{(+)}, H_2, \check{Z}_\mu, \check{Y}_\mu`),
        " はすべて ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の元であり（",
        ref("def_half_integer_checkZ"),
        "、",
        ref("def_half_integer_checkY"),
        "、",
        ref("def_H1_plus"),
        "、",
        ref("def_H2"),
        "）、",
        math(String.raw`K_1, K_2^* \in \mathbb{R}`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " のスカラー、",
        math(String.raw`[X, W] := XW - WX`),
        " は交換子である。",
        math(String.raw`X \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
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
        math(String.raw`n = 0`),
        " のときは恒等写像、すなわち値は ",
        math(String.raw`W`),
        " そのもの）。以下、",
        math(String.raw`\tilde\theta := \tilde\theta_\mu`),
        " と略記する。",
      ]),
      paragraph(["(h1.z)"]),
      displayMath(
        String.raw`\underbrace{[K_1 H_1^{(+)}, \dots, [K_1 H_1^{(+)}, \check{Z}_\mu]\dots]}_{n}
= \begin{cases}
(-1)^{(n-1)/2}(2K_1)^n \exp(-i\tilde\theta)\,\check{Y}_\mu & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_1)^n\,\check{Z}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h1.y)"]),
      displayMath(
        String.raw`\underbrace{[K_1 H_1^{(+)}, \dots, [K_1 H_1^{(+)}, \check{Y}_\mu]\dots]}_{n}
= \begin{cases}
(-1)^{(n+1)/2}(2K_1)^n \exp(i\tilde\theta)\,\check{Z}_\mu & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_1)^n\,\check{Y}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h2.z)"]),
      displayMath(
        String.raw`\underbrace{[K_2^* H_2, \dots, [K_2^* H_2, \check{Z}_\mu]\dots]}_{n}
= \begin{cases}
(-1)^{(n+1)/2}(2K_2^*)^n\,\check{Y}_\mu & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_2^*)^n\,\check{Z}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h2.y)"]),
      displayMath(
        String.raw`\underbrace{[K_2^* H_2, \dots, [K_2^* H_2, \check{Y}_\mu]\dots]}_{n}
= \begin{cases}
(-1)^{(n-1)/2}(2K_2^*)^n\,\check{Z}_\mu & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_2^*)^n\,\check{Y}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
    ],
    proof: [
      paragraph([
        "証明はすべて ",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " に関する帰納法であり、用いるのは ",
        ref("commutator_of_H_and_check_Z_Y"),
        " の 1 重の交換子の公式",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\text{(A)}\quad \left[H_1^{(+)}, \check{Z}_\mu\right] &= 2 \exp(-i\tilde\theta)\,\check{Y}_\mu, &
\text{(B)}\quad \left[H_1^{(+)}, \check{Y}_\mu\right] &= -2 \exp(i\tilde\theta)\,\check{Z}_\mu, \\
\text{(C)}\quad \left[H_2, \check{Z}_\mu\right] &= -2\,\check{Y}_\mu, &
\text{(D)}\quad \left[H_2, \check{Y}_\mu\right] &= 2\,\check{Z}_\mu
\end{aligned}`,
      ),
      paragraph([
        "と、交換子の第 1 引数・第 2 引数についての ",
        math(String.raw`\mathbb{C}`),
        " 双線型性",
      ]),
      displayMath(
        String.raw`[\alpha X, \beta W] = \alpha\beta\,[X, W]
\qquad (\alpha, \beta \in \mathbb{C},\ X, W \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C}))`,
      ),
      paragraph([
        "だけである。後者は、スカラー倍が積と可換なこと（",
        ref("scalar_identity_commutes"),
        "）を使って次のように得られる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[\alpha X, \beta W]
&= (\alpha X)(\beta W) - (\beta W)(\alpha X)
&&\bigl(\because \text{交換子の定義}\bigr) \\
&= \alpha\beta\,XW - \alpha\beta\,WX
&&\bigl(\because \text{スカラー倍が積と可換であること}\bigr) \\
&= \alpha\beta\,(XW - WX)
&&\bigl(\because \text{分配則}\bigr) \\
&= \alpha\beta\,[X, W]
&&\bigl(\because \text{交換子の定義}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "また ",
        math(String.raw`\exp(-i\tilde\theta)\exp(i\tilde\theta) = 1`),
        " を使う。各主張の右辺は ",
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
        math(String.raw`C_n := \underbrace{[K_1 H_1^{(+)},\dots,[K_1 H_1^{(+)}, \check{Z}_\mu]\dots]}_{n}`),
        " とおくと、定義より ",
        math(String.raw`C_{n+1} = [K_1 H_1^{(+)},\, C_n]`),
        " が ",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について成り立つ。",
      ]),
      paragraph([
        "基底段階（",
        math(String.raw`n = 0`),
        "、偶数）では、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
C_0
&= \check{Z}_\mu
&&\bigl(\because\ 0\ \text{重交換子は恒等写像}\bigr) \\
&= (-1)^0(2K_1)^0\check{Z}_\mu
&&\bigl(\because\ (-1)^0=1\ \text{かつ}\ (2K_1)^0=1\bigr)
\end{aligned}`,
      ),
      paragraph(["となり、偶数側の右辺と一致する。"]),
      paragraph([
        "帰納段階 1（",
        math(String.raw`n`),
        " 偶数 → ",
        math(String.raw`n+1`),
        " 奇数）：",
        math(String.raw`C_n = (-1)^{n/2}(2K_1)^n\check{Z}_\mu`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
C_{n+1}
&= \left[K_1 H_1^{(+)},\ (-1)^{n/2}(2K_1)^n\check{Z}_\mu\right]
&&\bigl(\because C_{n+1} = [K_1 H_1^{(+)},\, C_n] \text{ と帰納法の仮定}\bigr) \\
&= K_1\cdot(-1)^{n/2}(2K_1)^n\left[H_1^{(+)},\ \check{Z}_\mu\right]
&&\bigl(\because \text{交換子の双線型性}\bigr) \\
&= K_1\cdot(-1)^{n/2}(2K_1)^n\cdot 2 \exp(-i\tilde\theta)\check{Y}_\mu
&&\bigl(\because \text{(A)}\bigr) \\
&= (-1)^{n/2}(2K_1)^{n+1} \exp(-i\tilde\theta)\check{Y}_\mu
&&\bigl(\because \text{スカラー倍の交換と } K_1\cdot(2K_1)^n\cdot 2 = (2K_1)^{n+1}\bigr)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`n+1`),
        " は奇数で、奇数側の右辺の符号は ",
        math(String.raw`(-1)^{((n+1)-1)/2} = (-1)^{n/2}`),
        " であり、係数 ",
        math(String.raw`(2K_1)^{n+1}`),
        " と位相因子 ",
        math(String.raw`\exp(-i\tilde\theta)`),
        " も一致する。",
      ]),
      paragraph([
        "帰納段階 2（",
        math(String.raw`n`),
        " 奇数 → ",
        math(String.raw`n+1`),
        " 偶数）：",
        math(String.raw`C_n = (-1)^{(n-1)/2}(2K_1)^n \exp(-i\tilde\theta)\check{Y}_\mu`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
C_{n+1}
&= \left[K_1 H_1^{(+)},\ (-1)^{(n-1)/2}(2K_1)^n \exp(-i\tilde\theta)\check{Y}_\mu\right]
&&\bigl(\because C_{n+1} = [K_1 H_1^{(+)},\, C_n] \text{ と帰納法の仮定}\bigr) \\
&= K_1\cdot(-1)^{(n-1)/2}(2K_1)^n \exp(-i\tilde\theta)\left[H_1^{(+)},\ \check{Y}_\mu\right]
&&\bigl(\because \text{交換子の双線型性}\bigr) \\
&= K_1\cdot(-1)^{(n-1)/2}(2K_1)^n \exp(-i\tilde\theta)\cdot\left(-2 \exp(i\tilde\theta)\check{Z}_\mu\right)
&&\bigl(\because \text{(B)}\bigr) \\
&= (-1)\cdot(-1)^{(n-1)/2}(2K_1)^{n+1}\,\overbrace{\exp(-i\tilde\theta)\exp(i\tilde\theta)}^{=\,1}\,\check{Z}_\mu
&&\bigl(\because \text{スカラー倍の交換と } K_1\cdot(2K_1)^n\cdot(-2) = (-1)(2K_1)^{n+1}\bigr) \\
&= (-1)^{(n-1)/2+1}(2K_1)^{n+1}\check{Z}_\mu
&&\bigl(\because \exp(-i\tilde\theta)\exp(i\tilde\theta) = 1 \text{ と } (-1)\cdot(-1)^{(n-1)/2} = (-1)^{(n-1)/2+1}\bigr) \\
&= (-1)^{(n+1)/2}(2K_1)^{n+1}\check{Z}_\mu
&&\bigl(\because \tfrac{n-1}{2}+1 = \tfrac{n+1}{2}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "最後の等号は ",
        math(String.raw`\dfrac{n-1}{2}+1 = \dfrac{n+1}{2}`),
        " による。",
        math(String.raw`n+1`),
        " は偶数なので偶数側の右辺 ",
        math(String.raw`(-1)^{(n+1)/2}(2K_1)^{n+1}\check{Z}_\mu`),
        " と一致する（位相因子は ",
        math(String.raw`\exp(-i\tilde\theta)\exp(i\tilde\theta)=1`),
        " により消える）。以上で (h1.z) が成り立つ。",
      ]),

      paragraph([
        "(h1.y) の証明。",
        math(String.raw`D_n := \underbrace{[K_1 H_1^{(+)},\dots,[K_1 H_1^{(+)}, \check{Y}_\mu]\dots]}_{n}`),
        " とおく。",
        math(String.raw`D_{n+1} = [K_1 H_1^{(+)},\, D_n]`),
        "。基底段階（",
        math(String.raw`n=0`),
        "、偶数）では、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
D_0
&= \check{Y}_\mu
&&\bigl(\because\ 0\ \text{重交換子は恒等写像}\bigr) \\
&= (-1)^0(2K_1)^0\check{Y}_\mu
&&\bigl(\because\ (-1)^0=1\ \text{かつ}\ (2K_1)^0=1\bigr)
\end{aligned}`,
      ),
      paragraph(["となり、偶数側の右辺と一致する。"]),
      paragraph([
        "帰納段階 1（",
        math(String.raw`n`),
        " 偶数 → ",
        math(String.raw`n+1`),
        " 奇数）：",
        math(String.raw`D_n = (-1)^{n/2}(2K_1)^n\check{Y}_\mu`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
D_{n+1}
&= \left[K_1 H_1^{(+)},\ (-1)^{n/2}(2K_1)^n\check{Y}_\mu\right]
&&\bigl(\because D_{n+1} = [K_1 H_1^{(+)},\, D_n] \text{ と帰納法の仮定}\bigr) \\
&= K_1\cdot(-1)^{n/2}(2K_1)^n\left[H_1^{(+)},\ \check{Y}_\mu\right]
&&\bigl(\because \text{交換子の双線型性}\bigr) \\
&= K_1\cdot(-1)^{n/2}(2K_1)^n\cdot\left(-2 \exp(i\tilde\theta)\check{Z}_\mu\right)
&&\bigl(\because \text{(B)}\bigr) \\
&= (-1)^{n/2+1}(2K_1)^{n+1} \exp(i\tilde\theta)\check{Z}_\mu
&&\bigl(\because \text{スカラー倍の交換と } K_1\cdot(2K_1)^n\cdot(-2) = (-1)(2K_1)^{n+1}\bigr)
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
        math(String.raw`D_n = (-1)^{(n+1)/2}(2K_1)^n \exp(i\tilde\theta)\check{Z}_\mu`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
D_{n+1}
&= \left[K_1 H_1^{(+)},\ (-1)^{(n+1)/2}(2K_1)^n \exp(i\tilde\theta)\check{Z}_\mu\right]
&&\bigl(\because D_{n+1} = [K_1 H_1^{(+)},\, D_n] \text{ と帰納法の仮定}\bigr) \\
&= K_1\cdot(-1)^{(n+1)/2}(2K_1)^n \exp(i\tilde\theta)\left[H_1^{(+)},\ \check{Z}_\mu\right]
&&\bigl(\because \text{交換子の双線型性}\bigr) \\
&= K_1\cdot(-1)^{(n+1)/2}(2K_1)^n \exp(i\tilde\theta)\cdot 2 \exp(-i\tilde\theta)\check{Y}_\mu
&&\bigl(\because \text{(A)}\bigr) \\
&= (-1)^{(n+1)/2}(2K_1)^{n+1}\,\overbrace{\exp(i\tilde\theta)\exp(-i\tilde\theta)}^{=\,1}\,\check{Y}_\mu
&&\bigl(\because \text{スカラー倍の交換と } K_1\cdot(2K_1)^n\cdot 2 = (2K_1)^{n+1}\bigr) \\
&= (-1)^{(n+1)/2}(2K_1)^{n+1}\check{Y}_\mu
&&\bigl(\because \exp(i\tilde\theta)\exp(-i\tilde\theta) = 1\bigr)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`n+1`),
        " は偶数で、偶数側の右辺の符号 ",
        math(String.raw`(-1)^{(n+1)/2}`),
        " と一致する。以上で (h1.y) が成り立つ。",
      ]),

      paragraph([
        "(h2.z) の証明。",
        math(String.raw`E_n := \underbrace{[K_2^* H_2,\dots,[K_2^* H_2, \check{Z}_\mu]\dots]}_{n}`),
        " とおく。",
        math(String.raw`E_{n+1} = [K_2^* H_2,\, E_n]`),
        "。この場合は (C), (D) の右辺に ",
        math(String.raw`\exp(\pm i\tilde\theta)`),
        " が現れないので位相因子は出てこない。基底段階（",
        math(String.raw`n=0`),
        "、偶数）では、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E_0
&= \check{Z}_\mu
&&\bigl(\because\ 0\ \text{重交換子は恒等写像}\bigr) \\
&= (-1)^0(2K_2^*)^0\check{Z}_\mu
&&\bigl(\because\ (-1)^0=1\ \text{かつ}\ (2K_2^*)^0=1\bigr)
\end{aligned}`,
      ),
      paragraph(["となり、偶数側の右辺と一致する。"]),
      paragraph([
        "帰納段階 1（",
        math(String.raw`n`),
        " 偶数 → ",
        math(String.raw`n+1`),
        " 奇数）：",
        math(String.raw`E_n = (-1)^{n/2}(2K_2^*)^n\check{Z}_\mu`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E_{n+1}
&= \left[K_2^* H_2,\ (-1)^{n/2}(2K_2^*)^n\check{Z}_\mu\right]
&&\bigl(\because E_{n+1} = [K_2^* H_2,\, E_n] \text{ と帰納法の仮定}\bigr) \\
&= K_2^*\cdot(-1)^{n/2}(2K_2^*)^n\left[H_2,\ \check{Z}_\mu\right]
&&\bigl(\because \text{交換子の双線型性}\bigr) \\
&= K_2^*\cdot(-1)^{n/2}(2K_2^*)^n\cdot\left(-2\,\check{Y}_\mu\right)
&&\bigl(\because \text{(C)}\bigr) \\
&= (-1)^{n/2}(-1)(2K_2^*)^n(2K_2^*)\check{Y}_\mu
&&\bigl(\because \text{スカラー倍の交換と結合。} K_2^*\cdot(-2) = (-1)(2K_2^*)\bigr) \\
&= (-1)^{n/2+1}(2K_2^*)^{n+1}\check{Y}_\mu
&&\bigl(\because \text{冪の指数法則を } (-1) \text{ と } 2K_2^* \text{ の両方へ適用}\bigr)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`n+1`),
        " は奇数で、奇数側の右辺の符号 ",
        math(String.raw`(-1)^{((n+1)+1)/2} = (-1)^{n/2+1}`),
        " と一致する。",
      ]),
      paragraph([
        "帰納段階 2（",
        math(String.raw`n`),
        " 奇数 → ",
        math(String.raw`n+1`),
        " 偶数）：",
        math(String.raw`E_n = (-1)^{(n+1)/2}(2K_2^*)^n\check{Y}_\mu`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E_{n+1}
&= \left[K_2^* H_2,\ (-1)^{(n+1)/2}(2K_2^*)^n\check{Y}_\mu\right]
&&\bigl(\because E_{n+1} = [K_2^* H_2,\, E_n] \text{ と帰納法の仮定}\bigr) \\
&= K_2^*\cdot(-1)^{(n+1)/2}(2K_2^*)^n\left[H_2,\ \check{Y}_\mu\right]
&&\bigl(\because \text{交換子の双線型性}\bigr) \\
&= K_2^*\cdot(-1)^{(n+1)/2}(2K_2^*)^n\cdot 2\,\check{Z}_\mu
&&\bigl(\because \text{(D)}\bigr) \\
&= (-1)^{(n+1)/2}(2K_2^*)^n(2K_2^*)\check{Z}_\mu
&&\bigl(\because \text{スカラー倍の交換と結合}\bigr) \\
&= (-1)^{(n+1)/2}(2K_2^*)^{n+1}\check{Z}_\mu
&&\bigl(\because \text{冪の指数法則}\bigr)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`n+1`),
        " は偶数で、偶数側の右辺の符号 ",
        math(String.raw`(-1)^{(n+1)/2}`),
        " と一致する。以上で (h2.z) が成り立つ。",
      ]),

      paragraph([
        "(h2.y) の証明。",
        math(String.raw`F_n := \underbrace{[K_2^* H_2,\dots,[K_2^* H_2, \check{Y}_\mu]\dots]}_{n}`),
        " とおく。",
        math(String.raw`F_{n+1} = [K_2^* H_2,\, F_n]`),
        "。基底段階（",
        math(String.raw`n=0`),
        "、偶数）では、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
F_0
&= \check{Y}_\mu
&&\bigl(\because\ 0\ \text{重交換子は恒等写像}\bigr) \\
&= (-1)^0(2K_2^*)^0\check{Y}_\mu
&&\bigl(\because\ (-1)^0=1\ \text{かつ}\ (2K_2^*)^0=1\bigr)
\end{aligned}`,
      ),
      paragraph(["となり、偶数側の右辺と一致する。"]),
      paragraph([
        "帰納段階 1（",
        math(String.raw`n`),
        " 偶数 → ",
        math(String.raw`n+1`),
        " 奇数）：",
        math(String.raw`F_n = (-1)^{n/2}(2K_2^*)^n\check{Y}_\mu`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
F_{n+1}
&= \left[K_2^* H_2,\ (-1)^{n/2}(2K_2^*)^n\check{Y}_\mu\right]
&&\bigl(\because F_{n+1} = [K_2^* H_2,\, F_n] \text{ と帰納法の仮定}\bigr) \\
&= K_2^*\cdot(-1)^{n/2}(2K_2^*)^n\left[H_2,\ \check{Y}_\mu\right]
&&\bigl(\because \text{交換子の双線型性}\bigr) \\
&= K_2^*\cdot(-1)^{n/2}(2K_2^*)^n\cdot 2\,\check{Z}_\mu
&&\bigl(\because \text{(D)}\bigr) \\
&= (-1)^{n/2}(2K_2^*)^n(2K_2^*)\check{Z}_\mu
&&\bigl(\because \text{スカラー倍の交換と結合}\bigr) \\
&= (-1)^{n/2}(2K_2^*)^{n+1}\check{Z}_\mu
&&\bigl(\because \text{冪の指数法則}\bigr)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`n+1`),
        " は奇数で、奇数側の右辺の符号 ",
        math(String.raw`(-1)^{((n+1)-1)/2} = (-1)^{n/2}`),
        " と一致する。",
      ]),
      paragraph([
        "帰納段階 2（",
        math(String.raw`n`),
        " 奇数 → ",
        math(String.raw`n+1`),
        " 偶数）：",
        math(String.raw`F_n = (-1)^{(n-1)/2}(2K_2^*)^n\check{Z}_\mu`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
F_{n+1}
&= \left[K_2^* H_2,\ (-1)^{(n-1)/2}(2K_2^*)^n\check{Z}_\mu\right]
&&\bigl(\because F_{n+1} = [K_2^* H_2,\, F_n] \text{ と帰納法の仮定}\bigr) \\
&= K_2^*\cdot(-1)^{(n-1)/2}(2K_2^*)^n\left[H_2,\ \check{Z}_\mu\right]
&&\bigl(\because \text{交換子の双線型性}\bigr) \\
&= K_2^*\cdot(-1)^{(n-1)/2}(2K_2^*)^n\cdot\left(-2\,\check{Y}_\mu\right)
&&\bigl(\because \text{(C)}\bigr) \\
&= (-1)^{(n-1)/2}(-1)(2K_2^*)^n(2K_2^*)\check{Y}_\mu
&&\bigl(\because \text{スカラー倍の交換と結合。} K_2^*\cdot(-2) = (-1)(2K_2^*)\bigr) \\
&= (-1)^{(n-1)/2+1}(2K_2^*)^{n+1}\check{Y}_\mu
&&\bigl(\because \text{冪の指数法則を } (-1) \text{ と } 2K_2^* \text{ の両方へ適用}\bigr) \\
&= (-1)^{(n+1)/2}(2K_2^*)^{n+1}\check{Y}_\mu
&&\bigl(\because \tfrac{n-1}{2}+1 = \tfrac{n+1}{2}\bigr)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`n+1`),
        " は偶数で、偶数側の右辺の符号 ",
        math(String.raw`(-1)^{(n+1)/2}`),
        " と一致する。以上で (h2.y) が成り立つ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の nesting_of_commutator_of_H_and_Z と同じ帰納法を、(A)〜(D) を commutator_of_H_and_check_Z_Y から取って半整数運動量について繰り返したもの。008 章の証明が θ_μ に固有の性質（e^{-iMθ_μ}=+1、添字集合 calM、hatZ_hatY_M_periodicity）を一切使っていないことを確認したうえで書いた。使うのは (A)〜(D) と交換子の双線型性と e^{iθ}e^{-iθ}=1 だけである。",
        "008 章では (h2.z) が hatZ^{(-)} 専用だったのに対し、ここでは (C)(D) が checkZ, checkY について成り立つので (h2.z)(h2.y) にセクターの制限が付かない。これが偶セクターで議論が閉じる理由である。",
        "M=2,3,4,5、μ=1..M、n=0..8、5 組の (K1,K2)（臨界点上・臨界点近傍を含む）で数値確認済み（sagemath/check/047_claim_even_sector_T_action/check_01_nested_commutators.sage）。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "evensectorT_003_claim_coefficient_conversion",
    kind: "claim",
    origin: { path: "structured-latex/content/014_even_sector_T_action.ts", ordinal: 5 },
    title: { tex: String.raw`\check{Z}, \check{Y} \text{ についての } \cosh, \sinh \text{ の展開係数への変換}` },
    labels: ["cosh_sinh_coefficient_conversion_for_check"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " とし、",
        math(String.raw`\tilde\theta := \tilde\theta_\mu`),
        " と略記する。",
      ]),
      paragraph(["(h1.z)"]),
      displayMath(
        String.raw`\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(+)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(+)},\check{Z}_\mu\right]\dots\right]}_{n}
= \begin{cases}
i K_1^n \exp(-i\tilde\theta)\,\check{Y}_\mu & (n \text{ 奇数}) \\
K_1^n\,\check{Z}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h1.y)"]),
      displayMath(
        String.raw`\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(+)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(+)},\check{Y}_\mu\right]\dots\right]}_{n}
= \begin{cases}
-i K_1^n \exp(i\tilde\theta)\,\check{Z}_\mu & (n \text{ 奇数}) \\
K_1^n\,\check{Y}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h2.z)"]),
      displayMath(
        String.raw`\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\check{Z}_\mu\right]\dots\right]}_{n}
= \begin{cases}
-i (2K_2^*)^n\,\check{Y}_\mu & (n \text{ 奇数}) \\
(2K_2^*)^n\,\check{Z}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h2.y)"]),
      displayMath(
        String.raw`\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\check{Y}_\mu\right]\dots\right]}_{n}
= \begin{cases}
i (2K_2^*)^n\,\check{Z}_\mu & (n \text{ 奇数}) \\
(2K_2^*)^n\,\check{Y}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
    ],
    proof: [
      paragraph([
        "まず 4 式すべてで用いる 2 つの補題を用意する（いずれも ",
        math(String.raw`\check{Z}, \check{Y}`),
        " とは無関係に ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の任意の元について成り立つ）。",
      ]),
      paragraph([
        "補題 1（生成子のスカラー倍）：",
        math(String.raw`\alpha \in \mathbb{C}`),
        "、",
        math(String.raw`X, W \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(
        String.raw`\underbrace{[\alpha X,\dots,[\alpha X, W]\dots]}_{n}
= \alpha^{n}\,\underbrace{[X,\dots,[X, W]\dots]}_{n}`,
      ),
      paragraph([
        "が成り立つ。実際、交換子の第 1 引数についての ",
        math(String.raw`\mathbb{C}`),
        " 線型性より、任意の ",
        math(String.raw`W`),
        " について次の一続きが成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ad}_{\alpha X}(W)
&=[\alpha X,W]
&&\bigl(\because\ \mathrm{ad}\text{ の定義}\bigr)\\
&=\alpha[X,W]
&&\bigl(\because\ \text{交換子の第 1 引数についての }\mathbb{C}\text{ 線型性}\bigr)\\
&=\alpha\,\mathrm{ad}_X(W)
&&\bigl(\because\ \mathrm{ad}\text{ の定義}\bigr)
\end{aligned}`),
      paragraph([
        "任意の ",
        math(String.raw`W`),
        " で成り立つので、線型写像として ",
        math(String.raw`\mathrm{ad}_{\alpha X}=\alpha\,\mathrm{ad}_X`),
        " である。したがって、",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ad}_{\alpha X}^{\,n}
&=(\alpha\,\mathrm{ad}_X)^n
&&\bigl(\because\ \mathrm{ad}_{\alpha X}=\alpha\,\mathrm{ad}_X\bigr)\\
&=\alpha^n\,\mathrm{ad}_X^{\,n}
&&\bigl(\because\ \mathrm{ad}_X\text{ は }\mathbb{C}\text{ 線型であり、合成の各段からスカラーを前へ出せる}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`n = 0`),
        " のときは両辺とも恒等写像で ",
        math(String.raw`\alpha^0 = 1`),
        " により成立する。",
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
        "が成り立つ。実際 ",
        math(String.raw`i^2 = -1`),
        " を使う。",
      ]),
      displayMath(String.raw`\begin{aligned}
i^n
&=(i^2)^{n/2}
&&\bigl(\because\ n\text{ が偶数なら }n=2(n/2)\bigr)\\
&=(-1)^{n/2}
&&\bigl(\because\ i^2=-1\bigr)
\end{aligned}
\qquad(n\text{ が偶数})`),
      displayMath(String.raw`\begin{aligned}
i^n
&=i\,(i^2)^{(n-1)/2}
&&\bigl(\because\ n\text{ が奇数なら }n=1+2((n-1)/2)\bigr)\\
&=i\,(-1)^{(n-1)/2}
&&\bigl(\because\ i^2=-1\bigr)
\end{aligned}
\qquad(n\text{ が奇数})`),
      paragraph(["いずれの指数も整数である。"]),
      paragraph([
        "(h1.z) について、補題 1 を ",
        math(String.raw`\alpha = \tfrac{i}{2}`),
        "、",
        math(String.raw`X = K_1 H_1^{(+)}`),
        "、",
        math(String.raw`W = \check{Z}_\mu`),
        " として使い、",
        ref("nesting_of_commutator_of_H_and_check_Z"),
        " (h1.z) を代入する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(+)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(+)},\check{Z}_\mu\right]\dots\right]}_{n}
&= \left(\tfrac{i}{2}\right)^{n}
   \underbrace{\left[K_1 H_1^{(+)},\dots,\left[K_1 H_1^{(+)},\check{Z}_\mu\right]\dots\right]}_{n}
   \quad (\because \text{補題 1}) \\
&= \left(\tfrac{i}{2}\right)^{n}\begin{cases}
(-1)^{(n-1)/2}(2K_1)^{n} \exp(-i\tilde\theta)\check{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(2K_1)^{n}\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \blkref{nesting_of_commutator_of_H_and_check_Z}\text{ (h1.z)}) \\
&= i^n2^{-n}\begin{cases}
(-1)^{(n-1)/2}(2K_1)^n\exp(-i\tilde\theta)\check{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(2K_1)^n\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because (i/2)^n=i^n2^{-n}) \\
&= i^n2^{-n}\begin{cases}
(-1)^{(n-1)/2}2^nK_1^n\exp(-i\tilde\theta)\check{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}2^nK_1^n\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because (2K_1)^n=2^nK_1^n) \\
&= \begin{cases}
i^{n}\,2^{-n}\,2^{n}\,(-1)^{(n-1)/2}\,K_1^{n}\, \exp(-i\tilde\theta)\check{Y}_\mu & (n\text{ 奇数}) \\
i^{n}\,2^{-n}\,2^{n}\,(-1)^{n/2}\,K_1^{n}\,\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \mathbb C\text{ の分配律・交換律}) \\
&= \begin{cases}
i^{n}\,(-1)^{(n-1)/2}\,K_1^{n}\, \exp(-i\tilde\theta)\check{Y}_\mu & (n\text{ 奇数}) \\
i^{n}\,(-1)^{n/2}\,K_1^{n}\,\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad \left(\because 2^{-n}2^{n} = 2^{0} = 1\right) \\
&= \begin{cases}
i\,(-1)^{(n-1)/2}(-1)^{(n-1)/2}\,K_1^{n}\, \exp(-i\tilde\theta)\check{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(-1)^{n/2}\,K_1^{n}\,\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \text{補題 2}) \\
&= \begin{cases}
i\,(-1)^{n-1}\,K_1^{n}\, \exp(-i\tilde\theta)\check{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n}\,K_1^{n}\,\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad \left(\because \frac{n-1}{2}+\frac{n-1}{2} = n-1,\ \frac{n}{2}+\frac{n}{2} = n\right) \\
&= \begin{cases}
i\,K_1^{n}\, \exp(-i\tilde\theta)\check{Y}_\mu & (n\text{ 奇数}) \\
K_1^{n}\,\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because n \text{ 奇数なら } (-1)^{n-1} = 1,\ n \text{ 偶数なら } (-1)^{n} = 1)
\end{aligned}`,
      ),
      paragraph([
        "最後の等号は、",
        math(String.raw`n`),
        " が奇数なら ",
        math(String.raw`n-1`),
        " が偶数で ",
        math(String.raw`(-1)^{n-1} = 1`),
        "、",
        math(String.raw`n`),
        " が偶数なら ",
        math(String.raw`(-1)^{n} = 1`),
        " による。",
      ]),
      paragraph([
        "(h1.y) について、補題 1 を ",
        math(String.raw`\alpha = \tfrac{i}{2}`),
        "、",
        math(String.raw`X = K_1 H_1^{(+)}`),
        "、",
        math(String.raw`W = \check{Y}_\mu`),
        " として使い、",
        ref("nesting_of_commutator_of_H_and_check_Z"),
        " (h1.y) を代入する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(+)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(+)},\check{Y}_\mu\right]\dots\right]}_{n}
&= \left(\tfrac{i}{2}\right)^{n}
   \underbrace{\left[K_1 H_1^{(+)},\dots,\left[K_1 H_1^{(+)},\check{Y}_\mu\right]\dots\right]}_{n}
   \quad (\because \text{補題 1}) \\
&= \left(\tfrac{i}{2}\right)^{n}\begin{cases}
(-1)^{(n+1)/2}(2K_1)^{n} \exp(i\tilde\theta)\check{Z}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(2K_1)^{n}\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \blkref{nesting_of_commutator_of_H_and_check_Z}\text{ (h1.y)}) \\
&= i^n2^{-n}\begin{cases}
(-1)^{(n+1)/2}(2K_1)^n\exp(i\tilde\theta)\check{Z}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(2K_1)^n\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because (i/2)^n=i^n2^{-n}) \\
&= i^n2^{-n}\begin{cases}
(-1)^{(n+1)/2}2^nK_1^n\exp(i\tilde\theta)\check{Z}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}2^nK_1^n\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because (2K_1)^n=2^nK_1^n) \\
&= \begin{cases}
i^{n}\,2^{-n}\,2^{n}\,(-1)^{(n+1)/2}\,K_1^{n}\, \exp(i\tilde\theta)\check{Z}_\mu & (n\text{ 奇数}) \\
i^{n}\,2^{-n}\,2^{n}\,(-1)^{n/2}\,K_1^{n}\,\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \mathbb C\text{ の分配律・交換律}) \\
&= \begin{cases}
i^{n}\,(-1)^{(n+1)/2}\,K_1^{n}\, \exp(i\tilde\theta)\check{Z}_\mu & (n\text{ 奇数}) \\
i^{n}\,(-1)^{n/2}\,K_1^{n}\,\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad \left(\because 2^{-n}2^{n} = 2^{0} = 1\right) \\
&= \begin{cases}
i\,(-1)^{(n-1)/2}(-1)^{(n+1)/2}\,K_1^{n}\, \exp(i\tilde\theta)\check{Z}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(-1)^{n/2}\,K_1^{n}\,\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \text{補題 2}) \\
&= \begin{cases}
i\,(-1)^{n}\,K_1^{n}\, \exp(i\tilde\theta)\check{Z}_\mu & (n\text{ 奇数}) \\
(-1)^{n}\,K_1^{n}\,\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad \left(\because \frac{n-1}{2}+\frac{n+1}{2} = n\right) \\
&= \begin{cases}
-i\,K_1^{n}\, \exp(i\tilde\theta)\check{Z}_\mu & (n\text{ 奇数}) \\
K_1^{n}\,\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because n \text{ 奇数なら } (-1)^{n} = -1,\ n \text{ 偶数なら } (-1)^{n} = 1)
\end{aligned}`,
      ),
      paragraph([
        "最後の等号は、",
        math(String.raw`n`),
        " が奇数なら ",
        math(String.raw`(-1)^{n} = -1`),
        "、偶数なら ",
        math(String.raw`(-1)^{n} = 1`),
        " による。",
      ]),
      paragraph([
        "(h2.z) について、補題 1 を ",
        math(String.raw`\alpha = i`),
        "、",
        math(String.raw`X = K_2^* H_2`),
        "、",
        math(String.raw`W = \check{Z}_\mu`),
        " として使う。今回は ",
        math(String.raw`\alpha = i`),
        " なので ",
        math(String.raw`2`),
        " の冪が現れず、",
        math(String.raw`(2K_2^*)^n`),
        " はそのまま残る。代入する ",
        math(String.raw`n`),
        " 重交換子は ",
        ref("nesting_of_commutator_of_H_and_check_Z"),
        " (h2.z) である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\check{Z}_\mu\right]\dots\right]}_{n}
&= i^{n}
   \underbrace{\left[K_2^* H_2,\dots,\left[K_2^* H_2,\check{Z}_\mu\right]\dots\right]}_{n}
   \quad (\because \text{補題 1}) \\
&= i^{n}\begin{cases}
(-1)^{(n+1)/2}(2K_2^*)^{n}\check{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(2K_2^*)^{n}\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \blkref{nesting_of_commutator_of_H_and_check_Z}\text{ (h2.z)}) \\
&= \begin{cases}
i\,(-1)^{(n-1)/2}(-1)^{(n+1)/2}(2K_2^*)^{n}\check{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(-1)^{n/2}(2K_2^*)^{n}\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \text{補題 2}) \\
&= \begin{cases}
i\,(-1)^{n}(2K_2^*)^{n}\check{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n}(2K_2^*)^{n}\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad \left(\because \frac{n-1}{2}+\frac{n+1}{2} = n,\ \frac{n}{2}+\frac{n}{2} = n\right) \\
&= \begin{cases}
-i\,(2K_2^*)^{n}\check{Y}_\mu & (n\text{ 奇数}) \\
(2K_2^*)^{n}\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because n \text{ 奇数なら } (-1)^n = -1,\ n \text{ 偶数なら } (-1)^n = 1)
\end{aligned}`,
      ),
      paragraph([
        "(h2.y) について、補題 1 を ",
        math(String.raw`\alpha = i`),
        "、",
        math(String.raw`X = K_2^* H_2`),
        "、",
        math(String.raw`W = \check{Y}_\mu`),
        " として使い、",
        ref("nesting_of_commutator_of_H_and_check_Z"),
        " (h2.y) を代入する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\check{Y}_\mu\right]\dots\right]}_{n}
&= i^{n}
   \underbrace{\left[K_2^* H_2,\dots,\left[K_2^* H_2,\check{Y}_\mu\right]\dots\right]}_{n}
   \quad (\because \text{補題 1}) \\
&= i^{n}\begin{cases}
(-1)^{(n-1)/2}(2K_2^*)^{n}\check{Z}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(2K_2^*)^{n}\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \blkref{nesting_of_commutator_of_H_and_check_Z}\text{ (h2.y)}) \\
&= \begin{cases}
i\,(-1)^{(n-1)/2}(-1)^{(n-1)/2}(2K_2^*)^{n}\check{Z}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(-1)^{n/2}(2K_2^*)^{n}\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \text{補題 2}) \\
&= \begin{cases}
i\,(-1)^{n-1}(2K_2^*)^{n}\check{Z}_\mu & (n\text{ 奇数}) \\
(-1)^{n}(2K_2^*)^{n}\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad \left(\because \frac{n-1}{2}+\frac{n-1}{2} = n-1,\ \frac{n}{2}+\frac{n}{2} = n\right) \\
&= \begin{cases}
i\,(2K_2^*)^{n}\check{Z}_\mu & (n\text{ 奇数}) \\
(2K_2^*)^{n}\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because n \text{ 奇数なら } (-1)^{n-1} = 1,\ n \text{ 偶数なら } (-1)^n = 1)
\end{aligned}`,
      ),
      paragraph([
        "以上 4 式が、",
        ref("nesting_of_commutator_of_H_and_check_Z"),
        " の各式に補題 1・補題 2 を適用して得られた。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の cosh_sinh_coefficient_conversion と同一形の計算を半整数運動量について繰り返したもの。用いる補題 1・補題 2 は θ にも Z,Y にも依存しない純代数的な主張なので、そのまま同じものを使える。",
        "M=2,3,4,5、μ=1..M、n=0..8 で数値確認済み（sagemath/check/047_claim_even_sector_T_action/check_01_nested_commutators.sage の scaled 列）。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "evensectorT_004_claim_extract_taylor",
    kind: "claim",
    origin: { path: "structured-latex/content/014_even_sector_T_action.ts", ordinal: 6 },
    title: { tex: String.raw`\check{Z}, \check{Y} \text{ についてのテイラー係数の抽出}` },
    labels: ["extract_taylor_coefficient_of_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " とし ",
        math(String.raw`\tilde\theta := \tilde\theta_\mu`),
        " と略記する。次の 4 つの級数は ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " において収束し（",
        ref("matrix_exp_conjugation"),
        " (1)）、それぞれ次に等しい。",
      ]),
      paragraph(["(h1.z)"]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}
\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(+)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(+)},\check{Z}_\mu\right]\dots\right]}_{n}
= \cosh(K_1)\check{Z}_\mu + i \exp(-i\tilde\theta)\sinh(K_1)\check{Y}_\mu`,
      ),
      paragraph(["(h1.y)"]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}
\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(+)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(+)},\check{Y}_\mu\right]\dots\right]}_{n}
= -i \exp(i\tilde\theta)\sinh(K_1)\check{Z}_\mu + \cosh(K_1)\check{Y}_\mu`,
      ),
      paragraph(["(h2.z)"]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}
\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\check{Z}_\mu\right]\dots\right]}_{n}
= \cosh(2K_2^*)\check{Z}_\mu - i\sinh(2K_2^*)\check{Y}_\mu`,
      ),
      paragraph(["(h2.y)"]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}
\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\check{Y}_\mu\right]\dots\right]}_{n}
= i\sinh(2K_2^*)\check{Z}_\mu + \cosh(2K_2^*)\check{Y}_\mu`,
      ),
    ],
    proof: [
      paragraph([
        "各級数を ",
        ref("cosh_sinh_coefficient_conversion_for_check"),
        " により偶数項・奇数項に分け、",
        ref("sinh_cosh_taylor_series"),
        " の ",
        math(String.raw`\sinh, \cosh`),
        " のテイラー展開",
      ]),
      displayMath(
        String.raw`\sinh x = \sum_{\substack{n \geq 1 \\ n \text{ 奇数}}} \frac{x^n}{n!}, \qquad
\cosh x = \sum_{\substack{n \geq 0 \\ n \text{ 偶数}}} \frac{x^n}{n!}`,
      ),
      paragraph([
        "を用いる。(h1.z) について、",
        ref("cosh_sinh_coefficient_conversion_for_check"),
        " の (h1.z) を用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\text{左辺})
&= \frac{1}{0!}\check{Z}_\mu
   + \sum_{n=1}^{\infty}\frac{1}{n!}\begin{cases}
i\,K_1^{n}\,\exp(-i\tilde\theta)\,\check{Y}_\mu & (n\text{ 奇数}) \\
K_1^{n}\,\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \blkref{cosh_sinh_coefficient_conversion_for_check}\text{ (h1.z)}) \\
&= \sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\left(\frac{1}{n!}K_1^{n}\check{Z}_\mu\right)
   + \sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\left(\frac{1}{n!}\,i\,K_1^{n}\,\exp(-i\tilde\theta)\,\check{Y}_\mu\right)
   \quad (\because n = 0 \text{ 項を偶数側の和へ吸収し、偶数項と奇数項に分けた}) \\
&= \left(\sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\frac{1}{n!}K_1^{n}\right)\check{Z}_\mu
   + i\,\exp(-i\tilde\theta)\left(\sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\frac{1}{n!}K_1^{n}\right)\check{Y}_\mu
   \quad (\because \check{Z}_\mu, \check{Y}_\mu, i \exp(-i\tilde\theta) \text{ が } n \text{ に依らないので和の外へ出した}) \\
&= \cosh(K_1)\check{Z}_\mu + i\,\exp(-i\tilde\theta)\sinh(K_1)\check{Y}_\mu
   \quad (\because \blkref{sinh_cosh_taylor_series})
\end{aligned}`,
      ),
      paragraph([
        "1 行目で ",
        math(String.raw`n = 0`),
        " 項を分けて書いたが、",
        ref("cosh_sinh_coefficient_conversion_for_check"),
        " (h1.z) の偶数側は ",
        math(String.raw`n = 0`),
        " でも ",
        math(String.raw`K_1^{0}\check{Z}_\mu = \check{Z}_\mu = \frac{1}{0!}\check{Z}_\mu`),
        " と一致するので、2 行目では ",
        math(String.raw`n = 0`),
        " 項を偶数側の和へ吸収した（以下の 3 式でも同様）。3 行目では ",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " と ",
        math(String.raw`i \exp(-i\tilde\theta)`),
        " が ",
        math(String.raw`n`),
        " に依らないので和の外へ出した。",
      ]),
      paragraph([
        "(h1.y) について、",
        ref("cosh_sinh_coefficient_conversion_for_check"),
        " の (h1.y) を用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\text{左辺})
&= \frac{1}{0!}\check{Y}_\mu
   + \sum_{n=1}^{\infty}\frac{1}{n!}\begin{cases}
-i\,K_1^{n}\,\exp(i\tilde\theta)\,\check{Z}_\mu & (n\text{ 奇数}) \\
K_1^{n}\,\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \blkref{cosh_sinh_coefficient_conversion_for_check}\text{ (h1.y)}) \\
&= \sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\left(\frac{1}{n!}K_1^{n}\check{Y}_\mu\right)
   + \sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\left(\frac{1}{n!}\,(-i)\,K_1^{n}\,\exp(i\tilde\theta)\,\check{Z}_\mu\right)
   \quad (\because n = 0 \text{ 項を偶数側の和へ吸収し、偶数項と奇数項に分けた}) \\
&= \left(\sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\frac{1}{n!}K_1^{n}\right)\check{Y}_\mu
   - i\,\exp(i\tilde\theta)\left(\sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\frac{1}{n!}K_1^{n}\right)\check{Z}_\mu
   \quad (\because \check{Z}_\mu, \check{Y}_\mu, -i \exp(i\tilde\theta) \text{ が } n \text{ に依らないので和の外へ出した}) \\
&= \cosh(K_1)\check{Y}_\mu - i\,\exp(i\tilde\theta)\sinh(K_1)\check{Z}_\mu
   \quad (\because \blkref{sinh_cosh_taylor_series}) \\
&= -i\,\exp(i\tilde\theta)\sinh(K_1)\check{Z}_\mu + \cosh(K_1)\check{Y}_\mu
   \quad (\because \text{行列加法の可換則})
\end{aligned}`,
      ),
      paragraph([
        "(h2.z) について、",
        ref("cosh_sinh_coefficient_conversion_for_check"),
        " の (h2.z) を用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\text{左辺})
&= \frac{1}{0!}\check{Z}_\mu
   + \sum_{n=1}^{\infty}\frac{1}{n!}\begin{cases}
-i\,(2K_2^*)^{n}\,\check{Y}_\mu & (n\text{ 奇数}) \\
(2K_2^*)^{n}\,\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \blkref{cosh_sinh_coefficient_conversion_for_check}\text{ (h2.z)}) \\
&= \sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\left(\frac{1}{n!}(2K_2^*)^{n}\check{Z}_\mu\right)
   + \sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\left(\frac{1}{n!}\,(-i)\,(2K_2^*)^{n}\,\check{Y}_\mu\right)
   \quad (\because n = 0 \text{ 項を偶数側の和へ吸収し、偶数項と奇数項に分けた}) \\
&= \left(\sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\frac{1}{n!}(2K_2^*)^{n}\right)\check{Z}_\mu
   - i\left(\sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\frac{1}{n!}(2K_2^*)^{n}\right)\check{Y}_\mu
   \quad (\because \check{Z}_\mu, \check{Y}_\mu, -i \text{ が } n \text{ に依らないので和の外へ出した}) \\
&= \cosh(2K_2^*)\check{Z}_\mu - i\sinh(2K_2^*)\check{Y}_\mu
   \quad (\because \blkref{sinh_cosh_taylor_series})
\end{aligned}`,
      ),
      paragraph([
        "(h2.y) について、",
        ref("cosh_sinh_coefficient_conversion_for_check"),
        " の (h2.y) を用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\text{左辺})
&= \frac{1}{0!}\check{Y}_\mu
   + \sum_{n=1}^{\infty}\frac{1}{n!}\begin{cases}
i\,(2K_2^*)^{n}\,\check{Z}_\mu & (n\text{ 奇数}) \\
(2K_2^*)^{n}\,\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \blkref{cosh_sinh_coefficient_conversion_for_check}\text{ (h2.y)}) \\
&= \sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\left(\frac{1}{n!}(2K_2^*)^{n}\check{Y}_\mu\right)
   + \sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\left(\frac{1}{n!}\,i\,(2K_2^*)^{n}\,\check{Z}_\mu\right)
   \quad (\because n = 0 \text{ 項を偶数側の和へ吸収し、偶数項と奇数項に分けた}) \\
&= \left(\sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\frac{1}{n!}(2K_2^*)^{n}\right)\check{Y}_\mu
   + i\left(\sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\frac{1}{n!}(2K_2^*)^{n}\right)\check{Z}_\mu
   \quad (\because \check{Z}_\mu, \check{Y}_\mu, i \text{ が } n \text{ に依らないので和の外へ出した}) \\
&= \cosh(2K_2^*)\check{Y}_\mu + i\sinh(2K_2^*)\check{Z}_\mu
   \quad (\because \blkref{sinh_cosh_taylor_series}) \\
&= i\sinh(2K_2^*)\check{Z}_\mu + \cosh(2K_2^*)\check{Y}_\mu
   \quad (\because \text{行列加法の可換則})
\end{aligned}`,
      ),
      paragraph([
        "以上 4 式がいずれも statement の右辺と一致する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の extract_taylor_coefficient_of_Z_Y と同一形。sinh/cosh のテイラー展開は 008 章の TV1_hatZ_hatY_004_claim_sinh_cosh_taylor がラベルを持たないため、ここでは式を再掲して使った。",
        "級数を 40 次で打ち切った数値検証を M=2,3,4,5・μ=1..M・5 組の (K1,K2) で実施し、残差 1e-13 以下（sagemath/check/047_claim_even_sector_T_action/check_02_taylor_sums.sage）。",
        "4 式の係数変換の適用を各式鎖の直前から実在ラベルで参照し、(h1.y)・(h2.y) の終端の項の交換へ行列加法の可換則を明記した（2026-08-15）。",
        "2026-09-26: sinh, cosh のテイラー展開の適用を sinh_cosh_taylor_series のラベル参照で引くようにした。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "evensectorT_005_claim_T_actions",
    kind: "claim",
    origin: { path: "structured-latex/content/014_even_sector_T_action.ts", ordinal: 7 },
    title: { tex: String.raw`T_{\left(V_1^{(+)}\right)^{1/2}}, T_{V_2} \text{ の } \check{Z}, \check{Y} \text{ への作用}` },
    labels: ["T_actions_on_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " について（",
        math(String.raw`\tilde\theta := \tilde\theta_\mu`),
        "）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu)
&= \cosh(K_1)\check{Z}_\mu + i \exp(-i\tilde\theta)\sinh(K_1)\check{Y}_\mu
= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
  \begin{pmatrix}\cosh(K_1) \\ i \exp(-i\tilde\theta)\sinh(K_1)\end{pmatrix} \\
T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)
&= -i \exp(i\tilde\theta)\sinh(K_1)\check{Z}_\mu + \cosh(K_1)\check{Y}_\mu
= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
  \begin{pmatrix}-i \exp(i\tilde\theta)\sinh(K_1) \\ \cosh(K_1)\end{pmatrix} \\
T_{V_2}(\check{Z}_\mu)
&= \cosh(2K_2^*)\check{Z}_\mu - i\sinh(2K_2^*)\check{Y}_\mu
= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
  \begin{pmatrix}\cosh(2K_2^*) \\ -i\sinh(2K_2^*)\end{pmatrix} \\
T_{V_2}(\check{Y}_\mu)
&= i\sinh(2K_2^*)\check{Z}_\mu + \cosh(2K_2^*)\check{Y}_\mu
= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
  \begin{pmatrix}i\sinh(2K_2^*) \\ \cosh(2K_2^*)\end{pmatrix}
\end{aligned}`,
      ),
      paragraph([
        "ここで行ベクトルと列ベクトルの積は ",
        math(String.raw`\begin{pmatrix}A, & B\end{pmatrix}\begin{pmatrix}a \\ b\end{pmatrix} := aA + bB`),
        "（",
        math(String.raw`A, B \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "、",
        math(String.raw`a, b \in \mathbb{C}`),
        "）とする。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu)`),
        " について、",
        ref("def_T_g"),
        "、",
        ref("def_V1_plus_square_root"),
        " の定義、",
        ref("matrix_exp_conjugation"),
        " (3) の ",
        math(String.raw`\exp(X)^{-1} = \exp(-X)`),
        "、",
        ref("exp_X_Y_exp_-X"),
        "、",
        ref("extract_taylor_coefficient_of_check_Z_Y"),
        " を順に用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu)
&= \left(V_1^{(+)}\right)^{1/2}\,\check{Z}_\mu\,\left(\left(V_1^{(+)}\right)^{1/2}\right)^{-1}
   \quad (\because \blkref{def_T_g}) \\
&= \exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\,\check{Z}_\mu\,
   \left(\exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\right)^{-1}
   \quad \left(\because \blkref{def_V1_plus_square_root}:\ \left(V_1^{(+)}\right)^{1/2} := \exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\right) \\
&= \exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\,\check{Z}_\mu\,
   \exp\!\left(-\tfrac{i}{2}K_1H_1^{(+)}\right)
   \quad \left(\because \blkref{matrix_exp_conjugation}\text{ (3)}:\ \exp(X)^{-1} = \exp(-X)\right) \\
&= \sum_{n=0}^{\infty}\frac{1}{n!}
   \underbrace{\left[\tfrac{i}{2}K_1H_1^{(+)},\dots,\left[\tfrac{i}{2}K_1H_1^{(+)},\check{Z}_\mu\right]\dots\right]}_{n}
   \quad (\because \blkref{exp_X_Y_exp_-X}) \\
&= \cosh(K_1)\check{Z}_\mu + i\,\exp(-i\tilde\theta)\sinh(K_1)\check{Y}_\mu
   \quad (\because \blkref{extract_taylor_coefficient_of_check_Z_Y}\text{ (h1.z)})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)`),
        " については、作用させる元が ",
        math(String.raw`\check{Z}_\mu`),
        " から ",
        math(String.raw`\check{Y}_\mu`),
        " へ変わるだけで共役の展開はまったく同じ手順であり、最後に ",
        ref("extract_taylor_coefficient_of_check_Z_Y"),
        " の (h1.y) を使う。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)
&= \left(V_1^{(+)}\right)^{1/2}\,\check{Y}_\mu\,\left(\left(V_1^{(+)}\right)^{1/2}\right)^{-1}
   \quad (\because \blkref{def_T_g}) \\
&= \exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\,\check{Y}_\mu\,
   \left(\exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\right)^{-1}
   \quad \left(\because \blkref{def_V1_plus_square_root}:\ \left(V_1^{(+)}\right)^{1/2} := \exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\right) \\
&= \exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\,\check{Y}_\mu\,
   \exp\!\left(-\tfrac{i}{2}K_1H_1^{(+)}\right)
   \quad \left(\because \blkref{matrix_exp_conjugation}\text{ (3)}:\ \exp(X)^{-1} = \exp(-X)\right) \\
&= \sum_{n=0}^{\infty}\frac{1}{n!}
   \underbrace{\left[\tfrac{i}{2}K_1H_1^{(+)},\dots,\left[\tfrac{i}{2}K_1H_1^{(+)},\check{Y}_\mu\right]\dots\right]}_{n}
   \quad (\because \blkref{exp_X_Y_exp_-X}) \\
&= -i\,\exp(i\tilde\theta)\sinh(K_1)\check{Z}_\mu + \cosh(K_1)\check{Y}_\mu
   \quad (\because \blkref{extract_taylor_coefficient_of_check_Z_Y}\text{ (h1.y)})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`T_{V_2}`),
        " については、",
        ref("V2_exponential_representation"),
        " の ",
        math(String.raw`V_2 = (2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(iK_2^*H_2\right)`),
        " の前因子 ",
        math(String.raw`(2s_2)^{M_{\mathrm{col}}/2} \in \mathbb{C}\setminus\{0\}`),
        " が共役で打ち消し合う。実際 ",
        ref("scalar_identity_commutes"),
        " より ",
        math(String.raw`(2s_2)^{M_{\mathrm{col}}/2}I`),
        " は任意の元と可換であり、",
        ref("def_invertible_elements_of_R"),
        " (ii)(iv) より ",
        math(String.raw`V_2^{-1} = \left((2s_2)^{M_{\mathrm{col}}/2}\right)^{-1}\exp\!\left(-iK_2^*H_2\right)`),
        " である（",
        ref("def_T_g"),
        " と ",
        ref("exp_X_Y_exp_-X"),
        " も以下で使う）。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{V_2}(\check{Z}_\mu)
&= V_2\,\check{Z}_\mu\,V_2^{-1}
   \quad (\because \blkref{def_T_g}) \\
&= (2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(iK_2^*H_2\right)\,\check{Z}_\mu\,
   \left((2s_2)^{M_{\mathrm{col}}/2}\right)^{-1}\exp\!\left(-iK_2^*H_2\right)
   \quad (\because \blkref{V2_exponential_representation}\text{ と直前の } V_2^{-1} \text{ の表示}) \\
&= (2s_2)^{M_{\mathrm{col}}/2}\left((2s_2)^{M_{\mathrm{col}}/2}\right)^{-1}
   \exp\!\left(iK_2^*H_2\right)\,\check{Z}_\mu\,\exp\!\left(-iK_2^*H_2\right)
   \quad (\because \blkref{scalar_identity_commutes}\text{（スカラー } \left((2s_2)^{M_{\mathrm{col}}/2}\right)^{-1} \text{ を左端へ移す）}) \\
&= \exp\!\left(iK_2^*H_2\right)\,\check{Z}_\mu\,\exp\!\left(-iK_2^*H_2\right)
   \quad (\because (2s_2)^{M_{\mathrm{col}}/2}\left((2s_2)^{M_{\mathrm{col}}/2}\right)^{-1} = 1) \\
&= \sum_{n=0}^{\infty}\frac{1}{n!}
   \underbrace{\left[iK_2^*H_2,\dots,\left[iK_2^*H_2,\check{Z}_\mu\right]\dots\right]}_{n}
   \quad (\because \blkref{exp_X_Y_exp_-X}) \\
&= \cosh(2K_2^*)\check{Z}_\mu - i\sinh(2K_2^*)\check{Y}_\mu
   \quad (\because \blkref{extract_taylor_coefficient_of_check_Z_Y}\text{ (h2.z)})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
T_{V_2}(\check{Y}_\mu)
&= V_2\,\check{Y}_\mu\,V_2^{-1}
   \quad (\because \blkref{def_T_g}) \\
&= (2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(iK_2^*H_2\right)\,\check{Y}_\mu\,
   \left((2s_2)^{M_{\mathrm{col}}/2}\right)^{-1}\exp\!\left(-iK_2^*H_2\right)
   \quad (\because \blkref{V2_exponential_representation}\text{ と直前の } V_2^{-1} \text{ の表示}) \\
&= (2s_2)^{M_{\mathrm{col}}/2}\left((2s_2)^{M_{\mathrm{col}}/2}\right)^{-1}
   \exp\!\left(iK_2^*H_2\right)\,\check{Y}_\mu\,\exp\!\left(-iK_2^*H_2\right)
   \quad (\because \blkref{scalar_identity_commutes}\text{（スカラー } \left((2s_2)^{M_{\mathrm{col}}/2}\right)^{-1} \text{ を左端へ移す）}) \\
&= \exp\!\left(iK_2^*H_2\right)\,\check{Y}_\mu\,\exp\!\left(-iK_2^*H_2\right)
   \quad (\because (2s_2)^{M_{\mathrm{col}}/2}\left((2s_2)^{M_{\mathrm{col}}/2}\right)^{-1} = 1) \\
&= \sum_{n=0}^{\infty}\frac{1}{n!}
   \underbrace{\left[iK_2^*H_2,\dots,\left[iK_2^*H_2,\check{Y}_\mu\right]\dots\right]}_{n}
   \quad (\because \blkref{exp_X_Y_exp_-X}) \\
&= i\sinh(2K_2^*)\check{Z}_\mu + \cosh(2K_2^*)\check{Y}_\mu
   \quad (\because \blkref{extract_taylor_coefficient_of_check_Z_Y}\text{ (h2.y)})
\end{aligned}`,
      ),
      paragraph([
        "最後に、行ベクトルと列ベクトルの積の定義 ",
        math(String.raw`\begin{pmatrix}A, & B\end{pmatrix}\begin{pmatrix}a \\ b\end{pmatrix} = aA + bB`),
        " により、上の 4 式はいずれも statement の行列表示に書き換えられる。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の ホロノミック量子場_p142下段_1 の半整数運動量版。008 章では H_1 の符号 (±) と hatZ の符号 (-) が食い違ったまま書かれていたが（why_008_applies_only_to_minus_sector により実質 (-) 専用）、ここでは H_1^{(+)} と checkZ, checkY で首尾一貫している。",
        "行列指数関数を明示的に構成した直接計算（交換子の級数展開に依存しない独立経路）で数値確認済み。V_2 の前因子 (2 s_2)^{M/2} を明示的に付けた形で相殺も確認した（sagemath/check/047_claim_even_sector_T_action/check_03_T_actions.sage）。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "evensectorT_006_claim_linearity_of_T",
    kind: "claim",
    origin: { path: "structured-latex/content/014_even_sector_T_action.ts", ordinal: 8 },
    title: { tex: String.raw`\left(V_1^{(+)}\right)^{1/2} \text{ による共役写像の } \mathbb{C} \text{ 線型性}` },
    labels: ["linearity_of_T_on_check_Z_Y"],
    statement: [
      paragraph([
        ref("def_half_integer_checkZ"),
        " と ",
        ref("def_half_integer_checkY"),
        " と ",
        ref("def_check_index_set"),
        " の記号を用いる。",
        math(String.raw`\mu\in\check{\mathcal M}`),
        " と ",
        math(String.raw`a,b\in\mathbb C`),
        " について、",
      ]),
      displayMath(
        String.raw`T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(a\check{Z}_\mu + b\check{Y}_\mu\right)
= a\,T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu) + b\,T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)`,
      ),
    ],
    proof: [
      paragraph([
        ref("V1_plus_half_invertible"),
        " より ",
        math(String.raw`\left(V_1^{(+)}\right)^{1/2}\in R^\times`),
        " である。したがって ",
        ref("linearity_of_T"),
        " で ",
        math(String.raw`g=\left(V_1^{(+)}\right)^{1/2}`),
        "、",
        math(String.raw`X=\check Z_\mu`),
        "、",
        math(String.raw`W=\check Y_\mu`),
        " と置けば、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(a\check Z_\mu+b\check Y_\mu\right)
&=a\,T_{\left(V_1^{(+)}\right)^{1/2}}(\check Z_\mu)
 +b\,T_{\left(V_1^{(+)}\right)^{1/2}}(\check Y_\mu)
&&\left(\because\ \blkref{linearity_of_T}\right).
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-02 の論文構成再編で、一般の共役写像の線型性と二つのイジング固有特殊化を束ねた旧ブロックから、半指数行列による特殊化だけを独立させた。V_2 による特殊化は直後の残余ブロックに保留した。",
      ],
    },
  },
  {
    id: "evensectorT_006a_claim_linearity_of_T_V2",
    kind: "claim",
    origin: { path: "structured-latex/content/014_even_sector_T_action.ts", ordinal: 9 },
    title: { tex: String.raw`V_2 \text{ による共役写像の } \mathbb{C} \text{ 線型性}` },
    labels: ["linearity_of_T_V2"],
    statement: [
      paragraph([
        ref("def_half_integer_checkZ"),
        " と ",
        ref("def_half_integer_checkY"),
        " と ",
        ref("def_check_index_set"),
        " の記号を用いる。",
        math(String.raw`\mu\in\check{\mathcal M}`),
        " と ",
        math(String.raw`a,b\in\mathbb C`),
        " について、",
      ]),
      displayMath(String.raw`T_{V_2}\!\left(a\check Z_\mu+b\check Y_\mu\right)
=a\,T_{V_2}(\check Z_\mu)+b\,T_{V_2}(\check Y_\mu)`),
    ],
    proof: [
      paragraph([
        ref("V2_invertible"),
        " より ",
        math(String.raw`V_2\in R^\times`),
        " である。したがって ",
        ref("linearity_of_T"),
        " で ",
        math(String.raw`g=V_2`),
        "、",
        math(String.raw`X=\check Z_\mu`),
        "、",
        math(String.raw`W=\check Y_\mu`),
        " と置く。一続きである。",
      ]),
      displayMath(String.raw`\begin{aligned}
T_{V_2}\!\left(a\check Z_\mu+b\check Y_\mu\right)
&=a\,T_{V_2}(\check Z_\mu)+b\,T_{V_2}(\check Y_\mu)
&&\left(\because\ \blkref{linearity_of_T}\right).
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧ブロックに含まれていた V_2 による特殊化を、既存の証明内容を失わず独立ブロックへ移した。一般の T_g の複素線型性、V_2 の可逆性、半整数運動量とその添字集合だけを直接入力とし、Lean の linearity_of_T_V2 と SageMath の同名検査がこの主張へ対応する。",
      ],
    },
  },
  {
    id: "evensectorT_007_definition_B1_B2",
    kind: "definition",
    origin: { path: "structured-latex/content/014_even_sector_T_action.ts", ordinal: 9 },
    title: { tex: String.raw`B_1(\theta), B_2 \text{ の定義}` },
    labels: ["def_B1_theta_B2"],
    statement: [
      paragraph([math(String.raw`\theta \in \mathbb{R}`), " について、"]),
      displayMath(
        String.raw`B_1(\theta) := \begin{pmatrix}
\cosh K_1 & -i \exp(i\theta)\sinh K_1 \\
i \exp(-i\theta)\sinh K_1 & \cosh K_1
\end{pmatrix},
\qquad
B_2 := \begin{pmatrix}
\cosh(2K_2^*) & i\sinh(2K_2^*) \\
-i\sinh(2K_2^*) & \cosh(2K_2^*)
\end{pmatrix}`,
      ),
      paragraph([
        "と定める（いずれも ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の元。",
        math(String.raw`K_1, K_2^*`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " の記号）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章では B_1, B_2 は factorization_of_A_theta の statement と T_V_hatZ_hatY の proof の中で θ_μ（μ ∈ calM）に限って導入されている。半整数運動量 θ~_μ で使うために、θ ∈ R 一般の定義として立て直した（008 章側は変更していない）。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "evensectorT_008_claim_product_action",
    kind: "claim",
    origin: { path: "structured-latex/content/014_even_sector_T_action.ts", ordinal: 10 },
    title: { tex: String.raw`T_{\left(V_1^{(+)}\right)^{1/2}}, T_{V_2} \text{ の } (\check{Z}, \check{Y}) \text{ への直積作用}` },
    labels: ["calc_of_TxT_check_Z_Y"],
    statement: [
      paragraph([math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）", " について、"]),
      displayMath(
        String.raw`\left(T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu),\
T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)\right)
= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix} B_1\!\left(\tilde\theta_\mu\right)`,
      ),
      displayMath(
        String.raw`\left(T_{V_2}(\check{Z}_\mu),\ T_{V_2}(\check{Y}_\mu)\right)
= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix} B_2`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`B_1, B_2`),
        " は ",
        ref("def_B1_theta_B2"),
        " のものであり、行ベクトルと ",
        math(String.raw`2\times 2`),
        " 行列の積は列ごとの ",
        math(String.raw`\begin{pmatrix}A, & B\end{pmatrix}\begin{pmatrix}a \\ b\end{pmatrix} = aA + bB`),
        " を 2 列並べたもの、すなわち",
      ]),
      displayMath(
        String.raw`\begin{pmatrix}A, & B\end{pmatrix}
\begin{pmatrix}p & q \\ r & s\end{pmatrix}
:= \left(pA + rB,\ qA + sB\right)`,
      ),
      paragraph(["とする。"]),
    ],
    proof: [
      paragraph([
        ref("T_actions_on_check_Z_Y"),
        " の 4 式の列ベクトル表示を、",
        math(String.raw`\check{Z}_\mu`),
        " 分・",
        math(String.raw`\check{Y}_\mu`),
        " 分の順に 2 列並べる。",
        math(String.raw`\tilde\theta := \tilde\theta_\mu`),
        " と書くと ",
        math(String.raw`V_1`),
        " 分は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\left(T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu),\
T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)\right) \\
&= \left(
   \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \begin{pmatrix}\cosh(K_1) \\ i \exp(-i\tilde\theta)\sinh(K_1)\end{pmatrix},\ \
   \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \begin{pmatrix}-i \exp(i\tilde\theta)\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}
   \right)
   \quad (\because \blkref{T_actions_on_check_Z_Y}\text{ を 2 列へ同時適用}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \begin{pmatrix}
   \cosh(K_1) & -i \exp(i\tilde\theta)\sinh(K_1) \\
   i \exp(-i\tilde\theta)\sinh(K_1) & \cosh(K_1)
   \end{pmatrix}
   \quad (\because \text{statement の行ベクトルと行列の積の定義}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix} B_1\!\left(\tilde\theta_\mu\right)
   \quad (\because \blkref{def_B1_theta_B2})
\end{aligned}`,
      ),
      paragraph([math(String.raw`V_2`), " 分も同様に、"]),
      displayMath(
        String.raw`\begin{aligned}
\left(T_{V_2}(\check{Z}_\mu),\ T_{V_2}(\check{Y}_\mu)\right)
&= \left(
   \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \begin{pmatrix}\cosh(2K_2^*) \\ -i\sinh(2K_2^*)\end{pmatrix},\ \
   \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \begin{pmatrix}i\sinh(2K_2^*) \\ \cosh(2K_2^*)\end{pmatrix}
   \right)
   \quad (\because \blkref{T_actions_on_check_Z_Y}\text{ を 2 列へ同時適用}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \begin{pmatrix}
   \cosh(2K_2^*) & i\sinh(2K_2^*) \\
   -i\sinh(2K_2^*) & \cosh(2K_2^*)
   \end{pmatrix}
   \quad (\because \text{statement の行ベクトルと行列の積の定義}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix} B_2
   \quad (\because \blkref{def_B1_theta_B2})
\end{aligned}`,
      ),
      paragraph([
        "並べた 2 列がそれぞれ ",
        ref("def_B1_theta_B2"),
        " の ",
        math(String.raw`B_1(\tilde\theta_\mu)`),
        "、",
        math(String.raw`B_2`),
        " の第 1 列・第 2 列に一致している。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の calc_of_TxT_hatZxhatY の半整数運動量版。008 章は直積写像 T×T を別ブロックで定義してから 2 列を並べていたが、直積写像の記号は以降で使われないので、ここでは 2 つの像の組をそのまま行ベクトル×行列の形に書いた。",
        "数値確認済み（sagemath/check/047_claim_even_sector_T_action/check_03_T_actions.sage の「B1 右乗」「B2 右乗」列）。",
      ],
    },
  },
  {
    id: "evensectorT_009_claim_factorization_A_theta",
    kind: "claim",
    origin: { path: "structured-latex/content/014_even_sector_T_action.ts", ordinal: 11 },
    title: { tex: String.raw`A(\theta) = B_1(\theta) B_2 B_1(\theta) \text{（}\theta \in \mathbb{R}\text{ 一般）}` },
    labels: ["factorization_of_A_theta_general"],
    statement: [
      paragraph([
        math(String.raw`\theta \in \mathbb{R}`),
        " について、",
        ref("def_B1_theta_B2"),
        " の ",
        math(String.raw`B_1(\theta), B_2`),
        " と ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\theta)`),
        " の間に",
      ]),
      displayMath(String.raw`B_1(\theta)\, B_2\, B_1(\theta) = A(\theta)`),
      paragraph([
        "が成り立つ。とくに ",
        math(String.raw`\theta = \tilde\theta_\mu`),
        "（",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        "）とすれば ",
        math(String.raw`B_1(\tilde\theta_\mu) B_2 B_1(\tilde\theta_\mu) = A(\tilde\theta_\mu)`),
        " である。",
      ]),
    ],
    proof: [
      paragraph(["以下、記号を"]),
      displayMath(
        String.raw`a := \cosh K_1 \in \mathbb{R},\quad b := \sinh K_1 \in \mathbb{R},\quad
C := \cosh 2K_2^* = c_2^* \in \mathbb{R},\quad S := \sinh 2K_2^* = s_2^* \in \mathbb{R}`,
      ),
      paragraph([
        "と略記する（",
        math(String.raw`c_1, s_1, c_2, c_2^*, s_2^*`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " の記号）。",
        ref("cosh_sinh_basic_properties"),
        " による倍角公式から従う次の三本の等式",
      ]),
      displayMath(String.raw`\begin{aligned}
a^2 + b^2
&= \cosh^2 K_1 + \sinh^2 K_1
&&\bigl(\because\ a, b\text{ の定義}\bigr)\\
&= \cosh 2K_1
&&\bigl(\because\ \blkref{cosh_sinh_basic_properties}\text{ の倍角公式}\bigr)\\
&= c_1
&&\bigl(\because\ \blkref{def_transfer_matrix_symbols}\text{ の記号の定義}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
2ab
&= 2\cosh K_1 \sinh K_1
&&\bigl(\because\ a, b\text{ の定義}\bigr)\\
&= \sinh 2K_1
&&\bigl(\because\ \blkref{cosh_sinh_basic_properties}\text{ の倍角公式}\bigr)\\
&= s_1
&&\bigl(\because\ \blkref{def_transfer_matrix_symbols}\text{ の記号の定義}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
a^2 - b^2
&= \cosh^2 K_1 - \sinh^2 K_1
&&\bigl(\because\ a, b\text{ の定義}\bigr)\\
&= 1
&&\bigl(\because\ \blkref{cosh_sinh_basic_properties}\bigr)
\end{aligned}`),
      paragraph([
        "を後で用いる。また複素指数の指数法則 ",
        math(String.raw`\exp(z)\exp(w) = \exp(z+w)`),
        " としては ",
        ref("theorem_exp_product"),
        " を ",
        math(String.raw`n=1`),
        " に適用したものを使う。この記号で ",
        math(String.raw`B_1(\theta) = \begin{pmatrix} a & -i \exp(i\theta) b \\ i \exp(-i\theta) b & a\end{pmatrix}`),
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
      displayMath(String.raw`\begin{aligned}
N_{11}
&= C\cdot a + (iS)\cdot\left(i \exp(-i\theta) b\right)
&&\bigl(\because\ \blkref{mat_mult}\bigr)\\
&= Ca - S b\, \exp(-i\theta)
&&\bigl(\because\ i\cdot i=-1\text{ と複素数の四則}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
N_{12}
&= C\cdot\left(-i \exp(i\theta) b\right) + (iS)\cdot a
&&\bigl(\because\ \blkref{mat_mult}\bigr)\\
&= i\left(Sa-Cb\,\exp(i\theta)\right)
&&\bigl(\because\ \mathbb C\text{ の分配則と四則}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
N_{21}
&=(-iS)\cdot a+C\cdot\left(i \exp(-i\theta)b\right)
&&\bigl(\because\ \blkref{mat_mult}\bigr)\\
&=i\left(Cb\,\exp(-i\theta)-Sa\right)
&&\bigl(\because\ \mathbb C\text{ の分配則と四則}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
N_{22}
&=(-iS)\cdot\left(-i \exp(i\theta)b\right)+C\cdot a
&&\bigl(\because\ \blkref{mat_mult}\bigr)\\
&=Ca-Sb\,\exp(i\theta)
&&\bigl(\because\ (-i)\cdot(-i)=-1\text{ と複素数の四則}\bigr)
\end{aligned}`),
      paragraph([
        "Step 2: ",
        math(String.raw`P := B_1(\theta)\, N = B_1(\theta)\, B_2\, B_1(\theta)`),
        " の (1,1) 成分。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{11}
&= a\, N_{11} + \left(-i \exp(i\theta) b\right) N_{21}
   &&(\because \blkref{mat_mult}) \\
&= a\left(Ca - S b\, \exp(-i\theta)\right)
   + \left(-i \exp(i\theta) b\right)\cdot i\left(C b\, \exp(-i\theta) - Sa\right)
   &&(\because \text{Step 1 の } N_{11}, N_{21}) \\
&= Ca^2 - S ab\, \exp(-i\theta)
   + \exp(i\theta) b\left(C b\, \exp(-i\theta) - Sa\right)
   &&(\because -i\cdot i = 1) \\
&= Ca^2 - S ab\, \exp(-i\theta) + C b^2 - S ab\, \exp(i\theta)
   &&(\because \exp(i\theta)\exp(-i\theta) = 1,\ \blkref{theorem_exp_product}\ (n=1)) \\
&= C\left(a^2 + b^2\right) - S ab\left(\exp(i\theta) + \exp(-i\theta)\right)
   &&(\because\ \mathbb C\text{ の分配則}) \\
&= C\, c_1 - S ab\left(\exp(i\theta) + \exp(-i\theta)\right)
   &&(\because \blkref{cosh_sinh_basic_properties}\text{ の倍角公式 } a^2+b^2 = c_1) \\
&= C\, c_1 - S\cdot\frac{s_1}{2}\left(\exp(i\theta) + \exp(-i\theta)\right)
   &&(\because \blkref{cosh_sinh_basic_properties}\text{ の倍角公式 } 2ab = s_1) \\
&= C\, c_1 - S\cdot\frac{s_1}{2}\cdot 2\cos\theta
   &&(\because \blkref{euler_formula_cos_sin}\text{ より } \exp(i\theta)+\exp(-i\theta) = 2\cos\theta) \\
&= c_1 c_2^* - s_1 s_2^*\cos\theta
   &&(\because C := c_2^*,\ S := s_2^*)
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\exp(i\theta) + \exp(-i\theta) = 2\cos\theta`),
        " は ",
        ref("euler_formula_cos_sin"),
        " による。）これは ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\theta)`),
        " の (1,1) 成分に一致する。",
      ]),
      paragraph(["Step 3: ", math(String.raw`P`), " の (2,2) 成分。"]),
      displayMath(
        String.raw`\begin{aligned}
P_{22}
&= \left(i \exp(-i\theta) b\right) N_{12} + a\, N_{22}
   &&(\because \blkref{mat_mult}) \\
&= \left(i \exp(-i\theta) b\right)\cdot i\left(Sa - C b\, \exp(i\theta)\right)
   + a\left(Ca - S b\, \exp(i\theta)\right)
   &&(\because \text{Step 1 の } N_{12}, N_{22}) \\
&= -\exp(-i\theta) b\left(Sa - C b\, \exp(i\theta)\right) + Ca^2 - S ab\, \exp(i\theta)
   &&(\because i\cdot i = -1) \\
&= -S ab\, \exp(-i\theta) + C b^2 + Ca^2 - S ab\, \exp(i\theta)
   &&(\because \exp(-i\theta)\exp(i\theta) = 1,\ \blkref{theorem_exp_product}\ (n=1)) \\
&= C\left(a^2 + b^2\right) - S ab\left(\exp(i\theta) + \exp(-i\theta)\right)
   &&(\because\ \mathbb C\text{ の分配則}) \\
&= Cc_1 - S ab\left(\exp(i\theta) + \exp(-i\theta)\right)
   &&(\because\ \blkref{cosh_sinh_basic_properties}\text{ の倍角公式}) \\
&= Cc_1 - S\frac{s_1}{2}\left(\exp(i\theta) + \exp(-i\theta)\right)
   &&(\because\ \blkref{cosh_sinh_basic_properties}\text{ の倍角公式}) \\
&= Cc_1 - Ss_1\cos\theta
   &&(\because\ \blkref{euler_formula_cos_sin}) \\
&= c_1 c_2^* - s_1 s_2^*\cos\theta
   &&(\because\ C=c_2^*,\ S=s_2^*)
\end{aligned}`,
      ),
      paragraph([
        "これは ",
        math(String.raw`A(\theta)`),
        " の (2,2) 成分に一致する（(1,1) 成分と同一の式）。",
      ]),
      paragraph([
        "Step 4: ",
        math(String.raw`P`),
        " の (1,2) 成分。準備として、補助的な等式",
      ]),
      displayMath(
        String.raw`\begin{aligned}
a^2 + b^2 \exp(2i\theta)
&= \exp(i\theta)\left(a^2 \exp(-i\theta) + b^2 \exp(i\theta)\right)
   &&(\because \blkref{theorem_exp_product}\ (n=1)) \\
&= \exp(i\theta)\left(a^2(\cos\theta - i\sin\theta) + b^2(\cos\theta + i\sin\theta)\right)
   &&(\because \blkref{euler_formula_cos_sin}\text{ を 2 箇所へ同時適用}) \\
&= \exp(i\theta)\left(\left(a^2 + b^2\right)\cos\theta - i\left(a^2 - b^2\right)\sin\theta\right)
   &&(\because\ \mathbb C\text{ の分配則}) \\
&= \exp(i\theta)\left(c_1\cos\theta - i\left(a^2-b^2\right)\sin\theta\right)
   &&(\because \blkref{cosh_sinh_basic_properties}\text{ の倍角公式 } a^2+b^2 = c_1) \\
&= \exp(i\theta)\left(c_1\cos\theta - i\sin\theta\right)
   &&(\because a^2-b^2 = 1)
\end{aligned}`,
      ),
      paragraph([
        "を置く（",
        ref("theorem_exp_product"),
        "、",
        ref("euler_formula_cos_sin"),
        "）。また ",
        math(String.raw`c_2^* = s_2^* c_2`),
        " は ",
        ref("duality_c2_star_eq_s2_star_c2"),
        " による。これらを用いて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{12}
&= a\, N_{12} + \left(-i \exp(i\theta) b\right) N_{22}
   &&(\because \blkref{mat_mult}) \\
&= a\cdot i\left(Sa - C b\, \exp(i\theta)\right)
   + \left(-i \exp(i\theta) b\right)\left(Ca - S b\, \exp(i\theta)\right)
   &&(\because \text{Step 1 の } N_{12}, N_{22}) \\
&= i\left[S a^2 - C ab\, \exp(i\theta)\right]
   + i\left[-C ab\, \exp(i\theta) + S b^2 \exp(2i\theta)\right]
   &&(\because \blkref{theorem_exp_product}\ (n=1)\ (\exp(i\theta)\exp(i\theta) = \exp(2i\theta))) \\
&= i\left[S\left(a^2 + b^2 \exp(2i\theta)\right) - 2C ab\, \exp(i\theta)\right]
   &&(\because\ \mathbb C\text{ の分配則}) \\
&= i\left[S\, \exp(i\theta)\left(c_1\cos\theta - i\sin\theta\right) - 2C ab\, \exp(i\theta)\right]
   &&(\because \text{準備の補助的な等式}) \\
&= i\left[S\, \exp(i\theta)\left(c_1\cos\theta - i\sin\theta\right) - C s_1 \exp(i\theta)\right]
   &&(\because \blkref{cosh_sinh_basic_properties}\text{ の倍角公式 } 2ab = s_1) \\
&= i \exp(i\theta)\left[s_2^*\left(c_1\cos\theta - i\sin\theta\right) - c_2^*\, s_1\right]
   &&(\because C := c_2^*,\ S := s_2^*) \\
&= i \exp(i\theta)\left[s_2^*\left(c_1\cos\theta - i\sin\theta\right) - s_2^* c_2\, s_1\right]
   &&(\because \blkref{duality_c2_star_eq_s2_star_c2}:\ c_2^* = s_2^* c_2) \\
&= i \exp(i\theta) s_2^*\left(c_1\cos\theta - i\sin\theta - s_1 c_2\right)
   &&(\because\ \mathbb C\text{ の分配則})
\end{aligned}`,
      ),
      paragraph([
        "得られた ",
        math(String.raw`P_{12}`),
        " は ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\theta)`),
        " の (1,2) 成分に一致する。",
      ]),
      paragraph(["Step 5: ", math(String.raw`P`), " の (2,1) 成分。"]),
      displayMath(
        String.raw`\begin{aligned}
P_{21}
&= \left(i \exp(-i\theta) b\right) N_{11} + a\, N_{21}
   &&(\because \blkref{mat_mult}) \\
&= \left(i \exp(-i\theta) b\right)\left(Ca - S b\, \exp(-i\theta)\right)
   + a\cdot i\left(C b\, \exp(-i\theta) - Sa\right)
   &&(\because \text{Step 1 の } N_{11}, N_{21}) \\
&= i\left[C ab\, \exp(-i\theta) - S b^2 \exp(-2i\theta)\right]
   + i\left[C ab\, \exp(-i\theta) - S a^2\right]
   &&(\because \blkref{theorem_exp_product}\ (n=1)\ (\exp(-i\theta)\exp(-i\theta) = \exp(-2i\theta))) \\
&= -i\left[S\left(a^2 + b^2 \exp(-2i\theta)\right) - 2C ab\, \exp(-i\theta)\right]
   &&(\because\ \mathbb C\text{ の分配則})
\end{aligned}`,
      ),
      paragraph([
        "準備として、Step 4 の補助的な等式と同形の等式",
      ]),
      displayMath(
        String.raw`\begin{aligned}
a^2 + b^2 \exp(-2i\theta)
&= \exp(-i\theta)\left(a^2 \exp(i\theta) + b^2 \exp(-i\theta)\right)
   &&(\because \blkref{theorem_exp_product}\ (n=1)) \\
&= \exp(-i\theta)\left(a^2(\cos\theta + i\sin\theta) + b^2(\cos\theta - i\sin\theta)\right)
   &&(\because \blkref{euler_formula_cos_sin}\text{ を 2 箇所へ同時適用}) \\
&= \exp(-i\theta)\left(\left(a^2 + b^2\right)\cos\theta + i\left(a^2 - b^2\right)\sin\theta\right)
   &&(\because\ \mathbb C\text{ の分配則}) \\
&= \exp(-i\theta)\left(c_1\cos\theta + i\left(a^2-b^2\right)\sin\theta\right)
   &&(\because \blkref{cosh_sinh_basic_properties}\text{ の倍角公式 } a^2+b^2 = c_1) \\
&= \exp(-i\theta)\left(c_1\cos\theta + i\sin\theta\right)
   &&(\because a^2-b^2 = 1)
\end{aligned}`,
      ),
      paragraph([
        "を置く（",
        ref("theorem_exp_product"),
        "、",
        ref("euler_formula_cos_sin"),
        "）。また ",
        math(String.raw`c_2^* = s_2^* c_2`),
        " は ",
        ref("duality_c2_star_eq_s2_star_c2"),
        " による。これらを用いて、直前の ",
        math(String.raw`P_{21}`),
        " の表示から一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{21}
&= -i\left[S\left(a^2 + b^2 \exp(-2i\theta)\right) - 2C ab\, \exp(-i\theta)\right]
   &&(\because \text{直前の } P_{21} \text{ の表示}) \\
&= -i\left[S\, \exp(-i\theta)\left(c_1\cos\theta + i\sin\theta\right) - 2C ab\, \exp(-i\theta)\right]
   &&(\because \text{準備の補助的な等式}) \\
&= -i\left[S\, \exp(-i\theta)\left(c_1\cos\theta + i\sin\theta\right) - C s_1 \exp(-i\theta)\right]
   &&(\because \blkref{cosh_sinh_basic_properties}\text{ の倍角公式 } 2ab = s_1) \\
&= -i \exp(-i\theta)\left[s_2^*\left(c_1\cos\theta + i\sin\theta\right) - c_2^*\, s_1\right]
   &&(\because C := c_2^*,\ S := s_2^*) \\
&= -i \exp(-i\theta)\left[s_2^*\left(c_1\cos\theta + i\sin\theta\right) - s_2^* c_2\, s_1\right]
   &&(\because \blkref{duality_c2_star_eq_s2_star_c2}:\ c_2^* = s_2^* c_2) \\
&= -i \exp(-i\theta) s_2^*\left(c_1\cos\theta + i\sin\theta - s_1 c_2\right)
   &&(\because\ \mathbb C\text{ の分配則})
\end{aligned}`,
      ),
      paragraph([
        "これは ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\theta)`),
        " の (2,1) 成分に一致する。",
      ]),
      paragraph([
        "Step 6: Step 2〜5 により ",
        math(String.raw`P = B_1(\theta) B_2 B_1(\theta)`),
        " の 4 成分すべてが ",
        math(String.raw`A(\theta)`),
        " の対応成分に一致するので ",
        math(String.raw`B_1(\theta) B_2 B_1(\theta) = A(\theta)`),
        "。",
        math(String.raw`\theta \in \mathbb{R}`),
        " は任意だったから、",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu \in \mathbb{R}`),
        " を代入して後半を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の factorization_of_A_theta は μ ∈ calM で量化された主張であり、そのままでは θ~_μ に適用できない。証明の実体（T_V_hatZ_hatY の proof の Step 1〜6）は θ ∈ R について何も μ に固有のことを使っていないので、ここでは θ ∈ R 一般の主張として立て直し、同じ行列計算を書き下した。",
        "θ を [0, 2π) 上で 60 点走査し、5 組の (K1,K2) について残差 1e-14 以下であることを数値確認済み（sagemath/check/047_claim_even_sector_T_action/check_04_T_V_plus_and_factorization.sage の (1)）。",
        "2026-08-19 の式変形統一で、Step 5 の「Step 4 とまったく同じ計算（θ → -θ）」に畳まれていた補助的な等式の導出と P_21 の整理を、Step 4 と同形の一続きの鎖（補助等式 5 段と P_21 の 6 段）へ開いた。内容・参照は変えていない。",
      ],
    },
  },
  {
    id: "evensectorT_010_claim_T_V_plus_action",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/014_even_sector_T_action.ts", ordinal: 12 },
    title: { tex: String.raw`T_{(V^{(+)})} \text{ の } \check{Z}, \check{Y} \text{ への作用}` },
    labels: ["T_V_plus_check_Z_Y"],
    statement: [
      paragraph([math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）", " について、"]),
      displayMath(
        String.raw`\left(T_{(V^{(+)})}(\check{Z}_\mu),\; T_{(V^{(+)})}(\check{Y}_\mu)\right)
= \left(\check{Z}_\mu,\; \check{Y}_\mu\right) A\!\left(\tilde\theta_\mu\right),
\qquad \tilde\theta_\mu = \frac{2\pi\left(\mu - \tfrac12\right)}{M_{\mathrm{col}}}`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`T_{(V^{(+)})}`),
        " は ",
        ref("def_T_V_plus"),
        "、",
        math(String.raw`A(\theta)`),
        " は ",
        ref("def_A_theta"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`\tilde\theta := \tilde\theta_\mu`),
        " と略記し、",
        ref("def_B1_theta_B2"),
        " の ",
        math(String.raw`B_1(\tilde\theta), B_2`),
        " を用いる。",
      ]),
      paragraph([
        "(z) ",
        math(String.raw`T_{(V^{(+)})}(\check{Z}_\mu)`),
        " について、",
        ref("def_T_V_plus"),
        " の定義、",
        ref("T_actions_on_check_Z_Y"),
        "、",
        ref("linearity_of_T_V2"),
        "、",
        ref("linearity_of_T_on_check_Z_Y"),
        "、",
        ref("calc_of_TxT_check_Z_Y"),
        " を順に用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}(\check{Z}_\mu)
&= T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(T_{V_2}\!\left(
   T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu)\right)\right)
   \quad (\because \blkref{def_T_V_plus}) \\
&= T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(T_{V_2}\!\left(
   \cosh(K_1)\check{Z}_\mu + i \exp(-i\tilde\theta)\sinh(K_1)\check{Y}_\mu\right)\right)
   \quad (\because \blkref{T_actions_on_check_Z_Y}) \\
&= T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(
   \left(T_{V_2}(\check{Z}_\mu),\ T_{V_2}(\check{Y}_\mu)\right)
   \begin{pmatrix}\cosh(K_1) \\ i \exp(-i\tilde\theta)\sinh(K_1)\end{pmatrix}\right)
   \quad (\because \blkref{linearity_of_T_V2}) \\
&= T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(
   \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix} B_2
   \begin{pmatrix}\cosh(K_1) \\ i \exp(-i\tilde\theta)\sinh(K_1)\end{pmatrix}\right)
   \quad (\because \blkref{calc_of_TxT_check_Z_Y}) \\
&= \left(T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu),\
   T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)\right) B_2
   \begin{pmatrix}\cosh(K_1) \\ i \exp(-i\tilde\theta)\sinh(K_1)\end{pmatrix}
   \quad (\because \blkref{linearity_of_T_on_check_Z_Y}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   B_1(\tilde\theta)\, B_2
   \begin{pmatrix}\cosh(K_1) \\ i \exp(-i\tilde\theta)\sinh(K_1)\end{pmatrix}
   \quad (\because \blkref{calc_of_TxT_check_Z_Y})
\end{aligned}`,
      ),
      paragraph([
        "（3 行目・5 行目の線型性は、",
        math(String.raw`B_2`),
        " や列ベクトルの成分がスカラーであり、",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " の ",
        math(String.raw`\mathbb{C}`),
        " 線型結合に ",
        math(String.raw`T`),
        " を掛ける形になっていることによる。）",
      ]),
      paragraph([
        "(y) ",
        math(String.raw`T_{(V^{(+)})}(\check{Y}_\mu)`),
        " についても同様に、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}(\check{Y}_\mu)
&= T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(T_{V_2}\!\left(
   T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)\right)\right)
   \quad (\because \blkref{def_T_V_plus}) \\
&= T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(T_{V_2}\!\left(
   -i \exp(i\tilde\theta)\sinh(K_1)\check{Z}_\mu + \cosh(K_1)\check{Y}_\mu\right)\right)
   \quad (\because \blkref{T_actions_on_check_Z_Y}) \\
&= T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(
   \left(T_{V_2}(\check{Z}_\mu),\ T_{V_2}(\check{Y}_\mu)\right)
   \begin{pmatrix}-i \exp(i\tilde\theta)\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}\right)
   \quad (\because \blkref{linearity_of_T_V2}) \\
&= T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(
   \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix} B_2
   \begin{pmatrix}-i \exp(i\tilde\theta)\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}\right)
   \quad (\because \blkref{calc_of_TxT_check_Z_Y}) \\
&= \left(T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu),\
   T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)\right) B_2
   \begin{pmatrix}-i \exp(i\tilde\theta)\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}
   \quad (\because \blkref{linearity_of_T_on_check_Z_Y}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   B_1(\tilde\theta)\, B_2
   \begin{pmatrix}-i \exp(i\tilde\theta)\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}
   \quad (\because \blkref{calc_of_TxT_check_Z_Y})
\end{aligned}`,
      ),
      paragraph([
        "(z) と (y) で得た 2 つの列ベクトルは、",
        ref("def_B1_theta_B2"),
        " より ",
        math(String.raw`B_1(\tilde\theta)`),
        " の第 1 列・第 2 列そのものである。2 列を並べ、",
        ref("factorization_of_A_theta_general"),
        " を ",
        math(String.raw`\theta = \tilde\theta_\mu \in \mathbb{R}`),
        " として適用すると、主張の左辺から一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(T_{(V^{(+)})}(\check{Z}_\mu),\ T_{(V^{(+)})}(\check{Y}_\mu)\right)
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   B_1(\tilde\theta)\, B_2\, B_1(\tilde\theta)
   \quad (\because \text{(z), (y) の鎖と }\blkref{def_B1_theta_B2}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix} A(\tilde\theta_\mu)
   \quad (\because \blkref{factorization_of_A_theta_general})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の T_V_hatZ_hatY の半整数運動量版。008 章はこのブロックの proof の中で B_1 B_2 B_1 = A(θ) の行列計算も行っていたが、ここではそれを factorization_of_A_theta_general として θ ∈ R 一般の独立した claim に分け、本ブロックは合成の計算だけを扱う形にした。",
        "M=2,3,4,5、μ=1..M、5 組の (K1,K2)（臨界点上・臨界点近傍を含む）について、V^{(+)} を行列指数関数から直接構成して (T(checkZ), T(checkY)) = (checkZ, checkY) A(θ~_μ) を数値確認済み（sagemath/check/047_claim_even_sector_T_action/check_04_T_V_plus_and_factorization.sage の (3)）。",
        "同じ検証で γ_2(θ~_μ) ≠ 0 が全 μ で成り立つことも数値で確認した（最小 |γ_2| は 0.56 以上）。これは章 C′ の残りの段（A(θ~) の対角化）で臨界点の例外処理が不要になることを示唆する事実であり、本章では使っていない。",
        "2026-08-19 の式変形統一で、(z), (y) の二本の鎖から得た二列を並べる等式と、B_1(θ~_μ) B_2 B_1(θ~_μ) = A(θ~_μ) の適用を、主張の左辺から始まる一続き二段の鎖と行末根拠へまとめた。内容・参照は変えていない。",
      ],
    },
  },
  {
    id: "reduction_to_A_theta_claim_T_V_plus_check_Z_Y_via_B1_B2_B1",
    kind: "claim",
    standing: "mainTheorem",
    title: { tex: String.raw`T_{(V^{(+)})} \text{ の } \check{Z}_\mu, \check{Y}_\mu \text{ への作用の } 2\times2 \text{ 行列 } A(\tilde\theta_\mu) = B_1(\tilde\theta_\mu) B_2 B_1(\tilde\theta_\mu) \text{ による表示}` },
    labels: ["T_V_plus_check_Z_Y_via_B1_B2_B1"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）とする。",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu = \frac{2\pi\left(\mu - \tfrac12\right)}{M_{\mathrm{col}}} \in \mathbb{R}`),
        "、",
        ref("def_half_integer_checkZ"),
        " の ",
        math(String.raw`\check{Z}_\mu`),
        "、",
        ref("def_half_integer_checkY"),
        " の ",
        math(String.raw`\check{Y}_\mu`),
        "（いずれも ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の元）、",
        ref("def_T_V_plus"),
        " の ",
        math(String.raw`T_{(V^{(+)})}`),
        "、",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\theta)`),
        "、",
        ref("def_B1_theta_B2"),
        " の ",
        math(String.raw`B_1(\theta), B_2`),
        "（いずれも ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の元）について、",
      ]),
      displayMath(
        String.raw`\left(T_{(V^{(+)})}(\check{Z}_\mu),\; T_{(V^{(+)})}(\check{Y}_\mu)\right)
= \left(\check{Z}_\mu,\; \check{Y}_\mu\right) A\!\left(\tilde\theta_\mu\right)
= \left(\check{Z}_\mu,\; \check{Y}_\mu\right) B_1\!\left(\tilde\theta_\mu\right) B_2\, B_1\!\left(\tilde\theta_\mu\right)`,
      ),
      paragraph([
        "が成り立つ。行ベクトルと ",
        math(String.raw`2\times 2`),
        " 行列の積は ",
        ref("calc_of_TxT_check_Z_Y"),
        " の ",
        math(String.raw`\begin{pmatrix}A, & B\end{pmatrix}\begin{pmatrix}p & q \\ r & s\end{pmatrix} = (pA + rB,\ qA + sB)`),
        " である。",
      ]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
\left(T_{(V^{(+)})}(\check{Z}_\mu),\; T_{(V^{(+)})}(\check{Y}_\mu)\right)
&= \left(\check{Z}_\mu,\; \check{Y}_\mu\right) A\!\left(\tilde\theta_\mu\right)
&&(\because\ \blkref{T_V_plus_check_Z_Y}) \\
&= \left(\check{Z}_\mu,\; \check{Y}_\mu\right) B_1\!\left(\tilde\theta_\mu\right) B_2\, B_1\!\left(\tilde\theta_\mu\right)
&&(\because\ \blkref{factorization_of_A_theta_general}\ \text{を}\ \theta = \tilde\theta_\mu \in \mathbb{R}\ \text{として})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、離散 Fourier 変換による 2×2 行列 A(θ̃_μ) への帰着の章のゴールの式を一つの主張として立てた。既存の二つの主張を順に当てるだけで、新しい証明は無い。",
      ],
    },
  },
]);
