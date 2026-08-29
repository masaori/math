/-
章「トーラス上の Kac--Ward 行列式」の「辺列に沿うねじれ符号の積は
巻き付き偶奇だけで決まる」（`claim_walk_twist_sign_product`）の具体版。

辺の型を正方格子トーラスの向き付き辺に固定し、本文の二つの切断線偶奇を
Bool 値写像として受け取る。証明は本文と同じ有限積の帰納法である。
-/
import Ising2DLambda.KacWard.Basic
import Ising2DLambda.NecSuf.KacWard.WalkTwistSign

namespace Ising2DLambda.KacWard

theorem walkTwistSign_product {L : ℕ} (a b : Bool)
    (horizontal vertical : OrientedEdge L → Bool) (walk : List (OrientedEdge L)) :
    (walk.map (Ising2DLambda.NecSuf.KacWard.twistSign a b horizontal vertical)).prod =
      Ising2DLambda.NecSuf.KacWard.boolSign
        (Bool.xor
          (a && Ising2DLambda.NecSuf.KacWard.parity horizontal walk)
          (b && Ising2DLambda.NecSuf.KacWard.parity vertical walk)) :=
  Ising2DLambda.NecSuf.KacWard.walkTwistSign_product_necSuf a b horizontal vertical walk

theorem walkTwistSign_product_from_necSuf {L : ℕ} (a b : Bool)
    (horizontal vertical : OrientedEdge L → Bool) (walk : List (OrientedEdge L)) :
    (walk.map (Ising2DLambda.NecSuf.KacWard.twistSign a b horizontal vertical)).prod =
      Ising2DLambda.NecSuf.KacWard.boolSign
        (Bool.xor
          (a && Ising2DLambda.NecSuf.KacWard.parity horizontal walk)
          (b && Ising2DLambda.NecSuf.KacWard.parity vertical walk)) :=
  walkTwistSign_product a b horizontal vertical walk

end Ising2DLambda.KacWard
