/-
主張「代数的数を成分とする行列の冪は右から掛けても得られる」（`claim_qbar_matrix_pow_succ_right`）の
必要十分版。手順は具体版と同じ（k についての帰納法。出発点で単位元の左右 2 つ、一歩で結合則）で、
仮定だけを、その証明が実際に使っているものまで削ってある。

削った結果として残った仮定は次の 5 つだけである。

  m       : M → M → M   … 2 項演算（行列の積である必要はない）
  hzero   : p 0 = e      … 冪の出発点
  hsucc   : p (k+1) = m a (p k)   … 冪の一歩（左から掛ける）
  hright  : m a e = a    … 単位元を右から掛けても変わらないこと
  hleft   : m e a = a    … 単位元を左から掛けても変わらないこと
  hassoc  : ∀ x, m a (m x a) = m (m a x) a   … 結合則。ただし**この形の三つ組についてだけ**

使っていないもの: 加法、零元、分配則、積の可換性、一般の結合則（両端が a でない三つ組）、
型 M の代数構造（半群でも環でもない勝手な型でよい）、添字の型の有限性、値が代数的数であること。
mathlib からは何も import していない（番号の型も `Nat` そのものを使う）。

住処: ここに ℝ / ℂ は現れない（型 M は任意）。
-/

universe u

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 冪が右から掛けた形にも書けること（必要十分版）。
出発点で単位元の左右 2 つ、一歩で「両端が `a` の三つ組についての結合則」だけを使う。 -/
theorem pow_succ_right_necSuf {M : Type u} (m : M → M → M) (a e : M) (p : Nat → M)
    (hzero : p 0 = e) (hsucc : ∀ k, p (k + 1) = m a (p k))
    (hright : m a e = a) (hleft : m e a = a)
    (hassoc : ∀ x, m a (m x a) = m (m a x) a) :
    ∀ k, p (k + 1) = m (p k) a := by
  intro k
  induction k with
  | zero =>
      calc p (0 + 1) = m a (p 0) := hsucc 0
        -- 出発点の第 1 段。冪の定義。
        _ = m a e := by rw [hzero]
        -- 出発点の第 2 段。冪の定義（p 0 = e）。
        _ = a := hright
        -- 出発点の第 3 段。単位元を右から掛ける。
        _ = m e a := hleft.symm
        -- 出発点の第 4 段。単位元を左から掛ける（右の等式からは出ない別の仮定である）。
        _ = m (p 0) a := by rw [hzero]
        -- 出発点の第 5 段。冪の定義へ戻す。
  | succ k ih =>
      calc p (k + 1 + 1) = m a (p (k + 1)) := hsucc (k + 1)
        -- 一歩の第 1 段。冪の定義。
        _ = m a (m (p k) a) := by rw [ih]
        -- 一歩の第 2 段。帰納法の仮定。
        _ = m (m a (p k)) a := hassoc (p k)
        -- 一歩の第 3 段。結合則（両端が a の三つ組についてだけ使う）。
        _ = m (p (k + 1)) a := by rw [hsucc k]
        -- 一歩の第 4 段。冪の定義へ戻す。

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
