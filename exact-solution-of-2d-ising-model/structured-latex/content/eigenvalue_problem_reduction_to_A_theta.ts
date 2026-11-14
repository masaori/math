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
&&(\because\ \text{オイラーの公式、}\blkref{euler_formula_cos_sin}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}} \left(1 + i \cdot 0\right)
&&(\because\ lj \in \mathbb{Z}\ \text{なので}\ \cos 2\pi lj = 1,\ \sin 2\pi lj = 0) \\
&= \sum_{j=1}^{M_{\mathrm{col}}} 1
&&(\because\ 1 + i \cdot 0 = 1) \\
&= M_{\mathrm{col}}
&&(\because\ \text{項数が}\ M_{\mathrm{col}}\ \text{である}) \\
&= M_{\mathrm{col}}\,\delta^{(M_{\mathrm{col}})}_{(k,0)}
&&(\because\ k \equiv 0 \pmod{M_{\mathrm{col}}}\ \text{なので}\ \delta^{(M_{\mathrm{col}})}_{(k,0)} = 1\ \text{である、}\blkref{def_delta_M})
\end{aligned}`,
      ),
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
&&(\because\ k \not\equiv 0 \pmod{M_{\mathrm{col}}}\ \text{なので}\ \delta^{(M_{\mathrm{col}})}_{(k,0)} = 0\ \text{である、}\blkref{def_delta_M})
\end{aligned}`,
      ),
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
        ref("def_identity_matrix"),
        " で ",
        math(String.raw`n = 2`),
        "）とし、",
        math(String.raw`I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        " を ",
        ref("def_identity_matrix"),
        " で ",
        math(String.raw`n = 2^{M_{\mathrm{col}}}`),
        " とした単位行列とする。",
        ref("kronecker_product_rule"),
        " (2) より",
        math(String.raw`\ I\boxtimes\cdots\boxtimes I = I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        "（左辺は ",
        math(String.raw`M_{\mathrm{col}}`),
        " 個のクロネッカー積）である。",
        math(String.raw`\sigma^x,\sigma^y,\sigma^z \in \mathrm{Mat}(2,\mathbb{C})`),
        " は ",
        ref("def_pauli_matrices"),
        " で定めた Pauli 行列である。",
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
&&(\because\ II = I.\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\ \text{を}\ A = I\ \text{として各因子へ同時適用})
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
&&(\because\ II = I.\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\ \text{を}\ A = I\ \text{として各因子へ同時適用})
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
&&(\because\ I\sigma^x = \sigma^x,\ I\sigma^y = \sigma^y.\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\ \text{を各因子へ同時適用}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ II = I.\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\ \text{を}\ A = I\ \text{として各因子へ同時適用})
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
&&(\because\ \sigma^x I = \sigma^x,\ \sigma^y I = \sigma^y.\ \blkref{identity_matrix_is_right_unit_of_mat_mult}\ \text{を各因子へ同時適用}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ II = I.\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\ \text{を}\ A = I\ \text{として各因子へ同時適用})
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
&&(\because\ \sigma^x I = \sigma^x,\ \sigma^z I = \sigma^z.\ \blkref{identity_matrix_is_right_unit_of_mat_mult}\ \text{を各因子へ同時適用}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ II = I.\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\ \text{を}\ A = I\ \text{として各因子へ同時適用})
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
&&(\because\ I\sigma^x = \sigma^x,\ I\sigma^z = \sigma^z.\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\ \text{を各因子へ同時適用}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ II = I.\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\ \text{を}\ A = I\ \text{として各因子へ同時適用})
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
          "設計は lean/Ising2D/EigenvalueProblem/ReductionToATheta/ClaimAnticommutatorZY.lean（anticomm_Z_Z, anticomm_Z_Y, " +
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
        "2026-11-01: 名前だけの根拠「II = I. 単位行列どうしの積」（6 か所）と「I は積の単位元」（4 か所）を、" +
          "identity_matrix_is_left_unit_of_mat_mult・identity_matrix_is_right_unit_of_mat_mult を各因子へ同時適用する参照に替えた。式は変えていない。",
        "2026-11-13（Lean の通しの証明のゴールラインの確認）: 証明の冒頭で σ^x, σ^y, σ^z を引く出典を、pauli_matrix_products（Pauli 行列の積の主張）から Pauli 行列の定義 def_pauli_matrices に替えた（Pauli 行列の定義を主張から分けたため）。" +
          "同じ段落で出典の無かった I := I_{Mat(2,C)} と I_{Mat(2^M_col,C)} を def_identity_matrix（n = 2、n = 2^M_col）から引く形にした。積の公式（σ^aσ^a = I・反可換）を引く行は替えていない。式は不変。",
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
      paragraph([math(String.raw`\theta \in \mathbb{R}`), " について、"]),
      displayMath(
        String.raw`A(\theta) :=
\begin{pmatrix}
c_1 c_2^* - s_1 s_2^*\cos\theta &
i \exp(i\theta) s_2^*(c_1\cos\theta - i\sin\theta - s_1 c_2) \\
-i \exp(-i\theta) s_2^*(c_1\cos\theta + i\sin\theta - s_1 c_2) &
c_1 c_2^* - s_1 s_2^*\cos\theta
\end{pmatrix}`,
      ),
      paragraph([
        "と定める。",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " とし、",
        math(String.raw`c_1, s_1, c_2, c_2^*, s_2^*`),
        " は ",
        ref("def_indexed_hyperbolic_abbreviations"),
        " の実数である。",
        math(String.raw`A(\theta)`),
        " は ",
        math(String.raw`2`),
        " 行 ",
        math(String.raw`2`),
        " 列の複素行列で、成分を次のように読む。",
        math(String.raw`(1,1)`),
        " 成分と ",
        math(String.raw`(2,2)`),
        " 成分は、実数 ",
        math(String.raw`c_1 c_2^* - s_1 s_2^*\cos\theta \in \mathbb{R}`),
        " の ",
        ref("inclusion_rr_to_cc"),
        " による像である。",
        math(String.raw`(1,2)`),
        " 成分と ",
        math(String.raw`(2,1)`),
        " 成分は ",
        math(String.raw`\mathbb{C}`),
        " の式で、そこに現れる実数 ",
        math(String.raw`\theta, c_1, s_1, c_2, s_2^*, \cos\theta, \sin\theta`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の像として読み、像の記号を省く。",
        math(String.raw`i\theta`),
        " は ",
        math(String.raw`i`),
        " と ",
        math(String.raw`\theta_{\mathbb{C}}`),
        " の積、",
        math(String.raw`-i\theta`),
        " は ",
        ref("euler_formula_cos_sin"),
        " の読みのとおり ",
        ref("multiply_by_minus_one"),
        " の ",
        math(String.raw`-(i\theta)`),
        " である。",
        math(String.raw`(2,1)`),
        " 成分の先頭の ",
        math(String.raw`-i`),
        " は ",
        ref("multiply_by_minus_one"),
        " の ",
        math(String.raw`-i = (-1_{\mathbb{C}})\,i`),
        " である。",
        math(String.raw`(1,2)`),
        " 成分と ",
        math(String.raw`(2,1)`),
        " 成分の四つの因子の積は左から順に括る（",
        math(String.raw`abcd = ((ab)c)d`),
        "）。",
        math(String.raw`(1,1)`),
        " 成分と ",
        math(String.raw`(2,2)`),
        " 成分の実数は、",
        math(String.raw`\mathbb{R}`),
        " の積を左から括った ",
        math(String.raw`(c_1 c_2^*) - \bigl((s_1 s_2^*)\cos\theta\bigr)`),
        " であり、差は ",
        ref("def_real_difference"),
        " の差である。",
        math(String.raw`(1,2)`),
        " 成分と ",
        math(String.raw`(2,1)`),
        " 成分の第四の因子は、",
        math(String.raw`\bigl((c_1\cos\theta) - (i\sin\theta)\bigr) - (s_1 c_2)`),
        " と ",
        math(String.raw`\bigl((c_1\cos\theta) + (i\sin\theta)\bigr) - (s_1 c_2)`),
        " のように左から括る。そこの差は ",
        ref("def_complex_difference"),
        " の差、和と積は ",
        ref("definition_of_cc"),
        " の和と積である。",
        math(String.raw`\exp(i\theta)`),
        " と ",
        math(String.raw`\exp(-i\theta)`),
        " は ",
        ref("def_scalar_exp"),
        " の係数の集合を ",
        math(String.raw`\mathbb{C}`),
        " とした ",
        math(String.raw`\exp`),
        " である。",
        math(String.raw`\theta`),
        " を ",
        math(String.raw`\mathbb{R}`),
        " に取るのは、成分の ",
        math(String.raw`\cos\theta, \sin\theta`),
        " が実数の引数を取る ",
        ref("def_cos"),
        "・",
        ref("def_sin"),
        " の値だからである（",
        ref("def_cos"),
        "・",
        ref("def_sin"),
        " はいま ",
        math(String.raw`[-\pi/2, \pi/2]`),
        " の上だけで定めてあり、全実数の引数への拡張が未整備であることは ",
        ref("euler_formula_cos_sin"),
        " の冒頭のとおりである）。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-11-09（Lean の通しの証明）: θ ∈ ℂ と書きながら成分に実数の cos θ・sin θ を使い、実数の成分を包含の像と書いていなかった。θ ∈ ℝ に直し、" +
          "(1,1)・(2,2) 成分を実数 c_1c_2^* - s_1s_2^* cos θ の像と読むこと、(1,2)・(2,1) 成分の実数を inclusion_rr_to_cc の像として読むこと、iθ・-iθ の読み、" +
          "(2,1) 成分の先頭の -i が multiply_by_minus_one の -i であること、四つの因子の積を左から括ることを定義に書いた。" +
          "def_gamma1_gamma2_of_theta と det_A_theta_tilde の証明がそれぞれ書いていた (2,1) 成分の読みは、この定義への参照にした。" +
          "factorization_of_A_theta_general の証明は (1,1)・(2,2) 成分を ℂ の式として読んでおり、この定義の読みに合わせる作業が残っている。行列の式は変えていない。",
        "2026-11-10（Lean の通しの証明）: (1,1)・(2,2) 成分の実数の積と差の括り方、(1,2)・(2,1) 成分の第四の因子の括り方と、その差・和・積・exp の出典（def_complex_difference・definition_of_cc・def_scalar_exp の係数を ℂ としたもの）を定義に書いた。行列の式は変えていない。",
        "2026-11-10（Lean の通しの証明のゴールラインの確認）: (1,1)・(2,2) 成分の実数の差の出典を、新しく足した def_real_difference にした。",
      ],
    },
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
        math(String.raw`2_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}\ne0_{\mathbb R}`),
        " である。以下の分数はこの二つの非零性により定まる。",
      ]),
      paragraph([
        "さらに、",
        math(String.raw`\pi\in\mathbb R`),
        " を円周率、",
        math(String.raw`i\in\mathbb C`),
        " を ",
        ref("def_imaginary_unit"),
        " の虚数単位とする。複素数の差、零元、単位元、逆元には ",
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
(2(M_{\mathrm{col}})_{\mathbb N})_{\mathbb Z}
&=2M_{\mathrm{col}}
&&\bigl(\because\ \iota_{\mathbb N\to\mathbb Z}\text{ は積を保つ},\ ((M_{\mathrm{col}})_{\mathbb N})_{\mathbb Z}=M_{\mathrm{col}}\bigr)\\
((M_{\mathrm{col}})_{\mathbb N})_{\mathbb R}
&=(M_{\mathrm{col}})_{\mathbb R}
&&\bigl(\because\ ((M_{\mathrm{col}})_{\mathbb N})_{\mathbb Z}=M_{\mathrm{col}}\bigr)\\
(2(M_{\mathrm{col}})_{\mathbb N})_{\mathbb R}
&=2_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}
&&\bigl(\because\ \iota_{\mathbb N\to\mathbb Z},\iota_{\mathbb Z\to\mathbb R}\text{ は積を保つ}\bigr)\\
(2M_{\mathrm{col}})_{\mathbb R}
&=2_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}
&&\bigl(\because\ \iota_{\mathbb Z\to\mathbb R}\text{ は積を保つ}\bigr)\\
((M_{\mathrm{col}})_{\mathbb N})_{\mathbb C}
&=(M_{\mathrm{col}})_{\mathbb C}
&&\bigl(\because\ ((M_{\mathrm{col}})_{\mathbb N})_{\mathbb R}=(M_{\mathrm{col}})_{\mathbb R}\bigr)\\
(2(M_{\mathrm{col}})_{\mathbb N})_{\mathbb C}
&=(2M_{\mathrm{col}})_{\mathbb C}
&&\bigl(\because\ (2(M_{\mathrm{col}})_{\mathbb N})_{\mathbb R}=2_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}=(2M_{\mathrm{col}})_{\mathbb R}\bigr).
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
        " である。まず、",
        math(String.raw`\mu\in\mathbb Z`),
        " について指数の中の実数を計算する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
k_{\mathbb R}\tilde\theta_\mu
&=k_{\mathbb R}\cdot\frac{2\pi\left(\mu_{\mathbb R}-\frac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \tilde\theta_\mu\text{ の定義}\bigr)\\
&=\frac{2\pi k_{\mathbb R}\left(\mu_{\mathbb R}-\frac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \mathbb R\text{ の積の交換律・結合律}\bigr)\\
&=\frac{2\pi k_{\mathbb R}\cdot2_{\mathbb R}\left(\mu_{\mathbb R}-\frac12\right)}{2_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ (M_{\mathrm{col}})_{\mathbb R}\ne0_{\mathbb R},\ 2_{\mathbb R}\ne0_{\mathbb R}\text{ なので分子と分母に }2_{\mathbb R}\text{ を掛ける}\bigr)\\
&=\frac{2\pi k_{\mathbb R}\left(2_{\mathbb R}\mu_{\mathbb R}-2_{\mathbb R}\cdot\frac12\right)}{2_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \mathbb R\text{ の分配法則}\bigr)\\
&=\frac{2\pi k_{\mathbb R}(2_{\mathbb R}\mu_{\mathbb R}-1_{\mathbb R})}{2_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ 2_{\mathbb R}\cdot\tfrac12=1_{\mathbb R}\bigr)\\
&=\frac{2\pi(2_{\mathbb R}\mu_{\mathbb R}-1_{\mathbb R})k_{\mathbb R}}{2_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \mathbb R\text{ の積の交換律}\bigr).
\end{aligned}`,
      ),
      paragraph([
        "主張の左辺を",
      ]),
      displayMath(
        String.raw`S_{M_{\mathrm{col}},k}:=\sum_{\mu=1}^{(M_{\mathrm{col}})_{\mathbb N}} \exp(i (k_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C})\in\mathbb C`,
      ),
      paragraph([
        "とおくと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
S_{M_{\mathrm{col}},k}
&=\sum_{\mu=1}^{(M_{\mathrm{col}})_{\mathbb N}}
\exp(i\left(\frac{2\pi(2_{\mathbb R}(\mu_{\mathbb Z})_{\mathbb R}-1_{\mathbb R})k_{\mathbb R}}{2_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}}\right)_{\mathbb C})
&&\bigl(\because\ \text{直前の鎖を各項の }\mu_{\mathbb Z}\in\mathbb Z\text{ へ適用}\bigr).
\end{aligned}`,
      ),
      paragraph([
        "また、正の自然数 ",
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
&=\sum_{r=1}^{2(M_{\mathrm{col}})_{\mathbb N}}\exp(i\left(\frac{2\pi(r_{\mathbb Z})_{\mathbb R}k_{\mathbb R}}{2_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}}\right)_{\mathbb C})
&&\bigl(\because\ (2(M_{\mathrm{col}})_{\mathbb N})_{\mathbb R}=2_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}\bigr)\\
&=\sum_{\mu=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(i\left(\frac{2\pi((2\mu-1)_{\mathbb Z})_{\mathbb R}k_{\mathbb R}}{2_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}}\right)_{\mathbb C})
+\sum_{\mu=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(i\left(\frac{2\pi((2\mu)_{\mathbb Z})_{\mathbb R}k_{\mathbb R}}{2_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}}\right)_{\mathbb C})
&&\bigl(\because\ r\text{ の奇偶による有限和の分割}\bigr)\\
&=\sum_{\mu=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(i\left(\frac{2\pi(2_{\mathbb R}(\mu_{\mathbb Z})_{\mathbb R}-1_{\mathbb R})k_{\mathbb R}}{2_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}}\right)_{\mathbb C})
+\sum_{\mu=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(i\left(\frac{2\pi(2_{\mathbb R}(\mu_{\mathbb Z})_{\mathbb R})k_{\mathbb R}}{2_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}}\right)_{\mathbb C})
&&\bigl(\because\ (2\mu-1)+1=2\mu\text{ と、}\iota_{\mathbb N\to\mathbb Z},\iota_{\mathbb Z\to\mathbb R}\text{ が単位元・和・積を保つことから }((2\mu-1)_{\mathbb Z})_{\mathbb R}+1_{\mathbb R}=2_{\mathbb R}(\mu_{\mathbb Z})_{\mathbb R}\bigr)\\
&=S_{M_{\mathrm{col}},k}+\sum_{\mu=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(i\left(\frac{2\pi(2_{\mathbb R}(\mu_{\mathbb Z})_{\mathbb R})k_{\mathbb R}}{2_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}}\right)_{\mathbb C})
&&\bigl(\because\ S_{M_{\mathrm{col}},k}\text{ の上の式}\bigr)\\
&=S_{M_{\mathrm{col}},k}+\sum_{\mu=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(i\left(\frac{2_{\mathbb R}\left(2\pi(\mu_{\mathbb Z})_{\mathbb R}k_{\mathbb R}\right)}{2_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}}\right)_{\mathbb C})
&&\bigl(\because\ \mathbb R\text{ の積の交換律・結合律}\bigr)\\
&=S_{M_{\mathrm{col}},k}+\sum_{\mu=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(i\left(\frac{2\pi(\mu_{\mathbb Z})_{\mathbb R}k_{\mathbb R}}{(M_{\mathrm{col}})_{\mathbb R}}\right)_{\mathbb C})
&&\bigl(\because\ 2_{\mathbb R}\ne0_{\mathbb R},\ (M_{\mathrm{col}})_{\mathbb R}\ne0_{\mathbb R}\text{ による約分}\bigr)\\
&=S_{M_{\mathrm{col}},k}+\sum_{\mu=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(i\left(\frac{2\pi(\mu_{\mathbb Z})_{\mathbb R}k_{\mathbb R}}{((M_{\mathrm{col}})_{\mathbb N})_{\mathbb R}}\right)_{\mathbb C})
&&\bigl(\because\ ((M_{\mathrm{col}})_{\mathbb N})_{\mathbb R}=(M_{\mathrm{col}})_{\mathbb R}\bigr)\\
&=S_{M_{\mathrm{col}},k}+T_{(M_{\mathrm{col}})_{\mathbb N},k}
&&\bigl(\because\ T_{(M_{\mathrm{col}})_{\mathbb N},k}\text{ の定義}\bigr).
\end{aligned}`,
      ),
      paragraph([
        ref("exp_sum"),
        " は像の記号を省いて書いており、左辺の項 ",
        math(String.raw`\exp(2\pi ijk/M_{\mathrm{col}})`),
        " は ",
        math(String.raw`\exp(i(2\pi(j_{\mathbb Z})_{\mathbb R}k_{\mathbb R}/(M_{\mathrm{col}})_{\mathbb R})_{\mathbb C})`),
        "、右辺の係数 ",
        math(String.raw`M_{\mathrm{col}}`),
        " は ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb C}`),
        " を表す。これを正の自然数 ",
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
&&\bigl(\because\ \blkref{exp_sum}\text{ を }2(M_{\mathrm{col}})_{\mathbb N}\text{ に適用}\bigr),\\
&=(2M_{\mathrm{col}})_{\mathbb C}\,\delta^{2(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}
&&\bigl(\because\ (2(M_{\mathrm{col}})_{\mathbb N})_{\mathbb C}=(2M_{\mathrm{col}})_{\mathbb C}\bigr),\\
T_{(M_{\mathrm{col}})_{\mathbb N},k}
&=((M_{\mathrm{col}})_{\mathbb N})_{\mathbb C}\,\delta^{(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}
&&\bigl(\because\ \blkref{exp_sum}\text{ を }(M_{\mathrm{col}})_{\mathbb N}\text{ に適用}\bigr),\\
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
        " でもある。",
        math(String.raw`((M_{\mathrm{col}})_{\mathbb N})_{\mathbb Z}=M_{\mathrm{col}}`),
        "、",
        math(String.raw`(2(M_{\mathrm{col}})_{\mathbb N})_{\mathbb Z}=2M_{\mathrm{col}}`),
        " と ",
        ref("def_delta_M"),
        " により ",
        math(String.raw`\delta^{2(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}=\delta^{(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}=0_{\mathbb C}`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
S_{M_{\mathrm{col}},k}
&=(2M_{\mathrm{col}})_{\mathbb C}\cdot0_{\mathbb C}-(M_{\mathrm{col}})_{\mathbb C}\cdot0_{\mathbb C}
&&\bigl(\because\ \delta^{2(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}=\delta^{(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}=0_{\mathbb C}\bigr)\\
&=0_{\mathbb C}-(M_{\mathrm{col}})_{\mathbb C}\cdot0_{\mathbb C}
&&\bigl(\because\ \blkref{complex_times_zero_is_zero}\ (z\to(2M_{\mathrm{col}})_{\mathbb C})\bigr)\\
&=0_{\mathbb C}-0_{\mathbb C}
&&\bigl(\because\ \blkref{complex_times_zero_is_zero}\ (z\to(M_{\mathrm{col}})_{\mathbb C})\bigr)\\
&=0_{\mathbb C}+(-0_{\mathbb C})
&&\bigl(\because\ \blkref{def_complex_difference}\bigr)\\
&=-0_{\mathbb C}
&&\bigl(\because\ \blkref{complex_zero_plus_is_original}\ (z\to-0_{\mathbb C})\bigr)\\
&=(-1_{\mathbb C})\cdot0_{\mathbb C}
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr)\\
&=0_{\mathbb C}
&&\bigl(\because\ \blkref{complex_times_zero_is_zero}\ (z\to-1_{\mathbb C})\bigr).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`k = lM_{\mathrm{col}}`),
        "（",
        math(String.raw`l \in \mathbb{Z}`),
        "）のときは、",
        math(String.raw`((M_{\mathrm{col}})_{\mathbb N})_{\mathbb Z}=M_{\mathrm{col}}`),
        " と ",
        ref("def_delta_M"),
        " により ",
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
        " が偶数なら、",
        math(String.raw`(2(M_{\mathrm{col}})_{\mathbb N})_{\mathbb Z}=2M_{\mathrm{col}}\mid k`),
        " と ",
        ref("def_delta_M"),
        " により ",
        math(String.raw`\delta^{2(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}=1_{\mathbb C}`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
S_{M_{\mathrm{col}},k}
&=(2M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}-(M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}
&&\bigl(\because\ \delta^{2(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}=\delta^{(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}=1_{\mathbb C}\bigr)\\
&=(2M_{\mathrm{col}})_{\mathbb C}-(M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}
&&\bigl(\because\ (2M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}=(2M_{\mathrm{col}})_{\mathbb C}\ (\blkref{complex_numbers_form_a_field})\bigr)\\
&=(2M_{\mathrm{col}})_{\mathbb C}-(M_{\mathrm{col}})_{\mathbb C}
&&\bigl(\because\ (M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}=(M_{\mathrm{col}})_{\mathbb C}\ (\blkref{complex_numbers_form_a_field})\bigr)\\
&=(2_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R})_{\mathbb C}-(M_{\mathrm{col}})_{\mathbb C}
&&\bigl(\because\ (2M_{\mathrm{col}})_{\mathbb R}=2_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}\bigr)\\
&=2_{\mathbb C}(M_{\mathrm{col}})_{\mathbb C}-(M_{\mathrm{col}})_{\mathbb C}
&&\bigl(\because\ \blkref{real_inclusion_preserves_product}\bigr)\\
&=2_{\mathbb C}(M_{\mathrm{col}})_{\mathbb C}-1_{\mathbb C}(M_{\mathrm{col}})_{\mathbb C}
&&\bigl(\because\ 1_{\mathbb C}\text{ は積の単位元}\ (\blkref{complex_numbers_form_a_field})\bigr)\\
&=(2_{\mathbb C}-1_{\mathbb C})(M_{\mathrm{col}})_{\mathbb C}
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\text{ の分配法則}\bigr)\\
&=1_{\mathbb C}(M_{\mathrm{col}})_{\mathbb C}
&&\bigl(\because\ \blkref{inclusion_rr_to_cc},\ \blkref{definition_of_cc}\text{ と }\blkref{def_complex_difference}\text{ により }2_{\mathbb C}-1_{\mathbb C}=(2_{\mathbb R}-1_{\mathbb R},0_{\mathbb R})=(1_{\mathbb R},0_{\mathbb R})=1_{\mathbb C}\bigr)\\
&=(M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}
&&\bigl(\because\ \mathbb C\text{ の積の交換律}\ (\blkref{complex_numbers_form_a_field})\bigr)\\
&=(M_{\mathrm{col}})_{\mathbb C}(-1_{\mathbb C})^l
&&\bigl(\because\ (-1_{\mathbb C})(-1_{\mathbb C})=1_{\mathbb C}\text{ と }(-1_{\mathbb C})^{-1}=-1_{\mathbb C}\text{ から、すべての }l\in\mathbb Z\text{ で }(-1_{\mathbb C})^{l+2}=(-1_{\mathbb C})^l\text{ であり、}(-1_{\mathbb C})^0=1_{\mathbb C}\text{ なので偶数の }l\text{ では }(-1_{\mathbb C})^l=1_{\mathbb C}\bigr).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`l`),
        " が奇数なら、",
        math(String.raw`(2(M_{\mathrm{col}})_{\mathbb N})_{\mathbb Z}=2M_{\mathrm{col}}\nmid k`),
        " と ",
        ref("def_delta_M"),
        " により ",
        math(String.raw`\delta^{2(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}=0_{\mathbb C}`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
S_{M_{\mathrm{col}},k}
&=(2M_{\mathrm{col}})_{\mathbb C}\cdot0_{\mathbb C}-(M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}
&&\bigl(\because\ \delta^{2(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}=0_{\mathbb C},\ \delta^{(M_{\mathrm{col}})_{\mathbb N}}_{(k,0)}=1_{\mathbb C}\bigr)\\
&=0_{\mathbb C}-(M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}
&&\bigl(\because\ \blkref{complex_times_zero_is_zero}\ (z\to(2M_{\mathrm{col}})_{\mathbb C})\bigr)\\
&=0_{\mathbb C}-(M_{\mathrm{col}})_{\mathbb C}
&&\bigl(\because\ (M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}=(M_{\mathrm{col}})_{\mathbb C}\ (\blkref{complex_numbers_form_a_field})\bigr)\\
&=0_{\mathbb C}+(-(M_{\mathrm{col}})_{\mathbb C})
&&\bigl(\because\ \blkref{def_complex_difference}\bigr)\\
&=-(M_{\mathrm{col}})_{\mathbb C}
&&\bigl(\because\ \blkref{complex_zero_plus_is_original}\ (z\to-(M_{\mathrm{col}})_{\mathbb C})\bigr)\\
&=(-1_{\mathbb C})(M_{\mathrm{col}})_{\mathbb C}
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr)\\
&=(M_{\mathrm{col}})_{\mathbb C}(-1_{\mathbb C})
&&\bigl(\because\ \mathbb C\text{ の積の交換律}\ (\blkref{complex_numbers_form_a_field})\bigr)\\
&=(M_{\mathrm{col}})_{\mathbb C}(-1_{\mathbb C})^l
&&\bigl(\because\ (-1_{\mathbb C})(-1_{\mathbb C})=1_{\mathbb C}\text{ と }(-1_{\mathbb C})^{-1}=-1_{\mathbb C}\text{ から、すべての }l\in\mathbb Z\text{ で }(-1_{\mathbb C})^{l+2}=(-1_{\mathbb C})^l\text{ であり、}(-1_{\mathbb C})^1=-1_{\mathbb C}\text{ なので奇数の }l\text{ では }(-1_{\mathbb C})^l=-1_{\mathbb C}\bigr).
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
&&\bigl(\because\ (-1_{\mathbb C})^0=1_{\mathbb C}\bigr) \\
&=(M_{\mathrm{col}})_{\mathbb C}
&&\bigl(\because\ (M_{\mathrm{col}})_{\mathbb C}\cdot1_{\mathbb C}=(M_{\mathrm{col}})_{\mathbb C}\ (\blkref{complex_numbers_form_a_field})\bigr).
\end{aligned}`,
      ),
      paragraph(["となる。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-14（Lean の通しの証明のゴールラインの確認）: k ≢ 0 (mod M) の鎖と l が奇数の鎖で、左から足す 0_C を消す行（0_C + (−0_C) = −0_C と 0_C + (−(M_col)_C) = −(M_col)_C）の根拠を、complex_numbers_form_a_field の「和の単位元」（右から足す z + 0_C = z しか示していない）から complex_zero_plus_is_original に替えた。式は不変。",
        "2026-11-14（Lean の通しの証明のゴールラインの確認）: 二つの鎖で右から 0_C を掛ける行（(2M_col)_C·0_C = 0_C の 2 行、(M_col)_C·0_C = 0_C、(−1_C)·0_C = 0_C）の根拠を、complex_numbers_form_a_field（体の公理は z·0 = 0 を含まない）から complex_times_zero_is_zero（z → (2M_col)_C、(M_col)_C、−1_C）に替えた。式は不変。",
      ],
    },
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
        ref("def_imaginary_unit"),
        " の ",
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
        " を仮定する。指数の ",
        math(String.raw`-i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}`),
        " は、",
        math(String.raw`-i := (-1_{\mathbb C})\,i`),
        "（",
        ref("multiply_by_minus_one"),
        "）を掛けた ",
        math(String.raw`(-i)\,(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}`),
        " の意味である。この複素数によるスカラー倍と同じ行列空間内の有限和を用いて",
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
        "2026-11-09（Lean の通しの証明）: 指数の -i(j_Rθ̃_μ)_C の読みが書かれていなかった。これを開いて使う anticommutator_of_check_psi・conjugate_index_of_check_Z_Y の読みと同じ (-i)(j_Rθ̃_μ)_C であることを書いた。定義の中身は変えていない。",
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
        ref("def_imaginary_unit"),
        " の ",
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
        " を仮定する。指数の ",
        math(String.raw`-i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}`),
        " は、",
        math(String.raw`-i := (-1_{\mathbb C})\,i`),
        "（",
        ref("multiply_by_minus_one"),
        "）を掛けた ",
        math(String.raw`(-i)\,(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}`),
        " の意味である。この複素数によるスカラー倍と同じ行列空間内の有限和を用いて",
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
        "2026-11-09（Lean の通しの証明）: 指数の -i(j_Rθ̃_μ)_C の読みが書かれていなかった。これを開いて使う anticommutator_of_check_psi・conjugate_index_of_check_Z_Y の読みと同じ (-i)(j_Rθ̃_μ)_C であることを書いた。定義の中身は変えていない。",
      ],
    },
  },
  {
    id: "evensector_003_claim_half_integer_phase_antiperiodicity",
    kind: "claim",
    origin: { path: "structured-latex/content/013_even_sector_modes.ts", ordinal: 5 },
    title: { tex: String.raw`\tilde\theta_\mu \text{ の反周期性 } \exp(-i((M_{\mathrm{col}})_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}) = -1_{\mathbb C}` },
    labels: ["half_integer_phase_antiperiodicity"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb Z_{\geq2}`),
        "、",
        math(String.raw`\mu\in\mathbb Z`),
        " とする。",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu\in\mathbb R`),
        " と像の記号 ",
        math(String.raw`a_{\mathbb R}`),
        "（",
        math(String.raw`a\in\mathbb Z`),
        "）、",
        ref("inclusion_rr_to_cc"),
        " の ",
        math(String.raw`r_{\mathbb C}`),
        "（",
        math(String.raw`r\in\mathbb R`),
        "）を用いる。主張の ",
        math(String.raw`-i((M_{\mathrm{col}})_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}`),
        " は、",
        math(String.raw`-i := (-1_{\mathbb C})\,i`),
        "（",
        ref("multiply_by_minus_one"),
        "）を掛けた ",
        math(String.raw`(-i)\,(\cdot)_{\mathbb C}`),
        " の意味である（",
        ref("def_half_integer_checkZ"),
        "・",
        ref("def_half_integer_checkY"),
        " の係数と同じ読み）。このとき",
      ]),
      displayMath(String.raw`\exp(-i((M_{\mathrm{col}})_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}) = -1_{\mathbb C}`),
      paragraph([
        "が成り立つ。証明は全実数上の ",
        math(String.raw`\cos,\sin`),
        " の性質（",
        math(String.raw`2\pi`),
        " 周期性、",
        math(String.raw`\cos\pi=-1_{\mathbb R}`),
        "、",
        math(String.raw`\sin\pi=0_{\mathbb R}`),
        "）と、",
        ref("cos_of_negated_real"),
        "・",
        ref("sin_of_negated_real"),
        "（これらも全実数上の ",
        math(String.raw`\cos,\sin`),
        " に依る）を使う。",
        ref("def_sin"),
        "・",
        ref("def_cos"),
        " は ",
        math(String.raw`[-\pi/2,\pi/2]`),
        " 上でしか定めておらず、全実数への拡張は ",
        ref("euler_formula_cos_sin"),
        " の前置きのとおり未整備なので、この主張はその拡張を前提とする。",
      ]),
    ],
    proof: [
      paragraph([
        "指数の中の実数を求める。",
        ref("antiperiodic_exp_sum"),
        " より ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
(M_{\mathrm{col}})_{\mathbb R}\tilde\theta_\mu
&=(M_{\mathrm{col}})_{\mathbb R}\cdot\frac{2\pi\left(\mu_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \tilde\theta_\mu\text{ の定義。}\blkref{antiperiodic_exp_sum}\bigr)\\
&=2\pi\left(\mu_{\mathbb R}-\tfrac12\right)
&&\bigl(\because\ (M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}\text{ による約分}\bigr)\\
&=2\pi\mu_{\mathbb R}-2\pi\cdot\tfrac12
&&\bigl(\because\ \mathbb R\text{ の分配法則}\bigr)\\
&=2\pi\mu_{\mathbb R}-(\pi\cdot2)\cdot\tfrac12
&&\bigl(\because\ \mathbb R\text{ の積の交換律}\ (2\pi=\pi\cdot2)\bigr)\\
&=2\pi\mu_{\mathbb R}-\pi\left(2\cdot\tfrac12\right)
&&\bigl(\because\ \mathbb R\text{ の積の結合律}\bigr)\\
&=2\pi\mu_{\mathbb R}-\pi
&&\bigl(\because\ 2\cdot\tfrac12=1\bigr)\\
&=-\pi+2\pi\mu_{\mathbb R}
&&\bigl(\because\ \mathbb R\text{ の加法の交換律}\bigr)
\end{aligned}`),
      paragraph(["これを使って、主張の左辺から"]),
      displayMath(
        String.raw`\begin{aligned}
\exp(-i((M_{\mathrm{col}})_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
&=\exp\bigl(-\bigl(i((M_{\mathrm{col}})_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}\bigr)\bigr)
&&\bigl(\because\ \blkref{negative_i_times_complex_is_negation_of_i_times}\ (z\to((M_{\mathrm{col}})_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})\bigr) \\
&=(\cos((M_{\mathrm{col}})_{\mathbb R}\tilde\theta_\mu))_{\mathbb C}-i(\sin((M_{\mathrm{col}})_{\mathbb R}\tilde\theta_\mu))_{\mathbb C}
&&\bigl(\because\ \blkref{exp_of_negative_i_real_as_cos_minus_i_sin}\text{ を }\theta=(M_{\mathrm{col}})_{\mathbb R}\tilde\theta_\mu\text{ で}\bigr) \\
&=(\cos(-\pi+2\pi\mu_{\mathbb R}))_{\mathbb C}-i(\sin(-\pi+2\pi\mu_{\mathbb R}))_{\mathbb C}
&&\bigl(\because\ \text{上の鎖を 2 箇所へ同時代入}\bigr) \\
&=(\cos(-\pi))_{\mathbb C}-i(\sin(-\pi+2\pi\mu_{\mathbb R}))_{\mathbb C}
&&\bigl(\because\ \mu\in\mathbb Z\text{ と }\cos\text{ の }2\pi\text{ 周期性}\ (x\to-\pi,\ n\to\mu)\bigr) \\
&=(\cos(-\pi))_{\mathbb C}-i(\sin(-\pi))_{\mathbb C}
&&\bigl(\because\ \mu\in\mathbb Z\text{ と }\sin\text{ の }2\pi\text{ 周期性}\ (x\to-\pi,\ n\to\mu)\bigr) \\
&=(\cos\pi)_{\mathbb C}-i(\sin(-\pi))_{\mathbb C}
&&\bigl(\because\ \blkref{cos_of_negated_real}\ (\theta\to\pi)\bigr) \\
&=(\cos\pi)_{\mathbb C}-i\bigl(-(\sin\pi)_{\mathbb C}\bigr)
&&\bigl(\because\ \blkref{sin_of_negated_real}\ (\theta\to\pi)\bigr) \\
&=(-1_{\mathbb R})_{\mathbb C}-i\bigl(-(\sin\pi)_{\mathbb C}\bigr)
&&\bigl(\because\ \cos\pi=-1_{\mathbb R}\bigr) \\
&=(-1_{\mathbb R})_{\mathbb C}-i\bigl(-(0_{\mathbb R})_{\mathbb C}\bigr)
&&\bigl(\because\ \sin\pi=0_{\mathbb R}\bigr) \\
&=(-1_{\mathbb R})_{\mathbb C}-i(-0_{\mathbb C})
&&\bigl(\because\ (0_{\mathbb R})_{\mathbb C}=(0_{\mathbb R},0_{\mathbb R})=0_{\mathbb C}\ (\blkref{inclusion_rr_to_cc},\ \blkref{complex_numbers_form_a_field}\text{ の零元})\bigr) \\
&=(-1_{\mathbb R})_{\mathbb C}-i\bigl((-1_{\mathbb C})\cdot0_{\mathbb C}\bigr)
&&\bigl(\because\ \blkref{multiply_by_minus_one}\ (z\to0_{\mathbb C})\bigr) \\
&=(-1_{\mathbb R})_{\mathbb C}-i\cdot0_{\mathbb C}
&&\bigl(\because\ \blkref{complex_times_zero_is_zero}\ (z\to-1_{\mathbb C})\bigr) \\
&=(-1_{\mathbb R})_{\mathbb C}-0_{\mathbb C}
&&\bigl(\because\ \blkref{complex_times_zero_is_zero}\ (z\to i)\bigr) \\
&=(-1_{\mathbb R})_{\mathbb C}+(-0_{\mathbb C})
&&\bigl(\because\ \blkref{def_complex_difference}\bigr) \\
&=(-1_{\mathbb R})_{\mathbb C}+(-1_{\mathbb C})\cdot0_{\mathbb C}
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr) \\
&=(-1_{\mathbb R})_{\mathbb C}+0_{\mathbb C}
&&\bigl(\because\ \blkref{complex_times_zero_is_zero}\ (z\to-1_{\mathbb C})\bigr) \\
&=(-1_{\mathbb R})_{\mathbb C}
&&\bigl(\because\ 0_{\mathbb C}\text{ は和の単位元}\ (\blkref{complex_numbers_form_a_field})\bigr) \\
&=-1_{\mathbb C}
&&\bigl(\because\ \blkref{inclusion_rr_to_cc}\text{ と }\blkref{definition_of_cc}\text{ の和により }(1_{\mathbb R},0_{\mathbb R})+(-1_{\mathbb R},0_{\mathbb R})=(0_{\mathbb R},0_{\mathbb R})=0_{\mathbb C}\text{ なので、}(-1_{\mathbb R})_{\mathbb C}=(-1_{\mathbb R},0_{\mathbb R})\text{ は }1_{\mathbb C}\text{ の加法の逆元 }-1_{\mathbb C}\ (\blkref{complex_numbers_form_a_field})\bigr)
\end{aligned}`,
      ),
      paragraph(["となる。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "旧複合ラベル def_half_integer_modes の (1) から、半整数位相の反周期性だけを独立した主張へ分離した。",
        "2026-11-02（全証明の SageMath 検算）: 主張と証明の実数・複素数に像の記号を付け、θ̃_μ の定義の式どおりに角度の鎖を始め、cos(2πμ-π) = -1 と sin(2πμ-π) = 0 を 1 行に束ねていたのを、周期性・偶奇性・特殊値の一行一操作に分けた。負角の Euler 表示は euler_formula_cos_sin の証明の中の式ではなく、主張 exp_of_negative_i_real_as_cos_minus_i_sin を引く。全実数上の cos・sin の性質に依ることを主張に書いた。",
        "2026-11-09（Lean の通しの証明のゴールラインの確認）: 鎖の「cos は偶関数」「sin は奇関数」の 2 行が名前だけの根拠だったので、主張 cos_of_negated_real・sin_of_negated_real（θ → π）の参照にした。" +
          "sin_of_negated_real の右辺は ℂ の符号反転 -(sin π)_ℂ なので、続く行を -(0_R)_ℂ → -0_ℂ → (-1_ℂ)·0_ℂ → 0_ℂ の順に直した（-0_R = 0_R の行が無くなり、-0_ℂ = (-1_ℂ)·0_ℂ と (-1_ℂ)·0_ℂ = 0_ℂ の 2 行が増え、鎖は 15 等号から 16 等号になった）。主張の中身は不変。",
        "2026-11-09（Lean の通しの証明）: 主張の -i(·)_C の読みが書かれていなかった。def_half_integer_checkZ・def_half_integer_checkY の係数と同じ (-i)(·)_C の読みを主張に書き、exp_of_negative_i_real_as_cos_minus_i_sin（-iθ_C は euler_formula_cos_sin の読みどおり -(iθ_C)）を引く前に negative_i_times_complex_is_negation_of_i_times で -(i(·)_C) へ書き換える 1 行を足した（16 等号 → 17 等号）。ほかの行は変えていない。",
        "2026-11-10（Lean の通しの証明）: 1 行に 2 つの事実を当てていた 2 行を割った。角度の鎖の「ℝ の積の結合律と交換律」を、積の交換律（2π = π·2）と積の結合律の 2 行に（6 等号 → 7 等号）、主鎖の「cos,sin の 2π 周期性を 2 箇所へ同時適用」を、cos の周期性と sin の周期性の 2 行に（17 等号 → 18 等号）した。主張の中身は不変。",
        "2026-11-14（Lean の通しの証明のゴールラインの確認）: 鎖の (−1_C)·0_C = 0_C の 2 行と i·0_C = 0_C の 1 行の根拠を、complex_numbers_form_a_field（体の公理は z·0 = 0 を含まない）から complex_times_zero_is_zero（z → −1_C、z → i）に替えた。式は不変。",
      ],
    },
  },
  {
    id: "evensector_claim_half_integer_phase_periodicity",
    kind: "claim",
    title: { tex: String.raw`\tilde\theta_\mu \text{ の添字をずらした位相 } \exp(-i(j_{\mathbb R}\tilde\theta_{\mu+M_{\mathrm{col}}})_{\mathbb C}) = \exp(-i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})` },
    labels: ["half_integer_phase_periodicity"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb Z_{\geq2}`),
        "、",
        math(String.raw`\mu\in\mathbb Z`),
        "、",
        math(String.raw`j\in\mathbb Z`),
        " とする。",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu\in\mathbb R`),
        " と像の記号 ",
        math(String.raw`a_{\mathbb R}`),
        "（",
        math(String.raw`a\in\mathbb Z`),
        "）、",
        ref("inclusion_rr_to_cc"),
        " の ",
        math(String.raw`r_{\mathbb C}`),
        "（",
        math(String.raw`r\in\mathbb R`),
        "）を用いる。主張の ",
        math(String.raw`-i(j_{\mathbb R}\tilde\theta_{\mu+M_{\mathrm{col}}})_{\mathbb C},\ -i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}`),
        " は、",
        math(String.raw`-i := (-1_{\mathbb C})\,i`),
        "（",
        ref("multiply_by_minus_one"),
        "）を掛けた ",
        math(String.raw`(-i)\,(\cdot)_{\mathbb C}`),
        " の意味である（",
        ref("def_half_integer_checkZ"),
        "・",
        ref("def_half_integer_checkY"),
        " の係数と同じ読み）。このとき",
      ]),
      displayMath(String.raw`\exp(-i(j_{\mathbb R}\tilde\theta_{\mu+M_{\mathrm{col}}})_{\mathbb C}) = \exp(-i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})`),
      paragraph([
        "が成り立つ。証明は全実数上の ",
        math(String.raw`\cos,\sin`),
        " の ",
        math(String.raw`2\pi`),
        " 周期性（",
        math(String.raw`x\in\mathbb R`),
        "、",
        math(String.raw`n\in\mathbb Z`),
        " について ",
        math(String.raw`\cos(x+2\pi n_{\mathbb R})=\cos x`),
        "、",
        math(String.raw`\sin(x+2\pi n_{\mathbb R})=\sin x`),
        "）を使う。全実数への拡張は ",
        ref("euler_formula_cos_sin"),
        " の前置きのとおり未整備なので、この主張はその拡張を前提とする。",
      ]),
    ],
    proof: [
      paragraph([
        "添字をずらした角度を求める。",
        ref("antiperiodic_exp_sum"),
        " より ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\tilde\theta_{\mu+M_{\mathrm{col}}}
&=\frac{2\pi\left((\mu+M_{\mathrm{col}})_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \tilde\theta\text{ の定義を }\mu+M_{\mathrm{col}}\in\mathbb Z\text{ で。}\blkref{antiperiodic_exp_sum}\bigr)\\
&=\frac{2\pi\left((\mu_{\mathbb R}+(M_{\mathrm{col}})_{\mathbb R})-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \iota_{\mathbb Z\to\mathbb R}\text{ は和を保つ}\bigr)\\
&=\frac{2\pi\left(\left((M_{\mathrm{col}})_{\mathbb R}+\mu_{\mathbb R}\right)-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \mathbb R\text{ の加法の交換律}\bigr)\\
&=\frac{2\pi\left(\left((M_{\mathrm{col}})_{\mathbb R}+\mu_{\mathbb R}\right)+\left(-\tfrac12\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \blkref{def_real_difference}\bigr)\\
&=\frac{2\pi\left((M_{\mathrm{col}})_{\mathbb R}+\left(\mu_{\mathbb R}+\left(-\tfrac12\right)\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \mathbb R\text{ の加法の結合律}\bigr)\\
&=\frac{2\pi\left((M_{\mathrm{col}})_{\mathbb R}+\left(\mu_{\mathbb R}-\tfrac12\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \blkref{def_real_difference}\text{ を右辺から左辺へ}\bigr)\\
&=\frac{2\pi\left(\left(\mu_{\mathbb R}-\tfrac12\right)+(M_{\mathrm{col}})_{\mathbb R}\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \mathbb R\text{ の加法の交換律}\bigr)\\
&=\frac{2\pi\left(\mu_{\mathbb R}-\tfrac12\right)+2\pi(M_{\mathrm{col}})_{\mathbb R}}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \mathbb R\text{ の分配法則}\bigr)\\
&=\frac{2\pi\left(\mu_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}+\frac{2\pi(M_{\mathrm{col}})_{\mathbb R}}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ (M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}\text{ を分母とする分数の和}\bigr)\\
&=\tilde\theta_\mu+\frac{2\pi(M_{\mathrm{col}})_{\mathbb R}}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \tilde\theta_\mu\text{ の定義。}\blkref{antiperiodic_exp_sum}\bigr)\\
&=\tilde\theta_\mu+2\pi
&&\bigl(\because\ (M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}\text{ による約分}\bigr)
\end{aligned}`),
      paragraph(["これに ", math(String.raw`j_{\mathbb R}`), " を掛けると"]),
      displayMath(String.raw`\begin{aligned}
j_{\mathbb R}\tilde\theta_{\mu+M_{\mathrm{col}}}
&=j_{\mathbb R}\left(\tilde\theta_\mu+2\pi\right)
&&\bigl(\because\ \text{上の鎖}\bigr)\\
&=j_{\mathbb R}\tilde\theta_\mu+j_{\mathbb R}\cdot2\pi
&&\bigl(\because\ \mathbb R\text{ の分配法則}\bigr)\\
&=j_{\mathbb R}\tilde\theta_\mu+2\pi j_{\mathbb R}
&&\bigl(\because\ \mathbb R\text{ の積の交換律}\bigr)
\end{aligned}`),
      paragraph(["となる。これを使って、主張の左辺から"]),
      displayMath(
        String.raw`\begin{aligned}
\exp(-i(j_{\mathbb R}\tilde\theta_{\mu+M_{\mathrm{col}}})_{\mathbb C})
&=\exp\bigl(-\bigl(i(j_{\mathbb R}\tilde\theta_{\mu+M_{\mathrm{col}}})_{\mathbb C}\bigr)\bigr)
&&\bigl(\because\ \blkref{negative_i_times_complex_is_negation_of_i_times}\ (z\to(j_{\mathbb R}\tilde\theta_{\mu+M_{\mathrm{col}}})_{\mathbb C})\bigr) \\
&=(\cos(j_{\mathbb R}\tilde\theta_{\mu+M_{\mathrm{col}}}))_{\mathbb C}-i(\sin(j_{\mathbb R}\tilde\theta_{\mu+M_{\mathrm{col}}}))_{\mathbb C}
&&\bigl(\because\ \blkref{exp_of_negative_i_real_as_cos_minus_i_sin}\text{ を }\theta=j_{\mathbb R}\tilde\theta_{\mu+M_{\mathrm{col}}}\text{ で}\bigr) \\
&=(\cos(j_{\mathbb R}\tilde\theta_\mu+2\pi j_{\mathbb R}))_{\mathbb C}-i(\sin(j_{\mathbb R}\tilde\theta_\mu+2\pi j_{\mathbb R}))_{\mathbb C}
&&\bigl(\because\ \text{上の鎖を 2 箇所へ同時代入}\bigr) \\
&=(\cos(j_{\mathbb R}\tilde\theta_\mu))_{\mathbb C}-i(\sin(j_{\mathbb R}\tilde\theta_\mu+2\pi j_{\mathbb R}))_{\mathbb C}
&&\bigl(\because\ j\in\mathbb Z\text{ と }\cos\text{ の }2\pi\text{ 周期性}\ (x\to j_{\mathbb R}\tilde\theta_\mu,\ n\to j)\bigr) \\
&=(\cos(j_{\mathbb R}\tilde\theta_\mu))_{\mathbb C}-i(\sin(j_{\mathbb R}\tilde\theta_\mu))_{\mathbb C}
&&\bigl(\because\ j\in\mathbb Z\text{ と }\sin\text{ の }2\pi\text{ 周期性}\ (x\to j_{\mathbb R}\tilde\theta_\mu,\ n\to j)\bigr) \\
&=\exp\bigl(-\bigl(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}\bigr)\bigr)
&&\bigl(\because\ \blkref{exp_of_negative_i_real_as_cos_minus_i_sin}\text{ を }\theta=j_{\mathbb R}\tilde\theta_\mu\text{ で（右辺から左辺へ）}\bigr) \\
&=\exp(-i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
&&\bigl(\because\ \blkref{negative_i_times_complex_is_negation_of_i_times}\ (z\to(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})\text{ を右辺から左辺へ}\bigr)
\end{aligned}`,
      ),
      paragraph(["となる。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02（全証明の SageMath 検算）: half_integer_checkZ_periodicity と half_integer_checkY_periodicity の証明が同じ二つの鎖（添字をずらした角度と係数の一致）を重複して持っていたので、係数の一致を一つの主張に切り出した。",
        "2026-11-09（Lean の通しの証明）: 主張の -i(·)_C の読みが書かれていなかった。def_half_integer_checkZ・def_half_integer_checkY の係数と同じ (-i)(·)_C の読みを主張に書き、exp_of_negative_i_real_as_cos_minus_i_sin（-iθ_C は -(iθ_C)）を当てる 1 行目の前と末尾の行の後に negative_i_times_complex_is_negation_of_i_times の行を 1 行ずつ足した（4 等号 → 6 等号）。ほかの行は変えていない。",
        "2026-11-10（Lean の通しの証明）: 1 行に 2 つの事実を当てていた 2 行を割った。角度の鎖の「ℝ の加法の結合律と交換律」を、交換律・差の定義（def_real_difference）・結合律・差の定義（右辺から左辺へ）・交換律の 5 行に（7 等号 → 11 等号）、主鎖の「cos,sin の 2π 周期性を 2 箇所へ同時適用」を、cos の周期性と sin の周期性の 2 行に（6 等号 → 7 等号）した。主張の中身は不変。",
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
        " が成り立つ。この主張は ",
        ref("half_integer_phase_periodicity"),
        " を通じて、全実数上の ",
        math(String.raw`\cos,\sin`),
        " の ",
        math(String.raw`2\pi`),
        " 周期性（未整備）を前提とする。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`j\in\{1,\dots,(M_{\mathrm{col}})_{\mathbb N}\}`),
        " について ",
        math(String.raw`j_{\mathbb Z}\in\mathbb Z`),
        " であり、",
        ref("antiperiodic_exp_sum"),
        " の記号で ",
        math(String.raw`(j_{\mathbb Z})_{\mathbb R}=j_{\mathbb R}`),
        " である。主張の左辺から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Z}_{\mu+M_{\mathrm{col}}}
&=\sum_{j=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(-i(j_{\mathbb R}\tilde\theta_{\mu+M_{\mathrm{col}}})_{\mathbb C})Z_{j_{\mathbb Z}}
&&\left(\because\ \blkref{def_half_integer_checkZ}\text{ を }\mu+M_{\mathrm{col}}\in\mathbb Z\text{ で}\right)\\
&=\sum_{j=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(-i(j_{\mathbb R}\tilde\theta_{\mu})_{\mathbb C})Z_{j_{\mathbb Z}}
&&\left(\because\ \blkref{half_integer_phase_periodicity}\text{ を整数 }j_{\mathbb Z}\text{ で全項へ同時適用}\right)\\
&=\check{Z}_{\mu}
&&\left(\because\ \blkref{def_half_integer_checkZ}\text{ を }\mu\text{ で}\right)
\end{aligned}`,
      ),
      paragraph(["となる。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "旧複合ラベル def_half_integer_modes の (2) から、半整数運動量 Fourier Z 行列の添字周期性だけを独立した主張へ分離した。",
        "2026-11-02（全証明の SageMath 検算）: 係数の一致の二つの鎖を half_integer_phase_periodicity へ切り出し、ここではそれを引く。",
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
        " が成り立つ。この主張は ",
        ref("half_integer_phase_periodicity"),
        " を通じて、全実数上の ",
        math(String.raw`\cos,\sin`),
        " の ",
        math(String.raw`2\pi`),
        " 周期性（未整備）を前提とする。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`j\in\{1,\dots,(M_{\mathrm{col}})_{\mathbb N}\}`),
        " について ",
        math(String.raw`j_{\mathbb Z}\in\mathbb Z`),
        " であり、",
        ref("antiperiodic_exp_sum"),
        " の記号で ",
        math(String.raw`(j_{\mathbb Z})_{\mathbb R}=j_{\mathbb R}`),
        " である。主張の左辺から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Y}_{\mu+M_{\mathrm{col}}}
&=\sum_{j=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(-i(j_{\mathbb R}\tilde\theta_{\mu+M_{\mathrm{col}}})_{\mathbb C})Y_{j_{\mathbb Z}}
&&\left(\because\ \blkref{def_half_integer_checkY}\text{ を }\mu+M_{\mathrm{col}}\in\mathbb Z\text{ で}\right)\\
&=\sum_{j=1}^{(M_{\mathrm{col}})_{\mathbb N}}\exp(-i(j_{\mathbb R}\tilde\theta_{\mu})_{\mathbb C})Y_{j_{\mathbb Z}}
&&\left(\because\ \blkref{half_integer_phase_periodicity}\text{ を整数 }j_{\mathbb Z}\text{ で全項へ同時適用}\right)\\
&=\check{Y}_{\mu}
&&\left(\because\ \blkref{def_half_integer_checkY}\text{ を }\mu\text{ で}\right)
\end{aligned}`,
      ),
      paragraph(["となる。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "旧複合ラベル def_half_integer_modes の (2) から、半整数運動量 Fourier Y 行列の添字周期性だけを独立した主張へ分離した。",
        "2026-11-02（全証明の SageMath 検算）: 係数の一致の二つの鎖を half_integer_phase_periodicity へ切り出し、ここではそれを引く。",
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
        "である。",
        ref("pi_is_positive"),
        " の ",
        math(String.raw`0 < \pi`),
        " と ",
        math(String.raw`0 < 2`),
        " から、",
        math(String.raw`\mathbb{R}`),
        " で正の数どうしの積は正（",
        math(String.raw`\mathbb{R}`),
        " は順序体 ",
        ref("set_and_algebra_notation"),
        "）なので ",
        math(String.raw`0 < 2\pi`),
        " である。",
        math(String.raw`M_{\mathrm{col}} \geq 2 > 0`),
        " と、",
        math(String.raw`\mathbb{R}`),
        " で正の数の逆数は正（同じく順序体）であることから ",
        math(String.raw`0 < \frac{1}{M_{\mathrm{col}}}`),
        "、これと ",
        math(String.raw`0 < 2\pi`),
        " の積で ",
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
        math(String.raw`0 < \pi`),
        " と上の ",
        math(String.raw`0 < \frac{1}{M_{\mathrm{col}}}`),
        " の積で ",
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
        "2026-11-09（Lean の通しの証明のゴールラインの確認）: (1) の 2π/M_col > 0 と 0 < π/M_col を、pi_is_positive の 0 < π から正の数どうしの積と正の数の逆数は正（ℝ は順序体 set_and_algebra_notation）の段を書いて導く形にした。値と主張は不変。",
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
        "、",
        math(String.raw`i \in \mathbb{C}`),
        " は ",
        ref("def_imaginary_unit"),
        " の虚数単位）、",
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
Z_jZ_k &= -Z_kZ_j,\quad Y_jY_k = -Y_kY_j
&&\bigl(\because\ \blkref{anticommutator_of_Z_and_Y},\ j\ne k\bigr), \\
Z_jY_k &= -Y_kZ_j
&&\bigl(\because\ \blkref{anticommutator_of_Z_and_Y}\bigr), \\
Z_jZ_j &= I,\quad Y_jY_j = I
&&\bigl(\because\ \blkref{anticommutator_of_Z_and_Y},\ \delta^{(M_{\mathrm{col}})}_{(j,j)}=1,\ \mathbb C\text{ の四則}\bigr)
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
&= O
   &&(\because \blkref{matrix_difference_zero_iff_equal}\ \text{の}\ \Leftarrow\ \text{を}\ A = B = Z_j\left(Z_aY_a\right)\ \text{へ適用})
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
&= O
   &&(\because \blkref{matrix_difference_zero_iff_equal}\ \text{の}\ \Leftarrow\ \text{を}\ A = B = Y_j\left(Z_aY_a\right)\ \text{へ適用})
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
&= O
   &&(\because \blkref{matrix_difference_zero_iff_equal}\ \text{の}\ \Leftarrow\ \text{を}\ A = B = Z_j\left(Y_aZ_b\right)\ \text{へ適用})
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
&= O
   &&(\because \blkref{matrix_difference_zero_iff_equal}\ \text{の}\ \Leftarrow\ \text{を}\ A = B = Y_j\left(Y_aZ_b\right)\ \text{へ適用})
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
   &&(\because \blkref{identity_matrix_is_left_unit_of_mat_mult}\ (I\,Y_j = Y_j)) \\
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
   &&(\because \blkref{identity_matrix_is_right_unit_of_mat_mult}\ (Z_j\,I = Z_j)) \\
&= Z_j - \left(-Z_jY_j\right)Y_j
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Y_jZ_j = -Z_jY_j)) \\
&= Z_j + Z_j\left(Y_jY_j\right)
   &&(\because \text{結合法則とスカラー倍}) \\
&= Z_j + Z_j\,I
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Y_jY_j = I)) \\
&= Z_j + Z_j
   &&(\because \blkref{identity_matrix_is_right_unit_of_mat_mult}\ (Z_j\,I = Z_j)) \\
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
   &&(\because \blkref{identity_matrix_is_right_unit_of_mat_mult}\ (Y_m\,I = Y_m)) \\
&= Y_m - \left(-Y_mZ_{m+1}\right)Z_{m+1}
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_{m+1}Y_m = -Y_mZ_{m+1})) \\
&= Y_m + Y_m\left(Z_{m+1}Z_{m+1}\right)
   &&(\because \text{結合法則とスカラー倍}) \\
&= Y_m + Y_m\,I
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_{m+1}Z_{m+1} = I)) \\
&= Y_m + Y_m
   &&(\because \blkref{identity_matrix_is_right_unit_of_mat_mult}\ (Y_m\,I = Y_m)) \\
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
   &&(\because \blkref{identity_matrix_is_left_unit_of_mat_mult}\ (I\,Z_{m+1} = Z_{m+1})) \\
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
   &&(\because \blkref{identity_matrix_is_right_unit_of_mat_mult}\ (Y_{M_{\mathrm{col}}}\,I = Y_{M_{\mathrm{col}}})) \\
&= -\left(Y_{M_{\mathrm{col}}} - \left(-Y_{M_{\mathrm{col}}}Z_1\right)Z_1\right)
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_1Y_{M_{\mathrm{col}}} = -Y_{M_{\mathrm{col}}}Z_1)) \\
&= -\left(Y_{M_{\mathrm{col}}} + Y_{M_{\mathrm{col}}}\left(Z_1Z_1\right)\right)
   &&(\because \text{結合法則とスカラー倍}) \\
&= -\left(Y_{M_{\mathrm{col}}} + Y_{M_{\mathrm{col}}}\,I\right)
   &&(\because \blkref{anticommutator_of_Z_and_Y}\ (Z_1Z_1 = I)) \\
&= -\left(Y_{M_{\mathrm{col}}} + Y_{M_{\mathrm{col}}}\right)
   &&(\because \blkref{identity_matrix_is_right_unit_of_mat_mult}\ (Y_{M_{\mathrm{col}}}\,I = Y_{M_{\mathrm{col}}})) \\
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
   &&(\because \blkref{identity_matrix_is_left_unit_of_mat_mult}\ (I\,Z_1 = Z_1)) \\
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
&= \left[Z_jY_j,\ Z_j\right] + \sum_{\substack{1 \leq a \leq M_{\mathrm{col}} \\ a \neq j}} O
   &&(\because \text{上で示した } \left[Z_aY_a, Z_j\right] = O\ (a \neq j) \text{ を各項へ同時適用}) \\
&= \left[Z_jY_j,\ Z_j\right] + O
   &&(\because \text{零行列の和は零行列（一つの添字を除いた集合の上の和。空の和を含む）}) \\
&= \left[Z_jY_j,\ Z_j\right]
   &&(\because \blkref{matrix_plus_zero_matrix}) \\
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
&= \left[Z_jY_j,\ Y_j\right] + \sum_{\substack{1 \leq a \leq M_{\mathrm{col}} \\ a \neq j}} O
   &&(\because \text{上で示した } \left[Z_aY_a, Y_j\right] = O\ (a \neq j) \text{ を各項へ同時適用}) \\
&= \left[Z_jY_j,\ Y_j\right] + O
   &&(\because \text{零行列の和は零行列（一つの添字を除いた集合の上の和。空の和を含む）}) \\
&= \left[Z_jY_j,\ Y_j\right]
   &&(\because \blkref{matrix_plus_zero_matrix}) \\
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
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\left[Y_mZ_{m+1},\ Z_j\right] - O
   &&(\because \text{上で示した } \left[Y_aZ_b, Z_j\right] = O\ (b \neq j) \text{ を } a = M_{\mathrm{col}},\ b = 1 \neq j \text{ に適用}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\left[Y_mZ_{m+1},\ Z_j\right]
   &&(\because \blkref{matrix_minus_zero_matrix}) \\
&= \left[Y_{j-1}Z_j,\ Z_j\right] + \sum_{\substack{1 \leq m \leq M_{\mathrm{col}}-1 \\ m \neq j-1}}\left[Y_mZ_{m+1},\ Z_j\right]
   &&(\because 1 \leq j-1 \leq M_{\mathrm{col}}-1 \text{ なので } m = j-1 \text{ の項を有限和から分ける}) \\
&= \left[Y_{j-1}Z_j,\ Z_j\right] + \sum_{\substack{1 \leq m \leq M_{\mathrm{col}}-1 \\ m \neq j-1}} O
   &&(\because \text{上で示した } \left[Y_aZ_b, Z_j\right] = O\ (b \neq j) \text{ を } a = m,\ b = m+1 \neq j \text{ として各項へ同時適用}) \\
&= \left[Y_{j-1}Z_j,\ Z_j\right] + O
   &&(\because \text{零行列の和は零行列（一つの添字を除いた集合の上の和。空の和を含む）}) \\
&= \left[Y_{j-1}Z_j,\ Z_j\right]
   &&(\because \blkref{matrix_plus_zero_matrix}) \\
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
&= \sum_{m=1}^{M_{\mathrm{col}}-1} O + \left[-Y_{M_{\mathrm{col}}}Z_1,\ Z_1\right]
   &&(\because \text{上で示した } \left[Y_aZ_b, Z_j\right] = O\ (b \neq j) \text{ を } a = m,\ b = m+1 \geq 2,\ j = 1 \text{ として各項へ同時適用}) \\
&= O + \left[-Y_{M_{\mathrm{col}}}Z_1,\ Z_1\right]
   &&(\because \blkref{finite_sum_of_zero_matrices}) \\
&= \left[-Y_{M_{\mathrm{col}}}Z_1,\ Z_1\right]
   &&(\because \blkref{zero_matrix_plus_matrix}) \\
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
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\left[Y_mZ_{m+1},\ Y_j\right] - O
   &&(\because \text{上で示した } \left[Y_aZ_b, Y_j\right] = O\ (a \neq j) \text{ を } a = M_{\mathrm{col}} \neq j,\ b = 1 \text{ に適用}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\left[Y_mZ_{m+1},\ Y_j\right]
   &&(\because \blkref{matrix_minus_zero_matrix}) \\
&= \left[Y_jZ_{j+1},\ Y_j\right] + \sum_{\substack{1 \leq m \leq M_{\mathrm{col}}-1 \\ m \neq j}}\left[Y_mZ_{m+1},\ Y_j\right]
   &&(\because 1 \leq j \leq M_{\mathrm{col}}-1 \text{ なので } m = j \text{ の項を有限和から分ける}) \\
&= \left[Y_jZ_{j+1},\ Y_j\right] + \sum_{\substack{1 \leq m \leq M_{\mathrm{col}}-1 \\ m \neq j}} O
   &&(\because \text{上で示した } \left[Y_aZ_b, Y_j\right] = O\ (a \neq j) \text{ を } a = m \neq j,\ b = m+1 \text{ として各項へ同時適用}) \\
&= \left[Y_jZ_{j+1},\ Y_j\right] + O
   &&(\because \text{零行列の和は零行列（一つの添字を除いた集合の上の和。空の和を含む）}) \\
&= \left[Y_jZ_{j+1},\ Y_j\right]
   &&(\because \blkref{matrix_plus_zero_matrix}) \\
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
&= \sum_{m=1}^{M_{\mathrm{col}}-1} O + \left[-Y_{M_{\mathrm{col}}}Z_1,\ Y_{M_{\mathrm{col}}}\right]
   &&(\because \text{上で示した } \left[Y_aZ_b, Y_j\right] = O\ (a \neq j) \text{ を } a = m \leq M_{\mathrm{col}}-1,\ b = m+1,\ j = M_{\mathrm{col}} \text{ として各項へ同時適用}) \\
&= O + \left[-Y_{M_{\mathrm{col}}}Z_1,\ Y_{M_{\mathrm{col}}}\right]
   &&(\because \blkref{finite_sum_of_zero_matrices}) \\
&= \left[-Y_{M_{\mathrm{col}}}Z_1,\ Y_{M_{\mathrm{col}}}\right]
   &&(\because \blkref{zero_matrix_plus_matrix}) \\
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
        "2026-11-01: Step 1 の名前だけの根拠「単位行列の性質」（9 か所）を identity_matrix_is_left_unit_of_mat_mult・identity_matrix_is_right_unit_of_mat_mult へ、" +
          "「同じ行列の差は零行列」（4 か所）を matrix_difference_zero_iff_equal の ⟸ へのラベル参照に替え、零行列の記号を def_zero_matrix の O に揃えた。" +
          "「零行列の和は零行列」「零行列を引いても変わらない」は引ける主張が本文に無いので残した。",
        "2026-11-01: Step 1 の名前だけの根拠「零行列の和は零行列」（6 か所）を、零行列の有限和を O にする行と O を足して消す行" +
          "（matrix_plus_zero_matrix・zero_matrix_plus_matrix）の 2 行に分け、「零行列を引いても変わらない」（2 か所）を matrix_minus_zero_matrix へのラベル参照に替えた。" +
          "有限和を O にする行は、添字が 1..M_col−1 の 2 か所だけを finite_sum_of_zero_matrices へのラベル参照にした。" +
          "残る 4 か所は一つの添字を除いた集合の上の和（M_col = 2 では空の和）で、本文の有限和の定義（添字 1..r、r ≥ 1）が覆わないので名前の根拠のまま残した。式・主張は変えていない。",
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
        "を得る。ここで ",
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
        math(String.raw`\theta \in \mathbb{R}`),
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
        "）。ここまでに用いるのは (A)〜(D)、交換子の双線型性、",
        math(String.raw`\exp(i\theta)\exp(-i\theta) = 1`),
        " と行列の計算だけである。",
        "最後に ",
        math(String.raw`V^{(+)}`),
        " が可逆であること（",
        ref("V_plus_factors_invertible"),
        "）と、合成で定めた ",
        math(String.raw`T_{(V^{(+)})}`),
        " が ",
        math(String.raw`V^{(+)}`),
        " による共役 ",
        math(String.raw`X\mapsto V^{(+)}X\left(V^{(+)}\right)^{-1}`),
        " に一致すること（",
        ref("T_V_plus_is_conjugation"),
        "）を使って、",
        math(String.raw`V^{(+)}\check{Z}_\mu\left(V^{(+)}\right)^{-1}, V^{(+)}\check{Y}_\mu\left(V^{(+)}\right)^{-1}`),
        " の表示として述べる（",
        ref("T_V_plus_check_Z_Y_via_B1_B2_B1"),
        "）。",
        "この最後の段で用いるのは、",
        math(String.raw`\left(V_1^{(+)}\right)^{1/2}`),
        " と ",
        math(String.raw`V_2`),
        " の可逆性（",
        ref("V1_plus_half_invertible"),
        "、",
        ref("V2_invertible"),
        "）、可逆な行列の積が可逆であること（",
        ref("def_invertible_elements_of_R"),
        " (ii)）、共役の合成則（",
        ref("conjugation_is_ring_homomorphism"),
        "）、",
        ref("def_V_plus"),
        "・",
        ref("def_T_V_plus"),
        "・",
        ref("def_T_g"),
        " の定義である。",
        math(String.raw`A(\tilde\theta_\mu)`),
        " の分解 ",
        math(String.raw`A(\tilde\theta_\mu) = B_1(\tilde\theta_\mu) B_2 B_1(\tilde\theta_\mu)`),
        " は ",
        ref("factorization_of_A_theta_general"),
        " による。",
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
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`M`),
        " を ",
        math(String.raw`M_{\mathrm{col}}`),
        " に取った ",
        math(String.raw`R=\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を用いる。",
        ref("def_V1_plus_square_root"),
        " で定めた ",
        math(String.raw`\left(V_1^{(+)}\right)^{1/2}\in R`),
        " は可逆である。すなわち ",
        math(String.raw`\left(V_1^{(+)}\right)^{1/2}\in R^\times`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`X:=\bigl(\tfrac{i}{2}(K_1)_{\mathbb{C}}\bigr)H_1^{(+)}\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "（",
        math(String.raw`(K_1)_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " による ",
        math(String.raw`K_1\in\mathbb{R}_{>0}`),
        " の像、",
        math(String.raw`\tfrac{i}{2}(K_1)_{\mathbb{C}}\in\mathbb{C}`),
        " によるスカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "。",
        ref("def_V1_plus_square_root"),
        " が ",
        math(String.raw`\mathbb{R}_{>0}\subset\mathbb{C}`),
        " と書いて掛けている ",
        math(String.raw`K_1`),
        " はこの像である）、",
        math(String.raw`h:=\exp(-X)\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "（",
        math(String.raw`-X`),
        " は ",
        ref("def_matrix_negation"),
        "、",
        math(String.raw`\exp`),
        " は ",
        ref("def_exp"),
        "）と置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(V_1^{(+)}\right)^{1/2}h
&=\left(V_1^{(+)}\right)^{1/2}\exp(-X)
&&(\because\ h\ \text{の置き方})\\
&=\exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\exp(-X)
&&\bigl(\because\ \blkref{def_V1_plus_square_root}\bigr)\\
&=\exp(X)\exp(-X)
&&\bigl(\because\ X\ \text{の置き方}\ (K_1\ \text{は}\ \blkref{inclusion_rr_to_cc}\ \text{の}\ (K_1)_{\mathbb{C}})\bigr)\\
&=\exp(-(-X))\exp(-X)
&&\bigl(\because\ \blkref{matrix_double_negation}\ (m\to 2^{M_{\mathrm{col}}},\ n\to 2^{M_{\mathrm{col}}},\ A\to X)\bigr)\\
&=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&\bigl(\because\ \blkref{exp_of_negative_is_left_inverse}\ (n\to 2^{M_{\mathrm{col}}},\ A\to -X)\bigr),\\[2mm]
h\left(V_1^{(+)}\right)^{1/2}
&=\exp(-X)\left(V_1^{(+)}\right)^{1/2}
&&(\because\ h\ \text{の置き方})\\
&=\exp(-X)\exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)
&&\bigl(\because\ \blkref{def_V1_plus_square_root}\bigr)\\
&=\exp(-X)\exp(X)
&&\bigl(\because\ X\ \text{の置き方}\ (K_1\ \text{は}\ \blkref{inclusion_rr_to_cc}\ \text{の}\ (K_1)_{\mathbb{C}})\bigr)\\
&=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&\bigl(\because\ \blkref{exp_of_negative_is_left_inverse}\ (n\to 2^{M_{\mathrm{col}}},\ A\to X)\bigr)
\end{aligned}`),
      displayMath(String.raw`\left(V_1^{(+)}\right)^{1/2}\in R^\times
\qquad\bigl(\because\ \text{上の二つの積},\ \blkref{def_invertible_elements_of_R}\ (M\to M_{\mathrm{col}},\ g\to \left(V_1^{(+)}\right)^{1/2},\ h\to \exp(-X))\bigr)`),
    ],
    conversion: { status: "added" },
  },
  {
    id: "evensectorT_claim_V2_invertible",
    kind: "claim",
    origin: { path: "structured-latex/content/014_even_sector_T_action.ts", ordinal: 3 },
    title: { tex: String.raw`V_2 \text{ の可逆性と逆元}` },
    labels: ["V2_invertible"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とし、",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`M`),
        " を ",
        math(String.raw`M_{\mathrm{col}}`),
        " に取った ",
        math(String.raw`R=\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を用いる。",
        ref("def_transfer_matrix_symbols"),
        " で定めた ",
        math(String.raw`V_2\in R`),
        " と ",
        math(String.raw`K_2^*\in\mathbb{R}_{>0}`),
        "、",
        ref("def_H2"),
        " の ",
        math(String.raw`H_2\in R`),
        "、",
        ref("def_second_transfer_matrix_prefactor"),
        " の ",
        math(String.raw`a:=(2s_2)^{M_{\mathrm{col}}/2}\in\mathbb{R}_{>0}`),
        "（",
        math(String.raw`s_2`),
        " は ",
        ref("def_indexed_hyperbolic_abbreviations"),
        "）",
        " とその逆数 ",
        math(String.raw`a^{-1}\in\mathbb{R}`),
        " を用い、",
        math(String.raw`(K_2^*)_{\mathbb{C}}, (a^{-1})_{\mathbb{C}}\in\mathbb{C}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " による像、",
        math(String.raw`Y:=\bigl(i(K_2^*)_{\mathbb{C}}\bigr)H_2\in R`),
        "（スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "、",
        math(String.raw`-Y`),
        " は ",
        ref("def_matrix_negation"),
        "、",
        math(String.raw`\exp`),
        " は ",
        ref("def_exp"),
        "）とする。",
        math(String.raw`V_2`),
        " は可逆であり、その逆元は",
      ]),
      displayMath(String.raw`V_2\in R^\times,\qquad V_2^{-1}=(a^{-1})_{\mathbb{C}}\exp(-Y)`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        "主張の ",
        math(String.raw`Y`),
        " を使う（",
        ref("V2_exponential_representation"),
        " が ",
        math(String.raw`\mathbb{R}_{>0}\subset\mathbb{C}`),
        " と書いて掛けている ",
        math(String.raw`K_2^*`),
        " と係数 ",
        math(String.raw`(2s_2)^{M_{\mathrm{col}}/2}`),
        " は、それぞれ ",
        math(String.raw`(K_2^*)_{\mathbb{C}}`),
        " と下の ",
        math(String.raw`a_{\mathbb{C}}`),
        " である）。主張の ",
        math(String.raw`a`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
a
&=(2\sinh 2K_2)^{M_{\mathrm{col}}/2}
&&\bigl(\because\ \blkref{def_indexed_hyperbolic_abbreviations}\ \text{の}\ s_2=\sinh 2K_2\bigr)\\
&\in\mathbb{R}_{>0}
&&\bigl(\because\ \blkref{def_second_transfer_matrix_prefactor}\bigr)
\end{aligned}`),
      paragraph([
        "なので ",
        math(String.raw`a\neq 0`),
        " であり、",
        math(String.raw`\mathbb{R}`),
        " の逆数 ",
        math(String.raw`a^{-1}\in\mathbb{R}`),
        " がある（",
        math(String.raw`\mathbb{R}`),
        " が現れるのは、",
        math(String.raw`\sinh`),
        " が実数の ",
        math(String.raw`\exp`),
        " の値で、",
        math(String.raw`(2\sinh 2K_2)^{M_{\mathrm{col}}/2}`),
        " が正の実数の平方根の冪だからである）。",
        ref("def_matrix_scalar_multiple"),
        " のスカラー倍は係数を ",
        math(String.raw`\mathbb{C}`),
        " に取るので、実数 ",
        math(String.raw`a`),
        "・",
        math(String.raw`a^{-1}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の ",
        math(String.raw`a_{\mathbb{C}}`),
        "・",
        math(String.raw`(a^{-1})_{\mathbb{C}}`),
        " として掛ける。",
        math(String.raw`h:=(a^{-1})_{\mathbb{C}}\exp(-Y)\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "（",
        math(String.raw`-Y`),
        " は ",
        ref("def_matrix_negation"),
        "）と置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
V_2h
&=V_2\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)
&&(\because\ h\ \text{の置き方})\\
&=\Bigl((2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(iK_2^*H_2\right)\Bigr)\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)
&&\bigl(\because\ \blkref{V2_exponential_representation}\bigr)\\
&=\Bigl(a_{\mathbb{C}}\exp\!\left(iK_2^*H_2\right)\Bigr)\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)
&&\bigl(\because\ a\ \text{の置き方}\ (\text{係数は}\ \blkref{inclusion_rr_to_cc}\ \text{の}\ a_{\mathbb{C}})\bigr)\\
&=\bigl(a_{\mathbb{C}}\exp(Y)\bigr)\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)
&&\bigl(\because\ Y\ \text{の置き方}\ (K_2^*\ \text{は}\ \blkref{inclusion_rr_to_cc}\ \text{の}\ (K_2^*)_{\mathbb{C}})\bigr)\\
&=a_{\mathbb{C}}\Bigl(\exp(Y)\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)\Bigr)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_left_factor}\bigr)\\
&=a_{\mathbb{C}}\Bigl((a^{-1})_{\mathbb{C}}\bigl(\exp(Y)\exp(-Y)\bigr)\Bigr)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_right_factor}\bigr)\\
&=\bigl(a_{\mathbb{C}}(a^{-1})_{\mathbb{C}}\bigr)\bigl(\exp(Y)\exp(-Y)\bigr)
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&=(aa^{-1})_{\mathbb{C}}\bigl(\exp(Y)\exp(-Y)\bigr)
&&\bigl(\because\ \blkref{real_inclusion_preserves_product}\ (a\to a,\ b\to a^{-1})\bigr)\\
&=(1)_{\mathbb{C}}\bigl(\exp(Y)\exp(-Y)\bigr)
&&(\because\ \mathbb{R}\ \text{で}\ aa^{-1}=1)\\
&=1_{\mathbb{C}}\bigl(\exp(Y)\exp(-Y)\bigr)
&&\bigl(\because\ 1_{\mathbb{C}}\ \text{は}\ \blkref{inclusion_rr_to_cc}\ \text{の略記}\ r_{\mathbb{C}}\ \text{の}\ r=1\bigr)\\
&=\exp(Y)\exp(-Y)
&&\bigl(\because\ \blkref{scalar_multiple_by_one}\bigr)\\
&=\exp(-(-Y))\exp(-Y)
&&\bigl(\because\ \blkref{matrix_double_negation}\ (m\to 2^{M_{\mathrm{col}}},\ n\to 2^{M_{\mathrm{col}}},\ A\to Y)\bigr)\\
&=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&\bigl(\because\ \blkref{exp_of_negative_is_left_inverse}\ (n\to 2^{M_{\mathrm{col}}},\ A\to -Y)\bigr),\\[2mm]
hV_2
&=\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)V_2
&&(\because\ h\ \text{の置き方})\\
&=\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)\Bigl((2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(iK_2^*H_2\right)\Bigr)
&&\bigl(\because\ \blkref{V2_exponential_representation}\bigr)\\
&=\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)\Bigl(a_{\mathbb{C}}\exp\!\left(iK_2^*H_2\right)\Bigr)
&&\bigl(\because\ a\ \text{の置き方}\ (\text{係数は}\ \blkref{inclusion_rr_to_cc}\ \text{の}\ a_{\mathbb{C}})\bigr)\\
&=\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)\bigl(a_{\mathbb{C}}\exp(Y)\bigr)
&&\bigl(\because\ Y\ \text{の置き方}\ (K_2^*\ \text{は}\ \blkref{inclusion_rr_to_cc}\ \text{の}\ (K_2^*)_{\mathbb{C}})\bigr)\\
&=(a^{-1})_{\mathbb{C}}\Bigl(\exp(-Y)\bigl(a_{\mathbb{C}}\exp(Y)\bigr)\Bigr)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_left_factor}\bigr)\\
&=(a^{-1})_{\mathbb{C}}\Bigl(a_{\mathbb{C}}\bigl(\exp(-Y)\exp(Y)\bigr)\Bigr)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_right_factor}\bigr)\\
&=\bigl((a^{-1})_{\mathbb{C}}a_{\mathbb{C}}\bigr)\bigl(\exp(-Y)\exp(Y)\bigr)
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&=(a^{-1}a)_{\mathbb{C}}\bigl(\exp(-Y)\exp(Y)\bigr)
&&\bigl(\because\ \blkref{real_inclusion_preserves_product}\ (a\to a^{-1},\ b\to a)\bigr)\\
&=(1)_{\mathbb{C}}\bigl(\exp(-Y)\exp(Y)\bigr)
&&(\because\ \mathbb{R}\ \text{で}\ a^{-1}a=1)\\
&=1_{\mathbb{C}}\bigl(\exp(-Y)\exp(Y)\bigr)
&&\bigl(\because\ 1_{\mathbb{C}}\ \text{は}\ \blkref{inclusion_rr_to_cc}\ \text{の略記}\ r_{\mathbb{C}}\ \text{の}\ r=1\bigr)\\
&=\exp(-Y)\exp(Y)
&&\bigl(\because\ \blkref{scalar_multiple_by_one}\bigr)\\
&=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&\bigl(\because\ \blkref{exp_of_negative_is_left_inverse}\ (n\to 2^{M_{\mathrm{col}}},\ A\to Y)\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
&V_2\in R^\times
&&\bigl(\because\ \text{上の二つの積},\ \blkref{def_invertible_elements_of_R}\ \text{の可逆の定義}\ (M\to M_{\mathrm{col}},\ g\to V_2,\ h\to (a^{-1})_{\mathbb{C}}\exp(-Y))\bigr)\\
&V_2^{-1}=(a^{-1})_{\mathbb{C}}\exp(-Y)
&&\bigl(\because\ \text{上の二つの積},\ \blkref{def_invertible_elements_of_R}\ \text{の逆元の一意性と記号}\ g^{-1}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02（全証明の SageMath 検算。T_actions_on_check_Z_Y の検算）: T_{V_2} の計算で V_2^{-1} の形が要るので、証明の中で置いていた a・Y・h を主張へ上げ、逆元が (a^{-1})_C exp(-Y) であることを主張に書いた（証明の二つの鎖は不変）。",
      ],
    },
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
    id: "evensectorT_claim_V_plus_factors_invertible",
    kind: "claim",
    origin: { path: "structured-latex/content/014_even_sector_T_action.ts", ordinal: 3 },
    title: { tex: String.raw`V^{(+)} \text{ の可逆性}` },
    labels: ["V_plus_factors_invertible"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`M`),
        " を ",
        math(String.raw`M_{\mathrm{col}}`),
        " に取った ",
        math(String.raw`R=\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を用いる。",
        ref("def_V_plus"),
        " で定めた ",
        math(String.raw`V^{(+)}\in R`),
        " は可逆である。すなわち ",
        math(String.raw`V^{(+)}\in R^\times`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`B:=\left(V_1^{(+)}\right)^{1/2}\in R`),
        "（",
        ref("def_V1_plus_square_root"),
        "）と置く。",
      ]),
      displayMath(String.raw`BV_2\in R^\times
\qquad\bigl(\because\ \blkref{V1_plus_half_invertible},\ \blkref{V2_invertible},\ \blkref{def_invertible_elements_of_R}\text{ (ii)}\ (g_1\to B,\ g_2\to V_2)\bigr)`),
      displayMath(String.raw`\begin{aligned}
V^{(+)}
&=(BV_2)B
&&\bigl(\because\ \blkref{def_V_plus}\bigr)\\
&\in R^\times
&&\bigl(\because\ \text{前の式の}\ BV_2\in R^\times,\ \blkref{V1_plus_half_invertible},\ \blkref{def_invertible_elements_of_R}\text{ (ii)}\ (g_1\to BV_2,\ g_2\to B)\bigr)
\end{aligned}`),
    ],
    conversion: { status: "added" },
  },
  {
    id: "evensectorT_claim_T_V_plus_is_conjugation",
    kind: "claim",
    origin: { path: "structured-latex/content/014_even_sector_T_action.ts", ordinal: 3 },
    title: { tex: String.raw`T_{(V^{(+)})} = T_{V^{(+)}}` },
    labels: ["T_V_plus_is_conjugation"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 2}`),
        " とし、",
        math(String.raw`R:=\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " と書く（",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`M`),
        " を ",
        math(String.raw`M_{\mathrm{col}}`),
        " に取ったもの）。",
        ref("def_T_V_plus"),
        " で合成として定めた写像 ",
        math(String.raw`T_{(V^{(+)})}:R\to R`),
        " は、",
        ref("def_V_plus"),
        " の ",
        math(String.raw`V^{(+)}`),
        "（",
        ref("V_plus_factors_invertible"),
        " により ",
        math(String.raw`V^{(+)}\in R^\times`),
        "）による ",
        ref("def_T_g"),
        " の共役 ",
        math(String.raw`T_{V^{(+)}}:R\to R`),
        " に、写像として一致する。",
      ]),
      displayMath(String.raw`T_{(V^{(+)})} = T_{V^{(+)}}`),
    ],
    proof: [
      paragraph([
        math(String.raw`S:=\left(V_1^{(+)}\right)^{1/2}\in R`),
        "（",
        ref("def_V1_plus_square_root"),
        "）と書く。四つの行列の可逆性を先に並べる。",
      ]),
      displayMath(String.raw`\begin{aligned}
&S\in R^\times
&&\bigl(\because\ \blkref{V1_plus_half_invertible}\bigr)\\
&V_2\in R^\times
&&\bigl(\because\ \blkref{V2_invertible}\bigr)\\
&SV_2\in R^\times
&&\bigl(\because\ \blkref{def_invertible_elements_of_R}\text{ (ii)}\ (g_1\to S,\ g_2\to V_2)\bigr)\\
&V^{(+)}\in R^\times
&&\bigl(\because\ \blkref{V_plus_factors_invertible}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`g\in R^\times`),
        " について、",
        ref("mat_conj"),
        " の ",
        math(String.raw`n`),
        " を ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        "、その変数 ",
        math(String.raw`B`),
        " を ",
        math(String.raw`g`),
        " に取った写像を ",
        math(String.raw`T'_g:R\to R`),
        "、",
        math(String.raw`T'_g(X):=(gX)g^{-1}`),
        " と書く（",
        ref("mat_conj"),
        " の ",
        math(String.raw`T_B`),
        " と ",
        ref("def_T_g"),
        " の ",
        math(String.raw`T_g`),
        " を記号で区別するため）。",
        math(String.raw`g^{-1}`),
        " は ",
        ref("def_invertible_elements_of_R"),
        " の逆元で ",
        math(String.raw`gg^{-1}=I`),
        " かつ ",
        math(String.raw`g^{-1}g=I`),
        " を満たすので、",
        math(String.raw`g`),
        " は ",
        ref("conjugation_is_ring_homomorphism"),
        " の意味で正則であり、",
        math(String.raw`g^{-1}`),
        " はそこでの逆行列でもある。",
        ref("def_T_g"),
        " の ",
        math(String.raw`g\cdot h\cdot g^{-1}`),
        " は ",
        math(String.raw`(gh)g^{-1}`),
        " と読む（",
        ref("linearity_of_T"),
        " の証明と同じ読み方）。任意の ",
        math(String.raw`X\in R`),
        " について、",
      ]),
      displayMath(String.raw`\begin{aligned}
T_g(X)
&=(gX)g^{-1}
&&\bigl(\because\ \blkref{def_T_g}\bigr)\\
&=T'_g(X)
&&\bigl(\because\ T'_g\text{ の定め方}\bigr)
\end{aligned}`),
      paragraph([
        "である（以下、これを ",
        math(String.raw`T_g=T'_g`),
        " と書いて、",
        math(String.raw`X`),
        " 以外の値へも当てる）。",
        math(String.raw`X\in R`),
        " を任意に取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
T_{(V^{(+)})}(X)
&=T_{S}\Bigl(T_{V_2}\bigl(T_{S}(X)\bigr)\Bigr)
&&\bigl(\because\ \blkref{def_T_V_plus}\bigr)\\
&=T'_{S}\Bigl(T'_{V_2}\bigl(T'_{S}(X)\bigr)\Bigr)
&&\bigl(\because\ \text{準備の }T_g=T'_g\text{ を }g\to S,\ V_2,\ S\text{ の 3 か所へ同時適用}\bigr)\\
&=\bigl(T'_{S}\circ T'_{V_2}\bigr)\bigl(T'_{S}(X)\bigr)
&&\bigl(\because\ \text{写像の合成の定義}\bigr)\\
&=T'_{SV_2}\bigl(T'_{S}(X)\bigr)
&&\bigl(\because\ \blkref{conjugation_is_ring_homomorphism}\text{ の合成則}\ (n\to 2^{M_{\mathrm{col}}},\ G\to S,\ H\to V_2)\bigr)\\
&=\bigl(T'_{SV_2}\circ T'_{S}\bigr)(X)
&&\bigl(\because\ \text{写像の合成の定義}\bigr)\\
&=T'_{(SV_2)S}(X)
&&\bigl(\because\ \blkref{conjugation_is_ring_homomorphism}\text{ の合成則}\ (n\to 2^{M_{\mathrm{col}}},\ G\to SV_2,\ H\to S)\bigr)\\
&=T'_{V^{(+)}}(X)
&&\bigl(\because\ \blkref{def_V_plus}\text{ の }V^{(+)}:=(SV_2)S\bigr)\\
&=T_{V^{(+)}}(X)
&&\bigl(\because\ \text{準備の }T_g=T'_g\text{ を }g\to V^{(+)}\text{ に}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`X\in R`),
        " は任意だったので、二つの写像 ",
        math(String.raw`T_{(V^{(+)})},\,T_{V^{(+)}}:R\to R`),
        " は全ての値が一致し、写像として等しい。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧 008 章のうち参照用ノート notes/integer_momentum_route_not_adopted.ts に退避した def_T_V は、T_{(V)} を (V_1^{(±)})^{1/2}, V_2 の共役の合成として定義し、同じノートの why_008_applies_only_to_minus_sector のとおりその V は実質 (-) 専用である。混同しないよう、本文では V^{(+)}（射影の章の def_V_plus）による T_{(V^{(+)})} を def_T_V_plus として、def_T_V を参照せずに定義している。",
        "旧 008 章は (V_1^{(±)})^{1/2} を「exp(iK_1H_1^{(±)}) の 1/2 乗」と書いたうえで proof の中で exp((1/2)iK_1H_1^{(±)}) と読み替えていた（参照用ノート notes/integer_momentum_route_not_adopted.ts の note_evensectorT_005_claim_T_actions_integer_route_TV1_hatZ_hatY_012_claim_TV1_TV2_actions へ退避した TV1_hatZ_hatY_012_claim_TV1_TV2_actions の proof）。本文では最初から exp((i/2)K_1H_1^{(+)}) を定義 def_V1_plus_square_root とし、それが V_1^{(+)} の平方根であることを V1_plus_square_root_property（最大固有値に属する固有ベクトルの章）で示した（読み替えを暗黙にしない）。",
        "T_{(V^{(+)})} = T_{V^{(+)}}（合成が積による共役に一致すること）は数値でも確認済み（sagemath/check/047_claim_even_sector_T_action/check_04, 「合成=共役」列）。",
        "2026-11-02: 全証明の SageMath 検算（sagemath/check/T_V_plus_is_conjugation/）を付けるにあたり、証明を値の一続きの鎖にした。可逆性の散文を準備の 4 行に、合成則の当てはめと末尾の合成の順序の散文を写像の合成の定義を挟んだ鎖にした。conjugation_is_ring_homomorphism の合成則は mat_conj の T_B についての主張なので、def_T_g の T_g と記号を分けて T'_g と書き（証明の中の (V_1^{(+)})^{1/2} は mat_conj の変数 B と重ならないよう S と書く）、T_g(X) = (gX)g^{-1} = T'_g(X) を準備に置いた。主張に M_col と R を書き、写像としての等号であることを明記した（主張の中身は不変）。",
      ],
    },
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
        " とし、",
        math(String.raw`\tilde\theta := \tilde\theta_\mu \in \mathbb{R}`),
        "（",
        ref("antiperiodic_exp_sum"),
        "）と略記し、",
        math(String.raw`(\tilde\theta)_{\mathbb{C}} \in \mathbb{C}`),
        " をその ",
        ref("inclusion_rr_to_cc"),
        " による像とする。",
        math(String.raw`R := \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " とし、",
        math(String.raw`H_1^{(+)}, H_2, \check{Z}_\mu, \check{Y}_\mu \in R`),
        " は ",
        ref("def_H1_plus"),
        "・",
        ref("def_H2"),
        "・",
        ref("def_half_integer_checkZ"),
        "・",
        ref("def_half_integer_checkY"),
        " のもの、",
        math(String.raw`K_1, K_2^* \in \mathbb{R}`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " のスカラー、",
        math(String.raw`(K_1)_{\mathbb{C}}, (K_2^*)_{\mathbb{C}} \in \mathbb{C}`),
        " はそれらの ",
        ref("inclusion_rr_to_cc"),
        " による像である。",
        math(String.raw`(K_1)_{\mathbb{C}} H_1^{(+)}`),
        " などはスカラー倍（",
        ref("def_matrix_scalar_multiple"),
        "）である。交換子 ",
        math(String.raw`[X, W] := XW - WX`),
        " と、その反復 ",
        math(String.raw`\mathrm{ad}^{n}_X`),
        "（",
        math(String.raw`\mathrm{ad}^{0}_X(W) = W`),
        "、",
        math(String.raw`\mathrm{ad}^{m+1}_X(W) = [X, \mathrm{ad}^{m}_X(W)]`),
        "）は ",
        ref("def_ad_X_matrix"),
        " のもので、",
        math(String.raw`X, W \in R`),
        " について",
      ]),
      displayMath(
        String.raw`\underbrace{[X,\dots,[X, W]\dots]}_{n} := \mathrm{ad}^{n}_X(W)`,
      ),
      paragraph([
        "と書く。右辺の係数は ",
        math(String.raw`\mathbb{C}`),
        " の元であり、係数に現れる ",
        math(String.raw`2`),
        " は ",
        math(String.raw`2_{\mathbb{C}} := (2_{\mathbb{R}})_{\mathbb{C}}`),
        "（",
        ref("inclusion_rr_to_cc"),
        "）を表す。",
        math(String.raw`n`),
        " が偶数なら ",
        math(String.raw`n/2 \in \mathbb{Z}_{\geq 0}`),
        "、奇数なら ",
        math(String.raw`(n-1)/2, (n+1)/2 \in \mathbb{Z}_{\geq 0}`),
        " であり、",
        math(String.raw`-1 \in \mathbb{C}`),
        " の冪と ",
        math(String.raw`\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}`),
        " などの冪は ",
        ref("scalar_exp_is_limit_of_partial_sums"),
        " の約束 ",
        math(String.raw`x^{0} := 1`),
        "、",
        math(String.raw`x^{m+1} := x^{m}x`),
        " による。係数と行列の積はスカラー倍である。このとき次が成り立つ。",
      ]),
      paragraph(["(h1.z)"]),
      displayMath(
        String.raw`\underbrace{\left[(K_1)_{\mathbb{C}} H_1^{(+)}, \dots, \left[(K_1)_{\mathbb{C}} H_1^{(+)}, \check{Z}_\mu\right]\dots\right]}_{n}
= \begin{cases}
\bigl((-1)^{(n-1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^n \exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Y}_\mu & (n \text{ 奇数}) \\
\bigl((-1)^{n/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^n\bigr)\check{Z}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h1.y)"]),
      displayMath(
        String.raw`\underbrace{\left[(K_1)_{\mathbb{C}} H_1^{(+)}, \dots, \left[(K_1)_{\mathbb{C}} H_1^{(+)}, \check{Y}_\mu\right]\dots\right]}_{n}
= \begin{cases}
\bigl((-1)^{(n+1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^n \exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Z}_\mu & (n \text{ 奇数}) \\
\bigl((-1)^{n/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^n\bigr)\check{Y}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h2.z)"]),
      displayMath(
        String.raw`\underbrace{\left[(K_2^*)_{\mathbb{C}} H_2, \dots, \left[(K_2^*)_{\mathbb{C}} H_2, \check{Z}_\mu\right]\dots\right]}_{n}
= \begin{cases}
\bigl((-1)^{(n+1)/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^n\bigr)\check{Y}_\mu & (n \text{ 奇数}) \\
\bigl((-1)^{n/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^n\bigr)\check{Z}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h2.y)"]),
      displayMath(
        String.raw`\underbrace{\left[(K_2^*)_{\mathbb{C}} H_2, \dots, \left[(K_2^*)_{\mathbb{C}} H_2, \check{Y}_\mu\right]\dots\right]}_{n}
= \begin{cases}
\bigl((-1)^{(n-1)/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^n\bigr)\check{Z}_\mu & (n \text{ 奇数}) \\
\bigl((-1)^{n/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^n\bigr)\check{Y}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
    ],
    proof: [
      paragraph([
        "準備（前提の読み方）。",
        ref("commutator_of_H_and_check_Z_Y"),
        " の (A)〜(D) の右辺の ",
        math(String.raw`\exp(\mp i\tilde\theta_\mu)`),
        " は ",
        ref("def_half_integer_checkZ"),
        " の位相と同じく ",
        math(String.raw`\exp\bigl(\mp i(\tilde\theta)_{\mathbb{C}}\bigr) \in \mathbb{C}`),
        " を表し、右辺は係数を一つの複素数にまとめたスカラー倍 ",
        math(String.raw`\bigl(2\exp(-i(\tilde\theta)_{\mathbb{C}})\bigr)\check{Y}_\mu`),
        "・",
        math(String.raw`\bigl(-2\exp(i(\tilde\theta)_{\mathbb{C}})\bigr)\check{Z}_\mu`),
        "・",
        math(String.raw`(-2)\check{Y}_\mu`),
        "・",
        math(String.raw`(2)\check{Z}_\mu`),
        " である。この右辺の ",
        math(String.raw`-2`),
        " は ",
        math(String.raw`2 = 2_{\mathbb{C}}`),
        " の符号反転 ",
        math(String.raw`-(2_{\mathbb{C}})`),
        "（",
        ref("multiply_by_minus_one"),
        "）を表す。主張と証明の ",
        math(String.raw`-1 \in \mathbb{C}`),
        " は ",
        math(String.raw`-1_{\mathbb{C}} := (-1)_{\mathbb{C}}`),
        "（",
        ref("inclusion_rr_to_cc"),
        " による ",
        math(String.raw`-1 \in \mathbb{R}`),
        " の像。",
        ref("multiply_by_minus_one"),
        " の ",
        math(String.raw`-1_{\mathbb{C}}`),
        "）を表す。括弧の無い 3 つ以上の複素数の積は、左から順に掛けたもの（",
        math(String.raw`xyz := (xy)z`),
        "）を表す。",
      ]),
      paragraph([
        "準備（位相の積）。",
        math(String.raw`-i(\tilde\theta)_{\mathbb{C}}`),
        " は ",
        ref("def_half_integer_checkZ"),
        " と同じく ",
        math(String.raw`(-i)(\tilde\theta)_{\mathbb{C}}`),
        "（",
        math(String.raw`-i := (-1_{\mathbb C})\,i`),
        "）と読む。",
      ]),
      displayMath(String.raw`\begin{aligned}
\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)
&= \exp\bigl(-i(\tilde\theta)_{\mathbb{C}} + i(\tilde\theta)_{\mathbb{C}}\bigr)
&&\bigl(\because\ \blkref{scalar_exp_product}\text{ を }K = \mathbb{C}\text{ で}\bigr)\\
&= \exp\bigl(-(i(\tilde\theta)_{\mathbb{C}}) + i(\tilde\theta)_{\mathbb{C}}\bigr)
&&\bigl(\because\ \blkref{negative_i_times_complex_is_negation_of_i_times}\ (z \to (\tilde\theta)_{\mathbb{C}})\bigr)\\
&= \exp(0_{\mathbb{C}})
&&\bigl(\because\ \blkref{negation_plus_self_is_zero_in_cc}\ (x \to i(\tilde\theta)_{\mathbb{C}})\bigr)\\
&= 1_{\mathbb{C}}
&&\bigl(\because\ \blkref{scalar_exp_zero}\text{ を }K = \mathbb{C}\text{ で}\bigr)
\end{aligned}`),
      paragraph(["(h1.z) の証明。", math(String.raw`C_n := \underbrace{\left[(K_1)_{\mathbb{C}} H_1^{(+)},\dots,\left[(K_1)_{\mathbb{C}} H_1^{(+)}, \check{Z}_\mu\right]\dots\right]}_{n}\in R`), "（", math(String.raw`n\in\mathbb{Z}_{\geq 0}`), "）とおき、", math(String.raw`n`), " についての帰納法で示す。基底段階（", math(String.raw`n = 0`), "）。"]),
      displayMath(String.raw`\begin{aligned}
C_0
&= \check{Z}_\mu
&&\bigl(\because\ \mathrm{ad}^{0}_X(W) = W\text{。}\blkref{def_ad_X_matrix}\bigr)\\
&= 1_{\mathbb{C}}\,\check{Z}_\mu
&&\bigl(\because\ \blkref{scalar_multiple_by_one}\bigr)\\
&= \bigl(1_{\mathbb{C}}1_{\mathbb{C}}\bigr)\check{Z}_\mu
&&\bigl(\because\ 1_{\mathbb{C}}\text{ は }\mathbb{C}\text{ の積の単位元}\bigr)\\
&= \bigl((-1)^{0}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{0}\bigr)\check{Z}_\mu
&&\bigl(\because\ \text{冪の約束 }x^{0} := 1\text{ を二か所へ。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)
\end{aligned}`),
      paragraph(["帰納段階（", math(String.raw`n`), " が偶数）。", math(String.raw`C_n = \bigl((-1)^{n/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\check{Z}_\mu`), " を仮定する。"]),
      displayMath(String.raw`\begin{aligned}
C_{n+1}
&= \left[(K_1)_{\mathbb{C}} H_1^{(+)},\ C_n\right]
&&\bigl(\because\ \mathrm{ad}^{m+1}_X(W) = [X,\mathrm{ad}^{m}_X(W)]\ \text{の再帰。}\blkref{def_ad_X_matrix}\bigr)\\
&= \left[(K_1)_{\mathbb{C}} H_1^{(+)},\ \bigl((-1)^{n/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\check{Z}_\mu\right]
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \bigl((K_1)_{\mathbb{C}}\bigl((-1)^{n/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\bigr)\left[H_1^{(+)},\ \check{Z}_\mu\right]
&&\bigl(\because\ \blkref{commutator_of_scalar_multiples}\text{ を }\alpha = (K_1)_{\mathbb{C}},\ \beta = (-1)^{n/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\text{ で}\bigr)\\
&= \bigl((K_1)_{\mathbb{C}}\bigl((-1)^{n/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\bigr)\bigl(\bigl(2\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Y}_\mu\bigr)
&&\bigl(\because\ \blkref{commutator_of_H_and_check_Z_Y}\text{ の }(A)\text{（準備の読み方で）}\bigr)\\
&= \bigl((K_1)_{\mathbb{C}}\bigl((-1)^{n/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\bigl(2\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\check{Y}_\mu
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&= \bigl(\bigl(\bigl((K_1)_{\mathbb{C}}\bigl((-1)^{n/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\bigr)2\bigr)\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Y}_\mu
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の結合律を右辺から左辺へ}\bigr)\\
&= \bigl(\bigl(2\bigl((K_1)_{\mathbb{C}}\bigl((-1)^{n/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\bigr)\bigr)\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Y}_\mu
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の可換律}\bigr)\\
&= \bigl(\bigl(\bigl(2(K_1)_{\mathbb{C}}\bigr)\bigl((-1)^{n/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\bigr)\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Y}_\mu
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の結合律を右辺から左辺へ}\bigr)\\
&= \bigl(\bigl(\bigl((-1)^{n/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\bigl(2(K_1)_{\mathbb{C}}\bigr)\bigr)\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Y}_\mu
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の可換律}\bigr)\\
&= \bigl(\bigl((-1)^{n/2}\bigl(\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigl(2(K_1)_{\mathbb{C}}\bigr)\bigr)\bigr)\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Y}_\mu
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の結合律}\bigr)\\
&= \bigl((-1)^{n/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n+1}\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Y}_\mu
&&\bigl(\because\ \text{冪の約束 }x^{m+1} := x^{m}x\text{。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)\\
&= \bigl((-1)^{((n+1)-1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n+1}\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Y}_\mu
&&\bigl(\because\ \tfrac{n}{2} = \tfrac{(n+1)-1}{2}\bigr)
\end{aligned}`),
      paragraph(["帰納段階（", math(String.raw`n`), " が奇数）。", math(String.raw`C_n = \bigl((-1)^{(n-1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Y}_\mu`), " を仮定する。"]),
      displayMath(String.raw`\begin{aligned}
C_{n+1}
&= \left[(K_1)_{\mathbb{C}} H_1^{(+)},\ C_n\right]
&&\bigl(\because\ \mathrm{ad}^{m+1}_X(W) = [X,\mathrm{ad}^{m}_X(W)]\ \text{の再帰。}\blkref{def_ad_X_matrix}\bigr)\\
&= \left[(K_1)_{\mathbb{C}} H_1^{(+)},\ \bigl((-1)^{(n-1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Y}_\mu\right]
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \bigl((K_1)_{\mathbb{C}}\bigl((-1)^{(n-1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\left[H_1^{(+)},\ \check{Y}_\mu\right]
&&\bigl(\because\ \blkref{commutator_of_scalar_multiples}\text{ を }\alpha = (K_1)_{\mathbb{C}},\ \beta = (-1)^{(n-1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\text{ で}\bigr)\\
&= \bigl((K_1)_{\mathbb{C}}\bigl((-1)^{(n-1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\bigl(\bigl(-2\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Z}_\mu\bigr)
&&\bigl(\because\ \blkref{commutator_of_H_and_check_Z_Y}\text{ の }(B)\text{（準備の読み方で）}\bigr)\\
&= \bigl((K_1)_{\mathbb{C}}\bigl((-1)^{(n-1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigl(-2\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&= \bigl(\bigl((K_1)_{\mathbb{C}}\bigl(\bigl((-1)^{(n-1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\bigl(\bigl((-1)2\bigr)\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \blkref{multiply_by_minus_one}\ (z \to 2)\text{。準備の読み方で}\bigr)\\
&= \bigl(\bigl(\bigl((K_1)_{\mathbb{C}}\bigl(\bigl((-1)^{(n-1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\bigl((-1)2\bigr)\bigr)\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の結合律を右辺から左辺へ}\bigr)\\
&= \bigl(\bigl(\bigl((-1)2\bigr)\bigl((K_1)_{\mathbb{C}}\bigl(\bigl((-1)^{(n-1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\bigr)\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の可換律}\bigr)\\
&= \bigl(\bigl((-1)\bigl(2\bigl((K_1)_{\mathbb{C}}\bigl(\bigl((-1)^{(n-1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\bigr)\bigr)\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の結合律}\bigr)\\
&= \bigl(\bigl((-1)\bigl(\bigl(2(K_1)_{\mathbb{C}}\bigr)\bigl(\bigl((-1)^{(n-1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\bigr)\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の結合律を右辺から左辺へ}\bigr)\\
&= \bigl(\bigl((-1)\bigl(\bigl(\bigl(2(K_1)_{\mathbb{C}}\bigr)\bigl((-1)^{(n-1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\bigr)\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の結合律を右辺から左辺へ}\bigr)\\
&= \bigl(\bigl(\bigl((-1)\bigl(\bigl(2(K_1)_{\mathbb{C}}\bigr)\bigl((-1)^{(n-1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\bigr)\bigr)\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の結合律を右辺から左辺へ}\bigr)\\
&= \bigl(\bigl((-1)\bigl(\bigl(2(K_1)_{\mathbb{C}}\bigr)\bigl((-1)^{(n-1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\bigr)\bigr)\bigl(\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の結合律}\bigr)\\
&= \bigl(\bigl((-1)\bigl(\bigl((-1)^{(n-1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\bigl(2(K_1)_{\mathbb{C}}\bigr)\bigr)\bigr)\bigl(\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の可換律}\bigr)\\
&= \bigl(\bigl((-1)\bigl((-1)^{(n-1)/2}\bigl(\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigl(2(K_1)_{\mathbb{C}}\bigr)\bigr)\bigr)\bigr)\bigl(\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の結合律}\bigr)\\
&= \bigl(\bigl(\bigl((-1)(-1)^{(n-1)/2}\bigr)\bigl(\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigl(2(K_1)_{\mathbb{C}}\bigr)\bigr)\bigr)\bigl(\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の結合律を右辺から左辺へ}\bigr)\\
&= \bigl(\bigl(\bigl((-1)^{(n-1)/2}(-1)\bigr)\bigl(\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigl(2(K_1)_{\mathbb{C}}\bigr)\bigr)\bigr)\bigl(\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の可換律}\bigr)\\
&= \bigl(\bigl((-1)^{(n-1)/2+1}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n+1}\bigr)\bigl(\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \text{冪の約束 }x^{m+1} := x^{m}x\text{ を }-1\text{ と }2(K_1)_{\mathbb{C}}\text{ の二か所へ。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)\\
&= \bigl(\bigl((-1)^{(n-1)/2+1}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n+1}\bigr)1_{\mathbb{C}}\bigr)\check{Z}_\mu
&&\bigl(\because\ \text{準備の }\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr) = 1_{\mathbb{C}}\bigr)\\
&= \bigl((-1)^{(n-1)/2+1}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n+1}\bigr)\check{Z}_\mu
&&\bigl(\because\ 1_{\mathbb{C}}\text{ は }\mathbb{C}\text{ の積の単位元}\bigr)\\
&= \bigl((-1)^{(n+1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n+1}\bigr)\check{Z}_\mu
&&\bigl(\because\ \tfrac{n-1}{2}+1 = \tfrac{n+1}{2}\bigr)
\end{aligned}`),
      paragraph(["最後の行は、", math(String.raw`n+1`), " の偶奇に応じた主張の右辺である。以上で (h1.z) が成り立つ。"]),
      paragraph(["(h1.y) の証明。", math(String.raw`D_n := \underbrace{\left[(K_1)_{\mathbb{C}} H_1^{(+)},\dots,\left[(K_1)_{\mathbb{C}} H_1^{(+)}, \check{Y}_\mu\right]\dots\right]}_{n}\in R`), "（", math(String.raw`n\in\mathbb{Z}_{\geq 0}`), "）とおき、", math(String.raw`n`), " についての帰納法で示す。基底段階（", math(String.raw`n = 0`), "）。"]),
      displayMath(String.raw`\begin{aligned}
D_0
&= \check{Y}_\mu
&&\bigl(\because\ \mathrm{ad}^{0}_X(W) = W\text{。}\blkref{def_ad_X_matrix}\bigr)\\
&= 1_{\mathbb{C}}\,\check{Y}_\mu
&&\bigl(\because\ \blkref{scalar_multiple_by_one}\bigr)\\
&= \bigl(1_{\mathbb{C}}1_{\mathbb{C}}\bigr)\check{Y}_\mu
&&\bigl(\because\ 1_{\mathbb{C}}\text{ は }\mathbb{C}\text{ の積の単位元}\bigr)\\
&= \bigl((-1)^{0}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{0}\bigr)\check{Y}_\mu
&&\bigl(\because\ \text{冪の約束 }x^{0} := 1\text{ を二か所へ。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)
\end{aligned}`),
      paragraph(["帰納段階（", math(String.raw`n`), " が偶数）。", math(String.raw`D_n = \bigl((-1)^{n/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\check{Y}_\mu`), " を仮定する。"]),
      displayMath(String.raw`\begin{aligned}
D_{n+1}
&= \left[(K_1)_{\mathbb{C}} H_1^{(+)},\ D_n\right]
&&\bigl(\because\ \mathrm{ad}^{m+1}_X(W) = [X,\mathrm{ad}^{m}_X(W)]\ \text{の再帰。}\blkref{def_ad_X_matrix}\bigr)\\
&= \left[(K_1)_{\mathbb{C}} H_1^{(+)},\ \bigl((-1)^{n/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\check{Y}_\mu\right]
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \bigl((K_1)_{\mathbb{C}}\bigl((-1)^{n/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\bigr)\left[H_1^{(+)},\ \check{Y}_\mu\right]
&&\bigl(\because\ \blkref{commutator_of_scalar_multiples}\text{ を }\alpha = (K_1)_{\mathbb{C}},\ \beta = (-1)^{n/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\text{ で}\bigr)\\
&= \bigl((K_1)_{\mathbb{C}}\bigl((-1)^{n/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\bigr)\bigl(\bigl(-2\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Z}_\mu\bigr)
&&\bigl(\because\ \blkref{commutator_of_H_and_check_Z_Y}\text{ の }(B)\text{（準備の読み方で）}\bigr)\\
&= \bigl((K_1)_{\mathbb{C}}\bigl((-1)^{n/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigr)\bigl(-2\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&= \bigl((-1)^{n/2}(-1)\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigl(2(K_1)_{\mathbb{C}}\bigr)\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \mathbb{C}\text{ の四則}\bigr)\\
&= \bigl((-1)^{n/2+1}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n+1}\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \text{冪の約束 }x^{m+1} := x^{m}x\text{ を }-1\text{ と }2(K_1)_{\mathbb{C}}\text{ の二か所へ。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)\\
&= \bigl((-1)^{((n+1)+1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n+1}\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \tfrac{n}{2}+1 = \tfrac{(n+1)+1}{2}\bigr)
\end{aligned}`),
      paragraph(["帰納段階（", math(String.raw`n`), " が奇数）。", math(String.raw`D_n = \bigl((-1)^{(n+1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Z}_\mu`), " を仮定する。"]),
      displayMath(String.raw`\begin{aligned}
D_{n+1}
&= \left[(K_1)_{\mathbb{C}} H_1^{(+)},\ D_n\right]
&&\bigl(\because\ \mathrm{ad}^{m+1}_X(W) = [X,\mathrm{ad}^{m}_X(W)]\ \text{の再帰。}\blkref{def_ad_X_matrix}\bigr)\\
&= \left[(K_1)_{\mathbb{C}} H_1^{(+)},\ \bigl((-1)^{(n+1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Z}_\mu\right]
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \bigl((K_1)_{\mathbb{C}}\bigl((-1)^{(n+1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\left[H_1^{(+)},\ \check{Z}_\mu\right]
&&\bigl(\because\ \blkref{commutator_of_scalar_multiples}\text{ を }\alpha = (K_1)_{\mathbb{C}},\ \beta = (-1)^{(n+1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\text{ で}\bigr)\\
&= \bigl((K_1)_{\mathbb{C}}\bigl((-1)^{(n+1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\bigl(\bigl(2\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Y}_\mu\bigr)
&&\bigl(\because\ \blkref{commutator_of_H_and_check_Z_Y}\text{ の }(A)\text{（準備の読み方で）}\bigr)\\
&= \bigl((K_1)_{\mathbb{C}}\bigl((-1)^{(n+1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigl(2\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\bigr)\check{Y}_\mu
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&= \bigl((-1)^{(n+1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n}\bigl(2(K_1)_{\mathbb{C}}\bigr)\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Y}_\mu
&&\bigl(\because\ \mathbb{C}\text{ の積の可換律と結合律}\bigr)\\
&= \bigl((-1)^{(n+1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n+1}\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Y}_\mu
&&\bigl(\because\ \text{冪の約束 }x^{m+1} := x^{m}x\text{。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)\\
&= \bigl((-1)^{(n+1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n+1}1_{\mathbb{C}}\bigr)\check{Y}_\mu
&&\bigl(\because\ \text{準備の }\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr) = 1_{\mathbb{C}}\bigr)\\
&= \bigl((-1)^{(n+1)/2}\bigl(2(K_1)_{\mathbb{C}}\bigr)^{n+1}\bigr)\check{Y}_\mu
&&\bigl(\because\ 1_{\mathbb{C}}\text{ は }\mathbb{C}\text{ の積の単位元}\bigr)
\end{aligned}`),
      paragraph(["最後の行は、", math(String.raw`n+1`), " の偶奇に応じた主張の右辺である。以上で (h1.y) が成り立つ。"]),
      paragraph(["(h2.z) の証明。", math(String.raw`E_n := \underbrace{\left[(K_2^*)_{\mathbb{C}} H_2,\dots,\left[(K_2^*)_{\mathbb{C}} H_2, \check{Z}_\mu\right]\dots\right]}_{n}\in R`), "（", math(String.raw`n\in\mathbb{Z}_{\geq 0}`), "）とおき、", math(String.raw`n`), " についての帰納法で示す。基底段階（", math(String.raw`n = 0`), "）。"]),
      displayMath(String.raw`\begin{aligned}
E_0
&= \check{Z}_\mu
&&\bigl(\because\ \mathrm{ad}^{0}_X(W) = W\text{。}\blkref{def_ad_X_matrix}\bigr)\\
&= 1_{\mathbb{C}}\,\check{Z}_\mu
&&\bigl(\because\ \blkref{scalar_multiple_by_one}\bigr)\\
&= \bigl(1_{\mathbb{C}}1_{\mathbb{C}}\bigr)\check{Z}_\mu
&&\bigl(\because\ 1_{\mathbb{C}}\text{ は }\mathbb{C}\text{ の積の単位元}\bigr)\\
&= \bigl((-1)^{0}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{0}\bigr)\check{Z}_\mu
&&\bigl(\because\ \text{冪の約束 }x^{0} := 1\text{ を二か所へ。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)
\end{aligned}`),
      paragraph(["帰納段階（", math(String.raw`n`), " が偶数）。", math(String.raw`E_n = \bigl((-1)^{n/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigr)\check{Z}_\mu`), " を仮定する。"]),
      displayMath(String.raw`\begin{aligned}
E_{n+1}
&= \left[(K_2^*)_{\mathbb{C}} H_2,\ E_n\right]
&&\bigl(\because\ \mathrm{ad}^{m+1}_X(W) = [X,\mathrm{ad}^{m}_X(W)]\ \text{の再帰。}\blkref{def_ad_X_matrix}\bigr)\\
&= \left[(K_2^*)_{\mathbb{C}} H_2,\ \bigl((-1)^{n/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigr)\check{Z}_\mu\right]
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \bigl((K_2^*)_{\mathbb{C}}\bigl((-1)^{n/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigr)\bigr)\left[H_2,\ \check{Z}_\mu\right]
&&\bigl(\because\ \blkref{commutator_of_scalar_multiples}\text{ を }\alpha = (K_2^*)_{\mathbb{C}},\ \beta = (-1)^{n/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\text{ で}\bigr)\\
&= \bigl((K_2^*)_{\mathbb{C}}\bigl((-1)^{n/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigr)\bigr)\bigl(\bigl(-2\bigr)\check{Y}_\mu\bigr)
&&\bigl(\because\ \blkref{commutator_of_H_and_check_Z_Y}\text{ の }(C)\text{（準備の読み方で）}\bigr)\\
&= \bigl((K_2^*)_{\mathbb{C}}\bigl((-1)^{n/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigr)\bigl(-2\bigr)\bigr)\check{Y}_\mu
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&= \bigl((-1)^{n/2}(-1)\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)\bigr)\check{Y}_\mu
&&\bigl(\because\ \mathbb{C}\text{ の四則}\bigr)\\
&= \bigl((-1)^{n/2+1}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n+1}\bigr)\check{Y}_\mu
&&\bigl(\because\ \text{冪の約束 }x^{m+1} := x^{m}x\text{ を }-1\text{ と }2(K_2^*)_{\mathbb{C}}\text{ の二か所へ。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)\\
&= \bigl((-1)^{((n+1)+1)/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n+1}\bigr)\check{Y}_\mu
&&\bigl(\because\ \tfrac{n}{2}+1 = \tfrac{(n+1)+1}{2}\bigr)
\end{aligned}`),
      paragraph(["帰納段階（", math(String.raw`n`), " が奇数）。", math(String.raw`E_n = \bigl((-1)^{(n+1)/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigr)\check{Y}_\mu`), " を仮定する。"]),
      displayMath(String.raw`\begin{aligned}
E_{n+1}
&= \left[(K_2^*)_{\mathbb{C}} H_2,\ E_n\right]
&&\bigl(\because\ \mathrm{ad}^{m+1}_X(W) = [X,\mathrm{ad}^{m}_X(W)]\ \text{の再帰。}\blkref{def_ad_X_matrix}\bigr)\\
&= \left[(K_2^*)_{\mathbb{C}} H_2,\ \bigl((-1)^{(n+1)/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigr)\check{Y}_\mu\right]
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \bigl((K_2^*)_{\mathbb{C}}\bigl((-1)^{(n+1)/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigr)\bigr)\left[H_2,\ \check{Y}_\mu\right]
&&\bigl(\because\ \blkref{commutator_of_scalar_multiples}\text{ を }\alpha = (K_2^*)_{\mathbb{C}},\ \beta = (-1)^{(n+1)/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\text{ で}\bigr)\\
&= \bigl((K_2^*)_{\mathbb{C}}\bigl((-1)^{(n+1)/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigr)\bigr)\bigl(\bigl(2\bigr)\check{Z}_\mu\bigr)
&&\bigl(\because\ \blkref{commutator_of_H_and_check_Z_Y}\text{ の }(D)\text{（準備の読み方で）}\bigr)\\
&= \bigl((K_2^*)_{\mathbb{C}}\bigl((-1)^{(n+1)/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigr)\bigl(2\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&= \bigl((-1)^{(n+1)/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \mathbb{C}\text{ の積の可換律と結合律}\bigr)\\
&= \bigl((-1)^{(n+1)/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n+1}\bigr)\check{Z}_\mu
&&\bigl(\because\ \text{冪の約束 }x^{m+1} := x^{m}x\text{。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)
\end{aligned}`),
      paragraph(["最後の行は、", math(String.raw`n+1`), " の偶奇に応じた主張の右辺である。以上で (h2.z) が成り立つ。"]),
      paragraph(["(h2.y) の証明。", math(String.raw`F_n := \underbrace{\left[(K_2^*)_{\mathbb{C}} H_2,\dots,\left[(K_2^*)_{\mathbb{C}} H_2, \check{Y}_\mu\right]\dots\right]}_{n}\in R`), "（", math(String.raw`n\in\mathbb{Z}_{\geq 0}`), "）とおき、", math(String.raw`n`), " についての帰納法で示す。基底段階（", math(String.raw`n = 0`), "）。"]),
      displayMath(String.raw`\begin{aligned}
F_0
&= \check{Y}_\mu
&&\bigl(\because\ \mathrm{ad}^{0}_X(W) = W\text{。}\blkref{def_ad_X_matrix}\bigr)\\
&= 1_{\mathbb{C}}\,\check{Y}_\mu
&&\bigl(\because\ \blkref{scalar_multiple_by_one}\bigr)\\
&= \bigl(1_{\mathbb{C}}1_{\mathbb{C}}\bigr)\check{Y}_\mu
&&\bigl(\because\ 1_{\mathbb{C}}\text{ は }\mathbb{C}\text{ の積の単位元}\bigr)\\
&= \bigl((-1)^{0}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{0}\bigr)\check{Y}_\mu
&&\bigl(\because\ \text{冪の約束 }x^{0} := 1\text{ を二か所へ。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)
\end{aligned}`),
      paragraph(["帰納段階（", math(String.raw`n`), " が偶数）。", math(String.raw`F_n = \bigl((-1)^{n/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigr)\check{Y}_\mu`), " を仮定する。"]),
      displayMath(String.raw`\begin{aligned}
F_{n+1}
&= \left[(K_2^*)_{\mathbb{C}} H_2,\ F_n\right]
&&\bigl(\because\ \mathrm{ad}^{m+1}_X(W) = [X,\mathrm{ad}^{m}_X(W)]\ \text{の再帰。}\blkref{def_ad_X_matrix}\bigr)\\
&= \left[(K_2^*)_{\mathbb{C}} H_2,\ \bigl((-1)^{n/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigr)\check{Y}_\mu\right]
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \bigl((K_2^*)_{\mathbb{C}}\bigl((-1)^{n/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigr)\bigr)\left[H_2,\ \check{Y}_\mu\right]
&&\bigl(\because\ \blkref{commutator_of_scalar_multiples}\text{ を }\alpha = (K_2^*)_{\mathbb{C}},\ \beta = (-1)^{n/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\text{ で}\bigr)\\
&= \bigl((K_2^*)_{\mathbb{C}}\bigl((-1)^{n/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigr)\bigr)\bigl(\bigl(2\bigr)\check{Z}_\mu\bigr)
&&\bigl(\because\ \blkref{commutator_of_H_and_check_Z_Y}\text{ の }(D)\text{（準備の読み方で）}\bigr)\\
&= \bigl((K_2^*)_{\mathbb{C}}\bigl((-1)^{n/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigr)\bigl(2\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&= \bigl((-1)^{n/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)\bigr)\check{Z}_\mu
&&\bigl(\because\ \mathbb{C}\text{ の積の可換律と結合律}\bigr)\\
&= \bigl((-1)^{n/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n+1}\bigr)\check{Z}_\mu
&&\bigl(\because\ \text{冪の約束 }x^{m+1} := x^{m}x\text{。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)\\
&= \bigl((-1)^{((n+1)-1)/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n+1}\bigr)\check{Z}_\mu
&&\bigl(\because\ \tfrac{n}{2} = \tfrac{(n+1)-1}{2}\bigr)
\end{aligned}`),
      paragraph(["帰納段階（", math(String.raw`n`), " が奇数）。", math(String.raw`F_n = \bigl((-1)^{(n-1)/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigr)\check{Z}_\mu`), " を仮定する。"]),
      displayMath(String.raw`\begin{aligned}
F_{n+1}
&= \left[(K_2^*)_{\mathbb{C}} H_2,\ F_n\right]
&&\bigl(\because\ \mathrm{ad}^{m+1}_X(W) = [X,\mathrm{ad}^{m}_X(W)]\ \text{の再帰。}\blkref{def_ad_X_matrix}\bigr)\\
&= \left[(K_2^*)_{\mathbb{C}} H_2,\ \bigl((-1)^{(n-1)/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigr)\check{Z}_\mu\right]
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \bigl((K_2^*)_{\mathbb{C}}\bigl((-1)^{(n-1)/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigr)\bigr)\left[H_2,\ \check{Z}_\mu\right]
&&\bigl(\because\ \blkref{commutator_of_scalar_multiples}\text{ を }\alpha = (K_2^*)_{\mathbb{C}},\ \beta = (-1)^{(n-1)/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\text{ で}\bigr)\\
&= \bigl((K_2^*)_{\mathbb{C}}\bigl((-1)^{(n-1)/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigr)\bigr)\bigl(\bigl(-2\bigr)\check{Y}_\mu\bigr)
&&\bigl(\because\ \blkref{commutator_of_H_and_check_Z_Y}\text{ の }(C)\text{（準備の読み方で）}\bigr)\\
&= \bigl((K_2^*)_{\mathbb{C}}\bigl((-1)^{(n-1)/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigr)\bigl(-2\bigr)\bigr)\check{Y}_\mu
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&= \bigl((-1)^{(n-1)/2}(-1)\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)\bigr)\check{Y}_\mu
&&\bigl(\because\ \mathbb{C}\text{ の四則}\bigr)\\
&= \bigl((-1)^{(n-1)/2+1}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n+1}\bigr)\check{Y}_\mu
&&\bigl(\because\ \text{冪の約束 }x^{m+1} := x^{m}x\text{ を }-1\text{ と }2(K_2^*)_{\mathbb{C}}\text{ の二か所へ。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)\\
&= \bigl((-1)^{(n+1)/2}\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^{n+1}\bigr)\check{Y}_\mu
&&\bigl(\because\ \tfrac{n-1}{2}+1 = \tfrac{n+1}{2}\bigr)
\end{aligned}`),
      paragraph(["最後の行は、", math(String.raw`n+1`), " の偶奇に応じた主張の右辺である。以上で (h2.y) が成り立つ。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の nesting_of_commutator_of_H_and_Z と同じ帰納法を、(A)〜(D) を commutator_of_H_and_check_Z_Y から取って半整数運動量について繰り返したもの。008 章の証明が θ_μ に固有の性質（e^{-iMθ_μ}=+1、添字集合 calM、hatZ_hatY_M_periodicity）を一切使っていないことを確認したうえで書いた。使うのは (A)〜(D) と交換子の双線型性と e^{iθ}e^{-iθ}=1 だけである。",
        "008 章では (h2.z) が hatZ^{(-)} 専用だったのに対し、ここでは (C)(D) が checkZ, checkY について成り立つので (h2.z)(h2.y) にセクターの制限が付かない。これが偶セクターで議論が閉じる理由である。",
        "M=2,3,4,5、μ=1..M、n=0..8、5 組の (K1,K2)（臨界点上・臨界点近傍を含む）で数値確認済み（sagemath/check/047_claim_even_sector_T_action/check_01_nested_commutators.sage）。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-11-02（全証明の SageMath 検算）: 主張の中で定めていた交換子と n 重の反復を def_ad_X_matrix の ad^n_X への参照にし、実数のスカラー K_1・K_2^* と θ̃_μ を inclusion_rr_to_cc の像 (K_1)_C・(K_2^*)_C・(θ̃)_C で書き、(−1) の冪の指数が ℤ_{≥0} に属することを書き、係数を一つの複素数にまとめてからスカラー倍で掛ける括弧を明示した（主張の中身は不変）。証明は、双線型性の鎖の名前だけの根拠をスカラー倍の主張へのラベル参照に、exp(-iθ̃)exp(iθ̃) = 1 を scalar_exp_product・scalar_exp_zero の鎖に、(A)〜(D) を commutator_of_H_and_check_Z_Y へのラベル参照に、基底段階に単位元の行を、(A)〜(D) の右辺をスカラー倍として読むことを準備に書き、二つの帰納段階の鎖の末尾に冪の約束と指数の等式の行を足して n+1 の主張の右辺まで一続きにし、鎖の後の散文の照合を除いた。検算は sagemath/check/nesting_of_commutator_of_H_and_check_Z/（円分体と不定元で厳密）。",
        "2026-11-02（cosh_sinh_coefficient_conversion_for_check の検算）: 証明の冒頭の準備（交換子の双線型性）の鎖を、同じ事実を使う cosh_sinh_coefficient_conversion_for_check と共有するため独立の主張 commutator_of_scalar_multiples に切り出し、帰納段階の 8 か所の根拠をそれへのラベル参照にした（鎖の中身は不変）。",
        "2026-11-14（Lean の通しの証明）: 準備（位相の積）の -i(θ̃)_C + i(θ̃)_C = 0 を名前だけの「C の加法の逆元」で消していた。-i(θ̃)_C を def_half_integer_checkZ と同じく (-i)(θ̃)_C と読むことを書き、negative_i_times_complex_is_negation_of_i_times（z → (θ̃)_C）で -(i(θ̃)_C) に直す行を足してから negation_plus_self_is_zero_in_cc（x → i(θ̃)_C）を引くようにした（3 等号 → 4 等号）。exp(0) を exp(0_C) と書いた。式の両端は不変。",
        "2026-11-14（Lean の通しの証明）: (h1.z) の二つの帰納段階で、係数の並べ替えを名前だけの「C の積の可換律と結合律」「C の四則」の 1 行で済ませていた。偶数の段を complex_numbers_form_a_field の積の結合律・可換律を 1 行に 1 つずつ当てる 5 行に、奇数の段を multiply_by_minus_one（z → 2。-2 = (-1)2）の 1 行と同じ当て方の 11 行に割り、準備（前提の読み方）に -2 を -(2_C)、-1 を -1_C、括弧の無い積を左から掛けたものと読むことを書き、続く冪の約束・準備の位相の積・単位元の行に括弧を明示した（式の両端と主張は不変）。並べ替えの行の数は、積の結合律・可換律を 1 か所に当てる手を 1 行として、行の数が最も少ない並べ方を総当たりで選んだ。(h1.y)・(h2.z)・(h2.y) の同じ行は次の回で割る。",
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
        math(String.raw`\tilde\theta := \tilde\theta_\mu \in \mathbb{R}`),
        "（",
        ref("antiperiodic_exp_sum"),
        "）と略記し、",
        math(String.raw`(\tilde\theta)_{\mathbb{C}} \in \mathbb{C}`),
        " をその ",
        ref("inclusion_rr_to_cc"),
        " による像とする。",
        math(String.raw`R := \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "、",
        math(String.raw`H_1^{(+)}, H_2, \check{Z}_\mu, \check{Y}_\mu \in R`),
        "、",
        math(String.raw`K_1, K_2^* \in \mathbb{R}`),
        " とその像 ",
        math(String.raw`(K_1)_{\mathbb{C}}, (K_2^*)_{\mathbb{C}} \in \mathbb{C}`),
        "、",
        math(String.raw`n`),
        " 重交換子の記法 ",
        math(String.raw`\underbrace{[X,\dots,[X, W]\dots]}_{n} := \mathrm{ad}^{n}_X(W)`),
        "（",
        ref("def_ad_X_matrix"),
        "）は ",
        ref("nesting_of_commutator_of_H_and_check_Z"),
        " のものとする。",
        math(String.raw`i \in \mathbb{C}`),
        " を ",
        ref("def_imaginary_unit"),
        " の虚数単位、",
        math(String.raw`-i := (-1_{\mathbb{C}})\,i`),
        "（",
        ref("multiply_by_minus_one"),
        "）とし、",
        math(String.raw`2_{\mathbb{C}} := (2_{\mathbb{R}})_{\mathbb{C}} = (2,0) \neq (0,0) = 0_{\mathbb{C}}`),
        "（",
        ref("inclusion_rr_to_cc"),
        "。第 1 成分が ",
        math(String.raw`2\neq0`),
        "）なので ",
        math(String.raw`2_{\mathbb{C}}\in\mathbb{C}^{\times}`),
        "（",
        ref("multiplicative_group_of_cc"),
        "）であり、",
        math(String.raw`\tfrac{i}{2} \in \mathbb{C}`),
        " は ",
        ref("def_complex_quotient"),
        " の商（",
        math(String.raw`z\to i,\ w\to2_{\mathbb{C}}`),
        "）",
        math(String.raw`\tfrac{i}{2} = i\,2_{\mathbb{C}}^{-1}`),
        " である。冪は ",
        ref("scalar_exp_is_limit_of_partial_sums"),
        " の約束 ",
        math(String.raw`x^{0} := 1_{\mathbb{C}}`),
        "、",
        math(String.raw`x^{m+1} := x^{m}x`),
        " による。この主張の係数と、その証明の式（証明の (",
        math(String.raw`\dagger`),
        ") を含む）に現れる ",
        math(String.raw`2`),
        " は ",
        math(String.raw`2_{\mathbb{C}}`),
        " を表す。係数と行列の積はスカラー倍（",
        ref("def_matrix_scalar_multiple"),
        "）である。このとき次が成り立つ。",
      ]),
      paragraph(["(h1.z)"]),
      displayMath(
        String.raw`\underbrace{\left[\tfrac{i}{2}\bigl((K_1)_{\mathbb{C}} H_1^{(+)}\bigr),\dots,\left[\tfrac{i}{2}\bigl((K_1)_{\mathbb{C}} H_1^{(+)}\bigr),\check{Z}_\mu\right]\dots\right]}_{n}
= \begin{cases}
\bigl(i\,(K_1)_{\mathbb{C}}^{\,n} \exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Y}_\mu & (n \text{ 奇数}) \\
(K_1)_{\mathbb{C}}^{\,n}\,\check{Z}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h1.y)"]),
      displayMath(
        String.raw`\underbrace{\left[\tfrac{i}{2}\bigl((K_1)_{\mathbb{C}} H_1^{(+)}\bigr),\dots,\left[\tfrac{i}{2}\bigl((K_1)_{\mathbb{C}} H_1^{(+)}\bigr),\check{Y}_\mu\right]\dots\right]}_{n}
= \begin{cases}
\bigl((-i)\,(K_1)_{\mathbb{C}}^{\,n} \exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)\check{Z}_\mu & (n \text{ 奇数}) \\
(K_1)_{\mathbb{C}}^{\,n}\,\check{Y}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h2.z)"]),
      displayMath(
        String.raw`\underbrace{\left[i\bigl((K_2^*)_{\mathbb{C}} H_2\bigr),\dots,\left[i\bigl((K_2^*)_{\mathbb{C}} H_2\bigr),\check{Z}_\mu\right]\dots\right]}_{n}
= \begin{cases}
\bigl((-i)\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^n\bigr)\check{Y}_\mu & (n \text{ 奇数}) \\
\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^n\,\check{Z}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h2.y)"]),
      displayMath(
        String.raw`\underbrace{\left[i\bigl((K_2^*)_{\mathbb{C}} H_2\bigr),\dots,\left[i\bigl((K_2^*)_{\mathbb{C}} H_2\bigr),\check{Y}_\mu\right]\dots\right]}_{n}
= \begin{cases}
\bigl(i\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^n\bigr)\check{Z}_\mu & (n \text{ 奇数}) \\
\bigl(2(K_2^*)_{\mathbb{C}}\bigr)^n\,\check{Y}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
    ],
    proof: [
      paragraph([
        "準備（生成子のスカラー倍）。",
        math(String.raw`\alpha \in \mathbb{C}`),
        "、",
        math(String.raw`X, W \in R`),
        " とし、",
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`\mathrm{ad}^{m}_{\alpha X}(W) = \alpha^{m}\,\mathrm{ad}^{m}_{X}(W) \qquad (\star)`),
      paragraph(["を示す。基底段階（", math(String.raw`m = 0`), "）。"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ad}^{0}_{\alpha X}(W)
&= W
&&\bigl(\because\ \mathrm{ad}^{0}_X(W) = W\text{。}\blkref{def_ad_X_matrix}\bigr)\\
&= 1_{\mathbb{C}}\,W
&&\bigl(\because\ \blkref{scalar_multiple_by_one}\bigr)\\
&= \alpha^{0}\,W
&&\bigl(\because\ \text{冪の約束 }x^{0} := 1_{\mathbb{C}}\text{。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)\\
&= \alpha^{0}\,\mathrm{ad}^{0}_{X}(W)
&&\bigl(\because\ \mathrm{ad}^{0}_X(W) = W\text{。}\blkref{def_ad_X_matrix}\bigr)
\end{aligned}`),
      paragraph(["帰納段階。", math(String.raw`m`), " で (", math(String.raw`\star`), ") を仮定する。"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ad}^{m+1}_{\alpha X}(W)
&= \left[\alpha X,\ \mathrm{ad}^{m}_{\alpha X}(W)\right]
&&\bigl(\because\ \mathrm{ad}^{m+1}_X(W) = [X,\mathrm{ad}^{m}_X(W)]\text{ の再帰。}\blkref{def_ad_X_matrix}\bigr)\\
&= \left[\alpha X,\ \alpha^{m}\,\mathrm{ad}^{m}_{X}(W)\right]
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \bigl(\alpha\,\alpha^{m}\bigr)\left[X,\ \mathrm{ad}^{m}_{X}(W)\right]
&&\bigl(\because\ \blkref{commutator_of_scalar_multiples}\text{ を }\beta = \alpha^{m},\ W \to \mathrm{ad}^{m}_{X}(W)\text{ で}\bigr)\\
&= \bigl(\alpha^{m}\,\alpha\bigr)\left[X,\ \mathrm{ad}^{m}_{X}(W)\right]
&&\bigl(\because\ \mathbb{C}\text{ の積の可換律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \alpha^{m+1}\left[X,\ \mathrm{ad}^{m}_{X}(W)\right]
&&\bigl(\because\ \text{冪の約束 }x^{m+1} := x^{m}x\text{。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)\\
&= \alpha^{m+1}\,\mathrm{ad}^{m+1}_{X}(W)
&&\bigl(\because\ \mathrm{ad}^{m+1}_X(W) = [X,\mathrm{ad}^{m}_X(W)]\text{ の再帰。}\blkref{def_ad_X_matrix}\bigr)
\end{aligned}`),
      paragraph(["準備（", math(String.raw`i\,i`), " と ", math(String.raw`(-1_{\mathbb{C}})(-1_{\mathbb{C}})`), "）。"]),
      displayMath(String.raw`\begin{aligned}
i\,i
&= (0_{\mathbb{R}}, 1_{\mathbb{R}})(0_{\mathbb{R}}, 1_{\mathbb{R}})
&&\bigl(\because\ \blkref{def_imaginary_unit}\bigr)\\
&= \bigl(0_{\mathbb{R}}0_{\mathbb{R}} - 1_{\mathbb{R}}1_{\mathbb{R}},\ 0_{\mathbb{R}}1_{\mathbb{R}} + 1_{\mathbb{R}}0_{\mathbb{R}}\bigr)
&&\bigl(\because\ \blkref{definition_of_cc}\text{ の積}\bigr)\\
&= (-1_{\mathbb{R}}, 0_{\mathbb{R}})
&&\bigl(\because\ \mathbb{R}\text{ の四則}\bigr)\\
&= -1_{\mathbb{C}}
&&\bigl(\because\ 1_{\mathbb{C}} = (1_{\mathbb{R}}, 0_{\mathbb{R}})\text{ の加法の逆元。}\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
(-1_{\mathbb{C}})(-1_{\mathbb{C}})
&= (-1_{\mathbb{R}}, 0_{\mathbb{R}})(-1_{\mathbb{R}}, 0_{\mathbb{R}})
&&\bigl(\because\ 1_{\mathbb{C}} = (1_{\mathbb{R}}, 0_{\mathbb{R}})\text{ の加法の逆元。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \bigl((-1_{\mathbb{R}})(-1_{\mathbb{R}}) - 0_{\mathbb{R}}0_{\mathbb{R}},\ (-1_{\mathbb{R}})0_{\mathbb{R}} + 0_{\mathbb{R}}(-1_{\mathbb{R}})\bigr)
&&\bigl(\because\ \blkref{definition_of_cc}\text{ の積}\bigr)\\
&= (1_{\mathbb{R}}, 0_{\mathbb{R}})
&&\bigl(\because\ \mathbb{R}\text{ の四則}\bigr)\\
&= 1_{\mathbb{C}}
&&\bigl(\because\ \mathbb{C}\text{ の積の単位元。}\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`),
      paragraph([
        "準備（係数の冪その一）。",
        math(String.raw`k \in \mathbb{C}`),
        " とし、",
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`\left(\tfrac{i}{2}\right)^{m}(2k)^{m} = i^{m}k^{m} \qquad (\dagger)`),
      paragraph(["を示す。基底段階（", math(String.raw`m = 0`), "）。"]),
      displayMath(String.raw`\begin{aligned}
\left(\tfrac{i}{2}\right)^{0}(2k)^{0}
&= 1_{\mathbb{C}}\,1_{\mathbb{C}}
&&\bigl(\because\ \text{冪の約束 }x^{0} := 1_{\mathbb{C}}\text{ を二か所へ。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)\\
&= i^{0}k^{0}
&&\bigl(\because\ \text{冪の約束 }x^{0} := 1_{\mathbb{C}}\text{ を二か所へ。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)
\end{aligned}`),
      paragraph(["帰納段階。", math(String.raw`m`), " で (", math(String.raw`\dagger`), ") を仮定する。"]),
      displayMath(String.raw`\begin{aligned}
\left(\tfrac{i}{2}\right)^{m+1}(2k)^{m+1}
&= \Bigl(\left(\tfrac{i}{2}\right)^{m}\tfrac{i}{2}\Bigr)\bigl((2k)^{m}(2k)\bigr)
&&\bigl(\because\ \text{冪の約束 }x^{m+1} := x^{m}x\text{ を二か所へ。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)\\
&= \Bigl(\left(\tfrac{i}{2}\right)^{m}(2k)^{m}\Bigr)\Bigl(\tfrac{i}{2}(2k)\Bigr)
&&\bigl(\because\ \mathbb{C}\text{ の積の可換律・結合律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \bigl(i^{m}k^{m}\bigr)\Bigl(\tfrac{i}{2}(2k)\Bigr)
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \bigl(i^{m}k^{m}\bigr)\Bigl(\bigl(i\,2_{\mathbb{C}}^{-1}\bigr)(2_{\mathbb{C}}k)\Bigr)
&&\bigl(\because\ \blkref{def_complex_quotient}\ (z\to i,\ w\to2_{\mathbb{C}})\text{。}2k\text{ の }2\text{ は主張の前置きのとおり }2_{\mathbb{C}}\bigr)\\
&= \bigl(i^{m}k^{m}\bigr)\Bigl(\bigl(i\,(2_{\mathbb{C}}^{-1}2_{\mathbb{C}})\bigr)k\Bigr)
&&\bigl(\because\ \mathbb{C}\text{ の積の結合律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \bigl(i^{m}k^{m}\bigr)\bigl((i\,1_{\mathbb{C}})k\bigr)
&&\bigl(\because\ 2_{\mathbb{C}}^{-1}\text{ は }2_{\mathbb{C}}\in\mathbb{C}^{\times}\text{ の逆元。}\blkref{multiplicative_group_of_cc}\bigr)\\
&= \bigl(i^{m}k^{m}\bigr)(ik)
&&\bigl(\because\ \mathbb{C}\text{ の積の単位元。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \bigl(i^{m}i\bigr)\bigl(k^{m}k\bigr)
&&\bigl(\because\ \mathbb{C}\text{ の積の可換律・結合律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= i^{m+1}k^{m+1}
&&\bigl(\because\ \text{冪の約束 }x^{m+1} := x^{m}x\text{ を二か所へ。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)
\end{aligned}`),
      paragraph([
        "準備（係数の冪その二）。",
        math(String.raw`l \in \mathbb{Z}_{\geq 0}`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`i^{2l}(-1_{\mathbb{C}})^{l} = 1_{\mathbb{C}} \qquad (\ddagger)`),
      paragraph(["を示す。基底段階（", math(String.raw`l = 0`), "）。"]),
      displayMath(String.raw`\begin{aligned}
i^{2\cdot 0}(-1_{\mathbb{C}})^{0}
&= i^{0}(-1_{\mathbb{C}})^{0}
&&\bigl(\because\ 2\cdot 0 = 0\ (\mathbb{Z})\bigr)\\
&= 1_{\mathbb{C}}\,1_{\mathbb{C}}
&&\bigl(\because\ \text{冪の約束 }x^{0} := 1_{\mathbb{C}}\text{ を二か所へ。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)\\
&= 1_{\mathbb{C}}
&&\bigl(\because\ \mathbb{C}\text{ の積の単位元。}\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`),
      paragraph(["帰納段階。", math(String.raw`l`), " で (", math(String.raw`\ddagger`), ") を仮定する。"]),
      displayMath(String.raw`\begin{aligned}
i^{2(l+1)}(-1_{\mathbb{C}})^{l+1}
&= i^{(2l+1)+1}(-1_{\mathbb{C}})^{l+1}
&&\bigl(\because\ 2(l+1) = (2l+1)+1\ (\mathbb{Z})\bigr)\\
&= \bigl(\bigl(i^{2l}\,i\bigr)i\bigr)\bigl((-1_{\mathbb{C}})^{l}(-1_{\mathbb{C}})\bigr)
&&\bigl(\because\ \text{冪の約束 }x^{m+1} := x^{m}x\text{ を三か所へ。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)\\
&= \bigl(i^{2l}(-1_{\mathbb{C}})^{l}\bigr)\bigl((i\,i)(-1_{\mathbb{C}})\bigr)
&&\bigl(\because\ \mathbb{C}\text{ の積の可換律・結合律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= 1_{\mathbb{C}}\bigl((i\,i)(-1_{\mathbb{C}})\bigr)
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= 1_{\mathbb{C}}\bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)
&&\bigl(\because\ \text{準備の }i\,i = -1_{\mathbb{C}}\bigr)\\
&= 1_{\mathbb{C}}\,1_{\mathbb{C}}
&&\bigl(\because\ \text{準備の }(-1_{\mathbb{C}})(-1_{\mathbb{C}}) = 1_{\mathbb{C}}\bigr)\\
&= 1_{\mathbb{C}}
&&\bigl(\because\ \mathbb{C}\text{ の積の単位元。}\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`),
      paragraph([
        "以下、",
        math(String.raw`n`),
        " が奇数のときは ",
        math(String.raw`l := (n-1)/2 \in \mathbb{Z}_{\geq 0}`),
        "（このとき ",
        math(String.raw`n = 2l+1`),
        "、",
        math(String.raw`(n+1)/2 = l+1`),
        "）、偶数のときは ",
        math(String.raw`l := n/2 \in \mathbb{Z}_{\geq 0}`),
        "（このとき ",
        math(String.raw`n = 2l`),
        "）とし、",
        math(String.raw`k_1 := (K_1)_{\mathbb{C}}`),
        "、",
        math(String.raw`k_2 := (K_2^*)_{\mathbb{C}}`),
        "、",
        math(String.raw`e_{\mp} := \exp\bigl(\mp i(\tilde\theta)_{\mathbb{C}}\bigr) \in \mathbb{C}`),
        " と略記する。",
      ]),
      paragraph(["(h1.z)、", math(String.raw`n`), " が奇数のとき。"]),
      displayMath(String.raw`\begin{aligned}
\underbrace{\left[\tfrac{i}{2}\bigl(k_1 H_1^{(+)}\bigr),\dots,\left[\tfrac{i}{2}\bigl(k_1 H_1^{(+)}\bigr),\check{Z}_\mu\right]\dots\right]}_{n}
&= \mathrm{ad}^{n}_{\frac{i}{2}(k_1 H_1^{(+)})}(\check{Z}_\mu)
&&\bigl(\because\ n\text{ 重交換子の記法}\bigr)\\
&= \left(\tfrac{i}{2}\right)^{n}\mathrm{ad}^{n}_{k_1 H_1^{(+)}}(\check{Z}_\mu)
&&\bigl(\because\ \text{準備の }(\star)\text{ を }\alpha = \tfrac{i}{2},\ X = k_1 H_1^{(+)},\ W = \check{Z}_\mu,\ m = n\text{ で}\bigr)\\
&= \left(\tfrac{i}{2}\right)^{n}\Bigl(\bigl((-1_{\mathbb{C}})^{l}(2k_1)^{n}e_{-}\bigr)\check{Y}_\mu\Bigr)
&&\bigl(\because\ \blkref{nesting_of_commutator_of_H_and_check_Z}\text{ (h1.z) の奇数の場合と }(n-1)/2 = l\bigr)\\
&= \Bigl(\left(\tfrac{i}{2}\right)^{n}\bigl((-1_{\mathbb{C}})^{l}(2k_1)^{n}e_{-}\bigr)\Bigr)\check{Y}_\mu
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&= \Bigl(\Bigl(\left(\tfrac{i}{2}\right)^{n}(2k_1)^{n}\Bigr)\bigl((-1_{\mathbb{C}})^{l}e_{-}\bigr)\Bigr)\check{Y}_\mu
&&\bigl(\because\ \mathbb{C}\text{ の積の可換律・結合律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \Bigl(\bigl(i^{n}k_1^{\,n}\bigr)\bigl((-1_{\mathbb{C}})^{l}e_{-}\bigr)\Bigr)\check{Y}_\mu
&&\bigl(\because\ \text{準備の }(\dagger)\text{ を }k = k_1,\ m = n\text{ で}\bigr)\\
&= \Bigl(\bigl(i^{2l+1}k_1^{\,n}\bigr)\bigl((-1_{\mathbb{C}})^{l}e_{-}\bigr)\Bigr)\check{Y}_\mu
&&\bigl(\because\ n = 2l+1\bigr)\\
&= \Bigl(\bigl(\bigl(i^{2l}\,i\bigr)k_1^{\,n}\bigr)\bigl((-1_{\mathbb{C}})^{l}e_{-}\bigr)\Bigr)\check{Y}_\mu
&&\bigl(\because\ \text{冪の約束 }x^{m+1} := x^{m}x\text{。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)\\
&= \Bigl(\bigl(i^{2l}(-1_{\mathbb{C}})^{l}\bigr)\bigl(i\,k_1^{\,n}e_{-}\bigr)\Bigr)\check{Y}_\mu
&&\bigl(\because\ \mathbb{C}\text{ の積の可換律・結合律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \bigl(1_{\mathbb{C}}\bigl(i\,k_1^{\,n}e_{-}\bigr)\bigr)\check{Y}_\mu
&&\bigl(\because\ \text{準備の }(\ddagger)\bigr)\\
&= \bigl(i\,k_1^{\,n}e_{-}\bigr)\check{Y}_\mu
&&\bigl(\because\ \mathbb{C}\text{ の積の単位元。}\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`),
      paragraph([
        "(h1.z)・(h1.y)、",
        math(String.raw`n`),
        " が偶数のとき。",
        math(String.raw`W_\mu \in \{\check{Z}_\mu, \check{Y}_\mu\}`),
        " とする（",
        math(String.raw`W_\mu = \check{Z}_\mu`),
        " が (h1.z)、",
        math(String.raw`W_\mu = \check{Y}_\mu`),
        " が (h1.y) である）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\underbrace{\left[\tfrac{i}{2}\bigl(k_1 H_1^{(+)}\bigr),\dots,\left[\tfrac{i}{2}\bigl(k_1 H_1^{(+)}\bigr),W_\mu\right]\dots\right]}_{n}
&= \mathrm{ad}^{n}_{\frac{i}{2}(k_1 H_1^{(+)})}(W_\mu)
&&\bigl(\because\ n\text{ 重交換子の記法}\bigr)\\
&= \left(\tfrac{i}{2}\right)^{n}\mathrm{ad}^{n}_{k_1 H_1^{(+)}}(W_\mu)
&&\bigl(\because\ \text{準備の }(\star)\text{ を }\alpha = \tfrac{i}{2},\ X = k_1 H_1^{(+)},\ W = W_\mu,\ m = n\text{ で}\bigr)\\
&= \left(\tfrac{i}{2}\right)^{n}\Bigl(\bigl((-1_{\mathbb{C}})^{l}(2k_1)^{n}\bigr)W_\mu\Bigr)
&&\bigl(\because\ \blkref{nesting_of_commutator_of_H_and_check_Z}\text{ (h1.z)・(h1.y) の偶数の場合と }n/2 = l\bigr)\\
&= \Bigl(\left(\tfrac{i}{2}\right)^{n}\bigl((-1_{\mathbb{C}})^{l}(2k_1)^{n}\bigr)\Bigr)W_\mu
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&= \Bigl(\Bigl(\left(\tfrac{i}{2}\right)^{n}(2k_1)^{n}\Bigr)(-1_{\mathbb{C}})^{l}\Bigr)W_\mu
&&\bigl(\because\ \mathbb{C}\text{ の積の可換律・結合律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \Bigl(\bigl(i^{n}k_1^{\,n}\bigr)(-1_{\mathbb{C}})^{l}\Bigr)W_\mu
&&\bigl(\because\ \text{準備の }(\dagger)\text{ を }k = k_1,\ m = n\text{ で}\bigr)\\
&= \Bigl(\bigl(i^{2l}k_1^{\,n}\bigr)(-1_{\mathbb{C}})^{l}\Bigr)W_\mu
&&\bigl(\because\ n = 2l\bigr)\\
&= \Bigl(\bigl(i^{2l}(-1_{\mathbb{C}})^{l}\bigr)k_1^{\,n}\Bigr)W_\mu
&&\bigl(\because\ \mathbb{C}\text{ の積の可換律・結合律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \bigl(1_{\mathbb{C}}\,k_1^{\,n}\bigr)W_\mu
&&\bigl(\because\ \text{準備の }(\ddagger)\bigr)\\
&= k_1^{\,n}\,W_\mu
&&\bigl(\because\ \mathbb{C}\text{ の積の単位元。}\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`),
      paragraph(["(h1.y)、", math(String.raw`n`), " が奇数のとき。"]),
      displayMath(String.raw`\begin{aligned}
\underbrace{\left[\tfrac{i}{2}\bigl(k_1 H_1^{(+)}\bigr),\dots,\left[\tfrac{i}{2}\bigl(k_1 H_1^{(+)}\bigr),\check{Y}_\mu\right]\dots\right]}_{n}
&= \mathrm{ad}^{n}_{\frac{i}{2}(k_1 H_1^{(+)})}(\check{Y}_\mu)
&&\bigl(\because\ n\text{ 重交換子の記法}\bigr)\\
&= \left(\tfrac{i}{2}\right)^{n}\mathrm{ad}^{n}_{k_1 H_1^{(+)}}(\check{Y}_\mu)
&&\bigl(\because\ \text{準備の }(\star)\text{ を }\alpha = \tfrac{i}{2},\ X = k_1 H_1^{(+)},\ W = \check{Y}_\mu,\ m = n\text{ で}\bigr)\\
&= \left(\tfrac{i}{2}\right)^{n}\Bigl(\bigl((-1_{\mathbb{C}})^{l+1}(2k_1)^{n}e_{+}\bigr)\check{Z}_\mu\Bigr)
&&\bigl(\because\ \blkref{nesting_of_commutator_of_H_and_check_Z}\text{ (h1.y) の奇数の場合と }(n+1)/2 = l+1\bigr)\\
&= \Bigl(\left(\tfrac{i}{2}\right)^{n}\bigl((-1_{\mathbb{C}})^{l+1}(2k_1)^{n}e_{+}\bigr)\Bigr)\check{Z}_\mu
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&= \Bigl(\Bigl(\left(\tfrac{i}{2}\right)^{n}(2k_1)^{n}\Bigr)\bigl((-1_{\mathbb{C}})^{l+1}e_{+}\bigr)\Bigr)\check{Z}_\mu
&&\bigl(\because\ \mathbb{C}\text{ の積の可換律・結合律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \Bigl(\bigl(i^{n}k_1^{\,n}\bigr)\bigl((-1_{\mathbb{C}})^{l+1}e_{+}\bigr)\Bigr)\check{Z}_\mu
&&\bigl(\because\ \text{準備の }(\dagger)\text{ を }k = k_1,\ m = n\text{ で}\bigr)\\
&= \Bigl(\bigl(i^{2l+1}k_1^{\,n}\bigr)\bigl((-1_{\mathbb{C}})^{l+1}e_{+}\bigr)\Bigr)\check{Z}_\mu
&&\bigl(\because\ n = 2l+1\bigr)\\
&= \Bigl(\bigl(\bigl(i^{2l}\,i\bigr)k_1^{\,n}\bigr)\bigl(\bigl((-1_{\mathbb{C}})^{l}(-1_{\mathbb{C}})\bigr)e_{+}\bigr)\Bigr)\check{Z}_\mu
&&\bigl(\because\ \text{冪の約束 }x^{m+1} := x^{m}x\text{ を二か所へ。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)\\
&= \Bigl(\bigl(i^{2l}(-1_{\mathbb{C}})^{l}\bigr)\bigl(\bigl((-1_{\mathbb{C}})\,i\bigr)k_1^{\,n}e_{+}\bigr)\Bigr)\check{Z}_\mu
&&\bigl(\because\ \mathbb{C}\text{ の積の可換律・結合律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \Bigl(1_{\mathbb{C}}\bigl(\bigl((-1_{\mathbb{C}})\,i\bigr)k_1^{\,n}e_{+}\bigr)\Bigr)\check{Z}_\mu
&&\bigl(\because\ \text{準備の }(\ddagger)\bigr)\\
&= \Bigl(1_{\mathbb{C}}\bigl((-i)\,k_1^{\,n}e_{+}\bigr)\Bigr)\check{Z}_\mu
&&\bigl(\because\ -i := (-1_{\mathbb{C}})\,i\text{。}\blkref{multiply_by_minus_one}\bigr)\\
&= \bigl((-i)\,k_1^{\,n}e_{+}\bigr)\check{Z}_\mu
&&\bigl(\because\ \mathbb{C}\text{ の積の単位元。}\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`),
      paragraph(["(h2.z)、", math(String.raw`n`), " が奇数のとき。"]),
      displayMath(String.raw`\begin{aligned}
\underbrace{\left[i\bigl(k_2 H_2\bigr),\dots,\left[i\bigl(k_2 H_2\bigr),\check{Z}_\mu\right]\dots\right]}_{n}
&= \mathrm{ad}^{n}_{i(k_2 H_2)}(\check{Z}_\mu)
&&\bigl(\because\ n\text{ 重交換子の記法}\bigr)\\
&= i^{n}\,\mathrm{ad}^{n}_{k_2 H_2}(\check{Z}_\mu)
&&\bigl(\because\ \text{準備の }(\star)\text{ を }\alpha = i,\ X = k_2 H_2,\ W = \check{Z}_\mu,\ m = n\text{ で}\bigr)\\
&= i^{n}\Bigl(\bigl((-1_{\mathbb{C}})^{l+1}(2k_2)^{n}\bigr)\check{Y}_\mu\Bigr)
&&\bigl(\because\ \blkref{nesting_of_commutator_of_H_and_check_Z}\text{ (h2.z) の奇数の場合と }(n+1)/2 = l+1\bigr)\\
&= \Bigl(i^{n}\bigl((-1_{\mathbb{C}})^{l+1}(2k_2)^{n}\bigr)\Bigr)\check{Y}_\mu
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&= \Bigl(i^{2l+1}\bigl((-1_{\mathbb{C}})^{l+1}(2k_2)^{n}\bigr)\Bigr)\check{Y}_\mu
&&\bigl(\because\ n = 2l+1\bigr)\\
&= \Bigl(\bigl(i^{2l}\,i\bigr)\bigl(\bigl((-1_{\mathbb{C}})^{l}(-1_{\mathbb{C}})\bigr)(2k_2)^{n}\bigr)\Bigr)\check{Y}_\mu
&&\bigl(\because\ \text{冪の約束 }x^{m+1} := x^{m}x\text{ を二か所へ。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)\\
&= \Bigl(\bigl(i^{2l}(-1_{\mathbb{C}})^{l}\bigr)\bigl(\bigl((-1_{\mathbb{C}})\,i\bigr)(2k_2)^{n}\bigr)\Bigr)\check{Y}_\mu
&&\bigl(\because\ \mathbb{C}\text{ の積の可換律・結合律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \Bigl(1_{\mathbb{C}}\bigl(\bigl((-1_{\mathbb{C}})\,i\bigr)(2k_2)^{n}\bigr)\Bigr)\check{Y}_\mu
&&\bigl(\because\ \text{準備の }(\ddagger)\bigr)\\
&= \Bigl(1_{\mathbb{C}}\bigl((-i)(2k_2)^{n}\bigr)\Bigr)\check{Y}_\mu
&&\bigl(\because\ -i := (-1_{\mathbb{C}})\,i\text{。}\blkref{multiply_by_minus_one}\bigr)\\
&= \bigl((-i)(2k_2)^{n}\bigr)\check{Y}_\mu
&&\bigl(\because\ \mathbb{C}\text{ の積の単位元。}\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`),
      paragraph(["(h2.y)、", math(String.raw`n`), " が奇数のとき。"]),
      displayMath(String.raw`\begin{aligned}
\underbrace{\left[i\bigl(k_2 H_2\bigr),\dots,\left[i\bigl(k_2 H_2\bigr),\check{Y}_\mu\right]\dots\right]}_{n}
&= \mathrm{ad}^{n}_{i(k_2 H_2)}(\check{Y}_\mu)
&&\bigl(\because\ n\text{ 重交換子の記法}\bigr)\\
&= i^{n}\,\mathrm{ad}^{n}_{k_2 H_2}(\check{Y}_\mu)
&&\bigl(\because\ \text{準備の }(\star)\text{ を }\alpha = i,\ X = k_2 H_2,\ W = \check{Y}_\mu,\ m = n\text{ で}\bigr)\\
&= i^{n}\Bigl(\bigl((-1_{\mathbb{C}})^{l}(2k_2)^{n}\bigr)\check{Z}_\mu\Bigr)
&&\bigl(\because\ \blkref{nesting_of_commutator_of_H_and_check_Z}\text{ (h2.y) の奇数の場合と }(n-1)/2 = l\bigr)\\
&= \Bigl(i^{n}\bigl((-1_{\mathbb{C}})^{l}(2k_2)^{n}\bigr)\Bigr)\check{Z}_\mu
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&= \Bigl(i^{2l+1}\bigl((-1_{\mathbb{C}})^{l}(2k_2)^{n}\bigr)\Bigr)\check{Z}_\mu
&&\bigl(\because\ n = 2l+1\bigr)\\
&= \Bigl(\bigl(i^{2l}\,i\bigr)\bigl((-1_{\mathbb{C}})^{l}(2k_2)^{n}\bigr)\Bigr)\check{Z}_\mu
&&\bigl(\because\ \text{冪の約束 }x^{m+1} := x^{m}x\text{。}\blkref{scalar_exp_is_limit_of_partial_sums}\bigr)\\
&= \Bigl(\bigl(i^{2l}(-1_{\mathbb{C}})^{l}\bigr)\bigl(i\,(2k_2)^{n}\bigr)\Bigr)\check{Z}_\mu
&&\bigl(\because\ \mathbb{C}\text{ の積の可換律・結合律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \Bigl(1_{\mathbb{C}}\bigl(i\,(2k_2)^{n}\bigr)\Bigr)\check{Z}_\mu
&&\bigl(\because\ \text{準備の }(\ddagger)\bigr)\\
&= \bigl(i\,(2k_2)^{n}\bigr)\check{Z}_\mu
&&\bigl(\because\ \mathbb{C}\text{ の積の単位元。}\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`),
      paragraph([
        "(h2.z)・(h2.y)、",
        math(String.raw`n`),
        " が偶数のとき。",
        math(String.raw`W_\mu \in \{\check{Z}_\mu, \check{Y}_\mu\}`),
        " とする（",
        math(String.raw`W_\mu = \check{Z}_\mu`),
        " が (h2.z)、",
        math(String.raw`W_\mu = \check{Y}_\mu`),
        " が (h2.y) である）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\underbrace{\left[i\bigl(k_2 H_2\bigr),\dots,\left[i\bigl(k_2 H_2\bigr),W_\mu\right]\dots\right]}_{n}
&= \mathrm{ad}^{n}_{i(k_2 H_2)}(W_\mu)
&&\bigl(\because\ n\text{ 重交換子の記法}\bigr)\\
&= i^{n}\,\mathrm{ad}^{n}_{k_2 H_2}(W_\mu)
&&\bigl(\because\ \text{準備の }(\star)\text{ を }\alpha = i,\ X = k_2 H_2,\ W = W_\mu,\ m = n\text{ で}\bigr)\\
&= i^{n}\Bigl(\bigl((-1_{\mathbb{C}})^{l}(2k_2)^{n}\bigr)W_\mu\Bigr)
&&\bigl(\because\ \blkref{nesting_of_commutator_of_H_and_check_Z}\text{ (h2.z)・(h2.y) の偶数の場合と }n/2 = l\bigr)\\
&= \Bigl(i^{n}\bigl((-1_{\mathbb{C}})^{l}(2k_2)^{n}\bigr)\Bigr)W_\mu
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&= \Bigl(i^{2l}\bigl((-1_{\mathbb{C}})^{l}(2k_2)^{n}\bigr)\Bigr)W_\mu
&&\bigl(\because\ n = 2l\bigr)\\
&= \Bigl(\bigl(i^{2l}(-1_{\mathbb{C}})^{l}\bigr)(2k_2)^{n}\Bigr)W_\mu
&&\bigl(\because\ \mathbb{C}\text{ の積の結合律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \bigl(1_{\mathbb{C}}(2k_2)^{n}\bigr)W_\mu
&&\bigl(\because\ \text{準備の }(\ddagger)\bigr)\\
&= (2k_2)^{n}\,W_\mu
&&\bigl(\because\ \mathbb{C}\text{ の積の単位元。}\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-11（Lean の通しの証明のゴールラインの確認）: 前置きで各自に置いていた i/2 := i·2_C^{-1} を def_complex_quotient の商（z→i, w→2_C）の参照に替え、2_C ∈ C^× を inclusion_rr_to_cc・multiplicative_group_of_cc で書いた。帰納段階の i/2 を開く行の根拠を def_complex_quotient に、2_C^{-1}2_C = 1_C の行の逆元を multiplicative_group_of_cc にした。主張と鎖の式は変えていない。",
        "008 章の cosh_sinh_coefficient_conversion と同一形の計算を半整数運動量について繰り返したもの。用いる補題 1・補題 2 は θ にも Z,Y にも依存しない純代数的な主張なので、そのまま同じものを使える。",
        "M=2,3,4,5、μ=1..M、n=0..8 で数値確認済み（sagemath/check/047_claim_even_sector_T_action/check_01_nested_commutators.sage の scaled 列）。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-11-02（全証明の SageMath 検算。sagemath/check/cosh_sinh_coefficient_conversion_for_check/）: 主張を nesting_of_commutator_of_H_and_check_Z の新しい表記にそろえ、K_1・K_2^*・θ̃ を inclusion_rr_to_cc の像で、生成子をスカラー倍 (i/2)((K_1)_C H_1^{(+)})・i((K_2^*)_C H_2) と、係数を一つの複素数にまとめたスカラー倍で書き、i・-i・i/2 と冪の約束を明記した（主張の中身は不変）。証明は、補題 1 の散文（「合成の各段からスカラーを前へ出せる」）を m についての帰納法の鎖に、その中の交換子の線型性を新しい主張 commutator_of_scalar_multiples への参照に、補題 2（i^n の偶奇。偶数冪・積の冪の法則を根拠なしで使っていた）と各鎖の (i/2)^n = i^n 2^{-n}・(2K_1)^n = 2^n K_1^n・(-1)^{a}(-1)^{b} = (-1)^{a+b} の行を、冪の約束だけから帰納法で示す二つの準備 (i/2)^m(2k)^m = i^m k^m と i^{2l}(-1)^l = 1 に置き換え、i i = -1 と (-1)(-1) = 1 を definition_of_cc の積から示した。偶数の場合は (h1.z)・(h1.y)、(h2.z)・(h2.y) をそれぞれ一本の鎖にまとめ、鎖の後の散文の照合を除いた。",
      ],
    },
  },
  {
    id: "evensectorT_claim_exponential_series_of_even_odd_power_terms",
    kind: "claim",
    title: { text: "偶数番目と奇数番目が数の冪のスカラー倍である行列の列の指数級数" },
    labels: ["exponential_series_of_even_odd_power_terms"],
    statement: [
      paragraph([
        math(String.raw`d \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(d,\mathbb{C})`),
        "、",
        math(String.raw`x \in \mathbb{R}`),
        " とその像 ",
        math(String.raw`x_{\mathbb{C}} \in \mathbb{C}`),
        "（",
        ref("inclusion_rr_to_cc"),
        "）、",
        math(String.raw`c \in \mathbb{C}`),
        " とする。数の冪は ",
        math(String.raw`\mathbb{R}`),
        " では ",
        ref("def_power_of_real_number"),
        "、",
        math(String.raw`\mathbb{C}`),
        " では ",
        ref("def_power_of_complex_number"),
        " による（どちらも ",
        ref("scalar_exp_is_limit_of_partial_sums"),
        " の約束 ",
        math(String.raw`y^{0} := 1`),
        "、",
        math(String.raw`y^{m+1} := y^{m}y`),
        " と同じ式で定まる）、係数と行列の積はスカラー倍（",
        ref("def_matrix_scalar_multiple"),
        "）、",
        math(String.raw`\cosh, \sinh`),
        " は ",
        ref("def_cosh_sinh"),
        "、行列の列の収束と級数の和は ",
        ref("def_matrix_norm"),
        " による。",
        math(String.raw`\mathrm{Mat}(d,\mathbb{C})`),
        " の列 ",
        math(String.raw`(T_n)_{n \in \mathbb{Z}_{\geq 0}}`),
        " が",
      ]),
      displayMath(
        String.raw`T_n = \begin{cases}
(x_{\mathbb{C}})^{n}\,A & (n \text{ 偶数}) \\
\bigl(c\,(x_{\mathbb{C}})^{n}\bigr)B & (n \text{ 奇数})
\end{cases}`,
      ),
      paragraph([
        "を満たすとする。このとき級数 ",
        math(String.raw`\sum_{n=0}^{\infty}\bigl(\tfrac{1}{n!}\bigr)_{\mathbb{C}}\,T_n`),
        " は ",
        math(String.raw`\mathrm{Mat}(d,\mathbb{C})`),
        " において収束し、",
      ]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty}\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}\,T_n
= (\cosh x)_{\mathbb{C}}\,A + \bigl(c\,(\sinh x)_{\mathbb{C}}\bigr)B`,
      ),
      paragraph([
        "である（",
        math(String.raw`\mathbb{R}`),
        " への脱出: 実数の ",
        math(String.raw`\exp`),
        "（",
        ref("def_scalar_exp"),
        "）の値と、部分和の極限）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`N \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`S_N := \sum_{n=0}^{N}\bigl(\tfrac{1}{n!}\bigr)_{\mathbb{C}}\,T_n \in \mathrm{Mat}(d,\mathbb{C})`),
        "（",
        ref("def_finite_sum_of_matrices"),
        "）、",
        math(String.raw`y \in \mathbb{R}`),
        " について ",
        math(String.raw`E_N(y) := \sum_{n=0}^{N}\frac{y^n}{n!} \in \mathbb{R}`),
        "（",
        ref("scalar_exp_is_limit_of_partial_sums"),
        " の部分和）、",
        math(String.raw`\alpha_N := \frac{E_N(x) + E_N(-x)}{2} \in \mathbb{R}`),
        "、",
        math(String.raw`\beta_N := \frac{E_N(x) - E_N(-x)}{2} \in \mathbb{R}`),
        "、",
        math(String.raw`L := (\cosh x)_{\mathbb{C}}\,A + \bigl(c\,(\sinh x)_{\mathbb{C}}\bigr)B \in \mathrm{Mat}(d,\mathbb{C})`),
        " とおく。",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`a_n := \frac{x^n + (-x)^n}{2\cdot n!} \in \mathbb{R}`),
        "、",
        math(String.raw`b_n := \frac{x^n - (-x)^n}{2\cdot n!} \in \mathbb{R}`),
        " とおく。",
      ]),
      paragraph([
        "準備（",
        math(String.raw`a_n, b_n`),
        " の値）: ",
        math(String.raw`n`),
        " が偶数のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
a_n
&= \frac{x^n + (-1)^n x^n}{2\cdot n!}
&&(\because \text{実数の冪}\ (-x)^n = (-1)^n x^n) \\
&= \frac{x^n + x^n}{2\cdot n!}
&&(\because n\ \text{偶数より}\ (-1)^n = 1) \\
&= \frac{x^n}{n!}
&&(\because \text{実数の四則}),
\\[4pt]
b_n
&= \frac{x^n - (-1)^n x^n}{2\cdot n!}
&&(\because \text{実数の冪}\ (-x)^n = (-1)^n x^n) \\
&= \frac{x^n - x^n}{2\cdot n!}
&&(\because n\ \text{偶数より}\ (-1)^n = 1) \\
&= 0
&&(\because \text{実数の四則})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`n`),
        " が奇数のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
a_n
&= \frac{x^n + (-1)^n x^n}{2\cdot n!}
&&(\because \text{実数の冪}\ (-x)^n = (-1)^n x^n) \\
&= \frac{x^n + (-1)x^n}{2\cdot n!}
&&(\because n\ \text{奇数より}\ (-1)^n = -1) \\
&= 0
&&(\because \text{実数の四則}),
\\[4pt]
b_n
&= \frac{x^n - (-1)^n x^n}{2\cdot n!}
&&(\because \text{実数の冪}\ (-x)^n = (-1)^n x^n) \\
&= \frac{x^n - (-1)x^n}{2\cdot n!}
&&(\because n\ \text{奇数より}\ (-1)^n = -1) \\
&= \frac{x^n}{n!}
&&(\because \text{実数の四則})
\end{aligned}`,
      ),
      paragraph(["である。"]),
      paragraph([
        "中間目標: 各項。",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`\bigl(\tfrac{1}{n!}\bigr)_{\mathbb{C}}\,T_n = (a_n)_{\mathbb{C}}\,A + \bigl(c\,(b_n)_{\mathbb{C}}\bigr)B`),
        " である。",
        math(String.raw`n`),
        " が偶数のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}\,T_n
&= \Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}\bigl((x_{\mathbb{C}})^{n}\,A\bigr)
&&(\because T_n\ \text{の仮定の偶数の場合}) \\
&= \Bigl(\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}(x_{\mathbb{C}})^{n}\Bigr)A
&&(\because \blkref{scalar_multiple_is_associative}) \\
&= \Bigl(\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}(x^{n})_{\mathbb{C}}\Bigr)A
&&(\because \blkref{real_inclusion_preserves_power}\ (r \to x,\ m \to n)\ \text{を右辺から左辺へ}) \\
&= \Bigl(\frac{1}{n!}\,x^{n}\Bigr)_{\mathbb{C}}A
&&(\because \blkref{real_inclusion_preserves_product}) \\
&= (a_n)_{\mathbb{C}}\,A
&&(\because \text{準備の}\ n\ \text{偶数の}\ a_n = x^n/n!) \\
&= (a_n)_{\mathbb{C}}\,A + O
&&(\because \blkref{matrix_plus_zero_matrix}) \\
&= (a_n)_{\mathbb{C}}\,A + 0_{\mathbb{C}}\,B
&&(\because \blkref{zero_scalar_multiple_is_zero_matrix}) \\
&= (a_n)_{\mathbb{C}}\,A + \bigl(c\,0_{\mathbb{C}}\bigr)B
&&(\because \blkref{complex_times_zero_is_zero}) \\
&= (a_n)_{\mathbb{C}}\,A + \bigl(c\,(0)_{\mathbb{C}}\bigr)B
&&(\because \blkref{inclusion_rr_to_cc}\ \text{の略記}\ 0_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(0)) \\
&= (a_n)_{\mathbb{C}}\,A + \bigl(c\,(b_n)_{\mathbb{C}}\bigr)B
&&(\because \text{準備の}\ n\ \text{偶数の}\ b_n = 0)
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`n`),
        " が奇数のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}\,T_n
&= \Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}\Bigl(\bigl(c\,(x_{\mathbb{C}})^{n}\bigr)B\Bigr)
&&(\because T_n\ \text{の仮定の奇数の場合}) \\
&= \Bigl(\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}\bigl(c\,(x_{\mathbb{C}})^{n}\bigr)\Bigr)B
&&(\because \blkref{scalar_multiple_is_associative}) \\
&= \Bigl(\Bigl(\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}c\Bigr)(x_{\mathbb{C}})^{n}\Bigr)B
&&(\because \blkref{complex_numbers_form_a_field}\ \text{の積の結合律}) \\
&= \Bigl(\Bigl(c\,\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}\Bigr)(x_{\mathbb{C}})^{n}\Bigr)B
&&(\because \blkref{complex_numbers_form_a_field}\ \text{の積の可換律}) \\
&= \Bigl(c\,\Bigl(\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}(x_{\mathbb{C}})^{n}\Bigr)\Bigr)B
&&(\because \blkref{complex_numbers_form_a_field}\ \text{の積の結合律}) \\
&= \Bigl(c\,\Bigl(\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}(x^{n})_{\mathbb{C}}\Bigr)\Bigr)B
&&(\because \blkref{real_inclusion_preserves_power}\ (r \to x,\ m \to n)\ \text{を右辺から左辺へ}) \\
&= \Bigl(c\,\Bigl(\frac{1}{n!}\,x^{n}\Bigr)_{\mathbb{C}}\Bigr)B
&&(\because \blkref{real_inclusion_preserves_product}) \\
&= \bigl(c\,(b_n)_{\mathbb{C}}\bigr)B
&&(\because \text{準備の}\ n\ \text{奇数の}\ b_n = x^n/n!) \\
&= O + \bigl(c\,(b_n)_{\mathbb{C}}\bigr)B
&&(\because \blkref{zero_matrix_plus_matrix}) \\
&= 0_{\mathbb{C}}\,A + \bigl(c\,(b_n)_{\mathbb{C}}\bigr)B
&&(\because \blkref{zero_scalar_multiple_is_zero_matrix}) \\
&= (0)_{\mathbb{C}}\,A + \bigl(c\,(b_n)_{\mathbb{C}}\bigr)B
&&(\because \blkref{inclusion_rr_to_cc}\ \text{の略記}\ 0_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(0)) \\
&= (a_n)_{\mathbb{C}}\,A + \bigl(c\,(b_n)_{\mathbb{C}}\bigr)B
&&(\because \text{準備の}\ n\ \text{奇数の}\ a_n = 0)
\end{aligned}`,
      ),
      paragraph([
        "である。中間目標: 部分和。",
        math(String.raw`S_N = (\alpha_N)_{\mathbb{C}}\,A + \bigl(c\,(\beta_N)_{\mathbb{C}}\bigr)B`),
        " である。",
        math(String.raw`p, q \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(S_N)_{pq}
&= \sum_{n=0}^{N}\Bigl(\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}\,T_n\Bigr)_{pq}
&&(\because \blkref{finite_sum_of_matrices_entrywise}) \\
&= \sum_{n=0}^{N}\Bigl((a_n)_{\mathbb{C}}\,A + \bigl(c\,(b_n)_{\mathbb{C}}\bigr)B\Bigr)_{pq}
&&(\because \text{各項の中間目標}) \\
&= \sum_{n=0}^{N}\Bigl(\bigl((a_n)_{\mathbb{C}}\,A\bigr)_{pq} + \Bigl(\bigl(c\,(b_n)_{\mathbb{C}}\bigr)B\Bigr)_{pq}\Bigr)
&&(\because \blkref{def_matrix_sum}) \\
&= \sum_{n=0}^{N}\Bigl((a_n)_{\mathbb{C}}\,A_{pq} + \bigl(c\,(b_n)_{\mathbb{C}}\bigr)B_{pq}\Bigr)
&&(\because \blkref{def_matrix_scalar_multiple}) \\
&= \sum_{n=0}^{N}(a_n)_{\mathbb{C}}\,A_{pq} + \sum_{n=0}^{N}\bigl(c\,(b_n)_{\mathbb{C}}\bigr)B_{pq}
&&(\because \blkref{finite_sum_of_complex_sums}) \\
&= \Bigl(\sum_{n=0}^{N}(a_n)_{\mathbb{C}}\Bigr)A_{pq} + \Bigl(c\sum_{n=0}^{N}(b_n)_{\mathbb{C}}\Bigr)B_{pq}
&&(\because \mathbb{C}\ \text{の有限和の分配則}) \\
&= \Bigl(\sum_{n=0}^{N}a_n\Bigr)_{\mathbb{C}}A_{pq} + \Bigl(c\Bigl(\sum_{n=0}^{N}b_n\Bigr)_{\mathbb{C}}\Bigr)B_{pq}
&&(\because \blkref{real_inclusion_preserves_finite_sum}\ \text{を 2 箇所へ同時適用}) \\
&= \Bigl(\frac{1}{2}\Bigl(\sum_{n=0}^{N}\frac{x^n}{n!} + \sum_{n=0}^{N}\frac{(-x)^n}{n!}\Bigr)\Bigr)_{\mathbb{C}}A_{pq}
 + \Bigl(c\Bigl(\frac{1}{2}\Bigl(\sum_{n=0}^{N}\frac{x^n}{n!} - \sum_{n=0}^{N}\frac{(-x)^n}{n!}\Bigr)\Bigr)_{\mathbb{C}}\Bigr)B_{pq}
&&(\because \text{実数の有限和の分配則}) \\
&= (\alpha_N)_{\mathbb{C}}\,A_{pq} + \bigl(c\,(\beta_N)_{\mathbb{C}}\bigr)B_{pq}
&&(\because E_N, \alpha_N, \beta_N\ \text{の定義}) \\
&= \bigl((\alpha_N)_{\mathbb{C}}\,A\bigr)_{pq} + \Bigl(\bigl(c\,(\beta_N)_{\mathbb{C}}\bigr)B\Bigr)_{pq}
&&(\because \blkref{def_matrix_scalar_multiple}) \\
&= \Bigl((\alpha_N)_{\mathbb{C}}\,A + \bigl(c\,(\beta_N)_{\mathbb{C}}\bigr)B\Bigr)_{pq}
&&(\because \blkref{def_matrix_sum})
\end{aligned}`,
      ),
      paragraph([
        "であり、行列は成分で定まるので中間目標が成り立つ。中間目標: 差。",
        math(String.raw`S_N - L = (\alpha_N - \cosh x)_{\mathbb{C}}\,A + \bigl(c\,(\beta_N - \sinh x)_{\mathbb{C}}\bigr)B`),
        " である。",
        math(String.raw`p, q \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(S_N - L)_{pq}
&= (S_N)_{pq} - L_{pq}
&&(\because \blkref{def_matrix_difference}) \\
&= \Bigl((\alpha_N)_{\mathbb{C}}\,A_{pq} + \bigl(c\,(\beta_N)_{\mathbb{C}}\bigr)B_{pq}\Bigr) - L_{pq}
&&(\because \text{部分和の中間目標の成分の鎖}) \\
&= \Bigl((\alpha_N)_{\mathbb{C}}\,A_{pq} + \bigl(c\,(\beta_N)_{\mathbb{C}}\bigr)B_{pq}\Bigr)
 - \Bigl((\cosh x)_{\mathbb{C}}\,A + \bigl(c\,(\sinh x)_{\mathbb{C}}\bigr)B\Bigr)_{pq}
&&(\because L\ \text{の定義}) \\
&= \Bigl((\alpha_N)_{\mathbb{C}}\,A_{pq} + \bigl(c\,(\beta_N)_{\mathbb{C}}\bigr)B_{pq}\Bigr)
 - \Bigl(\bigl((\cosh x)_{\mathbb{C}}\,A\bigr)_{pq} + \Bigl(\bigl(c\,(\sinh x)_{\mathbb{C}}\bigr)B\Bigr)_{pq}\Bigr)
&&(\because \blkref{def_matrix_sum}) \\
&= \Bigl((\alpha_N)_{\mathbb{C}}\,A_{pq} + \bigl(c\,(\beta_N)_{\mathbb{C}}\bigr)B_{pq}\Bigr)
 - \Bigl((\cosh x)_{\mathbb{C}}\,A_{pq} + \bigl(c\,(\sinh x)_{\mathbb{C}}\bigr)B_{pq}\Bigr)
&&(\because \blkref{def_matrix_scalar_multiple}) \\
&= \bigl((\alpha_N)_{\mathbb{C}} - (\cosh x)_{\mathbb{C}}\bigr)A_{pq}
 + \Bigl(c\,\bigl((\beta_N)_{\mathbb{C}} - (\sinh x)_{\mathbb{C}}\bigr)\Bigr)B_{pq}
&&(\because \mathbb{C}\ \text{の四則}) \\
&= (\alpha_N - \cosh x)_{\mathbb{C}}\,A_{pq} + \bigl(c\,(\beta_N - \sinh x)_{\mathbb{C}}\bigr)B_{pq}
&&(\because \blkref{real_inclusion_preserves_difference}\ \text{を 2 箇所へ同時適用}) \\
&= \bigl((\alpha_N - \cosh x)_{\mathbb{C}}\,A\bigr)_{pq} + \Bigl(\bigl(c\,(\beta_N - \sinh x)_{\mathbb{C}}\bigr)B\Bigr)_{pq}
&&(\because \blkref{def_matrix_scalar_multiple}) \\
&= \Bigl((\alpha_N - \cosh x)_{\mathbb{C}}\,A + \bigl(c\,(\beta_N - \sinh x)_{\mathbb{C}}\bigr)B\Bigr)_{pq}
&&(\because \blkref{def_matrix_sum})
\end{aligned}`,
      ),
      paragraph([
        "であり、行列は成分で定まるので中間目標が成り立つ。中間目標: 実数の評価。",
        math(String.raw`u_N := \bigl|E_N(x) - \exp(x)\bigr| \in \mathbb{R}_{\geq 0}`),
        "、",
        math(String.raw`v_N := \bigl|E_N(-x) - \exp(-x)\bigr| \in \mathbb{R}_{\geq 0}`),
        " とおく（",
        math(String.raw`\mathbb{R}`),
        " の絶対値。",
        math(String.raw`\exp`),
        " は実数の ",
        math(String.raw`\exp`),
        "（",
        ref("def_scalar_exp"),
        "））。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\bigl|\alpha_N - \cosh x\bigr|
&= \Bigl|\frac{E_N(x) + E_N(-x)}{2} - \cosh x\Bigr|
&&(\because \alpha_N\ \text{の定義}) \\
&= \Bigl|\frac{E_N(x) + E_N(-x)}{2} - \frac{\exp(x) + \exp(-x)}{2}\Bigr|
&&(\because \blkref{def_cosh_sinh}) \\
&= \Bigl|\frac{\bigl(E_N(x) - \exp(x)\bigr) + \bigl(E_N(-x) - \exp(-x)\bigr)}{2}\Bigr|
&&(\because \text{実数の四則}) \\
&= \frac{\bigl|\bigl(E_N(x) - \exp(x)\bigr) + \bigl(E_N(-x) - \exp(-x)\bigr)\bigr|}{2}
&&(\because \text{実数の絶対値は正の数で割ることと交換する}) \\
&\leq \frac{u_N + v_N}{2}
&&(\because \text{実数の絶対値の三角不等式と}\ |{-y}| = |y|),
\\[4pt]
\bigl|\beta_N - \sinh x\bigr|
&= \Bigl|\frac{E_N(x) - E_N(-x)}{2} - \sinh x\Bigr|
&&(\because \beta_N\ \text{の定義}) \\
&= \Bigl|\frac{E_N(x) - E_N(-x)}{2} - \frac{\exp(x) - \exp(-x)}{2}\Bigr|
&&(\because \blkref{def_cosh_sinh}) \\
&= \Bigl|\frac{\bigl(E_N(x) - \exp(x)\bigr) - \bigl(E_N(-x) - \exp(-x)\bigr)}{2}\Bigr|
&&(\because \text{実数の四則}) \\
&= \frac{\bigl|\bigl(E_N(x) - \exp(x)\bigr) - \bigl(E_N(-x) - \exp(-x)\bigr)\bigr|}{2}
&&(\because \text{実数の絶対値は正の数で割ることと交換する}) \\
&\leq \frac{u_N + v_N}{2}
&&(\because \text{実数の絶対値の三角不等式と}\ |{-y}| = |y|)
\end{aligned}`,
      ),
      paragraph([
        "である。中間目標: ノルムの評価。",
        math(String.raw`\kappa := \|A\| + |c|\,\|B\| \in \mathbb{R}_{\geq 0}`),
        " とおく（",
        ref("def_matrix_norm"),
        "、",
        ref("def_abs_arg"),
        "）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|S_N - L\|
&= \Bigl\|(\alpha_N - \cosh x)_{\mathbb{C}}\,A + \bigl(c\,(\beta_N - \sinh x)_{\mathbb{C}}\bigr)B\Bigr\|
&&(\because \text{差の中間目標}) \\
&\leq \bigl\|(\alpha_N - \cosh x)_{\mathbb{C}}\,A\bigr\| + \Bigl\|\bigl(c\,(\beta_N - \sinh x)_{\mathbb{C}}\bigr)B\Bigr\|
&&(\because \blkref{matrix_norm_triangle_inequality}\ (3)) \\
&= \bigl|(\alpha_N - \cosh x)_{\mathbb{C}}\bigr|\,\|A\| + \bigl|c\,(\beta_N - \sinh x)_{\mathbb{C}}\bigr|\,\|B\|
&&(\because \blkref{matrix_norm_triangle_inequality}\ (2)\ \text{を 2 項へ同時適用}) \\
&= \bigl|(\alpha_N - \cosh x)_{\mathbb{C}}\bigr|\,\|A\| + \Bigl(|c|\,\bigl|(\beta_N - \sinh x)_{\mathbb{C}}\bigr|\Bigr)\|B\|
&&(\because \blkref{abs_basic_properties}\ (4)) \\
&= \bigl|\alpha_N - \cosh x\bigr|\,\|A\| + \Bigl(|c|\,\bigl|\beta_N - \sinh x\bigr|\Bigr)\|B\|
&&(\because \blkref{abs_basic_properties}\ (6)\ \text{を 2 箇所へ同時適用}) \\
&\leq \frac{u_N + v_N}{2}\,\|A\| + \Bigl(|c|\,\frac{u_N + v_N}{2}\Bigr)\|B\|
&&(\because \text{実数の評価の中間目標と}\ \|A\| \geq 0,\ |c| \geq 0,\ \|B\| \geq 0) \\
&= \frac{u_N + v_N}{2}\bigl(\|A\| + |c|\,\|B\|\bigr)
&&(\because \text{実数の四則}) \\
&= \frac{u_N + v_N}{2}\,\kappa
&&(\because \kappa\ \text{の定義})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        ref("scalar_exp_is_limit_of_partial_sums"),
        " を ",
        math(String.raw`K = \mathbb{R}`),
        " で ",
        math(String.raw`x`),
        " と ",
        math(String.raw`-x`),
        " へ当てると、",
        ref("def_matrix_norm"),
        " の ",
        math(String.raw`K`),
        " の列の収束の意味で ",
        math(String.raw`u_N \to 0`),
        "、",
        math(String.raw`v_N \to 0`),
        " である（",
        math(String.raw`\mathbb{R}`),
        " への脱出: 極限）。",
        math(String.raw`\varepsilon \in \mathbb{R}_{>0}`),
        " に対し、",
        math(String.raw`N \geq N_1`),
        " で ",
        math(String.raw`u_N < \varepsilon/(\kappa+1)`),
        "、",
        math(String.raw`N \geq N_2`),
        " で ",
        math(String.raw`v_N < \varepsilon/(\kappa+1)`),
        " となる ",
        math(String.raw`N_1, N_2 \in \mathbb{Z}_{\geq 0}`),
        " を取ると、",
        math(String.raw`N \geq \max(N_1, N_2)`),
        " で",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|S_N - L\|
&\leq \frac{u_N + v_N}{2}\,\kappa
&&(\because \text{ノルムの評価の中間目標}) \\
&\leq \frac{\varepsilon}{\kappa+1}\,\kappa
&&(\because \tfrac{u_N + v_N}{2} < \tfrac{\varepsilon}{\kappa+1}\ \text{と}\ \kappa \geq 0) \\
&< \varepsilon
&&(\because \kappa < \kappa + 1\ \text{と}\ \varepsilon > 0)
\end{aligned}`,
      ),
      paragraph([
        "である。よって ",
        math(String.raw`\|S_N - L\| \to 0`),
        "、すなわち ",
        ref("def_matrix_norm"),
        " の意味で ",
        math(String.raw`S_N \to L`),
        " であり、級数は収束して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{n=0}^{\infty}\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}\,T_n
&= \lim_{N\to\infty} S_N
&&(\because \blkref{def_matrix_norm}\ \text{の級数の和。極限は}\ \blkref{matrix_norm_triangle_inequality}\ (4)\ \text{により一意}) \\
&= L
&&(\because S_N \to L) \\
&= (\cosh x)_{\mathbb{C}}\,A + \bigl(c\,(\sinh x)_{\mathbb{C}}\bigr)B
&&(\because L\ \text{の定義})
\end{aligned}`,
      ),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02（全証明の SageMath 検算。sagemath/check/exponential_series_of_even_odd_power_terms/）: extract_taylor_coefficient_of_check_Z_Y の証明が、級数を偶数項と奇数項の二つの級数に分けて n に依らない因子を和の外へ出し、証明の無い sinh_cosh_taylor_series を代入していた（無限和の並べ替えと分割の根拠が無かった）ので、その四つの式に共通の計算を部分和の等式と極限で示すこの主張として切り出した。偶奇の場合分けは a_n・b_n の (x^n ± (-x)^n)/(2·n!) にまとめ、極限は bridge の two_by_two_transfer_identity の証明と同じく E_N(±x) と三角不等式で取る。",
        "2026-11-09（Lean の通しの証明のゴールラインの確認）: 準備（冪の像）(x_C)^n = (x^n)_C の帰納法は real_inclusion_preserves_power と向きが逆なだけの同じ内容だったので外し、中間目標「各項」の 2 か所でその主張を右辺から左辺へ引くようにした。主張の冪の約束を def_power_of_real_number・def_power_of_complex_number の参照にした（式は scalar_exp_is_limit_of_partial_sums の約束と同じ）。値と主張は不変。",
        "2026-11-10（Lean の通しの証明のゴールラインの確認）: 準備（実数の差の像）の 6 行の鎖を主張 real_inclusion_preserves_difference として切り出し、中間目標「差」の 1 か所でその主張を引くようにした。鎖の中身・値と主張は不変。",
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
        " とし、",
        math(String.raw`R`),
        "、",
        math(String.raw`H_1^{(+)}, H_2, \check{Z}_\mu, \check{Y}_\mu \in R`),
        "、",
        math(String.raw`K_1, K_2^* \in \mathbb{R}`),
        " とその像 ",
        math(String.raw`(K_1)_{\mathbb{C}}, (K_2^*)_{\mathbb{C}}`),
        "、",
        math(String.raw`\tilde\theta := \tilde\theta_\mu`),
        " とその像 ",
        math(String.raw`(\tilde\theta)_{\mathbb{C}}`),
        "、",
        math(String.raw`i, -i, \tfrac{i}{2} \in \mathbb{C}`),
        "、冪の約束、",
        math(String.raw`n`),
        " 重交換子の記法は ",
        ref("cosh_sinh_coefficient_conversion_for_check"),
        " のものとする。",
        math(String.raw`2K_2^* \in \mathbb{R}`),
        " は実数の積、",
        math(String.raw`(1/n!)_{\mathbb{C}}`),
        " は ",
        math(String.raw`1/n! \in \mathbb{R}`),
        " の ",
        ref("inclusion_rr_to_cc"),
        " による像、",
        math(String.raw`\cosh, \sinh`),
        " は ",
        ref("def_cosh_sinh"),
        "、係数と行列の積はスカラー倍（",
        ref("def_matrix_scalar_multiple"),
        "）、級数の和は ",
        ref("def_matrix_norm"),
        " による。このとき次の 4 つの級数は ",
        math(String.raw`R`),
        " において収束し、それぞれ次に等しい（",
        math(String.raw`\mathbb{R}`),
        " への脱出: 実数の ",
        math(String.raw`\exp`),
        " の値と、部分和の極限）。",
      ]),
      paragraph(["(h1.z)"]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}
\underbrace{\left[\tfrac{i}{2}\bigl((K_1)_{\mathbb{C}} H_1^{(+)}\bigr),\dots,\left[\tfrac{i}{2}\bigl((K_1)_{\mathbb{C}} H_1^{(+)}\bigr),\check{Z}_\mu\right]\dots\right]}_{n}
= (\cosh K_1)_{\mathbb{C}}\,\check{Z}_\mu
 + \Bigl(\bigl(i\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)(\sinh K_1)_{\mathbb{C}}\Bigr)\check{Y}_\mu`,
      ),
      paragraph(["(h1.y)"]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}
\underbrace{\left[\tfrac{i}{2}\bigl((K_1)_{\mathbb{C}} H_1^{(+)}\bigr),\dots,\left[\tfrac{i}{2}\bigl((K_1)_{\mathbb{C}} H_1^{(+)}\bigr),\check{Y}_\mu\right]\dots\right]}_{n}
= \Bigl(\bigl((-i)\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)(\sinh K_1)_{\mathbb{C}}\Bigr)\check{Z}_\mu
 + (\cosh K_1)_{\mathbb{C}}\,\check{Y}_\mu`,
      ),
      paragraph(["(h2.z)"]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}
\underbrace{\left[i\bigl((K_2^*)_{\mathbb{C}} H_2\bigr),\dots,\left[i\bigl((K_2^*)_{\mathbb{C}} H_2\bigr),\check{Z}_\mu\right]\dots\right]}_{n}
= (\cosh 2K_2^*)_{\mathbb{C}}\,\check{Z}_\mu + \bigl((-i)(\sinh 2K_2^*)_{\mathbb{C}}\bigr)\check{Y}_\mu`,
      ),
      paragraph(["(h2.y)"]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}
\underbrace{\left[i\bigl((K_2^*)_{\mathbb{C}} H_2\bigr),\dots,\left[i\bigl((K_2^*)_{\mathbb{C}} H_2\bigr),\check{Y}_\mu\right]\dots\right]}_{n}
= \bigl(i\,(\sinh 2K_2^*)_{\mathbb{C}}\bigr)\check{Z}_\mu + (\cosh 2K_2^*)_{\mathbb{C}}\,\check{Y}_\mu`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`G_1 := \tfrac{i}{2}\bigl((K_1)_{\mathbb{C}} H_1^{(+)}\bigr)`),
        "、",
        math(String.raw`G_2 := i\bigl((K_2^*)_{\mathbb{C}} H_2\bigr)`),
        "、",
        math(String.raw`e_{\mp} := \exp\bigl(\mp i(\tilde\theta)_{\mathbb{C}}\bigr) \in \mathbb{C}`),
        "（",
        ref("def_scalar_exp"),
        " の複素数の exp）、",
        math(String.raw`d := 2^{M_{\mathrm{col}}}`),
        " とおき、",
        math(String.raw`n`),
        " 重交換子を ",
        math(String.raw`\mathrm{ad}^{n}_{G}(W)`),
        " と書く（",
        ref("def_ad_X_matrix"),
        "）。準備: ",
        math(String.raw`2K_2^*`),
        " の像は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
2\,(K_2^*)_{\mathbb{C}}
&= (2_{\mathbb{R}})_{\mathbb{C}}\,(K_2^*)_{\mathbb{C}}
&&(\because \blkref{cosh_sinh_coefficient_conversion_for_check}\ \text{の}\ 2 = 2_{\mathbb{C}} := (2_{\mathbb{R}})_{\mathbb{C}}) \\
&= (2K_2^*)_{\mathbb{C}}
&&(\because \blkref{real_inclusion_preserves_product})
\end{aligned}`,
      ),
      paragraph([
        "である。(h1.z): ",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " が偶数のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{ad}^{n}_{G_1}(\check{Z}_\mu)
&= (K_1)_{\mathbb{C}}^{\,n}\,\check{Z}_\mu
&&(\because \blkref{cosh_sinh_coefficient_conversion_for_check}\ \text{(h1.z) の偶数の場合})
\end{aligned}`,
      ),
      paragraph(["であり、奇数のとき"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{ad}^{n}_{G_1}(\check{Z}_\mu)
&= \bigl(i\,(K_1)_{\mathbb{C}}^{\,n}\,e_{-}\bigr)\check{Y}_\mu
&&(\because \blkref{cosh_sinh_coefficient_conversion_for_check}\ \text{(h1.z) の奇数の場合}) \\
&= \bigl(i\,\bigl((K_1)_{\mathbb{C}}^{\,n}\,e_{-}\bigr)\bigr)\check{Y}_\mu
&&(\because \blkref{complex_numbers_form_a_field}\ \text{の積の結合律}) \\
&= \bigl(i\,\bigl(e_{-}\,(K_1)_{\mathbb{C}}^{\,n}\bigr)\bigr)\check{Y}_\mu
&&(\because \blkref{complex_numbers_form_a_field}\ \text{の積の可換律}) \\
&= \bigl((i\,e_{-})\,(K_1)_{\mathbb{C}}^{\,n}\bigr)\check{Y}_\mu
&&(\because \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})
\end{aligned}`,
      ),
      paragraph([
        "である。ゆえに ",
        math(String.raw`T_n := \mathrm{ad}^{n}_{G_1}(\check{Z}_\mu)`),
        " は ",
        ref("exponential_series_of_even_odd_power_terms"),
        " の仮定を ",
        math(String.raw`d`),
        "、",
        math(String.raw`x = K_1`),
        "、",
        math(String.raw`A = \check{Z}_\mu`),
        "、",
        math(String.raw`B = \check{Y}_\mu`),
        "、",
        math(String.raw`c = i\,e_{-}`),
        " で満たし、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{n=0}^{\infty}\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}\mathrm{ad}^{n}_{G_1}(\check{Z}_\mu)
&= (\cosh K_1)_{\mathbb{C}}\,\check{Z}_\mu + \bigl((i\,e_{-})(\sinh K_1)_{\mathbb{C}}\bigr)\check{Y}_\mu
&&(\because \blkref{exponential_series_of_even_odd_power_terms})
\end{aligned}`,
      ),
      paragraph([
        "である。(h1.y): 偶数のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{ad}^{n}_{G_1}(\check{Y}_\mu)
&= (K_1)_{\mathbb{C}}^{\,n}\,\check{Y}_\mu
&&(\because \blkref{cosh_sinh_coefficient_conversion_for_check}\ \text{(h1.y) の偶数の場合})
\end{aligned}`,
      ),
      paragraph(["であり、奇数のとき"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{ad}^{n}_{G_1}(\check{Y}_\mu)
&= \bigl((-i)\,(K_1)_{\mathbb{C}}^{\,n}\,e_{+}\bigr)\check{Z}_\mu
&&(\because \blkref{cosh_sinh_coefficient_conversion_for_check}\ \text{(h1.y) の奇数の場合}) \\
&= \bigl((-i)\,\bigl((K_1)_{\mathbb{C}}^{\,n}\,e_{+}\bigr)\bigr)\check{Z}_\mu
&&(\because \blkref{complex_numbers_form_a_field}\ \text{の積の結合律}) \\
&= \bigl((-i)\,\bigl(e_{+}\,(K_1)_{\mathbb{C}}^{\,n}\bigr)\bigr)\check{Z}_\mu
&&(\because \blkref{complex_numbers_form_a_field}\ \text{の積の可換律}) \\
&= \bigl(((-i)\,e_{+})\,(K_1)_{\mathbb{C}}^{\,n}\bigr)\check{Z}_\mu
&&(\because \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})
\end{aligned}`,
      ),
      paragraph([
        "であるから、",
        ref("exponential_series_of_even_odd_power_terms"),
        " を ",
        math(String.raw`d`),
        "、",
        math(String.raw`x = K_1`),
        "、",
        math(String.raw`A = \check{Y}_\mu`),
        "、",
        math(String.raw`B = \check{Z}_\mu`),
        "、",
        math(String.raw`c = (-i)\,e_{+}`),
        " で当てて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{n=0}^{\infty}\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}\mathrm{ad}^{n}_{G_1}(\check{Y}_\mu)
&= (\cosh K_1)_{\mathbb{C}}\,\check{Y}_\mu + \bigl(((-i)\,e_{+})(\sinh K_1)_{\mathbb{C}}\bigr)\check{Z}_\mu
&&(\because \blkref{exponential_series_of_even_odd_power_terms}) \\
&= \bigl(((-i)\,e_{+})(\sinh K_1)_{\mathbb{C}}\bigr)\check{Z}_\mu + (\cosh K_1)_{\mathbb{C}}\,\check{Y}_\mu
&&(\because \blkref{matrix_sum_is_commutative})
\end{aligned}`,
      ),
      paragraph([
        "である。(h2.z): 偶数のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{ad}^{n}_{G_2}(\check{Z}_\mu)
&= \bigl(2\,(K_2^*)_{\mathbb{C}}\bigr)^{n}\,\check{Z}_\mu
&&(\because \blkref{cosh_sinh_coefficient_conversion_for_check}\ \text{(h2.z) の偶数の場合}) \\
&= \bigl((2K_2^*)_{\mathbb{C}}\bigr)^{n}\,\check{Z}_\mu
&&(\because \text{準備の}\ 2\,(K_2^*)_{\mathbb{C}} = (2K_2^*)_{\mathbb{C}})
\end{aligned}`,
      ),
      paragraph(["であり、奇数のとき"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{ad}^{n}_{G_2}(\check{Z}_\mu)
&= \Bigl((-i)\bigl(2\,(K_2^*)_{\mathbb{C}}\bigr)^{n}\Bigr)\check{Y}_\mu
&&(\because \blkref{cosh_sinh_coefficient_conversion_for_check}\ \text{(h2.z) の奇数の場合}) \\
&= \Bigl((-i)\bigl((2K_2^*)_{\mathbb{C}}\bigr)^{n}\Bigr)\check{Y}_\mu
&&(\because \text{準備の}\ 2\,(K_2^*)_{\mathbb{C}} = (2K_2^*)_{\mathbb{C}})
\end{aligned}`,
      ),
      paragraph([
        "であるから、",
        ref("exponential_series_of_even_odd_power_terms"),
        " を ",
        math(String.raw`d`),
        "、",
        math(String.raw`x = 2K_2^*`),
        "、",
        math(String.raw`A = \check{Z}_\mu`),
        "、",
        math(String.raw`B = \check{Y}_\mu`),
        "、",
        math(String.raw`c = -i`),
        " で当てて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{n=0}^{\infty}\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}\mathrm{ad}^{n}_{G_2}(\check{Z}_\mu)
&= (\cosh 2K_2^*)_{\mathbb{C}}\,\check{Z}_\mu + \bigl((-i)(\sinh 2K_2^*)_{\mathbb{C}}\bigr)\check{Y}_\mu
&&(\because \blkref{exponential_series_of_even_odd_power_terms})
\end{aligned}`,
      ),
      paragraph([
        "である。(h2.y): 偶数のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{ad}^{n}_{G_2}(\check{Y}_\mu)
&= \bigl(2\,(K_2^*)_{\mathbb{C}}\bigr)^{n}\,\check{Y}_\mu
&&(\because \blkref{cosh_sinh_coefficient_conversion_for_check}\ \text{(h2.y) の偶数の場合}) \\
&= \bigl((2K_2^*)_{\mathbb{C}}\bigr)^{n}\,\check{Y}_\mu
&&(\because \text{準備の}\ 2\,(K_2^*)_{\mathbb{C}} = (2K_2^*)_{\mathbb{C}})
\end{aligned}`,
      ),
      paragraph(["であり、奇数のとき"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{ad}^{n}_{G_2}(\check{Y}_\mu)
&= \Bigl(i\bigl(2\,(K_2^*)_{\mathbb{C}}\bigr)^{n}\Bigr)\check{Z}_\mu
&&(\because \blkref{cosh_sinh_coefficient_conversion_for_check}\ \text{(h2.y) の奇数の場合}) \\
&= \Bigl(i\bigl((2K_2^*)_{\mathbb{C}}\bigr)^{n}\Bigr)\check{Z}_\mu
&&(\because \text{準備の}\ 2\,(K_2^*)_{\mathbb{C}} = (2K_2^*)_{\mathbb{C}})
\end{aligned}`,
      ),
      paragraph([
        "であるから、",
        ref("exponential_series_of_even_odd_power_terms"),
        " を ",
        math(String.raw`d`),
        "、",
        math(String.raw`x = 2K_2^*`),
        "、",
        math(String.raw`A = \check{Y}_\mu`),
        "、",
        math(String.raw`B = \check{Z}_\mu`),
        "、",
        math(String.raw`c = i`),
        " で当てて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{n=0}^{\infty}\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}\mathrm{ad}^{n}_{G_2}(\check{Y}_\mu)
&= (\cosh 2K_2^*)_{\mathbb{C}}\,\check{Y}_\mu + \bigl(i\,(\sinh 2K_2^*)_{\mathbb{C}}\bigr)\check{Z}_\mu
&&(\because \blkref{exponential_series_of_even_odd_power_terms}) \\
&= \bigl(i\,(\sinh 2K_2^*)_{\mathbb{C}}\bigr)\check{Z}_\mu + (\cosh 2K_2^*)_{\mathbb{C}}\,\check{Y}_\mu
&&(\because \blkref{matrix_sum_is_commutative})
\end{aligned}`,
      ),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の extract_taylor_coefficient_of_Z_Y と同一形。sinh/cosh のテイラー展開は 008 章の TV1_hatZ_hatY_004_claim_sinh_cosh_taylor がラベルを持たないため、ここでは式を再掲して使った。",
        "級数を 40 次で打ち切った数値検証を M=2,3,4,5・μ=1..M・5 組の (K1,K2) で実施し、残差 1e-13 以下（sagemath/check/047_claim_even_sector_T_action/check_02_taylor_sums.sage）。",
        "4 式の係数変換の適用を各式鎖の直前から実在ラベルで参照し、(h1.y)・(h2.y) の終端の項の交換へ行列加法の可換則を明記した（2026-08-15）。",
        "2026-09-26: sinh, cosh のテイラー展開の適用を sinh_cosh_taylor_series のラベル参照で引くようにした。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-11-02（全証明の SageMath 検算。sagemath/check/extract_taylor_coefficient_of_check_Z_Y/）: 主張を cosh_sinh_coefficient_conversion_for_check の新しい表記（生成子 (i/2)((K_1)_C H_1^{(+)})・i((K_2^*)_C H_2)、K_1・K_2^*・θ̃・1/n!・cosh・sinh の値を inclusion_rr_to_cc の像で、係数を一つの複素数にまとめたスカラー倍）にそろえた（主張の中身は不変）。証明は、級数を偶数項と奇数項の二つの級数に分けて n に依らない因子を和の外へ出し、証明の無い sinh_cosh_taylor_series を代入していた（無限和の分割と並べ替えの根拠が無かった）ので、部分和と極限で示す新しい主張 exponential_series_of_even_odd_power_terms を引く形にし、係数変換の結果をその仮定の形へ並べ替える行と 2(K_2^*)_C = (2K_2^*)_C を足した。収束の根拠も matrix_exp_conjugation (1) からこの新しい主張へ移した。",
      ],
    },
  },
  {
    id: "evensectorT_definition_pair_of_matrices_times_column_of_numbers",
    kind: "definition",
    origin: { path: "structured-latex/content/014_even_sector_T_action.ts", ordinal: 7 },
    title: { tex: String.raw`\text{行列の組と数の列の積}` },
    labels: ["def_pair_of_matrices_times_column_of_numbers"],
    statement: [
      paragraph([
        math(String.raw`d\in\mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B\in\mathrm{Mat}(d,\mathbb{C})`),
        "、",
        math(String.raw`a, b\in\mathbb{C}`),
        " について、行列の組 ",
        math(String.raw`\begin{pmatrix}A, & B\end{pmatrix}`),
        " と数の列 ",
        math(String.raw`\begin{pmatrix}a \\ b\end{pmatrix}`),
        " の積を",
      ]),
      displayMath(String.raw`\begin{pmatrix}A, & B\end{pmatrix}\begin{pmatrix}a \\ b\end{pmatrix} := aA + bB\ \in\ \mathrm{Mat}(d,\mathbb{C})`),
      paragraph([
        "と定める（",
        math(String.raw`aA`),
        "・",
        math(String.raw`bB`),
        " は ",
        ref("def_matrix_scalar_multiple"),
        " のスカラー倍、和は ",
        ref("def_matrix_sum"),
        "）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02（全証明の SageMath 検算）: T_actions_on_check_Z_Y の主張の中で定めていた積を、1 ブロック 1 定義に従って切り出した。",
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
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`M`),
        " を ",
        math(String.raw`M_{\mathrm{col}}`),
        " に取った ",
        math(String.raw`R=\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を用いる。",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        "、",
        math(String.raw`\tilde\theta := \tilde\theta_\mu`),
        "、",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu \in R`),
        "（",
        ref("def_half_integer_checkZ"),
        "・",
        ref("def_half_integer_checkY"),
        "）、",
        math(String.raw`K_1, K_2^*`),
        "・",
        math(String.raw`2K_2^*`),
        " とそれらの像、",
        math(String.raw`(\tilde\theta)_{\mathbb{C}}`),
        "、",
        math(String.raw`\cosh, \sinh`),
        " は ",
        ref("extract_taylor_coefficient_of_check_Z_Y"),
        " のものとする。",
        math(String.raw`\left(V_1^{(+)}\right)^{1/2}\in R^\times`),
        "（",
        ref("def_V1_plus_square_root"),
        "・",
        ref("V1_plus_half_invertible"),
        "）と ",
        math(String.raw`V_2\in R^\times`),
        "（",
        ref("V2_invertible"),
        "）による共役 ",
        math(String.raw`T_{\left(V_1^{(+)}\right)^{1/2}}, T_{V_2}: R\to R`),
        " は ",
        ref("def_T_g"),
        "、行列の組と数の列の積は ",
        ref("def_pair_of_matrices_times_column_of_numbers"),
        " による。このとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu)
&= (\cosh K_1)_{\mathbb{C}}\,\check{Z}_\mu + \Bigl(\bigl(i\,\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)(\sinh K_1)_{\mathbb{C}}\Bigr)\check{Y}_\mu
= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\begin{pmatrix}(\cosh K_1)_{\mathbb{C}} \\ \bigl(i\,\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)(\sinh K_1)_{\mathbb{C}}\end{pmatrix} \\
T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)
&= \Bigl(\bigl((-i)\,\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)(\sinh K_1)_{\mathbb{C}}\Bigr)\check{Z}_\mu + (\cosh K_1)_{\mathbb{C}}\,\check{Y}_\mu
= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\begin{pmatrix}\bigl((-i)\,\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)(\sinh K_1)_{\mathbb{C}} \\ (\cosh K_1)_{\mathbb{C}}\end{pmatrix} \\
T_{V_2}(\check{Z}_\mu)
&= (\cosh 2K_2^*)_{\mathbb{C}}\,\check{Z}_\mu + \bigl((-i)(\sinh 2K_2^*)_{\mathbb{C}}\bigr)\check{Y}_\mu
= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\begin{pmatrix}(\cosh 2K_2^*)_{\mathbb{C}} \\ (-i)(\sinh 2K_2^*)_{\mathbb{C}}\end{pmatrix} \\
T_{V_2}(\check{Y}_\mu)
&= \bigl(i\,(\sinh 2K_2^*)_{\mathbb{C}}\bigr)\check{Z}_\mu + (\cosh 2K_2^*)_{\mathbb{C}}\,\check{Y}_\mu
= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\begin{pmatrix}i\,(\sinh 2K_2^*)_{\mathbb{C}} \\ (\cosh 2K_2^*)_{\mathbb{C}}\end{pmatrix}
\end{aligned}`,
      ),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`S := \left(V_1^{(+)}\right)^{1/2}`),
        "、",
        ref("extract_taylor_coefficient_of_check_Z_Y"),
        " の証明と同じく ",
        math(String.raw`G_1 := \tfrac{i}{2}\bigl((K_1)_{\mathbb{C}} H_1^{(+)}\bigr)`),
        "、",
        math(String.raw`G_2 := i\bigl((K_2^*)_{\mathbb{C}} H_2\bigr)`),
        "、",
        math(String.raw`n`),
        " 重交換子を ",
        math(String.raw`\mathrm{ad}^{n}_{G}(W)`),
        "（",
        ref("def_ad_X_matrix"),
        "）と書き、",
        ref("V1_plus_half_invertible"),
        " の証明と同じく ",
        math(String.raw`X := \bigl(\tfrac{i}{2}(K_1)_{\mathbb{C}}\bigr)H_1^{(+)}\in R`),
        " と置く（",
        ref("def_V1_plus_square_root"),
        " が ",
        math(String.raw`\mathbb{R}_{>0}\subset\mathbb{C}`),
        " と書いて掛けている ",
        math(String.raw`K_1`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の像 ",
        math(String.raw`(K_1)_{\mathbb{C}}`),
        " である）。",
        math(String.raw`a`),
        "・",
        math(String.raw`a^{-1}`),
        "・",
        math(String.raw`Y`),
        " は ",
        ref("V2_invertible"),
        " の主張のものとする（",
        ref("V2_exponential_representation"),
        " が ",
        math(String.raw`\mathbb{R}_{>0}\subset\mathbb{C}`),
        " と書いて掛けている ",
        math(String.raw`K_2^*`),
        " と係数 ",
        math(String.raw`(2s_2)^{M_{\mathrm{col}}/2}`),
        " は、それぞれ ",
        math(String.raw`(K_2^*)_{\mathbb{C}}`),
        " と ",
        math(String.raw`a_{\mathbb{C}}`),
        " である）。級数の係数 ",
        math(String.raw`1/n!\in\mathbb{R}`),
        " は ",
        ref("def_matrix_scalar_multiple"),
        " のスカラー倍として掛けるので、",
        ref("inclusion_rr_to_cc"),
        " による像を ",
        math(String.raw`(1/n!)_{\mathbb{C}}`),
        " と書く。準備: 指数の肩は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
X
&= \bigl(\tfrac{i}{2}(K_1)_{\mathbb{C}}\bigr)H_1^{(+)}
&&(\because\ X\ \text{の置き方})\\
&= \tfrac{i}{2}\bigl((K_1)_{\mathbb{C}}H_1^{(+)}\bigr)
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\ (a\to\tfrac{i}{2},\ b\to(K_1)_{\mathbb{C}},\ A\to H_1^{(+)})\bigr)\\
&= G_1
&&(\because\ G_1\ \text{の置き方}),\\[2mm]
Y
&= \bigl(i(K_2^*)_{\mathbb{C}}\bigr)H_2
&&\bigl(\because\ \blkref{V2_invertible}\ \text{の}\ Y\bigr)\\
&= i\bigl((K_2^*)_{\mathbb{C}}H_2\bigr)
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\ (a\to i,\ b\to(K_2^*)_{\mathbb{C}},\ A\to H_2)\bigr)\\
&= G_2
&&(\because\ G_2\ \text{の置き方})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`T_S(\check{Z}_\mu)`),
        "・",
        math(String.raw`T_S(\check{Y}_\mu)`),
        " は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{S}(\check{Z}_\mu)
&= (S\check{Z}_\mu)S^{-1}
&&\bigl(\because\ \blkref{def_T_g}\ (M\to M_{\mathrm{col}},\ g\to S,\ h\to \check{Z}_\mu)\bigr)\\
&= \Bigl(\exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\check{Z}_\mu\Bigr)\Bigl(\exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\Bigr)^{-1}
&&\bigl(\because\ \blkref{def_V1_plus_square_root}\ \text{を 2 か所へ同時適用}\bigr)\\
&= \bigl(\exp(X)\check{Z}_\mu\bigr)\bigl(\exp(X)\bigr)^{-1}
&&\bigl(\because\ X\ \text{の置き方}\ (K_1\ \text{は}\ \blkref{inclusion_rr_to_cc}\ \text{の}\ (K_1)_{\mathbb{C}})\bigr)\\
&= \bigl(\exp(X)\check{Z}_\mu\bigr)\exp(-X)
&&\bigl(\because\ \blkref{matrix_exp_conjugation}\ \text{(3)}\ (n\to 2^{M_{\mathrm{col}}},\ X\to X)\bigr)\\
&= \bigl(\exp(G_1)\check{Z}_\mu\bigr)\exp(-G_1)
&&(\because\ \text{準備の}\ X = G_1)\\
&= \sum_{n=0}^{\infty}\frac{1}{n!}\,\mathrm{ad}^{n}_{G_1}(\check{Z}_\mu)
&&\bigl(\because\ \blkref{exp_X_Y_exp_-X}\ (\text{同主張の}\ d,\ X,\ Y\ \text{を}\ 2^{M_{\mathrm{col}}},\ G_1,\ \check{Z}_\mu\ \text{に})\bigr)\\
&= \sum_{n=0}^{\infty}\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}\mathrm{ad}^{n}_{G_1}(\check{Z}_\mu)
&&\bigl(\because\ \blkref{exp_X_Y_exp_-X}\ \text{が引く}\ \blkref{matrix_exp_conjugation}\ \text{の実数係数の包含は}\ \blkref{inclusion_rr_to_cc}\bigr)\\
&= (\cosh K_1)_{\mathbb{C}}\,\check{Z}_\mu + \Bigl(\bigl(i\,\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)(\sinh K_1)_{\mathbb{C}}\Bigr)\check{Y}_\mu
&&\bigl(\because\ \blkref{extract_taylor_coefficient_of_check_Z_Y}\ \text{(h1.z)}\bigr)\\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\begin{pmatrix}(\cosh K_1)_{\mathbb{C}} \\ \bigl(i\,\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)(\sinh K_1)_{\mathbb{C}}\end{pmatrix}
&&\bigl(\because\ \blkref{def_pair_of_matrices_times_column_of_numbers}\bigr)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
T_{S}(\check{Y}_\mu)
&= (S\check{Y}_\mu)S^{-1}
&&\bigl(\because\ \blkref{def_T_g}\ (M\to M_{\mathrm{col}},\ g\to S,\ h\to \check{Y}_\mu)\bigr)\\
&= \Bigl(\exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\check{Y}_\mu\Bigr)\Bigl(\exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\Bigr)^{-1}
&&\bigl(\because\ \blkref{def_V1_plus_square_root}\ \text{を 2 か所へ同時適用}\bigr)\\
&= \bigl(\exp(X)\check{Y}_\mu\bigr)\bigl(\exp(X)\bigr)^{-1}
&&\bigl(\because\ X\ \text{の置き方}\ (K_1\ \text{は}\ \blkref{inclusion_rr_to_cc}\ \text{の}\ (K_1)_{\mathbb{C}})\bigr)\\
&= \bigl(\exp(X)\check{Y}_\mu\bigr)\exp(-X)
&&\bigl(\because\ \blkref{matrix_exp_conjugation}\ \text{(3)}\ (n\to 2^{M_{\mathrm{col}}},\ X\to X)\bigr)\\
&= \bigl(\exp(G_1)\check{Y}_\mu\bigr)\exp(-G_1)
&&(\because\ \text{準備の}\ X = G_1)\\
&= \sum_{n=0}^{\infty}\frac{1}{n!}\,\mathrm{ad}^{n}_{G_1}(\check{Y}_\mu)
&&\bigl(\because\ \blkref{exp_X_Y_exp_-X}\ (\text{同主張の}\ d,\ X,\ Y\ \text{を}\ 2^{M_{\mathrm{col}}},\ G_1,\ \check{Y}_\mu\ \text{に})\bigr)\\
&= \sum_{n=0}^{\infty}\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}\mathrm{ad}^{n}_{G_1}(\check{Y}_\mu)
&&\bigl(\because\ \blkref{exp_X_Y_exp_-X}\ \text{が引く}\ \blkref{matrix_exp_conjugation}\ \text{の実数係数の包含は}\ \blkref{inclusion_rr_to_cc}\bigr)\\
&= \Bigl(\bigl((-i)\,\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)(\sinh K_1)_{\mathbb{C}}\Bigr)\check{Z}_\mu + (\cosh K_1)_{\mathbb{C}}\,\check{Y}_\mu
&&\bigl(\because\ \blkref{extract_taylor_coefficient_of_check_Z_Y}\ \text{(h1.y)}\bigr)\\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\begin{pmatrix}\bigl((-i)\,\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)(\sinh K_1)_{\mathbb{C}} \\ (\cosh K_1)_{\mathbb{C}}\end{pmatrix}
&&\bigl(\because\ \blkref{def_pair_of_matrices_times_column_of_numbers}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`T_{V_2}(\check{Z}_\mu)`),
        "・",
        math(String.raw`T_{V_2}(\check{Y}_\mu)`),
        " は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{V_2}(\check{Z}_\mu)
&= (V_2\check{Z}_\mu)V_2^{-1}
&&\bigl(\because\ \blkref{def_T_g}\ (M\to M_{\mathrm{col}},\ g\to V_2,\ h\to \check{Z}_\mu)\bigr)\\
&= (V_2\check{Z}_\mu)\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)
&&\bigl(\because\ \blkref{V2_invertible}\bigr)\\
&= \Bigl(\Bigl((2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(iK_2^*H_2\right)\Bigr)\check{Z}_\mu\Bigr)\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)
&&\bigl(\because\ \blkref{V2_exponential_representation}\bigr)\\
&= \Bigl(\Bigl(a_{\mathbb{C}}\exp\!\left(iK_2^*H_2\right)\Bigr)\check{Z}_\mu\Bigr)\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)
&&\bigl(\because\ \blkref{V2_invertible}\ \text{の}\ a\ (\text{係数は}\ \blkref{inclusion_rr_to_cc}\ \text{の}\ a_{\mathbb{C}})\bigr)\\
&= \Bigl(\bigl(a_{\mathbb{C}}\exp(Y)\bigr)\check{Z}_\mu\Bigr)\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)
&&\bigl(\because\ \blkref{V2_invertible}\ \text{の}\ Y\ (K_2^*\ \text{は}\ \blkref{inclusion_rr_to_cc}\ \text{の}\ (K_2^*)_{\mathbb{C}})\bigr)\\
&= \Bigl(a_{\mathbb{C}}\bigl(\exp(Y)\check{Z}_\mu\bigr)\Bigr)\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_left_factor}\ (a\to a_{\mathbb{C}},\ A\to\exp(Y),\ B\to \check{Z}_\mu)\bigr)\\
&= a_{\mathbb{C}}\Bigl(\bigl(\exp(Y)\check{Z}_\mu\bigr)\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)\Bigr)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_left_factor}\ (a\to a_{\mathbb{C}},\ A\to\exp(Y)\check{Z}_\mu,\ B\to(a^{-1})_{\mathbb{C}}\exp(-Y))\bigr)\\
&= a_{\mathbb{C}}\Bigl((a^{-1})_{\mathbb{C}}\Bigl(\bigl(\exp(Y)\check{Z}_\mu\bigr)\exp(-Y)\Bigr)\Bigr)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_right_factor}\ (a\to (a^{-1})_{\mathbb{C}},\ B\to\exp(-Y))\bigr)\\
&= \bigl(a_{\mathbb{C}}(a^{-1})_{\mathbb{C}}\bigr)\Bigl(\bigl(\exp(Y)\check{Z}_\mu\bigr)\exp(-Y)\Bigr)
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\ (a\to a_{\mathbb{C}},\ b\to(a^{-1})_{\mathbb{C}})\bigr)\\
&= (aa^{-1})_{\mathbb{C}}\Bigl(\bigl(\exp(Y)\check{Z}_\mu\bigr)\exp(-Y)\Bigr)
&&\bigl(\because\ \blkref{real_inclusion_preserves_product}\ (a\to a,\ b\to a^{-1})\bigr)\\
&= (1)_{\mathbb{C}}\Bigl(\bigl(\exp(Y)\check{Z}_\mu\bigr)\exp(-Y)\Bigr)
&&(\because\ \mathbb{R}\ \text{で}\ aa^{-1}=1)\\
&= 1_{\mathbb{C}}\Bigl(\bigl(\exp(Y)\check{Z}_\mu\bigr)\exp(-Y)\Bigr)
&&\bigl(\because\ 1_{\mathbb{C}}\ \text{は}\ \blkref{inclusion_rr_to_cc}\ \text{の略記}\ r_{\mathbb{C}}\ \text{の}\ r=1\bigr)\\
&= \bigl(\exp(Y)\check{Z}_\mu\bigr)\exp(-Y)
&&\bigl(\because\ \blkref{scalar_multiple_by_one}\bigr)\\
&= \bigl(\exp(G_2)\check{Z}_\mu\bigr)\exp(-G_2)
&&(\because\ \text{準備の}\ Y = G_2)\\
&= \sum_{n=0}^{\infty}\frac{1}{n!}\,\mathrm{ad}^{n}_{G_2}(\check{Z}_\mu)
&&\bigl(\because\ \blkref{exp_X_Y_exp_-X}\ (\text{同主張の}\ d,\ X,\ Y\ \text{を}\ 2^{M_{\mathrm{col}}},\ G_2,\ \check{Z}_\mu\ \text{に})\bigr)\\
&= \sum_{n=0}^{\infty}\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}\mathrm{ad}^{n}_{G_2}(\check{Z}_\mu)
&&\bigl(\because\ \blkref{exp_X_Y_exp_-X}\ \text{が引く}\ \blkref{matrix_exp_conjugation}\ \text{の実数係数の包含は}\ \blkref{inclusion_rr_to_cc}\bigr)\\
&= (\cosh 2K_2^*)_{\mathbb{C}}\,\check{Z}_\mu + \bigl((-i)(\sinh 2K_2^*)_{\mathbb{C}}\bigr)\check{Y}_\mu
&&\bigl(\because\ \blkref{extract_taylor_coefficient_of_check_Z_Y}\ \text{(h2.z)}\bigr)\\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\begin{pmatrix}(\cosh 2K_2^*)_{\mathbb{C}} \\ (-i)(\sinh 2K_2^*)_{\mathbb{C}}\end{pmatrix}
&&\bigl(\because\ \blkref{def_pair_of_matrices_times_column_of_numbers}\bigr)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
T_{V_2}(\check{Y}_\mu)
&= (V_2\check{Y}_\mu)V_2^{-1}
&&\bigl(\because\ \blkref{def_T_g}\ (M\to M_{\mathrm{col}},\ g\to V_2,\ h\to \check{Y}_\mu)\bigr)\\
&= (V_2\check{Y}_\mu)\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)
&&\bigl(\because\ \blkref{V2_invertible}\bigr)\\
&= \Bigl(\Bigl((2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(iK_2^*H_2\right)\Bigr)\check{Y}_\mu\Bigr)\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)
&&\bigl(\because\ \blkref{V2_exponential_representation}\bigr)\\
&= \Bigl(\Bigl(a_{\mathbb{C}}\exp\!\left(iK_2^*H_2\right)\Bigr)\check{Y}_\mu\Bigr)\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)
&&\bigl(\because\ \blkref{V2_invertible}\ \text{の}\ a\ (\text{係数は}\ \blkref{inclusion_rr_to_cc}\ \text{の}\ a_{\mathbb{C}})\bigr)\\
&= \Bigl(\bigl(a_{\mathbb{C}}\exp(Y)\bigr)\check{Y}_\mu\Bigr)\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)
&&\bigl(\because\ \blkref{V2_invertible}\ \text{の}\ Y\ (K_2^*\ \text{は}\ \blkref{inclusion_rr_to_cc}\ \text{の}\ (K_2^*)_{\mathbb{C}})\bigr)\\
&= \Bigl(a_{\mathbb{C}}\bigl(\exp(Y)\check{Y}_\mu\bigr)\Bigr)\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_left_factor}\ (a\to a_{\mathbb{C}},\ A\to\exp(Y),\ B\to \check{Y}_\mu)\bigr)\\
&= a_{\mathbb{C}}\Bigl(\bigl(\exp(Y)\check{Y}_\mu\bigr)\bigl((a^{-1})_{\mathbb{C}}\exp(-Y)\bigr)\Bigr)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_left_factor}\ (a\to a_{\mathbb{C}},\ A\to\exp(Y)\check{Y}_\mu,\ B\to(a^{-1})_{\mathbb{C}}\exp(-Y))\bigr)\\
&= a_{\mathbb{C}}\Bigl((a^{-1})_{\mathbb{C}}\Bigl(\bigl(\exp(Y)\check{Y}_\mu\bigr)\exp(-Y)\Bigr)\Bigr)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_right_factor}\ (a\to (a^{-1})_{\mathbb{C}},\ B\to\exp(-Y))\bigr)\\
&= \bigl(a_{\mathbb{C}}(a^{-1})_{\mathbb{C}}\bigr)\Bigl(\bigl(\exp(Y)\check{Y}_\mu\bigr)\exp(-Y)\Bigr)
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\ (a\to a_{\mathbb{C}},\ b\to(a^{-1})_{\mathbb{C}})\bigr)\\
&= (aa^{-1})_{\mathbb{C}}\Bigl(\bigl(\exp(Y)\check{Y}_\mu\bigr)\exp(-Y)\Bigr)
&&\bigl(\because\ \blkref{real_inclusion_preserves_product}\ (a\to a,\ b\to a^{-1})\bigr)\\
&= (1)_{\mathbb{C}}\Bigl(\bigl(\exp(Y)\check{Y}_\mu\bigr)\exp(-Y)\Bigr)
&&(\because\ \mathbb{R}\ \text{で}\ aa^{-1}=1)\\
&= 1_{\mathbb{C}}\Bigl(\bigl(\exp(Y)\check{Y}_\mu\bigr)\exp(-Y)\Bigr)
&&\bigl(\because\ 1_{\mathbb{C}}\ \text{は}\ \blkref{inclusion_rr_to_cc}\ \text{の略記}\ r_{\mathbb{C}}\ \text{の}\ r=1\bigr)\\
&= \bigl(\exp(Y)\check{Y}_\mu\bigr)\exp(-Y)
&&\bigl(\because\ \blkref{scalar_multiple_by_one}\bigr)\\
&= \bigl(\exp(G_2)\check{Y}_\mu\bigr)\exp(-G_2)
&&(\because\ \text{準備の}\ Y = G_2)\\
&= \sum_{n=0}^{\infty}\frac{1}{n!}\,\mathrm{ad}^{n}_{G_2}(\check{Y}_\mu)
&&\bigl(\because\ \blkref{exp_X_Y_exp_-X}\ (\text{同主張の}\ d,\ X,\ Y\ \text{を}\ 2^{M_{\mathrm{col}}},\ G_2,\ \check{Y}_\mu\ \text{に})\bigr)\\
&= \sum_{n=0}^{\infty}\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}\mathrm{ad}^{n}_{G_2}(\check{Y}_\mu)
&&\bigl(\because\ \blkref{exp_X_Y_exp_-X}\ \text{が引く}\ \blkref{matrix_exp_conjugation}\ \text{の実数係数の包含は}\ \blkref{inclusion_rr_to_cc}\bigr)\\
&= \bigl(i\,(\sinh 2K_2^*)_{\mathbb{C}}\bigr)\check{Z}_\mu + (\cosh 2K_2^*)_{\mathbb{C}}\,\check{Y}_\mu
&&\bigl(\because\ \blkref{extract_taylor_coefficient_of_check_Z_Y}\ \text{(h2.y)}\bigr)\\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\begin{pmatrix}i\,(\sinh 2K_2^*)_{\mathbb{C}} \\ (\cosh 2K_2^*)_{\mathbb{C}}\end{pmatrix}
&&\bigl(\because\ \blkref{def_pair_of_matrices_times_column_of_numbers}\bigr)
\end{aligned}`,
      ),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の ホロノミック量子場_p142下段_1 の半整数運動量版。008 章では H_1 の符号 (±) と hatZ の符号 (-) が食い違ったまま書かれていたが（why_008_applies_only_to_minus_sector により実質 (-) 専用）、ここでは H_1^{(+)} と checkZ, checkY で首尾一貫している。",
        "行列指数関数を明示的に構成した直接計算（交換子の級数展開に依存しない独立経路）で数値確認済み。V_2 の前因子 (2 s_2)^{M/2} を明示的に付けた形で相殺も確認した（sagemath/check/047_claim_even_sector_T_action/check_03_T_actions.sage）。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-11-02（全証明の SageMath 検算。sagemath/check/T_actions_on_check_Z_Y/）: 主張を extract_taylor_coefficient_of_check_Z_Y の新しい表記（K_1・K_2^*・θ̃・cosh・sinh の値を inclusion_rr_to_cc の像で、係数を一つの複素数にまとめたスカラー倍）にそろえ、M_col・R・S・V_2 の所属と可逆性の根拠を書いた（主張の中身は不変）。主張の中で定めていた行列の組と数の列の積を def_pair_of_matrices_times_column_of_numbers へ切り出した。証明は、Y̌ の場合を「同じ手順」の散文で済ませていたのを四本の鎖に書き下し、指数の肩の読み替え（X = G_1、Y = G_2。scalar_multiple_is_associative）を準備に置き、V_2^{-1} の形を V2_invertible の主張から引き、前因子が消える段を scalar_identity_commutes の散文から係数を左右の因子から出す行・係数をまとめる行・包含の三行・1_C を外す行の鎖にし、最後の行列表示への書き換えを各鎖の最終行にした。",
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
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`M`),
        " を ",
        math(String.raw`M_{\mathrm{col}}`),
        " に取った ",
        math(String.raw`R=\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " と ",
        math(String.raw`R^\times`),
        " を用いる。",
        math(String.raw`\mu\in\check{\mathcal M}`),
        "（",
        ref("def_check_index_set"),
        "）と ",
        math(String.raw`\check Z_\mu,\check Y_\mu\in R`),
        "（",
        ref("def_half_integer_checkZ"),
        "・",
        ref("def_half_integer_checkY"),
        "）、",
        math(String.raw`\left(V_1^{(+)}\right)^{1/2}\in R^\times`),
        "（",
        ref("def_V1_plus_square_root"),
        "・",
        ref("V1_plus_half_invertible"),
        "）による共役 ",
        math(String.raw`T_{\left(V_1^{(+)}\right)^{1/2}}:R\to R`),
        "（",
        ref("def_T_g"),
        "）をとる。任意の ",
        math(String.raw`a,b\in\mathbb C`),
        " について、",
      ]),
      displayMath(
        String.raw`T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(a\check Z_\mu+b\check Y_\mu\right)
=a\,T_{\left(V_1^{(+)}\right)^{1/2}}(\check Z_\mu)+b\,T_{\left(V_1^{(+)}\right)^{1/2}}(\check Y_\mu)`,
      ),
    ],
    proof: [
      paragraph([
        ref("linearity_of_T"),
        " を、",
        math(String.raw`M:=M_{\mathrm{col}}`),
        "、",
        math(String.raw`g:=\left(V_1^{(+)}\right)^{1/2}\in R^\times`),
        "（",
        ref("V1_plus_half_invertible"),
        "）、",
        math(String.raw`X:=\check Z_\mu\in R`),
        "、",
        math(String.raw`W:=\check Y_\mu\in R`),
        " と、主張の ",
        math(String.raw`a,b\in\mathbb C`),
        " に当てる。",
      ]),
      displayMath(String.raw`\begin{aligned}
T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(a\check Z_\mu+b\check Y_\mu\right)
&=a\,T_{\left(V_1^{(+)}\right)^{1/2}}(\check Z_\mu)+b\,T_{\left(V_1^{(+)}\right)^{1/2}}(\check Y_\mu)
&&\left(\because\ \blkref{linearity_of_T}\right).
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02（全証明の SageMath 検算。sagemath/check/linearity_of_T_on_check_Z_Y/）: 主張を T_actions_on_check_Z_Y と同じ書き方にそろえ、M_col・R・R^×・Ž_μ・Y̌_μ の所属と、共役写像 T を定める def_T_g と可逆性の根拠を主張に書いた（主張の中身は不変）。証明の準備に linearity_of_T の M・g・X・W・a・b に何を当てるかを書いた。",
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
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`M`),
        " を ",
        math(String.raw`M_{\mathrm{col}}`),
        " に取った ",
        math(String.raw`R=\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " と ",
        math(String.raw`R^\times`),
        " を用いる。",
        math(String.raw`\mu\in\check{\mathcal M}`),
        "（",
        ref("def_check_index_set"),
        "）と ",
        math(String.raw`\check Z_\mu,\check Y_\mu\in R`),
        "（",
        ref("def_half_integer_checkZ"),
        "・",
        ref("def_half_integer_checkY"),
        "）、",
        math(String.raw`V_2\in R^\times`),
        "（",
        ref("def_transfer_matrix_symbols"),
        "・",
        ref("V2_invertible"),
        "）による共役 ",
        math(String.raw`T_{V_2}:R\to R`),
        "（",
        ref("def_T_g"),
        "）をとる。任意の ",
        math(String.raw`a,b\in\mathbb C`),
        " について、",
      ]),
      displayMath(
        String.raw`T_{V_2}\!\left(a\check Z_\mu+b\check Y_\mu\right)
=a\,T_{V_2}(\check Z_\mu)+b\,T_{V_2}(\check Y_\mu)`,
      ),
    ],
    proof: [
      paragraph([
        ref("linearity_of_T"),
        " を、",
        math(String.raw`M:=M_{\mathrm{col}}`),
        "、",
        math(String.raw`g:=V_2\in R^\times`),
        "（",
        ref("V2_invertible"),
        "）、",
        math(String.raw`X:=\check Z_\mu\in R`),
        "、",
        math(String.raw`W:=\check Y_\mu\in R`),
        " と、主張の ",
        math(String.raw`a,b\in\mathbb C`),
        " に当てる。",
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
        "2026-11-02（全証明の SageMath 検算。sagemath/check/linearity_of_T_V2/）: 主張を T_actions_on_check_Z_Y と同じ書き方にそろえ、M_col・R・R^×・Ž_μ・Y̌_μ・V_2 の所属と、共役写像 T を定める def_T_g と可逆性の根拠を主張に書いた（主張の中身は不変。Ž_μ・Y̌_μ の定義が M_col ≥ 2 を要るので M_col ∈ Z_{≥2} とした）。証明の準備に linearity_of_T の M・g・X・W・a・b に何を当てるかを書き、地の文「一続きである。」を除いた。",
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
      paragraph([
        math(String.raw`\theta \in \mathbb{R}`),
        " とその ",
        ref("inclusion_rr_to_cc"),
        " による像 ",
        math(String.raw`(\theta)_{\mathbb{C}}`),
        "、",
        math(String.raw`K_1, K_2^* \in \mathbb{R}`),
        "（",
        ref("def_transfer_matrix_symbols"),
        "）、実数の積 ",
        math(String.raw`2K_2^* \in \mathbb{R}`),
        "、",
        math(String.raw`\cosh, \sinh`),
        "（",
        ref("def_cosh_sinh"),
        "）の値の像 ",
        math(String.raw`(\cosh K_1)_{\mathbb{C}}, (\sinh K_1)_{\mathbb{C}}, (\cosh 2K_2^*)_{\mathbb{C}}, (\sinh 2K_2^*)_{\mathbb{C}}`),
        "、数の ",
        math(String.raw`\exp`),
        "（",
        ref("def_scalar_exp"),
        "）、",
        ref("def_imaginary_unit"),
        " の虚数単位 ",
        math(String.raw`i \in \mathbb{C}`),
        " と ",
        math(String.raw`-i := (-1_{\mathbb{C}})\,i`),
        "（",
        ref("multiply_by_minus_one"),
        "）を用いて",
      ]),
      displayMath(
        String.raw`B_1(\theta) := \begin{pmatrix}
(\cosh K_1)_{\mathbb{C}} & \bigl((-i)\,\exp\bigl(i(\theta)_{\mathbb{C}}\bigr)\bigr)(\sinh K_1)_{\mathbb{C}} \\
\bigl(i\,\exp\bigl(-i(\theta)_{\mathbb{C}}\bigr)\bigr)(\sinh K_1)_{\mathbb{C}} & (\cosh K_1)_{\mathbb{C}}
\end{pmatrix},
\qquad
B_2 := \begin{pmatrix}
(\cosh 2K_2^*)_{\mathbb{C}} & i\,(\sinh 2K_2^*)_{\mathbb{C}} \\
(-i)(\sinh 2K_2^*)_{\mathbb{C}} & (\cosh 2K_2^*)_{\mathbb{C}}
\end{pmatrix}`,
      ),
      paragraph([
        "と定める（いずれも ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の元）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章では B_1, B_2 は factorization_of_A_theta の statement と T_V_hatZ_hatY の proof の中で θ_μ（μ ∈ calM）に限って導入されている。半整数運動量 θ~_μ で使うために、θ ∈ R 一般の定義として立て直した（008 章側は変更していない）。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-11-02（全証明の SageMath 検算）: 成分を T_actions_on_check_Z_Y の主張と同じ表記（包含の像、係数をまとめた積）で書いた。中身は不変。",
      ],
    },
  },
  {
    id: "evensectorT_definition_pair_of_matrices_times_two_by_two_matrix",
    kind: "definition",
    origin: { path: "structured-latex/content/014_even_sector_T_action.ts", ordinal: 10 },
    title: { tex: String.raw`\text{行列の組と } 2\times 2 \text{ 行列の積}` },
    labels: ["def_pair_of_matrices_times_two_by_two_matrix"],
    statement: [
      paragraph([
        math(String.raw`d\in\mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B\in\mathrm{Mat}(d,\mathbb{C})`),
        "、",
        math(String.raw`p, q, r, s\in\mathbb{C}`),
        " について、行列の組 ",
        math(String.raw`\begin{pmatrix}A, & B\end{pmatrix}`),
        " と ",
        math(String.raw`\begin{pmatrix}p & q \\ r & s\end{pmatrix}\in\mathrm{Mat}(2,\mathbb{C})`),
        " の積を、",
        ref("def_pair_of_matrices_times_column_of_numbers"),
        " の積を列ごとに並べた組",
      ]),
      displayMath(
        String.raw`\begin{pmatrix}A, & B\end{pmatrix}\begin{pmatrix}p & q \\ r & s\end{pmatrix}
:= \left(\begin{pmatrix}A, & B\end{pmatrix}\begin{pmatrix}p \\ r\end{pmatrix},\ \begin{pmatrix}A, & B\end{pmatrix}\begin{pmatrix}q \\ s\end{pmatrix}\right)
\ \in\ \mathrm{Mat}(d,\mathbb{C})\times\mathrm{Mat}(d,\mathbb{C})`,
      ),
      paragraph(["と定める。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02（全証明の SageMath 検算）: calc_of_TxT_check_Z_Y の主張の中で定めていた積を、1 ブロック 1 定義に従って切り出した。",
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
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`R=\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "（",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`M`),
        " を ",
        math(String.raw`M_{\mathrm{col}}`),
        " に取ったもの）、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        "、",
        math(String.raw`\tilde\theta = \tilde\theta_\mu \in \mathbb{R}`),
        " とその像 ",
        math(String.raw`(\tilde\theta)_{\mathbb{C}}`),
        "、",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu \in R`),
        "、共役 ",
        math(String.raw`T_{\left(V_1^{(+)}\right)^{1/2}}, T_{V_2}: R\to R`),
        "、その主張の係数に現れる ",
        math(String.raw`K_1, K_2^*`),
        " の値の像は ",
        ref("T_actions_on_check_Z_Y"),
        " のものとする。",
        math(String.raw`B_1(\tilde\theta), B_2 \in \mathrm{Mat}(2,\mathbb{C})`),
        " は ",
        ref("def_B1_theta_B2"),
        " の ",
        math(String.raw`\theta`),
        " を ",
        math(String.raw`\tilde\theta`),
        " に取ったもの、行列の組と ",
        math(String.raw`2\times 2`),
        " 行列の積は ",
        ref("def_pair_of_matrices_times_two_by_two_matrix"),
        " の ",
        math(String.raw`d`),
        " を ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " に取ったものとする。このとき",
      ]),
      displayMath(
        String.raw`\left(T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu),\
T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)\right)
= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix} B_1(\tilde\theta)`,
      ),
      displayMath(
        String.raw`\left(T_{V_2}(\check{Z}_\mu),\ T_{V_2}(\check{Y}_\mu)\right)
= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix} B_2`,
      ),
      paragraph(["である（いずれも ", math(String.raw`R\times R`), " の元の等式）。"]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
&\left(T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu),\
T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)\right) \\
&= \left(
   \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \begin{pmatrix}
     (\cosh K_1)_{\mathbb{C}} \\
     \bigl(i\,\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)(\sinh K_1)_{\mathbb{C}}
   \end{pmatrix},\ \
   \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \begin{pmatrix}
     \bigl((-i)\,\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)(\sinh K_1)_{\mathbb{C}} \\
     (\cosh K_1)_{\mathbb{C}}
   \end{pmatrix}
   \right)
   \quad (\because \blkref{T_actions_on_check_Z_Y}\text{ の } T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu)\text{・}T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)\text{ の式を 2 成分へ同時適用}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \begin{pmatrix}
     (\cosh K_1)_{\mathbb{C}} & \bigl((-i)\,\exp\bigl(i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)(\sinh K_1)_{\mathbb{C}} \\
     \bigl(i\,\exp\bigl(-i(\tilde\theta)_{\mathbb{C}}\bigr)\bigr)(\sinh K_1)_{\mathbb{C}} & (\cosh K_1)_{\mathbb{C}}
   \end{pmatrix}
   \quad (\because \blkref{def_pair_of_matrices_times_two_by_two_matrix}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix} B_1(\tilde\theta)
   \quad (\because \blkref{def_B1_theta_B2})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
&\left(T_{V_2}(\check{Z}_\mu),\ T_{V_2}(\check{Y}_\mu)\right) \\
&= \left(
   \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \begin{pmatrix}
     (\cosh 2K_2^*)_{\mathbb{C}} \\
     (-i)(\sinh 2K_2^*)_{\mathbb{C}}
   \end{pmatrix},\ \
   \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \begin{pmatrix}
     i\,(\sinh 2K_2^*)_{\mathbb{C}} \\
     (\cosh 2K_2^*)_{\mathbb{C}}
   \end{pmatrix}
   \right)
   \quad (\because \blkref{T_actions_on_check_Z_Y}\text{ の } T_{V_2}(\check{Z}_\mu)\text{・}T_{V_2}(\check{Y}_\mu)\text{ の式を 2 成分へ同時適用}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \begin{pmatrix}
     (\cosh 2K_2^*)_{\mathbb{C}} & i\,(\sinh 2K_2^*)_{\mathbb{C}} \\
     (-i)(\sinh 2K_2^*)_{\mathbb{C}} & (\cosh 2K_2^*)_{\mathbb{C}}
   \end{pmatrix}
   \quad (\because \blkref{def_pair_of_matrices_times_two_by_two_matrix}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix} B_2
   \quad (\because \blkref{def_B1_theta_B2})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の calc_of_TxT_hatZxhatY の半整数運動量版。008 章は直積写像 T×T を別ブロックで定義してから 2 列を並べていたが、直積写像の記号は以降で使われないので、ここでは 2 つの像の組をそのまま行ベクトル×行列の形に書いた。",
        "2026-11-02（全証明の SageMath 検算）: 主張を T_actions_on_check_Z_Y の新しい表記にそろえ、主張の中で定めていた行列の組と 2×2 行列の積を def_pair_of_matrices_times_two_by_two_matrix に切り出した。証明の地の文を除いた。主張の中身は不変。検算は sagemath/check/calc_of_TxT_check_Z_Y/。",
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
      paragraph([
        "記号を次のように置く。",
        math(String.raw`c_1, s_1, c_2, c_2^*, s_2^* \in \mathbb{R}`),
        " は ",
        ref("def_indexed_hyperbolic_abbreviations"),
        "、",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記、",
        math(String.raw`\exp`),
        " は ",
        ref("def_scalar_exp"),
        " の数の exp（",
        math(String.raw`K = \mathbb{C}`),
        "）である。",
      ]),
      displayMath(String.raw`\begin{aligned}
&a := (\cosh K_1)_{\mathbb{C}} \in \mathbb{C},\quad
b := (\sinh K_1)_{\mathbb{C}} \in \mathbb{C},\quad
C := (\cosh 2K_2^*)_{\mathbb{C}} = (c_2^*)_{\mathbb{C}} \in \mathbb{C},\quad
S := (\sinh 2K_2^*)_{\mathbb{C}} = (s_2^*)_{\mathbb{C}} \in \mathbb{C},\\
&e_+ := \exp\bigl(i(\theta)_{\mathbb{C}}\bigr) \in \mathbb{C},\quad
e_- := \exp\bigl((-i)(\theta)_{\mathbb{C}}\bigr) \in \mathbb{C}
\end{aligned}`),
      paragraph([
        "この記号で ",
        ref("def_B1_theta_B2"),
        " は ",
        math(String.raw`B_1(\theta) = \begin{pmatrix} a & \bigl((-i)e_+\bigr)b \\ (i e_-)b & a\end{pmatrix}`),
        "、",
        math(String.raw`B_2 = \begin{pmatrix} C & iS \\ (-i)S & C\end{pmatrix}`),
        " である（",
        ref("def_B1_theta_B2"),
        " の ",
        math(String.raw`\exp\bigl(-i(\theta)_{\mathbb{C}}\bigr)`),
        " の指数 ",
        math(String.raw`-i(\theta)_{\mathbb{C}}`),
        " は、",
        ref("multiply_by_minus_one"),
        " の ",
        math(String.raw`-i = (-1_{\mathbb{C}})\,i`),
        " を係数とする積 ",
        math(String.raw`(-i)(\theta)_{\mathbb{C}}`),
        " である）。",
        math(String.raw`A(\theta)`),
        " の成分は ",
        ref("def_A_theta"),
        " の読みのとおりで、(1,1) 成分と (2,2) 成分は実数の ",
        ref("inclusion_rr_to_cc"),
        " による像、(1,2) 成分と (2,1) 成分は実数の像を ",
        math(String.raw`\mathbb{C}`),
        " の演算にかけた式である。Step 2・3 の末尾の 3 行に現れる三つの因子の積 ",
        math(String.raw`(s_1)_{\mathbb{C}}(s_2^*)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}}`),
        " と ",
        math(String.raw`s_1 s_2^*\cos\theta \in \mathbb{R}`),
        " は左から括る（",
        math(String.raw`xyw = (xy)w`),
        "）。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`\cosh, \sinh`),
        " の値が実数の exp の値（部分和の極限）であり、",
        math(String.raw`\theta`),
        " が実数の運動量だからである。",
      ]),
      paragraph(["準備として、次の七本の等式を置く。"]),
      displayMath(String.raw`\begin{aligned}
a^2 + b^2
&= (\cosh K_1)_{\mathbb{C}}(\cosh K_1)_{\mathbb{C}} + (\sinh K_1)_{\mathbb{C}}(\sinh K_1)_{\mathbb{C}}
&&(\because\ a, b\ \text{の定義と二乗の記法})\\
&= \bigl(\cosh K_1 \cosh K_1\bigr)_{\mathbb{C}} + \bigl(\sinh K_1 \sinh K_1\bigr)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product}\ \text{を 2 箇所へ})\\
&= \bigl(\cosh K_1 \cosh K_1 + \sinh K_1 \sinh K_1\bigr)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_finite_sum}\ (m = 2))\\
&= \bigl(\cosh (K_1 + K_1)\bigr)_{\mathbb{C}}
&&(\because\ \blkref{cosh_addition_formula}\ \text{の複号 }+\text{ を }x = y = K_1\text{ で})\\
&= \bigl(\cosh 2K_1\bigr)_{\mathbb{C}}
&&(\because\ K_1 + K_1 = 2K_1)\\
&= (c_1)_{\mathbb{C}}
&&(\because\ \blkref{def_indexed_hyperbolic_abbreviations})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
2ab
&= \bigl((2)_{\mathbb{C}}(\cosh K_1)_{\mathbb{C}}\bigr)(\sinh K_1)_{\mathbb{C}}
&&(\because\ a, b\ \text{の定義と}\ 2 = (2)_{\mathbb{C}}\ (\blkref{inclusion_rr_to_cc}))\\
&= \bigl(2 \cosh K_1\bigr)_{\mathbb{C}}(\sinh K_1)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product})\\
&= \bigl(2 \cosh K_1 \sinh K_1\bigr)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product})\\
&= \bigl(2 \sinh K_1 \cosh K_1\bigr)_{\mathbb{C}}
&&(\because\ \mathbb{R}\ \text{の積の交換律})\\
&= \Bigl(2 \sinh\!\left(\tfrac{2K_1}{2}\right) \cosh\!\left(\tfrac{2K_1}{2}\right)\Bigr)_{\mathbb{C}}
&&(\because\ K_1 = \tfrac{2K_1}{2})\\
&= \bigl(\sinh 2K_1\bigr)_{\mathbb{C}}
&&(\because\ \blkref{sinh_double_angle_formula}\ \text{を }x = 2K_1\text{ で})\\
&= (s_1)_{\mathbb{C}}
&&(\because\ \blkref{def_indexed_hyperbolic_abbreviations})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
a^2 - b^2
&= (\cosh K_1)_{\mathbb{C}}(\cosh K_1)_{\mathbb{C}} - (\sinh K_1)_{\mathbb{C}}(\sinh K_1)_{\mathbb{C}}
&&(\because\ a, b\ \text{の定義と二乗の記法})\\
&= \bigl(\cosh K_1 \cosh K_1\bigr)_{\mathbb{C}} - \bigl(\sinh K_1 \sinh K_1\bigr)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product}\ \text{を 2 箇所へ})\\
&= \bigl(\cosh K_1 \cosh K_1\bigr)_{\mathbb{C}} + (-1_{\mathbb{C}})\bigl(\sinh K_1 \sinh K_1\bigr)_{\mathbb{C}}
&&(\because\ \blkref{def_complex_difference},\ \blkref{multiply_by_minus_one})\\
&= \bigl(\cosh K_1 \cosh K_1\bigr)_{\mathbb{C}} + (-1)_{\mathbb{C}}\bigl(\sinh K_1 \sinh K_1\bigr)_{\mathbb{C}}
&&(\because\ -1_{\mathbb{C}} = (-1)_{\mathbb{C}}\ (\blkref{inclusion_rr_to_cc}\ \text{の略記}))\\
&= \bigl(\cosh K_1 \cosh K_1\bigr)_{\mathbb{C}} + \bigl((-1)\sinh K_1 \sinh K_1\bigr)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product})\\
&= \bigl(\cosh K_1 \cosh K_1 + (-1)\sinh K_1 \sinh K_1\bigr)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_finite_sum}\ (m = 2))\\
&= \bigl((\cosh K_1)^2 - (\sinh K_1)^2\bigr)_{\mathbb{C}}
&&(\because\ \mathbb{R}\ \text{の差と二乗の記法})\\
&= (1)_{\mathbb{C}}
&&(\because\ \blkref{cosh_sinh_basic_properties}\ (2))\\
&= 1_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{の略記})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
e_+ e_-
&= \exp\bigl(i(\theta)_{\mathbb{C}} + (-i)(\theta)_{\mathbb{C}}\bigr)
&&(\because\ e_\pm\ \text{の定義と}\ \blkref{scalar_exp_product}\ (K = \mathbb{C}))\\
&= \exp(0_{\mathbb{C}})
&&(\because\ \mathbb{C}\ \text{の分配則と}\ i + (-i) = 0_{\mathbb{C}})\\
&= 1_{\mathbb{C}}
&&(\because\ \blkref{scalar_exp_zero}\ (K = \mathbb{C}))
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
e_+ + e_-
&= (2)_{\mathbb{C}}\,\frac{e_+ + e_-}{(2)_{\mathbb{C}}}
&&(\because\ (2)_{\mathbb{C}} \neq 0_{\mathbb{C}}\ \text{と}\ \mathbb{C}\ \text{の四則})\\
&= (2)_{\mathbb{C}}\,\frac{\exp\bigl(i(\theta)_{\mathbb{C}}\bigr) + \exp\bigl((-i)(\theta)_{\mathbb{C}}\bigr)}{(2)_{\mathbb{C}}}
&&(\because\ e_\pm\ \text{の定義})\\
&= (2)_{\mathbb{C}}\,\frac{\exp\bigl(i(\theta)_{\mathbb{C}}\bigr) + \exp\bigl(-(i(\theta)_{\mathbb{C}})\bigr)}{(2)_{\mathbb{C}}}
&&\bigl(\because\ \blkref{negative_i_times_complex_is_negation_of_i_times}\ (z \to (\theta)_{\mathbb{C}})\bigr)\\
&= (2)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}}
&&(\because\ \blkref{euler_formula_cos_sin}\ \text{の第 1 式})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
e_+
&= \frac{e_+ + e_-}{(2)_{\mathbb{C}}} + i\,\frac{e_+ - e_-}{(2)_{\mathbb{C}}\,i}
&&(\because\ (2)_{\mathbb{C}} \neq 0_{\mathbb{C}},\ (2)_{\mathbb{C}}\,i \neq 0_{\mathbb{C}}\ \text{と}\ \mathbb{C}\ \text{の四則})\\
&= \frac{\exp\bigl(i(\theta)_{\mathbb{C}}\bigr) + \exp\bigl((-i)(\theta)_{\mathbb{C}}\bigr)}{(2)_{\mathbb{C}}}
  + i\,\frac{\exp\bigl(i(\theta)_{\mathbb{C}}\bigr) - \exp\bigl((-i)(\theta)_{\mathbb{C}}\bigr)}{(2)_{\mathbb{C}}\,i}
&&(\because\ e_\pm\ \text{の定義})\\
&= \frac{\exp\bigl(i(\theta)_{\mathbb{C}}\bigr) + \exp\bigl(-(i(\theta)_{\mathbb{C}})\bigr)}{(2)_{\mathbb{C}}}
  + i\,\frac{\exp\bigl(i(\theta)_{\mathbb{C}}\bigr) - \exp\bigl(-(i(\theta)_{\mathbb{C}})\bigr)}{(2)_{\mathbb{C}}\,i}
&&\bigl(\because\ \blkref{negative_i_times_complex_is_negation_of_i_times}\ (z \to (\theta)_{\mathbb{C}})\ \text{を 2 箇所へ}\bigr)\\
&= (\cos\theta)_{\mathbb{C}} + i(\sin\theta)_{\mathbb{C}}
&&(\because\ \blkref{euler_formula_cos_sin}\ \text{の第 1 式と第 2 式})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
e_-
&= \frac{e_+ + e_-}{(2)_{\mathbb{C}}} - i\,\frac{e_+ - e_-}{(2)_{\mathbb{C}}\,i}
&&(\because\ (2)_{\mathbb{C}} \neq 0_{\mathbb{C}},\ (2)_{\mathbb{C}}\,i \neq 0_{\mathbb{C}}\ \text{と}\ \mathbb{C}\ \text{の四則})\\
&= \frac{\exp\bigl(i(\theta)_{\mathbb{C}}\bigr) + \exp\bigl((-i)(\theta)_{\mathbb{C}}\bigr)}{(2)_{\mathbb{C}}}
  - i\,\frac{\exp\bigl(i(\theta)_{\mathbb{C}}\bigr) - \exp\bigl((-i)(\theta)_{\mathbb{C}}\bigr)}{(2)_{\mathbb{C}}\,i}
&&(\because\ e_\pm\ \text{の定義})\\
&= \frac{\exp\bigl(i(\theta)_{\mathbb{C}}\bigr) + \exp\bigl(-(i(\theta)_{\mathbb{C}})\bigr)}{(2)_{\mathbb{C}}}
  - i\,\frac{\exp\bigl(i(\theta)_{\mathbb{C}}\bigr) - \exp\bigl(-(i(\theta)_{\mathbb{C}})\bigr)}{(2)_{\mathbb{C}}\,i}
&&\bigl(\because\ \blkref{negative_i_times_complex_is_negation_of_i_times}\ (z \to (\theta)_{\mathbb{C}})\ \text{を 2 箇所へ}\bigr)\\
&= (\cos\theta)_{\mathbb{C}} - i(\sin\theta)_{\mathbb{C}}
&&(\because\ \blkref{euler_formula_cos_sin}\ \text{の第 1 式と第 2 式})
\end{aligned}`),
      paragraph(["さらに、これらから次の二本の補助的な等式を置く。"]),
      displayMath(String.raw`\begin{aligned}
a^2 + b^2 e_+ e_+
&= a^2 (e_+ e_-) + b^2 e_+ e_+
&&(\because\ e_+ e_- = 1_{\mathbb{C}})\\
&= e_+\left(a^2 e_- + b^2 e_+\right)
&&(\because\ \mathbb{C}\ \text{の分配則と積の交換律・結合律})\\
&= e_+\Bigl(a^2\bigl((\cos\theta)_{\mathbb{C}} - i(\sin\theta)_{\mathbb{C}}\bigr) + b^2 e_+\Bigr)
&&(\because\ e_-\ \text{の上の表示})\\
&= e_+\Bigl(a^2\bigl((\cos\theta)_{\mathbb{C}} - i(\sin\theta)_{\mathbb{C}}\bigr) + b^2\bigl((\cos\theta)_{\mathbb{C}} + i(\sin\theta)_{\mathbb{C}}\bigr)\Bigr)
&&(\because\ e_+\ \text{の上の表示})\\
&= e_+\Bigl(\left(a^2 + b^2\right)(\cos\theta)_{\mathbb{C}} - i\left(a^2 - b^2\right)(\sin\theta)_{\mathbb{C}}\Bigr)
&&(\because\ \mathbb{C}\ \text{の分配則})\\
&= e_+\Bigl((c_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}} - i\left(a^2 - b^2\right)(\sin\theta)_{\mathbb{C}}\Bigr)
&&(\because\ a^2 + b^2 = (c_1)_{\mathbb{C}})\\
&= e_+\Bigl((c_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}} - i(\sin\theta)_{\mathbb{C}}\Bigr)
&&(\because\ a^2 - b^2 = 1_{\mathbb{C}})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
a^2 + b^2 e_- e_-
&= a^2 (e_+ e_-) + b^2 e_- e_-
&&(\because\ e_+ e_- = 1_{\mathbb{C}})\\
&= e_-\left(a^2 e_+ + b^2 e_-\right)
&&(\because\ \mathbb{C}\ \text{の分配則と積の交換律・結合律})\\
&= e_-\Bigl(a^2\bigl((\cos\theta)_{\mathbb{C}} + i(\sin\theta)_{\mathbb{C}}\bigr) + b^2 e_-\Bigr)
&&(\because\ e_+\ \text{の上の表示})\\
&= e_-\Bigl(a^2\bigl((\cos\theta)_{\mathbb{C}} + i(\sin\theta)_{\mathbb{C}}\bigr) + b^2\bigl((\cos\theta)_{\mathbb{C}} - i(\sin\theta)_{\mathbb{C}}\bigr)\Bigr)
&&(\because\ e_-\ \text{の上の表示})\\
&= e_-\Bigl(\left(a^2 + b^2\right)(\cos\theta)_{\mathbb{C}} + i\left(a^2 - b^2\right)(\sin\theta)_{\mathbb{C}}\Bigr)
&&(\because\ \mathbb{C}\ \text{の分配則})\\
&= e_-\Bigl((c_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}} + i\left(a^2 - b^2\right)(\sin\theta)_{\mathbb{C}}\Bigr)
&&(\because\ a^2 + b^2 = (c_1)_{\mathbb{C}})\\
&= e_-\Bigl((c_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}} + i(\sin\theta)_{\mathbb{C}}\Bigr)
&&(\because\ a^2 - b^2 = 1_{\mathbb{C}})
\end{aligned}`),
      paragraph([
        "また ",
        ref("duality_c2_star_eq_s2_star_c2"),
        " の ",
        math(String.raw`c_2^* = s_2^* c_2`),
        " から",
      ]),
      displayMath(String.raw`\begin{aligned}
C
&= (c_2^*)_{\mathbb{C}}
&&(\because\ C\ \text{の定義})\\
&= (s_2^* c_2)_{\mathbb{C}}
&&(\because\ \blkref{duality_c2_star_eq_s2_star_c2})\\
&= S\,(c_2)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product},\ S\ \text{の定義})
\end{aligned}`),
      paragraph([
        "Step 1: ",
        math(String.raw`N := B_2\, B_1(\theta) \in \mathrm{Mat}(2,\mathbb{C})`),
        " の成分（行列の積は ",
        ref("mat_mult"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
N_{11}
&= C a + (iS)\bigl((i e_-) b\bigr)
&&(\because\ \blkref{mat_mult})\\
&= Ca - S b e_-
&&(\because\ i i = -1_{\mathbb{C}}\ \text{と}\ \mathbb{C}\ \text{の積の交換律・結合律})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
N_{12}
&= C\bigl(((-i)e_+) b\bigr) + (iS) a
&&(\because\ \blkref{mat_mult})\\
&= i\left(Sa - C b e_+\right)
&&(\because\ \mathbb{C}\ \text{の分配則と積の交換律・結合律})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
N_{21}
&= \bigl((-i)S\bigr) a + C\bigl((i e_-) b\bigr)
&&(\because\ \blkref{mat_mult})\\
&= i\left(C b e_- - S a\right)
&&(\because\ \mathbb{C}\ \text{の分配則と積の交換律・結合律})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
N_{22}
&= \bigl((-i)S\bigr)\bigl(((-i)e_+) b\bigr) + C a
&&(\because\ \blkref{mat_mult})\\
&= Ca - S b e_+
&&(\because\ (-i)(-i) = -1_{\mathbb{C}}\ \text{と}\ \mathbb{C}\ \text{の積の交換律・結合律})
\end{aligned}`),
      paragraph([
        "Step 2: ",
        math(String.raw`P := B_1(\theta)\, N \in \mathrm{Mat}(2,\mathbb{C})`),
        " の (1,1) 成分。",
      ]),
      displayMath(String.raw`\begin{aligned}
P_{11}
&= a N_{11} + \bigl(((-i)e_+)b\bigr) N_{21}
&&(\because\ \blkref{mat_mult})\\
&= a\left(Ca - S b e_-\right) + \bigl(((-i)e_+)b\bigr)\, i\left(C b e_- - S a\right)
&&(\because\ \text{Step 1 の } N_{11}, N_{21})\\
&= a\left(Ca - S b e_-\right) + e_+ b\left(C b e_- - S a\right)
&&(\because\ (-i) i = 1_{\mathbb{C}}\ \text{と}\ \mathbb{C}\ \text{の積の交換律・結合律})\\
&= C a^2 - S ab e_- + C b^2 e_+ e_- - S ab e_+
&&(\because\ \mathbb{C}\ \text{の分配則と積の交換律・結合律})\\
&= C a^2 - S ab e_- + C b^2 - S ab e_+
&&(\because\ e_+ e_- = 1_{\mathbb{C}})\\
&= C\left(a^2 + b^2\right) - S ab\left(e_+ + e_-\right)
&&(\because\ \mathbb{C}\ \text{の分配則})\\
&= C (c_1)_{\mathbb{C}} - S ab\left(e_+ + e_-\right)
&&(\because\ a^2 + b^2 = (c_1)_{\mathbb{C}})\\
&= C (c_1)_{\mathbb{C}} - S ab\,(2)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}}
&&(\because\ e_+ + e_- = (2)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}})\\
&= C (c_1)_{\mathbb{C}} - S\,(2ab)\,(\cos\theta)_{\mathbb{C}}
&&(\because\ \mathbb{C}\ \text{の積の交換律・結合律})\\
&= C (c_1)_{\mathbb{C}} - S\,(s_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}}
&&(\because\ 2ab = (s_1)_{\mathbb{C}})\\
&= (c_2^*)_{\mathbb{C}} (c_1)_{\mathbb{C}} - (s_2^*)_{\mathbb{C}}(s_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}}
&&(\because\ C, S\ \text{の定義を 2 箇所へ})\\
&= (c_1)_{\mathbb{C}}(c_2^*)_{\mathbb{C}} - (s_1)_{\mathbb{C}}(s_2^*)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}}
&&(\because\ \mathbb{C}\ \text{の積の交換律})\\
&= (c_1 c_2^*)_{\mathbb{C}} - (s_1 s_2^*)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product}\ \text{を 2 箇所へ})\\
&= (c_1 c_2^*)_{\mathbb{C}} - (s_1 s_2^*\cos\theta)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product})\\
&= (c_1 c_2^* - s_1 s_2^*\cos\theta)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_difference})
\end{aligned}`),
      paragraph([
        "これは ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\theta)`),
        " の (1,1) 成分である。",
      ]),
      paragraph(["Step 3: ", math(String.raw`P`), " の (2,2) 成分。"]),
      displayMath(String.raw`\begin{aligned}
P_{22}
&= \bigl((i e_-) b\bigr) N_{12} + a N_{22}
&&(\because\ \blkref{mat_mult})\\
&= \bigl((i e_-) b\bigr)\, i\left(Sa - C b e_+\right) + a\left(Ca - S b e_+\right)
&&(\because\ \text{Step 1 の } N_{12}, N_{22})\\
&= (-1_{\mathbb{C}})\, e_- b\left(Sa - C b e_+\right) + a\left(Ca - S b e_+\right)
&&(\because\ i i = -1_{\mathbb{C}}\ \text{と}\ \mathbb{C}\ \text{の積の交換律・結合律})\\
&= - S ab e_- + C b^2 e_+ e_- + C a^2 - S ab e_+
&&(\because\ \mathbb{C}\ \text{の分配則と積の交換律・結合律})\\
&= - S ab e_- + C b^2 + C a^2 - S ab e_+
&&(\because\ e_+ e_- = 1_{\mathbb{C}})\\
&= C\left(a^2 + b^2\right) - S ab\left(e_+ + e_-\right)
&&(\because\ \mathbb{C}\ \text{の分配則と和の交換律})\\
&= C (c_1)_{\mathbb{C}} - S ab\left(e_+ + e_-\right)
&&(\because\ a^2 + b^2 = (c_1)_{\mathbb{C}})\\
&= C (c_1)_{\mathbb{C}} - S ab\,(2)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}}
&&(\because\ e_+ + e_- = (2)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}})\\
&= C (c_1)_{\mathbb{C}} - S\,(2ab)\,(\cos\theta)_{\mathbb{C}}
&&(\because\ \mathbb{C}\ \text{の積の交換律・結合律})\\
&= C (c_1)_{\mathbb{C}} - S\,(s_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}}
&&(\because\ 2ab = (s_1)_{\mathbb{C}})\\
&= (c_2^*)_{\mathbb{C}} (c_1)_{\mathbb{C}} - (s_2^*)_{\mathbb{C}}(s_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}}
&&(\because\ C, S\ \text{の定義を 2 箇所へ})\\
&= (c_1)_{\mathbb{C}}(c_2^*)_{\mathbb{C}} - (s_1)_{\mathbb{C}}(s_2^*)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}}
&&(\because\ \mathbb{C}\ \text{の積の交換律})\\
&= (c_1 c_2^*)_{\mathbb{C}} - (s_1 s_2^*)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product}\ \text{を 2 箇所へ})\\
&= (c_1 c_2^*)_{\mathbb{C}} - (s_1 s_2^*\cos\theta)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product})\\
&= (c_1 c_2^* - s_1 s_2^*\cos\theta)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_difference})
\end{aligned}`),
      paragraph([
        "これは ",
        math(String.raw`A(\theta)`),
        " の (2,2) 成分である。",
      ]),
      paragraph(["Step 4: ", math(String.raw`P`), " の (1,2) 成分。"]),
      displayMath(String.raw`\begin{aligned}
P_{12}
&= a N_{12} + \bigl(((-i)e_+)b\bigr) N_{22}
&&(\because\ \blkref{mat_mult})\\
&= a\, i\left(Sa - C b e_+\right) + \bigl(((-i)e_+)b\bigr)\left(Ca - S b e_+\right)
&&(\because\ \text{Step 1 の } N_{12}, N_{22})\\
&= i\left(S a^2 - C ab e_+\right) + i\left(-C ab e_+ + S b^2 e_+ e_+\right)
&&(\because\ \mathbb{C}\ \text{の分配則と積の交換律・結合律})\\
&= i\left(S\left(a^2 + b^2 e_+ e_+\right) - (2ab)\, C e_+\right)
&&(\because\ \mathbb{C}\ \text{の分配則と積の交換律・結合律})\\
&= i\Bigl(S e_+\bigl((c_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}} - i(\sin\theta)_{\mathbb{C}}\bigr) - (2ab)\, C e_+\Bigr)
&&(\because\ \text{準備の補助的な等式の 1 本目})\\
&= i\Bigl(S e_+\bigl((c_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}} - i(\sin\theta)_{\mathbb{C}}\bigr) - (s_1)_{\mathbb{C}}\, C e_+\Bigr)
&&(\because\ 2ab = (s_1)_{\mathbb{C}})\\
&= i\Bigl(S e_+\bigl((c_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}} - i(\sin\theta)_{\mathbb{C}}\bigr) - (s_1)_{\mathbb{C}}\, S (c_2)_{\mathbb{C}} e_+\Bigr)
&&(\because\ C = S (c_2)_{\mathbb{C}})\\
&= i e_+ S\bigl((c_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}} - i(\sin\theta)_{\mathbb{C}} - (s_1)_{\mathbb{C}}(c_2)_{\mathbb{C}}\bigr)
&&(\because\ \mathbb{C}\ \text{の分配則と積の交換律・結合律})\\
&= i e_+ (s_2^*)_{\mathbb{C}}\bigl((c_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}} - i(\sin\theta)_{\mathbb{C}} - (s_1)_{\mathbb{C}}(c_2)_{\mathbb{C}}\bigr)
&&(\because\ S\ \text{の定義})
\end{aligned}`),
      paragraph([
        "これは ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\theta)`),
        " の (1,2) 成分である。",
      ]),
      paragraph(["Step 5: ", math(String.raw`P`), " の (2,1) 成分。"]),
      displayMath(String.raw`\begin{aligned}
P_{21}
&= \bigl((i e_-) b\bigr) N_{11} + a N_{21}
&&(\because\ \blkref{mat_mult})\\
&= \bigl((i e_-) b\bigr)\left(Ca - S b e_-\right) + a\, i\left(C b e_- - S a\right)
&&(\because\ \text{Step 1 の } N_{11}, N_{21})\\
&= i\left(C ab e_- - S b^2 e_- e_-\right) + i\left(C ab e_- - S a^2\right)
&&(\because\ \mathbb{C}\ \text{の分配則と積の交換律・結合律})\\
&= (-i)\left(S\left(a^2 + b^2 e_- e_-\right) - (2ab)\, C e_-\right)
&&(\because\ \mathbb{C}\ \text{の分配則と積の交換律・結合律})\\
&= (-i)\Bigl(S e_-\bigl((c_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}} + i(\sin\theta)_{\mathbb{C}}\bigr) - (2ab)\, C e_-\Bigr)
&&(\because\ \text{準備の補助的な等式の 2 本目})\\
&= (-i)\Bigl(S e_-\bigl((c_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}} + i(\sin\theta)_{\mathbb{C}}\bigr) - (s_1)_{\mathbb{C}}\, C e_-\Bigr)
&&(\because\ 2ab = (s_1)_{\mathbb{C}})\\
&= (-i)\Bigl(S e_-\bigl((c_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}} + i(\sin\theta)_{\mathbb{C}}\bigr) - (s_1)_{\mathbb{C}}\, S (c_2)_{\mathbb{C}} e_-\Bigr)
&&(\because\ C = S (c_2)_{\mathbb{C}})\\
&= (-i) e_- S\bigl((c_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}} + i(\sin\theta)_{\mathbb{C}} - (s_1)_{\mathbb{C}}(c_2)_{\mathbb{C}}\bigr)
&&(\because\ \mathbb{C}\ \text{の分配則と積の交換律・結合律})\\
&= (-i) e_- (s_2^*)_{\mathbb{C}}\bigl((c_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}} + i(\sin\theta)_{\mathbb{C}} - (s_1)_{\mathbb{C}}(c_2)_{\mathbb{C}}\bigr)
&&(\because\ S\ \text{の定義})\\
&= (-i) \exp\bigl((-i)(\theta)_{\mathbb{C}}\bigr) (s_2^*)_{\mathbb{C}}\bigl((c_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}} + i(\sin\theta)_{\mathbb{C}} - (s_1)_{\mathbb{C}}(c_2)_{\mathbb{C}}\bigr)
&&(\because\ e_-\ \text{の定義})\\
&= (-i) \exp\bigl(-(i(\theta)_{\mathbb{C}})\bigr) (s_2^*)_{\mathbb{C}}\bigl((c_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}} + i(\sin\theta)_{\mathbb{C}} - (s_1)_{\mathbb{C}}(c_2)_{\mathbb{C}}\bigr)
&&\bigl(\because\ \blkref{negative_i_times_complex_is_negation_of_i_times}\ (z \to (\theta)_{\mathbb{C}})\bigr)
\end{aligned}`),
      paragraph([
        "これは ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\theta)`),
        " の (2,1) 成分である。",
      ]),
      paragraph([
        "Step 6: 主張の左辺は ",
        ref("mat_mult_associative"),
        " により括弧の付け方によらず ",
        math(String.raw`B_1(\theta)\bigl(B_2 B_1(\theta)\bigr) = P`),
        " に等しい。Step 2〜5 で ",
        math(String.raw`P`),
        " の 4 成分が ",
        math(String.raw`A(\theta)`),
        " の対応する成分に等しいので、",
        math(String.raw`B_1(\theta) B_2 B_1(\theta) = A(\theta)`),
        " である。",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu \in \mathbb{R}`),
        " を ",
        math(String.raw`\theta`),
        " に取れば後半を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の factorization_of_A_theta は μ ∈ calM で量化された主張であり、そのままでは θ~_μ に適用できない。証明の実体（T_V_hatZ_hatY の proof の Step 1〜6）は θ ∈ R について何も μ に固有のことを使っていないので、ここでは θ ∈ R 一般の主張として立て直し、同じ行列計算を書き下した。",
        "θ を [0, 2π) 上で 60 点走査し、5 組の (K1,K2) について残差 1e-14 以下であることを数値確認済み（sagemath/check/047_claim_even_sector_T_action/check_04_T_V_plus_and_factorization.sage の (1)）。",
        "2026-08-19 の式変形統一で、Step 5 の「Step 4 とまったく同じ計算（θ → -θ）」に畳まれていた補助的な等式の導出と P_21 の整理を、Step 4 と同形の一続きの鎖（補助等式 5 段と P_21 の 6 段）へ開いた。内容・参照は変えていない。",
        "2026-11-02（全証明の SageMath 検算）: a, b, C, S と e_± := exp(±i(θ)_C) を ℂ の元として置き直し、A(θ) の実数の成分を包含の像として読んだ。本文に無かった「cosh_sinh_basic_properties の倍角公式」の参照を cosh_addition_formula・sinh_double_angle_formula と包含の積・和の保存に、行列の theorem_exp_product (n=1) を scalar_exp_product・scalar_exp_zero に付け替え、e_± = cos θ ± i sin θ を euler_formula_cos_sin から導く行を置いた。Step 4・5 の exp(±2iθ) を e_±e_± のまま扱い、Step 6 に積の結合律を引いた。主張の中身は不変。検算は sagemath/check/factorization_of_A_theta_general/。",
        "2026-11-09（Lean の通しの証明）: euler_formula_cos_sin は -iθ を -(iθ) と読む。e_- := exp((-i)(θ)_ℂ) と置いたまま引いていた準備の 5〜7 本目に、e_± の定義を展開する行と、negative_i_times_complex_is_negation_of_i_times で exp((-i)(θ)_ℂ) を exp(-(i(θ)_ℂ)) へ書き換える行を 1 行ずつ足した。主張と記号の置き方は変えていない。",
        "2026-11-10（Lean の通しの証明）: Step 2・3 の鎖は ℂ の式 (c_1)_ℂ(c_2^*)_ℂ - (s_1)_ℂ(s_2^*)_ℂ(cos θ)_ℂ で止めて def_A_theta の (1,1)・(2,2) 成分（実数の像）だと言っていたので、real_inclusion_preserves_product を 2 行、real_inclusion_preserves_difference を 1 行足して実数の像まで運んだ。証明冒頭の「A(θ) の成分に現れる実数は像として ℂ の演算にかける」を def_A_theta の読みへの参照にし、末尾の 3 行の三つの因子の積を左から括ることを書いた。主張は不変。",
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
    title: { tex: String.raw`V^{(+)} \text{ による } \check{Z}_\mu, \check{Y}_\mu \text{ の共役の、} 2\times2 \text{ 行列 } A(\tilde\theta_\mu) \text{ による表示}` },
    labels: ["T_V_plus_check_Z_Y_via_B1_B2_B1"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）とする。",
        ref("def_V_plus"),
        " の ",
        math(String.raw`V^{(+)}`),
        "（",
        ref("V_plus_factors_invertible"),
        " により ",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`R^\times`),
        " の元。",
        math(String.raw`R=\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "）、",
        ref("def_T_V_plus"),
        " の ",
        math(String.raw`T_{(V^{(+)})}`),
        "、",
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
        math(String.raw`R`),
        " の元）、",
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
        String.raw`\begin{aligned}
\left(V^{(+)}\check{Z}_\mu\left(V^{(+)}\right)^{-1},\; V^{(+)}\check{Y}_\mu\left(V^{(+)}\right)^{-1}\right)
&= \left(T_{(V^{(+)})}(\check{Z}_\mu),\; T_{(V^{(+)})}(\check{Y}_\mu)\right) \\
&= \left(\check{Z}_\mu,\; \check{Y}_\mu\right) A\!\left(\tilde\theta_\mu\right) \\
&= \left(\check{Z}_\mu,\; \check{Y}_\mu\right) B_1\!\left(\tilde\theta_\mu\right) B_2\, B_1\!\left(\tilde\theta_\mu\right)
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。行ベクトルと ",
        math(String.raw`2\times 2`),
        " 行列の積は ",
        ref("def_pair_of_matrices_times_two_by_two_matrix"),
        "・",
        ref("def_pair_of_matrices_times_column_of_numbers"),
        " を続けて展開した ",
        math(String.raw`\begin{pmatrix}A, & B\end{pmatrix}\begin{pmatrix}p & q \\ r & s\end{pmatrix} = (pA + rB,\ qA + sB)`),
        " である。最後の等号の根拠である行列の等式 ",
        math(String.raw`A(\theta) = B_1(\theta) B_2 B_1(\theta)\ (\theta \in \mathbb{R})`),
        " は ",
        ref("factorization_of_A_theta_general"),
        " である。",
      ]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
\left(V^{(+)}\check{Z}_\mu\left(V^{(+)}\right)^{-1},\; V^{(+)}\check{Y}_\mu\left(V^{(+)}\right)^{-1}\right)
&= \left(T_{V^{(+)}}(\check{Z}_\mu),\; T_{V^{(+)}}(\check{Y}_\mu)\right)
&&(\because\ \blkref{def_T_g}\ \text{を}\ g = V^{(+)}\ \text{として。}\ V^{(+)} \in R^\times\ \text{は}\ \blkref{V_plus_factors_invertible}) \\
&= \left(T_{(V^{(+)})}(\check{Z}_\mu),\; T_{(V^{(+)})}(\check{Y}_\mu)\right)
&&(\because\ \blkref{T_V_plus_is_conjugation}) \\
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
        "2026-10-31: 章立ての組み直しで、離散 Fourier 変換による 2×2 行列 A(θ̃_μ) への帰着の章のゴールの式を一つの主張として立てた。既存の主張を順に当てるだけで、新しい証明は無い。",
        "2026-10-31: 章立て案の約束 T_{(V)}(X)=VXV^{-1} と合わせるため、V^{(+)} による共役から始まる式変形にした（T_V_plus_is_conjugation と V_plus_factors_invertible を対角化の章からこの章へ移して引く）。",
      ],
    },
  },
]);
