/-
# 先頭から並べたサイトの Pauli 行列の積のクロネッカー積表示（**具体版**）

対応する人手証明のラベル: `site_pauli_prefix_product_kronecker_form`
（`structured-latex/content/partition_function_projection_and_jordan_wigner.ts` の
`projection_claim_site_pauli_prefix_product_kronecker_form`）。
同じファイルで、Lean の `Z`・`Y`（クロネッカー積 `siteProd` で定義）が人手の定義
`def_jordan_wigner_Z_matrices`・`def_jordan_wigner_Y_matrices` の行列の有限積 `∏_{j=1}^{m}F_j^{(z)}`・`∏_{j=1}^{m}F_j^{(y)}`
（因子 `F_j^{(z)}`・`F_j^{(y)}` と積の読み方は同じ 2 つの定義が定める）に等しいことを示す。

**必要十分版**: `Ising2D/NecSuf/SitePauliPrefixProductKroneckerForm.lean`。具体版をその系として導くのは
`ClaimSitePauliPrefixProductKroneckerFormFromNecSuf.lean`。

## 人手証明との対応

* 人手の `r ∈ {1, …, M_col}` は Lean の `r + 1`（`r < M`）、人手の `a_1, …, a_r` は Lean の `a : Fin (r + 1) → Mat(2,ℂ)` で、人手の `a_j` が Lean の `a (j - 1)` である。
  人手は `a_j ∈ {x, y, z}` の `σ^{a_j}` で述べるが、証明は Pauli 行列の性質を使わない（各サイトの行列について使うのは、単位行列が左右の単位元であることだけ）ので、
  Lean は `σ^{a_j}` を一般の `a j ∈ Mat(2,ℂ)` で述べる（`siteOp_mul_same`・`siteOp_mul_comm` と同じ扱い）。
* 人手の左辺 `Π_{j=1}^{r}σ_j^{a_j}`（`def_finite_product_of_matrices` の有限積、`A_j → σ_j^{a_j}`）は、Lean の具体版 `finiteMatrixProduct`（`ι := Conf M`）に
  因子 `sitePauliFamily r h a`（`σ_1^{a_1}, …, σ_{r+1}^{a_{r+1}}`）を入れたものである。
  人手の `Π_{j=1}^{s}σ_j^{a_j}` は Lean の `finiteMatrixProduct (s - 1) (sitePauliFamily (s - 1) _ (a の先頭 s 個))` で、
  `def_finite_product_of_matrices` の第 1 式の行と第 2 式（`r → s`）の行は `finiteMatrixProduct_zero`・`finiteMatrixProduct_succ` である。
* 人手の右辺 `σ^{a_1}⊠⋯⊠σ^{a_r}⊠I⊠⋯⊠I` は `siteProd M (prefixKroneckerFamily r a)`（第 `i` 因子は `i < r + 1` なら `a i`、それ以外は `I`）。
* 人手の `s` の帰納法は、Lean の `r` の帰納法（因子 `a` を一般にしたまま。`a` の先頭の `s` 個が人手の `Π_{j=1}^{s}σ_j^{a_j}` の因子）である。
  `s = 1` の 2 行の鎖と、`s → s + 1` の 6 行の鎖は、`site_pauli_prefix_product_kronecker_form` の 2 つの節の `calc` と 1 段ずつ対応する。
  節 `| s + 1` の Lean の変数 `s` は人手の `s - 1` である。段のコメントの `k = s+1`・「第 `s+2` 以降」などの `s` は人手の `s` で書く。
  3 行目（`kronecker_product_rule` (1)）は `siteProd_mul` を右辺から左辺へ使い、因子の並びを人手の行と同じ形に書く。
  4 行目（第 1 から第 `s` 因子へ同時に適用）は因子ごとの場合分けの中で `mul_identity_matrix` を当てる。5・6 行目は `identity_matrix_mul` の `rw` 一回で
  該当する因子を全て書き換え、6 行目の場合分けは因子の並びを `prefixKroneckerFamily (s + 1) a` の形へ読み替えるだけである。
* `Z`・`Y` の式は、人手で `Z_m` を `site_pauli_prefix_product_kronecker_form` でクロネッカー積へ直す使い方
  （`epsilon_anticommutes_with_jordan_wigner_Z` は `a_j` を置いて `r → m` で当てる。`iH_is_real_symmetric`・`H1_plus_in_sigma_z_form` は
  `r → m`、`a_1 = ⋯ = a_{m-1} = x`、`a_m = z` で当てる）を逆向きに読んだものである。
  人手の `m` は Lean の `m + 1`（`m : Fin M`）で、因子 `jwFactor m A` の第 `j` 因子（Lean の 0 始まり）は `j < m` なら `σ_{j+1}^x`、`j = m` なら `σ_{m+1}^{A}` である。
  人手 `epsilon_anticommutes_with_jordan_wigner_Z`・`_Y` の証明の `Z_m`・`Y_m` の鎖の (k)・本主張・`a_j` の定義の 3 行は
  `finiteMatrixProduct_jwFactor_kronecker_form`（`a_j` は `jwLetter`）と 1 段ずつ対応する。
* 同じファイルで、人手 `global_spin_flip_kronecker_form` の 2 行の鎖（`def_global_spin_flip_matrix` の有限積 `∏_{j=1}^{M_col}σ_j^x` → 本主張）を
  `global_spin_flip_kronecker_form` として示す。Lean の `ε` は接頭積 `sigmaXPrefixProduct`（`P_0 := I` から掛け始める）で定めてあるので、
  人手の定義の有限積に等しいことを `epsilon_eq_finiteMatrixProduct` で先に示す。
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionTransferMatrixSymbols
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionFiniteProductOfMatrices
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf

namespace Ising2D

variable {M : ℕ}

/-- 人手の右辺の因子の並び `σ^{a_1}, …, σ^{a_{r+1}}, I, …, I`（人手の `r` は Lean の `r + 1`）。
第 `i` 因子（Lean の 0 始まり）は `i < r + 1` なら `a i`、それ以外は `I`。 -/
def prefixKroneckerFamily (r : ℕ) (a : Fin (r + 1) → Matrix (Fin 2) (Fin 2) ℂ) :
    Fin M → Matrix (Fin 2) (Fin 2) ℂ :=
  fun i => if h : (i : ℕ) < r + 1 then a ⟨i, h⟩ else 1

/-- 人手の左辺の因子 `σ_1^{a_1}, …, σ_{r+1}^{a_{r+1}}`（`def_site_pauli_matrices`。Lean の 0 始まりの `j` が人手の `σ_{j+1}^{a_{j+1}}`）。 -/
noncomputable def sitePauliFamily (r : ℕ) (h : r < M) (a : Fin (r + 1) → Matrix (Fin 2) (Fin 2) ℂ) :
    Fin (r + 1) → TensorPow M :=
  fun j => siteOp ⟨(j : ℕ), lt_of_le_of_lt (Nat.le_of_lt_succ j.isLt) h⟩ (a j)

/-- **人手 `site_pauli_prefix_product_kronecker_form`**:
`Π_{j=1}^{r}σ_j^{a_j} = σ^{a_1}⊠⋯⊠σ^{a_r}⊠I⊠⋯⊠I`（人手の `r` は Lean の `r + 1`）。
`s = 1` の 2 行の鎖と、`s → s + 1` の 6 行の鎖と 1 段ずつの `calc`。 -/
theorem site_pauli_prefix_product_kronecker_form :
    ∀ (r : ℕ) (h : r < M) (a : Fin (r + 1) → Matrix (Fin 2) (Fin 2) ℂ),
      finiteMatrixProduct r (sitePauliFamily r h a) = siteProd M (prefixKroneckerFamily r a)
  | 0, h, a =>
    calc finiteMatrixProduct 0 (sitePauliFamily 0 h a)
        = siteOp (⟨0, h⟩ : Fin M) (a 0) := finiteMatrixProduct_zero _
                                                        -- `def_finite_product_of_matrices` の第 1 式
      _ = siteProd M (prefixKroneckerFamily 0 a) := by
          -- `def_site_pauli_matrices` の `k = 1`
          rw [siteOp_apply]
          congr 1
          funext i
          by_cases hi : (i : ℕ) < 0 + 1
          · have he : i = (⟨0, h⟩ : Fin M) := Fin.ext (show (i : ℕ) = 0 by omega)
            rw [prefixKroneckerFamily, dif_pos hi]
            subst he
            rw [Function.update_self]
            rfl
          · have hne : i ≠ (⟨0, h⟩ : Fin M) := fun he => hi (by subst he; exact Nat.zero_lt_one)
            rw [prefixKroneckerFamily, dif_neg hi, Function.update_of_ne hne, Pi.one_apply]
  | s + 1, h, a => by
    have hs : s < M := Nat.lt_of_succ_lt h
    have ih := site_pauli_prefix_product_kronecker_form s hs (fun j => a (Fin.castSucc j))
    calc finiteMatrixProduct (s + 1) (sitePauliFamily (s + 1) h a)
        = finiteMatrixProduct s (sitePauliFamily s hs (fun j => a (Fin.castSucc j)))
            * siteOp (⟨s + 1, h⟩ : Fin M) (a (Fin.last (s + 1))) := finiteMatrixProduct_succ s _
                                                        -- `def_finite_product_of_matrices` の第 2 式（`r → s`）
      _ = siteProd M (prefixKroneckerFamily s (fun j => a (Fin.castSucc j)))
            * siteProd M (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) ⟨s + 1, h⟩ (a (Fin.last (s + 1)))) := by
          rw [ih, siteOp_apply]                         -- 帰納法の仮定と `def_site_pauli_matrices` の `k = s+1`
      _ = siteProd M (fun i : Fin M =>
            if hi : (i : ℕ) < s + 1 then a ⟨i, by omega⟩ * 1
            else if (i : ℕ) = s + 1 then 1 * a (Fin.last (s + 1)) else 1 * 1) := by
          -- `kronecker_product_rule` (1)
          rw [← siteProd_mul]
          congr 1
          funext i
          rw [Pi.mul_apply]
          rcases lt_trichotomy (i : ℕ) (s + 1) with hi | hi | hi
          · have hne : i ≠ (⟨s + 1, h⟩ : Fin M) := fun he => by rw [he] at hi; exact lt_irrefl _ hi
            rw [prefixKroneckerFamily, dif_pos hi, dif_pos hi, Function.update_of_ne hne, Pi.one_apply]
            rfl
          · have he : i = (⟨s + 1, h⟩ : Fin M) := Fin.ext hi
            rw [prefixKroneckerFamily, dif_neg (by omega), dif_neg (by omega), if_pos hi, he,
              Function.update_self]
          · have hne : i ≠ (⟨s + 1, h⟩ : Fin M) := fun he => by rw [he] at hi; exact lt_irrefl _ hi
            rw [prefixKroneckerFamily, dif_neg (by omega), dif_neg (by omega), if_neg (by omega),
              Function.update_of_ne hne, Pi.one_apply]
      _ = siteProd M (fun i : Fin M =>
            if hi : (i : ℕ) < s + 1 then a ⟨i, by omega⟩
            else if (i : ℕ) = s + 1 then 1 * a (Fin.last (s + 1)) else 1 * 1) := by
          -- `identity_matrix_is_right_unit_of_mat_mult` を第 1 から第 `s` 因子へ同時に適用
          congr 1
          funext i
          by_cases hi : (i : ℕ) < s + 1
          · rw [dif_pos hi, dif_pos hi]
            exact mul_identity_matrix _
          · rw [dif_neg hi, dif_neg hi]
      _ = siteProd M (fun i : Fin M =>
            if hi : (i : ℕ) < s + 1 then a ⟨i, by omega⟩
            else if (i : ℕ) = s + 1 then a (Fin.last (s + 1)) else 1 * 1) := by
          -- `identity_matrix_is_left_unit_of_mat_mult`（`A → σ^{a_{s+1}}`）
          rw [identity_matrix_mul (a (Fin.last (s + 1)))]
      _ = siteProd M (prefixKroneckerFamily (s + 1) a) := by
          -- `identity_matrix_is_left_unit_of_mat_mult`（`A → I`）を第 `s+2` 以降の因子へ同時に適用
          rw [identity_matrix_mul (1 : Matrix (Fin 2) (Fin 2) ℂ)]
          congr 1                                       -- 両辺は同じ因子の並び `σ^{a_1}⊠⋯⊠σ^{a_{s+1}}⊠I⊠⋯⊠I`
          funext i
          rcases lt_trichotomy (i : ℕ) (s + 1) with hi | hi | hi
          · rw [dif_pos hi, prefixKroneckerFamily, dif_pos (by omega)]
          · rw [dif_neg (by omega), if_pos hi, prefixKroneckerFamily, dif_pos (by omega)]
            congr 1
            exact Fin.ext hi.symm
          · rw [dif_neg (by omega), if_neg (by omega), prefixKroneckerFamily, dif_neg (by omega)]

/-! ## Lean の `Z`・`Y` は人手の定義の行列の有限積に等しい -/

/-- 人手 `def_jordan_wigner_Z_matrices`・`def_jordan_wigner_Y_matrices` の因子 `F_j^{(z)}`（`A = σ^z`）・`F_j^{(y)}`（`A = σ^y`）:
`j < m` なら `σ_j^x`、`j = m` なら `σ_m^{A}`（人手の `m` は Lean の `m + 1`。Lean の 0 始まりの `j` が人手の `F_{j+1}`）。 -/
noncomputable def jwFactor (m : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) : Fin ((m : ℕ) + 1) → TensorPow M :=
  fun j => if hj : (j : ℕ) < (m : ℕ) then sigmaX ⟨(j : ℕ), lt_trans hj m.isLt⟩ else siteOp m A

/-- `F_j` の右肩の文字 `a_j`（`j < m` なら `x`、`j = m` なら `A`）。`site_pauli_prefix_product_kronecker_form` の `a` に入れる。 -/
def jwLetter (m : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) : Fin ((m : ℕ) + 1) → Matrix (Fin 2) (Fin 2) ℂ :=
  fun j => if (j : ℕ) < (m : ℕ) then pauliX else A

/-- 人手 `epsilon_anticommutes_with_jordan_wigner_Z`・`_Y` の証明の `Z_m`・`Y_m` の 4 行の鎖（`A = σ^z` が `Z_m`、`A = σ^y` が `Y_m`。
人手の `m` は Lean の `m + 1`）: `def_jordan_wigner_Z_matrices`・`def_jordan_wigner_Y_matrices` の有限積 `∏_{j=1}^{m}F_j` →
(k) の `F_j = σ_j^{a_j}` を `m` 個の因子へ → `site_pauli_prefix_product_kronecker_form`（`r → m`）→ `a_j` の定義（`jwLetter`）を `m` か所へ。
右辺の `siteProd M (jwFamily m A)` は `σ^x⊠⋯⊠σ^x⊠σ^{A}⊠I⊠⋯⊠I`。 -/
theorem finiteMatrixProduct_jwFactor_kronecker_form (m : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    finiteMatrixProduct (m : ℕ) (jwFactor m A) = siteProd M (jwFamily m A) :=
  calc finiteMatrixProduct (m : ℕ) (jwFactor m A)
      = finiteMatrixProduct (m : ℕ) (sitePauliFamily (m : ℕ) m.isLt (jwLetter m A)) := by
        -- (k): `j < m` なら `F_j = σ_j^x = σ_j^{a_j}`、`j = m` なら `F_m = σ_m^{A} = σ_m^{a_m}`
        congr 1
        funext j
        by_cases hj : (j : ℕ) < (m : ℕ)
        · rw [sitePauliFamily, jwFactor, jwLetter, if_pos hj, dif_pos hj]
          rfl
        · have he : (⟨(j : ℕ), lt_of_le_of_lt (Nat.le_of_lt_succ j.isLt) m.isLt⟩ : Fin M) = m :=
            Fin.ext (show (j : ℕ) = (m : ℕ) by have := j.isLt; omega)
          rw [sitePauliFamily, jwFactor, jwLetter, if_neg hj, dif_neg hj, he]
    _ = siteProd M (prefixKroneckerFamily (m : ℕ) (jwLetter m A)) :=
        site_pauli_prefix_product_kronecker_form (m : ℕ) m.isLt (jwLetter m A)
                                                                  -- `site_pauli_prefix_product_kronecker_form`（`r → m`）
    _ = siteProd M (jwFamily m A) := by
        -- `a_j` の定義を `m` か所へ（`j < m` なら `x`、`j = m` なら `A`）
        congr 1
        funext i
        rcases lt_trichotomy (i : ℕ) (m : ℕ) with hi | hi | hi
        · rw [jwFamily_of_lt hi, prefixKroneckerFamily, dif_pos (by omega), jwLetter, if_pos hi]
        · have he : i = m := Fin.ext hi
          rw [he, jwFamily_self, prefixKroneckerFamily, dif_pos (by omega), jwLetter, if_neg (lt_irrefl _)]
        · rw [jwFamily_of_gt hi, prefixKroneckerFamily, dif_neg (by omega)]

/-- `σ_1^x⋯σ_{m-1}^x σ_m^{A} = ∏_{j=1}^{m}F_j`（人手の `m` は Lean の `m + 1`）。`Z`・`Y` に共通の鎖。
左辺の `siteProd M (jwFamily m A)` が Lean の `Z`・`Y` の定義、右辺が人手の `def_jordan_wigner_Z_matrices`・`def_jordan_wigner_Y_matrices`
の積を `def_finite_product_of_matrices` で読んだものである。 -/
theorem jw_eq_finiteMatrixProduct (m : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd M (jwFamily m A) = finiteMatrixProduct (m : ℕ) (jwFactor m A) :=
  (finiteMatrixProduct_jwFactor_kronecker_form m A).symm

/-- **Lean の `Z` は人手 `def_jordan_wigner_Z_matrices` の `Z_m = σ_1^x⋯σ_{m-1}^xσ_m^z = ∏_{j=1}^{m}F_j^{(z)}`**（人手の `m` は Lean の `m + 1`）。 -/
theorem Z_eq_finiteMatrixProduct (m : Fin M) : Z m = finiteMatrixProduct (m : ℕ) (jwFactor m pauliZ) :=
  calc Z m = siteProd M (jwFamily m pauliZ) := rfl     -- Lean の `Z` の定義
    _ = finiteMatrixProduct (m : ℕ) (jwFactor m pauliZ) := jw_eq_finiteMatrixProduct m pauliZ

/-- **Lean の `Y` は人手 `def_jordan_wigner_Y_matrices` の `Y_m = σ_1^x⋯σ_{m-1}^xσ_m^y = ∏_{j=1}^{m}F_j^{(y)}`**（人手の `m` は Lean の `m + 1`）。 -/
theorem Y_eq_finiteMatrixProduct (m : Fin M) : Y m = finiteMatrixProduct (m : ℕ) (jwFactor m pauliY) :=
  calc Y m = siteProd M (jwFamily m pauliY) := rfl     -- Lean の `Y` の定義
    _ = finiteMatrixProduct (m : ℕ) (jwFactor m pauliY) := jw_eq_finiteMatrixProduct m pauliY

/-- **人手 `iH_is_real_symmetric` の Step 1 の準備の `Z_m` の表示の 4 行**（人手の `m` は Lean の `m + 1`）:
`def_jordan_wigner_Z_matrices` の有限積 `∏_{j=1}^{m}F_j^{(z)}` → (k) → `site_pauli_prefix_product_kronecker_form`（`r → m`）→ `a_j^{(z)}` の定義。
1 段目は Lean の `Z` の定義（クロネッカー積）を人手の定義（有限積）へ読み替える橋渡し、2 段目が残りの 3 行である。 -/
theorem Z_prefix_kronecker_form (m : Fin M) : Z m = siteProd M (jwFamily m pauliZ) :=
  calc Z m = finiteMatrixProduct (m : ℕ) (jwFactor m pauliZ) :=
        Z_eq_finiteMatrixProduct m                              -- `def_jordan_wigner_Z_matrices`
    _ = siteProd M (jwFamily m pauliZ) :=
        finiteMatrixProduct_jwFactor_kronecker_form m pauliZ    -- (k)・`site_pauli_prefix_product_kronecker_form`・`a_j^{(z)}` の定義

/-- **人手 `iH_is_real_symmetric` の Step 1 の準備の `Y_m` の表示の 4 行**（人手の `m` は Lean の `m + 1`）。`Z_prefix_kronecker_form` と同じ形。 -/
theorem Y_prefix_kronecker_form (m : Fin M) : Y m = siteProd M (jwFamily m pauliY) :=
  calc Y m = finiteMatrixProduct (m : ℕ) (jwFactor m pauliY) :=
        Y_eq_finiteMatrixProduct m                              -- `def_jordan_wigner_Y_matrices`
    _ = siteProd M (jwFamily m pauliY) :=
        finiteMatrixProduct_jwFactor_kronecker_form m pauliY    -- (k)・`site_pauli_prefix_product_kronecker_form`・`a_j^{(y)}` の定義

/-! ## Lean の `ε` は人手の定義の行列の有限積に等しい、と `global_spin_flip_kronecker_form` -/

/-- Lean の `ε` の接頭積 `sigmaXPrefixProduct M (r + 1)`（`P_0 := I`、`P_{s+1} := P_sσ_{s+1}^x`）は、
人手 `def_global_spin_flip_matrix` が引く `def_finite_product_of_matrices` の有限積 `∏_{j=1}^{r}σ_j^x`（人手の `r` は Lean の `r + 1`。
因子は `sitePauliFamily r h (fun _ => σ^x)`）に等しい。Lean の `ε` の定義の形（`P_0 := I` から掛け始める）を人手の定義の形
（`∏_{j=1}^{1} := A_1` から掛け始める）へ読み替える橋渡しで、人手の鎖には対応する行が無い（`Z_eq_finiteMatrixProduct` と同じ扱い）。 -/
theorem sigmaXPrefixProduct_eq_sitePauliProduct :
    ∀ (r : ℕ) (h : r < M),
      sigmaXPrefixProduct M (r + 1) = finiteMatrixProduct r (sitePauliFamily r h (fun _ => pauliX))
  | 0, h =>
    calc sigmaXPrefixProduct M (0 + 1)
        = sigmaXPrefixProduct M 0 * sigmaX ⟨0, h⟩ := by
          rw [sigmaXPrefixProduct.eq_2, dif_pos h]                 -- Lean の `P_1` の定義
      _ = (1 : TensorPow M) * sigmaX ⟨0, h⟩ := rfl                 -- Lean の `P_0` の定義
      _ = sigmaX ⟨0, h⟩ := identity_matrix_mul_tensorPow _         -- `identity_matrix_is_left_unit_of_mat_mult`（`A → σ_1^x`）
      _ = finiteMatrixProduct 0 (sitePauliFamily 0 h (fun _ => pauliX)) := by
          rw [finiteMatrixProduct_zero]; rfl                       -- `def_finite_product_of_matrices` の第 1 式を右辺から左辺へ
  | r + 1, h =>
    calc sigmaXPrefixProduct M (r + 1 + 1)
        = sigmaXPrefixProduct M (r + 1) * sigmaX ⟨r + 1, h⟩ := by
          rw [sigmaXPrefixProduct.eq_2, dif_pos h]                 -- Lean の `P_{r+2}` の定義
      _ = finiteMatrixProduct r (sitePauliFamily r (Nat.lt_of_succ_lt h) (fun _ => pauliX))
            * sigmaX ⟨r + 1, h⟩ := by
          rw [sigmaXPrefixProduct_eq_sitePauliProduct r (Nat.lt_of_succ_lt h)]   -- 帰納法の仮定
      _ = finiteMatrixProduct (r + 1) (sitePauliFamily (r + 1) h (fun _ => pauliX)) := by
          rw [finiteMatrixProduct_succ]; rfl                       -- `def_finite_product_of_matrices` の第 2 式を右辺から左辺へ

/-- **Lean の `ε` は人手 `def_global_spin_flip_matrix` の `ε = ∏_{j=1}^{M_col}σ_j^x`**（人手の `M_col ∈ ℤ_{≥1}` は Lean の `n + 1`）。 -/
theorem epsilon_eq_finiteMatrixProduct (n : ℕ) :
    epsilon (n + 1) = finiteMatrixProduct n (sitePauliFamily n (Nat.lt_succ_self n) (fun _ => pauliX)) :=
  calc epsilon (n + 1) = sigmaXPrefixProduct (n + 1) (n + 1) := rfl   -- Lean の `ε` の定義
    _ = finiteMatrixProduct n (sitePauliFamily n (Nat.lt_succ_self n) (fun _ => pauliX)) :=
        sigmaXPrefixProduct_eq_sitePauliProduct n (Nat.lt_succ_self n)

/-- **人手 `global_spin_flip_kronecker_form`**: `ε = σ^x⊠⋯⊠σ^x`（人手の `M_col ∈ ℤ_{≥1}` は Lean の `n + 1`）。
人手の 2 行の鎖と 1 段ずつの `calc`。最後の段は、`r = M_col` で `I` の因子が無いことの読み替え（因子の並びの書き方の違いだけ）である。 -/
theorem global_spin_flip_kronecker_form (n : ℕ) :
    epsilon (n + 1) = siteProd (n + 1) (fun _ => pauliX) :=
  calc epsilon (n + 1)
      = finiteMatrixProduct n (sitePauliFamily n (Nat.lt_succ_self n) (fun _ => pauliX)) :=
        epsilon_eq_finiteMatrixProduct n                          -- `def_global_spin_flip_matrix`
    _ = siteProd (n + 1) (prefixKroneckerFamily n (fun _ => pauliX)) :=
        site_pauli_prefix_product_kronecker_form n (Nat.lt_succ_self n) (fun _ => pauliX)
                                                                  -- `site_pauli_prefix_product_kronecker_form`（`r → M_col`, `a_1 = ⋯ = a_{M_col} = x`）
    _ = siteProd (n + 1) (fun _ => pauliX) := by
        congr 1
        funext i
        rw [prefixKroneckerFamily, dif_pos i.isLt]

end Ising2D
