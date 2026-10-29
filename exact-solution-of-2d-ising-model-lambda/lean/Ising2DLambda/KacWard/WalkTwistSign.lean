/-
章「離散 Whitney 系: トーラス上の閉歩道の回転数」の「辺列に沿うねじれ符号の積は
巻き付き偶奇だけで決まる」（`claim_walk_twist_sign_product`）の具体版。

辺の型を正方格子トーラスの向き付き辺に固定し、実際の切断線指示子と
ねじれ符号を使う。証明は本文と同じ有限積の帰納法である。
-/
import Ising2DLambda.KacWard.TerminalMatrix
import Ising2DLambda.NecSuf.KacWard.WalkTwistSign

namespace Ising2DLambda.KacWard

private lemma negOnePow_mod_two (n : ℕ) :
    (-1 : ℤ) ^ n = (-1 : ℤ) ^ (n % 2) := by
  conv_lhs => rw [← Nat.mod_add_div n 2]
  rw [pow_add, pow_mul, neg_one_sq, one_pow, mul_one]

theorem walkTwistSign_product {L : ℕ} (s : SpinStructure)
    (walk : List (OrientedEdge L)) :
    (walk.map (twistSign s)).prod =
      (-1 : ℤ) ^ (s.1.toNat * ((walk.map horizontalSeamParity).sum % 2) +
        s.2.toNat * ((walk.map verticalSeamParity).sum % 2)) := by
  have h (walk : List (OrientedEdge L)) :
      (walk.map (twistSign s)).prod =
        (-1 : ℤ) ^ (s.1.toNat * (walk.map horizontalSeamParity).sum +
          s.2.toNat * (walk.map verticalSeamParity).sum) := by
    induction walk with
    | nil => simp
    | cons e es ih =>
        simp only [List.map_cons, List.prod_cons, List.sum_cons, twistSign]
        rw [ih, ← pow_add]
        congr 1
        simp only [Nat.mul_add]
        omega
  rw [h, negOnePow_mod_two]
  conv_rhs => rw [negOnePow_mod_two]
  congr 1
  rcases s with ⟨a, b⟩
  cases a <;> cases b <;> simp [Bool.toNat, Nat.add_mod]

theorem walkTwistSign_product_from_necSuf {L : ℕ} (a b : Bool)
    (horizontal vertical : OrientedEdge L → Bool) (walk : List (OrientedEdge L)) :
    (walk.map (Ising2DLambda.NecSuf.KacWard.twistSign a b horizontal vertical)).prod =
      Ising2DLambda.NecSuf.KacWard.boolSign
        (Bool.xor
          (a && Ising2DLambda.NecSuf.KacWard.parity horizontal walk)
          (b && Ising2DLambda.NecSuf.KacWard.parity vertical walk)) :=
  Ising2DLambda.NecSuf.KacWard.walkTwistSign_product_necSuf a b horizontal vertical walk

end Ising2DLambda.KacWard
