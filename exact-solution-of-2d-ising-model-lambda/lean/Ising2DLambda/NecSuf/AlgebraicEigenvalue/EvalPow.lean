/-
主張「成分ごとの評価は行列の冪を保つ」（`claim_qbar_matrix_eval_pow`）の必要十分版。
手順は具体版と同じ（k についての帰納法。出発点 4 段・一歩 4 段）で、仮定だけを、
その証明が実際に使っているものまで削ってある。

削った結果として残った仮定は次の 7 つだけである。

  hmul   : f (mM x y) = mN (f x) (f y)  … 写像が積を保つこと
  hpzero : p 0 = a                       … もとの側の冪の出発点（人手証明の A^1 = A）
  hpsucc : p (k+1) = mM (p k) a          … もとの側の冪の一歩（右から掛ける）
  hqzero : q 0 = e                       … 行き先の側の冪の出発点
  hqsucc : q (k+1) = mN (f a) (q k)      … 行き先の側の冪の一歩（左から掛ける）
  hright : mN (f a) e = f a              … 単位元を右から掛けても変わらないこと
  hqright: q (k+1) = mN (q k) (f a)      … 行き先の側の冪が右から掛けた形にも書けること

使っていないもの: 加法、零元、分配則、積の可換性、結合則、型 M・N の代数構造
（勝手な型でよい。半群でも環でもない）、添字の型の有限性、値が代数的数であること、
写像 f が環準同型であること（要るのは積を保つこと 1 本だけで、和も単位元も保たなくてよい）。
mathlib からは何も import していない（番号の型も `Nat` そのものを使う）。

`hqright` を仮定として置くのは、これが具体版で独立の主張
（`claim_qbar_matrix_pow_succ_right`）として先に示してあるものだからである。
2 つの冪は出発点も一歩の向きも違うので、この 1 本が無いと一歩がつながらない。

住処: ここに ℝ / ℂ は現れない（型 M・N は任意）。
-/

universe u v

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 写像が冪を保つこと（必要十分版）。もとの側の冪は `a` から始めて右から掛け、
行き先の側の冪は `e` から始めて左から掛ける。 -/
theorem eval_pow_necSuf {M : Type u} {N : Type v}
    (mM : M → M → M) (mN : N → N → N) (f : M → N)
    (a : M) (e : N) (p : Nat → M) (q : Nat → N)
    (hmul : ∀ x y, f (mM x y) = mN (f x) (f y))
    (hpzero : p 0 = a) (hpsucc : ∀ k, p (k + 1) = mM (p k) a)
    (hqzero : q 0 = e) (hqsucc : ∀ k, q (k + 1) = mN (f a) (q k))
    (hright : mN (f a) e = f a)
    (hqright : ∀ k, q (k + 1) = mN (q k) (f a)) :
    ∀ k, f (p k) = q (k + 1) := by
  intro k
  induction k with
  | zero =>
      calc f (p 0) = f a := by rw [hpzero]
        -- 出発点の第 1 段。もとの側の冪の定義（p 0 = a）。
        _ = mN (f a) e := hright.symm
        -- 出発点の第 2 段。単位元を右から掛ける。
        _ = mN (f a) (q 0) := by rw [hqzero]
        -- 出発点の第 3 段。行き先の側の冪の定義（q 0 = e）。
        _ = q (0 + 1) := (hqsucc 0).symm
        -- 出発点の第 4 段。行き先の側の冪の定義へ戻す。
  | succ k ih =>
      calc f (p (k + 1)) = f (mM (p k) a) := by rw [hpsucc k]
        -- 一歩の第 1 段。もとの側の冪の定義。
        _ = mN (f (p k)) (f a) := hmul (p k) a
        -- 一歩の第 2 段。写像が積を保つこと。
        _ = mN (q (k + 1)) (f a) := by rw [ih]
        -- 一歩の第 3 段。帰納法の仮定。
        _ = q (k + 1 + 1) := (hqright (k + 1)).symm
        -- 一歩の第 4 段。行き先の側の冪が右から掛けた形にも書けること。

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
