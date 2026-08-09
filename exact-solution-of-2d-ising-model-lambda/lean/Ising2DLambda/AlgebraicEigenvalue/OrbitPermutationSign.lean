/-
章「固有値の代数性」の「軌道を保つ置換の符号は軌道ごとの符号の積である」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 1 件
（`def_orbit_permutation_sign`）と主張 1 件（`claim_permutation_sign_orbit_product`）に対応する。

  人手証明                                          このファイル
  sgn_O(ψ) = (-1)^{inv_O(ψ)}                        orbitPermSign
  sgn_O は O の中の値だけで決まる                    orbitPermSign_congr
  sgn(φ) = ∏_O sgn_O(φ↾_O)                          permSign_eq_prod_orbitPermSign

`sgn_O` の引数の持ち方は前のセクションの `orbitInversionCount` に合わせる。すなわち
人手証明の `ψ : O → O` を ambient の写像として受け、`O` の外の値が結果に効かないことを
`orbitPermSign_congr` で別に示す（持ち方が値を漏らしていないことの検査）。
理由は `InversionOrbitDecomposition.lean` の冒頭に書いたものと同じである。

mathlib の `Equiv.Perm.sign` と群作用の軌道の一般論は引いていない。使ったのは
`pow_add`（人手証明の指数法則 `a^{m+n} = a^m a^n`）、`pow_mul`（同 `a^{mn} = (a^m)^n`）、
`Finset.prod_pow_eq_pow_sum`（人手証明の「有限和を指数とする冪は冪の有限積である」）だけである。

住処: 人手証明のこれらのブロックは ℤ を宣言している。
ここに ℝ / ℂ は現れない（個数は ℕ、符号は ℤ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrientedOrbitPairs

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の定義「軌道の上の全単射の符号」`sgn_O(ψ) = (-1)^{inv_O(ψ)}`。 -/
noncomputable def orbitPermSign (L : ℕ) [NeZero L] (O : Finset (RowConfig L))
    (g : RowConfig L → RowConfig L) : ℤ :=
  (-1) ^ orbitInversionCount L O g

/-- `sgn_O(ψ)` は `g` の `O` の中での値だけで決まる（ambient の写像として持ったことが
値を漏らしていないことの検査）。人手証明の `ψ : O → O` に対応する。 -/
theorem orbitPermSign_congr {O : Finset (RowConfig L)} {g g' : RowConfig L → RowConfig L}
    (h : ∀ τ ∈ O, g τ = g' τ) : orbitPermSign L O g = orbitPermSign L O g' := by
  unfold orbitPermSign
  rw [orbitInversionCount_congr h]

variable {φ : Equiv.Perm (RowConfig L)}

/-- 人手証明の主張「軌道を保つ置換の符号は、軌道ごとの符号の積である」。

人手証明の式変形の 9 段をそのまま辿る。準備で `|Inv^≠(φ)| = 2k` を取り、
`(-1)^{2k} = ((-1)^2)^k = 1^k = 1` でまたぐ項を落とす。 -/
theorem permSign_eq_prod_orbitPermSign (hφ : OrbitPreserving L φ) :
    permSign L φ
      = ∏ O ∈ (rowShiftOrbitSet L).attach,
          orbitPermSign L O.1 (orbitRestrictionAmbient hφ O.2) := by
  classical
  -- 準備: 人手証明の k（またぐ転倒対の個数の偶数性から取る）。
  set k := ∑ q ∈ orientedOrbitPairs L,
    (crossOrderedPairs L q.1 q.2 \ crossOrderedPairsImage L φ q.1 q.2).card with hkdef
  have hk : (crossOrbitInversionPairs L φ).card = 2 * k :=
    card_crossOrbitInversionPairs_eq_two_mul hφ
  -- 準備で置いた記号（人手証明の Σ_O inv_O(φ↾_O)）。
  set total := ∑ O ∈ (rowShiftOrbitSet L).attach,
    orbitInversionCount L O.1 (orbitRestrictionAmbient hφ O.2) with htotal
  calc permSign L φ
      = (-1 : ℤ) ^ inversionCount L φ := rfl
    _ = (-1 : ℤ) ^ (total + (crossOrbitInversionPairs L φ).card) := by
        rw [inversionCount_orbit_decomposition hφ, htotal]
    _ = (-1 : ℤ) ^ total * (-1 : ℤ) ^ (crossOrbitInversionPairs L φ).card := pow_add _ _ _
    _ = (-1 : ℤ) ^ total * (-1 : ℤ) ^ (2 * k) := by rw [hk]
    _ = (-1 : ℤ) ^ total * ((-1 : ℤ) ^ 2) ^ k := by rw [pow_mul]
    _ = (-1 : ℤ) ^ total * (1 : ℤ) ^ k := by norm_num
    _ = (-1 : ℤ) ^ total := by rw [one_pow, mul_one]
    _ = ∏ O ∈ (rowShiftOrbitSet L).attach,
          (-1 : ℤ) ^ orbitInversionCount L O.1 (orbitRestrictionAmbient hφ O.2) := by
        rw [htotal, Finset.prod_pow_eq_pow_sum]
    _ = ∏ O ∈ (rowShiftOrbitSet L).attach,
          orbitPermSign L O.1 (orbitRestrictionAmbient hφ O.2) := rfl

end Ising2DLambda.AlgebraicEigenvalue
