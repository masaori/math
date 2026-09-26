import { defineBlocks, paragraph, math, displayMath, ref } from "../schema.ts";

// 章「T_{V_1}(hat Z) と hat Z, hat Y の関係」の後半（文書順）。
// 収録範囲は parts/008 の 020〜031, 034, 035, 033, 032, 037, 044, 041, 042, 038, 039,
// 040, 043（文書順はソースのファイル名連番と一致しない）。並びが文書順の正準表現。
export default defineBlocks([
  {
    id: "TV1_hatZ_hatY_044_claim_critical_condition",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/043_claim_臨界条件_c1_eq_s1c2.typ",
      ordinal: 44,
    },
    title: { tex: String.raw`c_1 = s_1 c_2 \text{ は臨界条件 } s_1 s_2 = 1 \text{ と同値}` },
    labels: ["critical_condition_c1_eq_s1_c2"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号 ",
        math(String.raw`c_1 = \cosh 2K_1`),
        "、",
        math(String.raw`s_1 = \sinh 2K_1`),
        "、",
        math(String.raw`c_2 = \cosh 2K_2`),
        "、",
        math(String.raw`s_2 = \sinh 2K_2`),
        " について、",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " とする。このとき",
      ]),
      displayMath(String.raw`c_1 = s_1 c_2 \iff s_1 s_2 = 1`),
      paragraph([
        "すなわち ",
        math(String.raw`\cosh 2K_1 = \sinh 2K_1 \cosh 2K_2`),
        " であることと、Ising 模型の臨界条件 ",
        math(String.raw`\sinh 2K_1 \sinh 2K_2 = 1`),
        " であることは同値である。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 0: 所属集合と正値性。",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " より ",
        math(String.raw`2K_1, 2K_2 \in \mathbb{R}_{>0}`),
        " であり、",
        ref("cosh_sinh_basic_properties"),
        " (3) を ",
        math(String.raw`x = 2K_1`),
        "、",
        math(String.raw`x = 2K_2`),
        " に適用して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
c_1
&= \cosh 2K_1
&& (\because\ \text{記号の定義})\\
&> \sinh 2K_1
&& (\because\ 2K_1>0\ \text{における}\ \cosh x>\sinh x)\\
&= s_1
&& (\because\ \text{記号の定義})\\
&> 0
&& (\because\ 2K_1>0\ \text{における}\ \sinh x>0)\\[3pt]
c_2
&= \cosh 2K_2
&& (\because\ \text{記号の定義})\\
&> \sinh 2K_2
&& (\because\ 2K_2>0\ \text{における}\ \cosh x>\sinh x)\\
&= s_2
&& (\because\ \text{記号の定義})\\
&> 0
&& (\because\ 2K_2>0\ \text{における}\ \sinh x>0)
\end{aligned}`,
      ),
      paragraph([
        "特に ",
        math(String.raw`c_1, s_1, c_2, s_2 \in \mathbb{R}_{>0}`),
        "。また同 (2) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
c_1^2
&= 1+s_1^2
&& (\because\ \cosh^2 x-\sinh^2 x=1\ \text{を}\ x=2K_1\ \text{へ適用})\\
c_2^2
&= 1+s_2^2
&& (\because\ \cosh^2 x-\sinh^2 x=1\ \text{を}\ x=2K_2\ \text{へ適用})
\end{aligned}`,
      ),
      paragraph([
        "Step 1: ",
        math(String.raw`(\Rightarrow)`),
        " の証明。",
        math(String.raw`c_1 = s_1 c_2`),
        " と仮定する。両辺は正の実数（",
        math(String.raw`s_1 c_2 > 0`),
        "）である。まず両辺を 2 乗して Step 0 の 2 式を代入すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
c_1^2
&= (s_1 c_2)^2
   \quad (\because\ c_1 = s_1 c_2\ \text{（仮定）}) \\
&= s_1^2 c_2^2
   \quad (\because\ \text{積の 2 乗は 2 乗の積}) \\
&= s_1^2 (1 + s_2^2)
   \quad (\because\ \text{Step 0 の } c_2^2 = 1 + s_2^2) \\
&= s_1^2 + s_1^2 s_2^2
   \quad (\because\ \text{分配則})
\end{aligned}`,
      ),
      paragraph(["が成り立つ。この両辺から ", math(String.raw`s_1^2`), " を引くと"]),
      displayMath(
        String.raw`\begin{aligned}
(s_1 s_2)^2
&= s_1^2 s_2^2
   \quad (\because\ \text{積の 2 乗は 2 乗の積}) \\
&= c_1^2 - s_1^2
   \quad (\because\ \text{上の等式の両辺から } s_1^2 \text{ を引く}) \\
&= (1 + s_1^2) - s_1^2
   \quad (\because\ \text{Step 0 の } c_1^2 = 1 + s_1^2) \\
&= 1
   \quad (\because\ \text{加法逆元の相殺})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
s_1s_2>0\ \land\ 1>0\ \land\ (s_1s_2)^2=1^2
&\Longrightarrow s_1s_2=1
&& (\because\ \text{正の実数の二乗の一意性、}\blkref{cosh_sinh_basic_properties}\text{ (4)})
\end{aligned}`,
      ),
      paragraph([
        "Step 2: ",
        math(String.raw`(\Leftarrow)`),
        " の証明。",
        math(String.raw`s_1 s_2 = 1`),
        " と仮定する。Step 0 の 2 式より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(s_1 c_2)^2
&= s_1^2 c_2^2
   \quad (\because\ \text{積の 2 乗は 2 乗の積}) \\
&= s_1^2 (1 + s_2^2)
   \quad (\because\ \text{Step 0 の } c_2^2 = 1 + s_2^2) \\
&= s_1^2 + s_1^2 s_2^2
   \quad (\because\ \text{分配則}) \\
&= s_1^2 + (s_1 s_2)^2
   \quad (\because\ \text{積の 2 乗は 2 乗の積}) \\
&= s_1^2 + 1
   \quad (\because\ s_1 s_2 = 1\ \text{（仮定）と } 1^2 = 1) \\
&= c_1^2
   \quad (\because\ \text{Step 0 の } c_1^2 = 1 + s_1^2)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
s_1c_2>0\ \land\ c_1>0\ \land\ (s_1c_2)^2=c_1^2
&\Longrightarrow s_1c_2=c_1
&& (\because\ \text{正の実数の二乗の一意性、}\blkref{cosh_sinh_basic_properties}\text{ (4)})
\end{aligned}`,
      ),
      paragraph([
        "以上で ",
        math(String.raw`c_1 = s_1 c_2 \iff s_1 s_2 = 1`),
        " が示された。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（043_claim_臨界条件_c1_eq_s1c2.typ）の proof は TODO（未完成）であり、証明は本リポジトリで新規に構成した。",
        "証明は cosh^2 - sinh^2 = 1 と正値性のみを使う初等的なもので、平方根を経由せずに" +
          "「正の実数について a^2 = b^2 ⟺ a = b」（labels: cosh_sinh_basic_properties (4)）で符号を確定させている。",
        "γ2 の零点と Ising 臨界点の対応（この claim の帰結）は数学的内容なので note ではなく statement に置いた。" +
          "その導出（gamma_2_theta_is_0 との接続）は proof の Step 3 に書いた。",
        "2026-08-13 の式変形統一で、Step 1 の積み重ねた等式列（根拠なし・最終行に等号 2 つ）を、" +
          "2 乗の代入の鎖と s_1^2 を引く鎖の二本の一行一等号の鎖へ分け、Step 2 の鎖の各行へ行末根拠を付けた。" +
          "内容は変えていない。",
        "2026-08-15 の式変形統一で、Step 0 の正値性と双曲線恒等式、および Step 3 の臨界条件への同値鎖を、一行一関係と行末根拠を持つ整列式へ開いた。内容は変えていない。",
        "2026-09-05 の式変形統一で、Step 1 と Step 2 の正の実数の二乗の一意性の適用を散文から含意式へ移し、適用行の末尾から根拠を参照する形へ揃えた。内容は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、statement 後半（γ2(θ_μ) の零点と臨界点の対応）と proof の Step 3 を参照用ノート（本文不採用の整数運動量の経路）へ移した。",
      ],
    },
  },
]);
