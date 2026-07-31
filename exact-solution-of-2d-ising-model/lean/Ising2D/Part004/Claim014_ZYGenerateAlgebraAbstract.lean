/-
# `<Z_Y_generate_algebra>` — 具体版を抽象版の特殊化として導出する

対応する人手証明:
`parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ` (`<Z_Y_generate_algebra>`)

## このファイルの位置づけ（README のゴール設定 4 節「2 本立て」）

| | 定理 | 何を仮定しているか |
| --- | --- | --- |
| **具体版** | `Ising2D.Z_Y_generate_algebra`（`Claim014_ZYGenerateAlgebra.lean`） | 複素行列・クロネッカー積・Pauli 行列 |
| **抽象版** | `Abstract.string_mem` / `Abstract.local_mem` / `Abstract.map_mem_of_mulSingle_mem` / `Abstract.eq_top_of_basis_mem`（`Abstract/GeneratedByBasis.lean`） | 可換半環 `R` 上の代数、有限添字の直積モノイド、基底 |

本ファイルは、同じ結論 `Algebra.adjoin ℂ (ZYSet M) = ⊤` を
**抽象版だけを論法として使って**導き直す（`Z_Y_generate_algebra_of_abstract`）。

## 特殊化で埋めた「具体的な部分」

抽象版に渡すために本ファイルで補ったのは次の 3 つだけである。
裏を返せば、原文の証明のうち **本当に複素 2×2 行列に依存しているのはこの 3 つだけ**である。

1. `span_pauli_eq_top`: `{I, σ^x, σ^y, σ^z}` が `Mat(2, ℂ)` を ℂ-加群として張ること
   （原文 Step 3 前半の成分比較。`matrix_two_decomp` そのもの）。
2. `siteProdHom`: クロネッカー積 `siteProd` がモノイド準同型であること
   （`siteProd_one` と `siteProd_mul` を束ねただけ）。
3. `E_eq_siteProd`（既存）: 行列単位 `E_{IJ}` が各サイトの行列単位のテンソル積であること。

Step 2（Jordan–Wigner 文字列の帰納法）は、`P_m P_m = I` から得られる分解
`σ^z_m = P_m Z_m`, `σ^y_m = P_m Y_m` と漸化式 `P_{m+1} = P_m σ^x_m` を渡すだけで、
帰納法そのものは抽象版 `Abstract.string_mem` が担う。

## 抽象版へ渡すための ℕ 添字化

抽象版はサイト添字を `ℕ` にとり、仮定を `n < N` の範囲でだけ課す。
具体版のサイト添字は `Fin M` なので、`M` 未満では対応する元、`M` 以上では `1` を返す
族（`ZNat` 等）を作って渡す。範囲外の値は抽象版の仮定にも結論にも現れない。
-/
import Ising2D.Abstract.GeneratedByBasis
import Ising2D.Part004.Claim014_ZYGenerateAlgebra

namespace Ising2D

variable {M : ℕ}

/-! ## ℕ 添字への読み替え -/

/-- 抽象版へ渡すための `Z` の ℕ 添字版（`M` 以上では単位元）。 -/
noncomputable def ZNat (M : ℕ) (n : ℕ) : TensorPow M :=
  if h : n < M then Z ⟨n, h⟩ else 1

/-- 抽象版へ渡すための `Y` の ℕ 添字版。 -/
noncomputable def YNat (M : ℕ) (n : ℕ) : TensorPow M :=
  if h : n < M then Y ⟨n, h⟩ else 1

/-- 抽象版へ渡すための `σ^z` の ℕ 添字版。 -/
noncomputable def sigmaZNat (M : ℕ) (n : ℕ) : TensorPow M :=
  if h : n < M then sigmaZ ⟨n, h⟩ else 1

/-- 抽象版へ渡すための `σ^y` の ℕ 添字版。 -/
noncomputable def sigmaYNat (M : ℕ) (n : ℕ) : TensorPow M :=
  if h : n < M then sigmaY ⟨n, h⟩ else 1

/-- 抽象版へ渡すための `σ^x` の ℕ 添字版。 -/
noncomputable def sigmaXNat (M : ℕ) (n : ℕ) : TensorPow M :=
  if h : n < M then sigmaX ⟨n, h⟩ else 1

/-! ## Step 2 を抽象版から導出する -/

/-- **原文 Step 2（`P_m ∈ 𝒜`）を抽象版 `Abstract.string_mem` の特殊化として導出した形**。 -/
theorem xString_mem_adjoin_of_abstract (n : ℕ) (hn : n ≤ M) :
    xString M n ∈ Algebra.adjoin ℂ (ZYSet M) := by
  refine Abstract.string_mem (S := Algebra.adjoin ℂ (ZYSet M)) (p := xString M)
    (z := ZNat M) (y := YNat M) (zl := sigmaZNat M) (yl := sigmaYNat M) (xl := sigmaXNat M)
    (r := -Complex.I) (N := M) (xString_zero) ?_ ?_ ?_ ?_ ?_ ?_ n hn
  · intro k hk
    rw [sigmaZNat, dif_pos hk, ZNat, dif_pos hk, sigmaZ_eq_xString_mul]
  · intro k hk
    rw [sigmaYNat, dif_pos hk, YNat, dif_pos hk, sigmaY_eq_xString_mul]
  · intro k hk
    rw [sigmaXNat, dif_pos hk, sigmaYNat, dif_pos hk, sigmaZNat, dif_pos hk, sigmaX_eq]
  · intro k hk
    rw [sigmaXNat, dif_pos hk, xString_succ k hk]
  · intro k hk
    rw [ZNat, dif_pos hk]
    exact Z_mem_adjoin _
  · intro k hk
    rw [YNat, dif_pos hk]
    exact Y_mem_adjoin _

/-- 抽象版 `Abstract.local_mem` の特殊化: `σ^z_k, σ^y_k, σ^x_k ∈ 𝒜`。 -/
theorem sigma_mem_adjoin_of_abstract (k : Fin M) :
    sigmaZ k ∈ Algebra.adjoin ℂ (ZYSet M) ∧ sigmaY k ∈ Algebra.adjoin ℂ (ZYSet M) ∧
      sigmaX k ∈ Algebra.adjoin ℂ (ZYSet M) := by
  have h := Abstract.local_mem (S := Algebra.adjoin ℂ (ZYSet M)) (p := xString M)
    (z := ZNat M) (y := YNat M) (zl := sigmaZNat M) (yl := sigmaYNat M) (xl := sigmaXNat M)
    (r := -Complex.I) (N := M) (xString_zero)
    (by intro n hn; rw [sigmaZNat, dif_pos hn, ZNat, dif_pos hn, sigmaZ_eq_xString_mul])
    (by intro n hn; rw [sigmaYNat, dif_pos hn, YNat, dif_pos hn, sigmaY_eq_xString_mul])
    (by intro n hn; rw [sigmaXNat, dif_pos hn, sigmaYNat, dif_pos hn, sigmaZNat, dif_pos hn,
      sigmaX_eq])
    (by intro n hn; rw [sigmaXNat, dif_pos hn, xString_succ n hn])
    (by intro n hn; rw [ZNat, dif_pos hn]; exact Z_mem_adjoin _)
    (by intro n hn; rw [YNat, dif_pos hn]; exact Y_mem_adjoin _)
    (k : ℕ) k.isLt
  rw [sigmaZNat, dif_pos k.isLt, sigmaYNat, dif_pos k.isLt, sigmaXNat, dif_pos k.isLt] at h
  simpa using h

/-! ## Step 3 前半: `{I, σ^x, σ^y, σ^z}` が `Mat(2, ℂ)` を張る -/

/-- 原文 Step 3 の成分比較（`matrix_two_decomp`）を「生成系が全体を張る」と言い換えた形。
抽象版 `Abstract.map_mem_of_span_eq_top` へ渡すのはこれだけである。 -/
theorem span_pauli_eq_top :
    Submodule.span ℂ ({1, pauliX, pauliY, pauliZ} : Set (Matrix (Fin 2) (Fin 2) ℂ)) = ⊤ := by
  refine eq_top_iff.2 fun B _ => ?_
  rw [matrix_two_decomp B]
  refine add_mem (add_mem (add_mem ?_ ?_) ?_) ?_ <;>
    exact Submodule.smul_mem _ _ (Submodule.subset_span (by simp))

/-- **抽象版 `Abstract.map_mem_of_span_eq_top` の特殊化**:
どんな `B ∈ Mat(2, ℂ)` を第 `k` 因子に載せても `𝒜` に入る。
`siteOp k` が ℂ-線型であることと、上の生成系だけで従う。 -/
theorem siteOp_mem_adjoin_of_abstract (k : Fin M) (B : Matrix (Fin 2) (Fin 2) ℂ) :
    siteOp k B ∈ Algebra.adjoin ℂ (ZYSet M) := by
  refine Abstract.map_mem_of_span_eq_top _ (siteOp k) span_pauli_eq_top ?_ B
  intro v hv
  obtain ⟨hz, hy, hx⟩ := sigma_mem_adjoin_of_abstract k
  rcases hv with rfl | rfl | rfl | rfl
  · rw [siteOp_one]; exact one_mem _
  · exact hx
  · exact hy
  · exact hz

/-! ## Step 3 後半: サイトごとの積 -/

/-- クロネッカー積 `siteProd` をモノイド準同型として束ねたもの。
抽象版 `Abstract.map_mem_of_mulSingle_mem` へ渡すのはこの準同型性だけである。 -/
noncomputable def siteProdHom (M : ℕ) :
    (Fin M → Matrix (Fin 2) (Fin 2) ℂ) →* TensorPow M where
  toFun := siteProd M
  map_one' := siteProd_one M
  map_mul' := siteProd_mul M

@[simp]
theorem siteProdHom_apply (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    siteProdHom M x = siteProd M x := rfl

/-- 「1 サイトだけ動かした族」を送ると、そのサイトのサイト作用素になる。 -/
theorem siteProdHom_mulSingle (k : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    siteProdHom M (Pi.mulSingle k A) = siteOp k A := by
  rw [siteProdHom_apply, siteOp_apply]
  rfl

/-- **抽象版 `Abstract.map_mem_of_mulSingle_mem` の特殊化**:
単項テンソル `A_1 ⊗ ⋯ ⊗ A_M` は、各因子をサイト作用素として含む部分多元環に属する
（具体版の `Ising2D.siteProd_mem` と同じ主張を、有限集合の帰納法を使わずに得たもの）。 -/
theorem siteProd_mem_of_abstract (A : Subalgebra ℂ (TensorPow M))
    (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (h : ∀ k, siteOp k (x k) ∈ A) :
    siteProd M x ∈ A := by
  have := Abstract.map_mem_subalgebra_of_mulSingle_mem (siteProdHom M) A x
    (fun k => by rw [siteProdHom_mulSingle]; exact h k)
  rwa [siteProdHom_apply] at this

/-! ## 結論 -/

/-- **`<Z_Y_generate_algebra>` を抽象版から導出した形**:
`{Z_1, …, Z_M, Y_1, …, Y_M}` が生成する ℂ-部分多元環は `Mat(2, ℂ)^{⊗M}` 全体である。

具体版 `Ising2D.Z_Y_generate_algebra` と**同じ形の主張**であり、
論法はすべて `Abstract/GeneratedByBasis.lean` の抽象版に委ねている。 -/
theorem Z_Y_generate_algebra_of_abstract (M : ℕ) : Algebra.adjoin ℂ (ZYSet M) = ⊤ := by
  refine Abstract.eq_top_of_basis_mem _ (matrixUnitBasis M) fun IJ => ?_
  rw [matrixUnitBasis_apply, E_eq_siteProd]
  exact siteProd_mem_of_abstract _ _ fun k => siteOp_mem_adjoin_of_abstract k _

end Ising2D
