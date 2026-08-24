/-
「破れ数ゼロの項から点数乗表示の底に合同式の制約が出る」の
Lean 必要十分版で使う整数算術の骨格。

具体版から有限箱・分配多項式・有理数を落とすと、整数の等式、両端項を
表す二つの合同式、および法と共通因子の互いに素性だけが残る。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- 整数の等式と両端の合同式から、共通因子を約して底の二条件を得る。 -/
theorem base_congruences_of_integer_equation
    (P omega uN vN a b aPow bPow : ℤ)
    (heq : P * vN = uN * bPow)
    (hmodA : P ≡ omega * bPow [ZMOD a])
    (hmodB : P ≡ omega * aPow [ZMOD b])
    (hcopB : IsCoprime bPow a)
    (hcopA : IsCoprime b aPow)
    (hbDvd : b ∣ uN * bPow) :
    (omega * vN ≡ uN [ZMOD a]) ∧ b ∣ omega * vN := by
  constructor
  · have hscaled : (omega * vN) * bPow ≡ uN * bPow [ZMOD a] := by
      calc
        (omega * vN) * bPow = (omega * bPow) * vN := by ring
        _ ≡ P * vN [ZMOD a] := hmodA.symm.mul_right vN
        _ = uN * bPow := heq
    have hdvd : a ∣ (uN - omega * vN) * bPow := by
      simpa [sub_mul] using (Int.modEq_iff_dvd.mp hscaled)
    exact Int.modEq_iff_dvd.mpr (hcopB.symm.dvd_of_dvd_mul_right hdvd)
  · have hzero : P * vN ≡ 0 [ZMOD b] := by
      rw [heq]
      exact Int.modEq_zero_iff_dvd.mpr hbDvd
    have hscaled : (omega * vN) * aPow ≡ 0 [ZMOD b] := by
      calc
        (omega * vN) * aPow = (omega * aPow) * vN := by ring
        _ ≡ P * vN [ZMOD b] := hmodB.symm.mul_right vN
        _ ≡ 0 [ZMOD b] := hzero
    exact hcopA.dvd_of_dvd_mul_right (Int.modEq_zero_iff_dvd.mp hscaled)

end Ising3DCut.NecSuf
