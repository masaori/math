/-
主張「零でない列ベクトルのスカラー倍が零ベクトルならば、スカラーは 0 である」
（`claim_qbar_smul_eq_zero`）の必要十分版。
手順は具体版と同じ（値の異なる点を 1 つ取り、そこで逆元を掛ける）で、
仮定だけを、その証明が実際に使っているものまで削ってある。

削った結果として残った仮定は次の 6 つだけである。

  hs     : s z v i = m z (v i)          … スカラー倍が各点の積であること
  ho     : o i = zero                   … 零ベクトルが各点で零であること
  hone   : m x one = x                  … one が積の右単位元であること
  hinv   : y ≠ zero → m y (inv y) = one … 零でない元が積についての右逆元を持つこと
  hassoc : m (m x y) w = m x (m y w)    … 積の結合則
  hzero  : m zero x = zero              … 零元との積が零元であること

使っていないもの: 加法、分配則、積の可換性、左単位元・左逆元、型 K の代数構造
（体でも環でもない勝手な型でよい）、添字の型 ι の有限性・相等の決定可能性、
値が代数的数であること（代数閉であることも各元が ℚ 上代数的であることも使わない）。
mathlib からは何も import していない。

住処: ここに ℝ / ℂ は現れない（型 ι・K は任意）。
-/

universe u v

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- スカラー倍が零ベクトルならスカラーが零であること（必要十分版）。 -/
theorem smul_eq_zero_necSuf {ι : Type u} {K : Type v}
    (m : K → K → K) (inv : K → K) (one zero : K)
    (s : K → (ι → K) → (ι → K)) (o : ι → K)
    (hs : ∀ (z : K) (v : ι → K) (i : ι), s z v i = m z (v i))
    (ho : ∀ i : ι, o i = zero)
    (hone : ∀ x : K, m x one = x)
    (hinv : ∀ y : K, y ≠ zero → m y (inv y) = one)
    (hassoc : ∀ x y w : K, m (m x y) w = m x (m y w))
    (hzero : ∀ x : K, m zero x = zero)
    (z : K) (v : ι → K)
    (h : s z v = o) (hv : v ≠ o) :
    z = zero := by
  -- 値の異なる点を 1 つ取る（写像の相等は各点の相等である）。
  -- mathlib を import していないので、二重否定の除去は `Classical.byContradiction` で書く。
  have hex : ∃ i : ι, v i ≠ o i :=
    Classical.byContradiction fun hcon =>
      hv (funext fun i => Classical.byContradiction fun hne => hcon ⟨i, hne⟩)
  cases hex with
  | intro i₀ hi₀ =>
      have hi : v i₀ ≠ zero := by
        intro hzeq
        exact hi₀ (by rw [hzeq, ho i₀])
      -- 第 1 の鎖。m z (v i₀) = s z v i₀ = o i₀ = zero。
      have hzv : m z (v i₀) = zero := by
        calc m z (v i₀) = s z v i₀ := (hs z v i₀).symm
          _ = o i₀ := by rw [h]
          _ = zero := ho i₀
      -- 第 2 の鎖。右逆元を掛けて z を取り出す。
      calc z = m z one := (hone z).symm
        _ = m z (m (v i₀) (inv (v i₀))) := by rw [hinv (v i₀) hi]
        _ = m (m z (v i₀)) (inv (v i₀)) := (hassoc z (v i₀) (inv (v i₀))).symm
        _ = m zero (inv (v i₀)) := by rw [hzv]
        _ = zero := hzero _

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
