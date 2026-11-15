/-
「自己双対点より低温側での分配多項式の両側評価」（`claim_low_temperature_partition_bounds`）の具体版。

  人手証明                                                    このファイル・引く具体版
  四つの `Q^{a,b}_L(q)` は正（`claim_signed_even_subgraph_rational_sign`）
                                                              `signedEvenSubgraphPolynomial_rational_sign`
  `𝒮` は四元集合なので最大 `M_L(q)` はそのうち一つの値          `Finset.exists_mem_eq_sup'`
  `Z_L(q) = ½ Σ_{(a,b)∈𝒮} Q^{a,b}_L(q)`（`claim_finite_torus_polynomial` を `q` で評価）
                                                              `finiteTorusPolynomial_eval_rat`
  下界: `Z_L(q) ≥ ½ M_L(q)`（最大を与える項以外も正）           `lowTemperaturePartitionBounds` の第一成分
  上界: `Z_L(q) ≤ ½ Σ M_L(q) = 2 M_L(q)`（`|𝒮| = 4`、`def_spin_structures`）
                                                              `lowTemperaturePartitionBounds` の第二成分

`Z_L, Q^{a,b}_L ∈ ℤ[x]` の有理点 `q` での値は、係数を `ℤ ↪ ℚ` で送った多項式の `q` での値と読む。
`𝒮` の元 `(a,b)` は `SpinStructure = Bool × Bool` の元で、`Fin 2 × Fin 2` の添字へは
`spinComponentFin` の成分ごとの全単射 `spinStructureFinEquiv` で移す。
必要十分版の定理・定義は使わない。住処は Q（符号の判定だけ実閉部分体 R ⊂ Qbar を通る）。
実数体・複素数体は現れない。
-/
import Ising2DLambda.KacWard.SignedEvenSubgraphRationalSign
import Ising2DLambda.KacWard.FiniteTorusPolynomial

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Ising2DLambda.PartitionPolynomial

/-- `spinComponentFin : Bool → Fin 2` は全単射。 -/
def spinComponentFinEquiv : Bool ≃ Fin 2 where
  toFun := spinComponentFin
  invFun := fun i => decide (i = 1)
  left_inv := by intro a; cases a <;> rfl
  right_inv := by intro i; fin_cases i <;> rfl

/-- スピン構造 `(a,b) ∈ 𝒮` を `Fin 2 × Fin 2` の添字へ移す全単射。 -/
def spinStructureFinEquiv : SpinStructure ≃ Fin 2 × Fin 2 :=
  Equiv.prodCongr spinComponentFinEquiv spinComponentFinEquiv

/-- `Q^{a,b}_L(q) ∈ ℚ`。 -/
noncomputable def signedEvenSubgraphValue (L : ℕ) [NeZero L] (q : ℚ) (s : SpinStructure) : ℚ :=
  ((signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
    (Int.castRingHom ℚ)).eval q

/-- `𝒮` は空でない（`(0,0) ∈ 𝒮`）。 -/
theorem spinStructure_univ_nonempty : (Finset.univ : Finset SpinStructure).Nonempty :=
  ⟨((false, false) : Bool × Bool), Finset.mem_univ _⟩

/-- `M_L(q) := max_{(a,b)∈𝒮} Q^{a,b}_L(q) ∈ ℚ`。 -/
noncomputable def signedEvenSubgraphMax (L : ℕ) [NeZero L] (q : ℚ) : ℚ :=
  Finset.univ.sup' spinStructure_univ_nonempty (signedEvenSubgraphValue L q)

/-- `Z_L(q) ∈ ℚ`。 -/
noncomputable def partitionValue (L : ℕ) [NeZero L] (q : ℚ) : ℚ :=
  ((partitionPolynomial L).map (Int.castRingHom ℚ)).eval q

/-- `claim_finite_torus_polynomial` を `q` で評価する: `2 Z_L(q) = Σ_{(a,b)∈𝒮} Q^{a,b}_L(q)`。 -/
theorem finiteTorusPolynomial_eval_rat (L : ℕ) [NeZero L] (q : ℚ) :
    2 * partitionValue L q = ∑ s : SpinStructure, signedEvenSubgraphValue L q s := by
  have h := congrArg (fun P : Polynomial ℤ => (P.map (Int.castRingHom ℚ)).eval q)
    (finiteTorusPolynomial L)
  simp only [Polynomial.map_sum, Polynomial.eval_finsetSum, Polynomial.map_mul,
    Polynomial.eval_mul, Polynomial.map_ofNat, Polynomial.eval_ofNat] at h
  rw [partitionValue, ← h]
  exact (Fintype.sum_equiv spinStructureFinEquiv _ _ (fun s => rfl)).symm

/-- 具体版: `0 < q < 1`、`q² + 2q − 1 < 0` なら `½ M_L(q) ≤ Z_L(q) ≤ 2 M_L(q)`。 -/
theorem lowTemperaturePartitionBounds (data : RealClosedSubfieldData) {L : ℕ} [NeZero L]
    (z : Qbar) (hz4 : z ^ 4 = -1) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1)
    (hc : q ^ 2 + 2 * q - 1 < 0) :
    signedEvenSubgraphMax L q / 2 ≤ partitionValue L q ∧
      partitionValue L q ≤ 2 * signedEvenSubgraphMax L q := by
  -- 四つの `Q^{a,b}_L(q)` は正
  have hpos : ∀ s : SpinStructure, 0 < signedEvenSubgraphValue L q s := fun s =>
    (signedEvenSubgraphPolynomial_rational_sign data z hz4 s q hq0 hq1).1 hc
  -- 最大 `M_L(q)` はそのうち一つの値
  obtain ⟨s₀, -, hs₀⟩ :=
    Finset.exists_mem_eq_sup' spinStructure_univ_nonempty (signedEvenSubgraphValue L q)
  -- `Z_L(q) = ½ Σ Q^{a,b}_L(q)`
  have hZ : partitionValue L q = (1 / 2) * ∑ s : SpinStructure, signedEvenSubgraphValue L q s := by
    rw [← finiteTorusPolynomial_eval_rat L q]
    ring
  constructor
  · -- 下界
    calc signedEvenSubgraphMax L q / 2
        = (1 / 2) * signedEvenSubgraphValue L q s₀ := by
          rw [signedEvenSubgraphMax, hs₀]
          ring
      _ ≤ (1 / 2) * ∑ s : SpinStructure, signedEvenSubgraphValue L q s := by
          -- 最大を与える項以外も正
          gcongr
          exact Finset.single_le_sum (fun s _ => (hpos s).le) (Finset.mem_univ s₀)
      _ = partitionValue L q := hZ.symm
  · -- 上界
    calc partitionValue L q
        = (1 / 2) * ∑ s : SpinStructure, signedEvenSubgraphValue L q s := hZ
      _ ≤ (1 / 2) * ∑ _s : SpinStructure, signedEvenSubgraphMax L q := by
          -- `M_L(q)` は四つの値の最大
          gcongr with s
          exact Finset.le_sup' (signedEvenSubgraphValue L q) (Finset.mem_univ s)
      _ = 2 * signedEvenSubgraphMax L q := by
          -- `|𝒮| = 4`
          rw [Finset.sum_const, Finset.card_univ, spinStructures_card, nsmul_eq_mul]
          norm_num
          ring

end Ising2DLambda.KacWard
