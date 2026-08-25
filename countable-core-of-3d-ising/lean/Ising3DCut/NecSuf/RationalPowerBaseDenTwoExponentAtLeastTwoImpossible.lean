/-
「点数乗表示の底の既約分母が偶数なら分母の素数 2 の指数は 2 以上になりえない」の
Lean 必要十分版で使う算術の骨格。

具体版から有限箱、分配多項式、法 4、素因子分解、点数と辺数を落とすと、残るのは
1 より大きい自然数 `d` が補正項と総量の双方を割る一方、その総量が補正項に 1 を
足したものに等しい、という三仮定の不両立だけである。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- 1 より大きい共通因子は、差が 1 である二つの自然数をともに割れない。 -/
theorem false_of_nontrivial_common_divisor_of_one_plus
    (d correction total : ℕ) (hd : 2 ≤ d)
    (hcorrection : d ∣ correction) (htotal : d ∣ total)
    (hbalance : 1 + correction = total) : False := by
  have hone : d ∣ 1 := by
    have hsub := Nat.dvd_sub htotal hcorrection
    have hdiff : total - correction = 1 := by omega
    simpa [hdiff] using hsub
  have hdle : d ≤ 1 := Nat.le_of_dvd (by norm_num) hone
  omega

end Ising3DCut.NecSuf
