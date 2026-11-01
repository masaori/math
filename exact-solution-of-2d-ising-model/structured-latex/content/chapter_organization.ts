import { defineBlocks, diagram, displayMath, list, math, paragraph } from "../schema.ts";

/**
 * 論文の冒頭に置く章「この論文について」。論文のゴールと、部と章の並び（冒頭に章の依存関係の図を置く）と、
 * 各章のゴールの式（何を示す式かの一文を添える）を示す。
 * 証明を持たない案内なので、主張・定義・注意は置かず、概要（`overview`）だけで書く。
 * 文書順の最初に来ることは `tools/content-modules.ts` の `LEADING_CONTENT_FILES` が決める。
 */
export default defineBlocks([
  {
    id: "chapter_organization_heading",
    kind: "heading",
    level: 2,
    title: { text: "この論文について" },
    labels: ["chapter_organization"],
  },
  {
    id: "chapter_organization_overview_goal_of_this_paper",
    kind: "overview",
    title: { text: "この論文のゴール" },
    labels: ["chapter_organization_goal_of_this_paper"],
    statement: [
      paragraph([
        "この論文のゴールは、二次元格子イジング模型の自由エネルギーの閉形式を解析し臨界点を厳密に得るというオンサーガーが1944年に示した方法を、数学的に一切の飛躍なく厳密に示すことである。",
      ]),
      paragraph([
        "原著も含めほとんどの論文・解説書・教科書は、計算の過程や証明に何らかの物理的直感を前提とした飛躍があり、理論物理の世界においては基本的な結果であるにもかかわらず、数学者にとっては理解しづらいものになってしまっていた。",
      ]),
      paragraph([
        "この論文では、計算対象を物理用語を使わず数学的対象として正確に定義し、計算の過程もできる限り飛ばさずに記述するよう努めた。そのため、興味関心と気骨さえあれば、高校生でも理解することが可能な内容になっている。代わりに長大な論文になってしまっていることをご容赦いただきたい。",
      ]),
      paragraph([
        "また、全ての計算過程は、SageMathによる数値計算による検証と、Leanによる形式検証により、その精度を担保している。計算ミスは限りなく0に近いと自負しているので、安心して重要な部分だけを読み飛ばしていただきたい。",
      ]),
      paragraph(["オンサーガーの方法の手順は次の三つである。"]),
      list([
        [
          "2次元 Ising 模型の分配関数 ",
          math(String.raw`Z`),
          " を用いて、この系の自由エネルギー ",
          math(String.raw`\log Z`),
          " を表す（格子点 1 個あたりでは ",
          math(String.raw`\frac{1}{M_{\mathrm{col}}N_{\mathrm{row}}}\log Z`),
          "）。",
        ],
        [
          "その熱力学極限（格子サイズ ",
          math(String.raw`M_{\mathrm{col}},N_{\mathrm{row}}\to\infty`),
          "）における閉形式を表示する（Onsager の厳密解）。",
        ],
        ["閉形式を解析することで、臨界点を計算する。"],
      ]),
      paragraph(["閉形式は次である。"]),
      displayMath(String.raw`\lim_{M_{\mathrm{col}}\to\infty}\lim_{N_{\mathrm{row}}\to\infty}\frac{1}{M_{\mathrm{col}}N_{\mathrm{row}}}\log Z
=\frac12\log\left(2\sinh 2K_2\right)+\frac1{4\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta,`),
      displayMath(String.raw`\gamma(\theta)=\mathrm{arccosh}\left(\cosh 2K_1\cosh 2K_2^*-\sinh 2K_1\sinh 2K_2^*\cos\theta\right)`),
      paragraph(["臨界点は次の条件で与えられる（", math(String.raw`K_1=K_2=K`), " のときは ", math(String.raw`\sinh 2K_c=1`), "）。"]),
      displayMath(String.raw`\sinh 2K_1\,\sinh 2K_2=1`),
    ],
  },
  {
    id: "chapter_organization_overview_parts_and_chapters",
    kind: "overview",
    title: { text: "部と章の並び" },
    labels: ["chapter_organization_parts_and_chapters"],
    statement: [
      paragraph([
        "数学的道具立てより後の章どうしの依存を次の図に示す。枠は部を、矢印は「矢印の元の章を、矢印の先の章が使う」を表す。ほかの矢印を辿って届く依存の矢印は省いた。数学的道具立てはすべての章が使うので、図には入れていない。",
      ]),
      diagram({
        groups: [
          { id: "partitionFunction", title: ["分配関数"] },
          { id: "eigenvalueProblem", title: ["固有値問題"] },
          { id: "thermodynamicLimit", title: ["熱力学極限"] },
          { id: "criticalPoint", title: ["臨界点"] },
        ],
        boxes: [
          {
            id: "transferMatrixRepresentation",
            title: ["転送行列による表示"],
            group: "partitionFunction",
            column: 0,
            row: 0,
          },
          {
            id: "projectionAndJordanWigner",
            title: [math(String.raw`\varepsilon`), " の固有値 ", math(String.raw`+1`), " の固有空間への射影と Jordan–Wigner 表示"],
            group: "partitionFunction",
            column: 0,
            row: 1,
          },
          {
            id: "reductionToATheta",
            title: [
              "離散 Fourier 変換による ",
              math(String.raw`2\times2`),
              " 行列 ",
              math(String.raw`A(\tilde\theta_\mu)`),
              " への帰着",
            ],
            group: "eigenvalueProblem",
            column: 0,
            row: 2,
          },
          {
            id: "diagonalizationAndExponentialForm",
            title: [
              math(String.raw`A(\tilde\theta_\mu)`),
              " の対角化と ",
              math(String.raw`V^{(+)}`),
              " の指数表示",
            ],
            group: "eigenvalueProblem",
            column: 0,
            row: 3,
          },
          {
            id: "eigenvaluesOfVPlus",
            title: [math(String.raw`V^{(+)}`), " の固有値"],
            group: "eigenvalueProblem",
            column: 0,
            row: 4,
          },
          {
            id: "eigenvectorOfMaxEigenvalue",
            title: [math(String.raw`V^{(+)}`), " の最大固有値に属する固有ベクトル"],
            group: "eigenvalueProblem",
            column: 0,
            row: 5,
          },
          {
            id: "rowLimitAndMaxEigenvalue",
            title: [
              math(String.raw`N\to\infty`),
              " の極限と最大固有値 ",
              math(String.raw`c(M)`),
            ],
            group: "thermodynamicLimit",
            column: 1,
            row: 6,
          },
          {
            id: "columnLimitAndClosedForm",
            title: [math(String.raw`M\to\infty`), " の極限と閉形式"],
            group: "thermodynamicLimit",
            column: 0,
            row: 7,
          },
          {
            id: "criticalPointAndLogDivergence",
            title: [
              "臨界点 ",
              math(String.raw`K_c`),
              " と ",
              math(String.raw`\frac{d^2f}{dK^2}`),
              " の対数発散",
            ],
            group: "criticalPoint",
            column: 0,
            row: 8,
          },
        ],
        edges: [
          { from: "transferMatrixRepresentation", to: "projectionAndJordanWigner" },
          { from: "projectionAndJordanWigner", to: "reductionToATheta" },
          { from: "reductionToATheta", to: "diagonalizationAndExponentialForm" },
          { from: "diagonalizationAndExponentialForm", to: "eigenvaluesOfVPlus" },
          { from: "eigenvaluesOfVPlus", to: "eigenvectorOfMaxEigenvalue" },
          { from: "eigenvectorOfMaxEigenvalue", to: "columnLimitAndClosedForm" },
          { from: "eigenvaluesOfVPlus", to: "rowLimitAndMaxEigenvalue" },
          { from: "rowLimitAndMaxEigenvalue", to: "columnLimitAndClosedForm" },
          { from: "columnLimitAndClosedForm", to: "criticalPointAndLogDivergence" },
        ],
      }),
      paragraph([
        "分配関数の二章と、固有値問題の初めの三章は一列に並ぶ。",
        math(String.raw`V^{(+)}`),
        " の固有値の章のあとで、流れは二つに分かれる。一つは ",
        math(String.raw`V^{(+)}`),
        " の最大固有値に属する固有ベクトルの章であり、もう一つは ",
        math(String.raw`N\to\infty`),
        " の極限の章である（",
        math(String.raw`W`),
        " が実対称で正定値であることの証明が、",
        math(String.raw`V^{(+)}`),
        " の固有値の章で示す、",
        math(String.raw`iK_1H_1^{(+)}`),
        " と ",
        math(String.raw`iK_2^*H_2`),
        " が実対称であることを使う）。二つの流れは ",
        math(String.raw`M\to\infty`),
        " の極限の章で合流する。",
      ]),
      paragraph([
        "この論文は、数学的道具立てを先に置き、そのあとに分配関数・固有値問題・熱力学極限・臨界点の四つの部を置く。部と章の並びは次のとおりである。",
      ]),
      list([
        [
          "数学的道具立て：計算公式、線型空間の一般論、線型写像のexp、行列と線型写像の対応と、対角行列の指数関数、",
          math(String.raw`\exp(X) Y \exp(-X) = \exp(\mathrm{ad}(X))(Y)`),
          " の証明、Pauli 行列の積と、クロネッカー積の反交換、",
          math(String.raw`\sinh,\cosh`),
          " のテイラー展開、可逆行列と共役写像 ",
          math(String.raw`T_g`),
          "、トレース・エルミート行列・正定値性、半正定値双線型形式の Cauchy–Schwarz の不等式、等間隔点の平均の積分への収束、",
          math(String.raw`\cosh,\sinh`),
          " の加法定理と、正弦およびそれを含む積分の評価",
        ],
        [
          "分配関数：転送行列による表示、",
          math(String.raw`\varepsilon`),
          " の固有値 ",
          math(String.raw`+1`),
          " の固有空間への射影と Jordan–Wigner 表示",
        ],
        [
          "固有値問題：離散 Fourier 変換による ",
          math(String.raw`2\times2`),
          " 行列 ",
          math(String.raw`A(\tilde\theta_\mu)`),
          " への帰着、",
          math(String.raw`A(\tilde\theta_\mu)`),
          " の対角化と ",
          math(String.raw`V^{(+)}`),
          " の指数表示、",
          math(String.raw`V^{(+)}`),
          " の固有値、",
          math(String.raw`V^{(+)}`),
          " の最大固有値に属する固有ベクトル",
        ],
        [
          "熱力学極限：",
          math(String.raw`N\to\infty`),
          " の極限と最大固有値 ",
          math(String.raw`c(M)`),
          "、",
          math(String.raw`M\to\infty`),
          " の極限と閉形式",
        ],
        [
          "臨界点：臨界点 ",
          math(String.raw`K_c`),
          " と ",
          math(String.raw`\frac{d^2f}{dK^2}`),
          " の対数発散",
        ],
      ]),
      paragraph([
        "数学的道具立てより後の各章は、一つのゴールの式で終わる。以下に各章のゴールの式を挙げる。記号の定義はそれぞれの章で与える。ここでは ",
        math(String.raw`M:=M_{\mathrm{col}}`),
        "、",
        math(String.raw`N:=N_{\mathrm{row}}`),
        " と略記する。",
        math(String.raw`T_{(V^{(+)})}`),
        " は本文では三つの因子による共役の合成として定め、",
        math(String.raw`V^{(+)}`),
        " による共役 ",
        math(String.raw`X\mapsto V^{(+)}X\left(V^{(+)}\right)^{-1}`),
        " と一致することを離散 Fourier 変換の章で示す。",
      ]),
    ],
  },
  {
    id: "chapter_organization_heading_partition_function",
    kind: "heading",
    level: 3,
    title: { text: "分配関数" },
    labels: [],
  },
  {
    id: "chapter_organization_overview_goal_transfer_matrix_representation",
    kind: "overview",
    title: { text: "転送行列による表示" },
    labels: ["chapter_organization_goal_transfer_matrix_representation"],
    statement: [
      paragraph([
        "分配関数 ",
        math(String.raw`Z`),
        " が、Pauli 行列から作った ",
        math(String.raw`2^M\times2^M`),
        " 複素行列の積の ",
        math(String.raw`N`),
        " 乗のトレースで書けることを示す式である。",
      ]),
      paragraph(["この章のゴールの式は次である（転送行列 ", math(String.raw`V_1, V_2`), " による表示 ",
        math(String.raw`Z=\mathrm{tr}\left((V_1V_2)^{N}\right)`), " に、", math(String.raw`V_1, V_2`), " の Pauli 行列による表示を代入した式）。"]),
      displayMath(String.raw`Z=\mathrm{tr}\left(\left(\exp\left(K_1\sum_{m=1}^{M}\sigma^z_m\sigma^z_{m+1}\right)
(2\sinh 2K_2)^{M/2}\exp\left(K_2^*\sum_{m=1}^{M}\sigma^x_m\right)\right)^{N}\right)`),
    ],
  },
  {
    id: "chapter_organization_overview_goal_projection_and_jordan_wigner",
    kind: "overview",
    title: { tex: String.raw`\varepsilon \text{ の固有値 } +1 \text{ の固有空間への射影と Jordan–Wigner 表示}` },
    labels: ["chapter_organization_goal_projection_and_jordan_wigner"],
    statement: [
      paragraph([
        math(String.raw`\varepsilon`),
        " の固有値 ",
        math(String.raw`+1`),
        " の固有空間の上では、",
        math(String.raw`W`),
        " が行列 ",
        math(String.raw`H_1^{(+)},H_2`),
        " の指数関数の積 ",
        math(String.raw`V^{(+)}`),
        " と一致することを示す式である。",
      ]),
      paragraph(["この章のゴールの式は次である。"]),
      displayMath(String.raw`WP^{(+)}=V^{(+)}P^{(+)},\qquad
P^{(+)}=\tfrac12\left(I+\varepsilon\right),\qquad
\varepsilon=\sigma^x_1\cdots\sigma^x_M,\qquad
\mathcal F^{(+)}=\left\{x\in\mathbb C^{2^M}\ \middle|\ \varepsilon x=x\right\}=\mathrm{im}\,P^{(+)},`),
      displayMath(String.raw`V^{(+)}=\exp\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\,(2\sinh 2K_2)^{M/2}\exp\left(iK_2^*H_2\right)\,\exp\left(\tfrac{i}{2}K_1H_1^{(+)}\right),`),
      paragraph(["ここに現れる行列 ", math(String.raw`H_1^{(+)},H_2`), " は次である。"]),
      displayMath(String.raw`H_1^{(+)}=\sum_{m=1}^{M-1}Y_mZ_{m+1}-Y_MZ_1,\qquad
H_2=\sum_{m=1}^{M}Z_mY_m`),
    ],
  },
  {
    id: "chapter_organization_heading_eigenvalue_problem",
    kind: "heading",
    level: 3,
    title: { text: "固有値問題" },
    labels: [],
  },
  {
    id: "chapter_organization_overview_goal_reduction_to_A_theta",
    kind: "overview",
    title: {
      tex: String.raw`\text{離散 Fourier 変換による }2\times2\text{ 行列 }A(\tilde\theta_\mu)\text{ への帰着}`,
    },
    labels: ["chapter_organization_goal_reduction_to_A_theta"],
    statement: [
      paragraph([
        math(String.raw`V^{(+)}`),
        " による共役が、離散 Fourier 変換した行列の組 ",
        math(String.raw`(\check Z_\mu,\check Y_\mu)`),
        " を ",
        math(String.raw`2\times2`),
        " 行列 ",
        math(String.raw`A(\tilde\theta_\mu)`),
        " で写すことを示し、問題を ",
        math(String.raw`M`),
        " 個の ",
        math(String.raw`2\times2`),
        " 行列に帰着する式である。",
      ]),
      paragraph([
        "この章のゴールの式は次である（",
        math(String.raw`\mu\in\check{\mathcal M}=\{1,\dots,M\}`),
        "）。",
      ]),
      displayMath(String.raw`\left(V^{(+)}\check Z_\mu\left(V^{(+)}\right)^{-1},\ V^{(+)}\check Y_\mu\left(V^{(+)}\right)^{-1}\right)
=\left(T_{(V^{(+)})}(\check Z_\mu),\ T_{(V^{(+)})}(\check Y_\mu)\right)=\left(\check Z_\mu,\ \check Y_\mu\right)A(\tilde\theta_\mu)
=\left(\check Z_\mu,\ \check Y_\mu\right)B_1(\tilde\theta_\mu)\,B_2\,B_1(\tilde\theta_\mu)`),
      paragraph(["ここに現れる記号は次である。"]),
      displayMath(String.raw`\tilde\theta_\mu=\frac{2\pi\left(\mu-\tfrac12\right)}{M},\qquad
\check Z_\mu=\sum_{j=1}^{M}Z_j\exp(-ij\tilde\theta_\mu),\qquad
\check Y_\mu=\sum_{j=1}^{M}Y_j\exp(-ij\tilde\theta_\mu)`),
    ],
  },
  {
    id: "chapter_organization_overview_goal_diagonalization_and_exponential_form",
    kind: "overview",
    title: {
      tex: String.raw`A(\tilde\theta_\mu)\text{ の対角化と }V^{(+)}\text{ の指数表示}`,
    },
    labels: ["chapter_organization_goal_diagonalization_and_exponential_form"],
    statement: [
      paragraph([
        math(String.raw`A(\tilde\theta_\mu)`),
        " の固有値が ",
        math(String.raw`\exp(\pm\gamma(\tilde\theta_\mu))`),
        " であることから、",
        math(String.raw`V^{(+)}`),
        " を定数倍を除いて行列 ",
        math(String.raw`\check n_\mu`),
        " と単位行列の一次結合の指数関数で書けることを示す式である。",
      ]),
      paragraph([
        "この章のゴールの式は次である（",
        math(String.raw`\mu\in\check{\mathcal M}`),
        "。",
        math(String.raw`\check P_\mu\in\mathrm{Mat}(2,\mathbb C)`),
        " は本文で成分を与える可逆行列で、",
        math(String.raw`c\in\mathbb C^\times`),
        " の値は次の章で決める）。",
      ]),
      displayMath(String.raw`A(\tilde\theta_\mu)=\check P_\mu\begin{pmatrix}\lambda_{+,\mu}&0\\0&\lambda_{-,\mu}\end{pmatrix}\check P_\mu^{-1},\qquad
\lambda_{\pm,\mu}=\exp\left(\pm\gamma(\tilde\theta_\mu)\right),`),
      displayMath(String.raw`\gamma(\theta)=\mathrm{arccosh}\left(\cosh 2K_1\cosh 2K_2^*-\sinh 2K_1\sinh 2K_2^*\cos\theta\right),`),
      displayMath(String.raw`\left(\check\psi_\mu^\dagger,\ \check\psi_\mu\right)=\left(\check Z_\mu,\ \check Y_\mu\right)\check P_\mu,\qquad
\check n_\mu=\check\psi_\mu^\dagger\check\psi_{M+1-\mu},`),
      displayMath(String.raw`V^{(+)}=c\,\exp\left(\sum_{\mu\in\check{\mathcal M}}\gamma(\tilde\theta_\mu)\left(\check n_\mu-\tfrac12I\right)\right)`),
    ],
  },
  {
    id: "chapter_organization_overview_goal_eigenvalues_of_V_plus",
    kind: "overview",
    title: { tex: String.raw`V^{(+)}\text{ の固有値}` },
    labels: ["chapter_organization_goal_eigenvalues_of_V_plus"],
    statement: [
      paragraph([
        "定数 ",
        math(String.raw`c`),
        " を決めて ",
        math(String.raw`V^{(+)}`),
        " の固有値をすべて求め、最大の固有値は ",
        math(String.raw`\epsilon=(1,\dots,1)`),
        " のときの ",
        math(String.raw`\Lambda^{(1/2)}_M`),
        " だけであることを示す式である。",
      ]),
      paragraph([
        "この章のゴールの式は次である（",
        math(String.raw`\epsilon\in\{0,1\}^{\check{\mathcal M}}`),
        "。前の章の ",
        math(String.raw`c`),
        " の値を一つ目の式で決める）。",
      ]),
      displayMath(String.raw`V^{(+)}=(2\sinh 2K_2)^{M/2}\exp\left(\sum_{\mu\in\check{\mathcal M}}\gamma(\tilde\theta_\mu)\left(\check n_\mu-\tfrac12I\right)\right),\qquad
V^{(+)}\check Q_\epsilon=\check\Lambda_\epsilon\check Q_\epsilon,`),
      displayMath(String.raw`\max_\epsilon\check\Lambda_\epsilon=\check\Lambda_{(1,\dots,1)}=\Lambda^{(1/2)}_M=(2\sinh 2K_2)^{M/2}\exp\left(\frac12\sum_{\mu=1}^{M}\gamma(\tilde\theta_\mu)\right),\qquad
\epsilon\neq(1,\dots,1)\Longrightarrow\check\Lambda_\epsilon<\check\Lambda_{(1,\dots,1)}`),
      paragraph(["ここに現れる記号は次である。"]),
      displayMath(String.raw`\check Q_\epsilon=\prod_{\mu=1}^{M}\left(\epsilon_\mu\check n_\mu+(1-\epsilon_\mu)\left(I-\check n_\mu\right)\right),\qquad
\check\Lambda_\epsilon=(2\sinh 2K_2)^{M/2}\exp\left(\sum_{\mu=1}^{M}\gamma(\tilde\theta_\mu)\left(\epsilon_\mu-\tfrac12\right)\right)`),
    ],
  },
  {
    id: "chapter_organization_overview_goal_eigenvector_of_max_eigenvalue",
    kind: "overview",
    title: { tex: String.raw`V^{(+)}\text{ の最大固有値に属する固有ベクトル}` },
    labels: ["chapter_organization_goal_eigenvector_of_max_eigenvalue"],
    statement: [
      paragraph([
        math(String.raw`\mathrm{tr}(\varepsilon V^{(+)})>0`),
        " から、最大の固有値に属する固有ベクトルが ",
        math(String.raw`\varepsilon`),
        " の固有値 ",
        math(String.raw`+1`),
        " の固有空間 ",
        math(String.raw`\mathcal F^{(+)}`),
        " に入ることを示す式である。",
      ]),
      paragraph(["この章のゴールの式は次である。"]),
      displayMath(String.raw`\mathrm{tr}\left(\varepsilon V^{(+)}\right)=\left(2\exp(-K_2)\cosh K_1\right)^{M}+\left(2\exp(K_2)\sinh K_1\right)^{M}>0
\ \Longrightarrow\
\mathrm{im}\,\check Q_{(1,\dots,1)}\subseteq\mathcal F^{(+)}`),
      paragraph(["ここに現れる記号は次である。"]),
      displayMath(String.raw`\varepsilon=\sigma^x_1\cdots\sigma^x_M,\qquad
\check Q_{(1,\dots,1)}=\prod_{\mu=1}^{M}\check n_\mu,\qquad
\mathcal F^{(+)}=\left\{x\in\mathbb C^{2^M}\ \middle|\ \varepsilon x=x\right\}`),
    ],
  },
  {
    id: "chapter_organization_heading_thermodynamic_limit",
    kind: "heading",
    level: 3,
    title: { text: "熱力学極限" },
    labels: [],
  },
  {
    id: "chapter_organization_overview_goal_row_limit_and_max_eigenvalue",
    kind: "overview",
    title: { tex: String.raw`N\to\infty\text{ の極限と最大固有値 }c(M)` },
    labels: ["chapter_organization_goal_row_limit_and_max_eigenvalue"],
    statement: [
      paragraph([
        math(String.raw`Z`),
        " を ",
        math(String.raw`W`),
        " の二次形式の上限 ",
        math(String.raw`c(M)`),
        " で上下から挟み、",
        math(String.raw`N\to\infty`),
        " で ",
        math(String.raw`\frac{1}{MN}\log Z`),
        " が ",
        math(String.raw`\frac1M\log c(M)`),
        " に収束することを示す式である。",
      ]),
      paragraph(["この章のゴールの式は次である。"]),
      displayMath(String.raw`W=V_1^{1/2}V_2V_1^{1/2},\qquad
c(M)=\sup\left\{x^\top Wx\ \middle|\ x\in\mathbb R^{2^M},\ \lVert x\rVert=1\right\},`),
      displayMath(String.raw`c(M)^{N}\le Z\le 2^{M}c(M)^{N},\qquad
\lim_{N\to\infty}\frac{1}{MN}\log Z=\frac1M\log c(M)`),
    ],
  },
  {
    id: "chapter_organization_overview_goal_column_limit_and_closed_form",
    kind: "overview",
    title: { tex: String.raw`M\to\infty\text{ の極限と閉形式}` },
    labels: ["chapter_organization_goal_column_limit_and_closed_form"],
    statement: [
      paragraph([
        math(String.raw`c(M)`),
        " を ",
        math(String.raw`\Lambda^{(1/2)}_M`),
        " とその ",
        math(String.raw`2`),
        " 倍で挟み、",
        math(String.raw`M\to\infty`),
        " で ",
        math(String.raw`\frac{1}{MN}\log Z`),
        " の極限が積分で書いた閉形式になることを示す式である。",
      ]),
      paragraph(["この章のゴールの式は次である。"]),
      displayMath(String.raw`c_+(M)=\sup\left\{x^\top Wx\ \middle|\ x\in\mathcal F^{(+)}\cap\mathbb R^{2^M},\ \lVert x\rVert=1\right\}=\Lambda^{(1/2)}_M,\qquad
\Lambda^{(1/2)}_M\le c(M)\le 2\Lambda^{(1/2)}_M,`),
      displayMath(String.raw`\lim_{M\to\infty}\lim_{N\to\infty}\frac{1}{MN}\log Z
=\frac12\log\left(2\sinh 2K_2\right)+\frac1{4\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta`),
    ],
  },
  {
    id: "chapter_organization_heading_critical_point",
    kind: "heading",
    level: 3,
    title: { text: "臨界点" },
    labels: [],
  },
  {
    id: "chapter_organization_overview_goal_critical_point_and_log_divergence",
    kind: "overview",
    title: {
      tex: String.raw`\text{臨界点 }K_c\text{ と }\frac{d^2f}{dK^2}\text{ の対数発散}`,
    },
    labels: ["chapter_organization_goal_critical_point_and_log_divergence"],
    statement: [
      paragraph([
        "閉形式 ",
        math(String.raw`f(K)`),
        " の二階導関数が、",
        math(String.raw`\sinh 2K_c=1`),
        " で定まる ",
        math(String.raw`K_c`),
        " に近づくと ",
        math(String.raw`\frac{8}{\pi}\log\frac{1}{\lvert K-K_c\rvert}`),
        " との差を ",
        math(String.raw`49`),
        " 以内に保って発散することを示す式である。",
      ]),
      paragraph([
        "この章のゴールの式は次である（",
        math(String.raw`K_1=K_2=K`),
        "、",
        math(String.raw`f(K)`),
        " は前の章のゴールの式の極限の右辺、",
        math(String.raw`0<\lvert K-K_c\rvert\le\frac1{10}`),
        "）。",
      ]),
      displayMath(String.raw`\sinh 2K_c=1,\qquad
\left\lvert\frac{d^2f}{dK^2}(K)-\frac{8}{\pi}\log\frac{1}{\lvert K-K_c\rvert}\right\rvert\le 49`),
    ],
  },
]);
