/-
「正の有理数の対数は全射である」の必要十分版。

具体版の有限積による構成が使うのは、正の生成元 `base i`、対数の単位元・積・逆元での規則、
および各生成元が一係数の有限台写像へ移ることだけである。素数、素因数分解、係数体が ℚ で
あることは仮定しない。証明手順は具体版と同じく、整数冪を調べて有限積を帰納する。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FreeEntropy

variable {I A : Type*} [DecidableEq I] [Field A] [LinearOrder A] [IsStrictOrderedRing A]

/-- 有限台の整数係数を、正の生成元の整数冪の有限積として実現する。 -/
noncomputable def realize (base : I → A) (eta : I →₀ ℤ) : A :=
  eta.prod fun i z => base i ^ z

lemma realize_pos (base : I → A) (hbasePos : ∀ i, 0 < base i) (eta : I →₀ ℤ) :
    0 < realize base eta := by
  classical
  unfold realize
  exact Finset.prod_pos fun i hi => zpow_pos (hbasePos i) _

/-- 生成元の対数規則だけから、生成元の任意の整数冪の対数を計算できる。 -/
lemma log_base_zpow_necSuf (base : I → A) (log : A → I →₀ ℤ)
    (hbasePos : ∀ i, 0 < base i)
    (hone : log 1 = 0)
    (hmul : ∀ {x y : A}, 0 < x → 0 < y → log (x * y) = log x + log y)
    (hinv : ∀ {x : A}, 0 < x → log x⁻¹ = -log x)
    (hbase : ∀ i, log (base i) = Finsupp.single i 1)
    (i : I) (z : ℤ) : log (base i ^ z) = z • Finsupp.single i 1 := by
  have hpow : ∀ n : ℕ, log (base i ^ n) = n • Finsupp.single i 1 := by
    intro n
    induction n with
    | zero => simp [hone]
    | succ n ih =>
        rw [pow_succ, hmul (pow_pos (hbasePos i) n) (hbasePos i), ih, hbase, succ_nsmul]
  cases z with
  | ofNat n =>
      simpa using hpow n
  | negSucc n =>
      rw [zpow_negSucc, hinv (pow_pos (hbasePos i) (n + 1))]
      rw [hpow]
      simp [Int.negSucc_eq]

/-- 有限積構成が任意の有限台指数ベクトルを対数の像として実現する。 -/
theorem log_realize_necSuf (base : I → A) (log : A → I →₀ ℤ)
    (hbasePos : ∀ i, 0 < base i)
    (hone : log 1 = 0)
    (hmul : ∀ {x y : A}, 0 < x → 0 < y → log (x * y) = log x + log y)
    (hinv : ∀ {x : A}, 0 < x → log x⁻¹ = -log x)
    (hbase : ∀ i, log (base i) = Finsupp.single i 1)
    (eta : I →₀ ℤ) : log (realize base eta) = eta := by
  classical
  induction eta using Finsupp.induction with
  | zero => simp [realize, hone]
  | single_add i z f hi hz ih =>
      rw [realize, Finsupp.prod_add_index' (fun _ => zpow_zero _)
          (fun j m n => zpow_add₀ (ne_of_gt (hbasePos j)) m n),
        Finsupp.prod_single_index (zpow_zero _)]
      change log (base i ^ z * realize base f) = Finsupp.single i z + f
      rw [hmul (zpow_pos (hbasePos i) z) (realize_pos base hbasePos f),
        log_base_zpow_necSuf base log hbasePos hone hmul hinv hbase i z, ih]
      ext j
      simp

end Ising2DLambda.NecSuf.FreeEntropy
