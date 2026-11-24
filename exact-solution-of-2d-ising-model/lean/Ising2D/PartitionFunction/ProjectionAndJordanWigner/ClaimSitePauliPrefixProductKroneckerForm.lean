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
* 人手の添字 `k ∈ {1,…,M_col}` は `finIndexToZZ M i = k`（`def_index_set_from_one_to_n`）を満たす `i : Fin M` である。証明の因子ごとの場合分けは、
  人手の添字 `finIndexToZZ M i` を ℤ の順序で比べる（「第 `1` から第 `s` 因子」は `finIndexToZZ M i ≤ ι_{ℕ→ℤ}(s)`、「第 `s+1` 因子」は
  `finIndexToZZ M i = finIndexToZZ M ⟨s, _⟩`）。分けた後の因子の等号は全単射の補題 `finIndexToZZ_bijective_onto_index_set` の単射で得る。
  Lean の定義（`prefixKroneckerFamily`・`jwFamily`・`jwLetter`・`jwFactor`）は `Fin` の元の値（ℕ）で比べるので、`prefixKroneckerFamily`・`jwFamily` へは
  `finIndexToZZ_le_inclusion_iff_val_lt`・`finIndexToZZ_lt_iff_val_lt` で移す。`jwFactor`・`jwLetter` の添字は `Fin (m + 1)` の元で、人手の `m` の添字
  `finIndexToZZ M m` と型が違うので、像の値を証明の中の `have` に置いて値の比較へ移す。
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
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionIndexSetFromOneToN

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
          -- 人手の添字 `finIndexToZZ M i`（`def_index_set_from_one_to_n`）が `ι_{ℕ→ℤ}(1) = 1_ℤ` 以下なら第 1 因子 `σ^{a_1}`、そうでなければ `I`
          have hinj := (finIndexToZZ_bijective_onto_index_set M).1
          have h0Z : finIndexToZZ M (⟨0, h⟩ : Fin M) = 1 := by
            simp only [finIndexToZZ, inclusionNNtoZZ_eq_natCast]; omega
          have h1Z : inclusionNNtoZZ (0 + 1) = 1 := by simp only [inclusionNNtoZZ_eq_natCast]; omega
          by_cases hi : finIndexToZZ M i ≤ inclusionNNtoZZ (0 + 1)
          · have he : i = (⟨0, h⟩ : Fin M) := hinj _ _ (by
              have := ((finIndexToZZ_bijective_onto_index_set M).2.1 i).1
              omega)
            rw [prefixKroneckerFamily, dif_pos ((finIndexToZZ_le_inclusion_iff_val_lt M i (0 + 1)).1 hi)]
            subst he
            rw [Function.update_self]
            rfl
          · have hne : i ≠ (⟨0, h⟩ : Fin M) := fun he => hi (by rw [he]; omega)
            rw [prefixKroneckerFamily, dif_neg (fun hv => hi ((finIndexToZZ_le_inclusion_iff_val_lt M i (0 + 1)).2 hv)),
              Function.update_of_ne hne, Pi.one_apply]
  | s + 1, h, a => by
    have hs : s < M := Nat.lt_of_succ_lt h
    have ih := site_pauli_prefix_product_kronecker_form s hs (fun j => a (Fin.castSucc j))
    -- `⟨s + 1, h⟩` の `finIndexToZZ` の像（人手の `s+1` の添字）は `ι_{ℕ→ℤ}(s + 1) + 1_ℤ`（ここの `s` は Lean の `s` で、人手の `s` は Lean の `s + 1`。`def_index_set_from_one_to_n`）
    have hinj := (finIndexToZZ_bijective_onto_index_set M).1
    have hsZ : finIndexToZZ M (⟨s + 1, h⟩ : Fin M) = inclusionNNtoZZ (s + 1) + 1 := rfl
    calc finiteMatrixProduct (s + 1) (sitePauliFamily (s + 1) h a)
        = finiteMatrixProduct s (sitePauliFamily s hs (fun j => a (Fin.castSucc j)))
            * siteOp (⟨s + 1, h⟩ : Fin M) (a (Fin.last (s + 1))) := finiteMatrixProduct_succ s _
                                                        -- `def_finite_product_of_matrices` の第 2 式（`r → s`）
      _ = siteProd M (prefixKroneckerFamily s (fun j => a (Fin.castSucc j)))
            * siteProd M (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) ⟨s + 1, h⟩ (a (Fin.last (s + 1)))) := by
          rw [ih, siteOp_apply]                         -- 帰納法の仮定と `def_site_pauli_matrices` の `k = s+1`
      _ = siteProd M (fun i : Fin M =>
            if hi : finIndexToZZ M i ≤ inclusionNNtoZZ (s + 1) then
              a ⟨i, by have := (finIndexToZZ_le_inclusion_iff_val_lt M i (s + 1)).1 hi; omega⟩ * 1
            else if finIndexToZZ M i = finIndexToZZ M ⟨s + 1, h⟩ then 1 * a (Fin.last (s + 1)) else 1 * 1) := by
          -- `kronecker_product_rule` (1)
          rw [← siteProd_mul]
          congr 1
          funext i
          rw [Pi.mul_apply]
          -- 人手の添字 `finIndexToZZ M i` を ℤ の順序で人手の `s+1` の添字と比べ、第 `1` から第 `s` 因子で `σ^{a_k}I`、
          -- 第 `s+1` 因子で `Iσ^{a_{s+1}}`、第 `s+2` 以降で `II`。Lean の定義 `prefixKroneckerFamily` へは `finIndexToZZ_le_inclusion_iff_val_lt` で移す
          rcases lt_trichotomy (finIndexToZZ M i) (finIndexToZZ M ⟨s + 1, h⟩) with hi | hi | hi
          · have hle : finIndexToZZ M i ≤ inclusionNNtoZZ (s + 1) := by omega
            have hne : i ≠ (⟨s + 1, h⟩ : Fin M) := fun he => by rw [he] at hi; exact lt_irrefl _ hi
            rw [prefixKroneckerFamily, dif_pos ((finIndexToZZ_le_inclusion_iff_val_lt M i (s + 1)).1 hle), dif_pos hle,
              Function.update_of_ne hne, Pi.one_apply]
            rfl
          · have he : i = (⟨s + 1, h⟩ : Fin M) := hinj _ _ hi
            have hle : ¬ finIndexToZZ M i ≤ inclusionNNtoZZ (s + 1) := by omega
            rw [prefixKroneckerFamily, dif_neg (fun hv => hle ((finIndexToZZ_le_inclusion_iff_val_lt M i (s + 1)).2 hv)),
              dif_neg hle, if_pos hi, he, Function.update_self]
          · have hle : ¬ finIndexToZZ M i ≤ inclusionNNtoZZ (s + 1) := by omega
            have hne : i ≠ (⟨s + 1, h⟩ : Fin M) := fun he => by rw [he] at hi; exact lt_irrefl _ hi
            rw [prefixKroneckerFamily, dif_neg (fun hv => hle ((finIndexToZZ_le_inclusion_iff_val_lt M i (s + 1)).2 hv)),
              dif_neg hle, if_neg (ne_of_gt hi), Function.update_of_ne hne, Pi.one_apply]
      _ = siteProd M (fun i : Fin M =>
            if hi : finIndexToZZ M i ≤ inclusionNNtoZZ (s + 1) then
              a ⟨i, by have := (finIndexToZZ_le_inclusion_iff_val_lt M i (s + 1)).1 hi; omega⟩
            else if finIndexToZZ M i = finIndexToZZ M ⟨s + 1, h⟩ then 1 * a (Fin.last (s + 1)) else 1 * 1) := by
          -- `identity_matrix_is_right_unit_of_mat_mult` を第 1 から第 `s` 因子へ同時に適用
          congr 1
          funext i
          by_cases hi : finIndexToZZ M i ≤ inclusionNNtoZZ (s + 1)
          · rw [dif_pos hi, dif_pos hi]
            exact mul_identity_matrix _
          · rw [dif_neg hi, dif_neg hi]
      _ = siteProd M (fun i : Fin M =>
            if hi : finIndexToZZ M i ≤ inclusionNNtoZZ (s + 1) then
              a ⟨i, by have := (finIndexToZZ_le_inclusion_iff_val_lt M i (s + 1)).1 hi; omega⟩
            else if finIndexToZZ M i = finIndexToZZ M ⟨s + 1, h⟩ then a (Fin.last (s + 1)) else 1 * 1) := by
          -- `identity_matrix_is_left_unit_of_mat_mult`（`A → σ^{a_{s+1}}`）
          rw [identity_matrix_mul (a (Fin.last (s + 1)))]
      _ = siteProd M (prefixKroneckerFamily (s + 1) a) := by
          -- `identity_matrix_is_left_unit_of_mat_mult`（`A → I`）を第 `s+2` 以降の因子へ同時に適用
          rw [identity_matrix_mul (1 : Matrix (Fin 2) (Fin 2) ℂ)]
          congr 1                                       -- 両辺は同じ因子の並び `σ^{a_1}⊠⋯⊠σ^{a_{s+1}}⊠I⊠⋯⊠I`
          funext i
          -- 左辺は人手の添字 `finIndexToZZ M i` の ℤ の比較で、右辺の Lean の定義は値（ℕ）の比較で因子を決める。
          -- 第 `1` から第 `s` 因子は `finIndexToZZ_le_inclusion_iff_val_lt` で移し、第 `s+1` 因子は全単射の補題の単射で `i = ⟨s + 1, h⟩` にし、
          -- 第 `s+2` 以降は `finIndexToZZ_lt_iff_val_lt` で移す
          rcases lt_trichotomy (finIndexToZZ M i) (finIndexToZZ M ⟨s + 1, h⟩) with hi | hi | hi
          · have hle : finIndexToZZ M i ≤ inclusionNNtoZZ (s + 1) := by omega
            have hv : (i : ℕ) < s + 1 := (finIndexToZZ_le_inclusion_iff_val_lt M i (s + 1)).1 hle
            rw [dif_pos hle, prefixKroneckerFamily, dif_pos (by omega)]
          · have he : i = (⟨s + 1, h⟩ : Fin M) := hinj _ _ hi
            subst he
            rw [dif_neg (by omega), if_pos rfl, prefixKroneckerFamily, dif_pos (by exact Nat.lt_succ_self (s + 1))]
            rfl
          · have hv : s + 1 < (i : ℕ) := (finIndexToZZ_lt_iff_val_lt M ⟨s + 1, h⟩ i).1 hi
            rw [dif_neg (by omega), if_neg (ne_of_gt hi), prefixKroneckerFamily, dif_neg (by omega)]

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
        -- 人手の添字 `finIndexToZZ (m + 1) j`（`def_index_set_from_one_to_n`）を、人手の `m` の添字 `finIndexToZZ M m` と ℤ の順序で比べる。
        -- Lean の定義 `jwFactor`・`jwLetter` は値（ℕ）で比べるので、像の比較を値の比較へ移す
        -- `Fin (m + 1)` の元 `j` を `Fin M` へ入れても像は変わらず、人手の `m` の添字は `ι_{ℕ→ℤ}(m + 1)`（Lean の `m`）
        have hjZ : finIndexToZZ M (⟨(j : ℕ), lt_of_le_of_lt (Nat.le_of_lt_succ j.isLt) m.isLt⟩ : Fin M)
            = finIndexToZZ ((m : ℕ) + 1) j := rfl
        have hmZ : finIndexToZZ M m = inclusionNNtoZZ ((m : ℕ) + 1) := by
          simp only [finIndexToZZ, inclusionNNtoZZ_eq_natCast]; push_cast; ring
        have hjm : finIndexToZZ ((m : ℕ) + 1) j < finIndexToZZ M m ↔ (j : ℕ) < (m : ℕ) := by
          rw [← hjZ]; exact finIndexToZZ_lt_iff_val_lt M _ m
        by_cases hj : finIndexToZZ ((m : ℕ) + 1) j < finIndexToZZ M m
        · rw [sitePauliFamily, jwFactor, jwLetter, if_pos (hjm.1 hj), dif_pos (hjm.1 hj)]
          rfl
        · -- 人手の添字 `j` は `{1,…,m}` の元で `m` より小さくないので、`j = m`（全単射の補題の値の範囲と単射）
          have hjle := ((finIndexToZZ_bijective_onto_index_set ((m : ℕ) + 1)).2.1 j).2
          have he : (⟨(j : ℕ), lt_of_le_of_lt (Nat.le_of_lt_succ j.isLt) m.isLt⟩ : Fin M) = m :=
            (finIndexToZZ_bijective_onto_index_set M).1 _ _ (by rw [hjZ]; omega)
          rw [sitePauliFamily, jwFactor, jwLetter, if_neg (fun hv => hj (hjm.2 hv)), dif_neg (fun hv => hj (hjm.2 hv)), he]
    _ = siteProd M (prefixKroneckerFamily (m : ℕ) (jwLetter m A)) :=
        site_pauli_prefix_product_kronecker_form (m : ℕ) m.isLt (jwLetter m A)
                                                                  -- `site_pauli_prefix_product_kronecker_form`（`r → m`）
    _ = siteProd M (jwFamily m A) := by
        -- `a_j` の定義を `m` か所へ（`j < m` なら `x`、`j = m` なら `A`）
        congr 1
        funext i
        -- 人手の添字 `finIndexToZZ M i` を人手の `m` の添字 `finIndexToZZ M m` と ℤ の順序で比べる（`def_index_set_from_one_to_n`）。
        -- Lean の定義 `jwFamily`・`prefixKroneckerFamily`・`jwLetter` へは `finIndexToZZ_lt_iff_val_lt` で移す
        rcases lt_trichotomy (finIndexToZZ M i) (finIndexToZZ M m) with hi | hi | hi
        · have hv := (finIndexToZZ_lt_iff_val_lt M i m).1 hi
          rw [jwFamily_of_lt hv, prefixKroneckerFamily, dif_pos (by omega), jwLetter, if_pos hv]
        · have he : i = m := (finIndexToZZ_bijective_onto_index_set M).1 i m hi
          rw [he, jwFamily_self, prefixKroneckerFamily, dif_pos (by omega), jwLetter, if_neg (lt_irrefl _)]
        · have hv := (finIndexToZZ_lt_iff_val_lt M m i).1 hi
          rw [jwFamily_of_gt hv, prefixKroneckerFamily, dif_neg (by omega)]

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

/-- **`Z_m` の表示の 4 行**（人手 `iH_is_real_symmetric` の Step 1 の準備と `H1_plus_in_sigma_z_form` の準備 1 が共有する。人手の `m` は Lean の `m + 1`）:
`def_jordan_wigner_Z_matrices` の有限積 `∏_{j=1}^{m}F_j^{(z)}` → (k) → `site_pauli_prefix_product_kronecker_form`（`r → m`）→ `a_j^{(z)}` の定義。
1 段目は Lean の `Z` の定義（クロネッカー積）を人手の定義（有限積）へ読み替える橋渡し、2 段目が残りの 3 行である。
人手 `H1_plus_in_sigma_z_form` の準備 1 の `Z_m` の表示の 4 行も同じ形で、これを引く。 -/
theorem Z_prefix_kronecker_form (m : Fin M) : Z m = siteProd M (jwFamily m pauliZ) :=
  calc Z m = finiteMatrixProduct (m : ℕ) (jwFactor m pauliZ) :=
        Z_eq_finiteMatrixProduct m                              -- `def_jordan_wigner_Z_matrices`
    _ = siteProd M (jwFamily m pauliZ) :=
        finiteMatrixProduct_jwFactor_kronecker_form m pauliZ    -- (k)・`site_pauli_prefix_product_kronecker_form`・`a_j^{(z)}` の定義

/-- **`Y_m` の表示の 4 行**（人手 `iH_is_real_symmetric` の Step 1 の準備ほかが共有する。人手の `m` は Lean の `m + 1`）。`Z_prefix_kronecker_form` と同じ形。
人手 `H1_plus_in_sigma_z_form` の準備 1 の `Y_m` の表示の 4 行も同じ形で、これを引く。 -/
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
        -- 人手の添字 `finIndexToZZ (n + 1) i` は `{1,…,M_col}` の元なので `M_col` 以下（全単射の補題の値の範囲。`def_index_set_from_one_to_n`）
        rw [prefixKroneckerFamily, dif_pos ((finIndexToZZ_le_inclusion_iff_val_lt (n + 1) i (n + 1)).1
          ((finIndexToZZ_bijective_onto_index_set (n + 1)).2.1 i).2)]

end Ising2D
