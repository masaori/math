import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/009_eigenvalues_of_V.ts";

export default defineBlocks([
  {
    id: "heading_eigenvalues_of_V",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { text: "トレース・エルミート行列・正定値性" },
    labels: [],
  },

  {
    id: "eigenvalues_of_V_001_definition_trace",
    kind: "definition",
    origin: { path: SRC, ordinal: 3 },
    title: { tex: String.raw`\text{トレース } \mathrm{tr}` },
    labels: ["def_trace"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        math(String.raw`A = (A_{k l})_{1 \leq k, l \leq n} \in \mathrm{Mat}(n,\mathbb{C})`),
        " に対して",
      ]),
      displayMath(String.raw`\mathrm{tr}(A) := \sum_{k=1}^{n} A_{k k} \in \mathbb{C}`),
      paragraph([
        "と定める（対角成分の有限和なので、収束の議論を要しない）。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "eigenvalues_of_V_002_claim_trace_properties",
    kind: "claim",
    origin: { path: SRC, ordinal: 4 },
    title: { text: "トレースの基本性質" },
    labels: ["trace_basic_properties"],
    statement: [
      paragraph(["トレースと行列の積は ", ref("def_trace"), "、", ref("mat_mult"), " のものとする。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(n,\mathbb{C})`),
        "、",
        math(String.raw`\alpha, \beta \in \mathbb{C}`),
        " について、",
      ]),
      list([
        [math(String.raw`\text{(1)}\quad \mathrm{tr}(\alpha A + \beta B) = \alpha\,\mathrm{tr}(A) + \beta\,\mathrm{tr}(B)`), "（線型性）"],
        [math(String.raw`\text{(2)}\quad \mathrm{tr}(AB) = \mathrm{tr}(BA)`), "（巡回性）"],
        [math(String.raw`\text{(3)}\quad \mathrm{tr}(I_n) = n`)],
        [
          math(String.raw`\text{(4)}\quad P \in \mathrm{Mat}(n,\mathbb{C}) \text{ が可逆なら } \mathrm{tr}(P A P^{-1}) = \mathrm{tr}(A)`),
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(1) 行列の和とスカラー倍は成分ごとに定義されるので ",
        math(String.raw`(\alpha A + \beta B)_{kk} = \alpha A_{kk} + \beta B_{kk}`),
        " であり、有限和の線型性から従う。",
      ]),
      paragraph([
        "(2) 行列の積の定義 ",
        math(String.raw`(AB)_{kl} = \sum_{j=1}^{n} A_{kj}B_{jl}`),
        " より、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}(AB)
&= \sum_{k=1}^{n} (AB)_{kk}
&&(\because \text{トレースの定義}) \\
&= \sum_{k=1}^{n}\sum_{j=1}^{n} A_{kj}B_{jk}
&&(\because \text{積の定義}) \\
&= \sum_{j=1}^{n}\sum_{k=1}^{n} B_{jk}A_{kj}
&&(\because \text{有限和の順序交換と } \mathbb{C} \text{ の積の可換性}) \\
&= \sum_{j=1}^{n} (BA)_{jj}
&&(\because \text{積の定義}) \\
&= \mathrm{tr}(BA)
&&(\because \text{トレースの定義})
\end{aligned}`,
      ),
      paragraph([
        "有限個の項の和なので、順序交換は ",
        math(String.raw`\mathbb{C}`),
        " の加法の結合法則・交換法則からの有限帰納法で正当化される（収束の議論を要しない）。",
      ]),
      paragraph([
        "(3) ",
        math(String.raw`(I_n)_{kk} = 1`),
        " が ",
        math(String.raw`n`),
        " 個あるので ",
        math(String.raw`\mathrm{tr}(I_n) = n`),
        "。",
      ]),
      paragraph([
        "(4) (2) を ",
        math(String.raw`A \to PA`),
        "、",
        math(String.raw`B \to P^{-1}`),
        " に適用して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}(PAP^{-1})
&= \mathrm{tr}\bigl((PA)P^{-1}\bigr)
&&(\because \text{行列の積の結合法則}) \\
&= \mathrm{tr}\bigl(P^{-1}(PA)\bigr)
&&(\because \text{(2) 巡回性}) \\
&= \mathrm{tr}\bigl((P^{-1}P)A\bigr)
&&(\because \text{行列の積の結合法則}) \\
&= \mathrm{tr}(I_n A)
&&(\because \text{逆行列の定義 } P^{-1}P = I_n) \\
&= \mathrm{tr}(A)
&&(\because \text{単位行列との積})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "本文はこれまでトレースを定義せずに使っていなかった（008 章までに tr は現れない）。本章で初めて必要になるため、定義と必要な性質だけをここで書き下した。",
        "2026-08-31 の式変形統一で、二本の鎖に行中の \\quad(\\because …) で置かれていた根拠 10 行を、他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。内容・式変形・参照は変えていない。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_003_claim_trace_of_idempotent",
    kind: "claim",
    origin: { path: SRC, ordinal: 5 },
    title: { text: "冪等行列のトレースは像の次元" },
    labels: ["trace_of_idempotent"],
    statement: [
      paragraph(["トレースとその相似変換不変性、行列の積は ", ref("def_trace"), "、", ref("trace_basic_properties"), "、", ref("mat_mult"), " を使う。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`Q \in \mathrm{Mat}(n,\mathbb{C})`),
        " が ",
        math(String.raw`Q^2 = Q`),
        " を満たすとき、",
      ]),
      displayMath(String.raw`\mathbb{C}^n = \mathrm{im}\,Q \oplus \ker Q, \qquad
\mathrm{tr}(Q) = \dim_{\mathbb{C}} \mathrm{im}\,Q`),
      paragraph([
        "が成り立つ。ここで ",
        math(String.raw`\mathrm{im}\,Q := \{Qx \mid x \in \mathbb{C}^n\}`),
        "、",
        math(String.raw`\ker Q := \{x \in \mathbb{C}^n \mid Qx = 0\}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（直和分解）。任意の ",
        math(String.raw`x \in \mathbb{C}^n`),
        " について ",
        math(String.raw`x = Qx + (x - Qx)`),
        " と書け、",
        math(String.raw`Qx \in \mathrm{im}\,Q`),
        " である。",
        math(String.raw`x - Qx \in \ker Q`),
        " は次の計算による。",
      ]),
      displayMath(String.raw`\begin{aligned}
Q(x - Qx)
&= Qx - Q^2x
&&(\because\ \text{行列の積の分配則})\\
&= Qx - Qx
&&(\because\ Q^2 = Q)\\
&= 0
&&(\because\ \text{同じ項の差は零元（加法逆元）})
\end{aligned}`),
      paragraph([
        "よって ",
        math(String.raw`\mathbb{C}^n = \mathrm{im}\,Q + \ker Q`),
        "。また ",
        math(String.raw`y \in \mathrm{im}\,Q \cap \ker Q`),
        " とすると、",
        math(String.raw`y = Qx`),
        " なる ",
        math(String.raw`x \in \mathbb{C}^n`),
        " が取れて",
      ]),
      displayMath(String.raw`\begin{aligned}
y
&= Qx
&&(\because\ x\ \text{の取り方})\\
&= Q^2 x
&&(\because\ Q = Q^2)\\
&= Q(Qx)
&&(\because\ \text{行列の積の結合則})\\
&= Qy
&&(\because\ Qx = y)\\
&= 0
&&(\because\ y \in \ker Q)
\end{aligned}`),
      paragraph([
        "よって交わりは ",
        math(String.raw`\{0\}`),
        " であり、和は直和である。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`Q`),
        " の適合基底での形）。",
        math(String.raw`r := \dim_{\mathbb{C}}\mathrm{im}\,Q`),
        " とおき、",
        math(String.raw`\mathrm{im}\,Q`),
        " の基底 ",
        math(String.raw`v_1,\dots,v_r`),
        " と ",
        math(String.raw`\ker Q`),
        " の基底 ",
        math(String.raw`v_{r+1},\dots,v_n`),
        " を取る（Step 1 の直和分解より ",
        math(String.raw`v_1,\dots,v_n`),
        " は ",
        math(String.raw`\mathbb{C}^n`),
        " の基底）。",
        math(String.raw`j \leq r`),
        " のとき ",
        math(String.raw`v_j = Qx_j`),
        " なる ",
        math(String.raw`x_j \in \mathbb{C}^n`),
        " が取れて",
      ]),
      displayMath(String.raw`\begin{aligned}
Qv_j
&= Q(Qx_j)
&&(\because\ v_j = Qx_j)\\
&= Q^2x_j
&&(\because\ \text{行列の積の結合則})\\
&= Qx_j
&&(\because\ Q^2 = Q)\\
&= v_j
&&(\because\ v_j = Qx_j)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`j > r`),
        " のとき ",
        math(String.raw`Qv_j = 0`),
        "（",
        math(String.raw`v_j \in \ker Q`),
        "）。よってこの基底に関する ",
        math(String.raw`Q`),
        " の表現行列 ",
        math(String.raw`D`),
        " は対角行列で、対角成分は ",
        math(String.raw`1`),
        " が ",
        math(String.raw`r`),
        " 個、",
        math(String.raw`0`),
        " が ",
        math(String.raw`n - r`),
        " 個である。",
      ]),
      paragraph([
        "Step 3。基底変換行列を ",
        math(String.raw`P`),
        "（可逆）とすると ",
        math(String.raw`D = P^{-1} Q P`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}(Q)
&= \mathrm{tr}(P^{-1}QP)
&&(\because\ \text{トレースの基本性質 (4)：相似変換でトレースは不変。}\blkref{trace_basic_properties})\\
&= \mathrm{tr}(D)
&&(\because\ D = P^{-1}QP)\\
&= r
&&(\because\ D\ \text{の対角成分は}\ 1\ \text{が}\ r\ \text{個、}\ 0\ \text{が}\ n-r\ \text{個})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-08-17 の式変形統一で、Step 1 の二つの計算（x−Qx∈ker Q、交わりが零）、Step 2 の Qv_j=v_j、Step 3 のトレースの計算を、一続きの等号と行末の根拠へ揃えた。内容は変えていない。",
        "2026-09-02: Step 3 の鎖の直後に置いていた参照一覧を削り、相似変換でトレースが不変であることを使う行末の blkref へ移した。内容・式変形・根拠・参照は不変である。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_011_definition_hermitian_positive_definite",
    kind: "definition",
    origin: { path: SRC, ordinal: 13 },
    title: { text: "共役転置・エルミート行列・正定値行列" },
    labels: ["def_hermitian_positive_definite"],
    statement: [
      paragraph(["行列の積は ", ref("mat_mult"), "、実数の複素数への包含は ", ref("inclusion_rr_to_cc"), " を用いる。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A = (A_{kl}) \in \mathrm{Mat}(n,\mathbb{C})`),
        " に対し、共役転置を",
      ]),
      displayMath(String.raw`(A^*)_{kl} := \overline{A_{lk}}`),
      paragraph([
        "で定める（",
        math(String.raw`\overline{\phantom{z}}`),
        " は ",
        ref("def_complex_conjugate"),
        " の複素共役）。",
        math(String.raw`x = (x_1,\dots,x_n) \in \mathbb{C}^n`),
        " を ",
        math(String.raw`n\times 1`),
        " 行列とみなすと ",
        math(String.raw`x^* A x \in \mathbb{C}`),
        "（",
        math(String.raw`1\times 1`),
        " 行列を ",
        math(String.raw`\mathbb{C}`),
        " と同一視する）である。",
      ]),
      paragraph([
        math(String.raw`A`),
        " が ",
        math(String.raw`A^* = A`),
        " を満たすとき ",
        math(String.raw`A`),
        " は**エルミート**であるという。エルミートな ",
        math(String.raw`A`),
        " が さらに",
      ]),
      displayMath(
        String.raw`\forall x \in \mathbb{C}^n \setminus \{0\} : \quad x^* A x \in \mathbb{R}_{>0}`,
      ),
      paragraph([
        "を満たすとき ",
        math(String.raw`A`),
        " は**正定値**であるという。",
      ]),
      paragraph([
        "成分がすべて実数で ",
        math(String.raw`A^{\top} = A`),
        "（転置に関して対称）な行列は ",
        math(String.raw`\overline{A_{lk}} = A_{lk} = A_{kl}`),
        " よりエルミートである。以下ではこれを**実対称**と呼ぶ。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "eigenvalues_of_V_012_claim_star_is_norm_preserving",
    kind: "claim",
    origin: { path: SRC, ordinal: 14 },
    title: { tex: String.raw`\|A^*\| = \|A\| \text{ と極限の共役転置}` },
    labels: ["star_preserves_norm_and_limits"],
    statement: [
      paragraph(["共役転置は ", ref("def_hermitian_positive_definite"), "、複素共役は ", ref("def_complex_conjugate"), "、行列積は ", ref("mat_mult"), "、複素数の積の可換性は ", ref("complex_numbers_form_a_field"), " を用いる。共役の和・積保存は ", ref("frobenius_inner_product_axioms"), " の証明冒頭の成分計算による。絶対値の成分表示は ", ref("abs_basic_properties"), " による。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(n,\mathbb{C})`),
        "、", math(String.raw`\alpha,\beta\in\mathbb C`), " および ", math(String.raw`(A_N)_{N\in\mathbb Z_{\ge0}}`), " を同じ行列空間の列とする。このとき、",
      ]),
      list([
        [math(String.raw`\text{(1)}\quad (AB)^* = B^* A^*, \qquad (\alpha A + \beta B)^* = \overline{\alpha}A^* + \overline{\beta}B^*`)],
        [
          math(String.raw`\text{(2)}\quad \|A^*\| = \|A\|`),
          "（ノルムは ",
          ref("def_matrix_norm"),
          " のもの）",
        ],
        [
          math(String.raw`\text{(3)}\quad A_N \to A \ \Longrightarrow\ A_N^* \to A^*`),
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(1) 成分計算による。任意の成分 ",
        math(String.raw`(k,l)`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
((AB)^*)_{kl}
&= \overline{(AB)_{lk}}
   \quad (\because \text{共役転置の定義}) \\
&= \overline{\textstyle\sum_j A_{lj}B_{jk}}
   \quad (\because \text{行列積の定義}) \\
&= \textstyle\sum_j \overline{A_{lj}B_{jk}}
   \quad (\because \text{複素共役は和を保つ、}\blkref{frobenius_inner_product_axioms}\text{ の証明冒頭}) \\
&= \textstyle\sum_j \overline{A_{lj}}\,\overline{B_{jk}}
   \quad (\because \text{複素共役は積を保つ、}\blkref{frobenius_inner_product_axioms}\text{ の証明冒頭}) \\
&= \textstyle\sum_j \overline{B_{jk}}\,\overline{A_{lj}}
   \quad (\because \mathbb{C}\text{ の積の可換性}) \\
&= \textstyle\sum_j (B^*)_{kj}(A^*)_{jl}
   \quad (\because \text{共役転置の定義}) \\
&= (B^*A^*)_{kl}
   \quad (\because \text{行列積の定義})
\end{aligned}`,
      ),
      paragraph([
        "第 2 式も同様。",
      ]),
      paragraph([
        "(2) 任意の ",
        math(String.raw`A\in\mathrm{Mat}(n,\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|A^*\|
&= \sqrt{\textstyle\sum_{k,l}|(A^*)_{kl}|^2}
   \quad (\because \text{行列ノルムの定義、}\blkref{def_matrix_norm}) \\
&= \sqrt{\textstyle\sum_{k,l}|\overline{A_{lk}}|^2}
   \quad (\because \text{共役転置の定義}) \\
&= \sqrt{\textstyle\sum_{k,l}|A_{lk}|^2}
   \quad (\because \text{共役の成分定義と絶対値の成分表示より（この代入の展開は未記載）、}\blkref{def_complex_conjugate},\blkref{abs_basic_properties}) \\
&= \sqrt{\textstyle\sum_{k,l}|A_{kl}|^2}
   \quad (\because (k,l)\mapsto(l,k)\text{ は添字集合の全単射}) \\
&= \|A\|
   \quad (\because \text{行列ノルムの定義、}\blkref{def_matrix_norm})
\end{aligned}`,
      ),
      paragraph([
        "(3) ",
        math(String.raw`A_N\to A`),
        " と仮定する。このとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|A_N^*-A^*\|
&= \|(A_N-A)^*\|
   \quad (\because \text{(1) の共役転置の線型性}) \\
&= \|A_N-A\|
   \quad (\because \text{(2)}) \\
&\longrightarrow 0
   \quad (\because A_N\to A\ \text{の仮定})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-05 の式変形統一で、複素共役が和・積・絶対値を保つことと行列ノルムの定義への後置き参照を、実際に適用する各等号の行末へ移した。内容・式変形・根拠・参照は変えていない。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_013_claim_exp_hermitian_positive_definite",
    kind: "claim",
    origin: { path: SRC, ordinal: 15 },
    title: { tex: String.raw`\text{エルミート行列の } \exp \text{ は正定値}` },
    labels: ["exp_hermitian_is_positive_definite"],
    statement: [
      paragraph(["指数は ", ref("def_exp"), "、指数の積と零での値は ", ref("theorem_exp_product"), " と ", ref("theorem_exp_zero"), "、共役転置と正定値性は ", ref("def_hermitian_positive_definite"), "、行列積は ", ref("mat_mult"), " による。成分の共役と積は ", ref("def_complex_conjugate"), "、", ref("frobenius_inner_product_axioms"), " の証明冒頭、", ref("complex_numbers_form_a_field"), "、絶対値の零との同値は ", ref("abs_basic_properties"), "、ノルムは ", ref("def_matrix_norm"), "、実数の包含は ", ref("inclusion_rr_to_cc"), "、トレースは ", ref("def_trace"), " を用いる。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " とする。",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad S \in \mathrm{Mat}(n,\mathbb{C}) \text{ がエルミートなら } \exp(S) \text{ はエルミートかつ正定値}`),
        ],
        [
          math(String.raw`\text{(2)}\quad A \text{ が正定値、} B \text{ が可逆なら } B^* A B \text{ は正定値}`),
        ],
        [
          math(String.raw`\text{(3)}\quad A \text{ が正定値、} \alpha \in \mathbb{R}_{>0} \text{ なら } \alpha A \text{ は正定値}`),
        ],
        [math(String.raw`\text{(4)}\quad A \text{ が正定値なら } \mathrm{tr}(A) \in \mathbb{R}_{>0}`)],
      ]),
    ],
    proof: [
      paragraph([
        "(1) まずエルミート性。部分和を ",
        math(String.raw`E_K := \sum_{k=0}^{K}\frac{1}{k!}S^k`),
        " と置く。任意の ",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(S^k)^*
&= (S^*)^k
   \quad (\because \text{積の共役転置を } k \text{ 回繰り返す、}\blkref{star_preserves_norm_and_limits}) \\
&= S^k
   \quad (\because S \text{ はエルミート、すなわち } S^* = S)
\end{aligned}`,
      ),
      paragraph(["したがって、"]),
      displayMath(
        String.raw`\begin{aligned}
E_K^*
&= \Bigl(\textstyle\sum_{k=0}^{K}\frac{1}{k!}S^k\Bigr)^*
   \quad (\because E_K \text{ の定義}) \\
&= \textstyle\sum_{k=0}^{K}\overline{\left(\frac{1}{k!}\right)}\,(S^k)^*
   \quad (\because \text{共役転置の線型性を和の各項へ適用、}\blkref{star_preserves_norm_and_limits}) \\
&= \textstyle\sum_{k=0}^{K}\frac{1}{k!}\,(S^k)^*
   \quad (\because 1/k! \in \mathbb{R} \text{ なので } \overline{1/k!} = 1/k!) \\
&= \textstyle\sum_{k=0}^{K}\frac{1}{k!}\,S^k
   \quad (\because \text{上で得た } (S^k)^* = S^k) \\
&= E_K
   \quad (\because E_K \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        ref("exp_converges"),
        " より ",
        math(String.raw`E_K \to \exp(S)`),
        " であり、",
        ref("star_preserves_norm_and_limits"),
        " (3) より ",
        math(String.raw`E_K^* \to \exp(S)^*`),
        "。上の等式 ",
        math(String.raw`E_K^* = E_K`),
        " より、同じ点列 ",
        math(String.raw`E_K`),
        " が ",
        math(String.raw`\exp(S)^*`),
        " と ",
        math(String.raw`\exp(S)`),
        " の両方へ収束するから、",
        ref("matrix_norm_triangle_inequality"),
        " (4)（極限の一意性）より ",
        math(String.raw`\exp(S)^* = \exp(S)`),
        "。",
      ]),
      paragraph([
        "次に正定値性。",
        math(String.raw`S/2`),
        " もエルミートなので、いま示したことから ",
        math(String.raw`\exp(S/2)^* = \exp(S/2)`),
        "。また ",
        math(String.raw`S/2`),
        " は自分自身と可換なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(S/2)\exp(S/2)
&= \exp(S/2 + S/2)
   \quad (\because \text{可換な行列の指数の積、}\blkref{theorem_exp_product}) \\
&= \exp(S)
   \quad (\because S/2 + S/2 = S)
\end{aligned}`,
      ),
      paragraph(["さらに、"]),
      displayMath(
        String.raw`\begin{aligned}
\exp(S/2)\exp(-S/2)
&= \exp\bigl(S/2 + (-S/2)\bigr)
   \quad (\because \text{可換な行列の指数の積}) \\
&= \exp(0)
   \quad (\because S/2 + (-S/2) = 0) \\
&= I
   \quad (\because \text{零行列の指数、}\blkref{theorem_exp_zero})
\end{aligned}`,
      ),
      paragraph([
        "従って、",
        math(String.raw`\exp(S/2)`),
        " は可逆である。よって ",
        math(String.raw`x \in \mathbb{C}^n\setminus\{0\}`),
        " に対し ",
        math(String.raw`w := \exp(S/2)x \neq 0`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^*\exp(S)x
&= x^*\bigl(\exp(S/2)\exp(S/2)\bigr)x
   \quad (\because \text{上で得た } \exp(S/2)\exp(S/2) = \exp(S)) \\
&= x^*\exp(S/2)^*\exp(S/2)x
   \quad (\because \text{上で示した } \exp(S/2)^* = \exp(S/2)) \\
&= \left(\exp(S/2)x\right)^*\left(\exp(S/2)x\right)
   \quad (\because \text{積の共役転置を } n \times 1 \text{ 行列 } x \text{ へ適用、}\blkref{star_preserves_norm_and_limits}) \\
&= w^* w
   \quad (\because w \text{ の定義}) \\
&= \textstyle\sum_{k=1}^{n}\overline{w_k}\,w_k
   \quad (\because \text{行列積の定義（} 1 \times 1 \text{ 成分）}) \\
&= \textstyle\sum_{k=1}^{n}|w_k|^2
   \quad (\because \overline{z}\,z = |z|^2) \\
&= \|w\|^2
   \quad (\because \text{ベクトルノルムの定義})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`w \neq 0`),
        " なのでどれかの ",
        math(String.raw`w_k \neq 0`),
        " であり、非負項の和が正の項を含むから ",
        math(String.raw`\|w\|^2 > 0`),
        "。よって ",
        math(String.raw`x^*\exp(S)x > 0`),
        " である。",
      ]),
      paragraph([
        "(2) 共役転置について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(B^*AB)^*
&= B^*A^*B^{**}
   \quad (\because \text{積の共役転置、}\blkref{star_preserves_norm_and_limits}) \\
&= B^*A^*B
   \quad (\because B^{**}=B) \\
&= B^*AB
   \quad (\because A^*=A)
\end{aligned}`,
      ),
      paragraph([
        "従って、エルミートである。",
        math(String.raw`x \neq 0`),
        " なら ",
        math(String.raw`B`),
        " が可逆なので ",
        math(String.raw`Bx \neq 0`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^*(B^*AB)x
&= (Bx)^*A(Bx)
   \quad (\because \text{積の共役転置、}\blkref{star_preserves_norm_and_limits}) \\
&>0
   \quad (\because A\ \text{は正定値かつ}\ Bx\ne0)
\end{aligned}`,
      ),
      paragraph([
        "(3) ",
        math(String.raw`\alpha\in\mathbb{R}_{>0}`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\alpha A)^*
&= \overline{\alpha}A^*
   \quad (\because \text{共役転置の線型性}) \\
&= \alpha A^*
   \quad (\because \alpha\in\mathbb{R}) \\
&= \alpha A
   \quad (\because A^*=A)
\end{aligned}`,
      ),
      paragraph(["よりエルミートである。また ", math(String.raw`x\ne0`), " ならば"]),
      displayMath(
        String.raw`\begin{aligned}
x^*(\alpha A)x
&= \alpha(x^*Ax)
   \quad (\because \text{スカラー倍と行列積の結合則}) \\
&>0
   \quad (\because \alpha>0\ \text{かつ}\ x^*Ax>0)
\end{aligned}`,
      ),
      paragraph([
        "(4) ",
        math(String.raw`e_k \in \mathbb{C}^n`),
        " を第 ",
        math(String.raw`k`),
        " 標準基底ベクトルとする。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A_{kk}
&= e_k^*Ae_k
   \quad (\because \text{標準基底ベクトルによる対角成分の表示}) \\
&>0
   \quad (\because A\ \text{は正定値かつ}\ e_k\ne0)
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}(A)
&= \sum_{k=1}^{n}A_{kk}
   \quad (\because \text{トレースの定義}) \\
&>0
   \quad (\because n\ge1\ \text{かつ各}\ A_{kk}>0)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`A`),
        " はエルミートなので各 ",
        math(String.raw`A_{kk}`),
        " は実数であり、よって ",
        math(String.raw`\mathrm{tr}(A)\in\mathbb{R}_{>0}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-05 の式変形統一で、共役転置・可換な行列指数の積・零行列の指数への後置き参照を、実際に適用する各等号の行末へ移した。内容・式変形・根拠・参照は変えていない。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_014_claim_iH_is_real_symmetric",
    kind: "claim",
    origin: { path: SRC, ordinal: 16 },
    title: { tex: String.raw`i K_1 H_1^{(+)} \text{ と } i K_2^* H_2 \text{ は実対称}` },
    labels: ["iH_is_real_symmetric"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもとで、",
      ]),
      displayMath(
        String.raw`S_1^{(+)} := i K_1 H_1^{(+)}, \qquad S_2 := i K_2^* H_2`,
      ),
      paragraph(["とおくと、"]),
      displayMath(
        String.raw`\begin{aligned}
S_1^{(+)} &= K_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z\right)
  - K_1\, G, \qquad
G := \sigma_1^y\,\sigma_2^x \sigma_3^x \cdots \sigma_{M_{\mathrm{col}}-1}^x\, \sigma_{M_{\mathrm{col}}}^y \\
S_2 &= K_2^*\left(\sigma_1^x + \sigma_2^x + \cdots + \sigma_{M_{\mathrm{col}}}^x\right)
\end{aligned}`,
      ),
      paragraph([
        "であり（",
        math(String.raw`M_{\mathrm{col}} = 2`),
        " のとき ",
        math(String.raw`G = \sigma_1^y\sigma_2^y`),
        " と読む）、",
        math(String.raw`S_1^{(+)}`),
        " と ",
        math(String.raw`S_2`),
        " はいずれも成分がすべて実数で、転置について対称である。とくに ",
        ref("def_hermitian_positive_definite"),
        " の意味でエルミートである。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 0（用いる ",
        math(String.raw`2\times 2`),
        " の積）。Pauli 行列の行列表示から直接成分計算して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^z\sigma^y
&= \begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
   \quad (\because \text{Pauli 行列の行列表示},\ \blkref{pauli_matrix_products}) \\
&= \begin{pmatrix}0&-i\\-i&0\end{pmatrix}
   \quad (\because \text{行列積の成分計算}) \\
&= -i\,\sigma^x
   \quad (\because \sigma^x \text{ の行列表示})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^y\sigma^x
&= \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix}
   \quad (\because \text{Pauli 行列の行列表示},\ \blkref{pauli_matrix_products}) \\
&= \begin{pmatrix}-i&0\\0&i\end{pmatrix}
   \quad (\because \text{行列積の成分計算}) \\
&= -i\,\sigma^z
   \quad (\because \sigma^z \text{ の行列表示})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^x\sigma^z
&= \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}1&0\\0&-1\end{pmatrix}
   \quad (\because \text{Pauli 行列の行列表示},\ \blkref{pauli_matrix_products}) \\
&= \begin{pmatrix}0&-1\\1&0\end{pmatrix}
   \quad (\because \text{行列積の成分計算}) \\
&= -i\,\sigma^y
   \quad (\because \sigma^y \text{ の行列表示})
\end{aligned}`,
      ),
      paragraph([
        "また ",
        ref("pauli_matrix_products"),
        " より ",
        math(String.raw`\sigma^x\sigma^x = I`),
        "、相異なるサイトに置かれた ",
        math(String.raw`\sigma_j^a`),
        " と ",
        math(String.raw`\sigma_k^b`),
        "（",
        math(String.raw`j \neq k`),
        "）は可換である（",
        ref("kronecker_product_rule"),
        " (1) より、クロネッカー積どうしの積は各サイトごとの ",
        math(String.raw`2`),
        " 次の行列の積になり、各サイトでは一方が ",
        math(String.raw`I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " だから）。",
      ]),
      paragraph([
        "Step 1（",
        math(String.raw`S_2`),
        " の形）。",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`Z_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^z`),
        "、",
        math(String.raw`Y_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^y`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_m Y_m
&= \left(\sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^z\right)
   \left(\sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^y\right)
   \quad (\because Z_m,\ Y_m \text{ の定義}) \\
&= \left(\sigma_1^x\cdots\sigma_{m-1}^x\right)\left(\sigma_1^x\cdots\sigma_{m-1}^x\right)
   \sigma_m^z\sigma_m^y
   \quad (\because \sigma_m^z \text{ は } \sigma_j^x\ (j<m) \text{ と可換}) \\
&= \sigma_m^z\sigma_m^y
   \quad (\because \sigma_j^x\sigma_j^x = I) \\
&= -i\,\sigma_m^x
   \quad (\because \text{Step 0})
\end{aligned}`,
      ),
      paragraph(["よって"]),
      displayMath(
        String.raw`\begin{aligned}
H_2
&= \sum_{m=1}^{M_{\mathrm{col}}} Z_mY_m
   \quad (\because\ \blkref{def_H2}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}} (-i\,\sigma_m^x)
   \quad (\because \text{上で得た } Z_mY_m = -i\,\sigma_m^x) \\
&= -i\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x
   \quad (\because \text{スカラー倍の和の分配})
\end{aligned}`,
      ),
      paragraph(["であり、"]),
      displayMath(
        String.raw`\begin{aligned}
S_2
&= iK_2^*H_2
   \quad (\because S_2 \text{ の定義}) \\
&= iK_2^*\left(-i\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x\right)
   \quad (\because \text{上で得た } H_2 \text{ の表示}) \\
&= i(-i)\,K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x
   \quad (\because \text{スカラー倍の交換}) \\
&= K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x
   \quad (\because i\cdot(-i) = 1)
\end{aligned}`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`S_1^{(+)}`),
        " の形）。",
        math(String.raw`1 \leq m \leq M_{\mathrm{col}}-1`),
        " に対して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_m Z_{m+1}
&= \left(\sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^y\right)
   \left(\sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^x\,\sigma_{m+1}^z\right)
   \quad (\because Y_m,\ Z_{m+1} \text{ の定義}) \\
&= \left(\sigma_1^x\cdots\sigma_{m-1}^x\right)^2\,
   \sigma_m^y\sigma_m^x\,\sigma_{m+1}^z
   \quad (\because \text{相異なる因子どうしは可換}) \\
&= \sigma_m^y\sigma_m^x\,\sigma_{m+1}^z
   \quad (\because \sigma_j^x\sigma_j^x = I) \\
&= -i\,\sigma_m^z\sigma_{m+1}^z
   \quad (\because \text{Step 0})
\end{aligned}`,
      ),
      paragraph(["また境界項について"]),
      displayMath(
        String.raw`\begin{aligned}
Y_{M_{\mathrm{col}}} Z_1
&= \left(\sigma_1^x\sigma_2^x\cdots\sigma_{M_{\mathrm{col}}-1}^x\,\sigma_{M_{\mathrm{col}}}^y\right)\sigma_1^z
   \quad (\because Y_{M_{\mathrm{col}}},\ Z_1 \text{ の定義}) \\
&= \left(\sigma_1^x\sigma_1^z\right)\sigma_2^x\cdots\sigma_{M_{\mathrm{col}}-1}^x\,\sigma_{M_{\mathrm{col}}}^y
   \quad (\because \sigma_1^z \text{ は他の因子と可換}) \\
&= -i\,\sigma_1^y\,\sigma_2^x\cdots\sigma_{M_{\mathrm{col}}-1}^x\,\sigma_{M_{\mathrm{col}}}^y
   \quad (\because \text{Step 0}) \\
&= -i\,G
   \quad (\because G \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "これらと ",
        ref("def_H1_plus"),
        " の ",
        math(String.raw`H_1^{(+)}`),
        " の定義を使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
S_1^{(+)}
&= iK_1H_1^{(+)}
   \quad (\because S_1^{(+)} \text{ の定義}) \\
&= iK_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1} Y_mZ_{m+1} - Y_{M_{\mathrm{col}}}Z_1\right)
   \quad (\because H_1^{(+)} \text{ の定義}) \\
&= iK_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1}\left(-i\,\sigma_m^z\sigma_{m+1}^z\right) - (-i\,G)\right)
   \quad (\because \text{上で得た } Y_mZ_{m+1},\ Y_{M_{\mathrm{col}}}Z_1 \text{ の表示}) \\
&= i(-i)\,K_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z - G\right)
   \quad (\because \text{スカラー倍の和の分配と交換}) \\
&= K_1\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z - K_1\,G
   \quad (\because i\cdot(-i) = 1 \text{ と分配則})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（実対称性）。",
        math(String.raw`\sigma^x = \begin{pmatrix}0&1\\1&0\end{pmatrix}`),
        " と ",
        math(String.raw`\sigma^z = \begin{pmatrix}1&0\\0&-1\end{pmatrix}`),
        " は成分が実で対称、",
        math(String.raw`\sigma^y = \begin{pmatrix}0&-i\\i&0\end{pmatrix}`),
        " は成分が純虚数で交代（",
        math(String.raw`(\sigma^y)^\top = -\sigma^y`),
        "）である。クロネッカー積（",
        ref("def_kronecker"),
        "）の成分は各因子の成分の積であり、転置は因子ごとの転置になる（",
        ref("kronecker_transpose"),
        "）：",
      ]),
      displayMath(
        String.raw`\left(A_1\boxtimes\cdots\boxtimes A_{M_{\mathrm{col}}}\right)^\top
= A_1^\top\boxtimes\cdots\boxtimes A_{M_{\mathrm{col}}}^\top
\quad (\because \text{クロネッカー積の転置})`,
      ),
      paragraph([
        "したがって、",
      ]),
      list([
        [
          math(String.raw`\sigma_m^x`),
          "：",
          math(String.raw`\sigma^x`),
          " が 1 個、他は ",
          math(String.raw`I`),
          "。成分は実、転置で不変。",
        ],
        [
          math(String.raw`\sigma_m^z\sigma_{m+1}^z`),
          "：",
          math(String.raw`\sigma^z`),
          " が 2 個、他は ",
          math(String.raw`I`),
          "。成分は実、転置で不変。",
        ],
        [
          math(String.raw`G`),
          "：",
          math(String.raw`\sigma^y`),
          " が **2 個**（第 1 因子と第 ",
          math(String.raw`M_{\mathrm{col}}`),
          " 因子）、残りは ",
          math(String.raw`\sigma^x`),
          "。純虚数成分の因子がちょうど 2 個なので、成分の積に現れる虚数単位は ",
          math(String.raw`i^2 = -1`),
          " の形でまとまり、成分はすべて実数。転置は ",
          math(String.raw`(-1)^2 = 1`),
          " 倍なので ",
          math(String.raw`G^\top = G`),
          "。",
        ],
      ]),
      paragraph([
        math(String.raw`K_1, K_2^* \in \mathbb{R}`),
        " なので、これらの実係数の有限和である ",
        math(String.raw`S_1^{(+)}`),
        "、",
        math(String.raw`S_2`),
        " は成分がすべて実数で転置について対称、すなわち実対称である。",
        ref("def_hermitian_positive_definite"),
        " の最後の注意より、実対称行列はエルミートである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "iK_1H_1^{(±)} と iK_2^*H_2 が厳密に実対称（成分が実かつ転置不変）であることは、M=2,3,4,5 と両符号について数値的にも残差 0 で確認した（sagemath/check/042_claim_constant_c_and_eigenvalues_of_V/check_01_real_symmetric.sage）。",
        "2026-08-15 の式変形統一で、Step 1 の Z_mY_m の鎖と Step 2 の Y_mZ_{m+1} の鎖の先頭行（定義の適用）に欠けていた行末根拠を補った。内容は変えていない。",
        "2026-09-05 の式変形統一で、Step 0 の三つの Pauli 行列積について、段落に置かれていた参照を実際に行列表示を使う各等号の行末へ移した。内容と計算順序は変えていない。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_016_claim_sign_flip_conjugation",
    kind: "claim",
    origin: { path: SRC, ordinal: 18 },
    title: { tex: String.raw`\text{符号反転共役 } U` },
    labels: ["sign_flip_conjugation"],
    statement: [
      paragraph([math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`), " とし、"]),
      displayMath(
        String.raw`E := \prod_{\substack{1 \leq m \leq M_{\mathrm{col}} \\ m\ \text{奇数}}} \sigma_m^x, \qquad
F := \prod_{m=1}^{M_{\mathrm{col}}} \sigma_m^z, \qquad
U := E F \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph([
        "とおく（積の因子は相異なるサイトに置かれた ",
        math(String.raw`2`),
        " 次の行列のクロネッカー積なので、",
        ref("kronecker_product_rule"),
        " (1) より互いに可換であり、順序は問わない）。このとき ",
        math(String.raw`U`),
        " は可逆で、",
      ]),
      displayMath(
        String.raw`U\,S_1^{(+)}\,U^{-1} = -\,S_1^{(+)}, \qquad
U\,S_2\,U^{-1} = -\,S_2`,
      ),
      paragraph([
        "が成り立つ。すなわち ",
        math(String.raw`U H_1^{(+)} U^{-1} = -H_1^{(+)}`),
        "、",
        math(String.raw`U H_2 U^{-1} = -H_2`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 0（可逆性）。",
        ref("pauli_matrix_products"),
        " より ",
        math(String.raw`\sigma^x\sigma^x = \sigma^z\sigma^z = I`),
        " なので、各サイト ",
        math(String.raw`m`),
        " で",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_m^x\sigma_m^x
&= I
   \quad (\because\ \text{パウリ行列の積}), \\
\sigma_m^z\sigma_m^z
&= I
   \quad (\because\ \text{パウリ行列の積})
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。したがって ",
        math(String.raw`\sigma_m^x`),
        "、",
        math(String.raw`\sigma_m^z`),
        " はいずれも自分自身を逆行列にもつ可逆行列であり、可逆行列の有限積である ",
        math(String.raw`E, F, U`),
        " も可逆である。",
      ]),
      paragraph([
        "Step 1（1 因子ごとの共役）。",
        math(String.raw`j \neq k`),
        " なら ",
        math(String.raw`\sigma_j^a`),
        " と ",
        math(String.raw`\sigma_k^b`),
        " は可換なので、共役 ",
        math(String.raw`X \mapsto FXF^{-1}`),
        " において ",
        math(String.raw`F`),
        " のうち第 ",
        math(String.raw`k`),
        " 因子の ",
        math(String.raw`\sigma_k^z`),
        " だけが効く。",
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^z\sigma^x = -\sigma^x\sigma^z`),
        "、",
        math(String.raw`\sigma^y\sigma^z = -\sigma^z\sigma^y`),
        "、および ",
        math(String.raw`(\sigma^z)^{-1} = \sigma^z`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
F\sigma_k^x F^{-1}
&= \sigma_k^z\sigma_k^x\sigma_k^z
   \quad (\because\ k\ \text{以外のサイトの因子は }\sigma_k^x\text{ と可換}) \\
&= -\sigma_k^x\sigma_k^z\sigma_k^z
   \quad (\because\ \text{パウリ行列の積}) \\
&= -\sigma_k^x
   \quad (\because\ \text{パウリ行列の積}), \\
F\sigma_k^y F^{-1}
&= \sigma_k^z\sigma_k^y\sigma_k^z
   \quad (\because\ k\ \text{以外のサイトの因子は }\sigma_k^y\text{ と可換}) \\
&= -\sigma_k^y\sigma_k^z\sigma_k^z
   \quad (\because\ \text{パウリ行列の積}) \\
&= -\sigma_k^y
   \quad (\because\ \text{パウリ行列の積}), \\
F\sigma_k^z F^{-1}
&= \sigma_k^z\sigma_k^z\sigma_k^z
   \quad (\because\ k\ \text{以外のサイトの因子は }\sigma_k^z\text{ と可換}) \\
&= \sigma_k^z
   \quad (\because\ \text{パウリ行列の積})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`E`),
        " は奇数番目の因子にだけ ",
        math(String.raw`\sigma^x`),
        " をもつ。したがって ", math(String.raw`k`),
        " が偶数なら全因子が ", math(String.raw`\sigma_k^a`),
        " と可換であり、", math(String.raw`k`),
        " が奇数なら第 ", math(String.raw`k`),
        " 因子だけを計算すればよい。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E\sigma_k^aE^{-1}
&= \sigma_k^a
&& (\because\ k\text{ が偶数なら }E\text{ の全因子と可換}),\\
E\sigma_k^xE^{-1}
&= \sigma_k^x\sigma_k^x\sigma_k^x
&& (\because\ k\text{ が奇数なら第 }k\text{ 因子だけが効く})\\
&= \sigma_k^x
&& (\because\ \text{パウリ行列の積}),\\
E\sigma_k^yE^{-1}
&= \sigma_k^x\sigma_k^y\sigma_k^x
&& (\because\ k\text{ が奇数なら第 }k\text{ 因子だけが効く})\\
&= -\sigma_k^y\sigma_k^x\sigma_k^x
&& (\because\ \text{パウリ行列の積})\\
&= -\sigma_k^y
&& (\because\ \text{パウリ行列の積}),\\
E\sigma_k^zE^{-1}
&= \sigma_k^x\sigma_k^z\sigma_k^x
&& (\because\ k\text{ が奇数なら第 }k\text{ 因子だけが効く})\\
&= -\sigma_k^z\sigma_k^x\sigma_k^x
&& (\because\ \text{パウリ行列の積})\\
&= -\sigma_k^z
&& (\because\ \text{パウリ行列の積})
\end{aligned}`,
      ),
      paragraph([
        "この 2 つを合成して（",
        math(String.raw`U X U^{-1} = E(FXF^{-1})E^{-1}`),
        "）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
U\sigma_k^x U^{-1}
&= E\left(F\sigma_k^xF^{-1}\right)E^{-1}
   \quad (\because\ U=EF) \\
&= E(-\sigma_k^x)E^{-1}
   \quad (\because\ F\text{ による共役の計算}) \\
&= -\sigma_k^x
   \quad (\because\ E\sigma_k^xE^{-1}=\sigma_k^x), \\
U\sigma_k^y U^{-1}
&= E\left(F\sigma_k^yF^{-1}\right)E^{-1}
   \quad (\because\ U=EF) \\
&= -E\sigma_k^yE^{-1}
   \quad (\because\ F\text{ による共役の計算}) \\
&= \begin{cases}+\sigma_k^y & (k\ \text{奇数}) \\ -\sigma_k^y & (k\ \text{偶数})\end{cases}
   \quad (\because\ E\text{ による共役の場合分け}), \\
U\sigma_k^z U^{-1}
&= E\left(F\sigma_k^zF^{-1}\right)E^{-1}
   \quad (\because\ U=EF) \\
&= E\sigma_k^zE^{-1}
   \quad (\because\ F\text{ による共役の計算}) \\
&= \begin{cases}-\sigma_k^z & (k\ \text{奇数}) \\ +\sigma_k^z & (k\ \text{偶数})\end{cases}
   \quad (\because\ E\text{ による共役の場合分け})
\end{aligned}`,
      ),
      paragraph([
        "以下、共役 ",
        math(String.raw`X \mapsto UXU^{-1}`),
        " が ",
        math(String.raw`\mathbb{C}`),
        " 線型で積を保つこと（",
        math(String.raw`U(XY)U^{-1} = (UXU^{-1})(UYU^{-1})`),
        "、",
        math(String.raw`U^{-1}U = I`),
        " より）を繰り返し使う。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`Z_m`),
        " と ",
        math(String.raw`Y_m`),
        " への作用）。",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`Z_m = \sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^z`),
        "、",
        math(String.raw`Y_m = \sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^y`),
        " の各因子に Step 1 を適用すると、符号は因子ごとの符号の積になる。先頭の ",
        math(String.raw`\sigma^x`),
        " の因子は ",
        math(String.raw`m-1`),
        " 個あり、Step 1 の第 1 式より各々 ",
        math(String.raw`-1`),
        " なので寄与は ",
        math(String.raw`(-1)^{m-1}`),
        "。第 ",
        math(String.raw`m`),
        " 因子の寄与は Step 1 の第 2・第 3 式より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
U Z_m U^{-1}
&= (-1)^{m-1}\cdot\begin{cases}-1 & (m\ \text{奇数}) \\ +1 & (m\ \text{偶数})\end{cases}\ Z_m
   \quad (\because\ \text{Step 1 を }Z_m\text{ の各因子に適用}) \\
&= -\,Z_m
   \quad (\because\ m\ \text{の偶奇ごとに符号を計算}), \\
U Y_m U^{-1}
&= (-1)^{m-1}\cdot\begin{cases}+1 & (m\ \text{奇数}) \\ -1 & (m\ \text{偶数})\end{cases}\ Y_m
   \quad (\because\ \text{Step 1 を }Y_m\text{ の各因子に適用}) \\
&= +\,Y_m
   \quad (\because\ m\ \text{の偶奇ごとに符号を計算})
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`m`),
        " 奇数なら ",
        math(String.raw`(-1)^{m-1} = +1`),
        "、",
        math(String.raw`m`),
        " 偶数なら ",
        math(String.raw`(-1)^{m-1} = -1`),
        " なので、いずれの場合も積は ",
        math(String.raw`Z_m`),
        " について ",
        math(String.raw`-1`),
        "、",
        math(String.raw`Y_m`),
        " について ",
        math(String.raw`+1`),
        " になる。",
        math(String.raw`m = 1`),
        " のときは先頭の ",
        math(String.raw`\sigma^x`),
        " の因子が無く ",
        math(String.raw`Z_1 = \sigma_1^z`),
        "、",
        math(String.raw`Y_1 = \sigma_1^y`),
        " だが、",
        math(String.raw`1`),
        " は奇数なので符号は同じく ",
        math(String.raw`-1`),
        "、",
        math(String.raw`+1`),
        " である。**",
        math(String.raw`m`),
        " の偶奇によらない**ことが要点である。）",
      ]),
      paragraph([
        "Step 3（",
        math(String.raw`H_1^{(+)}`),
        " と ",
        math(String.raw`H_2`),
        " への作用）。",
        ref("def_H1_plus"),
        " の ",
        math(String.raw`H_1^{(+)} = \sum_{m=1}^{M_{\mathrm{col}}-1}Y_mZ_{m+1} - Y_{M_{\mathrm{col}}}Z_1`),
        " と ",
        ref("iH_is_real_symmetric"),
        " の Step 1 の ",
        math(String.raw`H_2 = \sum_{m=1}^{M_{\mathrm{col}}}Z_mY_m`),
        " は、どちらも ",
        math(String.raw`Y`),
        " と ",
        math(String.raw`Z`),
        " を 1 個ずつ掛けた項の、係数が ",
        math(String.raw`1`),
        " または ",
        math(String.raw`-1`),
        " の有限和である。Step 2 より各項について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
U\left(Y_j Z_k\right)U^{-1}
&= \left(U Y_j U^{-1}\right)\left(U Z_k U^{-1}\right)
   \quad (\because\ \text{共役は積を保つ}) \\
&= (+Y_j)(-Z_k)
   \quad (\because\ \text{Step 2}) \\
&= -\,Y_j Z_k
   \quad (\because\ \text{スカラー倍と行列積の両立}), \\
U\left(Z_j Y_j\right)U^{-1}
&= \left(U Z_j U^{-1}\right)\left(U Y_j U^{-1}\right)
   \quad (\because\ \text{共役は積を保つ}) \\
&= (-Z_j)(+Y_j)
   \quad (\because\ \text{Step 2}) \\
&= -\,Z_j Y_j
   \quad (\because\ \text{スカラー倍と行列積の両立})
\end{aligned}`,
      ),
      paragraph([
        "なので、共役の ",
        math(String.raw`\mathbb{C}`),
        " 線型性より",
      ]),
      displayMath(
        String.raw`U H_1^{(+)} U^{-1} = -\,H_1^{(+)}, \qquad
U H_2 U^{-1} = -\,H_2`,
      ),
      paragraph([
        "Step 4（",
        math(String.raw`S_1^{(+)}, S_2`),
        " への言い換え）。",
        math(String.raw`S_1^{(+)} = iK_1H_1^{(+)}`),
        "、",
        math(String.raw`S_2 = iK_2^*H_2`),
        " であり、スカラー倍は共役と可換なので Step 3 から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
U S_1^{(+)} U^{-1}
&= iK_1\,U H_1^{(+)} U^{-1}
   \quad (\because\ S_1^{(+)}=iK_1H_1^{(+)}\ \text{かつ共役はスカラー倍を保つ}) \\
&= -iK_1H_1^{(+)}
   \quad (\because\ \text{Step 3}) \\
&= -\,S_1^{(+)}
   \quad (\because\ S_1^{(+)}=iK_1H_1^{(+)}), \\
U S_2 U^{-1}
&= iK_2^*\,U H_2 U^{-1}
   \quad (\because\ S_2=iK_2^*H_2\ \text{かつ共役はスカラー倍を保つ}) \\
&= -iK_2^*H_2
   \quad (\because\ \text{Step 3}) \\
&= -\,S_2
   \quad (\because\ S_2=iK_2^*H_2)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`K_1, K_2^* > 0`),
        " より ",
        math(String.raw`iK_1, iK_2^* \neq 0`),
        " なので、逆に ",
        math(String.raw`S`),
        " についての等式から ",
        math(String.raw`H`),
        " についての等式も従い、両者は同値である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "この U は M の偶奇によらず両方の符号 (±) について働く。M=2,3,4,5,6 と両符号で残差 0 を数値確認した（sagemath/check/042_claim_constant_c_and_eigenvalues_of_V/check_02_sign_flip_conjugation.sage）。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },

]);
