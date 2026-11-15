/-
「自己双対点より高温側での分配多項式の両側評価」（`claim_high_temperature_partition_bounds`）の具体版。
`0 < q < 1`、`q² + 2q − 1 > 0` なら `¼ M^abs_L(q) ≤ Z_L(q) ≤ 2 M^abs_L(q)`。

  人手証明                                                    このファイル・引く具体版
  `t := KW(q)`、`0 < t < 1`、`t² + 2t − 1 < 0`                  `kwDualTransform_preservesUnitInterval`・`kwDualRational_selfDual_neg`
  四つの `Q^{a,b}_L(t)` は正（`claim_signed_even_subgraph_rational_sign`）
                                                              `signedEvenSubgraphPolynomial_rational_sign`
  下界 `Z_L(q) ≥ (1+q)^{2L²}/2^{L²+2} · M_L(t)` と上界 `Z_L(q) ≤ 2 M^abs_L(q)`
                                                              `highTemperatureDualBounds`
  `claim_signed_even_subgraph_duality_up_to_sign` を `x = q` で評価し、
  有理数から代数的数への単射（`def_algebraic_numbers`）で有理数の等号にする
    `(1+q)^{2L²}/2^{L²} · Q^{a,b}_L(t) = ε Q^{a,b}_L(q)`        `signedEvenSubgraphDuality_up_to_sign`・`dualityUpToSign_eval_rat`
    `= |Q^{a,b}_L(q)|`（左辺は正で `ε ∈ {1, −1}`）              `dualityScaled_eq_abs`
  `(1+q)^{2L²}/2^{L²} · M_L(t) = M^abs_L(q)`（正の有理数倍は最大値を保つ）
                                                              `dualityScaledMax_eq_absMax`
  `Z_L(q) ≥ (1+q)^{2L²}/2^{L²+2} M_L(t) = ¼ M^abs_L(q)`

符号 `ε` の値は使わない。必要十分版の定理・定義は使わない。住処は ℚ（Qbar は自己双対変換の等式を
評価する所と、四つの値の符号の判定だけに通る）。実数体・複素数体は現れない。
-/
import Ising2DLambda.KacWard.HighTemperatureDualBounds
import Ising2DLambda.KacWard.SignedEvenSubgraphDualityUpToSign

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Ising2DLambda.PartitionPolynomial

/-- 係数を Qbar に送った `Q^{a,b}_L` を有理点で評価した値は、係数を ℚ に送って評価した値の像。 -/
theorem signedEvenSubgraphPolynomial_qbar_eval_rat (L : ℕ) [NeZero L] (s : SpinStructure)
    (r : ℚ) :
    ((signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
        (Int.castRingHom Qbar)).eval (r : Qbar) =
      ((signedEvenSubgraphValue L r s : ℚ) : Qbar) := by
  rw [signedEvenSubgraphValue, eval_map, eval_map]
  have h := Polynomial.hom_eval₂
    (signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2))
    (Int.castRingHom ℚ) (Rat.castHom Qbar) r
  rw [RingHom.ext_int ((Rat.castHom Qbar).comp (Int.castRingHom ℚ)) (Int.castRingHom Qbar)] at h
  simpa using h.symm

/-- `claim_signed_even_subgraph_duality_up_to_sign` を `x = q` で評価し、有理数から代数的数への単射で
有理数の等号にしたもの: `(1+q)^{2L²} Q^{a,b}_L(t) = 2^{L²} Q^{a,b}_L(q)` または `−2^{L²} Q^{a,b}_L(q)`。 -/
theorem dualityUpToSign_eval_rat (L : ℕ) [NeZero L] (z : Qbar) (hz4 : z ^ 4 = -1)
    (s : SpinStructure) {q : ℚ} (hq0 : 0 < q) :
    (1 + q) ^ (2 * L ^ 2) * signedEvenSubgraphValue L (kwDualRational q) s =
        2 ^ (L ^ 2) * signedEvenSubgraphValue L q s ∨
      (1 + q) ^ (2 * L ^ 2) * signedEvenSubgraphValue L (kwDualRational q) s =
        -(2 ^ (L ^ 2) * signedEvenSubgraphValue L q s) := by
  have hx : (1 : Qbar) + (q : Qbar) ≠ 0 := by
    have h : (0 : ℚ) < 1 + q := by linarith
    exact_mod_cast ne_of_gt h
  -- `KW(q)` を Qbar へ送ったもの
  have hkw : ((kwDualRational q : ℚ) : Qbar) = (1 - (q : Qbar)) / (1 + (q : Qbar)) := by
    rw [kwDualRational]
    push_cast
    rw [div_eq_mul_inv]
  -- 分母を払った式の `x = q` での値
  have heval := signedEvenSubgraphDualityCleared_eval L (spinComponentFin s.1)
    (spinComponentFin s.2) (q : Qbar) hx
  rw [← hkw, signedEvenSubgraphPolynomial_qbar_eval_rat] at heval
  -- 有理数から代数的数への単射
  have hinj : Function.Injective (fun r : ℚ => (r : Qbar)) := (Rat.castHom Qbar).injective
  rcases signedEvenSubgraphDuality_up_to_sign L z hz4 s with h | h
  · left
    apply hinj
    have h' := congrArg (fun P : QbarPoly => P.eval (q : Qbar)) h
    simp only [Polynomial.eval_mul, Polynomial.eval_pow, Polynomial.eval_ofNat] at h'
    rw [heval, signedEvenSubgraphPolynomial_qbar_eval_rat] at h'
    push_cast
    exact h'
  · right
    apply hinj
    have h' := congrArg (fun P : QbarPoly => P.eval (q : Qbar)) h
    simp only [Polynomial.eval_neg, Polynomial.eval_mul, Polynomial.eval_pow,
      Polynomial.eval_ofNat] at h'
    rw [heval, signedEvenSubgraphPolynomial_qbar_eval_rat] at h'
    push_cast
    exact h'

/-- 各 `(a,b)` について `(1+q)^{2L²}/2^{L²} · Q^{a,b}_L(t) = |Q^{a,b}_L(q)|`（左辺は正で `ε ∈ {1, −1}`）。 -/
theorem dualityScaled_eq_abs (data : RealClosedSubfieldData) (L : ℕ) [NeZero L] (z : Qbar)
    (hz4 : z ^ 4 = -1) (s : SpinStructure) {q : ℚ} (hq0 : 0 < q) (hq1 : q < 1)
    (hc : 0 < q ^ 2 + 2 * q - 1) :
    (1 + q) ^ (2 * L ^ 2) / 2 ^ (L ^ 2) * signedEvenSubgraphValue L (kwDualRational q) s =
      |signedEvenSubgraphValue L q s| := by
  have hqI : q ∈ unitIntervalRationals := ⟨hq0, hq1⟩
  obtain ⟨⟨ht0, ht1⟩, -⟩ := kwDualTransform_preservesUnitInterval hqI
  have htc := kwDualRational_selfDual_neg hq0 hc
  -- `Q^{a,b}_L(t) > 0`（`claim_signed_even_subgraph_rational_sign`）
  have hpos : 0 < signedEvenSubgraphValue L (kwDualRational q) s :=
    (signedEvenSubgraphPolynomial_rational_sign data z hz4 s _ ht0 ht1).1 htc
  have h2pos : (0 : ℚ) < 2 ^ (L ^ 2) := by positivity
  have hcpos : (0 : ℚ) < (1 + q) ^ (2 * L ^ 2) := by
    have : (0 : ℚ) < 1 + q := by linarith
    positivity
  -- 左辺は正
  have hlhs : 0 < (1 + q) ^ (2 * L ^ 2) / 2 ^ (L ^ 2) *
      signedEvenSubgraphValue L (kwDualRational q) s := by positivity
  rcases dualityUpToSign_eval_rat L z hz4 s hq0 with h | h
  · -- `ε = 1`
    have heq : (1 + q) ^ (2 * L ^ 2) / 2 ^ (L ^ 2) *
        signedEvenSubgraphValue L (kwDualRational q) s = signedEvenSubgraphValue L q s := by
      field_simp
      linarith
    rw [heq] at hlhs ⊢
    exact (abs_of_pos hlhs).symm
  · -- `ε = −1`
    have heq : (1 + q) ^ (2 * L ^ 2) / 2 ^ (L ^ 2) *
        signedEvenSubgraphValue L (kwDualRational q) s = -signedEvenSubgraphValue L q s := by
      field_simp
      linarith
    rw [heq] at hlhs ⊢
    exact (abs_of_neg (neg_pos.mp hlhs)).symm

/-- `(1+q)^{2L²}/2^{L²} · M_L(t) = M^abs_L(q)`（正の有理数倍は最大値を保つ）。 -/
theorem dualityScaledMax_eq_absMax (data : RealClosedSubfieldData) (L : ℕ) [NeZero L]
    (z : Qbar) (hz4 : z ^ 4 = -1) {q : ℚ} (hq0 : 0 < q) (hq1 : q < 1)
    (hc : 0 < q ^ 2 + 2 * q - 1) :
    (1 + q) ^ (2 * L ^ 2) / 2 ^ (L ^ 2) * signedEvenSubgraphMax L (kwDualRational q) =
      signedEvenSubgraphAbsMax L q := by
  set k : ℚ := (1 + q) ^ (2 * L ^ 2) / 2 ^ (L ^ 2) with hk
  have hkpos : 0 < k := by
    have : (0 : ℚ) < 1 + q := by linarith
    positivity
  apply le_antisymm
  · -- 最大を与える添字 `s₀` で `k Q(t)_{s₀} = |Q(q)_{s₀}| ≤ M^abs_L(q)`
    obtain ⟨s₀, -, hs₀⟩ := Finset.exists_mem_eq_sup' spinStructure_univ_nonempty
      (signedEvenSubgraphValue L (kwDualRational q))
    rw [signedEvenSubgraphMax, hs₀, hk, dualityScaled_eq_abs data L z hz4 s₀ hq0 hq1 hc]
    exact Finset.le_sup' (fun s => |signedEvenSubgraphValue L q s|) (Finset.mem_univ s₀)
  · -- 各 `s` で `|Q(q)_s| = k Q(t)_s ≤ k M_L(t)`
    apply Finset.sup'_le
    intro s _
    rw [← dualityScaled_eq_abs data L z hz4 s hq0 hq1 hc, ← hk]
    gcongr
    exact Finset.le_sup' (signedEvenSubgraphValue L (kwDualRational q)) (Finset.mem_univ s)

/-- 具体版: `0 < q < 1`、`q² + 2q − 1 > 0` なら `¼ M^abs_L(q) ≤ Z_L(q) ≤ 2 M^abs_L(q)`。 -/
theorem highTemperaturePartitionBounds (data : RealClosedSubfieldData) {L : ℕ} [NeZero L]
    (z : Qbar) (hz4 : z ^ 4 = -1) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1)
    (hc : 0 < q ^ 2 + 2 * q - 1) :
    signedEvenSubgraphAbsMax L q / 4 ≤ partitionValue L q ∧
      partitionValue L q ≤ 2 * signedEvenSubgraphAbsMax L q := by
  -- 符号に依存しない段の下界と上界
  obtain ⟨hlow, hup⟩ := highTemperatureDualBounds (L := L) data z hz4 q hq0 hq1 hc
  -- 直前の最大値の等式
  have hmax := dualityScaledMax_eq_absMax data L z hz4 hq0 hq1 hc
  refine ⟨?_, hup⟩
  calc signedEvenSubgraphAbsMax L q / 4
      = (1 + q) ^ (2 * L ^ 2) / 2 ^ (L ^ 2 + 2) * signedEvenSubgraphMax L (kwDualRational q) := by
        rw [← hmax, pow_add]
        ring
    _ ≤ partitionValue L q := hlow

end Ising2DLambda.KacWard
