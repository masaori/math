/-
# 切断付値 `truncVal`

対応する人手証明:
`integrable-lattice/outputs/paper-plans/002_R_Lambda_duality.md` §2 **命題 A** (3)、
根拠 report `integrable-lattice/outputs/reports/cycle3_T1_D-U2_rigorous.md` 命題 A (3)。

人手証明は「切断付値 $\min(v_p(Z_N),k)$ は $Z_N \bmod p^k$ で決まる」と述べている。
`padicValInt p 0 = 0`（mathlib の規約）なので、$\min(v_p(\cdot),k)$ をそのまま使うと
$z = 0$ で主張が壊れる（$0 \equiv p^k$ だが $\min(v_p 0,k)=0 \neq k$）。
そこで **$k$ で切断した付値そのものを定義に採る**:
`truncVal p k z := max { j ≤ k | p^j ∣ z }`（`Nat.findGreatest`）。
これは $z=0$ でも $k$ を返し、人手証明の意図（$p^k$ を法とした情報だけで決まる量）に一致する。
`truncVal_eq_min_padicValInt` で、$z \neq 0$ のとき $\min(v_p(z),k)$ に一致することを示す。
-/
import Mathlib

open scoped Classical

namespace IntegrableLattice

/-- `Nat.findGreatest` は `k` 以下での述語の値にしか依存しない。 -/
theorem findGreatest_congr {P Q : ℕ → Prop} [DecidablePred P] [DecidablePred Q] :
    ∀ (k : ℕ), (∀ j, j ≤ k → (P j ↔ Q j)) →
      Nat.findGreatest P k = Nat.findGreatest Q k := by
  intro k
  induction k with
  | zero => intro _; simp [Nat.findGreatest]
  | succ n ih =>
      intro h
      have hn : Nat.findGreatest P n = Nat.findGreatest Q n :=
        ih fun j hj => h j (Nat.le_succ_of_le hj)
      have hs : P (n + 1) ↔ Q (n + 1) := h (n + 1) le_rfl
      by_cases hP : P (n + 1)
      · have hQ : Q (n + 1) := hs.mp hP
        rw [Nat.findGreatest_succ, Nat.findGreatest_succ, if_pos hP, if_pos hQ]
      · have hQ : ¬ Q (n + 1) := fun h' => hP (hs.mpr h')
        rw [Nat.findGreatest_succ, Nat.findGreatest_succ, if_neg hP, if_neg hQ, hn]

/-- `k` で切断した `p` 進付値。`max { j ≤ k | p^j ∣ z }`。 -/
noncomputable def truncVal (p k : ℕ) (z : ℤ) : ℕ :=
  Nat.findGreatest (fun j => (p : ℤ) ^ j ∣ z) k

theorem truncVal_le (p k : ℕ) (z : ℤ) : truncVal p k z ≤ k :=
  Nat.findGreatest_le k

/-- **命題 A (3) の核**: 切断付値は `p^k` を法とした剰余だけで決まる。 -/
theorem truncVal_congr_of_dvd (p k : ℕ) {z z' : ℤ} (h : (p : ℤ) ^ k ∣ z - z') :
    truncVal p k z = truncVal p k z' := by
  refine findGreatest_congr k ?_
  intro j hj
  have hjk : (p : ℤ) ^ j ∣ (p : ℤ) ^ k := pow_dvd_pow _ hj
  have hd : (p : ℤ) ^ j ∣ z - z' := hjk.trans h
  constructor
  · intro hz
    have : z' = z - (z - z') := by ring
    rw [this]; exact dvd_sub hz hd
  · intro hz'
    have : z = z' + (z - z') := by ring
    rw [this]; exact dvd_add hz' hd

/-- `z ≠ 0` のとき、切断付値は人手証明の `min (v_p z) k` に一致する。 -/
theorem truncVal_eq_min_padicValInt (p k : ℕ) [hp : Fact p.Prime] {z : ℤ} (hz : z ≠ 0) :
    truncVal p k z = min (padicValInt p z) k := by
  have hdvd : ∀ j : ℕ, ((p : ℤ) ^ j ∣ z) ↔ j ≤ padicValInt p z := by
    intro j
    rw [padicValInt, ← Int.natAbs_dvd_natAbs, Int.natAbs_pow, Int.natAbs_natCast]
    rw [padicValNat_dvd_iff]
    constructor
    · rintro (h | h)
      · exact absurd (Int.natAbs_eq_zero.mp h) hz
      · exact h
    · intro h; exact Or.inr h
  refine le_antisymm ?_ ?_
  · refine le_min ?_ (truncVal_le p k z)
    -- `P 0` は自明に成り立つので `Nat.findGreatest_spec` が使える。
    have hspec : (p : ℤ) ^ (truncVal p k z) ∣ z :=
      Nat.findGreatest_spec (P := fun j => (p : ℤ) ^ j ∣ z) (m := 0) (Nat.zero_le _) (by simp)
    exact (hdvd _).mp hspec
  · exact Nat.le_findGreatest (min_le_right _ _) ((hdvd _).mpr (min_le_left _ _))

end IntegrableLattice
