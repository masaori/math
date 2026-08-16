/-
「有理係数の対数順序群の実現写像は順序を保つ」の必要十分版。

具体版が使うのは次だけである。
(1) 値の側 `R` が順序体であること（最後の三段: 乗法の結合則、正の元の逆元は正、`c⁻¹ c = 1`、`1·t = t`、
    正の元を左から掛けても順序が保たれる）。`Field`＋`LinearOrder`＋`IsStrictOrderedRing`。
    使うのは半順序と `PosMulMono`・`PosMulReflectLT` の分だけだが、mathlib の順序体の骨格が線形順序を
    前提にするため `LinearOrder` のまま置く。
(2) 可算側の順序 `le_L a b` が `rat a ≤ rat b`（`Q0` の半順序）へ落ちること、`ι : Q0 → R` が順序を保つこと、
    `lg : P → R` が `val` について単調であること（`P` は具体版の正の実数）、
    `emb : L → X` の実現が `lg (pr a)` に等しく `val (pr a) = ι (rat a)` であること
    （`claim_log_order_group_realization_real_log` の形）、
    `ρ (smul N x) = c N * ρ x`（`claim_rational_log_order_group_realization_smul` の形）、`1 ≤ N → 0 < c N`。
順序 `le_X l m` そのものは受けず、その証人（`1 ≤ N`、`smul N l = emb lN`、`smul N m = emb mN`、`le_L lN mN`）を
仮定として受ける（`∃` を剥がすのは導出側）。`X`・`L`・`Q0`・`P` に代数構造は要らない（`Q0` の半順序だけ）。
実対数・完備性・級数は現れない。証明手順は具体版と同じ（含意の鎖六段と最後の三段）。
-/
import Mathlib.Algebra.Order.Field.Basic

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {R : Type*} [Field R] [LinearOrder R] [IsStrictOrderedRing R]

/-- 最後の三段: `0 < c`、`c * a ≤ c * b` なら `a ≤ b`（順序体で正の元 `c⁻¹` を左から掛ける）。 -/
theorem le_of_smul_le_smul_necSuf {c a b : R} (hc : 0 < c) (h : c * a ≤ c * b) : a ≤ b := by
  have hinv : 0 < c⁻¹ := inv_pos.mpr hc                                 -- 正の元の逆元は正
  calc
    a = c⁻¹ * (c * a) := by rw [← mul_assoc, inv_mul_cancel₀ (ne_of_gt hc), one_mul]
    _ ≤ c⁻¹ * (c * b) := mul_le_mul_of_nonneg_left h (le_of_lt hinv)  -- 正の元を左から掛ける
    _ = b := by rw [← mul_assoc, inv_mul_cancel₀ (ne_of_gt hc), one_mul]

/-- 含意の鎖六段と最後の三段。 -/
theorem realize_monotone_of_common_denominator_necSuf
    {X L Q0 P : Type*} [Preorder Q0]
    (rat : L → Q0) (le_L : L → L → Prop) (hle : ∀ a b : L, le_L a b → rat a ≤ rat b)
    (ι : Q0 → R) (hι : ∀ q q' : Q0, q ≤ q' → ι q ≤ ι q')
    (val : P → R) (lg : P → R) (hlg : ∀ u v : P, val u ≤ val v → lg u ≤ lg v)
    (pr : L → P) (hval : ∀ a : L, val (pr a) = ι (rat a))
    (emb : L → X) (ρ : X → R) (hρemb : ∀ a : L, ρ (emb a) = lg (pr a))
    (smul : ℕ → X → X) (c : ℕ → R) (hρsmul : ∀ (N : ℕ) (x : X), ρ (smul N x) = c N * ρ x)
    (hc : ∀ N : ℕ, 1 ≤ N → 0 < c N)
    (l m : X) (N : ℕ) (lN mN : L) (hN : 1 ≤ N)
    (hl : smul N l = emb lN) (hm : smul N m = emb mN) (hlm : le_L lN mN) :
    ρ l ≤ ρ m := by
  have h1 : rat lN ≤ rat mN := hle lN mN hlm                              -- 可算側の順序の定義
  have h2 : ι (rat lN) ≤ ι (rat mN) := hι _ _ h1                          -- ι は順序を保つ
  have h3 : lg (pr lN) ≤ lg (pr mN) := by                                  -- lg の単調性
    apply hlg
    rw [hval, hval]
    exact h2
  have h4 : ρ (emb lN) ≤ ρ (emb mN) := by                                  -- 実現は lg (pr ·)
    rw [hρemb, hρemb]
    exact h3
  have h5 : ρ (smul N l) ≤ ρ (smul N m) := by                              -- 共通分母の証人
    rw [hl, hm]
    exact h4
  have h6 : c N * ρ l ≤ c N * ρ m := by                                    -- 倍率との可換
    rw [hρsmul, hρsmul] at h5
    exact h5
  exact le_of_smul_le_smul_necSuf (hc N hN) h6                             -- 最後の三段

end Ising2DLambda.NecSuf.ThermodynamicLimit
