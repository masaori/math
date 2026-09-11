/-
# スカラー倍された因子から作る接頭積（必要十分版）

対応する人手証明のラベル: `<global_spin_flip_jordan_wigner_representation>`。

## 本文との段対応

* `q 0 = c^0 • p 0` は二つの空積の定義。
* 帰納段は、帰納法の仮定、局所関係 `paired m = c • factor m`、
  スカラー倍と積の両立、冪の再帰、`p` の一因子追加則をこの順に使う。

## 効いているもの / 効いていないもの

効いているのは、モノイド `K` のモノイド `A` への作用、作用と `A` の積を左右で
両立させる二法則、二つの接頭積の一因子追加則、および各局所因子が同じ
作用元 `c` で結ばれることだけである。
行列、複素数、クロネッカー積、Pauli 行列、因子間の可換性は使わない。
-/
import Mathlib.Algebra.Group.Action.Defs

namespace Ising2D.NecSuf

/-- 局所関係 `paired m = c • factor m` を添字順に掛けると、
`q m = c^m • p m` になる。積の因子は並べ替えない。 -/
theorem prefix_eq_pow_smul_of_local_smul
    {K A : Type*} [Monoid K] [Monoid A] [MulAction K A]
    (N : ℕ) (c : K) (p q factor paired : ℕ → A)
    (hpZero : p 0 = 1) (hqZero : q 0 = 1)
    (hpSucc : ∀ m, m < N → p (m + 1) = p m * factor m)
    (hqSucc : ∀ m, m < N → q (m + 1) = q m * paired m)
    (hpaired : ∀ m, m < N → paired m = c • factor m)
    (hsmul_mul : ∀ k : K, ∀ a b : A, (k • a) * b = k • (a * b))
    (hmul_smul : ∀ k : K, ∀ a b : A, a * (k • b) = k • (a * b)) :
    ∀ m, m ≤ N → q m = c ^ m • p m := by
  intro m hm
  induction m with
  | zero =>
      calc
        q 0 = 1 := hqZero
        _ = (1 : K) • (1 : A) := (one_smul K (1 : A)).symm
        _ = c ^ 0 • (1 : A) := by rw [pow_zero]
        _ = c ^ 0 • p 0 := by rw [hpZero]
  | succ m ih =>
      have hlt : m < N := Nat.lt_of_succ_le hm
      calc
        q (m + 1) = q m * paired m := hqSucc m hlt
        _ = (c ^ m • p m) * paired m := by
          rw [ih (Nat.le_of_lt hlt)]
        _ = (c ^ m • p m) * (c • factor m) := by
          rw [hpaired m hlt]
        _ = c ^ m • (p m * (c • factor m)) := hsmul_mul (c ^ m) (p m) (c • factor m)
        _ = c ^ m • (c • (p m * factor m)) := by
          rw [hmul_smul c (p m) (factor m)]
        _ = (c ^ m * c) • (p m * factor m) := by
          rw [mul_smul]
        _ = c ^ (m + 1) • (p m * factor m) := by
          rw [pow_succ]
        _ = c ^ (m + 1) • p (m + 1) := by
          rw [hpSucc m hlt]

end Ising2D.NecSuf
