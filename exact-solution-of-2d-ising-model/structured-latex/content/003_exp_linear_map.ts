import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "heading_exp_linear_map",
    kind: "heading",
    level: 2,
    origin: { path: "_old/typst/main.typ", ordinal: 4 },
    title: { text: "線型写像のexp" },
    labels: [],
  },
  {
    id: "exp_linear_map_000a_claim_real_exp_series_converges",
    kind: "claim",
    origin: { path: "structured-latex/content/003_exp_linear_map.ts", ordinal: 1 },
    title: { text: "非負実数の指数級数の収束" },
    labels: ["real_exp_series_converges"],
    statement: [
      paragraph([
        math(String.raw`a \in \mathbb{R}_{\ge 0}`),
        " とし、",
        math(String.raw`N \in \mathbb{Z}_{\ge 0}`),
        " について",
      ]),
      displayMath(
        String.raw`E_N(a) := \sum_{m=0}^{N}\frac{a^m}{m!}
\qquad (a^0 := 1,\ 0! := 1)`,
      ),
      paragraph(["とおく。このとき次が成り立つ。"]),
      list([
        [
          "(1) ",
          math(String.raw`(E_N(a))_{N\ge 0}`),
          " は単調非減少かつ上に有界であり、収束する。その極限を ",
          math(String.raw`E(a) := \sum_{m=0}^{\infty}\frac{a^m}{m!}`),
          " と書く。",
        ],
        [
          "(2) すべての ",
          math(String.raw`N`),
          " について ",
          math(String.raw`E_N(a)\le E(a)`),
          "。",
        ],
        [
          "(3) 剰余 ",
          math(String.raw`R_N(a) := E(a)-E_N(a)`),
          " は非負であり ",
          math(String.raw`R_N(a)\to 0\ (N\to\infty)`),
          "。さらに ",
          math(String.raw`p,q\in\mathbb{Z}_{\ge 1},\ p\le q`),
          " について ",
          math(String.raw`\sum_{m=p}^{q}\dfrac{a^m}{m!}\le R_{p-1}(a)`),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "Step 1: 単調非減少性。",
        math(String.raw`a\ge 0`),
        " より各項 ",
        math(String.raw`a^m/m!\ge 0`),
        " であるから",
      ]),
      displayMath(
        String.raw`E_{N+1}(a)-E_N(a)=\frac{a^{N+1}}{(N+1)!}\ge 0`,
      ),
      paragraph([
        "Step 2: 上に有界であること。Archimedes の原理より ",
        math(String.raw`m_0\in\mathbb{Z}_{\ge 1}`),
        " で ",
        math(String.raw`m_0\ge 2a`),
        " を満たすものがとれる。",
        math(String.raw`m\ge m_0`),
        " のとき ",
        math(String.raw`m+1>m_0\ge 2a`),
        " すなわち ",
        math(String.raw`a/(m+1)\le 1/2`),
        " であるから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{a^{m+1}}{(m+1)!}
&= \frac{a}{m+1}\cdot\frac{a^m}{m!}
&&\bigl(\because\ (m+1)! = (m+1)\cdot m!\bigr)\\
&\le \frac{1}{2}\cdot\frac{a^m}{m!}
&&\bigl(\because\ a/(m+1)\le 1/2 \text{ と } a^m/m!\ge 0\bigr)
\end{aligned}`,
      ),
      paragraph([
        "これを ",
        math(String.raw`k`),
        " に関する帰納法で繰り返すと ",
        math(String.raw`k\in\mathbb{Z}_{\ge 0}`),
        " について",
      ]),
      displayMath(
        String.raw`\frac{a^{m_0+k}}{(m_0+k)!}\le\left(\frac{1}{2}\right)^k\frac{a^{m_0}}{m_0!}`,
      ),
      paragraph([
        "（",
        math(String.raw`k=0`),
        " は等号。",
        math(String.raw`k`),
        " から ",
        math(String.raw`k+1`),
        " へは上の不等式を ",
        math(String.raw`m=m_0+k\ (\ge m_0)`),
        " に適用する。）よって ",
        math(String.raw`N\ge m_0`),
        " のとき等比数列の和の公式より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{m=m_0}^{N}\frac{a^m}{m!}
&\le \frac{a^{m_0}}{m_0!}\sum_{k=0}^{N-m_0}\left(\frac{1}{2}\right)^k
&&\bigl(\because\ \text{各項へ直前の評価 } a^{m_0+k}/(m_0+k)!\le (1/2)^k a^{m_0}/m_0! \text{ を適用した}\bigr)\\
&= \frac{a^{m_0}}{m_0!}\left(2-\left(\frac{1}{2}\right)^{N-m_0}\right)
&&\bigl(\because\ \text{等比数列の和の公式}\bigr)\\
&\le \frac{2a^{m_0}}{m_0!}
&&\bigl(\because\ (1/2)^{N-m_0}\ge 0\bigr)
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`N\ge m_0`),
        " について ",
        math(String.raw`E_N(a)\le E_{m_0-1}(a)+\dfrac{2a^{m_0}}{m_0!}=:C`),
        "。",
        math(String.raw`N<m_0`),
        " のときは Step 1 より ",
        math(String.raw`E_N(a)\le E_{m_0-1}(a)\le C`),
        "。よって ",
        math(String.raw`(E_N(a))`),
        " は ",
        math(String.raw`C`),
        " で上に有界である。",
      ]),
      paragraph([
        "Step 3: (1)。単調非減少かつ上に有界な実数列は収束する（",
        math(String.raw`\mathbb{R}`),
        " の連続性、すなわち上に有界な集合が上限をもつことによる）。よって ",
        math(String.raw`E(a):=\lim_{N\to\infty}E_N(a)`),
        " が存在する。",
      ]),
      paragraph([
        "Step 4: (2)。単調非減少な収束列の極限はその上限であるから、すべての ",
        math(String.raw`N`),
        " について ",
        math(String.raw`E_N(a)\le E(a)`),
        "。",
      ]),
      paragraph([
        "Step 5: (3)。(2) より ",
        math(String.raw`R_N(a)=E(a)-E_N(a)\ge 0`),
        " であり、",
        math(String.raw`E_N(a)\to E(a)`),
        " より ",
        math(String.raw`R_N(a)\to 0`),
        "。また ",
        math(String.raw`1\le p\le q`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{m=p}^{q}\frac{a^m}{m!}
&= E_q(a)-E_{p-1}(a)
&&\bigl(\because\ E_N(a)=\sum_{m=0}^{N}a^m/m! \text{ の差}\bigr)\\
&\le E(a)-E_{p-1}(a)
&&\bigl(\because\ (2)\bigr)\\
&= R_{p-1}(a)
&&\bigl(\because\ R_N(a)=E(a)-E_N(a) \text{ の定義}\bigr)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。exp 級数の収束（labels: exp_converges）と" +
          "可換行列の exp 積公式（labels: theorem_exp_product）の証明が土台として使う" +
          "実数の指数級数の収束と剰余評価を、章の冒頭に置いた。",
        "2026-09-01 の式変形統一で、三本の鎖に行中の \\quad(\\because …) で置かれていた根拠 8 行を、" +
          "他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。内容・式変形・根拠は変えていない。",
      ],
    },
  },
  {
    id: "exp_linear_map_000b_claim_matrix_exp_series_converges",
    kind: "claim",
    origin: { path: "structured-latex/content/003_exp_linear_map.ts", ordinal: 1 },
    title: { text: "行列の exp 級数はノルム収束する" },
    labels: ["matrix_exp_series_converges"],
    statement: [
      paragraph(["行列積は ", ref("mat_mult"), "、実数係数を複素数として使うときの包含は ", ref("inclusion_rr_to_cc"), " による。"]),
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,K)`),
        " とし、ノルムと収束は ",
        ref("def_matrix_norm"),
        " のものとする。",
        math(String.raw`A^0 := I`),
        "（単位行列）とおき",
      ]),
      displayMath(String.raw`S_N(A) := \sum_{m=0}^{N}\frac{1}{m!}A^m \in \mathrm{Mat}(n,K)`),
      paragraph(["とおくと、次が成り立つ。"]),
      list([
        [
          "(1) ",
          math(String.raw`\sum_{m=0}^{\infty}\frac{1}{m!}A^m := \lim_{N\to\infty}S_N(A)`),
          " は ",
          math(String.raw`\mathrm{Mat}(n,K)`),
          " において存在する。",
        ],
        [
          "(2) ",
          math(String.raw`M_A := \|I\| + E(\|A\|)`),
          "（",
          math(String.raw`E`),
          " は ",
          ref("real_exp_series_converges"),
          " の極限）とおくと、すべての ",
          math(String.raw`N`),
          " について ",
          math(String.raw`\|S_N(A)\| \le M_A`),
          " であり、",
          math(String.raw`\left\|\sum_{m=0}^{\infty}\frac{1}{m!}A^m\right\| \le M_A`),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "Step 1: ",
        math(String.raw`m\ge 1`),
        " について ",
        math(String.raw`\|A^m\|\le\|A\|^m`),
        "。",
        math(String.raw`m`),
        " に関する帰納法で示す。",
        math(String.raw`m=1`),
        " のときは等号。",
        math(String.raw`m`),
        " で成り立つとすると ",
        ref("matrix_norm_submultiplicativity"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|A^{m+1}\|
&= \|A^m A\|
&&\bigl(\because\ A^{m+1}=A^m A\bigr) \\
&\le \|A^m\|\cdot\|A\|
&&\bigl(\because\ \text{ノルムの劣乗法性}\bigr) \\
&\le \|A\|^m\cdot\|A\|
&&\bigl(\because\ \text{帰納法の仮定}\bigr) \\
&= \|A\|^{m+1}
&&\bigl(\because\ \text{冪の定義}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "Step 2: 実数級数 ",
        math(String.raw`\sum_{m=0}^{\infty}\left\|\frac{1}{m!}A^m\right\|`),
        " の収束。",
        ref("matrix_norm_triangle_inequality"),
        " (2) より ",
        math(String.raw`\left\|\frac{1}{m!}A^m\right\|=\frac{1}{m!}\|A^m\|`),
        "（",
        math(String.raw`1/m!>0`),
        " なので ",
        math(String.raw`|1/m!|=1/m!`),
        "）であるから、Step 1 より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{m=0}^{N}\left\|\frac{1}{m!}A^m\right\|
&= \|I\| + \sum_{m=1}^{N}\frac{\|A^m\|}{m!}
&&\bigl(\because\ m=0 \text{ の項は } \|A^0\|=\|I\| \text{、他の項は上の等式}\bigr) \\
&\le \|I\| + \sum_{m=1}^{N}\frac{\|A\|^m}{m!}
&&\bigl(\because\ \text{Step 1}\bigr) \\
&\le \|I\| + E(\|A\|)
&&\bigl(\because\ \text{非負実数の指数級数の収束 } (2)\bigr) \\
&= M_A
&&\bigl(\because\ M_A \text{ の定義}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "（第 3 行の不等号は ",
        ref("real_exp_series_converges"),
        " (2) による。）この実数級数は非負項なので部分和は単調非減少であり、いま ",
        math(String.raw`M_A`),
        " で上に有界であるから収束する（",
        math(String.raw`\mathbb{R}`),
        " の連続性）。",
      ]),
      paragraph([
        "Step 3: (1)。Step 2 と ",
        ref("matrix_completeness"),
        " (2)（絶対収束判定）より ",
        math(String.raw`\sum_{m=0}^{\infty}\frac{1}{m!}A^m`),
        " は ",
        math(String.raw`\mathrm{Mat}(n,K)`),
        " において収束する。",
      ]),
      paragraph([
        "Step 4: (2)。有限和については",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|S_N(A)\|
&\le \sum_{m=0}^{N}\left\|\frac{1}{m!}A^m\right\|
&&\bigl(\because\ \text{ノルムの三角不等式 } (3) \text{ を繰り返し用いる}\bigr) \\
&\le M_A
&&\bigl(\because\ \text{Step 2 の評価}\bigr)
\end{aligned}`,
      ),
      paragraph(["である。無限和については"]),
      displayMath(
        String.raw`\begin{aligned}
\left\|\sum_{m=0}^{\infty}\frac{1}{m!}A^m\right\|
&\le \sum_{m=0}^{\infty}\left\|\frac{1}{m!}A^m\right\|
&&\bigl(\because\ \text{Mat}(n,K) \text{ の完備性と絶対収束判定 } (2) \text{ の後半}\bigr) \\
&\le M_A
&&\bigl(\because\ \text{Step 2 の評価}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "である（引いたブロックは ",
        ref("matrix_norm_triangle_inequality"),
        " と ",
        ref("matrix_completeness"),
        "）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。原文の exp 級数の収束（labels: exp_converges）は" +
          "「各点収束」だけを主張しているが、可換行列の exp 積公式（labels: theorem_exp_product）の証明は" +
          "Mat(n,K) におけるノルム収束を必要とするため、独立した主張として切り出した。",
        "2026-09-01 の式変形統一で、四本の鎖に行中の \\quad (\\because …) で置かれていた根拠 12 行を、" +
          "他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。内容・式変形・根拠は変えていない。",
      ],
    },
  },
  {
    id: "exp_linear_map_001_theorem_exp_series_pointwise_converges",
    kind: "theorem",
    standing: "mainTheorem",
    origin: {
      path: "_old/typst/parts/003_線型写像のexp/000_theorem_線型写像のexpの級数が各点収束すること.typ",
      ordinal: 1,
    },
    title: { text: "exp 級数の各点収束（数ベクトルへの作用・成分・行列への線型写像）" },
    labels: ["exp_converges"],
    statement: [
      paragraph(["行列と数ベクトルの積は ", ref("mat_mult"), "、非負実数の平方根は ", ref("definition_of_sqrt_r_positive"), "、実数係数の複素数への包含は ", ref("inclusion_rr_to_cc"), " による。"]),
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\ge 1}`),
        " とし、ノルムと収束は ",
        ref("def_matrix_norm"),
        " のものとする。",
      ]),
      paragraph([
        "(1) ",
        math(String.raw`A \in \mathrm{Mat}(n,K)`),
        " とし、",
      ]),
      displayMath(
        String.raw`S_N := \sum_{m=0}^{N}\frac{1}{m!}A^m \in \mathrm{Mat}(n,K), \qquad
S := \sum_{m=0}^{\infty}\frac{1}{m!}A^m \in \mathrm{Mat}(n,K)`,
      ),
      paragraph([
        "とおく（",
        math(String.raw`S`),
        " の存在は ",
        ref("matrix_exp_series_converges"),
        " (1) による）。このとき次が成り立つ。",
      ]),
      list([
        [
          "(1a)（数ベクトルへの作用の各点収束）すべての ",
          math(String.raw`v \in K^n`),
          " について ",
          math(String.raw`S_N v \to S v`),
          " が ",
          math(String.raw`K^n`),
          " において成り立つ。",
        ],
        [
          "(1b)（成分ごとの収束）すべての ",
          math(String.raw`i, j \in \{1,\dots,n\}`),
          " について ",
          math(String.raw`(S_N)_{ij} \to S_{ij}`),
          "、すなわち ",
          math(String.raw`\left|(S_N)_{ij}-S_{ij}\right| \to 0`),
          "。",
        ],
      ]),
      paragraph([
        "(2) ",
        math(String.raw`\Phi : \mathrm{Mat}(n,K) \to \mathrm{Mat}(n,K)`),
        " を ",
        math(String.raw`K`),
        "-線型写像とする。すなわち ",
        math(String.raw`Y, Z \in \mathrm{Mat}(n,K)`),
        "、",
        math(String.raw`c \in K`),
        " について ",
        math(String.raw`\Phi(Y+Z)=\Phi(Y)+\Phi(Z)`),
        " かつ ",
        math(String.raw`\Phi(cY)=c\,\Phi(Y)`),
        " が成り立つとする。",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " について行列単位 ",
        math(String.raw`E^{(k,l)} \in \mathrm{Mat}(n,K)`),
        " を",
      ]),
      displayMath(
        String.raw`\left(E^{(k,l)}\right)_{ij} :=
\begin{cases} 1 & ((i,j)=(k,l)) \\ 0 & (\text{それ以外}) \end{cases}`,
      ),
      paragraph([" で定め、"]),
      displayMath(
        String.raw`c_{\Phi} := \sqrt{\sum_{k=1}^{n}\sum_{l=1}^{n}\left\|\Phi\!\left(E^{(k,l)}\right)\right\|^2}^{\,(\mathbb{R}_{\ge 0})}
\in \mathbb{R}_{\ge 0}`,
      ),
      paragraph([
        " とおく。また ",
        math(String.raw`\Phi^0 := \mathrm{id}_{\mathrm{Mat}(n,K)}`),
        "、",
        math(String.raw`\Phi^{m+1} := \Phi \circ \Phi^{m}`),
        "（",
        math(String.raw`m \in \mathbb{Z}_{\ge 0}`),
        "）とおく。このとき次が成り立つ。",
      ]),
      list([
        [
          "(2a) すべての ",
          math(String.raw`Y \in \mathrm{Mat}(n,K)`),
          " について ",
          math(String.raw`\|\Phi(Y)\| \le c_{\Phi}\,\|Y\|`),
          "。",
        ],
        [
          "(2b) すべての ",
          math(String.raw`m \in \mathbb{Z}_{\ge 0}`),
          " について ",
          math(String.raw`\Phi^m`),
          " は ",
          math(String.raw`K`),
          "-線型であり、",
          math(String.raw`\|\Phi^m(Y)\| \le c_{\Phi}^{\,m}\,\|Y\|`),
          "（",
          math(String.raw`c_{\Phi}^{\,0}:=1`),
          "）。",
        ],
        [
          "(2c)（各点収束）すべての ",
          math(String.raw`Y \in \mathrm{Mat}(n,K)`),
          " について、部分和 ",
          math(String.raw`T_N(Y) := \sum_{m=0}^{N}\frac{1}{m!}\Phi^m(Y)`),
          " は ",
          math(String.raw`\mathrm{Mat}(n,K)`),
          " において収束する。その極限を ",
          math(String.raw`T(Y) := \sum_{m=0}^{\infty}\frac{1}{m!}\Phi^m(Y)`),
          " と書く。",
        ],
        [
          "(2d) ",
          math(String.raw`T : \mathrm{Mat}(n,K) \to \mathrm{Mat}(n,K)`),
          " は ",
          math(String.raw`K`),
          "-線型写像である。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "以下、",
        math(String.raw`\|\cdot\|`),
        " と収束は ",
        ref("def_matrix_norm"),
        " のもの（",
        math(String.raw`K^n`),
        " と ",
        math(String.raw`\mathrm{Mat}(n,K)`),
        " の成分の平方和の平方根）である。",
      ]),
      paragraph([
        "Step 1: 成分の絶対値はノルム以下である。",
        math(String.raw`B=(b_{ij})\in\mathrm{Mat}(n,K)`),
        " と ",
        math(String.raw`i,j\in\{1,\dots,n\}`),
        " について、",
        ref("def_matrix_norm"),
        " の定義に現れる平方和は非負項の有限和であり ",
        math(String.raw`|b_{ij}|^2`),
        " はその項の 1 つであるから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|b_{ij}|^2
&\le \sum_{k=1}^{n}\sum_{l=1}^{n}|b_{kl}|^2
&&(\because\ \text{非負項の有限和は各項以上である})\\
&= \|B\|^2
&&(\because\ \text{ノルムの定義と}\ \left(\sqrt{a}^{(\mathbb{R}_{\ge 0})}\right)^2=a)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`|b_{ij}|\ge 0`),
        " かつ ",
        math(String.raw`\|B\|\ge 0`),
        " であるから ",
        ref("matrix_norm_triangle_inequality"),
        " の Step 0（非負実数の平方の単調性）より",
      ]),
      displayMath(String.raw`|b_{ij}| \le \|B\| \qquad (i,j\in\{1,\dots,n\})`),
      paragraph([
        "Step 2: (1b)。",
        ref("matrix_exp_series_converges"),
        " (1) と ",
        ref("def_matrix_norm"),
        " の収束の定義より ",
        math(String.raw`\|S_N-S\|\to 0`),
        "。行列の差は成分ごとの差であるから ",
        math(String.raw`(S_N-S)_{ij}=(S_N)_{ij}-S_{ij}`),
        " であり、Step 1 を ",
        math(String.raw`B=S_N-S`),
        " に適用して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&\le \left|(S_N)_{ij}-S_{ij}\right|
&&(\because\ \text{絶対値は非負である})\\
&= \left|(S_N-S)_{ij}\right|
&&(\because\ \text{行列の差は成分ごとの差である})\\
&\le \|S_N-S\|
&&(\because\ \text{Step 1 を}\ B=S_N-S\ \text{に適用する})
\end{aligned}`,
      ),
      paragraph([
        "右辺は ",
        math(String.raw`0`),
        " に収束するから ",
        math(String.raw`\left|(S_N)_{ij}-S_{ij}\right|\to 0`),
        "。",
      ]),
      paragraph([
        "Step 3: (1a)。",
        math(String.raw`v\in K^n`),
        " を固定する。行列と数ベクトルの積は分配律を満たすから ",
        math(String.raw`S_Nv-Sv=(S_N-S)v`),
        " であり、",
        ref("matrix_norm_vector_bound"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&\le \|S_Nv-Sv\|
&&(\because\ \text{ノルムは非負である})\\
&= \|(S_N-S)v\|
&&(\because\ \text{行列と数ベクトルの積の分配律})\\
&\le \|S_N-S\|\cdot\|v\|
&&(\because\ \text{行列のノルムによる数ベクトルの評価})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\|v\|`),
        " は ",
        math(String.raw`N`),
        " によらない非負定数であり、Step 2 より ",
        math(String.raw`\|S_N-S\|\to 0`),
        " であるから右辺は ",
        math(String.raw`0`),
        " に収束する。よって ",
        math(String.raw`\|S_Nv-Sv\|\to 0`),
        " すなわち ",
        math(String.raw`S_Nv\to Sv`),
        "。",
      ]),
      paragraph([
        "Step 4: 行列単位による展開。",
        math(String.raw`Y=(y_{kl})\in\mathrm{Mat}(n,K)`),
        " について",
      ]),
      displayMath(
        String.raw`Y=\sum_{k=1}^{n}\sum_{l=1}^{n}y_{kl}E^{(k,l)}`,
      ),
      paragraph([
        "が成り立つ。実際、行列の和とスカラー倍は成分ごとに定まるので右辺の ",
        math(String.raw`(i,j)`),
        " 成分は ",
        math(String.raw`\sum_{k=1}^{n}\sum_{l=1}^{n}y_{kl}\left(E^{(k,l)}\right)_{ij}`),
        " であり、",
        math(String.raw`E^{(k,l)}`),
        " の定義よりこの和では ",
        math(String.raw`(k,l)=(i,j)`),
        " の項が ",
        math(String.raw`y_{ij}\cdot 1=y_{ij}`),
        "、他の項は ",
        math(String.raw`y_{kl}\cdot 0=0`),
        " であるから、和は ",
        math(String.raw`y_{ij}`),
        " に等しい。また ", ref("def_matrix_norm"), " より",
      ]),
      displayMath(String.raw`\begin{aligned}
\left\|E^{(k,l)}\right\|
&=\sqrt{1}^{\,(\mathbb{R}_{\ge 0})}
&&\left(\because\ \text{行列ノルムの定義と }E^{(k,l)}\text{ の成分の定義}\right)\\
&=1
&&\left(\because\ \mathbb{R}_{\ge0}\text{ における }1\text{ の非負平方根}\right).
\end{aligned}`),
      paragraph([
        "Step 5: (2a)。",
        math(String.raw`\Phi`),
        " の線型性を Step 4 の有限和に繰り返し適用すると（項数に関する帰納法）",
      ]),
      displayMath(
        String.raw`\Phi(Y)=\sum_{k=1}^{n}\sum_{l=1}^{n}y_{kl}\,\Phi\!\left(E^{(k,l)}\right)`,
      ),
      paragraph([
        ref("matrix_norm_triangle_inequality"),
        " (3) を有限個の項に繰り返し用い、続いて同 (2) を用いると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|\Phi(Y)\|
&= \left\|\sum_{k=1}^{n}\sum_{l=1}^{n}y_{kl}\,\Phi\!\left(E^{(k,l)}\right)\right\|
&&(\because\ \text{直前の等式})\\
&\le \sum_{k=1}^{n}\sum_{l=1}^{n}\left\|y_{kl}\,\Phi\!\left(E^{(k,l)}\right)\right\|
&&(\because\ \text{三角不等式を有限個の項に繰り返し用いる})\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n}|y_{kl}|\,\left\|\Phi\!\left(E^{(k,l)}\right)\right\|
&&(\because\ \text{スカラー倍のノルム})
\end{aligned}`,
      ),
      paragraph([
        "この二重和に Cauchy--Schwarz の不等式を適用する。全単射",
      ]),
      displayMath(
        String.raw`\sigma : \{1,\dots,n\}^2 \to \{1,\dots,n^2\},
\qquad \sigma(k,l) := (k-1)n+l`,
      ),
      paragraph([
        " により二重和を 1 重の和へ書き換え（有限和の項の並べ替え）、",
        ref("matrix_norm_triangle_inequality"),
        " の Step 4（有限列に対する Cauchy--Schwarz の不等式）を ",
        math(String.raw`u_{\sigma(k,l)}:=|y_{kl}|`),
        "、",
        math(String.raw`v_{\sigma(k,l)}:=\left\|\Phi\!\left(E^{(k,l)}\right)\right\|`),
        " に適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\sum_{k=1}^{n}\sum_{l=1}^{n}|y_{kl}|\,\left\|\Phi\!\left(E^{(k,l)}\right)\right\|\right)^2
&\le\left(\sum_{k=1}^{n}\sum_{l=1}^{n}|y_{kl}|^2\right)
\left(\sum_{k=1}^{n}\sum_{l=1}^{n}\left\|\Phi\!\left(E^{(k,l)}\right)\right\|^2\right)
&&(\because\ \text{有限列に対する Cauchy--Schwarz の不等式})\\
&=\|Y\|^2\,c_{\Phi}^2
&&(\because\ \left(\sqrt{a}^{(\mathbb{R}_{\ge 0})}\right)^2=a\ \text{を両方の和に用いる})\\
&=\left(c_{\Phi}\|Y\|\right)^2
&&(\because\ \text{非負実数の積の平方})
\end{aligned}`,
      ),
      paragraph([
        "左辺の平方の中身 ",
        math(String.raw`\sum_{k,l}|y_{kl}|\,\left\|\Phi\!\left(E^{(k,l)}\right)\right\|`),
        " と ",
        math(String.raw`c_{\Phi}\|Y\|`),
        " はともに非負であるから、",
        ref("matrix_norm_triangle_inequality"),
        " の Step 0 より",
      ]),
      displayMath(
        String.raw`\sum_{k=1}^{n}\sum_{l=1}^{n}|y_{kl}|\,\left\|\Phi\!\left(E^{(k,l)}\right)\right\|
\le c_{\Phi}\|Y\|`,
      ),
      paragraph([
        "以上を合わせて ",
        math(String.raw`\|\Phi(Y)\|\le c_{\Phi}\|Y\|`),
        "。",
      ]),
      paragraph([
        "Step 6: (2b)。",
        math(String.raw`m`),
        " に関する帰納法で示す。",
        math(String.raw`m=0`),
        " のとき ",
        math(String.raw`\Phi^0=\mathrm{id}_{\mathrm{Mat}(n,K)}`),
        " は線型である。ノルムについては",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left\|\Phi^0(Y)\right\|
&=\|Y\|
&&(\because\ \Phi^0=\mathrm{id}_{\mathrm{Mat}(n,K)})\\
&=c_{\Phi}^{\,0}\|Y\|
&&(\because\ \text{非負実数の零乗は }1)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`m`),
        " で成り立つとすると、",
        math(String.raw`Y,Z\in\mathrm{Mat}(n,K)`),
        "、",
        math(String.raw`c\in K`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\Phi^{m+1}(Y+Z)
&= \Phi\!\left(\Phi^m(Y+Z)\right)
&&(\because\ \Phi^{m+1}=\Phi\circ\Phi^m) \\
&= \Phi\!\left(\Phi^m(Y)+\Phi^m(Z)\right)
&&(\because\ \Phi^m \text{ の線型性}) \\
&= \Phi\!\left(\Phi^m(Y)\right)+\Phi\!\left(\Phi^m(Z)\right)
&&(\because\ \Phi \text{ の線型性}) \\
&= \Phi^{m+1}(Y)+\Phi^{m+1}(Z)
&&(\because\ \Phi^{m+1}=\Phi\circ\Phi^m) \\
\Phi^{m+1}(cY)
&= \Phi\!\left(\Phi^m(cY)\right)
&&(\because\ \Phi^{m+1}=\Phi\circ\Phi^m) \\
&= \Phi\!\left(c\,\Phi^m(Y)\right)
&&(\because\ \Phi^m \text{ の線型性}) \\
&= c\,\Phi\!\left(\Phi^m(Y)\right)
&&(\because\ \Phi \text{ の線型性}) \\
&= c\,\Phi^{m+1}(Y)
&&(\because\ \Phi^{m+1}=\Phi\circ\Phi^m)
\end{aligned}`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`\Phi^{m+1}`),
        " は ",
        math(String.raw`K`),
        "-線型。ノルムについては Step 5 と帰納法の仮定より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left\|\Phi^{m+1}(Y)\right\|
&= \left\|\Phi\!\left(\Phi^m(Y)\right)\right\|
&&(\because\ \Phi^{m+1}=\Phi\circ\Phi^m)\\
&\le c_{\Phi}\left\|\Phi^m(Y)\right\|
&&(\because\ \text{Step 5 を}\ Y=\Phi^m(Y)\ \text{に適用する})\\
&\le c_{\Phi}\cdot c_{\Phi}^{\,m}\|Y\|
&&(\because\ \text{帰納法の仮定と}\ c_{\Phi}\ge 0)\\
&= c_{\Phi}^{\,m+1}\|Y\|
&&(\because\ \text{非負実数の冪の指数法則})
\end{aligned}`,
      ),
      paragraph([
        "Step 7: (2c)。",
        math(String.raw`Y\in\mathrm{Mat}(n,K)`),
        " を固定する。",
        ref("matrix_norm_triangle_inequality"),
        " (2)（",
        math(String.raw`1/m!>0`),
        " なので ",
        math(String.raw`|1/m!|=1/m!`),
        "）と (2b) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{m=0}^{N}\left\|\frac{1}{m!}\Phi^m(Y)\right\|
&= \sum_{m=0}^{N}\frac{\left\|\Phi^m(Y)\right\|}{m!}
&&(\because\ \text{スカラー倍のノルムと}\ |1/m!|=1/m!)\\
&\le \|Y\|\sum_{m=0}^{N}\frac{c_{\Phi}^{\,m}}{m!}
&&(\because\ \text{(2b) を各項に適用する})\\
&\le \|Y\|\,E(c_{\Phi})
&&(\because\ \text{非負実数の指数級数の部分和の上界を}\ a=c_{\Phi}\ \text{に適用し、}\ \|Y\|\ge 0)
\end{aligned}`,
      ),
      paragraph([
        "（最後の不等号で引いたのは ",
        ref("real_exp_series_converges"),
        " (2) である）。左辺は非負項の実数級数の部分和なので単調非減少であり、いま ",
        math(String.raw`\|Y\|\,E(c_{\Phi})`),
        " で上に有界であるから収束する（",
        math(String.raw`\mathbb{R}`),
        " の連続性）。よって ",
        ref("matrix_completeness"),
        " (2)（絶対収束判定）より ",
        math(String.raw`\sum_{m=0}^{\infty}\frac{1}{m!}\Phi^m(Y)`),
        " は ",
        math(String.raw`\mathrm{Mat}(n,K)`),
        " において収束する。極限が一意であることは ",
        ref("matrix_norm_triangle_inequality"),
        " (4) による。",
      ]),
      paragraph([
        "Step 8: (2d)。まず ",
        math(String.raw`T_N`),
        " は線型である。実際 (2b) より各 ",
        math(String.raw`\Phi^m`),
        " は線型であり、行列の和とスカラー倍の性質から ",
        math(String.raw`T_N(Y+Z)=T_N(Y)+T_N(Z)`),
        "、",
        math(String.raw`T_N(cY)=c\,T_N(Y)`),
        " が成り立つ（有限和なので項ごとに確かめればよい）。",
      ]),
      paragraph([
        math(String.raw`Y,Z\in\mathrm{Mat}(n,K)`),
        " について、",
        math(String.raw`T_N`),
        " の線型性と ",
        ref("matrix_norm_triangle_inequality"),
        " (3) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&\le \left\|T_N(Y+Z)-\left(T(Y)+T(Z)\right)\right\|
&&(\because\ \text{ノルムは非負である})\\
&= \left\|\left(T_N(Y)-T(Y)\right)+\left(T_N(Z)-T(Z)\right)\right\|
&&(\because\ T_N\ \text{の線型性})\\
&\le \left\|T_N(Y)-T(Y)\right\|+\left\|T_N(Z)-T(Z)\right\|
&&(\because\ \text{三角不等式})
\end{aligned}`,
      ),
      paragraph([
        "右辺は Step 7（",
        math(String.raw`T_N(Y)\to T(Y)`),
        " と ",
        math(String.raw`T_N(Z)\to T(Z)`),
        "）より ",
        math(String.raw`0`),
        " に収束するから ",
        math(String.raw`T_N(Y+Z)\to T(Y)+T(Z)`),
        "。一方、",
        math(String.raw`T`),
        " の定義より ",
        math(String.raw`T_N(Y+Z)\to T(Y+Z)`),
        " であるから、",
        ref("matrix_norm_triangle_inequality"),
        " (4)（極限の一意性）より ",
        math(String.raw`T(Y+Z)=T(Y)+T(Z)`),
        "。",
      ]),
      paragraph([
        "同様に ",
        math(String.raw`c\in K`),
        " について、",
        math(String.raw`T_N`),
        " の線型性と ",
        ref("matrix_norm_triangle_inequality"),
        " (2) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&\le \left\|T_N(cY)-c\,T(Y)\right\|
&&(\because\ \text{ノルムは非負である})\\
&= \left\|c\left(T_N(Y)-T(Y)\right)\right\|
&&(\because\ T_N\ \text{の線型性})\\
&= |c|\cdot\left\|T_N(Y)-T(Y)\right\|
&&(\because\ \text{スカラー倍のノルム})
\end{aligned}`,
      ),
      paragraph([
        "であり、右辺は Step 7 より ",
        math(String.raw`0`),
        " に収束する。よって ",
        math(String.raw`T_N(cY)\to c\,T(Y)`),
        " であり、",
        math(String.raw`T_N(cY)\to T(cY)`),
        " と極限の一意性より ",
        math(String.raw`T(cY)=c\,T(Y)`),
        "。したがって ",
        math(String.raw`T`),
        " は ",
        math(String.raw`K`),
        "-線型写像である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文は「有限次元行列表現に帰着し、各成分が絶対収束する（証明略）」として TODO を置いていた。" +
          "ここでは原文の道筋（行列への帰着、絶対収束）を保ったまま証明を完成させた。" +
          "行列側のノルム収束は別ブロック（labels: matrix_exp_series_converges）に切り出している。",
        "原文の「各成分は絶対収束する」を、Mat(n,K) におけるノルムでの絶対収束" +
          "（labels: matrix_completeness の絶対収束判定）と、成分ごとの評価 |b_ij| <= ||B||（Step 1）" +
          "として実装した。",
        "この主張は以前、体 K 上の抽象的な有限次元ノルム線型空間 V とその自己準同型 X : V -> V " +
          "について述べており、証明で基底の存在・座標写像 c : V -> K^d・線型同型・dim_K V を使っていた。" +
          "README 4 節（主張は複素行列について具体的に述べる。一般論へ持ち上げない）と " +
          "README 3 節 4（未定義の概念を残さない。本文には「ノルム線型空間」の定義が無かった）に反するため、" +
          "本文で実際に必要な 2 つの形（(1) Mat(n,K) の行列が K^n のベクトルへ作用する場合、" +
          "(2) Mat(n,K) 上の K-線型写像の場合）へ具体的に述べ直した。" +
          "行列単位 E^(k,l) による展開は「基底が存在する」という一般論ではなく、" +
          "行列の成分の定義からその場で確かめられる等式である。" +
          "抽象的な一般化（任意の有限次元ノルム線型空間で同じ結論が成り立つこと）は " +
          "notes/003_exp_abstract_normed_space.ts へ退避した。",
        "2026-09-01 の式変形統一で、Step 6 の線型性の鎖に行中の \\quad (\\because …) で置かれていた" +
          "根拠 8 行を、他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。内容・式変形・根拠は変えていない。",
      ],
    },
  },
  {
    id: "exp_linear_map_002_definition_exp_of_endomorphism",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/003_線型写像のexp/001_definition_有限次元線型空間の自己準同型のexpの定義.typ",
      ordinal: 2,
    },
    title: { text: "exp の定義（行列の場合と、行列への線型写像の場合）" },
    labels: ["def_exp"],
    statement: [
      paragraph(["行列の積は ", ref("mat_mult"), "、実数係数の複素数への包含は ", ref("inclusion_rr_to_cc"), " を用いる。"]),
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\ge 1}`),
        " とし、ノルムと収束は ",
        ref("def_matrix_norm"),
        " のものとする。",
      ]),
      paragraph([
        "(1)（行列の exp）",
        math(String.raw`A \in \mathrm{Mat}(n,K)`),
        " について、",
        math(String.raw`A^0 := I`),
        "（単位行列）、",
        math(String.raw`A^{m+1} := A^m A`),
        " とおき",
      ]),
      displayMath(
        String.raw`\exp(A) := \sum_{m=0}^{\infty}\frac{1}{m!}A^m
= \lim_{N\to\infty}\sum_{m=0}^{N}\frac{1}{m!}A^m
\in \mathrm{Mat}(n,K)`,
      ),
      paragraph([
        " と定める。この極限は ",
        ref("matrix_exp_series_converges"),
        " (1) により存在し、",
        ref("matrix_norm_triangle_inequality"),
        " (4) により一意である。これにより写像 ",
        math(String.raw`\exp : \mathrm{Mat}(n,K) \to \mathrm{Mat}(n,K)`),
        " が定まる。",
      ]),
      paragraph([
        "(2)（行列への線型写像の exp）",
        math(String.raw`\Phi : \mathrm{Mat}(n,K) \to \mathrm{Mat}(n,K)`),
        " を ",
        math(String.raw`K`),
        "-線型写像とし、",
        math(String.raw`\Phi^0 := \mathrm{id}_{\mathrm{Mat}(n,K)}`),
        "、",
        math(String.raw`\Phi^{m+1} := \Phi \circ \Phi^{m}`),
        " とおく。写像 ",
        math(String.raw`\exp(\Phi) : \mathrm{Mat}(n,K) \to \mathrm{Mat}(n,K)`),
        " を",
      ]),
      displayMath(
        String.raw`\left(\exp(\Phi)\right)(Y) := \sum_{m=0}^{\infty}\frac{1}{m!}\Phi^m(Y)
= \lim_{N\to\infty}\sum_{m=0}^{N}\frac{1}{m!}\Phi^m(Y)
\qquad (Y \in \mathrm{Mat}(n,K))`,
      ),
      paragraph([
        " で定める。各 ",
        math(String.raw`Y`),
        " についてこの極限が存在すること（各点収束）は ",
        ref("exp_converges"),
        " (2c) により、一意であることは ",
        ref("matrix_norm_triangle_inequality"),
        " (4) による。また ",
        ref("exp_converges"),
        " (2d) より ",
        math(String.raw`\exp(\Phi)`),
        " は ",
        math(String.raw`K`),
        "-線型写像である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文は「有限次元線型空間 V の自己準同型 X ∈ End(V) の exp」として定義していた。" +
          "README 4 節（主張は複素行列について具体的に述べる）に従い、" +
          "本文で exp が実際に適用される 2 つの形だけを具体的に定義した。" +
          "(1) は Mat(n,K) の行列（転送行列の V_1, V_2 は labels: def_end_iso の同一視により " +
          "Mat(2^M,C) の行列として扱われる）、" +
          "(2) は Mat(n,K) 上の K-線型写像（labels: def_ad_X_matrix の ad_X がこれに当たる）である。" +
          "抽象的な有限次元線型空間 V と End(V) は本文から取り除いた。" +
          "採用しなかった一般化は notes/003_exp_abstract_normed_space.ts に記録している。",
      ],
    },
  },
  {
    id: "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
    kind: "theorem",
    standing: "mainTheorem",
    origin: { path: "_old/typst/parts/003_線型写像のexp/002_theorem_可換行列のexpの積公式.typ", ordinal: 3 },
    title: { text: "可換行列の exp 積公式" },
    labels: ["theorem_exp_product"],
    statement: [
      paragraph(["行列積は ", ref("mat_mult"), "、成分の演算は ", ref("complex_numbers_form_a_field"), "、実数係数の包含は ", ref("inclusion_rr_to_cc"), "、非負平方根は ", ref("definition_of_sqrt_r_positive"), " による。二項係数とPascalの関係式は ", ref("ad_binomial"), " の定義と証明の準備で述べたものを使う。"]),
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
      ]),
      paragraph([
        math(String.raw`A, B \in \mathrm{Mat}(n, K)`),
        " が ",
        math(String.raw`AB = BA`),
        " を満たすとき、",
      ]),
      displayMath(String.raw`\exp(A)\exp(B) = \exp(A + B)`),
    ],
    proof: [
      paragraph([
        "以下、",
        ref("def_exp"),
        " (1) の ",
        math(String.raw`\exp`),
        " を",
      ]),
      displayMath(
        String.raw`\exp(A)=\sum_{m=0}^{\infty}\frac{1}{m!}A^m \in \mathrm{Mat}(n,K)`,
      ),
      paragraph([
        "（",
        ref("def_matrix_norm"),
        " の意味での収束）として扱う。この級数が収束することは ",
        ref("matrix_exp_series_converges"),
        " による。記号を",
      ]),
      displayMath(
        String.raw`S_N := \sum_{m=0}^{N}\frac{1}{m!}A^m, \qquad
T_N := \sum_{m=0}^{N}\frac{1}{m!}B^m, \qquad
C_N := \sum_{k=0}^{N}\frac{1}{k!}(A+B)^k`,
      ),
      paragraph([
        " と定め、",
        math(String.raw`a:=\|A\|,\ b:=\|B\|\in\mathbb{R}_{\ge 0}`),
        " とおく。",
      ]),
      paragraph([
        "Step 1: ",
        math(String.raw`A`),
        " は ",
        math(String.raw`B`),
        " の冪と可換である。すなわち ",
        math(String.raw`m\in\mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`AB^m=B^mA`),
        "。",
        math(String.raw`m`),
        " に関する帰納法で示す。",
        math(String.raw`m=0`),
        " のときは",
      ]),
      displayMath(
        String.raw`\begin{aligned}
AI
&= A
&&(\because\ I\ \text{は単位行列である})\\
&= IA
&&(\because\ I\ \text{は単位行列である})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`m`),
        " で成り立つとすると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
AB^{m+1}
&= (AB^m)B
&&(\because\ B^{m+1}=B^mB\ \text{と積の結合律})\\
&= (B^mA)B
&&(\because\ \text{帰納法の仮定})\\
&= B^m(AB)
&&(\because\ \text{積の結合律})\\
&= B^m(BA)
&&(\because\ AB=BA)\\
&= B^{m+1}A
&&(\because\ \text{積の結合律と}\ B^mB=B^{m+1})
\end{aligned}`,
      ),
      paragraph([
        "Step 2: 二項定理。",
        math(String.raw`k\in\mathbb{Z}_{\ge 0}`),
        " について",
      ]),
      displayMath(
        String.raw`(A+B)^k=\sum_{j=0}^{k}\binom{k}{j}A^jB^{k-j}`,
      ),
      paragraph([
        "を ",
        math(String.raw`k`),
        " に関する帰納法で示す。",
        math(String.raw`k=0`),
        " のときは両辺とも ",
        math(String.raw`I`),
        "。",
        math(String.raw`k`),
        " で成り立つとすると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(A+B)^{k+1}
&= (A+B)^k(A+B)
&&(\because\ \text{冪の定義})\\
&= \left(\sum_{j=0}^{k}\binom{k}{j}A^jB^{k-j}\right)(A+B)
&&(\because\ \text{帰納法の仮定})\\
&= \sum_{j=0}^{k}\binom{k}{j}A^jB^{k-j}A
 + \sum_{j=0}^{k}\binom{k}{j}A^jB^{k-j}B
&&(\because\ \text{積の分配律})\\
&= \sum_{j=0}^{k}\binom{k}{j}A^{j+1}B^{k-j}
 + \sum_{j=0}^{k}\binom{k}{j}A^{j}B^{k-j+1}
&&(\because\ \text{Step 1 を第 1 和の各項へ当てる})\\
&= \sum_{j=1}^{k+1}\binom{k}{j-1}A^{j}B^{k+1-j}
 + \sum_{j=0}^{k}\binom{k}{j}A^{j}B^{k+1-j}
&&(\because\ \text{第 1 和で}\ j \to j-1\ \text{と添字を付け替えた})\\
&= \sum_{j=0}^{k+1}\left(\binom{k}{j-1}+\binom{k}{j}\right)A^{j}B^{k+1-j}
&&\left(\because\ \binom{k}{-1}:=0,\ \binom{k}{k+1}:=0\ \text{として和をまとめた}\right)\\
&= \sum_{j=0}^{k+1}\binom{k+1}{j}A^{j}B^{k+1-j}
&&(\because\ \text{Pascal の関係式})
\end{aligned}`,
      ),
      paragraph([
        "Step 3: 部分和の書き換え。",
        math(String.raw`\binom{k}{j}\frac{1}{k!}=\frac{1}{j!\,(k-j)!}`),
        " であるから、Step 2 より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
C_N
&= \sum_{k=0}^{N}\frac{1}{k!}\sum_{j=0}^{k}\binom{k}{j}A^jB^{k-j}
&&(\because\ \text{Step 2 を各}\ k\ \text{へ当てる})\\
&= \sum_{k=0}^{N}\sum_{j=0}^{k}\frac{1}{j!\,(k-j)!}A^jB^{k-j}
&&\left(\because\ \binom{k}{j}\frac{1}{k!}=\frac{1}{j!\,(k-j)!}\right)\\
&= \sum_{(j,l)\in D_N}\frac{1}{j!\,l!}A^jB^{l}
&&(\because\ l:=k-j\ \text{と置くと添字は}\ D_N:=\{(j,l)\in\mathbb{Z}_{\ge 0}^2 \mid j+l\le N\}\ \text{を走る})
\end{aligned}`,
      ),
      paragraph(["一方、有限和の積を展開して"]),
      displayMath(
        String.raw`\begin{aligned}
S_NT_N
&= \left(\sum_{j=0}^{N}\frac{1}{j!}A^j\right)\left(\sum_{l=0}^{N}\frac{1}{l!}B^l\right)
&&(\because\ S_N,\ T_N\ \text{の置き方})\\
&= \sum_{(j,l)\in Q_N}\frac{1}{j!\,l!}A^jB^{l}
&&(\because\ \text{積の分配律。添字は}\ Q_N:=\{0,1,\dots,N\}^2\ \text{を走る})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`(j,l)\in D_N`),
        " ならば ",
        math(String.raw`j\le j+l\le N`),
        " かつ ",
        math(String.raw`l\le N`),
        " であるから ",
        math(String.raw`D_N\subseteq Q_N`),
        "。よって",
      ]),
      displayMath(
        String.raw`S_NT_N-C_N=\sum_{(j,l)\in Q_N\setminus D_N}\frac{1}{j!\,l!}A^jB^{l}`,
      ),
      paragraph([
        "Step 4: 各項のノルム評価。",
        math(String.raw`\|I\|\ge 1`),
        " である（",
        ref("def_matrix_norm"),
        " より ",
        math(String.raw`\|I\|=\sqrt{n}^{\,(\mathbb{R}_{\ge 0})}`),
        " であり ",
        math(String.raw`n\ge 1`),
        "）。",
        ref("matrix_exp_series_converges"),
        " の Step 1 より ",
        math(String.raw`j\ge 1`),
        " で ",
        math(String.raw`\|A^j\|\le a^j`),
        "、",
        math(String.raw`j=0`),
        " では ",
        math(String.raw`\|A^0\|=\|I\|`),
        " であるから、いずれの場合も",
      ]),
      displayMath(String.raw`\|A^j\|\le\|I\|\,a^j \qquad (j\in\mathbb{Z}_{\ge 0})`),
      paragraph([
        math(String.raw`B`),
        " についても同様。よって ",
        ref("matrix_norm_submultiplicativity"),
        " と ",
        ref("matrix_norm_triangle_inequality"),
        " (2) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left\|\frac{1}{j!\,l!}A^jB^{l}\right\|
&= \frac{\|A^jB^l\|}{j!\,l!}
&&(\because\ \text{ノルムのスカラー倍についての等式と}\ 1/(j!\,l!)>0)\\
&\le \frac{\|A^j\|\,\|B^l\|}{j!\,l!}
&&(\because\ \text{行列ノルムの劣乗法性と}\ 1/(j!\,l!)>0)\\
&\le \|I\|^2\cdot\frac{a^j}{j!}\cdot\frac{b^l}{l!}
&&(\because\ \|A^j\|\le\|I\|\,a^j\ \text{と}\ \|B^l\|\le\|I\|\,b^l)
\end{aligned}`,
      ),
      paragraph([
        "Step 5: ",
        math(String.raw`\|S_NT_N-C_N\|\to 0`),
        "。まず添字集合を評価する。",
        math(String.raw`(j,l)\in Q_N\setminus D_N`),
        " とすると ",
        math(String.raw`j+l>N`),
        " であるから ",
        math(String.raw`2j>N`),
        " または ",
        math(String.raw`2l>N`),
        " である（もし ",
        math(String.raw`2j\le N`),
        " かつ ",
        math(String.raw`2l\le N`),
        " なら ",
        math(String.raw`j+l\le N`),
        " となり矛盾）。",
        math(String.raw`P_N\in\mathbb{Z}_{\ge 1}`),
        " を ",
        math(String.raw`P_N\ge (N+1)/2`),
        " を満たす最小の整数とすると、整数 ",
        math(String.raw`j`),
        " について ",
        math(String.raw`2j>N`),
        " は ",
        math(String.raw`2j\ge N+1`),
        " すなわち ",
        math(String.raw`j\ge P_N`),
        " と同値であるから",
      ]),
      displayMath(
        String.raw`Q_N\setminus D_N\subseteq
\left(\{P_N,\dots,N\}\times\{0,\dots,N\}\right)
\cup\left(\{0,\dots,N\}\times\{P_N,\dots,N\}\right)`,
      ),
      paragraph([
        "（",
        math(String.raw`P_N>N`),
        " のときは対応する部分は空集合とする。）",
        ref("matrix_norm_triangle_inequality"),
        " (3) を有限個の項に繰り返し用い、Step 4 の評価と、非負項を付け加えても和が増えるだけであることを使うと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|S_NT_N-C_N\|
&\le \sum_{(j,l)\in Q_N\setminus D_N}\left\|\frac{1}{j!\,l!}A^jB^{l}\right\|
&&(\because\ \text{三角不等式を有限個の項に繰り返し用いる})\\
&\le \|I\|^2\sum_{(j,l)\in Q_N\setminus D_N}\frac{a^j}{j!}\cdot\frac{b^l}{l!}
&&(\because\ \text{Step 4 を各項へ当てる})\\
&\le \|I\|^2\left(
\left(\sum_{j=P_N}^{N}\frac{a^j}{j!}\right)\left(\sum_{l=0}^{N}\frac{b^l}{l!}\right)
+\left(\sum_{j=0}^{N}\frac{a^j}{j!}\right)\left(\sum_{l=P_N}^{N}\frac{b^l}{l!}\right)
\right)
&&(\because\ \text{上の添字集合の包含と、非負項を付け加えても和は増えるだけであること})\\
&\le \|I\|^2\left(R_{P_N-1}(a)\,E(b)+E(a)\,R_{P_N-1}(b)\right)
&&(\because\ \text{非負実数の指数級数の収束の (2)(3)})
\end{aligned}`,
      ),
      paragraph([
        "最後の不等号で引いたのは ",
        ref("real_exp_series_converges"),
        " の (2)(3) である。",
        math(String.raw`P_N\ge (N+1)/2`),
        " より ",
        math(String.raw`P_N-1\to\infty`),
        " であり、",
        ref("real_exp_series_converges"),
        " (3) より ",
        math(String.raw`R_{P_N-1}(a)\to 0`),
        "、",
        math(String.raw`R_{P_N-1}(b)\to 0`),
        "。",
        math(String.raw`\|I\|^2,\ E(a),\ E(b)`),
        " は ",
        math(String.raw`N`),
        " によらない定数であるから ",
        math(String.raw`\|S_NT_N-C_N\|\to 0`),
        "。",
      ]),
      paragraph([
        "Step 6: ",
        math(String.raw`S_NT_N\to\exp(A)\exp(B)`),
        "。",
        ref("matrix_norm_triangle_inequality"),
        " (3)、",
        ref("matrix_norm_submultiplicativity"),
        "、および ",
        ref("matrix_exp_series_converges"),
        " (2) の評価 ",
        math(String.raw`\|S_N\|\le M_A`),
        "、",
        math(String.raw`\|\exp(B)\|\le M_B`),
        "（",
        math(String.raw`M_A=\|I\|+E(\|A\|)`),
        "、",
        math(String.raw`M_B=\|I\|+E(\|B\|)`),
        " は ",
        ref("matrix_exp_series_converges"),
        " (2) をそれぞれ ",
        math(String.raw`A`),
        "、",
        math(String.raw`B`),
        " に適用したもの）より、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left\|S_NT_N-\exp(A)\exp(B)\right\|
&\le \left\|S_NT_N-S_N\exp(B)\right\|+\left\|S_N\exp(B)-\exp(A)\exp(B)\right\|
&&(\because\ \text{三角不等式})\\
&= \left\|S_N\left(T_N-\exp(B)\right)\right\|+\left\|\left(S_N-\exp(A)\right)\exp(B)\right\|
&&(\because\ \text{積の分配律})\\
&\le \|S_N\|\cdot\left\|T_N-\exp(B)\right\|+\left\|S_N-\exp(A)\right\|\cdot\|\exp(B)\|
&&(\because\ \text{行列ノルムの劣乗法性を 2 つの項へ当てる})\\
&\le M_A\left\|T_N-\exp(B)\right\|+M_B\left\|S_N-\exp(A)\right\|
&&(\because\ \|S_N\|\le M_A\ \text{と}\ \|\exp(B)\|\le M_B)
\end{aligned}`,
      ),
      paragraph([
        ref("matrix_exp_series_converges"),
        " (1) より ",
        math(String.raw`\|S_N-\exp(A)\|\to 0`),
        "、",
        math(String.raw`\|T_N-\exp(B)\|\to 0`),
        " であるから右辺は ",
        math(String.raw`0`),
        " に収束する。",
      ]),
      paragraph([
        "Step 7: ",
        math(String.raw`C_N\to\exp(A+B)`),
        "。",
        ref("matrix_exp_series_converges"),
        " を行列 ",
        math(String.raw`A+B`),
        " に適用すれば、",
        math(String.raw`C_N`),
        " は ",
        math(String.raw`\exp(A+B)`),
        " の部分和列であるから ",
        math(String.raw`\|C_N-\exp(A+B)\|\to 0`),
        "。",
      ]),
      paragraph([
        "Step 8: 結論。",
        ref("matrix_norm_triangle_inequality"),
        " (3) より各 ",
        math(String.raw`N`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&\le\left\|\exp(A)\exp(B)-\exp(A+B)\right\|
&&(\because\ \text{ノルムは非負実数として定まる})\\
&\le\left\|\exp(A)\exp(B)-S_NT_N\right\|+\left\|S_NT_N-\exp(A+B)\right\|
&&(\because\ \text{三角不等式})\\
&\le\left\|\exp(A)\exp(B)-S_NT_N\right\|
+\left\|S_NT_N-C_N\right\|
+\left\|C_N-\exp(A+B)\right\|
&&(\because\ \text{第 2 項へもう一度三角不等式})
\end{aligned}`,
      ),
      paragraph([
        "右辺は Step 5・Step 6・Step 7 より ",
        math(String.raw`N\to\infty`),
        " で ",
        math(String.raw`0`),
        " に収束する（",
        math(String.raw`\|\exp(A)\exp(B)-S_NT_N\|=\|S_NT_N-\exp(A)\exp(B)\|`),
        " は ",
        ref("matrix_norm_triangle_inequality"),
        " (2) を ",
        math(String.raw`c=-1`),
        " に適用し ",
        math(String.raw`|-1|=1`),
        " を用いて得られる）。左辺は ",
        math(String.raw`N`),
        " によらない非負定数であるから ",
        math(String.raw`\left\|\exp(A)\exp(B)-\exp(A+B)\right\|=0`),
        " であり、",
        ref("matrix_norm_triangle_inequality"),
        " (1) より",
      ]),
      displayMath(String.raw`\exp(A)\exp(B)=\exp(A+B)`),
      paragraph([
        "なお、この証明で用いたのは行列の積・和の計算と ",
        ref("def_matrix_norm"),
        " のノルムに関する評価のみであり、微分は用いていない。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文の proof は証明の骨格（3 ステップの outline）と結語のみで、詳細計算は原文自体が省いていた。" +
          "ここでは原文の骨格（二項定理・部分和の比較・劣乗法性によるノルム評価）に沿って証明を完成させた。",
        "部分和の差の評価では、実数の指数関数の加法定理 e^a e^b = e^(a+b) を使わずに済むよう、" +
          "j+l>N かつ j,l<=N なら j または l が N/2 より大きいことを用いて剰余の積で抑える経路をとった" +
          "（labels: real_exp_series_converges の剰余評価のみで完結する）。",
        "2026-09-01 の式変形統一で、Step 1 の帰納法の初期値にあった一行三等号 " +
          "AI=A=IA を、単位行列を根拠とする二段の行末根拠つきの鎖へ開いた。" +
          "内容・式変形・根拠・ラベル参照は変えていない。",
      ],
    },
  },
  {
    id: "exp_linear_map_004_theorem_exp_zero_is_identity",
    kind: "theorem",
    origin: { path: "_old/typst/parts/003_線型写像のexp/003_theorem_零行列のexpはI.typ", ordinal: 4 },
    title: { tex: String.raw`\exp(O) = I` },
    labels: ["theorem_exp_zero"],
    statement: [
      paragraph(["行列指数は ", ref("def_exp"), "、成分積は ", ref("mat_mult"), "、実数係数の包含は ", ref("inclusion_rr_to_cc"), " による。実数級数の収束は ", ref("real_exp_series_converges"), " を引数1に適用する。"]),
      paragraph([math(String.raw`d \in \mathbb{Z}_{\ge 1}`), " とし、", math(String.raw`O,I \in \mathrm{Mat}(d,\mathbb{C})`), " とする。"]),
      paragraph([
        math(String.raw`O`),
        " を零行列、",
        math(String.raw`I`),
        " を単位行列とするとき、",
      ]),
      displayMath(String.raw`\exp(O) = I`),
    ],
    proof: [
      paragraph([
        "準備として、零行列の冪を書き下しておく。行列の冪の定義より ",
        math(String.raw`O^0 = I`),
        " であり、",
        math(String.raw`n \geq 1`),
        " のとき ",
        math(String.raw`O^n = O`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(O)
&= \sum_{n=0}^{\infty} \frac{O^n}{n!}
&&(\because\ \text{exp の定義（行列の場合と、行列への線型写像の場合）。}\blkref{def_exp})\\
&= \frac{O^0}{0!} + \sum_{n=1}^{\infty} \frac{O^n}{n!}
&&(\because\ \text{収束級数の第 0 項を分ける})\\
&= \frac{I}{0!} + \sum_{n=1}^{\infty} \frac{O^n}{n!}
&&(\because\ O^0 = I)\\
&= \frac{I}{0!} + \sum_{n=1}^{\infty} \frac{O}{n!}
&&(\because\ n \geq 1\ \text{のとき}\ O^n = O)\\
&= I + \sum_{n=1}^{\infty} \frac{O}{n!}
&&(\because\ 0! = 1)\\
&= I + O \cdot \sum_{n=1}^{\infty} \frac{1}{n!}
&&(\because\ \text{収束級数のスカラー倍は各項のスカラー倍の和である})\\
&= I + O
&&(\because\ \text{零行列のスカラー倍は零行列である})\\
&= I
&&(\because\ \text{零行列は行列の加法の単位元である})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-09-03 の式変形統一で、証明末尾の参照一覧を削除し、exp の定義を使う最初の等式行の行末へラベル参照を移した。内容・式変形・根拠は変えていない。",
      ],
    },
  },
  {
    id: "exp_linear_map_005_definition_one_by_one_matrix",
    kind: "definition",
    origin: { path: "structured-latex/content/003_exp_linear_map.ts", ordinal: 5 },
    title: { text: "数を成分とする 1 行 1 列の行列" },
    labels: ["def_one_by_one_matrix"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        " とする。",
        math(String.raw`x \in K`),
        " に対して、ただ 1 つの成分が ",
        math(String.raw`x`),
        " である 1 行 1 列の行列を",
      ]),
      displayMath(String.raw`[x]_K \in \mathrm{Mat}(1,K), \qquad \left([x]_K\right)_{11} := x`),
      paragraph([
        "と書く。これにより写像 ",
        math(String.raw`[\,\cdot\,]_K : K \to \mathrm{Mat}(1,K)`),
        " が定まる。",
        math(String.raw`\mathrm{Mat}(1,K)`),
        " の元 ",
        math(String.raw`A`),
        " は成分 ",
        math(String.raw`A_{11}`),
        " だけで決まるので、",
        math(String.raw`A = [A_{11}]_K`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "数の exp（labels: def_scalar_exp）を行列の exp（labels: def_exp）から定義するために置いた。数と 1 行 1 列の行列を同一視せず、行き来をこの写像と成分の取り出し A ↦ A_11 の 2 本に限る。",
      ],
    },
  },
  {
    id: "exp_linear_map_006_definition_scalar_exp",
    kind: "definition",
    origin: { path: "structured-latex/content/003_exp_linear_map.ts", ordinal: 6 },
    title: { text: "実数と複素数の exp" },
    labels: ["def_scalar_exp"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        " とし、",
        math(String.raw`x \in K`),
        " に対して",
      ]),
      displayMath(String.raw`\exp(x) := \bigl(\exp([x]_K)\bigr)_{11} \in K`),
      paragraph([
        "と定める。右辺の ",
        math(String.raw`\exp`),
        " は ",
        ref("def_exp"),
        " (1) の行列の exp を ",
        math(String.raw`n = 1`),
        " で ",
        ref("def_one_by_one_matrix"),
        " の ",
        math(String.raw`[x]_K`),
        " に適用したものであり、",
        math(String.raw`\exp([x]_K) \in \mathrm{Mat}(1,K)`),
        " だからその成分は ",
        math(String.raw`K`),
        " の元である。これにより写像 ",
        math(String.raw`\exp : \mathbb{R} \to \mathbb{R}`),
        " と ",
        math(String.raw`\exp : \mathbb{C} \to \mathbb{C}`),
        " が定まる。以後、",
        math(String.raw`\exp`),
        " の引数が実数ならば前者、複素数ならば後者、行列ならば ",
        ref("def_exp"),
        " の行列の exp を表す。実数 ",
        math(String.raw`x`),
        " に対する前者と、",
        math(String.raw`x_{\mathbb{C}}`),
        "（",
        ref("inclusion_rr_to_cc"),
        "）に対する後者の関係は ",
        ref("complex_exp_of_real_argument"),
        " で述べる。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "それまで本文は指数関数を e^x・e^{iθ} や定義のない exp(x) で書いていた。新しい極限の議論を持ち込まず、既に定義と収束が済んでいる行列の exp の 1 行 1 列の場合として定めた。級数で直接定義する経路は、負の引数や複素数の引数での収束と積公式を数について証明し直す必要があるため採らなかった。",
      ],
    },
  },
  {
    id: "exp_linear_map_007_claim_scalar_exp_is_limit_of_partial_sums",
    kind: "claim",
    origin: { path: "structured-latex/content/003_exp_linear_map.ts", ordinal: 7 },
    title: { text: "数の exp は指数級数の部分和の極限" },
    labels: ["scalar_exp_is_limit_of_partial_sums"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`x \in K`),
        " とする。",
        math(String.raw`N \to \infty`),
        " のとき",
      ]),
      displayMath(String.raw`\sum_{m=0}^{N}\frac{x^m}{m!} \to \exp(x)`),
      paragraph([
        "が ",
        math(String.raw`K`),
        " において成り立つ（",
        math(String.raw`x^0 := 1`),
        "、",
        math(String.raw`0! := 1`),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`[x]_K^{\,m} = [x^m]_K`),
        "）。",
        math(String.raw`m \in \mathbb{Z}_{\ge 0}`),
        " に関する帰納法で示す。",
        math(String.raw`m = 0`),
        " では ",
        math(String.raw`[x]_K^{\,0} = I = [1]_K = [x^0]_K`),
        "（1 行 1 列の単位行列の成分は 1）。",
        math(String.raw`m`),
        " で成り立つと仮定すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left([x]_K^{\,m+1}\right)_{11}
&= \left([x]_K^{\,m}[x]_K\right)_{11}
   \quad (\because \text{行列の冪の定義。}\blkref{def_exp}) \\
&= \sum_{j=1}^{1}\left([x]_K^{\,m}\right)_{1j}\left([x]_K\right)_{j1}
   \quad (\because \text{行列の積の成分。}\blkref{mat_mult}) \\
&= \left([x]_K^{\,m}\right)_{11}\left([x]_K\right)_{11}
   \quad (\because \text{和は } j=1 \text{ の 1 項だけ}) \\
&= \left([x^m]_K\right)_{11}\left([x]_K\right)_{11}
   \quad (\because \text{帰納法の仮定}) \\
&= x^m\,x
   \quad (\because \blkref{def_one_by_one_matrix}) \\
&= x^{m+1}
   \quad (\because \text{冪の定義})
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`[x]_K^{\,m+1} = [x^{m+1}]_K`),
        "（1 行 1 列の行列は成分だけで決まる。",
        ref("def_one_by_one_matrix"),
        "）。",
      ]),
      paragraph([
        "Step 2（部分和の成分）。",
        ref("matrix_exp_series_converges"),
        " の部分和 ",
        math(String.raw`S_N([x]_K) = \sum_{m=0}^{N}\frac{1}{m!}[x]_K^{\,m} \in \mathrm{Mat}(1,K)`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(S_N([x]_K)\right)_{11}
&= \sum_{m=0}^{N}\frac{1}{m!}\left([x]_K^{\,m}\right)_{11}
   \quad (\because \text{行列の和とスカラー倍は成分ごと}) \\
&= \sum_{m=0}^{N}\frac{1}{m!}\left([x^m]_K\right)_{11}
   \quad (\because \text{Step 1 を各項へ適用}) \\
&= \sum_{m=0}^{N}\frac{x^m}{m!}
   \quad (\because \blkref{def_one_by_one_matrix})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（極限）。",
        ref("exp_converges"),
        " (1b) を ",
        math(String.raw`n = 1`),
        "、",
        math(String.raw`A = [x]_K`),
        "、",
        math(String.raw`i = j = 1`),
        " に適用すると ",
        math(String.raw`\left(S_N([x]_K)\right)_{11} \to \left(\exp([x]_K)\right)_{11}`),
        " である（",
        math(String.raw`\sum_{m=0}^{\infty}\frac{1}{m!}[x]_K^{\,m} = \exp([x]_K)`),
        " は ",
        ref("def_exp"),
        " (1)）。左辺は Step 2 により ",
        math(String.raw`\sum_{m=0}^{N}\frac{x^m}{m!}`),
        "、右辺は ",
        ref("def_scalar_exp"),
        " により ",
        math(String.raw`\exp(x)`),
        " である。",
      ]),
    ],
    conversion: { status: "added", notes: ["数の exp を行列の exp から定義したことに伴い、指数級数との関係を主張として置いた。"] },
  },
  {
    id: "exp_linear_map_008_claim_scalar_exp_product",
    kind: "claim",
    origin: { path: "structured-latex/content/003_exp_linear_map.ts", ordinal: 8 },
    title: { tex: String.raw`\exp(x)\exp(y) = \exp(x+y)` },
    labels: ["scalar_exp_product"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`x, y \in K`),
        " について",
      ]),
      displayMath(String.raw`\exp(x)\exp(y) = \exp(x+y)`),
    ],
    proof: [
      paragraph([
        "準備。1 行 1 列の行列 ",
        math(String.raw`A, B \in \mathrm{Mat}(1,K)`),
        " について、",
        ref("mat_mult"),
        " の和は ",
        math(String.raw`j = 1`),
        " の 1 項だけなので ",
        math(String.raw`(AB)_{11} = A_{11}B_{11}`),
        " である。とくに ",
        math(String.raw`([x]_K[y]_K)_{11} = xy = yx = ([y]_K[x]_K)_{11}`),
        " より ",
        math(String.raw`[x]_K[y]_K = [y]_K[x]_K`),
        "。また行列の和は成分ごとなので ",
        math(String.raw`[x]_K + [y]_K = [x+y]_K`),
        "。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(x)\exp(y)
&= \bigl(\exp([x]_K)\bigr)_{11}\bigl(\exp([y]_K)\bigr)_{11}
   \quad (\because \blkref{def_scalar_exp}) \\
&= \bigl(\exp([x]_K)\exp([y]_K)\bigr)_{11}
   \quad (\because \text{準備の } (AB)_{11} = A_{11}B_{11}) \\
&= \bigl(\exp([x]_K+[y]_K)\bigr)_{11}
   \quad (\because [x]_K[y]_K = [y]_K[x]_K \text{ と可換行列の exp 積公式。}\blkref{theorem_exp_product}) \\
&= \bigl(\exp([x+y]_K)\bigr)_{11}
   \quad (\because [x]_K+[y]_K = [x+y]_K) \\
&= \exp(x+y)
   \quad (\because \blkref{def_scalar_exp})
\end{aligned}`,
      ),
    ],
    conversion: { status: "added", notes: ["数の exp を行列の exp から定義したことに伴い、指数法則を可換行列の exp 積公式から導いた。"] },
  },
  {
    id: "exp_linear_map_009_claim_scalar_exp_zero",
    kind: "claim",
    origin: { path: "structured-latex/content/003_exp_linear_map.ts", ordinal: 9 },
    title: { tex: String.raw`\exp(0) = 1` },
    labels: ["scalar_exp_zero"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        " とし、",
        math(String.raw`0, 1`),
        " を ",
        math(String.raw`K`),
        " の零元と単位元とするとき",
      ]),
      displayMath(String.raw`\exp(0) = 1`),
    ],
    proof: [
      paragraph([
        "すべての ",
        math(String.raw`N \in \mathbb{Z}_{\ge 0}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{m=0}^{N}\frac{0^m}{m!}
&= \frac{0^0}{0!} + \sum_{m=1}^{N}\frac{0^m}{m!}
   \quad (\because \text{第 0 項を分ける}) \\
&= \frac{1}{1} + \sum_{m=1}^{N}\frac{0}{m!}
   \quad (\because 0^0 = 1,\ 0! = 1,\ m \ge 1 \text{ で } 0^m = 0) \\
&= 1
   \quad (\because K \text{ の四則演算})
\end{aligned}`,
      ),
      paragraph([
        "であり、定数列の極限は 1 である。一方 ",
        ref("scalar_exp_is_limit_of_partial_sums"),
        " を ",
        math(String.raw`x = 0`),
        " に適用すると同じ列は ",
        math(String.raw`\exp(0)`),
        " に収束する。",
        math(String.raw`K`),
        " の列の極限の一意性より ",
        math(String.raw`\exp(0) = 1`),
        "。",
      ]),
    ],
    conversion: { status: "added", notes: ["数の exp を行列の exp から定義したことに伴い置いた。"] },
  },
  {
    id: "exp_linear_map_010_claim_real_exp_positive",
    kind: "claim",
    origin: { path: "structured-latex/content/003_exp_linear_map.ts", ordinal: 10 },
    title: { tex: String.raw`\exp(x) > 0` },
    labels: ["real_exp_positive"],
    statement: [
      paragraph([
        math(String.raw`x \in \mathbb{R}`),
        " について ",
        math(String.raw`\exp(x) > 0`),
        "。",
      ]),
    ],
    proof: [
      paragraph(["Step 1（0 でない）。"]),
      displayMath(
        String.raw`\begin{aligned}
\exp(x)\exp(-x)
&= \exp\bigl(x + (-x)\bigr)
   \quad (\because \blkref{scalar_exp_product}) \\
&= \exp(0)
   \quad (\because \text{加法の逆元}) \\
&= 1
   \quad (\because \blkref{scalar_exp_zero})
\end{aligned}`,
      ),
      paragraph([
        "もし ",
        math(String.raw`\exp(x) = 0`),
        " なら左辺は 0 となり矛盾するので、",
        math(String.raw`\exp(x) \neq 0`),
        "。",
      ]),
      paragraph(["Step 2（非負）。"]),
      displayMath(
        String.raw`\begin{aligned}
\exp(x)
&= \exp\!\left(\frac{x}{2} + \frac{x}{2}\right)
   \quad (\because \tfrac{x}{2} + \tfrac{x}{2} = x) \\
&= \exp\!\left(\frac{x}{2}\right)\exp\!\left(\frac{x}{2}\right)
   \quad (\because \blkref{scalar_exp_product}) \\
&= \left(\exp\!\left(\frac{x}{2}\right)\right)^2
   \quad (\because \text{冪の定義}) \\
&\ge 0
   \quad (\because \text{実数の平方は非負})
\end{aligned}`,
      ),
      paragraph([
        "Step 1 と Step 2 より ",
        math(String.raw`\exp(x) > 0`),
        "。",
      ]),
    ],
    conversion: { status: "added", notes: ["実数の exp を行列の exp から定義したことに伴い置いた。"] },
  },
  {
    id: "exp_linear_map_011_claim_real_exp_strictly_increasing",
    kind: "claim",
    origin: { path: "structured-latex/content/003_exp_linear_map.ts", ordinal: 11 },
    title: { text: "実数の exp は狭義単調増加" },
    labels: ["real_exp_strictly_increasing"],
    statement: [
      paragraph([
        math(String.raw`x, y \in \mathbb{R}`),
        " が ",
        math(String.raw`x < y`),
        " を満たすなら ",
        math(String.raw`\exp(x) < \exp(y)`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`a > 0`),
        " なら ",
        math(String.raw`\exp(a) > 1`),
        "）。",
        ref("real_exp_series_converges"),
        " の ",
        math(String.raw`E_N(a) = \sum_{m=0}^{N}\frac{a^m}{m!}`),
        " と ",
        math(String.raw`E(a) = \lim_{N\to\infty}E_N(a)`),
        " を使う。",
        ref("scalar_exp_is_limit_of_partial_sums"),
        " より同じ列 ",
        math(String.raw`E_N(a)`),
        " は ",
        math(String.raw`\exp(a)`),
        " に収束するので、実数列の極限の一意性より ",
        math(String.raw`E(a) = \exp(a)`),
        "。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(a)
&= E(a)
   \quad (\because \text{上の } E(a) = \exp(a)) \\
&\ge E_1(a)
   \quad (\because \blkref{real_exp_series_converges}\text{ (2)}) \\
&= 1 + a
   \quad (\because E_1(a) = \tfrac{a^0}{0!} + \tfrac{a^1}{1!}) \\
&> 1
   \quad (\because a > 0)
\end{aligned}`,
      ),
      paragraph(["Step 2。"]),
      displayMath(
        String.raw`\begin{aligned}
\exp(y)
&= \exp\bigl(x + (y-x)\bigr)
   \quad (\because x + (y - x) = y) \\
&= \exp(x)\exp(y-x)
   \quad (\because \blkref{scalar_exp_product}) \\
&> \exp(x)\cdot 1
   \quad (\because \exp(x) > 0\ \blkref{real_exp_positive}\text{ と、}y - x > 0\text{ への Step 1}) \\
&= \exp(x)
   \quad (\because 1 \text{ は乗法の単位元})
\end{aligned}`,
      ),
    ],
    conversion: { status: "added", notes: ["実数の exp を行列の exp から定義したことに伴い置いた。"] },
  },
  {
    id: "exp_linear_map_012_claim_complex_exp_of_real_argument",
    kind: "claim",
    origin: { path: "structured-latex/content/003_exp_linear_map.ts", ordinal: 12 },
    title: { text: "実数の exp と複素数の exp は実数上で一致する" },
    labels: ["complex_exp_of_real_argument"],
    statement: [
      paragraph([
        math(String.raw`x \in \mathbb{R}`),
        " について、",
        ref("inclusion_rr_to_cc"),
        " の記法で",
      ]),
      displayMath(String.raw`\exp\!\left(x_{\mathbb{C}}\right) = \left(\exp(x)\right)_{\mathbb{C}}`),
      paragraph([
        "が成り立つ。左辺は複素数の exp、右辺の内側は実数の exp である（",
        ref("def_scalar_exp"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        ref("definition_of_cc"),
        " の演算より、",
        math(String.raw`a, b \in \mathbb{R}`),
        " について ",
        math(String.raw`a_{\mathbb{C}} + b_{\mathbb{C}} = (a+b,0) = (a+b)_{\mathbb{C}}`),
        "、",
        math(String.raw`a_{\mathbb{C}}\,b_{\mathbb{C}} = (ab - 0\cdot 0,\ a\cdot 0 + 0\cdot b) = (ab)_{\mathbb{C}}`),
        " である。これを項ごとに使うと、すべての ",
        math(String.raw`N \in \mathbb{Z}_{\ge 0}`),
        " について",
      ]),
      displayMath(
        String.raw`\sum_{m=0}^{N}\frac{\left(x_{\mathbb{C}}\right)^m}{m!}
= \left(\sum_{m=0}^{N}\frac{x^m}{m!}\right)_{\mathbb{C}}
\quad (\because \text{上の和と積の保存を有限個の項へ適用})`,
      ),
      paragraph([
        "である。また ",
        math(String.raw`a, b \in \mathbb{R}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|a_{\mathbb{C}} - b_{\mathbb{C}}\right|
&= \left|(a-b)_{\mathbb{C}}\right|
   \quad (\because \text{上の和の保存と } (-1)_{\mathbb{C}}\,b_{\mathbb{C}} = (-b)_{\mathbb{C}}) \\
&= \sqrt{(a-b)^2+0^2}^{(\mathbb{R}_{\ge 0})}
   \quad (\because \blkref{abs_basic_properties}\text{ (1)}) \\
&= |a-b|
   \quad (\because \text{実数の平方の非負平方根は絶対値})
\end{aligned}`,
      ),
      paragraph([
        "なので、実数列 ",
        math(String.raw`E_N := \sum_{m=0}^{N}\frac{x^m}{m!}`),
        " が ",
        math(String.raw`\exp(x)`),
        " に収束すること（",
        ref("scalar_exp_is_limit_of_partial_sums"),
        " を ",
        math(String.raw`K = \mathbb{R}`),
        " で適用）から、",
        math(String.raw`(E_N)_{\mathbb{C}}`),
        " は ",
        math(String.raw`(\exp(x))_{\mathbb{C}}`),
        " に収束する。一方、上の等式より ",
        math(String.raw`(E_N)_{\mathbb{C}}`),
        " は ",
        math(String.raw`x_{\mathbb{C}}`),
        " の指数級数の部分和でもあるから、",
        ref("scalar_exp_is_limit_of_partial_sums"),
        " を ",
        math(String.raw`K = \mathbb{C}`),
        " で適用すると ",
        math(String.raw`\exp(x_{\mathbb{C}})`),
        " に収束する。",
        math(String.raw`\mathbb{C}`),
        " の列の極限の一意性より主張が従う。",
      ]),
    ],
    conversion: { status: "added", notes: ["実数の exp と複素数の exp を別々の写像として定義したので、両者の関係を主張として置いた。"] },
  },
  {
    id: "calc_formulae_definition_cosh_sinh",
    kind: "definition",
    origin: { path: "structured-latex/content/000_calculation_formulae_00_09.ts", ordinal: 1 },
    title: { text: "双曲線余弦と双曲線正弦" },
    labels: ["def_cosh_sinh"],
    statement: [
      paragraph([math(String.raw`x\in\mathbb R`), " に対して、", ref("def_scalar_exp"), " の実数の exp を使い"]),
      displayMath(String.raw`\cosh x:=\frac{\exp(x)+\exp(-x)}2,\qquad \sinh x:=\frac{\exp(x)-\exp(-x)}2`),
      paragraph(["と定める。"]),
    ],
    conversion: { status: "added", notes: ["双曲線関数の定義と、その性質を依存境界で分離した。", "定義のない実数値の指数関数を使っていたので、実数の exp（labels: def_scalar_exp）を引く形にし、計算公式の章から実数の exp の直後へ移した。"] },
  },
  {
    id: "calc_formulae_000_cosh_sinh_product",
    kind: "theorem",
    origin: { path: "_old/typst/parts/000_計算公式/000_theorem_cosh_sinhの掛け算.typ", ordinal: 1 },
    title: { tex: "\\cosh,\\sinh\\text{の掛け算}" },
    labels: [],
    statement: [
      paragraph([ref("def_cosh_sinh"), " の記号を用いる。"]),
      displayMath("\\forall a,b\\in\\mathbb{R}"),
      displayMath(String.raw`\begin{aligned}
\cosh(a)\sinh(b) &= \frac{1}{2}\left(\sinh(a+b)-\sinh(a-b)\right) \\
\cosh(a)\cosh(b) &= \frac{1}{2}\left(\cosh(a+b)+\cosh(a-b)\right)
\end{aligned}`),
    ],
    proof: [
      paragraph(["1 つめの等式。"]),
      displayMath(String.raw`\begin{aligned}
\cosh(a)\sinh(b)
&=
\frac{\exp(a)+\exp(-a)}{2}
\frac{\exp(b)-\exp(-b)}{2}
&&(\because\ \cosh,\ \sinh\ \text{の定義})
\\
&=
\frac{1}{4}
\left(
\left(\exp(a)\exp(b)-\exp(-a)\exp(-b)\right)
-
\left(\exp(a)\exp(-b)-\exp(-a)\exp(b)\right)
\right)
&&(\because\ \text{分配則})
\\
&=
\frac{1}{2}
\left(
\frac{\exp(a+b)-\exp(-(a+b))}{2}
-
\frac{\exp(a-b)-\exp(-(a-b))}{2}
\right)
&&(\because\ \exp(s)\exp(t)=\exp(s+t)\ \text{を 4 箇所へ。}\blkref{scalar_exp_product})
\\
&=
\frac{1}{2}
\left(
\sinh(a+b)-\sinh(a-b)
\right)
&&(\because\ \sinh\ \text{の定義})
\end{aligned}`),
      paragraph(["2 つめの等式。"]),
      displayMath(String.raw`\begin{aligned}
\cosh(a)\cosh(b)
&=
\frac{\exp(a)+\exp(-a)}{2}
\frac{\exp(b)+\exp(-b)}{2}
&&(\because\ \cosh\ \text{の定義})
\\
&=
\frac{1}{4}
\left(
\left(\exp(a)\exp(b)+\exp(-a)\exp(-b)\right)
+
\left(\exp(a)\exp(-b)+\exp(-a)\exp(b)\right)
\right)
&&(\because\ \text{分配則})
\\
&=
\frac{1}{2}
\left(
\frac{\exp(a+b)+\exp(-(a+b))}{2}
+
\frac{\exp(a-b)+\exp(-(a-b))}{2}
\right)
&&(\because\ \exp(s)\exp(t)=\exp(s+t)\ \text{を 4 箇所へ。}\blkref{scalar_exp_product})
\\
&=
\frac{1}{2}
\left(
\cosh(a+b)+\cosh(a-b)
\right)
&&(\because\ \cosh\ \text{の定義})
\end{aligned}`),
    ],
  },
  {
    id: "calc_formulae_000b_claim_cosh_sinh_basic_properties",
    kind: "claim",
    origin: { path: "structured-latex/content/000_calculation_formulae_00_09.ts", ordinal: 1 },
    title: { tex: String.raw`\cosh,\ \sinh\text{ の基本性質}` },
    labels: ["cosh_sinh_basic_properties"],
    statement: [
      paragraph([
        ref("def_cosh_sinh"), " の ", math(String.raw`x\in\mathbb R`), " における値について、次が成り立つ。",
      ]),
      list([
        [
          "(1) ",
          math(String.raw`\cosh x - \sinh x = \exp(-x) > 0`),
          " かつ ",
          math(String.raw`\cosh x + \sinh x = \exp(x) > 0`),
          "。特に ",
          math(String.raw`\cosh x > 0`),
          " かつ ",
          math(String.raw`\cosh x > \sinh x`),
          "。",
        ],
        ["(2) ", math(String.raw`(\cosh x)^2 - (\sinh x)^2 = 1`), "。"],
        [
          "(3) ",
          math(String.raw`x > 0`),
          " ならば ",
          math(String.raw`\cosh x > \sinh x > 0`),
          "。",
        ],
        [
          "(4) ",
          math(String.raw`a, b \in \mathbb{R}_{>0}`),
          " について ",
          math(String.raw`a^2 = b^2 \iff a = b`),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph(["(1) の証明。"]),
      displayMath(
        String.raw`\begin{aligned}
\cosh x - \sinh x
&= \frac{\exp(x) + \exp(-x)}{2} - \frac{\exp(x) - \exp(-x)}{2}
&&(\because\ \cosh,\ \sinh\ \text{の定義})\\
&= \frac{\bigl(\exp(x) + \exp(-x)\bigr) - \bigl(\exp(x) - \exp(-x)\bigr)}{2}
&&(\because\ \text{分母の等しい分数の差})\\
&= \frac{2\exp(-x)}{2}
&&(\because\ \text{分子の整理})\\
&= \exp(-x)
&&(\because\ \text{約分})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\cosh x + \sinh x
&= \frac{\exp(x) + \exp(-x)}{2} + \frac{\exp(x) - \exp(-x)}{2}
&&(\because\ \cosh,\ \sinh\ \text{の定義})\\
&= \frac{\bigl(\exp(x) + \exp(-x)\bigr) + \bigl(\exp(x) - \exp(-x)\bigr)}{2}
&&(\because\ \text{分母の等しい分数の和})\\
&= \frac{2\exp(x)}{2}
&&(\because\ \text{分子の整理})\\
&= \exp(x)
&&(\because\ \text{約分})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\cosh x - \sinh x
&= \exp(-x)
&&(\because\ \text{上の第 1 式})\\
&> 0
&&(\because\ \exp\ \text{の正値性。}\blkref{real_exp_positive})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\cosh x - \sinh x > 0
&\Longrightarrow \cosh x > \sinh x
&&(\because\ \text{両辺に}\ \sinh x\ \text{を加える})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
2\cosh x
&= (\cosh x - \sinh x) + (\cosh x + \sinh x)
&&(\because\ \text{右辺の整理})\\
&= \exp(-x) + \exp(x)
&&(\because\ \text{上の 2 式})\\
&> 0
&&(\because\ \exp\ \text{の正値性。}\blkref{real_exp_positive})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
2\cosh x > 0
&\Longrightarrow \cosh x > 0
&&(\because\ \text{両辺を}\ 2 > 0\ \text{で割る})
\end{aligned}`,
      ),
      paragraph(["(2) の証明。"]),
      displayMath(
        String.raw`\begin{aligned}
(\cosh x)^2 - (\sinh x)^2
&= (\cosh x - \sinh x)(\cosh x + \sinh x)
&&(\because\ \text{2 乗の差の因数分解})\\
&= \exp(-x)\exp(x)
&&(\because\ \text{(1) の 2 式})\\
&= \exp(-x + x)
&&(\because\ \blkref{scalar_exp_product})\\
&= \exp(0)
&&(\because\ -x + x = 0)\\
&= 1
&&(\because\ \blkref{scalar_exp_zero})
\end{aligned}`,
      ),
      paragraph(["(3) の証明。"]),
      displayMath(
        String.raw`\begin{aligned}
x>0
&\Longrightarrow -x<0
&&(\because\ \text{両辺に }-1<0\text{ を掛けると不等号の向きが反転する})\\
x>0
&\Longrightarrow 0<x
&&(\because\ \text{同じ不等式の左右を入れ替える})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\exp(-x)
&< \exp(0)
&&(\because\ -x < 0\ \text{と}\ \blkref{real_exp_strictly_increasing})\\
&= 1
&&(\because\ \blkref{scalar_exp_zero})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
1
&= \exp(0)
&&(\because\ \blkref{scalar_exp_zero})\\
&< \exp(x)
&&(\because\ 0 < x\ \text{と}\ \blkref{real_exp_strictly_increasing})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\exp(-x)<1<\exp(x)
&\Longrightarrow \exp(-x)<\exp(x)
&&(\because\ \mathbb R\text{ の順序の推移律})\\
&\Longrightarrow \exp(x)-\exp(-x)>0
&&(\because\ \text{両辺に }-\exp(-x)\text{ を加える})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sinh x
&= \frac{\exp(x) - \exp(-x)}{2}
&&(\because\ \sinh\ \text{の定義})\\
&> 0
&&(\because\ \text{正の実数を}\ 2 > 0\ \text{で割った値は正})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\cosh x>\sinh x\ \land\ \sinh x>0
&\Longrightarrow \cosh x>\sinh x>0
&&(\because\ \text{(1) と直前の不等式})
\end{aligned}`,
      ),
      paragraph([
        "(4) の証明。両方向を別々に示すので、ここは一続きの式にしない。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
a=b
&\Longrightarrow a^2=b^2
&&(\because\ \text{等しい実数を二乗しても等しい})
\end{aligned}`,
      ),
      paragraph([
        "逆に ",
        math(String.raw`a^2 = b^2`),
        " とする。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(a - b)(a + b)
&= a^2 - b^2
&&(\because\ \text{2 乗の差の因数分解})\\
&= 0
&&(\because\ a^2 = b^2)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
a>0\ \land\ b>0
&\Longrightarrow a+b>0
&&(\because\ \text{正の実数の和は正})\\
&\Longrightarrow a+b\ne0
&&(\because\ \text{正の実数は }0\text{ でない})\\
(a-b)(a+b)=0\ \land\ a+b\ne0
&\Longrightarrow a-b=0
&&(\because\ \mathbb R\text{ は整域})\\
&\Longrightarrow a=b
&&(\because\ \text{両辺に }b\text{ を加える})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。cosh, sinh の定義から直ちに従う基本性質" +
          "（cosh - sinh = e^{-x} > 0、cosh^2 - sinh^2 = 1、x>0 での正値性、正実数の自乗の単射性）は、" +
          "008_TV1_hatZ_hatY_part2 の γ_1 の偏角・臨界条件 c_1 = s_1 c_2 ⟺ s_1 s_2 = 1 の証明で必要になるが、" +
          "従来どのブロックにも主張として置かれていなかったため、cosh, sinh の積公式" +
          "（calc_formulae_000_cosh_sinh_product）の直後に追加した。",
        "計算公式の章から実数の exp の直後へ移し、前提として列挙していた指数関数の性質（積公式・exp(0)=1・正値性・狭義単調増加）を、実数の exp の主張への参照に置き換えた。",
      ],
    },
  },
]);
