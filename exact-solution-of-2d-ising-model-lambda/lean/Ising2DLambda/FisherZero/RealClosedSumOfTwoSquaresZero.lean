/-
章「零点の詰め寄り」の「実閉部分体の二つの平方の和が零なら、両方が零である」
（`claim_real_closed_sum_of_two_squares_zero`）の具体版。人手証明と 1 対 1 に対応させる。

  人手証明                                                          このファイル
  (x + yω)(x - yω) = x*x - y*y*(ω*ω) = x*x + y*y = 0                `hfac`
  Qbar は体なので零因子が無く、どちらかの因子が零                     `mul_eq_zero`
  第 4 条件を 0 へ当てると 0 = a + bω の組は (0,0) だけ              `zero_decomposition_unique`
  第 1 の場合は組 (x,y)、第 2 の場合は組 (x,-y) へ当てる              `rcases` の二つの枝

住処: Qbar。実数体・複素数体は現れない。
-/
import Ising2DLambda.FisherZero.RealClosedSubfield

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 第 4 条件を `0` へ当てた形。`0 = a + b·ω` を満たす `R` の組は `(0,0)` だけである。 -/
theorem zero_decomposition_unique (data : RealClosedSubfieldData)
    (a b : data.carrier) (h : (0 : Qbar) = (a : Qbar) + (b : Qbar) * data.omega) :
    a = 0 ∧ b = 0 := by
  obtain ⟨ab, _, huniq⟩ := data.unique_decomposition 0
  have h1 : (a, b) = ab := huniq (a, b) h
  have h2 : ((0 : data.carrier), (0 : data.carrier)) = ab := by
    refine huniq (0, 0) ?_
    push_cast
    ring
  have : (a, b) = ((0 : data.carrier), (0 : data.carrier)) := by rw [h1, ← h2]
  exact ⟨(Prod.mk.injEq .. ▸ this).1, (Prod.mk.injEq .. ▸ this).2⟩

theorem realClosed_sq_add_sq_eq_zero (data : RealClosedSubfieldData) (x y : data.carrier)
    (h : (x : Qbar) * (x : Qbar) + (y : Qbar) * (y : Qbar) = 0) :
    x = 0 ∧ y = 0 := by
  -- 因数分解して零因子が無いことを使う。
  have hfac : ((x : Qbar) + (y : Qbar) * data.omega)
      * ((x : Qbar) - (y : Qbar) * data.omega) = 0 := by
    calc ((x : Qbar) + (y : Qbar) * data.omega) * ((x : Qbar) - (y : Qbar) * data.omega)
        = (x : Qbar) * (x : Qbar)
            - (y : Qbar) * (y : Qbar) * (data.omega * data.omega) := by ring
      _ = (x : Qbar) * (x : Qbar) - (y : Qbar) * (y : Qbar) * (-1) := by rw [data.omega_sq]
      _ = (x : Qbar) * (x : Qbar) + (y : Qbar) * (y : Qbar) := by ring
      _ = 0 := h
  rcases mul_eq_zero.mp hfac with hzero | hzero
  · -- 第 1 の場合: 組 (x, y) へ第 4 条件を当てる。
    exact zero_decomposition_unique data x y hzero.symm
  · -- 第 2 の場合: x - yω = x + (-y)ω なので組 (x, -y) へ当てる。
    have hzero' : (0 : Qbar) = (x : Qbar) + ((-y : data.carrier) : Qbar) * data.omega := by
      push_cast
      linear_combination -hzero
    obtain ⟨hx, hy⟩ := zero_decomposition_unique data x (-y) hzero'
    exact ⟨hx, by simpa using neg_eq_zero.mp hy⟩

end Ising2DLambda.FisherZero
