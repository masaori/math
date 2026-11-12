/-
# 張る族のクロネッカー積の族は全体を張る

対応する人手証明:
`structured-latex/content/002_linear_space_general.ts` の `kronecker_family_of_spanning_family_spans`

人手の `b_1, …, b_4` は Lean の `b : Fin 4 → Mat(2, ℂ)`（添字は `0, …, 3`）、人手の `𝒫 = {1,2,3,4}^M` の元
`π(q) = (a_1, …, a_M)` は Lean の `p : Fin M → Fin 4` である。人手は `def_finite_sum_of_matrices` の
`1, …, N` の和に合わせるために `𝒫` を全単射 `π` で並べるが、Lean は `p` を添字とする有限和で書き、並べ替えは置かない。
人手のサイト `k`（`1 ≤ k ≤ M`）は Lean の `k - 1`（0 始まり）である。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `F_q := b_{π(q)_1} ⊠ ⋯ ⊠ b_{π(q)_M}` | `kroneckerFamily b p` |
| `𝒮 := {Σ_q d_q F_q}` | `kroneckerFamilyCombinations b` |
| Step 1（`𝒮` は ℂ-線型結合について閉じる。5 行の鎖） | `linComb_mem_kroneckerFamilyCombinations`（`calc` の 5 段） |
| Step 2 の `kronecker_multilinear`（`j → s+1, r → 4, B_a → b_a`） | `siteProd_update_sum_smul`（Lean の具体版は無いので `siteProd` の多重線型性） |
| Step 2（`C(s)` の帰納法。`s = 0` の 5 行の鎖と一段の 2 行の鎖） | `siteProd_mem_kroneckerFamilyCombinations` |
| Step 3 の `E_{I,J} = E_{i_1j_1} ⊠ ⋯ ⊠ E_{i_Mj_M}`（`tensor_basis` の定義と、その Step 2 の行列単位であること） | `E_eq_siteProd_single` |
| Step 3（`tensor_basis` (1) の展開、`C(M)`、Step 1 で結ぶ） | `kronecker_family_of_spanning_family_spans` |

必要十分版は `Ising2D/NecSuf/MultilinearImageOfSpanningFamilySpans.lean`、
具体版をその特殊化として得る導出は `ClaimKroneckerFamilyOfSpanningFamilySpansFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.TheoremTensorBasisFromNecSuf

namespace Ising2D

variable {M : ℕ}

/-- 人手の `F_q := b_{π(q)_1} ⊠ ⋯ ⊠ b_{π(q)_M}`（`p` は人手の `π(q)`）。 -/
noncomputable def kroneckerFamily (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ) (p : Fin M → Fin 4) :
    TensorPow M :=
  siteProd M (fun k => b (p k))

/-- 人手の `𝒮 := {Σ_q d_q F_q : d_1, …, d_N ∈ ℂ}`。 -/
def kroneckerFamilyCombinations (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ) : Set (TensorPow M) :=
  {X | ∃ d : (Fin M → Fin 4) → ℂ, X = ∑ p, d p • kroneckerFamily b p}

/-- 人手 Step 1: `𝒮` は ℂ-線型結合について閉じる。人手の `a = 1, …, r` は Lean の有限集合 `t` の元で、
`X_a = Σ_q d^{(a)}_q F_q` の係数 `d^{(a)}` は `choose!` で取る。 -/
theorem linComb_mem_kroneckerFamilyCombinations (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ)
    {ι : Type*} (t : Finset ι) (X : ι → TensorPow M) (κ : ι → ℂ)
    (hX : ∀ a ∈ t, X a ∈ kroneckerFamilyCombinations b) :
    ∑ a ∈ t, κ a • X a ∈ kroneckerFamilyCombinations b := by
  choose! d hd using hX
  refine ⟨fun p => ∑ a ∈ t, κ a * d a p, ?_⟩
  calc ∑ a ∈ t, κ a • X a
      = ∑ a ∈ t, κ a • ∑ p, d a p • kroneckerFamily b p :=
        Finset.sum_congr rfl fun a ha => by rw [← hd a ha]               -- `X_a` の表示
    _ = ∑ a ∈ t, ∑ p, κ a • (d a p • kroneckerFamily b p) := by
        simp_rw [Finset.smul_sum]                                         -- `finite_sum_of_scalar_multiples` を右辺から左辺へ、各 `a` へ
    _ = ∑ a ∈ t, ∑ p, (κ a * d a p) • kroneckerFamily b p := by
        simp_rw [smul_smul]                                               -- `scalar_multiple_is_associative` を各項へ
    _ = ∑ p, ∑ a ∈ t, (κ a * d a p) • kroneckerFamily b p :=
        Finset.sum_comm                                                   -- `finite_double_sum_of_matrices_interchange`
    _ = ∑ p, (∑ a ∈ t, κ a * d a p) • kroneckerFamily b p := by
        simp_rw [Finset.sum_smul]                                         -- `finite_sum_of_scalar_multiples_of_one_matrix` を各 `q` へ

/-- 人手 Step 2 が引く `kronecker_multilinear`（`j` 番目の因子を `Σ_a c_a B_a` に置いたクロネッカー積の展開）。
`kronecker_multilinear` の Lean の具体版は無いので、`siteProd` の多重線型性
（`MultilinearMap.map_update_sum`・`MultilinearMap.map_update_smul`）を当てる。 -/
theorem siteProd_update_sum_smul (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (j : Fin M)
    {ι : Type*} (t : Finset ι) (c : ι → ℂ) (B : ι → Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd M (Function.update x j (∑ a ∈ t, c a • B a))
      = ∑ a ∈ t, c a • siteProd M (Function.update x j (B a)) := by
  rw [MultilinearMap.map_update_sum]
  exact Finset.sum_congr rfl fun a _ => (siteProd M).map_update_smul x j (c a) (B a)

/-- 人手 Step 2: `s ∈ {0, …, M}` についての帰納法で示す `C(s)`:
`s < k ≤ M` のすべての `k` で `X_k ∈ {b_1, …, b_4}` ならば `X_1 ⊠ ⋯ ⊠ X_M ∈ 𝒮`。
人手の `s < k`（`k` は 1 始まり）は Lean の `s ≤ k`（`k` は 0 始まり）、人手の第 `s+1` 因子は Lean の `⟨s, _⟩` である。
`s = 0` の `δ_{qq_0}` は Lean の `if q = p then 1 else 0`（`p` は人手の `π(q_0)`）。 -/
theorem siteProd_mem_kroneckerFamilyCombinations (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ)
    (hb : ∀ A : Matrix (Fin 2) (Fin 2) ℂ, ∃ c : Fin 4 → ℂ, A = ∑ a, c a • b a) :
    ∀ s : ℕ, s ≤ M → ∀ x : Fin M → Matrix (Fin 2) (Fin 2) ℂ,
      (∀ k : Fin M, s ≤ (k : ℕ) → x k ∈ Set.range b) →
        siteProd M x ∈ kroneckerFamilyCombinations b
  | 0, _, x, hx => by
    choose p hp using fun k => hx k (Nat.zero_le _)                       -- `X_k = b_{a_k}`
    refine ⟨fun q => if q = p then 1 else 0, ?_⟩                          -- `d_q := δ_{qq_0}`
    calc siteProd M x
        = siteProd M (fun k => b (p k)) := by
          congr 1; funext k; exact (hp k).symm                            -- `X_k = b_{a_k}`
      _ = kroneckerFamily b p := rfl                                      -- `q_0` と `F_{q_0}` の定義
      _ = (1 : ℂ) • kroneckerFamily b p := (one_smul ℂ _).symm            -- `scalar_multiple_by_one` を右辺から左辺へ
      _ = (if p = p then (1 : ℂ) else 0) • kroneckerFamily b p := by
          rw [if_pos rfl]                                                 -- `def_kronecker_delta`
      _ = ∑ q, (if q = p then (1 : ℂ) else 0) • kroneckerFamily b q := by
          rw [Finset.sum_eq_single p
            (fun q _ hq => by rw [if_neg hq, zero_smul])                  -- `def_kronecker_delta` と `zero_scalar_multiple_is_zero_matrix`
            (fun h => absurd (Finset.mem_univ p) h)]                      -- `finite_sum_of_matrices_with_single_nonzero_term` を右辺から左辺へ
  | s + 1, hs, x, hx => by
    have hsM : s < M := hs
    obtain ⟨c, hc⟩ := hb (x ⟨s, hsM⟩)                                     -- 仮定: `X_{s+1} = Σ_a c_a b_a`
    have hexp : siteProd M x
        = ∑ a, c a • siteProd M (Function.update x ⟨s, hsM⟩ (b a)) := by
      calc siteProd M x
          = siteProd M (Function.update x ⟨s, hsM⟩ (∑ a, c a • b a)) := by
            rw [← hc, Function.update_eq_self]                            -- `X_{s+1}` の表示
        _ = ∑ a, c a • siteProd M (Function.update x ⟨s, hsM⟩ (b a)) :=
            siteProd_update_sum_smul x ⟨s, hsM⟩ Finset.univ c b           -- `kronecker_multilinear`（`j → s+1, r → 4, B_a → b_a`）
    rw [hexp]
    refine linComb_mem_kroneckerFamilyCombinations b Finset.univ _ c fun a _ => ?_   -- Step 1（`r → 4, κ_a → c_a`）
    refine siteProd_mem_kroneckerFamilyCombinations b hb s (Nat.le_of_lt hsM) _ fun k hk => ?_   -- 帰納法の仮定 `C(s)`
    by_cases hks : k = ⟨s, hsM⟩
    · subst hks
      rw [Function.update_self]                                           -- 第 `s+1` 因子は `b_a`
      exact ⟨a, rfl⟩
    · rw [Function.update_of_ne hks]                                      -- 第 `s+2` 以降の因子は `X_k ∈ {b_1, …, b_4}`
      have hne : (k : ℕ) ≠ s := fun h => hks (Fin.ext h)
      exact hx k (by omega)

/-- 人手 Step 3 が使う `E_{I,J} = E_{i_1j_1} ⊠ ⋯ ⊠ E_{i_Mj_M}`: Lean の `E I J`（`TensorPow M` の行列単位）は、
`Mat(2, ℂ)` の行列単位の `M` 個のクロネッカー積である。`tensor_basis` の Step 2 の 3 行の鎖
（クロネッカー積の成分の定め方・`(E_{ij})_{st} = δ_{is}δ_{jt}`・添字の一致による場合分け）と同じ順に示す。 -/
theorem E_eq_siteProd_single (I J : Conf M) :
    E I J = siteProd M (fun k => Matrix.single (I k) (J k) (1 : ℂ)) := by
  ext K L
  symm
  calc siteProd M (fun k => Matrix.single (I k) (J k) (1 : ℂ)) K L
      = ∏ k, Matrix.single (I k) (J k) (1 : ℂ) (K k) (L k) :=
        siteProd_apply M _ K L                                            -- クロネッカー積の成分の定め方
    _ = ∏ k, (if I k = K k ∧ J k = L k then (1 : ℂ) else 0) := by
        simp only [Matrix.single_apply]                                   -- `(E_{ij})_{st} = δ_{is}δ_{jt}`
    _ = (if I = K ∧ J = L then (1 : ℂ) else 0) := by
        rw [Finset.prod_boole]                                            -- 添字の一致による場合分け
        simp [funext_iff, forall_and]
    _ = E I J K L := by
        show _ = Matrix.single I J (1 : ℂ) K L
        rw [Matrix.single_apply]                                          -- `E_{I,J}` は行列単位

/-- **`<kronecker_family_of_spanning_family_spans>` の形式化**: `b_1, …, b_4` が `Mat(2, ℂ)` を張るならば、
任意の `X ∈ Mat(2^M, ℂ)` は `b_{a_1} ⊠ ⋯ ⊠ b_{a_M}` の ℂ-線型結合である。

人手 Step 3: `tensor_basis` (1) の展開 `X = Σ_{I,J} X_{IJ} E_{I,J}`（Lean の `matrix_eq_sum_E`）、
各 `E_{I,J}` が `C(M)`（条件は空）で `𝒮` に入ること、Step 1 で結ぶ。 -/
theorem kronecker_family_of_spanning_family_spans (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ)
    (hb : ∀ A : Matrix (Fin 2) (Fin 2) ℂ, ∃ c : Fin 4 → ℂ, A = ∑ a, c a • b a)
    (X : TensorPow M) :
    ∃ d : (Fin M → Fin 4) → ℂ, X = ∑ p, d p • siteProd M (fun k => b (p k)) := by
  have hE : ∀ IJ ∈ (Finset.univ : Finset (Conf M × Conf M)),
      E IJ.1 IJ.2 ∈ kroneckerFamilyCombinations b := fun IJ _ => by
    rw [E_eq_siteProd_single]                                             -- `E_{I,J} = E_{i_1j_1} ⊠ ⋯ ⊠ E_{i_Mj_M}`
    exact siteProd_mem_kroneckerFamilyCombinations b hb M le_rfl _
      fun k hk => absurd hk (by omega)                                    -- `C(M)`（`M < k` となる `k` は無い）
  have h := linComb_mem_kroneckerFamilyCombinations b Finset.univ
    (fun IJ : Conf M × Conf M => E IJ.1 IJ.2) (fun IJ => X IJ.1 IJ.2) hE  -- Step 1（`r → N, X_t → E_{I_t,J_t}`）
  rw [← matrix_eq_sum_E M X] at h                                         -- `tensor_basis` (1): `X = Σ κ_t E_{I_t,J_t}`
  exact h

end Ising2D
