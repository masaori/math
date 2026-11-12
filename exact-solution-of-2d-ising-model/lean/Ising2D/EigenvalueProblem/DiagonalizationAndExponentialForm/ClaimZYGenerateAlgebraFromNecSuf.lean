/-
# `<Z_Y_generate_algebra>` — 具体版を必要十分版の特殊化として導出する

対応する人手証明:
`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の `Z_Y_generate_algebra`

## このファイルの位置づけ（README のゴール設定 4 節「2 本立て」）

| | 定理 | 何を仮定しているか |
| --- | --- | --- |
| **具体版** | `Ising2D.Z_Y_generate_algebra`（`ClaimZYGenerateAlgebra.lean`） | 複素行列・クロネッカー積・Pauli 行列 |
| **必要十分版** | `NecSuf.string_mem` / `NecSuf.local_mem`（中は `string_mem_of_previous`・`local_mem_of_previous`）/ `NecSuf.xl_mul_string_comm` / `NecSuf.string_mul_self` / `NecSuf.string_eq_finProdLeft` / `NecSuf.map_mem_of_mulSingle_mem` / `NecSuf.eq_top_of_span_eq_top`（`NecSuf/GeneratedByBasis.lean`） | 可換半環 `R` 上の代数、モノイドでの `x n * x n = 1` と相異なる番号どうしの可換性、積の表示は `*` と `1` と `1 * x 0 = x 0` だけ、`Fin n` 添字の直積への積を保つ写像（`0 < n`）、全体を張る集合 |

本ファイルは、同じ結論 `Algebra.adjoin ℂ (ZYSet M) = ⊤` を
**必要十分版だけを論法として使って**導き直す（`Z_Y_generate_algebra_of_necSuf`）。

## 特殊化で埋めた「具体的な部分」

必要十分版に渡す具体的な部分は次の 3 つである（1 は具体版の `ClaimZYGenerateAlgebra.lean` と
`ClaimKroneckerFamilyOfSpanningFamilySpansFromNecSuf.lean` を使う）。
このうち複素 2×2 行列に依存しているのは 1 の `𝓑` が `Mat(2, ℂ)` を張ること（`matrix_two_decomp`）だけで、
`<kronecker_family_of_spanning_family_spans>` は `Mat(2, ℂ)` を張る任意の 4 元の族で、3 は `siteOp_one` と Step 2 だけで成り立つ。

1. `span_kroneckerFamily_eq_top_of_necSuf pauliFamily pauliFamily_spans`: `𝓑 = {I, σ^x, σ^y, σ^z}` が `Mat(2, ℂ)` を張ること
   （原文 Step 3 前半の成分比較 `matrix_two_decomp`）と、`<kronecker_family_of_spanning_family_spans>` を `𝓑` に適用した
   `𝓑^{⊠M}` が `Mat(2^M, ℂ)` を張ること（その必要十分版 `NecSuf.mem_familyCombinations_of_spanning` からの導出）。
2. `siteProdHom`: クロネッカー積 `siteProd` が積を保つこと（`siteProd_mul`。`kronecker_product_rule` (1)）。
   必要十分版の帰納法は `P_1 := E_1` から始まるので `siteProd_one` は要らない。
   ただし `M = 0`（人手に現れない場合）は必要十分版の `0 < n` を満たさないので、具体版と同じく
   `siteProd_one` と (ii) で別に閉じる。
3. 各 `E_k = siteOp k e_k`（`e_k ∈ 𝓑`）が `𝒜` に入ること: `e_k = I` なら `siteOp_one`、
   `e_k = σ^x, σ^y, σ^z` なら `σ_k^x, σ_k^y, σ_k^z` の定義と、Step 2 の必要十分版の結論。

Step 2（Jordan–Wigner 文字列の帰納法）は、`P_m P_m = I` から得られる分解
`σ^z_m = P_m Z_m`, `σ^y_m = P_m Y_m` と漸化式 `P_{m+1} = P_m σ^x_m`（`P_m` は具体版と同じ `sigmaXPrefixProduct`）を渡すだけで、
帰納法そのもの（外側の累積帰納法と `P_{m-1} ∈ 𝒜` の `r` の帰納法）は必要十分版 `NecSuf.local_mem`・`NecSuf.string_mem_of_previous` が担う。`P_m P_m = I`（人手 Step 2 の二乗の式）も
必要十分版 `NecSuf.string_mul_self` から導く（`sigmaXPrefixProduct_mul_self_of_necSuf`）。

## 必要十分版へ渡すための ℕ 添字化

必要十分版はサイト添字を `ℕ` にとり、仮定を `n < N` の範囲でだけ課す。
具体版のサイト添字は `Fin M` なので、`M` 未満では対応する元、`M` 以上では `1` を返す
族（`ZNat` 等）を作って渡す。範囲外の値は必要十分版の仮定にも結論にも現れない。
-/
import Ising2D.NecSuf.GeneratedByBasis
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimZYGenerateAlgebra
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerFamilyOfSpanningFamilySpansFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionFiniteProductOfMatricesFromNecSuf

namespace Ising2D

variable {M : ℕ}

/-! ## ℕ 添字への読み替え -/

/-- 必要十分版へ渡すための `Z` の ℕ 添字版（`M` 以上では単位元）。 -/
noncomputable def ZNat (M : ℕ) (n : ℕ) : TensorPow M :=
  if h : n < M then Z ⟨n, h⟩ else 1

/-- 必要十分版へ渡すための `Y` の ℕ 添字版。 -/
noncomputable def YNat (M : ℕ) (n : ℕ) : TensorPow M :=
  if h : n < M then Y ⟨n, h⟩ else 1

/-- 必要十分版へ渡すための `σ^z` の ℕ 添字版。 -/
noncomputable def sigmaZNat (M : ℕ) (n : ℕ) : TensorPow M :=
  if h : n < M then sigmaZ ⟨n, h⟩ else 1

/-- 必要十分版へ渡すための `σ^y` の ℕ 添字版。 -/
noncomputable def sigmaYNat (M : ℕ) (n : ℕ) : TensorPow M :=
  if h : n < M then sigmaY ⟨n, h⟩ else 1

/-- 必要十分版へ渡すための `σ^x` の ℕ 添字版。 -/
noncomputable def sigmaXNat (M : ℕ) (n : ℕ) : TensorPow M :=
  if h : n < M then sigmaX ⟨n, h⟩ else 1

/-! ## Step 2 を必要十分版から導出する -/

/-- **人手 Step 2 の二乗の式 `P_rP_r = I` を必要十分版 `NecSuf.string_mul_self` の特殊化として導出した形**
（具体版は `sigmaXPrefixProduct_mul_self`）。渡すのは `P_0 = I`・`P_{r+1} = P_rσ_{r+1}^x`（`sigmaXPrefixProduct` の定義そのもの。`sigmaXNat` と同じ `if` の形なので `rfl`）、
Step 1 の `σ_k^xσ_k^x = I`（`sigmaX_mul_self`）、相異なるサイトの可換性（`siteOp_mul_comm`）だけである。 -/
theorem sigmaXPrefixProduct_mul_self_of_necSuf (r : ℕ) (hr : r ≤ M) :
    sigmaXPrefixProduct M r * sigmaXPrefixProduct M r = 1 :=
  NecSuf.string_mul_self (p := sigmaXPrefixProduct M) (x := sigmaXNat M) (N := M) rfl
    (fun _ _ => rfl)
    (fun n hn => by rw [sigmaXNat, dif_pos hn, sigmaX_mul_self])
    (fun k n hk hnk => by
      have hne : (⟨k, hk⟩ : Fin M) ≠ ⟨n, lt_trans hnk hk⟩ :=
        fun he => absurd (Fin.mk.inj_iff.mp he) (by omega)
      rw [sigmaXNat, dif_pos hk, sigmaXNat, dif_pos (lt_trans hnk hk), sigmaX, sigmaX,
        siteOp_mul_comm hne])
    r hr

/-- **人手 Step 2 の可換の式 `σ_k^xP_r = P_rσ_k^x`（`r < k`）を必要十分版 `NecSuf.xl_mul_string_comm` の特殊化として導出した形**
（具体版は `sigmaX_mul_sigmaXPrefixProduct_comm`）。 -/
theorem sigmaX_mul_sigmaXPrefixProduct_comm_of_necSuf (k : Fin M) (r : ℕ) (hr : r ≤ (k : ℕ)) :
    sigmaX k * sigmaXPrefixProduct M r = sigmaXPrefixProduct M r * sigmaX k := by
  have h := NecSuf.xl_mul_string_comm (p := sigmaXPrefixProduct M) (x := sigmaXNat M) (N := M) rfl
    (fun _ _ => rfl)
    (fun k' n hk hnk => by
      have hne : (⟨k', hk⟩ : Fin M) ≠ ⟨n, lt_trans hnk hk⟩ :=
        fun he => absurd (Fin.mk.inj_iff.mp he) (by omega)
      rw [sigmaXNat, dif_pos hk, sigmaXNat, dif_pos (lt_trans hnk hk), sigmaX, sigmaX,
        siteOp_mul_comm hne])
    (k : ℕ) k.isLt r hr
  rwa [sigmaXNat, dif_pos k.isLt] at h

/-- **人手 Step 2 の積の表示 `P_r = ∏_{j=1}^{r}σ_j^x` を必要十分版 `NecSuf.string_eq_finProdLeft` の特殊化として導出した形**
（具体版は `sigmaXPrefixProduct_eq_finiteMatrixProduct`）。渡すのは `P_0 = I`・`P_{r+1} = P_rσ_{r+1}^x`（`rfl`）と
`identity_matrix_is_left_unit_of_mat_mult`（`identity_matrix_mul_tensorPow`）の `A → σ_1^x` だけで、有限積は
`finiteMatrixProduct_eq_finProdLeft`（`ι := Conf M`）で必要十分版の `NecSuf.finProdLeft` へ読み替える。 -/
theorem sigmaXPrefixProduct_eq_finiteMatrixProduct_of_necSuf (r : ℕ) (h : r < M) :
    sigmaXPrefixProduct M (r + 1) = finiteMatrixProduct r (sigmaXFamily r h) := by
  have hfam : sigmaXFamily r h = fun j : Fin (r + 1) => sigmaXNat M j := by
    funext j
    rw [sigmaXNat, dif_pos (lt_of_le_of_lt (Nat.le_of_lt_succ j.isLt) h)]
    rfl
  rw [finiteMatrixProduct_eq_finProdLeft, hfam]
  exact NecSuf.string_eq_finProdLeft (p := sigmaXPrefixProduct M) (x := sigmaXNat M) (N := M) rfl
    (fun _ _ => rfl)
    (by rw [sigmaXNat, dif_pos (lt_of_le_of_lt (Nat.zero_le r) h), identity_matrix_mul_tensorPow])
    r h

/-- 人手 Step 2 の `σ^z_m = P_{m-1}Z_m`（`m ≥ 2`。人手の `m` は Lean の `r + 2`）を、二乗の式の必要十分版から得た形
（鎖は具体版 `sigmaZ_eq_sigmaXPrefixProduct_mul` と同じ）。 -/
theorem sigmaZ_eq_sigmaXPrefixProduct_mul_of_necSuf (r : ℕ) (h : r + 1 < M) :
    sigmaZ (⟨r + 1, h⟩ : Fin M) = sigmaXPrefixProduct M (r + 1) * Z ⟨r + 1, h⟩ := by
  rw [Z_eq_sigmaXPrefixProduct_mul, ← mul_assoc,
    sigmaXPrefixProduct_mul_self_of_necSuf _ (le_of_lt h), identity_matrix_mul_tensorPow]

/-- 人手 Step 2 の `σ^y_m = P_{m-1}Y_m`（`m ≥ 2`）を、二乗の式の必要十分版から得た形。 -/
theorem sigmaY_eq_sigmaXPrefixProduct_mul_of_necSuf (r : ℕ) (h : r + 1 < M) :
    sigmaY (⟨r + 1, h⟩ : Fin M) = sigmaXPrefixProduct M (r + 1) * Y ⟨r + 1, h⟩ := by
  rw [Y_eq_sigmaXPrefixProduct_mul, ← mul_assoc,
    sigmaXPrefixProduct_mul_self_of_necSuf _ (le_of_lt h), identity_matrix_mul_tensorPow]

/-- **人手 Step 2 の `P_{m-1} ∈ 𝒜` の `r` の帰納法を必要十分版 `NecSuf.string_mem_of_previous` の特殊化として導出した形**
（具体版は `sigmaXPrefixProduct_mem_adjoin`。部分モノイドとしての `𝒜` に渡す）。 -/
theorem sigmaXPrefixProduct_mem_adjoin_of_necSuf (r : ℕ) (hr : r ≤ M)
    (h : ∀ j : Fin M, (j : ℕ) < r → sigmaX j ∈ Algebra.adjoin ℂ (ZYSet M)) :
    sigmaXPrefixProduct M r ∈ Algebra.adjoin ℂ (ZYSet M) :=
  NecSuf.string_mem_of_previous (S := (Algebra.adjoin ℂ (ZYSet M)).toSubsemiring.toSubmonoid)
    (p := sigmaXPrefixProduct M) (xl := sigmaXNat M) (N := M) rfl (fun _ _ => rfl) r hr
    (fun j hj => by
      have hjM : j < M := lt_of_lt_of_le hj hr
      show sigmaXNat M j ∈ Algebra.adjoin ℂ (ZYSet M)
      rw [sigmaXNat, dif_pos hjM]
      exact h ⟨j, hjM⟩ hj)

/-- 必要十分版 `NecSuf.local_mem` の特殊化: `σ^z_k, σ^y_k, σ^x_k ∈ 𝒜`（`p` は具体版と同じ `sigmaXPrefixProduct`）。 -/
theorem sigma_mem_adjoin_of_necSuf (k : Fin M) :
    sigmaZ k ∈ Algebra.adjoin ℂ (ZYSet M) ∧ sigmaY k ∈ Algebra.adjoin ℂ (ZYSet M) ∧
      sigmaX k ∈ Algebra.adjoin ℂ (ZYSet M) := by
  have h := NecSuf.local_mem (S := Algebra.adjoin ℂ (ZYSet M)) (p := sigmaXPrefixProduct M)
    (z := ZNat M) (y := YNat M) (zl := sigmaZNat M) (yl := sigmaYNat M) (xl := sigmaXNat M)
    (r := -Complex.I) (N := M) rfl
    (by
      -- `n = 0` は人手の `m = 1` の `Z_1 = σ_1^z`（`def_jordan_wigner_Z_matrices` の `m = 1` の場合。`sigmaZ_zero_eq_Z`）に `P_0 = I` を左から掛けたもの
      intro n hn
      rcases n with _ | n
      · rw [sigmaZNat, dif_pos hn, ZNat, dif_pos hn, sigmaZ_zero_eq_Z hn]
        exact (identity_matrix_mul_tensorPow _).symm
      · rw [sigmaZNat, dif_pos hn, ZNat, dif_pos hn, sigmaZ_eq_sigmaXPrefixProduct_mul_of_necSuf])
    (by
      -- `n = 0` は人手の `m = 1` の `Y_1 = σ_1^y`（`def_jordan_wigner_Y_matrices` の `m = 1` の場合。`sigmaY_zero_eq_Y`）に `P_0 = I` を左から掛けたもの
      intro n hn
      rcases n with _ | n
      · rw [sigmaYNat, dif_pos hn, YNat, dif_pos hn, sigmaY_zero_eq_Y hn]
        exact (identity_matrix_mul_tensorPow _).symm
      · rw [sigmaYNat, dif_pos hn, YNat, dif_pos hn, sigmaY_eq_sigmaXPrefixProduct_mul_of_necSuf])
    (by intro n hn; rw [sigmaXNat, dif_pos hn, sigmaYNat, dif_pos hn, sigmaZNat, dif_pos hn,
      sigmaX_eq])
    (fun _ _ => rfl)
    (by intro n hn; rw [ZNat, dif_pos hn]; exact Z_mem_adjoin _)
    (by intro n hn; rw [YNat, dif_pos hn]; exact Y_mem_adjoin _)
    (k : ℕ) k.isLt
  rw [sigmaZNat, dif_pos k.isLt, sigmaYNat, dif_pos k.isLt, sigmaXNat, dif_pos k.isLt] at h
  simpa using h

/-! ## Step 3 後半: 各 `E_k` は `𝒜` に属する -/

/-- 人手 Step 3 後半の「各 `E_k = I ⊠ ⋯ ⊠ e_k ⊠ ⋯ ⊠ I`（`e_k ∈ 𝓑`）は `𝒜` に属する」を、
Step 2 の必要十分版の結論 `sigma_mem_adjoin_of_necSuf` から得た形（場合分けは具体版
`siteOp_pauliFamily_mem_adjoin` と同じ）。 -/
theorem siteOp_pauliFamily_mem_adjoin_of_necSuf (k : Fin M) (j : Fin 4) :
    siteOp k (pauliFamily j) ∈ Algebra.adjoin ℂ (ZYSet M) := by
  obtain ⟨hz, hy, hx⟩ := sigma_mem_adjoin_of_necSuf k
  fin_cases j
  · change siteOp k (1 : Matrix (Fin 2) (Fin 2) ℂ) ∈ Algebra.adjoin ℂ (ZYSet M)
    rw [siteOp_one]; exact one_mem _
  · exact hx
  · exact hy
  · exact hz

/-! ## Step 3 後半: サイトごとの積 -/

/-- クロネッカー積 `siteProd` を積を保つ写像として束ねたもの（`kronecker_product_rule` (1)）。
必要十分版 `NecSuf.map_mem_of_mulSingle_mem` へ渡すのはこの性質だけである。 -/
noncomputable def siteProdHom (M : ℕ) :
    (Fin M → Matrix (Fin 2) (Fin 2) ℂ) →ₙ* TensorPow M where
  toFun := siteProd M
  map_mul' := siteProd_mul M

@[simp]
theorem siteProdHom_apply (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    siteProdHom M x = siteProd M x := rfl

/-- 「1 サイトだけ動かした族」を送ると、そのサイトのサイト作用素になる（`E_k` の定義）。 -/
theorem siteProdHom_mulSingle (k : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    siteProdHom M (Pi.mulSingle k A) = siteOp k A := by
  rw [siteProdHom_apply, siteOp_apply]
  rfl

/-- **必要十分版 `NecSuf.map_mem_of_mulSingle_mem` の特殊化**:
クロネッカー積 `e_1 ⊠ ⋯ ⊠ e_M` は、各 `E_k` を含む部分多元環に属する
（具体版の `Ising2D.siteProd_mem` と同じ主張。`P_s` の帰納法は必要十分版 `NecSuf.prefixProduct_eq_and_mem` の中にある）。
`M = 0` は具体版の `siteProd_mem` と同じく `siteProd_one` と (ii) で閉じる（人手に現れない場合）。 -/
theorem siteProd_mem_of_necSuf (A : Subalgebra ℂ (TensorPow M))
    (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (h : ∀ k, siteOp k (x k) ∈ A) :
    siteProd M x ∈ A := by
  rcases Nat.eq_zero_or_pos M with hM | hM
  · subst hM
    have hx : x = 1 := funext fun i => i.elim0
    rw [hx, siteProd_one]
    exact one_mem A
  · have := NecSuf.map_mem_of_mulSingle_mem hM (siteProdHom M) A.toSubmonoid.toSubsemigroup x
      (fun k => by rw [siteProdHom_mulSingle]; exact h k)
    rwa [siteProdHom_apply] at this

/-! ## 結論 -/

/-- **`<Z_Y_generate_algebra>` を必要十分版から導出した形**:
`{Z_1, …, Z_M, Y_1, …, Y_M}` が生成する ℂ-部分多元環は `Mat(2^M, ℂ)` 全体である。

具体版 `Ising2D.Z_Y_generate_algebra` と**同じ形の主張**で、具体版と同じく `Mat(2^M, ℂ)` を張る `𝓑^{⊠M}` の元
`e_1 ⊠ ⋯ ⊠ e_M` が `𝒜` に入ることから結論する。論法は `NecSuf/GeneratedByBasis.lean` の
必要十分版（`eq_top_of_span_eq_top`・`map_mem_of_mulSingle_mem`・`string_mem`・`local_mem`）に委ねている。
必要十分版へ渡すのは `𝓑^{⊠M}` が全体を張ること（`<kronecker_family_of_spanning_family_spans>` の必要十分版からの導出
`span_kroneckerFamily_eq_top_of_necSuf`）だけである。 -/
theorem Z_Y_generate_algebra_of_necSuf (M : ℕ) : Algebra.adjoin ℂ (ZYSet M) = ⊤ := by
  refine NecSuf.eq_top_of_span_eq_top _ ?_ (span_kroneckerFamily_eq_top_of_necSuf pauliFamily pauliFamily_spans)
  rintro _ ⟨p, rfl⟩
  exact siteProd_mem_of_necSuf _ _ fun k => siteOp_pauliFamily_mem_adjoin_of_necSuf k (p k)

end Ising2D
