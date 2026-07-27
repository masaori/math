/**
 * セットアップ: 整数スペクトル曲線と、その二素点で測る量の定義。
 *
 * 出典は `outputs/paper-plans/002_R_Lambda_duality.md`（§2「中核命題の候補」と §3「帰属台帳」）。
 * この移設は転記であって、新しい数学の主張ではない。 企画書に書かれた定義文をそのまま
 * 構造化テキストへ移し、住処（可算／非可算）を型で宣言できる形にしてある。
 *
 * 移していないもの（数学的判断が要るため）は
 * `integrable-lattice/docs/paper-001-migration-status.md` に列挙してある。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "setup_000_heading",
    kind: "heading",
    level: 1,
    sourcePath: "outputs/paper-plans/002_R_Lambda_duality.md",
    sourceOrdinal: 1,
    title: { text: "セットアップ: 整数スペクトル曲線と二素点の量" },
    labels: [],
    conversion: { status: "converted" },
  },
  {
    id: "setup_001_definition_spectral_curve",
    kind: "definition",
    sourcePath: "outputs/paper-plans/002_R_Lambda_duality.md",
    sourceOrdinal: 2,
    title: { text: "整数スペクトル曲線" },
    labels: ["def_spectral_curve"],
    habitat: "Z",
    statement: [
      paragraph([
        math(String.raw`d \geq 1`),
        " とし、",
        math(String.raw`P \in \mathbb{Z}[z_1^{\pm1},\dots,z_d^{\pm1}] \setminus \{0\}`),
        " を 整数スペクトル曲線 と呼ぶ。可積分格子模型では、整数転送行列 ",
        math(String.raw`T(z) \in M_{d_0}(\mathbb{Z}[z^{\pm1}])`),
        " に対し ",
        math(String.raw`P(z,w) = \det(w I - T(z))`),
        " として現れる。",
      ]),
      paragraph([
        "係数はすべて整数であり、この定義の中に極限も収束もない。",
        "以降の量はすべてこの ",
        math(String.raw`P`),
        " から作る。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "setup_002_definition_periodic_points",
    kind: "definition",
    sourcePath: "outputs/paper-plans/002_R_Lambda_duality.md",
    sourceOrdinal: 3,
    title: { text: "周期点数と簡約周期点数" },
    labels: ["def_periodic_points"],
    habitat: "Z",
    verification: ["sagemath/check/cycle5_T1_mahler"],
    statement: [
      paragraph([
        ref("def_spectral_curve"),
        " の ",
        math(String.raw`P`),
        " と ",
        math(String.raw`L \geq 1`),
        " に対し、「簡約周期点数」を",
      ]),
      displayMath(
        String.raw`a^{\mathrm{red}}_L := \prod_{\substack{z_i^{L}=1 \\ P(z) \neq 0}} P(z_1,\dots,z_d) \in \mathbb{Z}`,
      ),
      paragraph([
        "と定める（",
        math(String.raw`P`),
        " の零点となる因子を除いた積）。",
        math(String.raw`P`),
        " が単位トーラス上に零点をもたなければ、これは通常の周期点数 ",
        math(String.raw`a_L`),
        " に一致する。",
      ]),
      paragraph([
        "値は整数であり、",
        math(String.raw`d`),
        " 重の終結式で厳密に計算できる（有限手続き）。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "setup_003_definition_massieu",
    kind: "definition",
    sourcePath: "outputs/paper-plans/002_R_Lambda_duality.md",
    sourceOrdinal: 4,
    title: { tex: String.raw`\text{Massieu 自由エントロピーと } \Lambda \text{ 上の測り方}` },
    labels: ["def_massieu_phi"],
    habitat: "Lambda",
    statement: [
      paragraph([
        "対数順序群 ",
        math(String.raw`\Lambda = \bigoplus_p \mathbb{Z}\,\ell_p`),
        "（",
        math(String.raw`p`),
        " は素数を走り、",
        math(String.raw`\ell_p`),
        " は形式的な生成元）を係数域として、有限サイズの Massieu 自由エントロピー を",
      ]),
      displayMath(String.raw`\Phi_L := \log|a^{\mathrm{red}}_L| = \sum_p v_p(a^{\mathrm{red}}_L)\, \ell_p \in \Lambda`),
      paragraph([
        "と定める。ここで ",
        math(String.raw`v_p`),
        " は ",
        math(String.raw`p`),
        " 進付値である。",
        math(String.raw`\Lambda`),
        " 上では等号は素因数分解の一致、順序は整数の比較であり、いずれも有限手続きで判定できる。",
      ]),
      paragraph([
        "本稿が ",
        math(String.raw`\Lambda`),
        " 上で行う操作は ",
        math(String.raw`\ell_p`),
        " の整数係数線形結合の等号・順序比較だけである（",
        math(String.raw`\ell_p \ell_q`),
        " のような積は現れない）。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "setup_004_definition_vp_decidable",
    kind: "definition",
    sourcePath: "outputs/paper-plans/002_R_Lambda_duality.md",
    sourceOrdinal: 5,
    title: { tex: String.raw`p \text{ 素点の係数と、その有限手続き}` },
    labels: ["def_vp_finite_procedure"],
    habitat: "Z",
    verification: ["sagemath/check/cycle6_T1_padic_mahler"],
    statement: [
      paragraph([
        ref("def_massieu_phi"),
        " の係数 ",
        math(String.raw`v_p(a^{\mathrm{red}}_L) \in \mathbb{Z}_{\geq 0}`),
        " は、任意の素数 ",
        math(String.raw`p`),
        " と任意の ",
        math(String.raw`L`),
        " について、整数上の有限手続きで計算できる: ",
        math(String.raw`d`),
        " 重の終結式で厳密な整数を得てから素因数分解すればよい。",
      ]),
      paragraph([
        "この手続きに完備体は現れない。",
        "つまり ",
        math(String.raw`p`),
        " 素点側の有限 ",
        math(String.raw`L`),
        " の主張は、可算な対象の中で閉じている。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "setup_005_definition_period_pi",
    kind: "definition",
    sourcePath: "outputs/paper-plans/002_R_Lambda_duality.md",
    sourceOrdinal: 6,
    title: { tex: String.raw`\text{行列冪の周期 } \pi(p,k)` },
    labels: ["def_period_pi"],
    habitat: "Z",
    verification: ["sagemath/check/cycle3_T1_period_bound"],
    statement: [
      paragraph([
        math(String.raw`T \in M_d(\mathbb{Z})`),
        "、素数 ",
        math(String.raw`p`),
        "、切断 ",
        math(String.raw`k \geq 1`),
        " に対し、",
        math(String.raw`\pi(p,k)`),
        " を ",
        math(String.raw`T^N \bmod p^k`),
        " の ",
        math(String.raw`N`),
        " についての最終周期と定める。",
      ]),
      paragraph([
        math(String.raw`M_d(\mathbb{Z}/p^k)`),
        " は有限モノイドなので、",
        math(String.raw`\pi(p,k)`),
        " は有限であり、その値は有限探索で決定できる。",
      ]),
    ],
    conversion: { status: "converted" },
  },
]);
