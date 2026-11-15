import Mathlib

/-!
「四つの行列式には定数項一の多項式平方根が存在する」
（`claim_determinant_polynomial_square_root_exists`）の必要十分版。

具体版 `Ising2DLambda.KacWard.kacWardDeterminant_existsUnique_qbarPolynomialSquareRoot` と同じ手順
（定数項の式鎖 → 平方 → 存在の証人 → 一意性）を、次の仮定だけで行う。

定数項の式鎖（`sum_ite_degree_zero_eq_one_necSuf`）:
* 値の型 `K` は加法可換モノイドに `1` があればよい。乗法は使わない。
* 添字の有限集合 `s` と次数 `deg : ι → ℕ` について、`s` の中で次数零の添字が一つ `e` だけであること
  （具体版の「|A| = 0 の偶部分グラフは空集合だけ」）、`e ∈ s`（「空集合は偶部分グラフ」）、
  `w e = 1`（「空集合の符号は一」）。三つとも削れない。`e ∉ s` なら和は零になり、
  次数零の添字が二つあれば和はその重みの和になり、`w e ≠ 1` なら和は `w e` になる。

存在と一意性（`existsUnique_squareRoot_of_witness_necSuf`）:
* 多項式の型 `P` は乗法 `Mul` だけを持てばよい。定数項 `c` は `P → K` の写像でありさえすればよい。
  可換性・結合性・単位元・零因子の無さは使わない（それは一意性の仮定 `huniq` が担う）。
* `hc`・`hsq` は証人 `Q` が平方根であることそのもの、`huniq` は定数項一の平方根の一意性で、
  どれも削れない。`huniq` が無ければ、`Q` 以外の定数項一の平方根を排除できない。
-/

namespace Ising2DLambda.NecSuf.KacWard

/-- 定数項の式鎖の必要十分版: 次数零の添字が `e` 一つだけなら、次数零の項の和は `w e = 1` である。 -/
theorem sum_ite_degree_zero_eq_one_necSuf {ι K : Type*} [AddCommMonoid K] [One K]
    (s : Finset ι) (deg : ι → ℕ) (w : ι → K) (e : ι)
    (he : e ∈ s) (hdeg : ∀ i ∈ s, deg i = 0 → i = e) (he0 : deg e = 0) (hw : w e = 1) :
    (∑ i ∈ s, if deg i = 0 then w i else 0) = 1 := by
  calc (∑ i ∈ s, if deg i = 0 then w i else 0)
      = (if deg e = 0 then w e else 0) := by
        -- 次数零の添字は `e` だけ
        apply Finset.sum_eq_single e
        · intro i hi hne
          have hi0 : deg i ≠ 0 := fun h => hne (hdeg i hi h)
          simp [hi0]
        · intro hnot
          exact False.elim (hnot he)
    _ = w e := by rw [if_pos he0]
    _ = 1 := hw

/-- 存在と一意性の必要十分版: 定数項一の証人 `Q` が `D` の平方根なら、定数項一の平方根はちょうど一つある。 -/
theorem existsUnique_squareRoot_of_witness_necSuf {P K : Type*} [Mul P] [One K]
    (c : P → K) (D Q : P) (hc : c Q = 1) (hsq : Q * Q = D)
    (huniq : ∀ S T : P, c S = 1 → c T = 1 → S * S = T * T → S = T) :
    ∃! S : P, c S = 1 ∧ S * S = D :=
  ⟨Q, ⟨hc, hsq⟩, fun S hS => huniq S Q hS.1 hc (hS.2.trans hsq.symm)⟩

end Ising2DLambda.NecSuf.KacWard
