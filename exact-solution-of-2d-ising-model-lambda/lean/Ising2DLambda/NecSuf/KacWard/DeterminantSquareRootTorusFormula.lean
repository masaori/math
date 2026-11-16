import Mathlib

/-!
「分配多項式は四つの行列式の定数項一の平方根の和の半分である」
（`claim_determinant_square_root_torus_formula`）の必要十分版。

具体版 `Ising2DLambda.KacWard.partitionPolynomial_eq_half_sum_kacWardSquareRoots` と同じ三行
（`Z = ½(2Z)` → `= ½ Σ Q` → `= ½ Σ S`）を、次の仮定だけで行う。

* 型 `P` は乗法のモノイド `Monoid P`（一行目の結合則と `1·Z = Z`）と、和を取るための
  加法可換モノイド `AddCommMonoid P` を別々に持てばよい。分配則・可換性・零因子の無さは使わない。
* `two half : P` と `hhalf : half * two = 1`。具体版の `C (1/2) · 2 = 1` で、これが無いと一行目が立たない
  （`Z = ½(2Z)` は `½·2 = 1` そのものを使う）。
* `hsum : Σ Q = two * Z`。具体版の `claim_finite_torus_polynomial` を送った等式で、二行目そのもの。
* 平方根の一意性を、定数項 `c : P → K`、平方される元 `D i`、証人 `Q i` の定数項と平方
  （`hcQ`・`hsqQ`）、平方根 `S i` の定数項と平方（`hcS`・`hsqS`）、一意性 `huniq` で受ける。
  三行目は `S i = Q i` だけを使い、それを具体版と同じく一意性から得るので、五つとも削れない。
  `huniq` を外すと `Q i` 以外の定数項一の平方根（例えば `−Q i` の定数項が一になる型）を排除できない。
-/

namespace Ising2DLambda.NecSuf.KacWard

/-- 必要十分版: `half·two = 1`、`Σ Q = two·Z`、各 `S i` が `D i` の定数項一の平方根で、
証人 `Q i` も定数項一の平方根で、定数項一の平方根が一意なら、`Z = half · Σ S`。 -/
theorem eq_half_sum_squareRoots_necSuf {ι P K : Type*} [Fintype ι] [Monoid P] [AddCommMonoid P]
    [One K] (c : P → K) (D Q S : ι → P) (Z two half : P)
    (hhalf : half * two = 1) (hsum : (∑ i, Q i) = two * Z)
    (hcQ : ∀ i, c (Q i) = 1) (hsqQ : ∀ i, Q i * Q i = D i)
    (hcS : ∀ i, c (S i) = 1) (hsqS : ∀ i, S i * S i = D i)
    (huniq : ∀ A B : P, c A = 1 → c B = 1 → A * A = B * B → A = B) :
    Z = half * ∑ i, S i := by
  calc Z = half * (two * Z) := by
        -- 一行目: `half·two = 1` と結合則
        rw [← mul_assoc, hhalf, one_mul]
    _ = half * ∑ i, Q i := by
        -- 二行目
        rw [hsum]
    _ = half * ∑ i, S i := by
        -- 三行目: 一意性から `S i = Q i`
        congr 1
        apply Finset.sum_congr rfl
        intro i _
        exact huniq (Q i) (S i) (hcQ i) (hcS i) ((hsqQ i).trans (hsqS i).symm)

end Ising2DLambda.NecSuf.KacWard
