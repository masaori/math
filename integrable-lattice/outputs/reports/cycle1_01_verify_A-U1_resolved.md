# cycle 1 step 1 — verify: A-U1 の resolved-risk 確認

対象候補: `A-U1-finite-N-fisher-zeros-qqbar`（有限 N 可積分模型の Fisher 零点の厳密 ℚ̄ 軌跡）。
目的: 「有限 N 零点を ℚ̄ の厳密対象として扱う」可算再定式化がどこまで既出か（06「未踏＝差分」の精査）。

## 確認結果（一次情報）

- **既出（標準）**:
  - 有限格子 Ising の分配関数を**整数係数多項式** $Z_N(x)\in\mathbb{Z}[x]$ として厳密計算する手法は標準（Kaufman/Beale 系、exact integer coefficients）。誤差なし。
  - その零点を**任意精度で数値的に厳密計算**する研究は多数（cond-mat/9707072「exact partition function zeros for large lattice sizes」, FOCS 2017「The Ising Partition Function: Zeros and Deterministic Approximation」）。
  - 計算限界も既知（L≳16 で整数巨大化）。
- **未踏寄り（差分）**:
  - 検索の明示所見: 既存研究は**数値・計算的側面**が中心で、**最小多項式・円分体上の代数的構造・代数的数論的側面**は特に扱っていない。
  - すなわち「零点 ∈ ℚ̄ を最小多項式 witness・決定可能性・形式検証（F）・逆数学 calibration として述べる」部分は手薄。

## 正直な判定（筋への影響）

- **A-U1 の数学的内容は本質的に既知**。「整数係数多項式の根は代数的（∈ℚ̄）で厳密計算可能」は**ほぼ自明な再言**で、新しい格子模型の結果ではない。
- 差分は **数学的新規性ではなく、形式化・決定可能性・証明書（方向 F）と逆数学 calibration** にある。これは「格子模型の新定理」ではなく**基礎論・形式検証の寄与**。
- 含意: 束 `finite_N_decidable` のうち **A 単体は新規性が薄い**。価値が残るとすれば:
  - **C-U3**（Bethe 可解系の有限 N スペクトル∈ℚ̄）— 自由フェルミより非自明（Bethe 根は代数的だが構造は richer）。要・別途 resolved 確認。
  - **D-U2**（Z_N(q) の素因数構造の数論的内容）— 自明でない可能性。
  - **F**（形式検証・decide・witness）— 基礎論寄与としてなら価値。ただし「可積分格子の新結果」ではない。

## ステータス

A-U1: resolved-risk = **largely known（数学内容）/ formalization が差分**。novelty は F 側に寄る。
次: この判定は束全体の筋に関わるため、深掘り投資（sagemath/Lean）前にユーザー判断を仰ぐ（下記）。
