/-
# 命題 W\* の仮定の当てはめ（$A=R[x]/(\rho)$ が冪基底をもつこと）— cycle 37 step 1

対応する人手証明:

* 本文ブロック `paper_046_theorem_wstar_different`（命題 W\*）の第 2 段・第 3 段

## なぜこのファイルが要るのか

`EulerDualBasisCommRing.lean` は、$A$ が $1,\theta,\dots,\theta^{m}$ を基底にもつこと
（`IsPowerBasisOf`）と、$\theta^{m+1}$ が低次へ落ちること（`IsReductionOf`）を
**仮定として受け取っている**。本文が扱うのは $A=\mathbb{Z}[x]/(\rho)$ という具体的な環なので、
その具体例が仮定を満たすことを当てないと、命題 W\* の側は閉じない。
cycle 36 step 1 はこの当てはめを「残り」として挙げていた。本ファイルがそれを書く。

併せて、cycle 36 step 1 が `WStarReducibleDescent.lean` で仮定として置いた
「$\eta$ が零因子でない」ことが、**本文が現に主張している $\det G\neq0$ と同じ事柄である**ことも
繋ぐ（同値そのものは `EulerDualBasisCommRing.norm_ne_zero_iff_mem_nonZeroDivisors`）。

## 書いたこと

* $A=R[x]/(\rho)$（$\rho$ はモニック、次数 $m+1$）の冪基底が `IsPowerBasisOf` を満たすこと。
* 同じ $A$ が `IsReductionOf` を満たすこと。中身は $\rho(\theta)=0$ と
  モニック多項式の展開 `Polynomial.Monic.as_sum` だけで、体も整域も既約性も使わない。
* 上の 2 つと 段 7 を合わせた形——$\det G\neq0$ から $\eta$ が零因子でないことが出て、
  `WStarReducibleDescent` の降下の仮定がそろう。

## 形式化しなかったもの

* **$\rho$ が無平方であることから $\eta=(\chi'/h)(\theta)$ が零因子でないことを直接導く段**は
  書いていない。本ファイルが繋いだのは「$\det G\neq0$ ならば零因子でない」という向きであり、
  本文が $\det G\neq0$ を主張している以上これで足りるが、
  無平方性から $\det G\neq0$ を出す段そのものは別である（本文の判別式の段）。
-/
import Mathlib
import IntegrableLattice.EulerDualBasisCommRing
import IntegrableLattice.WStarReducibleDescent

namespace IntegrableLattice
namespace WStarPowerBasis

open Polynomial Finset Module EulerDualBasis

variable {R : Type*} [CommRing R]

/-! ## 1. $A=R[x]/(\rho)$ の冪基底 -/

section AdjoinRootBasis

variable {ρ : R[X]} {m : ℕ}

/-- $\rho$ がモニックで次数 $m+1$ のとき、$R[x]/(\rho)$ は $\theta$ の冪を基底にもつ。
`AdjoinRoot.powerBasis'` の添字を `Fin (m + 1)` へ読み替えただけである。 -/
noncomputable def adjoinRootBasis (hmonic : ρ.Monic) (hdeg : ρ.natDegree = m + 1) :
    Basis (Fin (m + 1)) R (AdjoinRoot ρ) :=
  (AdjoinRoot.powerBasis' hmonic).basis.reindex
    (finCongr (by rw [AdjoinRoot.powerBasis'_dim, hdeg]))

/-- **冪基底の仮定の当てはめ**（`IsPowerBasisOf`）。 -/
theorem isPowerBasisOf_adjoinRoot (hmonic : ρ.Monic) (hdeg : ρ.natDegree = m + 1) :
    IsPowerBasisOf (adjoinRootBasis hmonic hdeg) (AdjoinRoot.root ρ) := by
  intro j
  rw [adjoinRootBasis, Basis.reindex_apply, PowerBasis.basis_eq_pow,
    AdjoinRoot.powerBasis'_gen]
  rfl

/-- **落とす関係の仮定の当てはめ**（`IsReductionOf`）。
中身は $\rho(\theta)=0$ とモニック多項式の展開だけで、体も整域も既約性も使わない。 -/
theorem isReductionOf_adjoinRoot (hmonic : ρ.Monic) (hdeg : ρ.natDegree = m + 1) :
    IsReductionOf ρ (AdjoinRoot.root ρ) m := by
  classical
  have hroot : aeval (AdjoinRoot.root ρ) ρ = 0 := by
    rw [AdjoinRoot.aeval_eq, AdjoinRoot.mk_self]
  -- モニックなので $\rho=X^{m+1}+\sum_{k\le m}\rho_k X^k$。
  have hsum : X ^ (m + 1) + ∑ i ∈ range (m + 1), C (ρ.coeff i) * X ^ i = ρ := by
    conv_rhs => rw [hmonic.as_sum, hdeg]
  -- 展開した形へ `aeval` を当てる（$\rho$ そのものは書き換えない）。
  have h2 : aeval (AdjoinRoot.root ρ)
      (X ^ (m + 1) + ∑ i ∈ range (m + 1), C (ρ.coeff i) * X ^ i) = 0 := by
    rw [hsum]; exact hroot
  rw [map_add, map_pow, map_sum, aeval_X] at h2
  have hterm : ∀ k ∈ range (m + 1),
      aeval (AdjoinRoot.root ρ) (C (ρ.coeff k) * X ^ k)
        = algebraMap R (AdjoinRoot ρ) (ρ.coeff k) * AdjoinRoot.root ρ ^ k := by
    intro k _
    simp [aeval_C, aeval_X_pow]
  rw [Finset.sum_congr rfl hterm] at h2
  rw [IsReductionOf, eq_neg_iff_add_eq_zero]
  exact h2

end AdjoinRootBasis

/-! ## 2. $\det G\neq0$ から降下の仮定がそろう -/

section DescentHypothesis

variable {R A : Type*} [CommRing R] [IsDomain R] [CommRing A] [Algebra R A]

/-- **本文が主張している $\det G\neq0$ から、降下が要求する「$\eta$ は零因子でない」が出る。**

`WStarReducibleDescent.lean` は cycle 36 step 1 で $\eta$ が零因子でないことを仮定として置いた。
本文はそこを $\det G=\pm N(\eta)\neq0$ として主張しているので、
段 7（$\det G=\pm N(\eta)$）と合わせるとこの仮定は本文の主張から出る。**余計な仮定ではない。**
$A$ は整域でなくてよい。 -/
theorem mem_nonZeroDivisors_of_det_weightedGram_ne_zero
    {m : ℕ} {ρ : R[X]} {θ : A} (b : Basis (Fin (m + 1)) R A)
    (hb : IsPowerBasisOf b θ) (hred : IsReductionOf ρ θ m)
    (hmonic : ρ.Monic) (hdeg : ρ.natDegree = m + 1) (μ : A)
    (hG : (EulerDualBasis.weightedGram (R := R) (m := m) θ μ).det ≠ 0) :
    aeval θ (derivative ρ) * μ ∈ nonZeroDivisors A := by
  classical
  refine (EulerDualBasis.norm_ne_zero_iff_mem_nonZeroDivisors b _).mp ?_
  intro hnorm
  exact hG (by rw [EulerDualBasis.det_weightedGram b hb hred hmonic hdeg μ, hnorm, mul_zero])

end DescentHypothesis

end WStarPowerBasis
end IntegrableLattice
