/**
 * 論文本体 第 2 章: 設定。
 *
 * 整数スペクトル曲線 P、周期点数 a_L、簡約周期点数 a^red_L、Massieu 自由エントロピー Φ_L を定義する。
 * すべて可算側で閉じる（ℝ を使わない）。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "paper_020_heading_setup",
    kind: "heading",
    level: 1,
    origin: { path: "structured-latex/content/002_setup.ts", ordinal: 1 },
    title: { text: "設定" },
    labels: [],
  },
  {
    id: "paper_021_definition_curve",
    kind: "definition",
    origin: { path: "structured-latex/content/002_setup.ts", ordinal: 2 },
    title: { text: "整数スペクトル曲線と周期点数" },
    labels: ["paper_def_curve", "paper_def_aL"],
    habitat: "Z",
    statement: [
      paragraph([
        math(String.raw`d\ge1`),
        " を整数、",
        math(String.raw`P\in\mathbb{Z}[z_1^{\pm1},\dots,z_d^{\pm1}]\setminus\{0\}`),
        " を整数係数の Laurent 多項式（整数スペクトル曲線）とする。",
      ]),
      paragraph([
        math(String.raw`L\ge1`),
        " に対し周期点数と簡約周期点数を",
      ]),
      displayMath(
        String.raw`a_L:=\prod_{z_1^{L}=\dots=z_d^{L}=1}P(z_1,\dots,z_d),
\qquad
a^{\mathrm{red}}_L:=\prod_{\substack{z_1^{L}=\dots=z_d^{L}=1\\ P(z)\neq0}}P(z_1,\dots,z_d)`,
      ),
      paragraph([
        "で定める。どちらも Galois 不変な代数的整数なので ",
        math(String.raw`\mathbb{Z}`),
        " に属する。",
        math(String.raw`P`),
        " が 1 の冪根の組で零点をもたなければ両者は一致する。",
      ]),
      paragraph([
        "単項式倍は ",
        math(String.raw`a_L`),
        " を変えない。実際 ",
        math(String.raw`\prod_{z_i^L=1}z_i^{a}=\bigl((-1)^{L+1}\bigr)^{aL}`),
        " で、",
        math(String.raw`L(L+1)`),
        " は ",
        math(String.raw`L`),
        " の偶奇に依らず偶数だから値は ",
        math(String.raw`+1`),
        " である。よって以下 ",
        math(String.raw`P\in\mathbb{Z}[z_1,\dots,z_d]`),
        " としてよい。",
      ]),
    ],
  },
  {
    id: "paper_022_claim_resultant",
    kind: "claim",
    origin: { path: "structured-latex/content/002_setup.ts", ordinal: 3 },
    title: { text: "周期点数は入れ子の終結式で厳密に計算できる" },
    labels: ["paper_claim_resultant"],
    habitat: "Z",
    verification: [
      "sagemath/check/cycle14_T1_vp_two_var",
      "sagemath/check/cycle15_T1_monsky_shape",
    ],
    lean: [
      "IntegrableLattice.resultant_X_pow_char_pow_sub_one",
      "IntegrableLattice.aOne_cast_zmod",
      "IntegrableLattice.aTwo_cast_zmod",
    ],
    statement: [
      paragraph([
        ref("paper_def_aL"),
        " の ",
        math(String.raw`a_L`),
        " は入れ子の終結式として書ける。",
        math(String.raw`d=2`),
        " のとき",
      ]),
      displayMath(
        String.raw`a_L=\mathrm{Res}_{z}\Bigl(z^L-1,\ \mathrm{Res}_{w}\bigl(w^L-1,\ P(z,w)\bigr)\Bigr).`,
      ),
      paragraph([
        "一般の ",
        math(String.raw`d`),
        " でも終結式を ",
        math(String.raw`d`),
        " 回入れ子にすればよい。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`z^L-1`),
        " と ",
        math(String.raw`w^L-1`),
        " はモニックなので、終結式の標準性質 ",
        math(String.raw`\mathrm{Res}(f,g)=\mathrm{lc}(f)^{\deg g}\prod_{f(\alpha)=0}g(\alpha)`),
        " において ",
        math(String.raw`\mathrm{lc}(f)=1`),
        " となり、終結式が根での積そのものを与える。内側を ",
        math(String.raw`w`),
        " について、外側を ",
        math(String.raw`z`),
        " について適用すればよい。",
      ]),
      paragraph([
        "この表示は整数係数の有限計算である。",
        "ℝ",
        " も ",
        math(String.raw`\mathbb{Q}_p`),
        " も使わない。したがって任意の有限 ",
        math(String.raw`L`),
        " について ",
        math(String.raw`v_p(a_L)\in\mathbb{Z}_{\ge0}`),
        " は有限手続きで決定できる（終結式を厳密整数として計算し、素因数分解する）。",
      ]),
    ],
  },
  {
    id: "paper_023_definition_massieu",
    kind: "definition",
    origin: { path: "structured-latex/content/002_setup.ts", ordinal: 4 },
    title: { text: "Massieu 自由エントロピーの Λ 帰属" },
    labels: ["paper_def_massieu"],
    habitat: "Lambda",
    verification: ["sagemath/check/D_phi_lambda", "sagemath/check/potts_phi"],
    statement: [
      paragraph([
        "有限・離散な模型の分配関数を ",
        math(String.raw`Z_N(x)=\sum_m\Omega_N(m)x^m\in\mathbb{Z}[x]`),
        "（",
        math(String.raw`\Omega_N(m)\in\mathbb{N}`),
        " は多重度）とする。有理点 ",
        math(String.raw`q\in\mathbb{Q}_{>0}`),
        " でのMassieu 自由エントロピーを",
      ]),
      displayMath(String.raw`\Phi_N:=\log Z_N(q)\in\Lambda`),
      paragraph([
        "と定める。",
        math(String.raw`Z_N(q)\in\mathbb{Q}_{>0}`),
        " の素因数分解の指数ベクトルがそのまま ",
        math(String.raw`\Lambda`),
        " の元を与えるので、これは ",
        "ℝ",
        " を経由しない定義である。",
      ]),
      paragraph([
        "各量の住処は次のとおり。多重度 ",
        math(String.raw`\Omega_N(m)\in\mathbb{N}`),
        "、分配多項式 ",
        math(String.raw`Z_N\in\mathbb{Z}[x]`),
        "、",
        math(String.raw`\Phi_N\in\Lambda`),
        "、転送行列 ",
        math(String.raw`T(x)\in M_d(\mathbb{Z}[x])`),
        "、固有値と分配関数零点 ",
        math(String.raw`\in\overline{\mathbb{Q}}`),
        "。",
      ]),
    ],
  },
]);
