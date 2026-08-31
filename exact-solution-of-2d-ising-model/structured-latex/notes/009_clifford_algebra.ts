import { defineNotes, paragraph, math, displayMath, list, ref } from "../schema.ts";

// 「なぜこの計算に至ったのか」を説明するための読み物（README 5 節）。
// クリフォード代数はテンソル代数の商代数として定義されるため、README 2 節の基準により
// 厳密証明（content/）には持ち込まない。本文はこのノートに一切依存していない。

export default defineNotes([
  {
    id: "note_clifford_000_scope_and_disclaimer",
    targets: ["Z_Y_generate_algebra", "anticommutator_of_Z_and_Y"],
    title: { text: "読み物：この証明の骨格はクリフォード代数である（位置づけと注意）" },
    body: [
      paragraph([
        "この一連のノートは、証明の各ステップが「なぜそう進むのか」「なぜその形で答が出るのか」を、",
        "クリフォード代数という既知の構造に照らして説明するための読み物である。",
        "厳密な証明ではなく、厳密である必要もない。",
      ]),
      paragraph(["扱いについて、はじめに 2 点を明記する。"]),
      list([
        [
          "厳密証明には含めない。 クリフォード代数はテンソル代数の商代数として定義される。",
          "これは README 2 節「使ってよい道具・使わない道具」の基準（抽象テンソル積の一般論を本文に出さない）",
          "に抵触するため、本文（",
          math(String.raw`\texttt{content/}`),
          "）には持ち込まない。",
        ],
        [
          "本文の証明はこのノートに依存していない。 本文は複素行列の具体的な計算だけで自足しており、",
          "以下で述べる一般論を 1 つも使っていない。逆に言えば、以下は「本文が具体計算で再現している構造は何か」",
          "を後から見取り図として与えるものである。",
        ],
      ]),
      paragraph([
        "以下、",
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " を固定し、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`Z_1,\dots,Z_M, Y_1,\dots,Y_M \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " を考える。",
      ]),
    ],
  },
  {
    id: "note_clifford_001_anticommutation_is_the_defining_relation",
    targets: ["anticommutator_of_Z_and_Y", "def_transfer_matrix_symbols"],
    title: { text: "読み物：反交換関係はそのままクリフォード代数の定義関係式である" },
    body: [
      paragraph([
        ref("anticommutator_of_Z_and_Y"),
        " で示した関係は、",
      ]),
      displayMath(
        String.raw`[Z_\mu, Z_\nu]_+ = 2\,\delta^M_{(\mu,\nu)}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}, \qquad
[Z_\mu, Y_\nu]_+ = 0, \qquad
[Y_\mu, Y_\nu]_+ = 2\,\delta^M_{(\mu,\nu)}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}`,
      ),
      paragraph([
        "であった。ここで ",
        math(String.raw`2M`),
        " 個の行列に通し番号を振り、",
      ]),
      displayMath(
        String.raw`(e_1,\dots,e_{2M}) := (Z_1,\dots,Z_M,\;Y_1,\dots,Y_M)`,
      ),
      paragraph(["と書き直すと、上の 3 本はまとめて 1 本の式になる："]),
      displayMath(
        String.raw`e_a e_b + e_b e_a = 2\,\delta_{ab}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
\qquad (a, b \in \{1,\dots,2M\}).`,
      ),
      paragraph([
        "これは、",
        math(String.raw`2M`),
        " 次元の空間に標準的な（非退化な）二次形式 ",
        math(String.raw`q(x) = x_1^2 + \cdots + x_{2M}^2`),
        " を入れたときのクリフォード代数 ",
        math(String.raw`\mathrm{Cl}_{2M}(\mathbb{C})`),
        " の定義関係式そのものである。",
        "つまり本文は、クリフォード代数という言葉を一度も使わずに、その定義関係式を満たす具体的な行列の組を",
        "手で作って、関係式を成分計算で検証した、ということになる。",
      ]),
      paragraph([
        "定義関係式を満たすということは、以後の計算で使える規則が「隣り合う 2 つを入れ替えると符号が反転する",
        "（同じもの同士なら二乗して単位行列になる）」だけに尽きる、ということでもある。",
        "実際、本文で反交換関係を使う場面は、どれもこの規則で語の並べ替えを行っているだけである。",
      ]),
    ],
  },
  {
    id: "note_clifford_002_dimension_and_jordan_wigner",
    targets: ["Z_Y_generate_algebra", "Z_Y_linearly_independent"],
    title: { text: "読み物：生成される代数の次元が行列全体と一致すること（Jordan–Wigner 構成）" },
    body: [
      paragraph([
        "クリフォード代数 ",
        math(String.raw`\mathrm{Cl}_{2M}(\mathbb{C})`),
        " の元は、上の関係式で並べ替えを繰り返すと、常に",
      ]),
      displayMath(
        String.raw`e_{a_1} e_{a_2} \cdots e_{a_r} \qquad (1 \leq a_1 < a_2 < \cdots < a_r \leq 2M)`,
      ),
      paragraph([
        "という形（添字が狭義単調増加な語）の ",
        math(String.raw`\mathbb{C}`),
        "-線型結合に書き直せる。添字の選び方は部分集合の選び方と 1 対 1 なので、この形の語はちょうど ",
        math(String.raw`2^{2M}`),
        " 個ある。一方、",
      ]),
      displayMath(
        String.raw`\dim_{\mathbb{C}} \mathrm{Mat}(2^M,\mathbb{C})
= \dim_{\mathbb{C}} \mathrm{Mat}(2^M, \mathbb{C})
= 2^M \times 2^M = 2^{2M}`,
      ),
      paragraph([
        "であり、次元が一致する。したがって「",
        math(String.raw`Z, Y`),
        " が全体を生成する」ことと「単調語が線型独立である」ことは同じ事柄の両面であり、",
        math(String.raw`\mathrm{Cl}_{2M}(\mathbb{C}) \cong \mathrm{Mat}(2^M,\mathbb{C})`),
        " という同型が成り立つ。",
      ]),
      paragraph([
        "Jordan–Wigner 構成とは、この同型を具体的に与える処方箋のことである。 ",
        ref("def_transfer_matrix_symbols"),
        " の",
      ]),
      displayMath(
        String.raw`Z_m = \sigma_1^x \cdots \sigma_{m-1}^x\, \sigma_m^z, \qquad
Y_m = \sigma_1^x \cdots \sigma_{m-1}^x\, \sigma_m^y`,
      ),
      paragraph([
        "という定義に現れる、先頭から ",
        math(String.raw`m-1`),
        " 番目までにかかる ",
        math(String.raw`\sigma^x`),
        " の列（いわゆる「弦」）が、まさにその処方箋である。",
        "同じサイト上では ",
        math(String.raw`\sigma^z`),
        " と ",
        math(String.raw`\sigma^y`),
        " が反可換であることから反交換が出て、異なるサイト同士では、この弦が長さの差の分だけ ",
        math(String.raw`\sigma^x`),
        " を挟むことで符号 ",
        math(String.raw`-1`),
        " を発生させる。弦がなければ異なるサイトの行列は可換になってしまい、クリフォードの関係式は成立しない。",
      ]),
      paragraph([
        "本文で言えば、",
        ref("Z_Y_generate_algebra"),
        "（",
        math(String.raw`Z, Y`),
        " が ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " を環として生成する）と ",
        ref("Z_Y_linearly_independent"),
        " が、この同型の 2 つの側面（全射性・単射性）に対応している。",
        "本文はこれを抽象的な同型定理としてではなく、Pauli 行列の具体的な語の計算として示している。",
      ]),
      paragraph([
        "この同型が効いているのは、次の一点である。",
        math(String.raw`2M`),
        " 個の生成元の言葉で書けたことは、",
        math(String.raw`2^M \times 2^M`),
        " 行列としての情報を何も失っていない。 ",
        "以降の議論が、巨大な行列そのものではなく ",
        math(String.raw`2M`),
        " 個の生成元の変換だけを追えば済むのは、このためである。",
      ]),
    ],
  },
  {
    id: "note_clifford_003_quadratic_exponential_acts_orthogonally",
    targets: ["T_V_hatZ_hatY", "def_T_V", "V1_in_Z_Y_epsilon", "V2_in_Z_Y"],
    title: { text: "読み物：二次形式の指数関数による共役が、生成元の空間の直交変換になること" },
    body: [
      paragraph([
        "生成元の張る ",
        math(String.raw`\mathbb{C}`),
        "-線型空間を",
      ]),
      displayMath(
        String.raw`\mathcal{V} := \mathrm{span}_{\mathbb{C}}\{e_1,\dots,e_{2M}\}
= \mathrm{span}_{\mathbb{C}}\{Z_1,\dots,Z_M,Y_1,\dots,Y_M\}
\qquad (\dim_{\mathbb{C}} \mathcal{V} = 2M)`,
      ),
      paragraph([
        "とおく。生成元の二次式（",
        math(String.raw`e_a e_b`),
        " の線型結合）を ",
        math(String.raw`X`),
        " とし、その指数関数による共役 ",
        math(String.raw`x \mapsto e^{X} x\, e^{-X}`),
        " を考えると、次が起きる。",
      ]),
      list([
        [
          "反交換関係から ",
          math(String.raw`[e_a e_b,\, e_c]`),
          " はふたたび生成元の線型結合になる（3 個の積が 1 個に落ちる）。",
        ],
        [
          "したがって共役の級数展開 ",
          math(String.raw`e^{X} x e^{-X} = \sum_{n\geq 0} \frac{1}{n!}[X,[X,\dots,[X,x]\dots]]`),
          " の各項がすべて ",
          math(String.raw`\mathcal{V}`),
          " の元であり、",
          math(String.raw`e^{X}\mathcal{V}e^{-X} = \mathcal{V}`),
          "。すなわち共役は ",
          math(String.raw`\mathcal{V}`),
          " 上の線型変換に制限される。",
        ],
        [
          "共役は積を保つので、",
          math(String.raw`e_a e_b + e_b e_a = 2\delta_{ab}I`),
          " という関係式も保たれる。つまり ",
          math(String.raw`\mathcal{V}`),
          " 上の変換は二次形式 ",
          math(String.raw`q`),
          " を保つ、すなわち直交変換である。",
        ],
      ]),
      paragraph([
        "これが、証明全体でいちばん効いている構造である。",
        math(String.raw`2^M \times 2^M`),
        " という巨大な行列の共役という操作が、",
        math(String.raw`2M`),
        " 次元空間の直交変換という有限次元の線型代数に化ける。",
        "しかも「二次式の指数関数」という条件は本文の主役たちが実際に満たしている：",
        ref("V1_in_Z_Y_epsilon"),
        " と ",
        ref("V2_in_Z_Y"),
        " が示すとおり、",
      ]),
      displayMath(
        String.raw`V_1 = \exp\!\bigl(i K_1 (Y_1 Z_2 + \cdots + Y_{M-1} Z_M - \varepsilon Y_M Z_1)\bigr), \qquad
V_2 = (2 s_2)^{M/2} \exp\!\bigl(i K_2^{*} (Z_1 Y_1 + \cdots + Z_M Y_M)\bigr)`,
      ),
      paragraph([
        "であり、指数の中身はどちらも生成元の二次式である（",
        math(String.raw`V_2`),
        " の前のスカラー ",
        math(String.raw`(2s_2)^{M/2}`),
        " は共役では打ち消えるので効かない）。",
      ]),
      paragraph([
        "残るのは「その直交変換を具体的に書き下す」ことだが、ここで ",
        ref("def_hatZ_hatY"),
        " のフーリエ変換された組 ",
        math(String.raw`\hat{Z}_\mu^{(\pm)}, \hat{Y}_\mu`),
        " が効く。並進対称性のおかげで直交変換は各波数 ",
        math(String.raw`\mu`),
        " ごとの 2 次元部分空間 ",
        math(String.raw`\mathrm{span}_{\mathbb{C}}\{\hat{Z}_\mu^{(-)}, \hat{Y}_\mu\}`),
        " を保つ。したがって ",
        math(String.raw`2M`),
        " 次元の直交変換は ",
        math(String.raw`2\times 2`),
        " のブロックへ分解し、各ブロックが 1 個の ",
        math(String.raw`2\times 2`),
        " 行列で書ける。これが ",
        ref("T_V_hatZ_hatY"),
        " の",
      ]),
      displayMath(
        String.raw`\left(T_{(V)}(\hat{Z}_\mu^{(-)}),\; T_{(V)}(\hat{Y}_\mu)\right)
= \left(\hat{Z}_\mu^{(-)},\; \hat{Y}_\mu\right) A\!\left(\frac{2\pi\mu}{M}\right)`,
      ),
      paragraph([
        "という形、すなわち「共役が ",
        math(String.raw`A(\theta)`),
        " という ",
        math(String.raw`2\times 2`),
        " 行列の作用に化ける」ことの理由である。",
        "なぜ ",
        math(String.raw`2\times 2`),
        " 行列の対角化だけで話が済むのか、という問いへの答もこれで尽きている。",
      ]),
      paragraph([
        "なお本文は、この一般論を使わずに ",
        ref("T_V_hatZ_hatY"),
        " を直接の級数展開で証明している（README 2 節によりリー群・リー環の一般論を使わないため）。",
        "上の話は「なぜその級数がきれいに閉じるはずだと予想できたのか」を説明するものであって、",
        "本文の証明の一部ではない。",
      ]),
    ],
  },
  {
    id: "note_clifford_004_kernel_is_scalar",
    targets: ["V_eq_Vprime", "T_V_eq_T_Vprime", "centralizer_is_scalar"],
    title: { text: "読み物：対応の核がスカラーであること（定数倍を除いてしか決まらない理由）" },
    body: [
      paragraph([
        "前項の対応を、写像として書き直す。可逆な ",
        math(String.raw`W \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " のうち共役が ",
        math(String.raw`\mathcal{V}`),
        " を保つものを集めると群（クリフォード群）になり、",
      ]),
      displayMath(
        String.raw`W \;\longmapsto\; \bigl(T_{(W)} : x \mapsto W x W^{-1}\bigr)\big|_{\mathcal{V}}`,
      ),
      paragraph([
        "は、この群から ",
        math(String.raw`\mathcal{V}`),
        " の直交変換群への準同型になる。ここで問題になるのがこの写像の核、",
        "すなわち「共役として何もしない ",
        math(String.raw`W`),
        "」が何かである。",
      ]),
      paragraph([
        math(String.raw`W`),
        " がすべての生成元と可換なら、生成元の積とその線型結合すべてとも可換である。",
        "前項の同型（",
        ref("Z_Y_generate_algebra"),
        "）により、生成元の積と線型結合は ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " 全体を尽くすので、",
        math(String.raw`W`),
        " は全行列環の中心の元になる。そして中心はスカラーに限る（",
        ref("centralizer_is_scalar"),
        "）。すなわち",
      ]),
      displayMath(
        String.raw`\ker\bigl(W \mapsto T_{(W)}\bigr) = \{\, c\, I_{\mathrm{Mat}(2^M,\mathbb{C})} \;:\; c \in \mathbb{C}^{\times} \,\}`,
      ),
      paragraph([
        "である。核がスカラーちょうどであることが、「共役が一致する 2 つの行列は定数倍を除いて一致する」",
        "という主張の構造的な意味である。",
      ]),
      paragraph([
        "本文でこれに当たるのが ",
        ref("T_V_eq_T_Vprime"),
        "（共役写像として ",
        math(String.raw`T_{(V)} = T_{(V')}`),
        "）から ",
        ref("V_eq_Vprime"),
        "（ある ",
        math(String.raw`c \in \mathbb{C}^{\times}`),
        " が存在して ",
        math(String.raw`V = c\,V'`),
        "）を導く箇所である。本文はここで、群論的な言葉ではなく、",
        math(String.raw`V (V')^{-1}`),
        " がすべての元と可換であることを直接示し、中心がスカラーであること（",
        ref("centralizer_is_scalar"),
        "）を適用して結論している。",
      ]),
      paragraph([
        "なぜ定数倍を除いてしか決まらないのかという問いへの答は、したがって「共役という操作が中心の情報を",
        "原理的に捨ててしまうから」であり、その中心が（複素行列環では）スカラーに尽きるから、",
        "捨てられる情報がちょうど定数倍 1 つ分だけで済む、ということになる。",
        "この定数は後段で別途決める必要があり、実際に本文でもそうしている。",
      ]),
    ],
  },
]);
