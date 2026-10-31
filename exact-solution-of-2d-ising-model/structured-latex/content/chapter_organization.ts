import { defineBlocks, diagram, displayMath, list, math, paragraph, ref } from "../schema.ts";

/**
 * 論文の冒頭に置く章立ての説明。部と章の並び、各章のゴールの式、章の依存関係の図を示す。
 * 証明を持たない案内なので、主張・定義は置かず、注意と図表だけで書く。
 * 文書順の最初に来ることは `tools/content-modules.ts` の `LEADING_CONTENT_FILES` が決める。
 */
export default defineBlocks([
  {
    id: "chapter_organization_heading",
    kind: "heading",
    level: 2,
    title: { text: "章立て" },
    labels: ["chapter_organization"],
  },
  {
    id: "chapter_organization_remark_goal_of_this_paper",
    kind: "remark",
    title: { text: "この論文のゴール" },
    labels: ["chapter_organization_goal_of_this_paper"],
    statement: [
      paragraph(["この論文のゴールは、自由エネルギーの閉形式を解析し、臨界点を厳密に得ることである。そのための手順は次の三つである。"]),
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
    id: "chapter_organization_remark_parts_and_chapters",
    kind: "remark",
    title: { text: "部と章の並び" },
    labels: ["chapter_organization_parts_and_chapters"],
    statement: [
      paragraph([
        "この論文は、数学的道具立てを先に置き、そのあとに分配関数・固有値問題・熱力学極限・臨界点の四つの部を置く。部と章の並びは次のとおりである。",
      ]),
      list([
        ["数学的道具立て"],
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
        " と略記し、",
        math(String.raw`T_{(V)}(X):=VXV^{-1}`),
        " は共役写像を表す。",
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
    id: "chapter_organization_remark_goal_transfer_matrix_representation",
    kind: "remark",
    title: { text: "転送行列による表示" },
    labels: ["chapter_organization_goal_transfer_matrix_representation"],
    statement: [
      paragraph(["この章のゴールの式は次である（転送行列 ", math(String.raw`V_1, V_2`), " による表示 ",
        math(String.raw`Z=\mathrm{tr}\left((V_1V_2)^{N}\right)`), " に、", math(String.raw`V_1, V_2`), " の Pauli 行列による表示を代入した式）。"]),
      displayMath(String.raw`Z=\mathrm{tr}\left(\left(\exp\left(K_1\sum_{m=1}^{M}\sigma^z_m\sigma^z_{m+1}\right)
(2\sinh 2K_2)^{M/2}\exp\left(K_2^*\sum_{m=1}^{M}\sigma^x_m\right)\right)^{N}\right)`),
    ],
  },
  {
    id: "chapter_organization_remark_goal_projection_and_jordan_wigner",
    kind: "remark",
    title: { tex: String.raw`\varepsilon \text{ の固有値 } +1 \text{ の固有空間への射影と Jordan–Wigner 表示}` },
    labels: ["chapter_organization_goal_projection_and_jordan_wigner"],
    statement: [
      paragraph(["この章のゴールの式は次である。"]),
      displayMath(String.raw`WP^{(+)}=V^{(+)}P^{(+)},\qquad
P^{(+)}=\tfrac12\left(I+\varepsilon\right),`),
      displayMath(String.raw`\varepsilon=\sigma^x_1\cdots\sigma^x_M,\qquad
\mathcal F^{(+)}=\left\{x\in\mathbb C^{2^M}\ \middle|\ \varepsilon x=x\right\}=\mathrm{im}\,P^{(+)},`),
      displayMath(String.raw`V^{(+)}=\exp\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\,(2\sinh 2K_2)^{M/2}\exp\left(iK_2^*H_2\right)\,\exp\left(\tfrac{i}{2}K_1H_1^{(+)}\right),`),
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
    id: "chapter_organization_remark_goal_reduction_to_A_theta",
    kind: "remark",
    title: {
      tex: String.raw`\text{離散 Fourier 変換による }2\times2\text{ 行列 }A(\tilde\theta_\mu)\text{ への帰着}`,
    },
    labels: ["chapter_organization_goal_reduction_to_A_theta"],
    statement: [
      paragraph([
        "この章のゴールの式は次である（",
        math(String.raw`\mu\in\check{\mathcal M}=\{1,\dots,M\}`),
        "）。",
      ]),
      displayMath(String.raw`\tilde\theta_\mu=\frac{2\pi\left(\mu-\tfrac12\right)}{M},\qquad
\check Z_\mu=\sum_{j=1}^{M}Z_j\exp(-ij\tilde\theta_\mu),\qquad
\check Y_\mu=\sum_{j=1}^{M}Y_j\exp(-ij\tilde\theta_\mu),`),
      displayMath(String.raw`\left(T_{(V^{(+)})}(\check Z_\mu),\ T_{(V^{(+)})}(\check Y_\mu)\right)=\left(\check Z_\mu,\ \check Y_\mu\right)A(\tilde\theta_\mu),\qquad
A(\theta)=B_1(\theta)\,B_2\,B_1(\theta)`),
    ],
  },
  {
    id: "chapter_organization_remark_goal_diagonalization_and_exponential_form",
    kind: "remark",
    title: {
      tex: String.raw`A(\tilde\theta_\mu)\text{ の対角化と }V^{(+)}\text{ の指数表示}`,
    },
    labels: ["chapter_organization_goal_diagonalization_and_exponential_form"],
    statement: [
      paragraph([
        "この章のゴールの式は次である（",
        math(String.raw`\mu\in\check{\mathcal M}`),
        "。",
        math(String.raw`\check P_\mu\in\mathrm{Mat}(2,\mathbb C)`),
        " は本文で成分を与える可逆行列。",
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
    id: "chapter_organization_remark_goal_eigenvalues_of_V_plus",
    kind: "remark",
    title: { tex: String.raw`V^{(+)}\text{ の固有値}` },
    labels: ["chapter_organization_goal_eigenvalues_of_V_plus"],
    statement: [
      paragraph([
        "この章のゴールの式は次である（",
        math(String.raw`\epsilon\in\{0,1\}^{\check{\mathcal M}}`),
        "）。",
      ]),
      displayMath(String.raw`c=(2\sinh 2K_2)^{M/2},\qquad
\check Q_\epsilon=\prod_{\mu=1}^{M}\left(\epsilon_\mu\check n_\mu+(1-\epsilon_\mu)\left(I-\check n_\mu\right)\right),\qquad
V^{(+)}\check Q_\epsilon=\check\Lambda_\epsilon\check Q_\epsilon,`),
      displayMath(String.raw`\check\Lambda_\epsilon=(2\sinh 2K_2)^{M/2}\exp\left(\sum_{\mu=1}^{M}\gamma(\tilde\theta_\mu)\left(\epsilon_\mu-\tfrac12\right)\right),`),
      displayMath(String.raw`\max_\epsilon\check\Lambda_\epsilon=\check\Lambda_{(1,\dots,1)}=\Lambda^{(1/2)}_M=(2\sinh 2K_2)^{M/2}\exp\left(\frac12\sum_{\mu=1}^{M}\gamma(\tilde\theta_\mu)\right),\qquad
\epsilon\neq(1,\dots,1)\Longrightarrow\check\Lambda_\epsilon<\check\Lambda_{(1,\dots,1)}`),
    ],
  },
  {
    id: "chapter_organization_remark_goal_eigenvector_of_max_eigenvalue",
    kind: "remark",
    title: { tex: String.raw`V^{(+)}\text{ の最大固有値に属する固有ベクトル}` },
    labels: ["chapter_organization_goal_eigenvector_of_max_eigenvalue"],
    statement: [
      paragraph(["この章のゴールの式は次である。"]),
      displayMath(String.raw`\mathrm{tr}\left(\varepsilon V^{(+)}\right)=\left(2\exp(-K_2)\cosh K_1\right)^{M}+\left(2\exp(K_2)\sinh K_1\right)^{M}>0
\ \Longrightarrow\
\mathrm{im}\,\check Q_{(1,\dots,1)}\subseteq\mathcal F^{(+)}`),
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
    id: "chapter_organization_remark_goal_row_limit_and_max_eigenvalue",
    kind: "remark",
    title: { tex: String.raw`N\to\infty\text{ の極限と最大固有値 }c(M)` },
    labels: ["chapter_organization_goal_row_limit_and_max_eigenvalue"],
    statement: [
      paragraph(["この章のゴールの式は次である。"]),
      displayMath(String.raw`W=V_1^{1/2}V_2V_1^{1/2},\qquad
c(M)=\sup\left\{x^\top Wx\ \middle|\ x\in\mathbb R^{2^M},\ \lVert x\rVert=1\right\},`),
      displayMath(String.raw`c(M)^{N}\le Z\le 2^{M}c(M)^{N},\qquad
\lim_{N\to\infty}\frac{1}{MN}\log Z=\frac1M\log c(M)`),
    ],
  },
  {
    id: "chapter_organization_remark_goal_column_limit_and_closed_form",
    kind: "remark",
    title: { tex: String.raw`M\to\infty\text{ の極限と閉形式}` },
    labels: ["chapter_organization_goal_column_limit_and_closed_form"],
    statement: [
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
    id: "chapter_organization_remark_goal_critical_point_and_log_divergence",
    kind: "remark",
    title: {
      tex: String.raw`\text{臨界点 }K_c\text{ と }\frac{d^2f}{dK^2}\text{ の対数発散}`,
    },
    labels: ["chapter_organization_goal_critical_point_and_log_divergence"],
    statement: [
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
  {
    id: "chapter_organization_heading_dependencies",
    kind: "heading",
    level: 3,
    title: { text: "章の依存関係" },
    labels: [],
  },
  {
    id: "chapter_organization_remark_dependencies",
    kind: "remark",
    title: { text: "章の依存関係" },
    labels: ["chapter_organization_dependencies"],
    statement: [
      paragraph([
        "章どうしの依存を",
        ref("figure_chapter_dependencies"),
        "に示す。",
        math(String.raw`\varepsilon`),
        " の固有値 ",
        math(String.raw`+1`),
        " の固有空間への射影と Jordan–Wigner 表示の章のあとで、流れは二つに分かれる。一つは固有値問題の四章であり、もう一つは ",
        math(String.raw`N\to\infty`),
        " の極限の章である。二つの流れは ",
        math(String.raw`M\to\infty`),
        " の極限の章で合流する。",
      ]),
    ],
  },
  {
    id: "chapter_organization_figure_dependencies",
    kind: "figure",
    labels: ["figure_chapter_dependencies"],
    content: [
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
          { from: "projectionAndJordanWigner", to: "rowLimitAndMaxEigenvalue" },
          { from: "rowLimitAndMaxEigenvalue", to: "columnLimitAndClosedForm" },
          { from: "columnLimitAndClosedForm", to: "criticalPointAndLogDivergence" },
        ],
      }),
    ],
    caption: [
      paragraph([
        "章の依存関係。枠は部を、矢印は「矢印の元の章を、矢印の先の章が使う」を表す。ほかの矢印を辿って届く依存の矢印は省いた。数学的道具立てはすべての章が使うので、図には入れていない。",
      ]),
    ],
  },
]);
