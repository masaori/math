/-
「定数として送る写像は冪を冪へ写す」の具体版が、必要十分版の特殊化として
得られることの導出。

具体版は必要十分版（`constant_embedding_pow_necSuf`）を次のように取ったものである。

  M := Qbar（モノイドなので冪の約束 `pow_zero`・`pow_succ` を持つ）
  N := QbarPoly（同上）
  φ := qbarConst（`Polynomial.C_1` と `Polynomial.C_mul` が単位元と積の保存）

すなわち具体版は、両側を `Qbar` と `QbarPoly` に固定した場合にほかならない。
人手証明で `Qbar` と `Qbar[t]` について書いているのは、人手証明を一般の構造へ
持ち上げないという規則によるもので、数学的に 2 つの内容があるわけではない。
この導出がそのことを示す。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarConstEmbeddingPow
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarConstEmbeddingPow

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarConstEmbeddingPow_from_necSuf (w : Qbar) (n : ℕ) :
    qbarConst (w ^ n) = qbarConst w ^ n :=
  NecSuf.AlgebraicEigenvalue.constant_embedding_pow_necSuf
    (M := Qbar) (N := QbarPoly)
    (fun a => pow_zero a) (fun a n => pow_succ a n)
    (fun b => pow_zero b) (fun b n => pow_succ b n)
    qbarConst Polynomial.C_1 (fun _ _ => Polynomial.C_mul)
    w n

end Ising2DLambda.AlgebraicEigenvalue
