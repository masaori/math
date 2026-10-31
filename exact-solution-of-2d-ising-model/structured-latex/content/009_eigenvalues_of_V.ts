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
]);
