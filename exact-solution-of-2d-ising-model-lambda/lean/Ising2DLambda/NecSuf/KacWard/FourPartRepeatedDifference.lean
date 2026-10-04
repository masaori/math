/-
四部分列のうち第一・第三部分を一周期ずつ延ばした循環隣接和の差。
歩の型には構造を要求しない。値は差の消去に可換加法群を使う。
反対称性・双線形性・対角零は不要で、列の正の長さは各接合の末尾を指定するために要る。
-/
import Ising2DLambda.NecSuf.KacWard.RepeatedAdjacentSum

namespace Ising2DLambda.NecSuf.KacWard

/-- claim_four_part_repeated_difference。四接合を固定し、二つの内部和の増分を足す。 -/
theorem fourPartRepeated_cyclicAdjacentSum_difference_necSuf
    {α M : Type*} [AddCommGroup M] (weight : α → α → M)
    (u v r x : ℕ → α) (m b n d c : ℕ)
    (hm : 0 < m) (hb : 0 < b) (hn : 0 < n) (hd : 0 < d) (hc : 0 < c) :
    let U := repeatDirectionSequence u m
    let R := repeatDirectionSequence r n
    let z := fun k => joinDirectionSequence
      (joinDirectionSequence (joinDirectionSequence U v (k * m)) R (k * m + b))
      x (k * m + b + k * n)
    let N := fun k => k * m + b + k * n + d
    (internalAdjacentSum weight (N (c + 1)) (z (c + 1)) +
        weight (z (c + 1) (N (c + 1) - 1)) (z (c + 1) 0)) -
      (internalAdjacentSum weight (N c) (z c) + weight (z c (N c - 1)) (z c 0)) =
      (internalAdjacentSum weight m u + weight (u (m - 1)) (u 0)) +
        (internalAdjacentSum weight n r + weight (r (n - 1)) (r 0)) := by
  dsimp only
  let U := repeatDirectionSequence u m
  let R := repeatDirectionSequence r n
  let z := fun k => joinDirectionSequence
    (joinDirectionSequence (joinDirectionSequence U v (k * m)) R (k * m + b))
    x (k * m + b + k * n)
  let N := fun k => k * m + b + k * n + d
  change (internalAdjacentSum weight (N (c + 1)) (z (c + 1)) +
      weight (z (c + 1) (N (c + 1) - 1)) (z (c + 1) 0)) -
    (internalAdjacentSum weight (N c) (z c) + weight (z c (N c - 1)) (z c 0)) = _
  -- 四部分分解を行い、反復二列の先頭・末尾を評価して四つの接合を固定する。
  have hparts (k : ℕ) (hk : 0 < k) :
      internalAdjacentSum weight (N k) (z k) + weight (z k (N k - 1)) (z k 0) =
        internalAdjacentSum weight (k * m) U + weight (u (m - 1)) (v 0) +
        internalAdjacentSum weight b v + weight (v (b - 1)) (r 0) +
        internalAdjacentSum weight (k * n) R + weight (r (n - 1)) (x 0) +
        internalAdjacentSum weight d x + weight (x (d - 1)) (u 0) := by
    have hu0 : U 0 = u 0 := by simp [U, repeatDirectionSequence]
    have hr0 : R 0 = r 0 := by simp [R, repeatDirectionSequence]
    have hulast : U (k * m - 1) = u (m - 1) :=
      repeatDirectionSequence_last u m k hm hk
    have hrlast : R (k * n - 1) = r (n - 1) :=
      repeatDirectionSequence_last r n k hn hk
    calc
      _ = internalAdjacentSum weight (k * m) U + weight (U (k * m - 1)) (v 0) +
          internalAdjacentSum weight b v + weight (v (b - 1)) (R 0) +
          internalAdjacentSum weight (k * n) R + weight (R (k * n - 1)) (x 0) +
          internalAdjacentSum weight d x + weight (x (d - 1)) (U 0) :=
        fourPart_cyclicAdjacentSum_necSuf weight U v R x (k * m) b (k * n) d
          (Nat.mul_pos hk hm) hb (Nat.mul_pos hk hn) hd
      _ = _ := by rw [hulast, hr0, hrlast, hu0]
  -- 二つの表示の共通項を消すと、反復二列の内部和の差だけが残る。
  calc
    _ = (internalAdjacentSum weight ((c + 1) * m) U -
          internalAdjacentSum weight (c * m) U) +
        (internalAdjacentSum weight ((c + 1) * n) R -
          internalAdjacentSum weight (c * n) R) := by
      rw [hparts (c + 1) (by omega), hparts c hc]
      abel
    _ = (internalAdjacentSum weight m u + weight (u (m - 1)) (u 0)) +
        (internalAdjacentSum weight ((c + 1) * n) R -
          internalAdjacentSum weight (c * n) R) := by
      rw [internalAdjacentSum_repeat_difference_necSuf weight u m c hm hc]
    _ = (internalAdjacentSum weight m u + weight (u (m - 1)) (u 0)) +
        (internalAdjacentSum weight n r + weight (r (n - 1)) (r 0)) := by
      rw [internalAdjacentSum_repeat_difference_necSuf weight r n c hn hc]

end Ising2DLambda.NecSuf.KacWard
