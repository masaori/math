/-
# `V^{(+)} = c V̌'`（定数倍を除いて一致）— **本章の結論**

対応する人手証明のラベル: `V_plus_eq_c_check_Vprime`
（`structured-latex/content/016_even_sector_fermions.ts` の
`evenfermi_009_claim_V_plus_eq_c_Vprime`）

## 形式化の方針

原文 Step 1〜5（`W := (V̌')^{-1}V^{(+)}` が可逆 → `W` はすべての元と可換 →
`centralizer_is_scalar` で `W = cI` → `c ≠ 0` → 結論）をそのまま追う。

**本ファイルは `V^{(+)}` の定義（014 章）に依存しない。**
「共役が一致する 2 つの可逆元は定数倍を除いて等しい」という形で述べており、
原文の主張はその特殊化である。008 章の `V_eq_Vprime` と同じく
クリフォード群には依存しない。
-/
import Ising2D.Part016.Claim008_TEq
import Ising2D.Part002.Lemma003_CentralizerIsScalar

namespace Ising2D

variable {M : ℕ}

/-- `T_1 = id`（`TConj` の単位性）。 -/
theorem TConj_one_apply {A : Type*} [Ring A] [Algebra ℂ A] (x : A) : TConj (1 : Aˣ) x = x := by
  rw [TConj_apply]
  simp

/-- **原文 `V_plus_eq_c_check_Vprime` の Step 1・Step 2**:
共役が一致すれば `W := v^{-1}u` はすべての元と可換。 -/
theorem commute_of_TConj_eq (u v : (TensorPow M)ˣ)
    (h : ∀ x : TensorPow M, TConj u x = TConj v x) (x : TensorPow M) :
    ((v⁻¹ * u : (TensorPow M)ˣ) : TensorPow M) * x
      = x * ((v⁻¹ * u : (TensorPow M)ˣ) : TensorPow M) := by
  have hWx : TConj (v⁻¹ * u) x = x := by
    rw [← TConj_trans]
    show TConj v⁻¹ (TConj u x) = x
    rw [h x]
    show TConj v⁻¹ (TConj v x) = x
    rw [← AlgEquiv.trans_apply, TConj_trans, inv_mul_cancel, TConj_one_apply]
  rw [TConj_apply] at hWx
  calc ((v⁻¹ * u : (TensorPow M)ˣ) : TensorPow M) * x
      = (((v⁻¹ * u : (TensorPow M)ˣ) : TensorPow M) * x
          * (((v⁻¹ * u : (TensorPow M)ˣ)⁻¹ : (TensorPow M)ˣ) : TensorPow M))
        * ((v⁻¹ * u : (TensorPow M)ˣ) : TensorPow M) := by
        rw [mul_assoc, Units.inv_mul, mul_one]
    _ = x * ((v⁻¹ * u : (TensorPow M)ˣ) : TensorPow M) := by rw [hWx]

/-- **原文 `V_plus_eq_c_check_Vprime`**（`V^{(+)}` に依存しない一般形）:
共役が一致する 2 つの可逆元は、`0` でないスカラー倍を除いて等しい。 -/
theorem exists_smul_of_TConj_eq (u v : (TensorPow M)ˣ)
    (h : ∀ x : TensorPow M, TConj u x = TConj v x) :
    ∃ c : ℂ, c ≠ 0 ∧ (u : TensorPow M) = c • (v : TensorPow M) := by
  set W : (TensorPow M)ˣ := v⁻¹ * u with hWdef
  obtain ⟨c, hc⟩ := centralizer_is_scalar (W : TensorPow M) (commute_of_TConj_eq u v h)
  have hWne : (W : TensorPow M) ≠ 0 := by
    intro hzero
    have : (1 : TensorPow M) = 0 := by
      have := W.mul_inv
      rw [hzero, zero_mul] at this
      exact this.symm
    exact one_ne_zero this
  have hc0 : c ≠ 0 := by
    intro hc0
    apply hWne
    rw [hc, hc0, zero_smul]
  refine ⟨c, hc0, ?_⟩
  have huv : (u : TensorPow M) = (v : TensorPow M) * (W : TensorPow M) := by
    rw [hWdef, Units.val_mul, ← mul_assoc, Units.mul_inv, one_mul]
  rw [huv, hc, mul_smul_comm, mul_one]

/-- **原文 `V_plus_eq_c_check_Vprime` そのもの（本章の結論）**:
ある `c ∈ ℂ^×` について `V^{(+)} = c V̌'`。 -/
theorem VPlus_eq_smul_checkVprime (K : IsingConst) (g : ℤ → ℂ) (hM : M ≠ 0)
    (hga : ∀ μ : ℤ, CheckIndex M μ → gamma2 K (thetaTilde M μ) ≠ 0)
    (hgconj : ∀ μ : ℤ, CheckIndex M μ → g ((M : ℤ) + 1 - μ) = g μ)
    (uPlus : (TensorPow M)ˣ)
    (hT : ∀ j : Fin M, ActsBy (TConj uPlus).toLinearMap
      (checkZ M (checkIdx M j)) (checkY M (checkIdx M j))
      (AMat K (thetaTilde M (checkIdx M j))))
    (hlamPlus : ∀ j : Fin M, gamma1 K (thetaTilde M (checkIdx M j))
      + ((checkR K M (checkIdx M j) : ℝ) : ℂ) = Complex.exp (g (checkIdx M j)))
    (hlamMinus : ∀ j : Fin M, gamma1 K (thetaTilde M (checkIdx M j))
      - ((checkR K M (checkIdx M j) : ℝ) : ℂ) = Complex.exp (-g (checkIdx M j))) :
    ∃ c : ℂ, c ≠ 0 ∧ (uPlus : TensorPow M) = c • checkVprime K M g :=
  exists_smul_of_TConj_eq uPlus (checkVprimeUnits K M g)
    (TVPlus_eq_TCheckVprime K g hM hga hgconj uPlus hT hlamPlus hlamMinus)

end Ising2D
