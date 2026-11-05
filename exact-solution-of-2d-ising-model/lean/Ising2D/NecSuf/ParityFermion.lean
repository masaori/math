/-
# パリティ演算子とフェルミオン（**必要十分版**）

対応する人手証明のラベル（正本は `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`。
具体版は `Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/` と `Ising2D/ThermodynamicLimit/ColumnLimitAndClosedForm/`）:

- `epsilon_anticommutes_with_check_Z_Y` (2) → `Ising2D.NecSuf.anticomm_sum_smul`、(3) → `NecSuf.anticomm_add_smul`
- `epsilon_anticommutes_with_check_Z_Y` (4) → `Ising2D.NecSuf.commute_parity_num`（`ň_μ` の 3 行）/
  `NecSuf.commute_sub_of_commute'`・`NecSuf.commute_defFactor_of_commute'`（`A_ν` の鎖）/
  `NecSuf.commute_parity_finProdLeft_defFactor`（`Q̌_ε` の 3 行）。添字を `Finset` で取る `Q_ε` の形は `NecSuf.commute_parity_projOn`
- `epsilon_eigenvalue_on_check_Q` (2) の冒頭・Step 1・Step 2 の後半・Step 3 の数ベクトルの鎖 → `NecSuf/SignReversalOnGeneratorVector.lean`。
  (2) Step 2 冒頭の `ň_μψ̌_μ^† = ψ̌_μ^†` の 13 行 → `NecSuf.num_mul_cre'`。本ファイルの `NecSuf.projOn_insert_mul_cre` /
  `NecSuf.cre_mul_projOn_ne_zero` は (2) と同じ結論を行列 `c_μQ_T` の上の別の手順で出すもので、人手との対応には数えない
  （1 次元性が要らないことの別証として残す）
- `trace_of_epsilon_V_plus_via_check_eigenvalues` Step 2 →
  `Ising2D.NecSuf.sum_powerset_signed_exp`

## この主張に本質的に効いている構造（＝具体版が過剰な構造を要求していないかの検査結果）

1. **`ε` が `n_μ` と可換であること**（人手証明 (4) 前半）に効いているのは、
   **`ε` が生成・消滅演算子の両方と反交換すること**と、積の結合則、符号反転が積の因子から外へ出ること、
   符号反転を二回すると元に戻ること（`Semigroup`・`HasDistribNeg`）だけである。加法・零・単位元は効かない。
   `ε = σ^x_1⋯σ^x_M` であることも、`ψ̌` が `Ž, Y̌` の 1 次結合であることも、
   行列であることも、複素数であることも、テンソル冪であることも効いていない。
   **`ε` が `Q̌_ε` と可換であること**（同 (4) 後半）には、これに加えて、`1` が積の単位元であること、
   分配則、差が和と符号反転で書けること（`x − y = x + (−y)`）、積が各因子について `𝕜` 倍と交換することが効く。
   加法の零・結合則・可換性・逆元則、`Q̌_ε` の因子の係数 `ε_ν`・`1 − ε_ν` の関係、`n_μ` の冪等性は効かない。

2. **符号の反転則**（人手証明 (2)）に効いているのは、次の 3 つだけである。
   - `Q_{T∪{μ}} (c_μ Q_T) = c_μ Q_T`（人手証明 Step 2）— これは
     **`n_μ c_μ = c_μ`** と **`n_ν`（`ν ≠ μ`）が `c_μ` と可換**なことから、
     環の計算だけで出る。`n_μ c_μ = c_μ` そのもの（`num_mul_cre'`）には、`a_μc_μ = 1 − n_μ` と `c_μc_μ = 0` に加えて、
     積の結合則と右単位元、左分配則、`HasDistribNeg`、`x − y = x + (−y)`、`0x = 0`、`x − 0 = x` だけが効く。
   - `c_μ Q_T ≠ 0`（人手証明 Step 1）— これは **`a_μ c_μ = 1 - n_μ`** と
     `n_μ Q_T = 0`（`μ ∉ T`）から出る。**1 次元性は要らない。**
   - `ε (c_μ Q_T) = -η_T (c_μ Q_T)`（人手証明 Step 3）— 反交換関係だけ。
   すなわち**人手証明が「`im Q̌_ε` は 1 次元だから」と言っている部分のうち、
   符号の反転則に 1 次元性が効いているのは「`η_{ε'}` が存在すること」だけ**であり、
   反転則そのものは 1 次元性なしで出る。

3. **`tr(εV^{(+)})` の積への分解**（人手証明 Step 2）に効いているのは、
   有限集合の冪集合にわたる和の積への変形（`Finset.prod_add`）と、
   `sinh x = (e^x - e^{-x})/2` だけである。`γ` が `arccosh` で書けることも、
   `V^{(+)}` が転送行列であることも、`Λ̌_ε` が固有値であることも効いていない。

## 1 次元性（`η_ε` の存在）について

`ε Q̌_ε = η_ε Q̌_ε` の**存在**は `im Q̌_ε` が 1 次元であることを使うので、
台が行列環であることが本質的である。したがって存在の部分は具体版
（`Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimEpsilonEigenvalueOnCheckQ.lean`）にしか置かない。
本ファイルにはスカラーの一意性（`NecSuf.smul_left_cancel_of_ne_zero`）だけを置く。
-/
import Ising2D.NecSuf.JointEigenspace
import Ising2D.NecSuf.CommuteWithAnticommutingProductAndScalarMultiple
import Ising2D.NecSuf.FiniteProductCommute
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

set_option linter.unusedSectionVars false

namespace Ising2D.NecSuf

open Finset

/-! ## 0. 反交換は 1 次結合へ引き継がれる（人手証明
`epsilon_anticommutes_with_check_Z_Y` (2)(3) の鎖） -/

section Lincomb

variable {𝕜 : Type*} {A : Type*} [NonUnitalNonAssocRing A] [DistribSMul 𝕜 A]
  [SMulCommClass 𝕜 A A] [IsScalarTower 𝕜 A A] {ι : Type*}

/-- `e` が各 `x_i` と反交換なら、`x_i` の任意の有限 `𝕜` 線型結合とも反交換。

**人手証明 (2) の必要十分版**。calc の 7 段は、具体版 `Ising2D.epsilon_anticomm_phase_sum`
（人手の `(W̌_μ, W)` の鎖の 2〜8 行目）の 7 段と同じ順に並ぶ:
有限和への左からの分配・スカラー倍を右因子から外へ・仮定 `hx`（人手の (1)）・
`c(−A) = −(cA)`・スカラー倍を左因子へ・有限和と符号反転の交換・有限和への右からの分配の逆。

効いているのは**積が各因子について `𝕜` 倍と交換すること**（`SMulCommClass`・`IsScalarTower`）、
`𝕜` の作用が `A` の加法を保ち符号反転と交換すること（`DistribSMul`）、`A` の加法が可換群で積が和に分配すること
（`NonUnitalNonAssocRing`）だけである。`𝕜` には構造を何も仮定しない: `𝕜` の積と単位元（作用則 `mul_smul`・
`one_smul`）、加法と可換性はどの段にも出ない。`A` の積の結合律と単位元、`A` が `𝕜`-代数であること
（`algebraMap`）、行列であること、添字集合が `{1,…,M_col}` であることも効いていない。
各段は環と作用の基本性質（mathlib の補題）の 1 回の適用で、主張そのものを既製の定理へ委ねてはいない。 -/
theorem anticomm_sum_smul {e : A} {x : ι → A} (hx : ∀ i, e * x i = -(x i * e))
    (s : Finset ι) (f : ι → 𝕜) :
    e * (∑ i ∈ s, f i • x i) = -((∑ i ∈ s, f i • x i) * e) := by
  calc e * (∑ i ∈ s, f i • x i)
      = ∑ i ∈ s, e * (f i • x i) := Finset.mul_sum _ _ _
                                  -- `finite_sum_of_matrices_distributes_in_right_factor` にあたる
    _ = ∑ i ∈ s, f i • (e * x i) := Finset.sum_congr rfl fun i _ => mul_smul_comm _ _ _
                                  -- `scalar_multiple_factors_out_of_right_factor` にあたる
    _ = ∑ i ∈ s, f i • (-(x i * e)) := Finset.sum_congr rfl fun i _ => by rw [hx i]
                                  -- 人手の (1)
    _ = ∑ i ∈ s, -(f i • (x i * e)) := Finset.sum_congr rfl fun i _ => smul_neg _ _
                                  -- `scalar_multiple_of_negated_matrix` にあたる
    _ = ∑ i ∈ s, -((f i • x i) * e) := Finset.sum_congr rfl fun i _ => by rw [smul_mul_assoc]
                                  -- `scalar_multiple_factors_out_of_left_factor` にあたる
    _ = -∑ i ∈ s, (f i • x i) * e := Finset.sum_neg_distrib _
                                  -- `finite_sum_of_negated_matrices` にあたる
    _ = -((∑ i ∈ s, f i • x i) * e) := by rw [Finset.sum_mul]
                                  -- `finite_sum_of_matrices_distributes_in_left_factor` にあたる

/-- `e` が `x`・`y` と反交換なら、`p x + q y` とも反交換。

**人手証明 (3) の必要十分版**。calc の 7 段は、具体版 `Ising2D.epsilon_anticomm_two_term`
（人手の `(Ψ, p, q)` の鎖の 2〜8 行目）の 7 段と同じ順に並ぶ:
和への左からの分配・スカラー倍を右因子から外へ・仮定 `hx`・`hy`（人手の (2)）・`c(−A) = −(cA)`・
スカラー倍を左因子へ・符号反転の和への分配を右辺から左辺へ・和への右からの分配の逆。

効いている構造は `anticomm_sum_smul` と同じである。`𝕜` の構造、`A` の積の結合律と単位元、
`x`・`y` が `Ž_μ`・`Y̌_μ` であることは効いていない。符号反転の和への分配 `−(a + b) = −a + −b` には
`A` の加法の可換性が効く（`NonUnitalNonAssocRing` の加法は可換群）。 -/
theorem anticomm_add_smul {e x y : A} (hx : e * x = -(x * e)) (hy : e * y = -(y * e)) (p q : 𝕜) :
    e * (p • x + q • y) = -((p • x + q • y) * e) := by
  calc e * (p • x + q • y)
      = e * (p • x) + e * (q • y) := mul_add _ _ _
                                  -- `mat_mult_distributes_over_sum_in_right_factor` にあたる
    _ = p • (e * x) + q • (e * y) := by rw [mul_smul_comm, mul_smul_comm]
                                  -- `scalar_multiple_factors_out_of_right_factor` にあたる
    _ = p • (-(x * e)) + q • (-(y * e)) := by rw [hx, hy]
                                  -- 人手の (2)
    _ = (-(p • (x * e))) + (-(q • (y * e))) := by rw [smul_neg, smul_neg]
                                  -- `scalar_multiple_of_negated_matrix` にあたる
    _ = (-((p • x) * e)) + (-((q • y) * e)) := by rw [smul_mul_assoc, smul_mul_assoc]
                                  -- `scalar_multiple_factors_out_of_left_factor` にあたる
    _ = -((p • x) * e + (q • y) * e) := (neg_add _ _).symm
                                  -- `negation_distributes_over_matrix_sum` を右辺から左辺へ にあたる
    _ = -((p • x + q • y) * e) := by rw [add_mul]
                                  -- `mat_mult_distributes_over_sum_in_left_factor` にあたる

end Lincomb

/-! ## 1. `ε` は個数演算子と可換（人手証明 `epsilon_anticommutes_with_check_Z_Y` (4)） -/

section ParityNum

variable {A : Type*} [Semigroup A] [HasDistribNeg A] {ι : Type*}

/-- **人手証明 (4) の前半の必要十分版**: `ε` が `c_i`, `a_i` の両方と反交換なら
`ε` は `n_i = c_i a_i` と可換。具体版 `Ising2D.CheckFermi.commute_epsilon_nOp` の 3 行（`def_check_number_operator`・
`product_of_anticommuting_matrices_commutes`・`def_check_number_operator`）と同じ並びで、2 行目は
`NecSuf.commute_mul_of_anticomm'`（人手 `product_of_anticommuting_matrices_commutes` の 8 行と同じ 8 段）である。
効いているのは反交換関係 2 本と、積の結合則・符号反転が積の因子から外へ出ること・二重の符号反転だけで、
仮定もそれだけにした（`Semigroup`・`HasDistribNeg`。`num` の定義には積だけが要る）。 -/
theorem commute_parity_num (c a : ι → A) {e : A} {i : ι}
    (hc : e * c i = -(c i * e)) (ha : e * a i = -(a i * e)) :
    Commute e (num c a i) := by
  show e * num c a i = num c a i * e
  calc e * num c a i
      = e * (c i * a i) := rfl                          -- `def_check_number_operator` にあたる
    _ = (c i * a i) * e := commute_mul_of_anticomm' hc ha
                                                        -- `product_of_anticommuting_matrices_commutes` にあたる
    _ = num c a i * e := rfl                            -- `def_check_number_operator` にあたる

end ParityNum


section Parity

variable {A : Type*} [Ring A] {ι : Type*} [DecidableEq ι]

/-- **人手証明 (4) の後半の必要十分版**: `ε` は `Q_ε` とも可換。 -/
theorem commute_parity_projOn (c a : ι → A) {e : A}
    (hn : ∀ i j, Commute (num c a i) (num c a j))
    (hc : ∀ i, e * c i = -(c i * e)) (ha : ∀ i, e * a i = -(a i * e)) (s T : Finset ι) :
    Commute e (projOn (num c a) hn s T) :=
  commute_projOn (n := num c a) (hn := hn) fun i _ => commute_parity_num c a (hc i) (ha i)

end Parity

/-! ## 1'. `ε` は `Q̌_ε` の因子 `A_ν` と有限積 `Q̌_ε` とも可換（人手証明 `epsilon_anticommutes_with_check_Z_Y` (4) の後半の鎖） -/

section CommuteSub

variable {A : Type*} [Mul A] [Add A] [LeftDistribClass A] [RightDistribClass A] [HasDistribNeg A] [Sub A]

/-- **`commuting_with_difference` の必要十分版（環の元）**: `GX = XG` かつ `GW = WG` なら `G(X − W) = (X − W)G`。
8 段は人手 `commuting_with_difference` の 8 行（具体版 `Ising2D.matrix_mul_sub_eq_sub_mul_of_commute`）と同じ並びである。
差は仮定 `hsub`（`x − y = x + (−y)`）でだけ使い、加法の零・結合則・可換性・逆元則は効かない。
積の結合則と単位元も効かないので、`Mul A` だけを仮定する。 -/
theorem commute_sub_of_commute' (hsub : ∀ x y : A, x - y = x + -y) {G X W : A}
    (hX : G * X = X * G) (hW : G * W = W * G) : G * (X - W) = (X - W) * G :=
  calc G * (X - W)
      = G * (X + -W) := by rw [hsub]                    -- `matrix_difference_is_sum_with_negation` にあたる
    _ = G * X + G * (-W) := mul_add _ _ _               -- `mat_mult_distributes_over_sum_in_right_factor` にあたる
    _ = X * G + G * (-W) := by rw [hX]                  -- 仮定 `GX = XG`
    _ = X * G + -(G * W) := by rw [mul_neg]             -- `negation_factors_out_of_right_factor` にあたる
    _ = X * G + -(W * G) := by rw [hW]                  -- 仮定 `GW = WG`
    _ = X * G + (-W) * G := by rw [neg_mul]             -- `negation_factors_out_of_left_factor` にあたる
    _ = (X + -W) * G := (add_mul _ _ _).symm            -- `mat_mult_distributes_over_sum_in_left_factor` にあたる
    _ = (X - W) * G := by rw [hsub]                     -- `matrix_difference_is_sum_with_negation` にあたる

end CommuteSub

section ParityFactor

variable {𝕜 : Type*} {A : Type*} [MulOneClass A] [Add A] [LeftDistribClass A] [RightDistribClass A]
  [HasDistribNeg A] [Sub A] [SMul 𝕜 A] [SMulCommClass 𝕜 A A] [IsScalarTower 𝕜 A A]

/-- **人手証明 (4) の `A_ν` の鎖の必要十分版**: `e n = n e` なら、`e` は `c n + d(1 − n)` と可換。
具体版 `Ising2D.CheckFermi.commute_epsilon_defFactor` と同じ並びで、`e·1 = 1·e` の 2 行、3 式
（`commuting_with_difference`・`commuting_with_scalar_multiple` 2 本）、`A_ν` の鎖（定義の行を除く 3 段）である。

人手の係数 `ε_ν`・`1 − ε_ν` を、ここでは無関係な二つのスカラー `c`・`d ∈ 𝕜` に置く。**`d = 1 − c` であることも、
`c ∈ {0, 1}` であることも効いていない**（`𝕜` には構造を何も仮定しない）。効いているのは、`1` が積の単位元であること、
差が和と符号反転で書けること、分配則、符号反転が積の因子から外へ出ること、積が各因子について `𝕜` 倍と交換することだけである。
`n` が個数演算子（冪等）であることは効いていない。 -/
theorem commute_defFactor_of_commute' (hsub : ∀ x y : A, x - y = x + -y) {e n : A}
    (hn : e * n = n * e) (c d : 𝕜) :
    e * (c • n + d • (1 - n)) = (c • n + d • (1 - n)) * e := by
  have h1 : e * 1 = 1 * e :=
    calc e * 1 = e := mul_one e                         -- `identity_matrix_is_right_unit_of_mat_mult` にあたる
      _ = 1 * e := (one_mul e).symm                     -- `identity_matrix_is_left_unit_of_mat_mult` にあたる
  have h2 : e * (1 - n) = (1 - n) * e := commute_sub_of_commute' hsub h1 hn
                                                        -- 3 式の 1 行目（`commuting_with_difference` にあたる）
  have h3 : e * (c • n) = (c • n) * e := commute_smul_of_commute' c hn
                                                        -- 3 式の 2 行目（`commuting_with_scalar_multiple` にあたる）
  have h4 : e * (d • (1 - n)) = (d • (1 - n)) * e := commute_smul_of_commute' d h2
                                                        -- 3 式の 3 行目（`commuting_with_scalar_multiple` にあたる）
  calc e * (c • n + d • (1 - n))
      = e * (c • n) + e * (d • (1 - n)) := mul_add _ _ _
                                                        -- `mat_mult_distributes_over_sum_in_right_factor` にあたる
    _ = (c • n) * e + (d • (1 - n)) * e := by rw [h3, h4]
                                                        -- 3 式の 2 行目と 3 行目を 2 項へ同時適用
    _ = (c • n + d • (1 - n)) * e := (add_mul _ _ _).symm
                                                        -- `mat_mult_distributes_over_sum_in_left_factor` にあたる

end ParityFactor

section ParityFactorProduct

variable {𝕜 : Type*} {A : Type*} [Monoid A] [Add A] [LeftDistribClass A] [RightDistribClass A]
  [HasDistribNeg A] [Sub A] [SMul 𝕜 A] [SMulCommClass 𝕜 A A] [IsScalarTower 𝕜 A A]

/-- **人手証明 (4) の後半の必要十分版**: `ε` が `c_ν`, `a_ν` の両方と反交換なら、`ε` は
`Q = ∏_{ν} (c'_ν n_ν + d'_ν(1 − n_ν))`（`n_ν = c_ν a_ν`、左から掛ける積）と可換。
具体版 `Ising2D.CheckFermi.commute_epsilon_Qproj_succ` の `Q̌_ε` の 3 行（定義の行を除く 1 段、
`matrix_commuting_with_each_factor_commutes_with_finite_product` にあたる `NecSuf.commute_finProdLeft`）と同じ並びである。
各因子との可換性は `commute_defFactor_of_commute'` と前半 `commute_mul_of_anticomm'` から出す。
有限積に効くのは積の結合則だけである。加法については分配則（`LeftDistribClass`・`RightDistribClass`）しか仮定しない（零・結合則・可換性は効かない）。 -/
theorem commute_parity_finProdLeft_defFactor (hsub : ∀ x y : A, x - y = x + -y) (r : ℕ)
    (c a : Fin (r + 1) → A) {e : A}
    (hc : ∀ ν, e * c ν = -(c ν * e)) (ha : ∀ ν, e * a ν = -(a ν * e)) (c' d' : Fin (r + 1) → 𝕜) :
    e * finProdLeft r (fun ν => c' ν • (c ν * a ν) + d' ν • (1 - c ν * a ν))
      = finProdLeft r (fun ν => c' ν • (c ν * a ν) + d' ν • (1 - c ν * a ν)) * e :=
  commute_finProdLeft r e _ fun ν =>
    commute_defFactor_of_commute' hsub (commute_mul_of_anticomm' (hc ν) (ha ν)) (c' ν) (d' ν)

end ParityFactorProduct

section NumMulCre

variable {A : Type*} [Monoid A] [Add A] [Zero A] [LeftDistribClass A] [HasDistribNeg A] [Sub A] {ι : Type*}

/-- **`n_i c_i = c_i` の必要十分版**（人手 `epsilon_eigenvalue_on_check_Q` (2) Step 2 冒頭の 13 行の鎖。
具体版 `Ising2D.CheckFermi.nOp_mul_cre` と同じ行である）。

効いているのは、`a_i c_i = 1 − n_i`（`check_number_operator_idempotent` (2)）と `c_i c_i = 0`（同 (1)）、積の結合則と単位元、
左分配則、符号反転が右の因子から外へ出ること、差が和と符号反転で書けること（`hsub`）、`0x = 0`（`hz`）、`x − 0 = x`（`hs0`）だけである。
加法の結合則・可換性・逆元則、右分配則、`x0 = 0`、`a_i` が `c_i` の随伴であること、反交換関係そのもの
（`a_i c_i = 1 − n_i` を導くのにだけ使う）は効いていない。 -/
theorem num_mul_cre' (hsub : ∀ x y : A, x - y = x + -y) (hz : ∀ x : A, 0 * x = 0) (hs0 : ∀ x : A, x - 0 = x)
    (c a : ι → A) (i : ι) (hac : a i * c i = 1 - num c a i) (hsq : c i * c i = 0) :
    num c a i * c i = c i :=
  calc num c a i * c i
      = (c i * a i) * c i := rfl                       -- `def_check_number_operator` にあたる
    _ = c i * (a i * c i) := mul_assoc _ _ _            -- `mat_mult_associative` にあたる
    _ = c i * (1 - num c a i) := by rw [hac]            -- `check_number_operator_idempotent` (2) にあたる
    _ = c i * (1 + -num c a i) := by rw [hsub]          -- `matrix_difference_is_sum_with_negation` にあたる
    _ = c i * 1 + c i * (-num c a i) := mul_add _ _ _   -- `mat_mult_distributes_over_sum_in_right_factor` にあたる
    _ = c i * 1 + -(c i * num c a i) := by rw [mul_neg] -- `negation_factors_out_of_right_factor` にあたる
    _ = c i * 1 - c i * num c a i := (hsub _ _).symm    -- `matrix_difference_is_sum_with_negation` にあたる
    _ = c i - c i * num c a i := by rw [mul_one]        -- `identity_matrix_is_right_unit_of_mat_mult` にあたる
    _ = c i - c i * (c i * a i) := rfl                  -- `def_check_number_operator` にあたる
    _ = c i - (c i * c i) * a i := by rw [mul_assoc]    -- `mat_mult_associative` にあたる
    _ = c i - 0 * a i := by rw [hsq]                    -- `check_number_operator_idempotent` (1) にあたる
    _ = c i - 0 := by rw [hz]                           -- `zero_matrix_is_left_zero_of_mat_mult` にあたる
    _ = c i := hs0 _                                    -- `matrix_minus_zero_matrix` にあたる

end NumMulCre

section Parity

variable {A : Type*} [Ring A] {ι : Type*} [DecidableEq ι]

/-- `n_i c_i = c_i`（人手証明 `epsilon_eigenvalue_on_check_Q` Step 2 冒頭）。上の 13 行の鎖 `num_mul_cre'` を環で使う
（`a_i c_i = 1 − n_i` は反交換関係から `ann_mul_cre` で出す）。 -/
theorem num_mul_cre (c a : ι → A) (i : ι) (hsq : c i * c i = 0)
    (hca : c i * a i + a i * c i = 1) : num c a i * c i = c i :=
  num_mul_cre' (fun x y => sub_eq_add_neg x y) (fun x => zero_mul x) (fun x => sub_zero x) c a i
    (ann_mul_cre c a i hca) hsq

end Parity

/-! ## 2. 符号の反転則（人手証明 `epsilon_eigenvalue_on_check_Q` (2)） -/

section Flip

variable {A : Type*} [Ring A] {ι : Type*} [DecidableEq ι]

/-- **人手証明 Step 2 の必要十分版**: `μ ∈ s`, `μ ∉ T` なら
`Q_{T∪{μ}} (c_μ Q_T) = c_μ Q_T`。

効いているのは `n_μ c_μ = c_μ` と「`ν ≠ μ` の `n_ν` は `c_μ` と可換」だけである。 -/
theorem projOn_insert_mul_cre (c a : ι → A)
    (hn : ∀ i j, Commute (num c a i) (num c a j))
    (hidem : ∀ i, num c a i * num c a i = num c a i)
    (hcn : ∀ i j, i ≠ j → Commute (c i) (num c a j))
    (hsq : ∀ i, c i * c i = 0) (hca : ∀ i, c i * a i + a i * c i = 1)
    {s T : Finset ι} {μ : ι} (hμs : μ ∈ s) (hμT : μ ∉ T) :
    projOn (num c a) hn s (insert μ T) * (c μ * projOn (num c a) hn s T)
      = c μ * projOn (num c a) hn s T := by
  classical
  -- `Q_T = (1 - n_μ) P'`
  have hQT : (1 - num c a μ) * projOn (num c a) hn (s.erase μ) T = projOn (num c a) hn s T := by
    have h : projFactor (num c a) T μ * projOn (num c a) hn (s.erase μ) T
        = projOn (num c a) hn s T := Finset.mul_noncommProd_erase _ hμs _ _
    rwa [projFactor_of_notMem hμT] at h
  -- `Q_{T ∪ {μ}} = n_μ P'`
  have hQT' : num c a μ * projOn (num c a) hn (s.erase μ) T
      = projOn (num c a) hn s (insert μ T) := by
    have h : projFactor (num c a) (insert μ T) μ
          * projOn (num c a) hn (s.erase μ) (insert μ T)
        = projOn (num c a) hn s (insert μ T) := Finset.mul_noncommProd_erase _ hμs _ _
    rw [projFactor_of_mem (Finset.mem_insert_self μ T)] at h
    have hcongr : projOn (num c a) hn (s.erase μ) (insert μ T)
        = projOn (num c a) hn (s.erase μ) T := by
      refine projOn_congr (n := num c a) (hn := hn) fun i hi => ?_
      have hiμ : i ≠ μ := Finset.ne_of_mem_erase hi
      simp [Finset.mem_insert, hiμ]
    rwa [hcongr] at h
  -- `c_μ` は `P'` と可換
  have hcP' : Commute (c μ) (projOn (num c a) hn (s.erase μ) T) :=
    commute_projOn (n := num c a) (hn := hn) fun i hi =>
      hcn μ i (fun h => (Finset.ne_of_mem_erase hi) h.symm)
  -- `P' Q_T = Q_T`
  have hP'Q : projOn (num c a) hn (s.erase μ) T * projOn (num c a) hn s T
      = projOn (num c a) hn s T := by
    have hcomm : Commute (projOn (num c a) hn (s.erase μ) T) (1 - num c a μ) :=
      (commute_projOn (n := num c a) (hn := hn) (x := 1 - num c a μ)
        (fun i _ => Commute.sub_left (Commute.one_left _) (hn μ i))).symm
    have hidem' : projOn (num c a) hn (s.erase μ) T * projOn (num c a) hn (s.erase μ) T
        = projOn (num c a) hn (s.erase μ) T := projOn_mul_self (n := num c a) (hn := hn) hidem _ _
    calc projOn (num c a) hn (s.erase μ) T * projOn (num c a) hn s T
        = projOn (num c a) hn (s.erase μ) T
            * ((1 - num c a μ) * projOn (num c a) hn (s.erase μ) T) := by rw [hQT]
      _ = ((1 - num c a μ) * projOn (num c a) hn (s.erase μ) T)
            * projOn (num c a) hn (s.erase μ) T := by rw [← mul_assoc, hcomm.eq]
      _ = (1 - num c a μ)
            * (projOn (num c a) hn (s.erase μ) T * projOn (num c a) hn (s.erase μ) T) := by
          rw [mul_assoc]
      _ = (1 - num c a μ) * projOn (num c a) hn (s.erase μ) T := by rw [hidem']
      _ = projOn (num c a) hn s T := hQT
  have hnc : num c a μ * c μ = c μ := num_mul_cre c a μ (hsq μ) (hca μ)
  calc projOn (num c a) hn s (insert μ T) * (c μ * projOn (num c a) hn s T)
      = (num c a μ * projOn (num c a) hn (s.erase μ) T) * (c μ * projOn (num c a) hn s T) := by
        rw [hQT']
    _ = num c a μ
          * ((projOn (num c a) hn (s.erase μ) T * c μ) * projOn (num c a) hn s T) := by
        simp only [mul_assoc]
    _ = num c a μ
          * ((c μ * projOn (num c a) hn (s.erase μ) T) * projOn (num c a) hn s T) := by
        rw [hcP'.symm.eq]
    _ = (num c a μ * c μ)
          * (projOn (num c a) hn (s.erase μ) T * projOn (num c a) hn s T) := by
        simp only [mul_assoc]
    _ = c μ * (projOn (num c a) hn (s.erase μ) T * projOn (num c a) hn s T) := by rw [hnc]
    _ = c μ * projOn (num c a) hn s T := by rw [hP'Q]

/-- **人手証明 Step 1 の必要十分版**: `μ ∈ s`, `μ ∉ T`, `Q_T ≠ 0` なら `c_μ Q_T ≠ 0`。

**1 次元性は使わない。** 効いているのは `a_μ c_μ = 1 - n_μ` と `n_μ Q_T = 0` だけである。 -/
theorem cre_mul_projOn_ne_zero (c a : ι → A)
    (hn : ∀ i j, Commute (num c a i) (num c a j))
    (hidem : ∀ i, num c a i * num c a i = num c a i)
    (hca : ∀ i, c i * a i + a i * c i = 1)
    {s T : Finset ι} {μ : ι} (hμs : μ ∈ s) (hμT : μ ∉ T)
    (hQ : projOn (num c a) hn s T ≠ 0) :
    c μ * projOn (num c a) hn s T ≠ 0 := by
  classical
  have hnQ : num c a μ * projOn (num c a) hn s T = 0 := by
    rw [num_mul_projOn (n := num c a) (hn := hn) hidem hμs, if_neg hμT, zero_mul]
  have hac : a μ * c μ = 1 - num c a μ := ann_mul_cre c a μ (hca μ)
  have key : a μ * (c μ * projOn (num c a) hn s T) = projOn (num c a) hn s T := by
    calc a μ * (c μ * projOn (num c a) hn s T)
        = (a μ * c μ) * projOn (num c a) hn s T := by rw [mul_assoc]
      _ = (1 - num c a μ) * projOn (num c a) hn s T := by rw [hac]
      _ = projOn (num c a) hn s T - num c a μ * projOn (num c a) hn s T := by noncomm_ring
      _ = projOn (num c a) hn s T := by rw [hnQ, sub_zero]
  intro h
  rw [h, mul_zero] at key
  exact hQ key.symm

end Flip

/-! ## 2a. 可換な因子の積と射影（人手証明 `epsilon_eigenvalue_on_check_Q` (4)） -/

section NoncommProdSmul

variable {𝕜 : Type*} [CommSemiring 𝕜] {A : Type*} [Ring A] [Algebra 𝕜 A] {ι : Type*}
  [DecidableEq ι]

/-- 各因子が `Q` に対してスカラー倍として働くなら、積も働く:
`g_i Q = c_i Q` （すべての `i`）⇒ `(∏_{i∈s} g_i) Q = (∏_{i∈s} c_i) Q`。

効いているのは結合律とスカラー倍の両立則だけである。 -/
theorem noncommProd_mul_of_mul_eq_smul (g : ι → A) (comm : ∀ i j, Commute (g i) (g j))
    (Q : A) (c : ι → 𝕜) (h : ∀ i, g i * Q = c i • Q) (s : Finset ι) :
    s.noncommProd g (fun i _ j _ _ => comm i j) * Q = (∏ i ∈ s, c i) • Q := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | insert j s hj ih =>
      rw [Finset.noncommProd_insert_of_notMem _ _ _ _ hj, Finset.prod_insert hj, mul_assoc, ih,
        mul_smul_comm, h j, smul_smul, mul_comm]

end NoncommProdSmul

/-! ## 2b. `Q_ε` のエルミート性（人手証明 `check_number_operator_is_hermitian` (4)） -/

section Star

variable {A : Type*} [Ring A] [StarRing A] {ι : Type*} [DecidableEq ι]

/-- **人手証明 `check_number_operator_is_hermitian` (4) の必要十分版**:
`n_i` がすべて自己共役なら `Q_ε` も自己共役。

効いているのは **`star` が反自己同型であること**と、**因子が互いに可換**なことだけである。 -/
theorem star_projOn (n : ι → A) (hn : ∀ i j, Commute (n i) (n j))
    (hstar : ∀ i, star (n i) = n i) (s T : Finset ι) :
    star (projOn n hn s T) = projOn n hn s T := by
  classical
  have hfac : ∀ i, star (projFactor n T i) = projFactor n T i := by
    intro i
    unfold projFactor
    split
    · exact hstar i
    · rw [star_sub, star_one, hstar i]
  induction s using Finset.induction_on with
  | empty => simp
  | insert j s hj ih =>
      have hcomm : Commute (projFactor n T j) (projOn n hn s T) :=
        Finset.noncommProd_commute _ _ _ _ fun i _ => commute_projFactor hn T T j i
      rw [projOn_insert (n := n) (hn := hn) hj, star_mul, ih, hfac j, hcomm.eq]

end Star

/-! ## 3. スカラーの一意性 -/

section Scalar

variable {𝕜 : Type*} [Field 𝕜] {A : Type*} [AddCommGroup A] [Module 𝕜 A]
  [NoZeroSMulDivisors 𝕜 A]

/-- `x ≠ 0` なら `η • x = η' • x ⇒ η = η'`（人手証明 (1) の「一意に定まる」）。 -/
theorem smul_left_cancel_of_ne_zero {x : A} (hx : x ≠ 0) {η η' : 𝕜} (h : η • x = η' • x) :
    η = η' := by
  have hz : (η - η') • x = 0 := by rw [sub_smul, h, sub_self]
  rcases smul_eq_zero.1 hz with h' | h'
  · exact sub_eq_zero.1 h'
  · exact absurd h' hx

end Scalar

/-! ## 4. 符号つき和の積への分解（人手証明
`trace_of_epsilon_V_plus_via_check_eigenvalues` Step 2） -/

section SignedSum

variable {ι : Type*} [DecidableEq ι]

/-- **人手証明 Step 2 の必要十分版**:

  `∑_{T ⊆ s} (-1)^{|s|-|T|} exp(∑_{i∈s} g_i (1_{i∈T} - 1/2)) = ∏_{i∈s} 2 sinh(g_i/2)`

効いているのは有限積の展開（`Finset.prod_add`）と `sinh x = (e^x - e^{-x})/2` だけで、
`g` が `arccosh` で書けることも、転送行列も、固有値も効いていない。 -/
theorem sum_powerset_signed_exp (s : Finset ι) (g : ι → ℝ) :
    ∑ T ∈ s.powerset,
        ((-1 : ℝ) ^ (s.card - T.card)
          * Real.exp (∑ i ∈ s, g i * ((if i ∈ T then (1 : ℝ) else 0) - 1 / 2)))
      = ∏ i ∈ s, (2 * Real.sinh (g i / 2)) := by
  classical
  have hfac : ∀ T ∈ s.powerset,
      ((-1 : ℝ) ^ (s.card - T.card)
          * Real.exp (∑ i ∈ s, g i * ((if i ∈ T then (1 : ℝ) else 0) - 1 / 2)))
        = (∏ i ∈ T, Real.exp (g i / 2)) * ∏ i ∈ s \ T, (-Real.exp (-(g i / 2))) := by
    intro T hT
    have hTs : T ⊆ s := Finset.mem_powerset.1 hT
    -- 指数の和を `T` と `s \ T` に分ける
    have hsplit : ∑ i ∈ s, g i * ((if i ∈ T then (1 : ℝ) else 0) - 1 / 2)
        = (∑ i ∈ T, g i / 2) + ∑ i ∈ s \ T, -(g i / 2) := by
      rw [← Finset.sum_sdiff hTs]
      have h1 : ∀ i ∈ T, g i * ((if i ∈ T then (1 : ℝ) else 0) - 1 / 2) = g i / 2 := by
        intro i hi; rw [if_pos hi]; ring
      have h2 : ∀ i ∈ s \ T, g i * ((if i ∈ T then (1 : ℝ) else 0) - 1 / 2) = -(g i / 2) := by
        intro i hi
        rw [if_neg (Finset.mem_sdiff.1 hi).2]; ring
      rw [Finset.sum_congr rfl h1, Finset.sum_congr rfl h2]
      ring
    rw [hsplit, Real.exp_add, Real.exp_sum, Real.exp_sum]
    have hneg : ∏ i ∈ s \ T, (-Real.exp (-(g i / 2)))
        = (-1 : ℝ) ^ (s \ T).card * ∏ i ∈ s \ T, Real.exp (-(g i / 2)) := by
      rw [← Finset.prod_const, ← Finset.prod_mul_distrib]
      exact Finset.prod_congr rfl fun i _ => by ring
    have hcard : (s \ T).card = s.card - T.card := by
      rw [Finset.card_sdiff, Finset.inter_eq_left.2 hTs]
    rw [hneg, hcard]
    ring
  rw [Finset.sum_congr rfl hfac]
  rw [← Finset.prod_add]
  refine Finset.prod_congr rfl fun i _ => ?_
  rw [Real.sinh_eq]
  ring

end SignedSum

end Ising2D.NecSuf
