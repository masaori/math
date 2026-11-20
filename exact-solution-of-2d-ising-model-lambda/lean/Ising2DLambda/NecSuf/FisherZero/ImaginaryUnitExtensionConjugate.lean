/-
「虚数単位を足した体を係数とする多項式と係数の共役の積は部分体係数である」の必要十分版。

具体版の証明が使うのは次だけである。
- 係数環が可換環であること。分配法則と、`b_i ω a_{k-i}` を `b_i a_{k-i} ω` へ、
  `a_i b_{k-i}` を `b_{k-i} a_i` へ並べ替える積の交換法則を使う。逆元は使わない。
- `ω·ω = -1`。`-b_i b_{k-i} ω·ω` を `b_i b_{k-i}` へ戻す段で使う。
- 部分集合 `S` が零元を含み、和と積で閉じること（各項 `a_i a_{k-i} + b_i b_{k-i}` と有限和）。
  符号反転・差・逆元の閉性は使わない。
- 二つの多項式 `g`, `h` の係数が同じ二つの列 `a`, `b`（値は `S`）で
  `ac_i(g) = a_i + b_i ω`、`ac_i(h) = a_i - b_i ω` と書けること。

具体版はこの最後の条件を共役 `cj_ω` の well-defined 性から得る。表示の一意性・正錐・
`ω ∉ F` はその well-defined 性を通してだけ効き、積の係数の計算そのものには現れない。
-/
import Mathlib.Algebra.Polynomial.Coeff
import Mathlib.Algebra.BigOperators.NatAntidiagonal
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.FisherZero

/-- 具体版と同じ段（積の係数、表示と共役の係数の代入、分配法則と `ω·ω = -1`、有限和の分配、
積の交換法則、反対角線の成分の入れ替え、四則、項の個数についての帰納法）で示す。 -/
theorem imaginaryUnitExtension_conjugateProduct_subfieldCoefficient_necSuf
    {R : Type*} [CommRing R] (S : Set R)
    (hzero : (0 : R) ∈ S)
    (hadd : ∀ x y : R, x ∈ S → y ∈ S → x + y ∈ S)
    (hmul : ∀ x y : R, x ∈ S → y ∈ S → x * y ∈ S)
    (omega : R) (homega : omega * omega = -1)
    (a b : ℕ → R) (ha : ∀ i, a i ∈ S) (hb : ∀ i, b i ∈ S)
    (g h : Polynomial R)
    (hg : ∀ i, g.coeff i = a i + b i * omega)
    (hh : ∀ i, h.coeff i = a i - b i * omega) :
    ∀ k : ℕ, (g * h).coeff k ∈ S := by
  intro k
  have hsum : (g * h).coeff k
      = ∑ x ∈ Finset.antidiagonal k, (a x.1 * a x.2 + b x.1 * b x.2) := by
    calc (g * h).coeff k
        = ∑ x ∈ Finset.antidiagonal k, g.coeff x.1 * h.coeff x.2 := Polynomial.coeff_mul g h k
      _ = ∑ x ∈ Finset.antidiagonal k,
            (a x.1 + b x.1 * omega) * (a x.2 - b x.2 * omega) := by
          refine Finset.sum_congr rfl (fun x _ => ?_)
          rw [hg x.1, hh x.2]
      _ = ∑ x ∈ Finset.antidiagonal k,
            ((a x.1 * a x.2 + b x.1 * b x.2) + (b x.1 * a x.2 - a x.1 * b x.2) * omega) := by
          refine Finset.sum_congr rfl (fun x _ => ?_)
          linear_combination (-(b x.1 * b x.2)) * homega
      _ = ∑ x ∈ Finset.antidiagonal k, (a x.1 * a x.2 + b x.1 * b x.2)
            + (∑ x ∈ Finset.antidiagonal k, b x.1 * a x.2
                - ∑ x ∈ Finset.antidiagonal k, a x.1 * b x.2) * omega := by
          rw [Finset.sum_add_distrib, ← Finset.sum_mul, Finset.sum_sub_distrib]
      _ = ∑ x ∈ Finset.antidiagonal k, (a x.1 * a x.2 + b x.1 * b x.2)
            + (∑ x ∈ Finset.antidiagonal k, b x.1 * a x.2
                - ∑ x ∈ Finset.antidiagonal k, b x.2 * a x.1) * omega := by
          congr 3
          exact Finset.sum_congr rfl (fun x _ => mul_comm _ _)
      _ = ∑ x ∈ Finset.antidiagonal k, (a x.1 * a x.2 + b x.1 * b x.2)
            + (∑ x ∈ Finset.antidiagonal k, b x.1 * a x.2
                - ∑ x ∈ Finset.antidiagonal k, b x.1 * a x.2) * omega := by
          congr 3
          exact Finset.Nat.sum_antidiagonal_swap (f := fun y => b y.1 * a y.2)
      _ = ∑ x ∈ Finset.antidiagonal k, (a x.1 * a x.2 + b x.1 * b x.2) := by ring
  rw [hsum]
  classical
  induction (Finset.antidiagonal k) using Finset.induction_on with
  | empty => rw [Finset.sum_empty]; exact hzero
  | insert x s hx ih =>
      rw [Finset.sum_insert hx]
      exact hadd _ _ (hadd _ _ (hmul _ _ (ha x.1) (ha x.2)) (hmul _ _ (hb x.1) (hb x.2))) ih

end Ising2DLambda.NecSuf.FisherZero
