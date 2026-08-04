/-
# 指標分解を 2 変数へ重ね、導来グラフのラプラシアンへ当てる — cycle 39 step 2

対応する人手証明:

* 本文ブロック `paper_def_graph_tower`（voltage グラフ・導来グラフ・voltage ラプラシアン）
* 本文ブロック `paper_prop_T`（命題 T）ほか、証明が「指標による対角化」を引く箇所

## このファイルが埋めるもの

cycle 38 step 2 は巡回群 $\mathbb{Z}/N$ の場合（ブロック巡回行列のブロック対角化）を書き、
`CharacterDecomposition.lean` の冒頭に、形式化していないものとして次の 3 つを挙げていた。

1. $\Gamma=\mathbb{Z}/N\times\mathbb{Z}/N'$（2 つの巡回群の積）の場合。本文の $\mathbb{Z}_\ell^2$ 塔はこちらである。
2. 導来グラフのラプラシアンがブロック巡回であることの当てはめ。
3. 各層のブロックが voltage ラプラシアンの $z=\zeta^{j}$ での評価値であること。

本ファイルはこの 3 つを書く。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。係数環 $R$ は整域とだけ仮定し、$1$ の原始 $N$ 乗根・$N'$ 乗根を持ち、
$N$ と $N'$ が単元であることだけを使う。本論文が当てるのは
$\mathbb{Z}[\zeta_N,\zeta_{N'}]\subset\overline{\mathbb{Q}}$ であり、これは可算である。

## 段の構成

* 2 変数（`det_blockCirculant₂`）。巡回の場合を 2 回重ねる。
  重ね方は添字の付け替えで、$V\times(\mathbb{Z}/N\times\mathbb{Z}/N')$ を
  $(V\times\mathbb{Z}/N')\times\mathbb{Z}/N$ と読み替えると、
  外側は頂点集合 $V\times\mathbb{Z}/N'$ のブロック巡回行列になり、
  その各層のブロックが今度は頂点集合 $V$ のブロック巡回行列になる。
* 導来グラフ（`derivedLaplacian_eq_blockCirculant`）。voltage グラフの導来グラフのラプラシアンが
  ブロック巡回であること。次数が層に依らないことがその内容である。
* 評価値（`hat_eq_evalChar`）。各層のブロックが、群環に値を取る voltage ラプラシアンを
  指標で送ったものに一致すること。

## 形式化しなかったもの

* **一般の有限アーベル群** $\Gamma$ は扱っていない。書いたのは巡回群 1 つと、巡回群 2 つの積までである。
  本文が要るのは後者なので当面は足りるが、一般の $\Gamma$ ではない。
* **基礎グラフを型として持っていない。** 導来グラフの側は voltage ごとの辺の本数 $a_{uv}(d)$ という
  核の形で受け取っており、それが基礎グラフの辺から定まることは書いていない。
-/
import Mathlib
import IntegrableLattice.CharacterDecomposition

namespace IntegrableLattice
namespace CharacterDecompositionTwoVariable

open Finset
open IntegrableLattice.CharacterDecomposition

variable {R : Type*} [CommRing R] [IsDomain R]

/-! ## 1. 2 つの巡回群の積へ重ねる

添字の付け替えだけで巡回の場合へ落とし、それを 2 回使う。 -/

section TwoVariable

variable {N N' : ℕ} [NeZero N] [NeZero N']
variable {V : Type*} [Fintype V] [DecidableEq V]

/-- $\Gamma=\mathbb{Z}/N\times\mathbb{Z}/N'$ の平行移動で不変な行列。
$M_{(u,\gamma),(v,\delta)}=c_{uv}(\delta-\gamma)$。 -/
def blockCirculant₂ (c : V → V → (ZMod N × ZMod N') → R) :
    Matrix (V × (ZMod N × ZMod N')) (V × (ZMod N × ZMod N')) R :=
  Matrix.of fun p q => c p.1 q.1 (q.2 - p.2)

/-- 各層のブロック
$\widehat M(j,j')_{uv}=\sum_{d,d'}c_{uv}(d,d')\,\zeta^{\,d\,j}\,\zeta'^{\,d'\,j'}$。 -/
noncomputable def hat₂ (ζ ζ' : R) (c : V → V → (ZMod N × ZMod N') → R)
    (j : ZMod N) (j' : ZMod N') : Matrix V V R :=
  Matrix.of fun u v =>
    ∑ d : ZMod N, ∑ d' : ZMod N', c u v (d, d') * ζ ^ (d.val * j.val) * ζ' ^ (d'.val * j'.val)

/-- 添字の付け替え。$V\times(\mathbb{Z}/N\times\mathbb{Z}/N')$ を
$(V\times\mathbb{Z}/N')\times\mathbb{Z}/N$ と読み替える。 -/
def regroup : (V × (ZMod N × ZMod N')) ≃ ((V × ZMod N') × ZMod N) where
  toFun p := ((p.1, p.2.2), p.2.1)
  invFun q := (q.1.1, (q.2, q.1.2))
  left_inv _ := rfl
  right_inv _ := rfl

/-- 外側の核。頂点集合を $V\times\mathbb{Z}/N'$ と見たときのブロック巡回の核である。 -/
def outerKernel (c : V → V → (ZMod N × ZMod N') → R) :
    (V × ZMod N') → (V × ZMod N') → ZMod N → R :=
  fun p q d => c p.1 q.1 (d, q.2 - p.2)

/-- 内側の核。外側を指標で送った各層が、今度は $\mathbb{Z}/N'$ のブロック巡回になる。 -/
noncomputable def innerKernel (ζ : R) (c : V → V → (ZMod N × ZMod N') → R) (j : ZMod N) :
    V → V → ZMod N' → R :=
  fun u v d' => ∑ d : ZMod N, c u v (d, d') * ζ ^ (d.val * j.val)

omit [IsDomain R] in
/-- 付け替えると、外側は頂点集合 $V\times\mathbb{Z}/N'$ のブロック巡回行列になる。 -/
theorem blockCirculant₂_eq_submatrix (c : V → V → (ZMod N × ZMod N') → R) :
    blockCirculant₂ (N := N) (N' := N') c
      = (blockCirculant (N := N) (outerKernel (N := N) (N' := N') c)).submatrix
          regroup regroup := by
  ext p q
  rfl

omit [IsDomain R] in
/-- 外側の各層のブロックは、内側の核によるブロック巡回行列である。 -/
theorem hat_outerKernel_eq_blockCirculant (ζ : R) (c : V → V → (ZMod N × ZMod N') → R)
    (j : ZMod N) :
    hat ζ (outerKernel (N := N) (N' := N') c) j
      = blockCirculant (N := N') (innerKernel (N := N) (N' := N') ζ c j) := by
  ext p q
  simp only [hat, blockCirculant, innerKernel, outerKernel, Matrix.of_apply]

omit [IsDomain R] in
/-- 内側の各層のブロックは 2 変数の $\widehat M(j,j')$ である。 -/
theorem hat_innerKernel_eq_hat₂ (ζ ζ' : R) (c : V → V → (ZMod N × ZMod N') → R)
    (j : ZMod N) (j' : ZMod N') :
    hat ζ' (innerKernel (N := N) (N' := N') ζ c j) j' = hat₂ ζ ζ' c j j' := by
  ext u v
  simp only [hat, hat₂, innerKernel, Matrix.of_apply, Finset.sum_mul]
  rw [Finset.sum_comm]

/-- **2 変数の指標分解。**
$$\det M=\prod_{j\in\mathbb{Z}/N}\ \prod_{j'\in\mathbb{Z}/N'}\det\widehat M(j,j').$$

巡回の場合（`det_blockCirculant`）を 2 回使うだけである。
本文の $\mathbb{Z}_\ell^2$ 塔が要求しているのはこの形である。 -/
theorem det_blockCirculant₂ {ζ ζ' : R} (hζ : IsPrimitiveRoot ζ N) (hζ' : IsPrimitiveRoot ζ' N')
    {cinv cinv' : R} (hcinv : cinv * (N : R) = 1) (hcinv' : cinv' * (N' : R) = 1)
    (c : V → V → (ZMod N × ZMod N') → R) :
    (blockCirculant₂ (N := N) (N' := N') c).det
      = ∏ j : ZMod N, ∏ j' : ZMod N', (hat₂ ζ ζ' c j j').det := by
  rw [blockCirculant₂_eq_submatrix, Matrix.det_submatrix_equiv_self]
  rw [det_blockCirculant (V := V × ZMod N') hζ hcinv]
  refine Finset.prod_congr rfl ?_
  intro j _
  rw [hat_outerKernel_eq_blockCirculant, det_blockCirculant (V := V) hζ' hcinv']
  refine Finset.prod_congr rfl ?_
  intro j' _
  rw [hat_innerKernel_eq_hat₂]

end TwoVariable

/-! ## 2. 導来グラフのラプラシアンはブロック巡回である

voltage グラフとは、基礎グラフの各辺に群 $\Gamma$ の元（voltage）が乗ったものである。
導来グラフは頂点集合を $V\times\Gamma$ とし、voltage $\alpha$ の辺 $u\to v$ ごとに
$(u,g)\to(v,g+\alpha)$ を張る。

ここでは辺を 1 本ずつ持たずに、**voltage ごとの本数** $a_{uv}(d)$ で持つ
（多重辺をそのまま許すのでこれで一般性を失わない）。このとき導来グラフの隣接行列は
$A_{(u,g),(v,h)}=a_{uv}(h-g)$ であり、定義そのものがブロック巡回である。
内容があるのは次数の側で、**$(u,g)$ の次数は $g$ に依らない**。
これが導来グラフのラプラシアンがブロック巡回であることの中身である。 -/

section Derived

variable {N : ℕ} [NeZero N]
variable {V : Type*} [Fintype V] [DecidableEq V]

/-- 導来グラフの頂点 $(u,g)$ の次数。voltage ごとの本数の総和で、$g$ に依らない。 -/
def voltageDegree (a : V → V → ZMod N → R) (u : V) : R :=
  ∑ v : V, ∑ d : ZMod N, a u v d

/-- 導来グラフのラプラシアンの核。対角に次数、非対角に $-a$ を置く。 -/
def derivedKernel (a : V → V → ZMod N → R) : V → V → ZMod N → R :=
  fun u v d => (if u = v ∧ d = 0 then voltageDegree a u else 0) - a u v d

/-- 導来グラフのラプラシアン $L=D-A$。 -/
def derivedLaplacian (a : V → V → ZMod N → R) :
    Matrix (V × ZMod N) (V × ZMod N) R :=
  Matrix.diagonal (fun p => voltageDegree a p.1) - blockCirculant (N := N) a

omit [IsDomain R] in
/-- **導来グラフのラプラシアンはブロック巡回である。**

次数の側が層に依らないことがその内容である（隣接行列の側は定義がすでにブロック巡回である）。
本文が「指標による対角化」を導来グラフのラプラシアンへ当てるときに要る当てはめである。 -/
theorem derivedLaplacian_eq_blockCirculant (a : V → V → ZMod N → R) :
    derivedLaplacian a = blockCirculant (N := N) (derivedKernel a) := by
  ext p q
  simp only [derivedLaplacian, Matrix.sub_apply, Matrix.diagonal_apply, blockCirculant,
    derivedKernel, Matrix.of_apply]
  congr 1
  by_cases h : p = q
  · subst h
    simp
  · have hne : ¬ (p.1 = q.1 ∧ q.2 - p.2 = 0) := by
      rintro ⟨h1, h2⟩
      exact h (Prod.ext h1 (by linear_combination (norm := abel) -h2))
    simp [h, hne]

end Derived

/-! ## 3. 各層のブロックは群環の voltage ラプラシアンを指標で送ったものである

voltage ラプラシアンを、成分が群環 $R[\mathbb{Z}/N]$ に住む $V\times V$ 行列として持つ。
本文が $L(z)$ と書いているものがこれで、$z$ の冪が群 $\mathbb{Z}/N$ の元にあたる。
指標 $\chi_j\colon d\mapsto\zeta^{\,d\,j}$ は群環から $R$ への環準同型を与え、
その像がちょうど $\widehat M(j)$ である。環準同型なので行列式とも交換し、
$\det\widehat M(j)$ は $\det L(z)$ の $z=\zeta^{j}$ での値になる。 -/

section Evaluation

variable {N : ℕ} [NeZero N]
variable {V : Type*} [Fintype V] [DecidableEq V]

/-- 指標 $\chi_j$ が定める乗法準同型 $d\mapsto(\zeta^{j})^{d}$。

準同型であることに $\zeta^{N}=1$ が要る（$\mathbb{Z}/N$ の加法は代表元の和と $N$ で割った余りなので、
$\zeta^{N}=1$ が無いと指数がずれる）。段は `pow_val_add` をそのまま使う。 -/
noncomputable def charHom {ζ : R} (hζ : ζ ^ N = 1) (j : ZMod N) :
    Multiplicative (ZMod N) →* R where
  toFun d := (ζ ^ j.val) ^ (Multiplicative.toAdd d).val
  map_one' := by simp
  map_mul' d e := by
    have hη : (ζ ^ j.val) ^ N = 1 := by
      rw [← pow_mul, mul_comm, pow_mul, hζ, one_pow]
    exact pow_val_add (ζ := ζ ^ j.val) hη _ _

/-- 指標が定める群環 $R[\mathbb{Z}/N]$ から $R$ への環準同型。本文の「$z=\zeta^{j}$ を代入する」がこれである。 -/
noncomputable def evalChar {ζ : R} (hζ : ζ ^ N = 1) (j : ZMod N) :
    AddMonoidAlgebra R (ZMod N) →+* R :=
  AddMonoidAlgebra.liftNCRingHom (RingHom.id R) (charHom hζ j) (fun _ _ => Commute.all _ _)

omit [IsDomain R] in
@[simp] theorem evalChar_single {ζ : R} (hζ : ζ ^ N = 1) (j : ZMod N) (d : ZMod N) (r : R) :
    evalChar hζ j (AddMonoidAlgebra.single d r) = r * ζ ^ (d.val * j.val) := by
  simp only [evalChar, AddMonoidAlgebra.liftNCRingHom, AddMonoidAlgebra.liftNC_single]
  simp [charHom, ← pow_mul, mul_comm]

/-- 成分が群環に住む voltage ラプラシアン。本文の $L(z)$ にあたる。 -/
noncomputable def voltageMatrix (c : V → V → ZMod N → R) :
    Matrix V V (AddMonoidAlgebra R (ZMod N)) :=
  Matrix.of fun u v => ∑ d : ZMod N, AddMonoidAlgebra.single d (c u v d)

omit [IsDomain R] in
/-- **各層のブロックは voltage ラプラシアンを指標で送ったものである。**
本文が「$\widehat L(j)$ は $L(z)$ の $z=\zeta^{j}$ での評価値である」と書いている段の中身。 -/
theorem hat_eq_evalChar {ζ : R} (hζ : ζ ^ N = 1) (c : V → V → ZMod N → R) (j : ZMod N) :
    hat ζ c j = (voltageMatrix c).map (evalChar hζ j) := by
  ext u v
  simp only [hat, voltageMatrix, Matrix.map_apply, Matrix.of_apply, map_sum, evalChar_single]

omit [IsDomain R] in
/-- 各層のブロックの行列式は、$\det L(z)$ の $z=\zeta^{j}$ での値である
（環準同型は行列式と交換する）。 -/
theorem det_hat_eq_evalChar_det {ζ : R} (hζ : ζ ^ N = 1) (c : V → V → ZMod N → R) (j : ZMod N) :
    (hat ζ c j).det = evalChar hζ j (voltageMatrix c).det := by
  rw [hat_eq_evalChar hζ c j]
  exact (RingHom.map_det (evalChar hζ j) (voltageMatrix c)).symm

end Evaluation

end CharacterDecompositionTwoVariable
end IntegrableLattice
