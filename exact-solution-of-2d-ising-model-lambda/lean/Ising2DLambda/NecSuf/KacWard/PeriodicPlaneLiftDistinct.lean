/-
「非零巻き付きの頂点単純閉路の周期延長した持ち上げ点は相異なる」の必要十分版。

格子から切り離すと、必要なのは、周期方向を消す射影が一周期内の余りを区別すること、
周期方向に整数ねじれが無いこと、商と余りが元の添字を区別することだけである。
証明手順は人手証明と同じく、余り、商、元の添字の順に一致を示す。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- 基本点を整数倍の周期方向へ延長した点。 -/
def periodicLiftCore {I R G : Type*} [AddCommGroup G]
    (base : R → G) (shift : G) (quotient : I → ℤ) (remainder : I → R) (k : I) : G :=
  base (remainder k) + quotient k • shift

/-- 射影による余りの分離、周期方向の無ねじれ、商余り表示の単射性から周期延長は単射になる。 -/
theorem periodic_lift_injective_necSuf
    {I R G V : Type*} [AddCommGroup G]
    (base : R → G) (shift : G) (quotient : I → ℤ) (remainder : I → R)
    (projection : G → V)
    (hprojection : ∀ r (q : ℤ),
      projection (base r + q • shift) = projection (base r))
    (hremainder : ∀ k k',
      projection (base (remainder k)) = projection (base (remainder k')) →
        remainder k = remainder k')
    (hshift : ∀ z : ℤ, z • shift = 0 → z = 0)
    (hindex : Function.Injective (fun k => (quotient k, remainder k))) :
    Function.Injective (periodicLiftCore base shift quotient remainder) := by
  intro k k' heq
  have hprojectionEq :
      projection (base (remainder k)) = projection (base (remainder k')) := by
    rw [← hprojection (remainder k) (quotient k)]
    rw [← hprojection (remainder k') (quotient k')]
    exact congrArg projection heq
  have hrem : remainder k = remainder k' := hremainder k k' hprojectionEq
  have hsmul : (quotient k - quotient k') • shift = 0 := by
    have hquotientSmul : quotient k • shift = quotient k' • shift := by
      simpa [periodicLiftCore, hrem] using heq
    rw [sub_smul]
    exact sub_eq_zero.mpr hquotientSmul
  have hquot : quotient k = quotient k' := sub_eq_zero.mp (hshift _ hsmul)
  exact hindex (Prod.ext hquot hrem)

end Ising2DLambda.NecSuf.KacWard
